# SPDX-License-Identifier: GPL-2.0-or-later
# CompilerForCAP: Speed up and verify categorical algorithms
#
# Implementations
#
InstallGlobalFunction( CAP_JIT_INTERNAL_EXPR_CASE, function ( args... )
    
    # COVERAGE_IGNORE_NEXT_LINE
    Error( "CAP_JIT_INTERNAL_EXPR_CASE is a helper for CompilerForCAP and should never actually be called" );
    
end );

# rewrite expressions which do not return a fixed data type to corresponding operations where possible
# to allow to handle them like any other function in the type system
BindGlobal( "CAP_JIT_INTERNAL_SYNTAX_TREE_TO_OPERATION_TRANSLATIONS", rec(
    EXPR_ELM_LIST := tree -> rec( operation_name := "[]", args := [ tree.list, tree.pos ] ),
    EXPR_ELMS_LIST := tree -> rec( operation_name := "{}", args := [ tree.list, tree.poss ] ),
    EXPR_ELM_MAT := tree -> rec( operation_name := "[,]", args := [ tree.list, tree.row, tree.col ] ),
    EXPR_SUM := tree -> rec( operation_name := "+", args := [ tree.left, tree.right ] ),
    EXPR_AINV := tree -> rec( operation_name := "AdditiveInverseSameMutability", args := [ tree.op ] ),
    EXPR_DIFF := tree -> rec( operation_name := "-", args := [ tree.left, tree.right ] ),
    EXPR_PROD := tree -> rec( operation_name := "*", args := [ tree.left, tree.right ] ),
    EXPR_QUO := tree -> rec( operation_name := "/", args := [ tree.left, tree.right ] ),
    EXPR_POW := tree -> rec( operation_name := "^", args := [ tree.left, tree.right ] ),
    EXPR_MOD := tree -> rec( operation_name := "mod", args := [ tree.left, tree.right ] ),
) );

BindGlobal( "CAP_JIT_INTERNAL_OPERATION_TO_SYNTAX_TREE_TRANSLATIONS", rec(
    \[\] := tree -> rec( type := "EXPR_ELM_LIST", list := tree.args.1, pos := tree.args.2 ),
    \{\} := tree -> rec( type := "EXPR_ELMS_LIST", list := tree.args.1, poss := tree.args.2 ),
    \[\,\] := tree -> rec( type := "EXPR_ELM_MAT", list := tree.args.1, row := tree.args.2, col := tree.args.3 ),
    \+ := tree -> rec( type := "EXPR_SUM", left := tree.args.1, right := tree.args.2 ),
    AdditiveInverseSameMutability := tree -> rec( type := "EXPR_AINV", op := tree.args.1 ),
    \- := tree -> rec( type := "EXPR_DIFF", left := tree.args.1, right := tree.args.2 ),
    \* := tree -> rec( type := "EXPR_PROD", left := tree.args.1, right := tree.args.2 ),
    \/ := tree -> rec( type := "EXPR_QUO", left := tree.args.1, right := tree.args.2 ),
    \^ := tree -> rec( type := "EXPR_POW", left := tree.args.1, right := tree.args.2 ),
    \mod := tree -> rec( type := "EXPR_MOD", left := tree.args.1, right := tree.args.2 ),
) );

Assert( 0, Length( RecNames( CAP_JIT_INTERNAL_SYNTAX_TREE_TO_OPERATION_TRANSLATIONS ) ) = Length( RecNames( CAP_JIT_INTERNAL_OPERATION_TO_SYNTAX_TREE_TRANSLATIONS ) ) );

