#
# CompilerForCAP: Speed up computations in CAP categories
#
# Implementations
#
BindGlobal( "CAP_JIT_INTERNAL_FUNCTION_ID", 1 );
MakeReadWriteGlobal( "CAP_JIT_INTERNAL_FUNCTION_ID" );
InstallGlobalFunction( ENHANCED_SYNTAX_TREE, function( func, args... )
  local globalize_hvars, tree, pre_func, additional_arguments_func;
    
    Assert( 0, Length( args ) = 0 or Length( args ) = 1 );
    
    if Length( args ) = 1 then
        
        Assert( 0, IsBool( args[1] ) );
        
        globalize_hvars := args[1];
        
    else
        
        globalize_hvars := false;
        
    fi;
  
    tree := SYNTAX_TREE( func );
    
    # some references to the original function are kept, e.g. tree.nams -> make a copy
    tree := StructuralCopy( tree );

    pre_func := function( tree, additional_arguments )
      local path, func_stack, statements, i, statement, level, pos, lvars, value, branch, keyvalue;
        
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
                        
                        statements := Concatenation( statements{[ 1 .. i-1 ]}, statement.statements, statements{[ i+1 .. Length( statements ) ]} );
                        
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
                tree.pos := tree.lvar;
                tree.initial_name := func_stack[Length( func_stack )].nams[tree.lvar];
                Unbind( tree.lvar );
                
            fi;
            
            if PositionSublist( tree.type, "HVAR" ) <> fail then
                
                level := Int( tree.hvar / 2^16 );
                pos := tree.hvar mod 2^16;
                
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
                    tree.pos := pos;
                    tree.initial_name := func_stack[Length( func_stack ) - level].nams[pos];
                    Unbind( tree.hvar );

                fi;
                
            fi;
            
        fi;

        return tree;
        
    end;
    
    additional_arguments_func := function( tree, key, additional_arguments )
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
    
    return CapJitIterateOverTree( tree, pre_func, CapJitResultFuncCombineChildren, additional_arguments_func, [[],[]] );
    
end );

InstallGlobalFunction( ENHANCED_SYNTAX_TREE_CODE, function( tree )
  local pre_func, additional_arguments_func, func;
    
    tree := StructuralCopy( tree );
    
    pre_func := function( tree, additional_arguments )
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
                    
                    tree.type := Concatenation( tree.type, [ String( Length( tree.body ) ) ] );
                    
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
                
                if tree.pos > Length( func_stack[func_pos].nams ) then
                    
                    Error( "FVAR references a non-existing position" );

                fi;
                
                if level = 0 then
                    
                    tree.type := ReplacedString( tree.type, "FVAR", "LVAR" );
                    tree.lvar := tree.pos;
                    
                else
                    
                    tree.type := ReplacedString( tree.type, "FVAR", "HVAR" );
                    tree.hvar := 2^16 * level + tree.pos;
                    
                fi;
                
            fi;

        fi;

        return tree;
        
    end;
    
    additional_arguments_func := function( tree, key, additional_arguments )
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
    
    tree := CapJitIterateOverTree( tree, pre_func, CapJitResultFuncCombineChildren, additional_arguments_func, [[],[]] );
    
    func := SYNTAX_TREE_CODE( tree );
    
    return func;
    
end );
