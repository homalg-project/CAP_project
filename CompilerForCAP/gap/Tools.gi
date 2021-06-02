# SPDX-License-Identifier: GPL-2.0-or-later
# CompilerForCAP: Speed up computations in CAP categories
#
# Implementations
#
InstallGlobalFunction( CapJitIsCallToGlobalFunction, function ( tree, condition )
  local condition_func;
    
    if IsString( condition ) then
        
        condition_func := gvar -> gvar = condition;
        
    elif IsFunction( condition ) then
        
        condition_func := condition;
        
    else
        
        Error( "<condition> must be a string or a function" );
        
    fi;
    
    return IsRecord( tree ) and tree.type = "EXPR_FUNCCALL" and tree.funcref.type = "EXPR_REF_GVAR" and condition_func( tree.funcref.gvar );
    
end );

InstallGlobalFunction( CapJitResultFuncCombineChildren, function ( tree, result, additional_arguments )
  local key;
    
    if IsList( result ) then
        
        return result;
        
    elif IsRecord( result ) then
        
        tree := ShallowCopy( tree );

        for key in RecNames( result ) do
            
            tree.(key) := result.(key);

        od;
        
        return tree;

    else
        
        Error( "this should never happen" );
        
    fi;
    
end );

InstallGlobalFunction( CapJitContainsRefToFVAROutsideOfFuncStack, function ( tree )
  local result_func, additional_arguments_func;
  
    result_func := function ( tree, result, func_id_stack )
      local type, level;
        
        if IsList( result ) then
            
            return true in result;

        elif IsRecord( result ) then
            
            if PositionSublist( tree.type, "FVAR" ) <> fail then
                
                if not tree.func_id in func_id_stack then
                    
                    return true;
                    
                fi;
                
            fi;
            
            return ForAny( RecNames( result ), key -> result.(key) = true );
            
        else
            
            Error( "this should never happen" );
            
        fi;
        
    end;

    additional_arguments_func := function ( tree, key, func_id_stack )
        
        if IsRecord( tree ) and tree.type = "EXPR_FUNC" then
            
            Assert( 0, IsBound( tree.id ) );
            
            return Concatenation( func_id_stack, [ tree.id ] );
            
        else
            
            return func_id_stack;
            
        fi;
        
    end;
    
    return CapJitIterateOverTree( tree, ReturnFirst, result_func, additional_arguments_func, [ ] );
    
end );

BindGlobal( "CAP_JIT_INTERNAL_GLOBAL_VARIABLE_COUNTER", 1 );
MakeReadWriteGlobal( "CAP_JIT_INTERNAL_GLOBAL_VARIABLE_COUNTER" );
InstallGlobalFunction( CapJitGetOrCreateGlobalVariable, function ( value )
  local gvar, i;
    
    # check if value is already bound to a global variable
    for i in [ 1 .. CAP_JIT_INTERNAL_GLOBAL_VARIABLE_COUNTER - 1 ] do
        
        gvar := Concatenation( "CAP_JIT_INTERNAL_GLOBAL_VARIABLE_", String( i ) );

        if IsIdenticalObj( value, ValueGlobal( gvar ) ) then
            
            return gvar;
            
        fi;
        
    od;
    
    # create new global variable
    gvar := Concatenation( "CAP_JIT_INTERNAL_GLOBAL_VARIABLE_", String( CAP_JIT_INTERNAL_GLOBAL_VARIABLE_COUNTER ) );
    
    BindGlobal( gvar, value );

    CAP_JIT_INTERNAL_GLOBAL_VARIABLE_COUNTER := CAP_JIT_INTERNAL_GLOBAL_VARIABLE_COUNTER + 1;
    
    return gvar;
    
end );

