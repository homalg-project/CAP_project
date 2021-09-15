# SPDX-License-Identifier: GPL-2.0-or-later
# CompilerForCAP: Speed up computations in CAP categories
#
# Implementations
#
BindGlobal( "CAP_JIT_INTERNAL_FUNCTION_ID", 1 );
MakeReadWriteGlobal( "CAP_JIT_INTERNAL_FUNCTION_ID" );

InstallGlobalFunction( CapJitIsCallToGlobalFunction, function ( tree, condition )
  local condition_func;
    
    if IsString( condition ) then
        
        condition_func := gvar -> gvar = condition;
        
    elif IsFunction( condition ) then
        
        condition_func := condition;
        
    else
        
        Error( "<condition> must be a string or a function" );
        
    fi;
    
    return tree.type = "EXPR_FUNCCALL" and tree.funcref.type = "EXPR_REF_GVAR" and condition_func( tree.funcref.gvar );
    
end );

InstallGlobalFunction( CapJitResultFuncCombineChildren, function ( tree, result, keys, additional_arguments )
  local key;
    
    # when unenhancing an enhanced syntax tree, the "list" case can still occur
    if IsList( result ) then
        
        return result;
        
    elif IsRecord( result ) then
        
        tree := ShallowCopy( tree );

        for key in keys do
            
            tree.(key) := result.(key);

        od;
        
        return tree;

    else
        
        Error( "this should never happen" );
        
    fi;
    
end );

InstallGlobalFunction( CapJitContainsRefToFVAROutsideOfFuncStack, function ( tree )
  local result_func, additional_arguments_func;
  
    result_func := function ( tree, result, keys, func_id_stack )
      local type, level;
        
        if PositionSublist( tree.type, "FVAR" ) <> fail then
            
            if not tree.func_id in func_id_stack then
                
                return true;
                
            fi;
            
        fi;
        
        return ForAny( keys, key -> result.(key) );
        
    end;
    
    additional_arguments_func := function ( tree, key, func_id_stack )
        
        if tree.type = "EXPR_FUNC" then
            
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
                
                Error( Concatenation( "tree contains reference to an fvar with name ", tree.name, " outside of the current function stack, this is not well-defined" ) );
                
            fi;
            
        fi;
        
        # make sure for loop only loops over local variables
        if tree.type = "STAT_FOR" then
            
            if tree.variable.type <> "EXPR_REF_FVAR" or tree.variable.func_id <> Last( func_id_stack ) then
                
                Error( "tree contains for loop over non-local variable, this is not supported" );
                
            fi;
            
        fi;
        
        # initialize number_of_assignments per function
        if tree.type = "EXPR_FUNC" then
            
            if IsBound( number_of_assignments[tree.id] ) then
                
                Error( "tree contains multiple functions with the same ID" );
                
            fi;
            
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
                
                Error( Concatenation( "tree contains an assignment of a higher variable with name ", tree.name, ", this is not supported" ) );
                
            fi;
            
            Assert( 0, IsBound( number_of_assignments[tree.func_id].(tree.name) ) );
            
            number_of_assignments[tree.func_id].(tree.name) := number_of_assignments[tree.func_id].(tree.name) + 1;
            
        fi;
        
        return tree;
        
    end;
    
    additional_arguments_func := function ( tree, key, func_id_stack )
        
        if tree.type = "EXPR_FUNC" then
            
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
    
    result_func := function ( tree, result, keys, path )
      local key, type;
        
        for key in keys do
            
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
        
    end;

    additional_arguments_func := function ( tree, key, path )
        
        return Concatenation( path, [ key ] );
        
    end;
  
    return CapJitIterateOverTree( tree, ReturnFirst, result_func, additional_arguments_func, [ ] );

end );

InstallGlobalFunction( CapJitGetNodeByPath, function ( tree, path )
    
    if Length( path ) = 0 then
        
        return tree;
        
    else
       
        Assert( 0, IsBound( tree.(path[1]) ) );
        
        return CapJitGetNodeByPath( tree.(path[1]), path{[ 2 .. Length( path ) ]} );
        
    fi;
    
end );