InstallGlobalFunction( ENHANCED_SYNTAX_TREE, function ( func )
  local WarnWithFuncLocation, ErrorWithFuncLocation, globalize_hvars, only_if_CAP_JIT_RESOLVE_FUNCTION, given_arguments, type_signature, remove_depth_numbering, tree, orig_tree, pre_func, result_func, additional_arguments_func;
    
    WarnWithFuncLocation := function ( args... )
        
        # using LocationFunc causes a segfault (https://github.com/gap-system/gap/issues/4507)
        # COVERAGE_IGNORE_NEXT_LINE
        CallFuncList( Print, Concatenation( [ "WARNING for function at ", TextAttr.b1, FilenameFunc( func ), ":", StartlineFunc( func ), TextAttr.reset, ":\n" ], args ) );
        
    end;
    
    ErrorWithFuncLocation := function ( args... )
        
        # using LocationFunc causes a segfault (https://github.com/gap-system/gap/issues/4507)
        # COVERAGE_IGNORE_NEXT_LINE
        CallFuncList( Error, Concatenation( [ "for function at ", TextAttr.b1, FilenameFunc( func ), ":", StartlineFunc( func ), TextAttr.reset, ":\n" ], args ) );
        
    end;
    
    globalize_hvars := ValueOption( "globalize_hvars" ) = true;
    
    only_if_CAP_JIT_RESOLVE_FUNCTION := ValueOption( "only_if_CAP_JIT_RESOLVE_FUNCTION" ) = true;
    
    given_arguments := ValueOption( "given_arguments" );
    
    if given_arguments = fail then
        
        given_arguments := [ ];
        
    fi;
    
    if not IsList( given_arguments ) then
        
        # COVERAGE_IGNORE_NEXT_LINE
        Error( "the option \"given_arguments\" must be a list" );
        
    fi;
    
    if not IsEmpty( NamesLocalVariablesFunction( func ) ) and ForAll( NamesLocalVariablesFunction( func ), name -> EndsWith( name, "_1" ) ) then
        
        # we assume that the function was created via ENHANCED_SYNTAX_TREE_CODE and thus has the function stack depth appended to all variable names
        remove_depth_numbering := true;
        
    else
        
        remove_depth_numbering := false;
        
    fi;
    
    tree := SYNTAX_TREE( func );
    
    if tree.variadic and Length( given_arguments ) >= tree.narg then
        
        # COVERAGE_IGNORE_NEXT_LINE
        ErrorWithFuncLocation( "cannot insert given arguments into variadic arguments" );
        
    fi;
    
    # some references to the original function are kept, e.g. tree.nams -> make a copy
    tree := StructuralCopy( tree );
    
    orig_tree := tree;
    
    if only_if_CAP_JIT_RESOLVE_FUNCTION then
        
        if Length( tree.stats.statements ) >= 1 and tree.stats.statements[1].type = "STAT_PRAGMA" and tree.stats.statements[1].value = "% CAP_JIT_RESOLVE_FUNCTION" then
            
            tree.stats.statements := tree.stats.statements{[ 2 .. Length( tree.stats.statements ) ]};
            
        else
            
            return fail;
            
        fi;
        
    fi;
    
    pre_func := function ( tree, additional_arguments )
      local path, func_stack, new_tree, statements, i, statement, level, pos, lvars, value, to_delete, next_statement, funccall, translation, operation_name, can_possibly_be_resolved, info, case_expression, data_type_getter, branch;
        
        path := additional_arguments[1];
        func_stack := additional_arguments[2];
        
        # convert lists to records
        if IsList( tree ) then
            
            if not IsDenseList( tree ) then
                
                # COVERAGE_IGNORE_NEXT_LINE
                ErrorWithFuncLocation( "non-dense lists are not supported by CompilerForCAP" );
                
            fi;
            
            new_tree := rec(
                type := "SYNTAX_TREE_LIST",
                length := Length( tree ),
            );
            
            for i in [ 1 .. Length( tree ) ] do
                
                new_tree.(i) := tree[i];
                
            od;
            
            tree := new_tree;
            
        elif IsRecord( tree ) then
            
            Assert( 0, IsBound( tree.type ) );
            
            # handle CapJitTypedExpression, must be done at the beginning because we return the first argument
            if StartsWith( tree.type, "EXPR_FUNCCALL_" ) and tree.funcref.type = "EXPR_REF_GVAR" and tree.funcref.gvar = "CapJitTypedExpression" then
                
                if Length( tree.args ) <> 2 then
                    
                    # COVERAGE_IGNORE_NEXT_LINE
                    ErrorWithFuncLocation( "CapJitTypedExpression must be called with exactly two arguments" );
                    
                fi;
                
                if tree.args[2].type = "EXPR_FUNC" then
                    
                    data_type_getter := SYNTAX_TREE_CODE( tree.args[2] );
                    
                elif tree.args[2].type = "EXPR_REF_GVAR" then
                    
                    data_type_getter := ValueGlobal( tree.args[2].gvar );
                    
                else
                    
                    # COVERAGE_IGNORE_NEXT_LINE
                    ErrorWithFuncLocation( "the second argument of CapJitTypedExpression must be a literal function or a reference to a global variable pointing to a function" );
                    
                fi;
                
                tree := ShallowCopy( tree.args[1] );
                
                if NumberArgumentsFunction( data_type_getter ) = 0 then
                    
                    tree.data_type := data_type_getter( );
                    
                elif NumberArgumentsFunction( data_type_getter ) = 1 then
                    
                    if Length( given_arguments ) = 0 or not IsCapCategory( given_arguments[1] ) then
                        
                        # COVERAGE_IGNORE_NEXT_LINE
                        ErrorWithFuncLocation( "the data type getter of CapJitTypedExpression needs a category but we are not inside a CAP operation or a method known to CompilerForCAP with a CAP category as first argument" );
                        
                    fi;
                    
                    tree.data_type := data_type_getter( given_arguments[1] );
                    
                else
                    
                    # COVERAGE_IGNORE_NEXT_LINE
                    ErrorWithFuncLocation( "the data type getter of CapJitTypedExpression must be a function accepting either no argument or a single argument" );
                    
                fi;
                
                if IsFilter( tree.data_type ) then
                    
                    tree.data_type := rec( filter := tree.data_type );
                    
                fi;
                
                if not IsRecord( tree.data_type ) or not IsBound( tree.data_type.filter ) then
                    
                    # COVERAGE_IGNORE_NEXT_LINE
                    ErrorWithFuncLocation( "CapJitTypedExpression has returned ", tree.data_type, " which is not a valid data type" );
                    
                fi;
                
            fi;
            
            # check for empty lists without type
            if tree.type = "EXPR_LIST" and Length( tree.list ) = 0 and not IsBound( tree.data_type ) then
                
                # COVERAGE_IGNORE_NEXT_LINE
                WarnWithFuncLocation( "Found empty list without data type. Use CapJitTypedExpression for better compilation results.\n" );
                
            fi;
            
            # check for unsupported stuff
            if tree.type = "STAT_EMPTY" then
                
                # COVERAGE_IGNORE_NEXT_LINE
                ErrorWithFuncLocation( "Found an empty statement, probably there is a superfluous semicolon in the function mentioned above.\n" );
                
            elif tree.type = "STAT_ASS_GVAR" then
                
                # COVERAGE_IGNORE_NEXT_LINE
                ErrorWithFuncLocation( "Found an assignment to the global variable `", tree.gvar, "`. Maybe this should be a local variable of the function mentioned above?\n" );
                
            elif tree.type = "EXPR_RANGE" and IsBound( tree.second ) then
                
                # COVERAGE_IGNORE_NEXT_LINE
                ErrorWithFuncLocation( "Found a range of the form `[ first, second .. last ]`. Only ranges of the form `[ first .. last ]` are supported currently.\n" );
                
            elif tree.type = "EXPR_REC" and not IsEmpty( tree.keyvalue ) then
                
                # COVERAGE_IGNORE_NEXT_LINE
                ErrorWithFuncLocation( "Non-empty records are not supported.\n" );
                
            fi;
            
            # replace verbose types by short types
            if StartsWith( tree.type, "STAT_SEQ_STAT" ) then
                
                tree.type := "STAT_SEQ_STAT";
            
            elif StartsWith( tree.type, "EXPR_FUNCCALL_" ) then
                
                tree.type := "EXPR_FUNCCALL";
            
            fi;
            
            # flatten statements
            if tree.type = "STAT_SEQ_STAT" then
                
                statements := tree.statements;
                
                i := 1;
                
                while i <= Length( statements ) do
                    
                    statement := statements[i];
                    
                    if StartsWith( statement.type, "STAT_SEQ_STAT" ) then
                        
                        statements := Concatenation( statements{[ 1 .. i - 1 ]}, statement.statements, statements{[ i + 1 .. Length( statements ) ]} );
                        
                    else
                        
                        i := i + 1;
                        
                    fi;
                    
                od;
                
                # drop final STAT_RETURN_VOID in a function (it will automatically be added again by SYNTAX_TREE_CODE)
                if Last( path ) = "stats" and Last( statements ).type = "STAT_RETURN_VOID" then
                    
                    statements := statements{[ 1 .. Length( statements ) - 1 ]};
                    
                fi;
                
                Assert( 0, Length( statements ) > 0 );
                
                tree.statements := statements;
                
            fi;
            
            # give if branches a type
            if tree.type in [ "STAT_IF", "STAT_IF_ELSE", "STAT_IF_ELIF", "STAT_IF_ELIF_ELSE" ] then
                
                for branch in tree.branches do
                    
                    branch.type := "BRANCH_IF";
                    
                od;
                
            fi;
            
            # make sure the body of an if branch is a STAT_SEQ_STAT
            if tree.type = "BRANCH_IF" then
                
                if not StartsWith( tree.body.type, "STAT_SEQ_STAT" ) then
                    
                    tree.body := rec(
                        type := "STAT_SEQ_STAT",
                        statements := [
                            tree.body,
                        ],
                    );
                    
                fi;
                
            fi;
            
            # assign IDs to functions
            if tree.type = "EXPR_FUNC" then
                
                # id might already have been set during inlining of global vars
                if not IsBound( tree.id ) then
                    
                    tree.id := CAP_JIT_INTERNAL_FUNCTION_ID;
                    
                    CAP_JIT_INTERNAL_FUNCTION_ID := CAP_JIT_INTERNAL_FUNCTION_ID + 1;
                    
                fi;
                
                if "RETURN_VALUE" in tree.nams then
                    
                    # COVERAGE_IGNORE_NEXT_LINE
                    ErrorWithFuncLocation( "Function has argument or local variable with name RETURN_VALUE. This is not supported." );
                    
                fi;
                
                if remove_depth_numbering then
                    
                    # remove position of function in stack from nams (the function is not yet on the stack at this point, so we have to add 1)
                    tree.nams := List( tree.nams, function ( name )
                      local suffix;
                        
                        suffix := Concatenation( "_", String( Length( func_stack ) + 1 ) );
                        
                        if not EndsWith( name, suffix ) then
                            
                            # COVERAGE_IGNORE_NEXT_LINE
                            ErrorWithFuncLocation( "variable name ", name, " does not have expected suffix ", suffix );
                            
                        fi;
                        
                        return name{[ 1 .. Length( name ) - Length( suffix ) ]};
                        
                    end );
                    
                fi;
                
                tree.nams := Concatenation( tree.nams, [ "RETURN_VALUE" ] );
                
            fi;
            
            # replace STAT_RETURN_OBJ
            if tree.type = "STAT_RETURN_OBJ" then
                
                tree := rec(
                    type := "STAT_ASS_FVAR",
                    func_id := Last( func_stack ).id,
                    name := "RETURN_VALUE",
                    rhs := tree.obj,
                );
                
            fi;
            
            # unify lvar and hvar handling
            if PositionSublist( tree.type, "LVAR" ) <> fail then
                
                tree.type := ReplacedString( tree.type, "LVAR", "FVAR" );
                tree.func_id := Last( func_stack ).id;
                tree.name := Last( func_stack ).nams[tree.lvar];
                Unbind( tree.lvar );
                
            fi;
            
            if PositionSublist( tree.type, "HVAR" ) <> fail then
                
                level := Int( tree.hvar / 2 ^ 16 );
                pos := tree.hvar mod 2 ^ 16;
                
                if level >= Length( func_stack ) then
                    
                    # only EPXR_REF_HVAR can be globalized
                    if globalize_hvars and tree.type = "EXPR_REF_HVAR" then
                        
                        lvars := ContentsLVars( ENVI_FUNC( func ) );
                        i := level - Length( func_stack );
                        while i > 0 do
                            
                            Assert( 0, IsBound( lvars.higher ) );
                            lvars := ContentsLVars( lvars.higher );
                            i := i - 1;
                            
                        od;

                        Assert( 0, IsBound( lvars.values[pos] ) );

                        value := lvars.values[pos];
                        
                        tree.type := "EXPR_REF_GVAR";
                        tree.gvar := CapJitGetOrCreateGlobalVariable( lvars.values[pos] );
                        Unbind( tree.hvar );
                        
                    else
                        
                        # COVERAGE_IGNORE_NEXT_LINE
                        ErrorWithFuncLocation( "tree contains hvar ref outside of stack" );
                        
                    fi;
                    
                else

                    tree.type := ReplacedString( tree.type, "HVAR", "FVAR" );
                    tree.func_id := func_stack[Length( func_stack ) - level].id;
                    tree.name := func_stack[Length( func_stack ) - level].nams[pos];
                    Unbind( tree.hvar );

                fi;
                
            fi;
            
            # try to find EXPR_REF_FVAR in given_arguments
            if tree.type = "EXPR_REF_FVAR" and tree.func_id = orig_tree.id and IsBound( given_arguments[SafeUniquePosition( orig_tree.nams, tree.name )] ) then
                
                tree := rec(
                    type := "EXPR_REF_GVAR",
                    gvar := CapJitGetOrCreateGlobalVariable( given_arguments[SafeUniquePosition( orig_tree.nams, tree.name )] ),
                );
                
            fi;
            
            # detect CAP_JIT_NEXT_FUNCCALL_DOES_NOT_RETURN_FAIL
            if tree.type = "STAT_SEQ_STAT" then
                
                to_delete := [ ];
                
                for i in [ 1 .. Length( tree.statements ) ] do
                    
                    if tree.statements[i].type = "STAT_PRAGMA" and tree.statements[i].value = "% CAP_JIT_NEXT_FUNCCALL_DOES_NOT_RETURN_FAIL" then
                        
                        if i = Length( tree.statements ) then
                            
                            # COVERAGE_IGNORE_NEXT_LINE
                            ErrorWithFuncLocation( "The pragma CAP_JIT_NEXT_FUNCCALL_DOES_NOT_RETURN_FAIL must not occur as the last statement in a sequence of statements" );
                            
                        fi;
                        
                        next_statement := tree.statements[i + 1];
                        
                        if StartsWith( next_statement.type, "STAT_ASS_" ) and StartsWith( next_statement.rhs.type, "EXPR_FUNCCALL" ) then
                            
                            funccall := next_statement.rhs;
                            
                        elif next_statement.type = "STAT_RETURN_OBJ" and StartsWith( next_statement.obj.type, "EXPR_FUNCCALL" ) then
                            
                            funccall := next_statement.obj;
                            
                        else
                            
                            # COVERAGE_IGNORE_NEXT_LINE
                            ErrorWithFuncLocation( "The line following the pragma CAP_JIT_NEXT_FUNCCALL_DOES_NOT_RETURN_FAIL must either assign a variable to the result of a function call or return the result of a function call" );
                            
                        fi;
                        
                        if funccall.funcref.type = "EXPR_REF_GVAR" then
                            
                            funccall.funcref.does_not_return_fail := true;
                            
                            Add( to_delete, i );
                            
                        else
                            
                            # COVERAGE_IGNORE_NEXT_LINE
                            ErrorWithFuncLocation( "The pragma CAP_JIT_NEXT_FUNCCALL_DOES_NOT_RETURN_FAIL can only be used for calls to global functions or operations" );
                            
                        fi;
                        
                    fi;
                    
                od;
                
                tree.statements := tree.statements{Difference( [ 1 .. Length( tree.statements ) ], to_delete )};
                
                Assert( 0, Length( tree.statements ) > 0 );
                
            fi;
            
            # detect CAP_JIT_DROP_NEXT_STATEMENT
            if tree.type = "STAT_SEQ_STAT" then
                
                to_delete := [ ];
                
                for i in [ 1 .. Length( tree.statements ) ] do
                    
                    if tree.statements[i].type = "STAT_PRAGMA" and tree.statements[i].value = "% CAP_JIT_DROP_NEXT_STATEMENT" then
                        
                        if i = Length( tree.statements ) then
                            
                            # COVERAGE_IGNORE_NEXT_LINE
                            ErrorWithFuncLocation( "The pragma CAP_JIT_DROP_NEXT_STATEMENT must not occur as the last statement in a sequence of statements" );
                            
                        fi;
                        
                        Add( to_delete, i );
                        Add( to_delete, i + 1 );
                        
                    fi;
                    
                od;
                
                tree.statements := tree.statements{Difference( [ 1 .. Length( tree.statements ) ], to_delete )};
                
                Assert( 0, Length( tree.statements ) > 0 );
                
            fi;
            
            # remove `if <condition> then Error( <message> ); fi;`
            # CAUTION: this has to be done after CAP_JIT_DROP_NEXT_STATEMENT, in case the user manually drops such a statement
            if tree.type = "STAT_SEQ_STAT" then
                
                tree.statements := Filtered( tree.statements, statement -> not (statement.type in [ "STAT_IF", "STAT_IF_ELSE", "STAT_IF_ELIF", "STAT_IF_ELIF_ELSE" ] and Length( statement.branches ) = 1 and StartsWith( statement.branches[1].body.type, "STAT_PROCCALL_" ) and statement.branches[1].body.funcref.type = "EXPR_REF_GVAR" and statement.branches[1].body.funcref.gvar = "Error") );
                
                Assert( 0, Length( tree.statements ) > 0 );
                
            fi;
            
            # move all statements after if ... then return ...; fi; into an else branch
            # CAUTION: this has to be done after CAP_JIT_DROP_NEXT_STATEMENT, in case the user manually drops the if statement
            if tree.type = "STAT_SEQ_STAT" then
                
                for i in [ 1 .. Length( tree.statements ) - 1 ] do
                    
                    statement := tree.statements[i];
                    
                    if statement.type in [ "STAT_IF", "STAT_IF_ELSE", "STAT_IF_ELIF", "STAT_IF_ELIF_ELSE" ] and ForAll( statement.branches, branch -> branch.body.type = "STAT_RETURN_OBJ" or (branch.body.type = "STAT_SEQ_STAT" and Last( branch.body.statements ).type = "STAT_RETURN_OBJ") ) then
                        
                        # add remaining statements as else-branch
                        statement.branches := Concatenation(
                            statement.branches,
                            [
                                rec(
                                    type := "IF_BRANCH",
                                    condition := rec(
                                        type := "EXPR_TRUE",
                                    ),
                                    body := rec(
                                        type := "STAT_SEQ_STAT",
                                        statements := tree.statements{[ i + 1 .. Length( tree.statements ) ]},
                                    ),
                                ),
                            ]
                        );
                        
                        tree.statements := tree.statements{[ 1 .. i ]};
                        
                        # we have added all remaining statements to the else-clause, so there is nothing to do anymore
                        break;
                        
                    fi;
                    
                od;
                
                Assert( 0, Length( tree.statements ) > 0 );
                
            fi;
            
            # replace by operation if possible
            if IsBound( CAP_JIT_INTERNAL_SYNTAX_TREE_TO_OPERATION_TRANSLATIONS.(tree.type) ) then
                
                translation := CAP_JIT_INTERNAL_SYNTAX_TREE_TO_OPERATION_TRANSLATIONS.(tree.type)( tree );
                
                tree := rec(
                    type := "EXPR_FUNCCALL",
                    funcref := rec(
                        type := "EXPR_REF_GVAR",
                        gvar := translation.operation_name,
                    ),
                    args := translation.args,
                );
                
            fi;
            
            # check if operations can be resolved
            if CapJitIsCallToGlobalFunction( tree, gvar -> HasNameFunction( ValueGlobal( gvar ) ) and NameFunction( ValueGlobal( gvar ) ) in Concatenation( RecNames( CAP_INTERNAL_METHOD_NAME_RECORD ), RecNames( CAP_JIT_INTERNAL_KNOWN_METHODS ) ) ) then
                
                operation_name := NameFunction( ValueGlobal( tree.funcref.gvar ) );
                
                can_possibly_be_resolved := false;
                
                if IsBound( CAP_INTERNAL_METHOD_NAME_RECORD.(operation_name) ) then
                    
                    info := CAP_INTERNAL_METHOD_NAME_RECORD.(operation_name);
                    
                    if Length( tree.args ) = Length( info.filter_list ) then
                        
                        can_possibly_be_resolved := true;
                        
                    # in proof assistant mode everything should be typed, so we do not necessarily need the category as first argument
                    elif CAP_JIT_PROOF_ASSISTANT_MODE_ENABLED and info.install_convenience_without_category and Length( tree.args ) = Length( info.filter_list ) - 1 then
                        
                        can_possibly_be_resolved := true;
                        
                    fi;
                    
                fi;
                
                if IsBound( CAP_JIT_INTERNAL_KNOWN_METHODS.(operation_name) ) and ForAny( CAP_JIT_INTERNAL_KNOWN_METHODS.(operation_name), x -> Length( tree.args ) = Length( x.filters ) ) then
                    
                    can_possibly_be_resolved := true;
                    
                fi;
                
                if not can_possibly_be_resolved then
                    
                    # COVERAGE_IGNORE_NEXT_LINE
                    WarnWithFuncLocation( "operation ", tree.funcref.gvar, " can probably not be resolved.\n" );
                    
                fi;
                
            fi;
            
            if CapJitIsCallToGlobalFunction( tree, "CAP_JIT_INTERNAL_EXPR_CASE" ) then
                
                Assert( 0, IsEvenInt( Length( tree.args ) ) );
                Assert( 0, not IsEmpty( tree.args ) );
                Assert( 0, tree.args[Length( tree.args ) - 1].type = "EXPR_TRUE" );
                
                case_expression := rec(
                    type := "EXPR_CASE",
                    branches := [ ],
                );
                
                for i in [ 1, 3 .. Length( tree.args ) - 1 ] do
                    
                    Add( case_expression.branches, rec(
                        type := "CASE_BRANCH",
                        condition := tree.args[i],
                        value := tree.args[i + 1],
                    ) );
                    
                od;
                
                tree := case_expression;
                
            fi;
            
        else
            
            # COVERAGE_IGNORE_NEXT_LINE
            ErrorWithFuncLocation( "this should never happen" );
            
        fi;
        
        return tree;
        
    end;
    
    result_func := function ( tree, result, keys, additional_arguments )
      local statements, bindings, add_binding, statement, name, case_expression, key, i, branch, j;
        
        tree := ShallowCopy( tree );
        
        for key in keys do
            
            tree.(key) := result.(key);
            
        od;
        
        if tree.type = "EXPR_FUNC" then
            
            statements := tree.stats.statements;
            
            bindings := rec(
                type := "FVAR_BINDING_SEQ",
                names := [ ],
            );
            
            add_binding := function ( name, value )
              local rec_name;
                
                rec_name := Concatenation( "BINDING_", name );
                
                if IsBound( bindings.(rec_name) ) then
                    
                    # COVERAGE_IGNORE_NEXT_LINE
                    ErrorWithFuncLocation( "Variable with name ", name, " is assigned more than once (not as part of a rapid reassignment). This is not supported." );
                    
                fi;
                
                if SafeUniquePosition( tree.nams, name ) <= tree.narg then
                    
                    # COVERAGE_IGNORE_NEXT_LINE
                    ErrorWithFuncLocation( "A function argument with name ", name, " is assigned. This is not supported." );
                    
                fi;
                
                CapJitAddBinding( bindings, name, value );
                
            end;
            
            for i in [ 1 .. statements.length ] do
                
                statement := statements.(i);
                
                if statement.type = "STAT_ASS_FVAR" then
                    
                    if statement.func_id <> tree.id then
                        
                        # COVERAGE_IGNORE_NEXT_LINE
                        ErrorWithFuncLocation( "A higher variable with name ", statement.name, " is assigned. This is not supported." );
                        
                    fi;
                    
                    # detect rapid reassignments
                    if i < statements.length and statements.(i + 1).type = "STAT_ASS_FVAR" and statements.(i + 1).func_id = tree.id and statements.(i + 1).name = statement.name and statement.name <> "RETURN_VALUE" then
                        
                        statements.(i + 1) := CapJitReplacedEXPR_REF_FVARByValue( statements.(i + 1), statement.func_id, statement.name, statement.rhs );
                        continue;
                        
                    fi;
                    
                    add_binding( statement.name, statement.rhs );
                    
                elif statement.type in [ "STAT_IF", "STAT_IF_ELSE", "STAT_IF_ELIF", "STAT_IF_ELIF_ELSE" ] then
                    
                    if statement.branches.1.body.statements.length = 0 then
                        
                        # COVERAGE_IGNORE_NEXT_LINE
                        ErrorWithFuncLocation( "Found empty if branch. This is not supported." );
                        
                    fi;
                    
                    if Last( statement.branches.1.body.statements ).type = "STAT_ASS_FVAR" then
                        
                        if Last( statement.branches.1.body.statements ).func_id <> tree.id then
                            
                            # COVERAGE_IGNORE_NEXT_LINE
                            ErrorWithFuncLocation( "Assignment to a non-local variable. This is not supported." );
                            
                        fi;
                        
                        if not Last( statement.branches ).condition.type = "EXPR_TRUE" then
                            
                            # COVERAGE_IGNORE_NEXT_LINE
                            ErrorWithFuncLocation( "Found if without else clause. This is not supported." );
                            
                        fi;
                        
                        name := Last( statement.branches.1.body.statements ).name;
                        
                        case_expression := rec(
                            type := "EXPR_CASE",
                            branches := [ ],
                        );
                        
                        for branch in statement.branches do
                            
                            if branch.body.statements.length = 0 then
                                
                                # COVERAGE_IGNORE_NEXT_LINE
                                ErrorWithFuncLocation( "Found empty if branch. This is not supported." );
                                
                            fi;
                            
                            for j in [ 1 .. branch.body.statements.length - 1 ] do
                                
                                if branch.body.statements.(j).type <> "STAT_ASS_FVAR" then
                                    
                                    # COVERAGE_IGNORE_NEXT_LINE
                                    ErrorWithFuncLocation( "The type ", branch.body.statements.(j).type, " is not supported at this point in the code." );
                                    
                                fi;
                                
                                add_binding( branch.body.statements.(j).name, branch.body.statements.(j).rhs );
                                
                            od;
                            
                            if Last( branch.body.statements ).type <> "STAT_ASS_FVAR" or Last( branch.body.statements ).func_id <> tree.id or Last( branch.body.statements ).name <> name then
                                
                                # COVERAGE_IGNORE_NEXT_LINE
                                ErrorWithFuncLocation( "Not all if branches end with the assignment to the same local variable. This is not supported." );
                                
                            fi;
                            
                            Add( case_expression.branches, rec(
                                type := "CASE_BRANCH",
                                condition := branch.condition,
                                value := Last( branch.body.statements ).rhs,
                            ) );
                            
                        od;
                        
                        case_expression.branches := AsSyntaxTreeList( case_expression.branches );
                        
                        add_binding( name, case_expression );
                        
                    else
                        
                        # COVERAGE_IGNORE_NEXT_LINE
                        ErrorWithFuncLocation( "statement type ", Last( statement.branches.1.body.statements ).type, " is not supported by CompilerForCAP" );
                        
                    fi;
                    
                else
                    
                    # COVERAGE_IGNORE_NEXT_LINE
                    ErrorWithFuncLocation( "statement type ", statement.type, " is not supported by CompilerForCAP" );
                    
                fi;
                
            od;
            
            # check that at least a binding for RETURN_VALUE was added
            Assert( 0, "RETURN_VALUE" in bindings.names );
            Assert( 0, IsSubset( tree.nams, bindings.names ) );
            
            tree.type := "EXPR_DECLARATIVE_FUNC";
            Unbind( tree.stats );
            Unbind( tree.nloc );
            Unbind( tree.name );
            tree.bindings := bindings;
            
        fi;
        
        # drop CAP_JIT_EXPR_CASE_WRAPPER
        # must be done after introduction of "EXPR_CASE"
        if tree.type = "EXPR_FUNCCALL" and CapJitIsCallToGlobalFunction( tree.funcref, "CAP_JIT_EXPR_CASE_WRAPPER" ) then
            
            Assert( 0, tree.args.length = 0 );
            Assert( 0, tree.funcref.args.length = 1 );
            Assert( 0, tree.funcref.args.1.type = "EXPR_DECLARATIVE_FUNC" );
            Assert( 0, tree.funcref.args.1.narg = 0 );
            Assert( 0, tree.funcref.args.1.bindings.names = [ "RETURN_VALUE" ] );
            Assert( 0, tree.funcref.args.1.bindings.BINDING_RETURN_VALUE.type = "EXPR_CASE" );
            
            tree := tree.funcref.args.1.bindings.BINDING_RETURN_VALUE;
            
        fi;
        
        return tree;
        
    end;
    
    additional_arguments_func := function ( tree, key, additional_arguments )
      local path, func_stack;
        
        path := additional_arguments[1];
        func_stack := additional_arguments[2];
        
        path := Concatenation( path, [ key ] );
        
        if IsRecord( tree ) and tree.type = "EXPR_FUNC" then
            
            Assert( 0, IsBound( tree.id ) );
            
            func_stack := Concatenation( func_stack, [ tree ] );
            
        fi;
        
        return [ path, func_stack ];
        
    end;
    
    tree := CapJitIterateOverTree( tree, pre_func, result_func, additional_arguments_func, [ [ ], [ ] ] );
    
    type_signature := ValueOption( "type_signature" );
    
    if type_signature = fail then
        
        #Error( "you must provide a type signature" );
        
    else
        
        if not IsList( type_signature ) or Length( type_signature ) <> 2 or not IsList( type_signature[1] ) or Length( type_signature[1] ) <> NumberArgumentsFunction( func ) then
            
            # COVERAGE_IGNORE_NEXT_LINE
            Error( "the option \"type_signature\" must be a pair with a list of length equal to the number of function arguments as the first entry" );
            
        fi;
        
        tree.data_type := rec( filter := IsFunction, signature := type_signature );
        
    fi;
    
    return tree;
    
end );