InstallGlobalFunction( CapJitThrowErrorOnSideEffects, function ( tree )
  local number_of_assignments, pre_func, additional_arguments_func, i, name;
    
    # modified inplace
    number_of_assignments := [ ];
    
    pre_func := function ( tree, func_id_stack )
      local name;
        
        if IsRecord( tree ) then
            
            # make sure we deal with an enhanced syntax tree
            if PositionSublist( tree.type, "HVAR" ) <> fail or PositionSublist( tree.type, "LVAR" ) <> fail then
                
                Error( "tree contains reference to HVAR or LVAR, this is not supported. Please use an enhanced syntax tree" );
                
            fi;
            
            # exclude most common statements and expression indicating possible side effects
            if tree.type in [ "STAT_ASS_GVAR", "EXPR_ISB_GVAR", "STAT_UNB_GVAR", "EXPR_ISB_FVAR", "EXPR_UNB_FVAR", "STAT_PROCCALL", "STAT_ASS_LIST", "STAT_ASS_COMOBJ_NAME", "STAT_ASS_MAT" ] then

                Error( Concatenation( "tree includes statements or expressions which indicate possible side effects: ", tree.type ) );

            fi;
            
            # make sure that fvars reference only functions in the current function stack
            if PositionSublist( tree.type, "FVAR" ) <> fail then
                
                Assert( 0, IsBound( tree.func_id ) );
                
                if not tree.func_id in func_id_stack then
                    
                    Error( Concatenation( "tree contains reference to an fvar with inital name ", tree.initial_name, " outside of the current function stack, this is not well-defined" ) );
                    
                fi;
                
            fi;

            # make sure for loop only loops over local variables
            if tree.type = "STAT_FOR" then
                
                if tree.variable.type <> "EXPR_REF_FVAR" or tree.variable.func_id <> Last( func_id_stack ) then
                    
                    Error( "tree contains for loop over non-local variable, this is not supported" );
                    
                fi;
                
            fi;
            
            # initialize number_of_assignments per function
            if tree.type = "EXPR_FUNC" and not IsBound( number_of_assignments[tree.id] ) then
                
                number_of_assignments[tree.id] := rec( );
                
                for name in tree.nams{[ 1 .. tree.narg ]} do
                    
                    number_of_assignments[tree.id].(name) := 1;
                    
                od;
                
                for name in tree.nams{[ tree.narg + 1 .. tree.narg + tree.nloc ]} do
                    
                    number_of_assignments[tree.id].(name) := 0;
                    
                od;
                
            fi;
            
            # make sure that only local variables are assigned, increase number_of_assignments
            if tree.type = "STAT_ASS_FVAR" then
                
                if tree.func_id <> Last( func_id_stack ) then
                    
                    Error( Concatenation( "tree contains an assignment of a higher variable with initial name ", tree.initial_name, ", this is not supported" ) );
                    
                fi;

                Assert( 0, IsBound( number_of_assignments[tree.func_id].(tree.name) ) );
                
                number_of_assignments[tree.func_id].(tree.name) := number_of_assignments[tree.func_id].(tree.name) + 1;
                
            fi;
            
        fi;
            
        return tree;
        
    end;
    
    additional_arguments_func := function ( tree, key, func_id_stack )
        
        if IsRecord( tree ) and tree.type = "EXPR_FUNC" then
            
            Assert( 0, IsBound( tree.id ) );
            
            return Concatenation( func_id_stack, [ tree.id ] );
            
        else
            
            return func_id_stack;
            
        fi;
        
    end;
    
    CapJitIterateOverTree( tree, pre_func, ReturnTrue, additional_arguments_func, [ ] );
    
    # make sure no variables is assigned more than once
    for i in [ 1 .. Length( number_of_assignments ) ] do
        
        if IsBound( number_of_assignments[i] ) then
            
            for name in RecNames( number_of_assignments[i] ) do
                
                if number_of_assignments[i].(name) >= 2 then
                    
                    Error( Concatenation( "a local variable with name ", name, " is assigned more than once (not as part of a rapid reassignment), this is not supported" ) );
                    
                fi;
                
            od;
            
        fi;
        
    od;
    
end );

InstallGlobalFunction( CapJitFindNodeDeep, function ( tree, condition_func )
  local result_func, additional_arguments_func;
    
    result_func := function ( tree, result, path )
      local key, type;
        
        if IsList( result ) then
            
            return First( result, r -> r <> fail );
            
        elif IsRecord( result ) then
        
            for key in RecNames( result ) do
                
                if result.(key) <> fail then
                    
                    return result.(key);
                
                fi;
                    
            od;

            # none of the descendants fulfills condition, otherwise we would already have returned above
            if condition_func( tree, path ) then
                
                return path;
                
            fi;
            
            # neither this record nor any of its descendants fulfills the condition
            return fail;

        else
            
            Error( "this should never happen" );
            
        fi;
        
    end;

    additional_arguments_func := function ( tree, key, path )
        
        return Concatenation( path, [ key ] );
        
    end;
  
    return CapJitIterateOverTree( tree, ReturnFirst, result_func, additional_arguments_func, [ ] );

end );