InstallGlobalFunction( CapJitRemovedReturnFail, function ( tree )
  local found_return_fail;
    
    Assert( 0, tree.type = "EXPR_FUNC" );
    
    tree := StructuralCopy( tree );
    
    # we want to rely on EXPR_CONDITIONAL below
    tree := CapJitDetectedTernaryConditionalExpressions( tree );
    
    found_return_fail := false;
    
    tree.stats.statements := AsSyntaxTreeList( Concatenation( List( [ 1 .. tree.stats.statements.length ], function ( i )
      local statement, branch, body_stat, next_statement;
        
        statement := tree.stats.statements.(i);
        
        # detect "if ... then return fail; fi"
        if statement.type = "STAT_IF" and statement.branches.length = 1 then
            
            branch := statement.branches.1;
            
            if branch.body.statements.length = 1 then
                
                body_stat := branch.body.statements.1;
                
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
        
        return [ statement ];
        
    end ) ) );
    
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

InstallGlobalFunction( CapJitCopyWithNewFunctionIDs, function ( tree )
  local pre_func;
    
    tree := StructuralCopy( tree );
    
    pre_func := function ( tree, additional_arguments )
        
        if tree.type = "EXPR_FUNC" then
            
            tree := ShallowCopy( tree );
            
            tree.stats := CAP_JIT_INTERNAL_REPLACED_FVARS_FUNC_ID( tree.stats, tree.id, CAP_JIT_INTERNAL_FUNCTION_ID, tree.nams, tree.nams );
            tree.id := CAP_JIT_INTERNAL_FUNCTION_ID;
            CAP_JIT_INTERNAL_FUNCTION_ID := CAP_JIT_INTERNAL_FUNCTION_ID + 1;
            
        fi;
        
        return tree;
        
    end;
    
    return CapJitIterateOverTree( tree, pre_func, CapJitResultFuncCombineChildren, ReturnTrue, true );
    
end );

InstallGlobalFunction( CapJitIsEqualForEnhancedSyntaxTrees, function ( tree1, tree2 )
    
    # well be changed inplace
    tree2 := StructuralCopy( tree2 );
    
    return CAP_JIT_INTERNAL_TREE_MATCHES_TEMPLATE_TREE( tree1, tree2 ) <> fail;
    
end );

## allow to handle SYNTAX_TREE_LISTs like lists
InstallMethod( AsSyntaxTreeList,
               [ IsList ],
               
  function ( list )
    local tree, i;
    
    tree := rec(
        type := "SYNTAX_TREE_LIST",
        length := Length( list ),
    );
    
    for i in [ 1 .. Length( list ) ] do
        
        tree.(i) := list[i];
        
    od;
    
    return tree;
    
end );

InstallMethod( AsListMut,
               "for syntax tree nodes of type SYNTAX_TREE_LIST",
               [ IsRecord ],
               
  function ( tree )
    
    if not IsBound( tree.type ) or tree.type <> "SYNTAX_TREE_LIST" then
        
        TryNextMethod();
        
    fi;
    
    return List( [ 1 .. tree.length ], i -> tree.(i) );
    
end );

InstallMethod( Sublist,
               "for syntax tree nodes of type SYNTAX_TREE_LIST",
               [ IsRecord, IsDenseList and IsSmallList ],
               
  function ( tree, poslist )
    local choice, j, i;
    
    if not IsBound( tree.type ) or tree.type <> "SYNTAX_TREE_LIST" then
        
        TryNextMethod();
        
    fi;
    
    choice := rec(
        type := "SYNTAX_TREE_LIST",
        length := Length( poslist ),
    );
    
    j := 1;
    
    for i in poslist do
        
        choice.(j) := tree.(i);
        
        j := j + 1;
        
    od;
    
    return choice;
    
end );

InstallMethod( Remove,
               "for syntax tree nodes of type SYNTAX_TREE_LIST",
               [ IsRecord and IsMutable, IsPosInt ],
               
  function ( tree, index )
    local old_value, i;
    
    if not IsBound( tree.type ) or tree.type <> "SYNTAX_TREE_LIST" then
        
        TryNextMethod();
        
    fi;
    
    if index > tree.length then
        
        return;
        
    fi;
    
    old_value := tree.(index);
    
    # move all elements after index by one index to the front
    for i in [ index .. tree.length - 1 ] do
        
        tree.(i) := tree.(i + 1);
        
    od;
    
    Unbind( tree.(tree.length) );
    
    tree.length := tree.length - 1;
    
    return old_value;
    
end );

InstallMethod( PositionProperty,
               "for syntax tree nodes of type SYNTAX_TREE_LIST",
               [ IsRecord, IsFunction ],
               
  function ( tree, func )
    
    if not IsBound( tree.type ) or tree.type <> "SYNTAX_TREE_LIST" then
        
        TryNextMethod();
        
    fi;
    
    return PositionProperty( [ 1 .. tree.length ], i -> func( tree.(i) ) );
    
end );

InstallGlobalFunction( ConcatenationForSyntaxTreeLists, function ( arg... )
  local tree, index, i, j;
    
    if Length( arg ) = 1 and IsList( arg[1] ) then
        
        arg := arg[1];
        
    fi;
    
    tree := rec(
        type := "SYNTAX_TREE_LIST",
        length := Sum( arg, tree -> tree.length ),
    );
    
    index := 1;
    
    for i in [ 1 .. Length( arg ) ] do
        
        for j in [ 1 .. arg[i].length ] do
            
            tree.(index) := arg[i].(j);
            
            index := index + 1;
            
        od;
        
    od;
    
    return tree;
    
end );

InstallMethod( ListOp,
               "for syntax tree nodes of type SYNTAX_TREE_LIST",
               [ IsRecord, IsFunction ],
               
  function ( tree, func )
    local result, i;
    
    if not IsBound( tree.type ) or tree.type <> "SYNTAX_TREE_LIST" then
        
        TryNextMethod();
        
    fi;
    
    result := rec(
        type := "SYNTAX_TREE_LIST",
        length := tree.length,
    );
    
    for i in [ 1 .. tree.length ] do
        
        result.(i) := func( tree.(i) );
        
    od;
    
    return result;
    
end );

InstallMethod( FilteredOp,
               "for syntax tree nodes of type SYNTAX_TREE_LIST",
               [ IsRecord, IsFunction ],
               
  function ( tree, func )
    
    if not IsBound( tree.type ) or tree.type <> "SYNTAX_TREE_LIST" then
        
        TryNextMethod();
        
    fi;
    
    return AsSyntaxTreeList( Filtered( AsListMut( tree ), func ) );
    
end );

InstallMethod( LastOp,
               "for syntax tree nodes of type SYNTAX_TREE_LIST",
               [ IsRecord ],
               
  function ( tree )
    
    if not IsBound( tree.type ) or tree.type <> "SYNTAX_TREE_LIST" then
        
        TryNextMethod();
        
    fi;
    
    if tree.length = 0 then
        
        return fail;
        
    fi;
    
    return tree.(tree.length);
    
end );

InstallMethod( ForAllOp,
               "for syntax tree nodes of type SYNTAX_TREE_LIST",
               [ IsRecord, IsFunction ],
               
  function ( tree, func )
    
    if not IsBound( tree.type ) or tree.type <> "SYNTAX_TREE_LIST" then
        
        TryNextMethod();
        
    fi;
    
    return ForAll( [ 1 .. tree.length ], i -> func( tree.(i) ) );
    
end );

InstallMethod( Iterator,
               "for syntax tree nodes of type SYNTAX_TREE_LIST",
               [ IsRecord ],
               
  function ( tree )
    local iter;
    
    if not IsBound( tree.type ) or tree.type <> "SYNTAX_TREE_LIST" then
        
        TryNextMethod();
        
    fi;
    
    # cf. IteratorList
    iter := rec(
        tree := tree,
        pos := 0,
        len := tree.length,
        NextIterator := function ( iter )
          local p;
            
            p := iter!.pos + 1;
            
            iter!.pos := p;
            
            return iter!.tree.(p);
            
        end,
        IsDoneIterator := iter -> iter!.pos >= iter!.len,
        ShallowCopy := iter -> rec( tree := iter!.tree, pos := iter!.pos, len := iter!.len ),
    );
    
    return IteratorByFunctions( iter );
    
end );
