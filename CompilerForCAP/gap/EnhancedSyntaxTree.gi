# SPDX-License-Identifier: GPL-2.0-or-later
# CompilerForCAP: Speed up computations in CAP categories
#
# Implementations
#
BindGlobal( "CAP_JIT_INTERNAL_FUNCTION_ID", 1 );
MakeReadWriteGlobal( "CAP_JIT_INTERNAL_FUNCTION_ID" );
InstallGlobalFunction( ENHANCED_SYNTAX_TREE, function ( func )
  local globalize_hvars, given_arguments, tree, orig_tree, pre_func, additional_arguments_func;
    
    globalize_hvars := ValueOption( "globalize_hvars" ) = true;
    
    if ValueOption( "given_arguments" ) = fail then
        
        given_arguments := [ ];
        
    else
        
        given_arguments := ValueOption( "given_arguments" );
        
    fi;
    
    if not IsList( given_arguments ) then
        
        Error( "the option \"given_arguments\" must be a list" );
        
    fi;
    
    tree := SYNTAX_TREE( func );
    
    if tree.variadic and Length( given_arguments ) >= tree.narg then
        
        Error( "cannot insert given arguments into variadic arguments" );
        
    fi;
    
    # some references to the original function are kept, e.g. tree.nams -> make a copy
    tree := StructuralCopy( tree );
    
    orig_tree := tree;
    
    pre_func := function ( tree, additional_arguments )
      local path, func_stack, statements, i, statement, body_if_true, body_if_false, level, pos, lvars, value, to_delete, next_statement, funccall, branch, keyvalue, operation_name;
        
        path := additional_arguments[1];
        func_stack := additional_arguments[2];
        
        if IsRecord( tree ) then
            
            Assert( 0, IsBound( tree.type ) );
            
            # replace verbose types by short types
            if StartsWith( tree.type, "STAT_SEQ_STAT" ) then
                
                tree.type := "STAT_SEQ_STAT";
            
            elif StartsWith( tree.type, "EXPR_FUNCCALL_" ) then
                
                tree.type := "EXPR_FUNCCALL";
            
            elif StartsWith( tree.type, "STAT_PROCCALL_" ) then
                
                tree.type := "STAT_PROCCALL";
            
            elif StartsWith( tree.type, "STAT_FOR" ) then
                
                tree.type := "STAT_FOR";
            
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

            # give rec key-values a type
            if tree.type = "EXPR_REC" then
                
                for keyvalue in tree.keyvalue do
                    
                    keyvalue.type := "REC_KEY_VALUE_PAIR";
                    
                od;
                
            fi;
            
            # detect EXPR_CONDITIONAL (before unifying lvar and hvar handling)
            if tree.type = "STAT_IF_ELSE" then
                
                Assert( 0, Length( tree.branches ) = 2 );
                Assert( 0, tree.branches[2].condition.type = "EXPR_TRUE" );
                
                body_if_true := tree.branches[1].body;
                body_if_false := tree.branches[2].body;
                
                if body_if_true.type = "STAT_RETURN_OBJ" and body_if_false.type = "STAT_RETURN_OBJ" then
                    
                    tree := rec(
                        type := "STAT_RETURN_OBJ",
                        obj := rec(
                            type := "EXPR_CONDITIONAL",
                            condition := tree.branches[1].condition,
                            expr_if_true := body_if_true.obj,
                            expr_if_false := body_if_false.obj,
                        ),
                    );
                    
                elif body_if_true.type = "STAT_ASS_LVAR" and body_if_false.type = "STAT_ASS_LVAR" and body_if_true.lvar = body_if_false.lvar then
                    
                    tree := rec(
                        type := "STAT_ASS_LVAR",
                        lvar := body_if_true.lvar,
                        rhs := rec(
                            type := "EXPR_CONDITIONAL",
                            condition := tree.branches[1].condition,
                            expr_if_true := body_if_true.rhs,
                            expr_if_false := body_if_false.rhs,
                        ),
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
                    
            fi;

            # unify lvar and hvar handling
            if PositionSublist( tree.type, "LVAR" ) <> fail then
                
                tree.type := ReplacedString( tree.type, "LVAR", "FVAR" );
                tree.func_id := func_stack[Length( func_stack )].id;
                tree.name := func_stack[Length( func_stack )].nams[tree.lvar];
                tree.initial_name := tree.name;
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
                        
                        Error( "tree contains hvar ref outside of stack" );
                        
                    fi;
                    
                else

                    tree.type := ReplacedString( tree.type, "HVAR", "FVAR" );
                    tree.func_id := func_stack[Length( func_stack ) - level].id;
                    tree.name := func_stack[Length( func_stack ) - level].nams[pos];
                    tree.initial_name := tree.name;
                    Unbind( tree.hvar );

                fi;
                
            fi;
            
            # try to find EXPR_REF_FVAR in given_arguments
            if tree.type = "EXPR_REF_FVAR" and tree.func_id = orig_tree.id and IsBound( given_arguments[Position( orig_tree.nams, tree.name )] ) then
                
                tree := rec(
                    type := "EXPR_REF_GVAR",
                    gvar := CapJitGetOrCreateGlobalVariable( given_arguments[Position( orig_tree.nams, tree.name )] ),
                );
                
            fi;
            
            # detect CAP_JIT_NEXT_FUNCCALL_DOES_NOT_RETURN_FAIL
            if tree.type = "STAT_SEQ_STAT" then
                
                to_delete := [ ];
                
                for i in [ 1 .. Length( tree.statements ) ] do
                    
                    if tree.statements[i].type = "STAT_PRAGMA" and tree.statements[i].value = "% CAP_JIT_NEXT_FUNCCALL_DOES_NOT_RETURN_FAIL" then
                        
                        if i = Length( tree.statements ) then
                            
                            Error( "The pragma CAP_JIT_NEXT_FUNCCALL_DOES_NOT_RETURN_FAIL must not occur as the last statement in a sequence of statements" );
                            
                        fi;
                        
                        next_statement := tree.statements[i + 1];
                        
                        if StartsWith( next_statement.type, "STAT_ASS_" ) and StartsWith( next_statement.rhs.type, "EXPR_FUNCCALL" ) then
                            
                            funccall := next_statement.rhs;
                            
                        elif next_statement.type = "STAT_RETURN_OBJ" and StartsWith( next_statement.obj.type, "EXPR_FUNCCALL" ) then
                            
                            funccall := next_statement.obj;
                            
                        else
                            
                            Error( "The line following the pragma CAP_JIT_NEXT_FUNCCALL_DOES_NOT_RETURN_FAIL must either assign a variable to the result of a function call or return the result of a function call" );
                            
                        fi;
                        
                        if funccall.funcref.type = "EXPR_REF_GVAR" then
                            
                            funccall.funcref.does_not_return_fail := true;
                            
                            Add( to_delete, i );
                            
                        else
                            
                            Error( "The pragma CAP_JIT_NEXT_FUNCCALL_DOES_NOT_RETURN_FAIL can only be used for calls to global functions or operations" );
                            
                        fi;
                        
                    fi;
                    
                od;
                
                tree.statements := tree.statements{Difference( [ 1 .. Length( tree.statements ) ], to_delete )};
                
            fi;
            
            # detect CAP_JIT_DROP_NEXT_STATEMENT
            if tree.type = "STAT_SEQ_STAT" then
                
                to_delete := [ ];
                
                for i in [ 1 .. Length( tree.statements ) ] do
                    
                    if tree.statements[i].type = "STAT_PRAGMA" and tree.statements[i].value = "% CAP_JIT_DROP_NEXT_STATEMENT" then
                        
                        if i = Length( tree.statements ) then
                            
                            Error( "The pragma CAP_JIT_DROP_NEXT_STATEMENT must not occur as the last statement in a sequence of statements" );
                            
                        fi;
                        
                        Add( to_delete, i );
                        Add( to_delete, i + 1 );
                        
                    fi;
                    
                od;
                
                tree.statements := tree.statements{Difference( [ 1 .. Length( tree.statements ) ], to_delete )};
                
            fi;
            
            # replace EXPR_ELM_MAT by call to MatElm
            if tree.type = "EXPR_ELM_MAT" then
                
                tree := rec(
                    type := "EXPR_FUNCCALL",
                    funcref := rec(
                        type := "EXPR_REF_GVAR",
                        gvar := "MatElm",
                    ),
                    args := [
                        tree.list,
                        tree.row,
                        tree.col,
                    ],
                );
                
            fi;
            
            # check if operations can be resolved
            if CapJitIsCallToGlobalFunction( tree, gvar -> HasNameFunction( ValueGlobal( gvar ) ) and NameFunction( ValueGlobal( gvar ) ) in Concatenation( RecNames( CAP_INTERNAL_METHOD_NAME_RECORD ), RecNames( CAP_JIT_INTERNAL_KNOWN_METHODS ) ) ) then
                
                operation_name := NameFunction( ValueGlobal( tree.funcref.gvar ) );
                
                if not (
                    (operation_name in RecNames( CAP_INTERNAL_METHOD_NAME_RECORD ) and Length( tree.args ) = Length( CAP_INTERNAL_METHOD_NAME_RECORD.(operation_name).filter_list ))
                    or
                    (operation_name in RecNames( CAP_JIT_INTERNAL_KNOWN_METHODS ) and ForAny( CAP_JIT_INTERNAL_KNOWN_METHODS.(operation_name), x -> Length( tree.args ) = Length( x[1] ) ))
                    ) then
                    
                    # using LocationFunc causes a segfault (https://github.com/gap-system/gap/issues/4507)
                    Print( "WARNING: operation ", tree.funcref.gvar, ", located in function at ", FilenameFunc( func ), ":", StartlineFunc( func ), " can probably not be resolved.\n" );
                    
                fi;
                
            fi;
            
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
    
    return CapJitIterateOverTree( tree, pre_func, CapJitResultFuncCombineChildren, additional_arguments_func, [ [ ], [ ] ] );
    
end );

InstallGlobalFunction( ENHANCED_SYNTAX_TREE_CODE, function ( tree )
  local stat, pre_func, additional_arguments_func, func;
    
    if not IsRecord( tree ) then
        
        Error( "the syntax tree must be a record" );
        
    fi;
    
    if tree.type <> "EXPR_FUNC" then
        
        Error( "The syntax tree is not of type EXPR_FUNC. However, if you type 'return;', it will be wrapped in a dummy function." );
        
        if StartsWith( tree.type, "EXPR" ) then
            
            stat := rec(
                type := "STAT_RETURN_OBJ",
                obj := tree,
            );
            
        else
            
            stat := tree;
            
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
                statements := [
                    stat,
                ],
            ),
        );
        
    fi;
    
    tree := StructuralCopy( tree );
    
    pre_func := function ( tree, additional_arguments )
      local path, func_stack, statements, first_six_statements, new_statements, func_pos, level;
        
        path := additional_arguments[1];
        func_stack := additional_arguments[2];
      
        if IsRecord( tree ) then
            
            Assert( 0, IsBound( tree.type ) );

            # sanity check that every function has an ID
            if tree.type = "EXPR_FUNC" then
                
                Assert( 0, IsBound( tree.id ) );
                
            fi;
            
            # assert that short types are used and replace by verbose types
            if StartsWith( tree.type, "STAT_SEQ_STAT" ) then
                
                if tree.type <> "STAT_SEQ_STAT" then
                    
                    Error( "enhanced syntax trees can only be used with short types" );
                    
                fi;

                # handled below
            
            elif StartsWith( tree.type, "EXPR_FUNCCALL" ) then
                
                if tree.type <> "EXPR_FUNCCALL" then
                    
                    Error( "enhanced syntax trees can only be used with short types" );
                    
                fi;

                if Length( tree.args ) > 6 then
                    
                    tree.type := "EXPR_FUNCCALL_XARGS";
                    
                else
                    
                    tree.type := Concatenation( "EXPR_FUNCCALL_", String( Length( tree.args ) ), "ARGS" );
                    
                fi;
            
            elif StartsWith( tree.type, "STAT_PROCCALL" ) then
                
                if tree.type <> "STAT_PROCCALL" then
                    
                    Error( "enhanced syntax trees can only be used with short types" );
                    
                fi;

                if Length( tree.args ) > 6 then
                    
                    tree.type := "STAT_PROCCALL_XARGS";
                    
                else
                    
                    tree.type := Concatenation( "STAT_PROCCALL_", String( Length( tree.args ) ), "ARGS" );
                    
                fi;
                
            elif StartsWith( tree.type, "STAT_FOR" ) then
                
                if tree.type <> "STAT_FOR" then
                    
                    Error( "enhanced syntax trees can only be used with short types" );
                    
                fi;
                
                # check if we range over a local variable
                if tree.collection.type = "EXPR_RANGE" and tree.variable.type = "EXPR_REF_FVAR" and tree.variable.func_id = Last( func_stack ).id then
                    
                    tree.type := "STAT_FOR_RANGE";
                    
                fi;
                
                if Length( tree.body ) = 2 or Length( tree.body ) = 3 then
                    
                    tree.type := Concatenation( tree.type, String( Length( tree.body ) ) );
                    
                fi;
                
            fi;
            
            # nest statements
            if tree.type = "STAT_SEQ_STAT" then
                
                statements := tree.statements;
                
                # assert that statements are flat
                Assert( 0, Length( statements ) > 0 );
                Assert( 0, ForAll( statements, s -> not StartsWith( s.type, "STAT_SEQ_STAT" ) ) );
                
                first_six_statements := fail;
                
                if Last( path ) = "stats" and Length( statements ) > 7 then
                    
                    first_six_statements := statements{[ 1 .. 6 ]};
                    statements := statements{[ 7 .. Length( statements ) ]};
                    
                fi;
                
                new_statements := rec(
                    type := "STAT_SEQ_STAT",
                    statements := statements,
                );
                    
                if first_six_statements <> fail then
                    
                    # new_statements.type will be handled by the recursion
                    return rec(
                        type := "STAT_SEQ_STAT7",
                        statements := Concatenation( first_six_statements, [ new_statements ] ),
                    );
                    
                else

                    if Length( statements ) >= 2 and Length( statements ) <= 7 then
                        
                        new_statements.type := Concatenation( "STAT_SEQ_STAT", String( Length( statements ) ) );
                        
                    fi;
                    
                    return new_statements;
                    
                fi;
                
            fi;

            # convert FVAR to LVAR and HVAR
            if PositionSublist( tree.type, "FVAR" ) <> fail then
                
                func_pos := PositionProperty( func_stack, f -> f.id = tree.func_id );
                
                if func_pos = fail then
                    
                    Error( "FVAR reference outside of function stack" );
                    
                fi;
                
                level := Length( func_stack ) - func_pos;
                
                if not tree.name in func_stack[func_pos].nams then
                    
                    Error( "FVAR name does not occur in the names of local variables of its function" );
                    
                fi;
                
                if level = 0 then
                    
                    tree.type := ReplacedString( tree.type, "FVAR", "LVAR" );
                    tree.lvar := Position( func_stack[func_pos].nams, tree.name );
                    
                else
                    
                    tree.type := ReplacedString( tree.type, "FVAR", "HVAR" );
                    tree.hvar := 2 ^ 16 * level + Position( func_stack[func_pos].nams, tree.name );
                    
                fi;
                
            fi;
            
            # remove STAT_SEQ_STAT from if branches with only a single statement
            if tree.type = "BRANCH_IF" and tree.body.type = "STAT_SEQ_STAT" and Length( tree.body.statements ) = 1 then
                
                tree.body := tree.body.statements[1];
                
            fi;
            
            # convert EXPR_CONDITIONAL back into if/else
            
            # EXPR_CONDITIONAL as obj of STAT_RETURN_OBJ
            if tree.type = "STAT_RETURN_OBJ" and tree.obj.type = "EXPR_CONDITIONAL" then
                
                tree := rec(
                    type := "STAT_IF_ELSE",
                    branches := [
                        rec(
                            type := "BRANCH_IF",
                            condition := tree.obj.condition,
                            body := rec(
                                type := "STAT_RETURN_OBJ",
                                obj := tree.obj.expr_if_true,
                            ),
                        ),
                        rec(
                            type := "BRANCH_IF",
                            condition := rec(
                                type := "EXPR_TRUE",
                            ),
                            body := rec(
                                type := "STAT_RETURN_OBJ",
                                obj := tree.obj.expr_if_false,
                            ),
                        ),
                    ],
                );
                
            fi;
            
            # EXPR_CONDITIONAL as rhs of STAT_ASS_LVAR
            if tree.type = "STAT_ASS_LVAR" and tree.rhs.type = "EXPR_CONDITIONAL" then
                
                tree := rec(
                    type := "STAT_IF_ELSE",
                    branches := [
                        rec(
                            type := "BRANCH_IF",
                            condition := tree.rhs.condition,
                            body := rec(
                                type := "STAT_ASS_LVAR",
                                lvar := tree.lvar,
                                rhs := tree.rhs.expr_if_true,
                            ),
                        ),
                        rec(
                            type := "BRANCH_IF",
                            condition := rec(
                                type := "EXPR_TRUE",
                            ),
                            body := rec(
                                type := "STAT_ASS_LVAR",
                                lvar := tree.lvar,
                                rhs := tree.rhs.expr_if_false,
                            ),
                        ),
                    ],
                );
                
            fi;
            
            # EXPR_CONDITIONAL without suitable context
            if tree.type = "EXPR_CONDITIONAL" then
                
                tree := rec(
                    type := "EXPR_FUNCCALL_0ARGS",
                    args := [ ],
                    funcref := rec(
                        type := "EXPR_FUNC",
                        id := -1, # will be ignored anyway
                        nams := [ ],
                        narg := 0,
                        nloc := 0,
                        variadic := false,
                        stats := rec(
                            type := "STAT_SEQ_STAT",
                            statements := [
                                rec(
                                    type := "STAT_IF_ELSE",
                                    branches := [
                                        rec(
                                            type := "BRANCH_IF",
                                            condition := tree.condition,
                                            body := rec(
                                                type := "STAT_RETURN_OBJ",
                                                obj := tree.expr_if_true,
                                            ),
                                        ),
                                        rec(
                                            type := "BRANCH_IF",
                                            condition := rec(
                                                type := "EXPR_TRUE",
                                            ),
                                            body := rec(
                                                type := "STAT_RETURN_OBJ",
                                                obj := tree.expr_if_false,
                                            ),
                                        ),
                                    ],
                                ),
                            ],
                        ),
                    ),
                );
                
            fi;
            
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
    
    tree := CapJitIterateOverTree( tree, pre_func, CapJitResultFuncCombineChildren, additional_arguments_func, [ [ ], [ ] ] );
    
    func := SYNTAX_TREE_CODE( tree );
    
    return func;
    
end );