InstallGlobalFunction( CapJitGetNodeByPath, function ( tree, path )
    
    if Length( path ) = 0 then
        
        return tree;
        
    elif IsList( tree ) then
        
        Assert( 0, IsPosInt( path[1] ) and path[1] <= Length( tree ) );

        return CapJitGetNodeByPath( tree[path[1]], path{[ 2 .. Length( path ) ]} );

    else
       
        Assert( 0, IsBound( tree.(path[1]) ) );
        
        return CapJitGetNodeByPath( tree.(path[1]), path{[ 2 .. Length( path ) ]} );
        
    fi;
    
end );

InstallGlobalFunction( CapJitRemovedReturnFail, function ( tree )
  local found_return_fail;
    
    Assert( 0, IsRecord( tree ) );
    Assert( 0, tree.type = "EXPR_FUNC" );
    
    tree := StructuralCopy( tree );

    found_return_fail := false;
    
    tree.stats.statements := Concatenation( List( [ 1 .. Length( tree.stats.statements ) ], function ( i )
      local statement, branch, body_stat, next_statement;
        
        statement := tree.stats.statements[i];
        
        # detect "if ... then return fail; fi"
        if statement.type = "STAT_IF" and Length( statement.branches ) = 1 then
            
            branch := statement.branches[1];
            
            if Length( branch.body.statements ) = 1 then
                
                body_stat := branch.body.statements[1];
                
                if body_stat.type = "STAT_RETURN_OBJ" and body_stat.obj.type = "EXPR_REF_GVAR" and body_stat.obj.gvar = "fail" then
                    
                    found_return_fail := true;
                    
                    return [ ];
                    
                fi;
                
            fi;
            
        fi;
        
        # detect "if ... then return fail; else return ...; fi" (as EXPR_CONDITIONAL)
        if statement.type = "STAT_RETURN_OBJ" and statement.obj.type = "EXPR_CONDITIONAL" and statement.obj.expr_if_true.type = "EXPR_REF_GVAR" and statement.obj.expr_if_true.gvar = "fail" then
            
            found_return_fail := true;
            
            return [
                rec(
                    type := "STAT_RETURN_OBJ",
                    obj := statement.obj.expr_if_false,
                )
            ];
            
        fi;
        
        # detect "if ... then var := fail; else var := fi; return var" (as EXPR_CONDITIONAL)
        if statement.type = "STAT_ASS_FVAR" and statement.rhs.type = "EXPR_CONDITIONAL" and statement.rhs.expr_if_true.type = "EXPR_REF_GVAR" and statement.rhs.expr_if_true.gvar = "fail" and i < Length( tree.stats.statements ) then
            
            # check if next statement is "return var"
            next_statement := tree.stats.statements[i + 1];
            
            if next_statement.type = "STAT_RETURN_OBJ" and next_statement.obj.type = "EXPR_REF_FVAR" and next_statement.obj.func_id = statement.func_id and next_statement.obj.name = statement.name then
                
                found_return_fail := true;
                
                return [
                    rec(
                        type := "STAT_ASS_FVAR",
                        func_id := statement.func_id,
                        name := statement.name,
                        initial_name := statement.initial_name,
                        rhs := statement.rhs.expr_if_false,
                    )
                ];
                
            fi;
            
        fi;
        
        return [ statement ];
        
    end ) );
    
    if not found_return_fail then
        
        Error( "Could not detect a statement returning fail. Either the pragma CAP_JIT_NEXT_FUNCCALL_DOES_NOT_RETURN_FAIL is not set correctly or the given structure is not yet handled correctly by the compiler" );
        
    fi;
    
    return tree;
    
end );

InstallGlobalFunction( CapJitPrettyPrintFunction, function ( func )
  local size_screen, function_string, string_stream;
    
    if IsOperation( func ) or IsKernelFunction( func ) then
        
        Error( "<func> must neither be an operation nor a kernel function" );
        
    fi;
    
    size_screen := SizeScreen( );
    
    # Lines which are exceeding SizeScreen and are thus wrapped using "\" are still valid GAP code,
    # so this is purely cosmetic.
    # We cannot use SetPrintFormattingStatus as that also prevents indentation.
    SizeScreen( [ 4096 ] );
    
    function_string := "";
    
    string_stream := OutputTextString( function_string, false );
    
    PrintTo( string_stream, func );
    
    CloseStream( string_stream );
    
    SizeScreen( size_screen );
    
    return function_string;
    
end );