# Helper variable for working around https://github.com/oscar-system/GAP.jl/issues/814
CAP_JIT_INTERNAL_TREE_TO_CODE := rec( );

InstallGlobalFunction( ENHANCED_SYNTAX_TREE_CODE, function ( tree )
  local orig_tree, is_dummy_function, seen_function_ids, stat, pre_func, result_func, additional_arguments_func, func;
    
    # to simplify debugging in break loops, we keep a reference to the original input
    orig_tree := tree;
    
    if not IsRecord( tree ) then
        
        # COVERAGE_IGNORE_NEXT_LINE
        Error( "the syntax tree must be a record" );
        
    fi;
    
    if tree.type = "EXPR_DECLARATIVE_FUNC" then
        
        is_dummy_function := false;
        
    else
        
        # COVERAGE_IGNORE_BLOCK_START
        Display( "The syntax tree is not of type EXPR_FUNC. It will be wrapped in a dummy function for debugging purposes." );
        
        if StartsWith( tree.type, "EXPR_" ) then
            
            stat := rec(
                type := "STAT_RETURN_OBJ",
                obj := tree,
            );
            
        elif StartsWith( tree.type, "STAT_" ) then
            
            stat := tree;
            
        elif tree.type = "SYNTAX_TREE_LIST" then
            
            stat := rec(
                type := "STAT_RETURN_OBJ",
                obj := rec(
                    type := "EXPR_LIST",
                    list := tree,
                ),
            );
            
        else
            
            Error( "cannot wrap tree of type ", tree.type );
            
        fi;
        
        tree := rec(
            type := "EXPR_FUNC",
            narg := 0,
            nloc := 0,
            id := -1,
            nams := [ ],
            variadic := false,
            stats := rec(
                type := "STAT_SEQ_STAT",
                statements := AsSyntaxTreeList( [
                    stat,
                ] ),
            ),
        );
        
        is_dummy_function := true;
        
        # COVERAGE_IGNORE_BLOCK_END
        
    fi;
    
    tree := StructuralCopy( tree );
    
    # check if a function ID is used more than once
    seen_function_ids := [ ];
    
    pre_func := function ( tree, additional_arguments )
      local path, func_stack, func, statements, used_by_paths, pre_func, additional_arguments_func, name_of_immediate_child, binding_names, ordered_binding_names, name, value, pos_RETURN_VALUE, first_six_statements, new_statements, func_pos, level, branch;
        
        path := additional_arguments[1];
        func_stack := additional_arguments[2];
        
        Assert( 0, IsRecord( tree ) );
        Assert( 0, IsBound( tree.type ) );
        
        # check that the input is a proper tree, i.e. acyclic
        if IsBound( tree.touched ) then
            
            # COVERAGE_IGNORE_NEXT_LINE
            Error( "this subtree can be reached via at least two different paths, i.e. the input contains a cycle and thus is not a proper tree" );
            
        else
            
            tree.touched := true;
            
        fi;
        
        if tree.type = "SYNTAX_TREE_VARIABLE" then
            
            # COVERAGE_IGNORE_BLOCK_START
            Display( "WARNING: you should only codify an enhanced syntax tree with variables for debugging purposes" );
            
            tree := rec(
                type := "EXPR_REF_GVAR",
                gvar := Concatenation( "CAP_JIT_INTERNAL_TEMPLATE_VAR_", String( tree.id ) ),
            );
            # COVERAGE_IGNORE_BLOCK_END
            
        fi;
        
        if tree.type = "SYNTAX_TREE_LIST" then
            
            tree := List( [ 1 .. tree.length ], i -> tree.(i) );
            
        else
            
            # replace by native syntax if possible
            # do not do this for "[,]" because of a difference between GAP 4.12 and GAP 4.13 regarding the indentation (https://github.com/gap-system/gap/pull/5167)
            if CapJitIsCallToGlobalFunction( tree, gvar -> IsBound( CAP_JIT_INTERNAL_OPERATION_TO_SYNTAX_TREE_TRANSLATIONS.(gvar) ) and gvar <> "[,]" ) then
                
                tree := CAP_JIT_INTERNAL_OPERATION_TO_SYNTAX_TREE_TRANSLATIONS.(tree.funcref.gvar)( tree );
                
            fi;
            
            # check that function IDs are unique (except dummy ID -1)
            if tree.type = "EXPR_DECLARATIVE_FUNC" and tree.id <> -1 then
                
                if tree.id in seen_function_ids then
                    
                    # COVERAGE_IGNORE_NEXT_LINE
                    Error( "tree contains multiple functions with the same ID" );
                    
                else
                    
                    Add( seen_function_ids, tree.id );
                    
                fi;
                
                func := tree;
                
                Assert( 0, "RETURN_VALUE" in func.nams );
                
                Assert( 0, IsSubset( func.nams, func.bindings.names ) );
                
                if not IsEmpty( Intersection( func.nams{[ 1 .. func.narg ]}, func.bindings.names ) ) then
                    
                    # COVERAGE_IGNORE_NEXT_LINE
                    Error( "bindings to function parameters are not supported" );
                    
                fi;
                
                statements := [ ];
                
                # Order bindings by the relation "is used by" and store the result in <ordered_binding_names>.
                # <name_of_immediate_child> chooses a name in <children> which is only used by the bindings with names in <parents>, i.e. an "immediate" child of <parents>
                # and is applied iteratively to the already ordered bindings and the not yet ordered bindings.
                # We always have a starting point because "RETURN_VALUE" must not be used explicitly.
                
                used_by_paths := rec( );
                
                for name in func.nams do
                    
                    used_by_paths.(name) := [ ];
                    
                od;
                
                pre_func := function ( tree, path )
                    
                    if tree.type = "EXPR_REF_FVAR" and tree.func_id = func.id then
                        
                        if SafeUniquePosition( func.nams, tree.name ) > func.narg then
                            
                            Assert( 0, tree.name in func.bindings.names );
                            
                        fi;
                        
                        Add( used_by_paths.(tree.name), path );
                        
                    fi;
                    
                    return tree;
                    
                end;
                
                additional_arguments_func := function ( tree, key, path )
                    
                    return Concatenation( path, [ key ] );
                    
                end;
                
                CapJitIterateOverTree( func.bindings, pre_func, ReturnTrue, additional_arguments_func, [ ] );
                
                Assert( 0, IsEmpty( used_by_paths.RETURN_VALUE ) );
                
                name_of_immediate_child := function ( parents, children )
                    
                    # Usually, we would take the last child because that would more faithfully reflect the original input.
                    # However, in the context of deduplication and hosting, the names at the end of the list are dependencies
                    # of the names at the front of the list, so the first name is already an immediate child. Taking this child
                    # gives a much nicer output, because the variable names are simply counting down.
                    # the sublist removes "BINDING_" from path[1]
                    return First( children, child -> ForAll( used_by_paths.(child), path -> path[1]{[ 9 .. Length( path[1] ) ]} in parents ) );
                    
                end;
                
                # is modified below
                binding_names := ShallowCopy( func.bindings.names );
                
                ordered_binding_names := [ ];
                
                while Length( binding_names ) > 0 do
                    
                    name := name_of_immediate_child( ordered_binding_names, binding_names );
                    
                    if name = fail then
                        
                        # COVERAGE_IGNORE_NEXT_LINE
                        Error( "The relation \"is used by\" between bindings does not give rise to a partial order, i.e. a DAG. This is not supported." );
                        
                    fi;
                    
                    Remove( binding_names, SafeUniquePosition( binding_names, name ) );
                    
                    Add( ordered_binding_names, name );
                    
                od;
                
                # for each binding A not of type EXPR_CASE which is used in a binding B of EXPR_CASE:
                # check if A is used solely in a single branch of B
                # if yes: add A as a subbinding of this branch of B, i.e. the STAT_ASS_FVAR corresponding to A should be placed inside the branch
                # and remove it from <ordered_binding_names> because it will be handled separately
                ordered_binding_names := Filtered( ordered_binding_names, function ( name )
                  local value, paths, path1, used_by_name, used_by_value, branch_number, key, i;
                    
                    value := CapJitValueOfBinding( func.bindings, name );
                    
                    if value.type <> "EXPR_CASE" and not IsEmpty( used_by_paths.(name) ) then
                        
                        paths := used_by_paths.(name);
                        path1 := paths[1];
                        
                        Assert( 0, StartsWith( path1[1], "BINDING_" ) );
                        
                        # remove "BINDING_" from the start
                        used_by_name := path1[1]{[ 9 .. Length( path1[1] ) ]};
                        used_by_value := CapJitValueOfBinding( func.bindings, used_by_name );
                        
                        # if used_by_value.type = "EXPR_CASE", then each path is of the form [ BINDING_<binding_name>, "branches", <branch_number>, "condition"/"value" ]
                        # check if binding names and branch numbers coincide for all paths, and if the variable is only used in the value
                        if used_by_value.type = "EXPR_CASE" and ForAll( paths, path -> path[1] = path1[1] and path[3] = path1[3] and path[4] = "value" ) then
                            
                            branch_number := path1[3];
                            
                            if not IsBound( used_by_value.branches.(branch_number).subbinding_names ) then
                                
                                used_by_value.branches.(branch_number).subbinding_names := [ ];
                                
                            fi;
                            
                            # prepend name because we work from the back to the front
                            Add( used_by_value.branches.(branch_number).subbinding_names, name, 1 );
                            
                            # for A and B as above: replace path to A by path to B
                            for key in func.nams do
                                
                                for i in [ 1 .. Length( used_by_paths.(key) ) ] do
                                    
                                    if used_by_paths.(key)[i][1] = Concatenation( "BINDING_", name ) then
                                        
                                        # we are only interested in the first 4 keys anyway, see above
                                        used_by_paths.(key)[i] := path1{[ 1 .. 4 ]};
                                        
                                    fi;
                                    
                                od;
                                
                            od;
                            
                            return false;
                            
                        fi;
                        
                    fi;
                    
                    return true;
                    
                end );
                
                for name in ordered_binding_names do
                    
                    # turning "RETURN_VALUE := ...;" into "return ...;" will be done below
                    
                    value := CapJitValueOfBinding( tree.bindings, name );
                    
                    if value.type = "EXPR_CASE" then
                        
                        for branch in value.branches do
                            
                            if not IsBound( branch.subbinding_names ) then
                                
                                branch.subbinding_names := [ ];
                                
                            fi;
                            
                        od;
                        
                        # prepend new statement
                        Add( statements, rec(
                            type := "STAT_IF_ELIF",
                            branches := List( value.branches, branch -> rec(
                                type := "BRANCH_IF",
                                condition := branch.condition,
                                body := rec(
                                    type := "STAT_SEQ_STAT",
                                    statements := AsSyntaxTreeList(
                                        Concatenation(
                                            List( branch.subbinding_names, subbinding_name ->
                                                rec(
                                                    type := "STAT_ASS_FVAR",
                                                    func_id := func.id,
                                                    name := subbinding_name,
                                                    rhs := CapJitValueOfBinding( func.bindings, subbinding_name ),
                                                )
                                            ),
                                            [ rec(
                                                type := "STAT_ASS_FVAR",
                                                func_id := func.id,
                                                name := name,
                                                rhs := branch.value,
                                            ) ]
                                        )
                                    ),
                                ),
                            ) ),
                        ), 1 );
                        
                    else
                        
                        # prepend new statement
                        Add( statements, rec(
                            type := "STAT_ASS_FVAR",
                            func_id := func.id,
                            name := name,
                            rhs := value,
                        ), 1 );
                        
                    fi;
                    
                od;
                
                # Recall: tree = func
                tree.type := "EXPR_FUNC";
                Unbind( tree.bindings );
                tree.stats := rec(
                    type := "STAT_SEQ_STAT",
                    statements := AsSyntaxTreeList( statements ),
                );
                
                pos_RETURN_VALUE := SafeUniquePosition( tree.nams, "RETURN_VALUE" );
                
                Assert( 0, pos_RETURN_VALUE <> fail );
                
                Remove( tree.nams, pos_RETURN_VALUE );
                
                # append position of function in stack to nams for unique names (the function is not yet on the stack at this point, so we have to add 1)
                tree.nams := List( tree.nams, name -> Concatenation( name, "_", String( Length( func_stack ) + 1 ) ) );
                
                tree.nloc := Length( tree.nams ) - tree.narg;
                
            fi;
            
            if tree.type = "STAT_ASS_FVAR" and tree.name = "RETURN_VALUE" then
                
                tree.type := "STAT_RETURN_OBJ";
                tree.obj := tree.rhs;
                Unbind( tree.func_id );
                Unbind( tree.name );
                Unbind( tree.rhs );
                
            fi;
            
            # assert that short types are used and replace by verbose types
            if StartsWith( tree.type, "STAT_SEQ_STAT" ) then
                
                if tree.type <> "STAT_SEQ_STAT" then
                    
                    # COVERAGE_IGNORE_NEXT_LINE
                    Error( "enhanced syntax trees can only be used with short types" );
                    
                fi;

                # handled below
            
            elif StartsWith( tree.type, "EXPR_FUNCCALL" ) then
                
                if tree.type <> "EXPR_FUNCCALL" then
                    
                    # COVERAGE_IGNORE_NEXT_LINE
                    Error( "enhanced syntax trees can only be used with short types" );
                    
                fi;
                
                if tree.args.length > 6 then
                    
                    tree.type := "EXPR_FUNCCALL_XARGS";
                    
                else
                    
                    tree.type := Concatenation( "EXPR_FUNCCALL_", String( tree.args.length ), "ARGS" );
                    
                fi;
            
            fi;
            
            # nest statements
            if tree.type = "STAT_SEQ_STAT" then
                
                statements := tree.statements;
                
                # assert that statements are flat
                Assert( 0, statements.length > 0 );
                Assert( 0, ForAll( statements, s -> not StartsWith( s.type, "STAT_SEQ_STAT" ) ) );
                
                first_six_statements := fail;
                
                if Last( path ) = "stats" and statements.length > 7 then
                    
                    first_six_statements := Sublist( statements, [ 1 .. 6 ] );
                    statements := Sublist( statements, [ 7 .. statements.length ] );
                    
                fi;
                
                new_statements := rec(
                    type := "STAT_SEQ_STAT",
                    statements := statements,
                );
                
                if first_six_statements <> fail then
                    
                    # new_statements.type will be handled by the recursion
                    return rec(
                        type := "STAT_SEQ_STAT7",
                        statements := ConcatenationForSyntaxTreeLists( first_six_statements, AsSyntaxTreeList( [ new_statements ] ) ),
                    );
                    
                else
                    
                    if statements.length >= 2 and statements.length <= 7 then
                        
                        new_statements.type := Concatenation( "STAT_SEQ_STAT", String( statements.length ) );
                        
                    fi;
                    
                    return new_statements;
                    
                fi;
                
            fi;

            # convert FVAR to LVAR and HVAR
            if PositionSublist( tree.type, "FVAR" ) <> fail then
                
                func_pos := PositionProperty( func_stack, f -> f.id = tree.func_id );
                
                if func_pos = fail then
                    
                    # COVERAGE_IGNORE_BLOCK_START
                    
                    # for dummy functions this case is expected
                    if not is_dummy_function then
                        
                        Error( "An FVAR references a variable outside of the function stack. However, if you type 'return;', it will be replaced by a dummy variable." );
                        
                    fi;
                    
                    tree.type := ReplacedString( tree.type, "FVAR", "GVAR" );
                    tree.gvar := Concatenation( "FVAR_outside_of_function_stack_", tree.name );
                    
                    return tree;
                    # COVERAGE_IGNORE_BLOCK_END
                    
                fi;
                
                level := Length( func_stack ) - func_pos;
                
                # append position of function in stack for unique names
                tree.name := Concatenation( tree.name, "_", String( func_pos ) );
                
                if not tree.name in func_stack[func_pos].nams then
                    
                    # COVERAGE_IGNORE_BLOCK_START
                    Error( "The FVAR name ", tree.name, " does not occur in the names of local variables of its function. ",
                        "However, if you type 'return;', the name will be added for debugging purposes (this might lead to unexpected results for variadic functions)." );
                    
                    Add( func_stack[func_pos].nams, tree.name );
                    # COVERAGE_IGNORE_BLOCK_END
                    
                fi;
                
                if level = 0 then
                    
                    tree.type := ReplacedString( tree.type, "FVAR", "LVAR" );
                    tree.lvar := SafeUniquePosition( func_stack[func_pos].nams, tree.name );
                    
                else
                    
                    tree.type := ReplacedString( tree.type, "FVAR", "HVAR" );
                    tree.hvar := 2 ^ 16 * level + SafeUniquePosition( func_stack[func_pos].nams, tree.name );
                    
                fi;
                
            fi;
            
            # remove STAT_SEQ_STAT from if branches with only a single statement
            if tree.type = "BRANCH_IF" and tree.body.type = "STAT_SEQ_STAT" and tree.body.statements.length = 1 then
                
                tree.body := tree.body.statements.1;
                
            fi;
            
            if tree.type = "EXPR_CASE" then
                
                # code as CAP_JIT_EXPR_CASE_WRAPPER( function( ) if ... then return ...; else return ...; fi; end )()
                # the wrapper is necessary because the GAP syntax `function() return ...; end()` is not valid in Julia
                tree := rec(
                    type := "EXPR_FUNCCALL_0ARGS",
                    args := AsSyntaxTreeList( [ ] ),
                    funcref := rec(
                        type := "EXPR_FUNCCALL",
                        funcref := rec(
                            type := "EXPR_REF_GVAR",
                            gvar := "CAP_JIT_EXPR_CASE_WRAPPER",
                        ),
                        args := AsSyntaxTreeList( [ rec(
                            type := "EXPR_FUNC",
                            id := -1, # will be ignored anyway
                            nams := [ ],
                            narg := 0,
                            nloc := 0,
                            variadic := false,
                            stats := rec(
                                type := "STAT_SEQ_STAT",
                                statements := AsSyntaxTreeList( [
                                    rec(
                                        type := "STAT_IF_ELIF",
                                        branches := List( tree.branches, branch -> rec(
                                            type := "BRANCH_IF",
                                            condition := branch.condition,
                                            body := rec(
                                                type := "STAT_RETURN_OBJ",
                                                obj := branch.value,
                                            ),
                                        ) ),
                                    ),
                                ] ),
                            ),
                        ) ] ),
                    ),
                );
                
            fi;
            
        fi;
        
        return tree;
        
    end;
    
    result_func := function ( tree, result, keys, additional_arguments )
      local key;
        
        if IsList( result ) then
            
            return result;
            
        elif IsRecord( result ) then
            
            tree := ShallowCopy( tree );
            
            for key in keys do
                
                tree.(key) := result.(key);
                
            od;
            
            return tree;
            
        else
            
            # COVERAGE_IGNORE_NEXT_LINE
            Error( "this should never happen" );
            
        fi;
        
    end;
    
    additional_arguments_func := function ( tree, key, additional_arguments )
      local path, func_stack;
        
        path := additional_arguments[1];
        func_stack := additional_arguments[2];
        
        path := Concatenation( path, [ key ] );
        
        if IsRecord( tree ) and tree.type in [ "EXPR_FUNC", "EXPR_DECLARATIVE_FUNC" ] then
            
            Assert( 0, IsBound( tree.id ) );
            
            func_stack := Concatenation( func_stack, [ tree ] );
            
        fi;
        
        return [ path, func_stack ];
        
    end;
    
    tree := CapJitIterateOverTree( tree, pre_func, result_func, additional_arguments_func, [ [ ], [ ] ] );
    
    # We work around https://github.com/oscar-system/GAP.jl/issues/814 by calling SYNTAX_TREE_CODE inside an `EvalString`
    CAP_JIT_INTERNAL_TREE_TO_CODE := tree;
    func := EvalString( "SYNTAX_TREE_CODE( CAP_JIT_INTERNAL_TREE_TO_CODE )" );
    
    return func;
    
end );
