# SPDX-License-Identifier: GPL-2.0-or-later
# CompilerForCAP: Speed up computations in CAP categories
#
# Implementations
#
BindGlobal( "CAP_JIT_INTERNAL_FUNCTION_ID", 1 );
MakeReadWriteGlobal( "CAP_JIT_INTERNAL_FUNCTION_ID" );

# names of functions which accept a domain and a function which is applied to elements of the domain
BindGlobal( "CAP_JIT_INTERNAL_NAMES_OF_LOOP_FUNCTIONS", [ "List", "Sum", "Product", "ForAll", "ForAny", "Number", "Filtered", "First", "SafeFirst", "SafeUniqueEntry", "Last", "SafePositionProperty", "SafeUniquePositionProperty" ] );

InstallGlobalFunction( CapJitIsCallToGlobalFunction, function ( tree, condition )
  local condition_func;
    
    if IsString( condition ) then
        
        condition_func := gvar -> gvar = condition;
        
    elif IsFunction( condition ) then
        
        condition_func := condition;
        
    else
        
        # COVERAGE_IGNORE_NEXT_LINE
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
        
        # COVERAGE_IGNORE_NEXT_LINE
        Error( "this should never happen" );
        
    fi;
    
end );

InstallGlobalFunction( CapJitContainsRefToFVAROutsideOfFuncStack, function ( tree, initial_func_id_stack )
  local result_func, additional_arguments_func;
    
    result_func := function ( tree, result, keys, func_id_stack )
      local type, level;
        
        if tree.type = "EXPR_REF_FVAR" then
            
            if not tree.func_id in func_id_stack then
                
                return true;
                
            fi;
            
        fi;
        
        return ForAny( keys, key -> result.(key) );
        
    end;
    
    additional_arguments_func := function ( tree, key, func_id_stack )
        
        if tree.type = "EXPR_DECLARATIVE_FUNC" then
            
            Assert( 0, IsBound( tree.id ) );
            
            return Concatenation( func_id_stack, [ tree.id ] );
            
        else
            
            return func_id_stack;
            
        fi;
        
    end;
    
    return CapJitIterateOverTree( tree, ReturnFirst, result_func, additional_arguments_func, initial_func_id_stack );
    
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

InstallGlobalFunction( CapJitFindNodeDeep, function ( tree, condition_func )
  local match, pre_func, result_func, additional_arguments_func;
    
    match := fail;
    
    pre_func := function ( tree, additional_arguments )
        
        if match = fail then
            
            return tree;
            
        else
            
            return fail;
            
        fi;
        
    end;
    
    result_func := function ( tree, result, keys, path )
      local key;
        
        if match <> fail then
            
            return fail;
            
        fi;
        
        # none of the descendants fulfills condition, otherwise we would already have returned above
        if condition_func( tree, path ) then
            
            match := path;
            return true;
            
        fi;
        
        # neither this record nor any of its descendants fulfills the condition
        return fail;
        
    end;
    
    additional_arguments_func := function ( tree, key, path )
        
        return Concatenation( path, [ key ] );
        
    end;
    
    CapJitIterateOverTree( tree, pre_func, result_func, additional_arguments_func, [ ] );
    
    return match;
    
end );

InstallGlobalFunction( CapJitFindNodes, function ( tree, condition_func )
  local result_func, additional_arguments_func;
    
    result_func := function ( tree, result, keys, path )
      local new_result;
        
        # concatenate the results of the children
        new_result := Concatenation( List( keys, name -> result.(name) ) );
        
        # add this node if it fulfills the condition
        if condition_func( tree, path ) then
            
            return Concatenation( new_result, [ path ] );
            
        else
            
            return new_result;
            
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
        
    else
       
        Assert( 0, IsBound( tree.(path[1]) ) );
        
        return CapJitGetNodeByPath( tree.(path[1]), path{[ 2 .. Length( path ) ]} );
        
    fi;
    
end );

InstallGlobalFunction( CapJitRemovedReturnFail, function ( tree )
  local found_return_fail, return_value, new_branches;
    
    Assert( 0, tree.type = "EXPR_DECLARATIVE_FUNC" );
    
    tree := StructuralCopy( tree );
    
    found_return_fail := false;
    
    return_value := tree.bindings.BINDING_RETURN_VALUE;
    
    if return_value.type = "EXPR_CASE" then
        
        new_branches := Filtered( return_value.branches, branch -> not (branch.value.type = "EXPR_REF_GVAR" and branch.value.gvar = "fail") );
        
        found_return_fail := return_value.branches.length <> new_branches.length;
        
        # turn `if true then var := value; fi;` into `var := value;`
        if new_branches.length = 1 and new_branches.1.condition.type = "EXPR_TRUE" then
            
            tree.bindings.BINDING_RETURN_VALUE := new_branches.1.value;
            
        else
            
            return_value.branches := new_branches;
            
        fi;
        
    fi;
    
    if not found_return_fail then
        
        # COVERAGE_IGNORE_NEXT_LINE
        Error( "Could not detect a statement returning fail. Either the pragma CAP_JIT_NEXT_FUNCCALL_DOES_NOT_RETURN_FAIL is not set correctly or the given structure is not yet handled correctly by the compiler." );
        
    fi;
    
    return tree;
    
end );

InstallGlobalFunction( CapJitPrettyPrintFunction, function ( func )
  local size_screen, function_string, string_stream;
    
    if IsOperation( func ) or IsKernelFunction( func ) then
        
        # COVERAGE_IGNORE_NEXT_LINE
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
        
        if tree.type = "EXPR_DECLARATIVE_FUNC" then
            
            tree := CAP_JIT_INTERNAL_REPLACED_FVARS_FUNC_ID( tree, CAP_JIT_INTERNAL_FUNCTION_ID, tree.nams );
            CAP_JIT_INTERNAL_FUNCTION_ID := CAP_JIT_INTERNAL_FUNCTION_ID + 1;
            
        fi;
        
        return tree;
        
    end;
    
    return CapJitIterateOverTree( tree, pre_func, CapJitResultFuncCombineChildren, ReturnTrue, true );
    
end );

InstallGlobalFunction( CapJitIsEqualForEnhancedSyntaxTrees, function ( tree1, tree2 )
    
    return CAP_JIT_INTERNAL_TREE_MATCHES_TEMPLATE_TREE( tree1, tree2, [ ], false ) <> fail;
    
end );

InstallGlobalFunction( CapJitAddBinding, function ( bindings, name, value )
  local rec_name;
    
    if not IsRecord( bindings ) or not IsBound( bindings.type ) or bindings.type <> "FVAR_BINDING_SEQ" then
        
        # COVERAGE_IGNORE_NEXT_LINE
        Error( "the first argument must be a syntax tree of type FVAR_BINDING_SEQ" );
        
    fi;
    
    if not IsString( name ) then
        
        # COVERAGE_IGNORE_NEXT_LINE
        Error( "the second arguments must be a string" );
        
    fi;
    
    rec_name := Concatenation( "BINDING_", name );
    
    if IsBound( bindings.(rec_name) ) then
        
        # COVERAGE_IGNORE_NEXT_LINE
        Error( "there already is a binding with name ", name );
        
    fi;
    
    bindings.(rec_name) := value;
    Add( bindings.names, name );
    
end );

InstallGlobalFunction( CapJitValueOfBinding, function ( bindings, name )
    
    if not IsRecord( bindings ) or not IsBound( bindings.type ) or bindings.type <> "FVAR_BINDING_SEQ" then
        
        # COVERAGE_IGNORE_NEXT_LINE
        Error( "the first argument must be a syntax tree of type FVAR_BINDING_SEQ" );
        
    fi;
    
    if not IsString( name ) then
        
        # COVERAGE_IGNORE_NEXT_LINE
        Error( "the second arguments must be a string" );
        
    fi;
    
    if not name in bindings.names then
        
        # COVERAGE_IGNORE_NEXT_LINE
        Error( name, " is not the name of a binding" );
        
    fi;
    
    return bindings.(Concatenation( "BINDING_", name ));
    
end );

InstallGlobalFunction( CapJitUnbindBinding, function ( bindings, name )
  local pos;
    
    if not IsRecord( bindings ) or not IsBound( bindings.type ) or bindings.type <> "FVAR_BINDING_SEQ" then
        
        # COVERAGE_IGNORE_NEXT_LINE
        Error( "the first argument must be a syntax tree of type FVAR_BINDING_SEQ" );
        
    fi;
    
    if not IsString( name ) then
        
        # COVERAGE_IGNORE_NEXT_LINE
        Error( "the second arguments must be a string" );
        
    fi;
    
    pos := Position( bindings.names, name );
    
    if pos = fail then
        
        # COVERAGE_IGNORE_NEXT_LINE
        Error( name, " is not the name of a binding" );
        
    fi;
    
    Unbind( bindings.(Concatenation( "BINDING_", name )) );
    Remove( bindings.names, pos );
    
end );

InstallGlobalFunction( CapJitReplacedEXPR_REF_FVARByValue, function ( tree, func_id, name, value )
  local result_func;
    
    # Use result_func instead of pre_func: this way we do not iterate over `value` which
    # a) gives better performance and
    # b) prevents an infinite recursion in the following case:
    # val1 := 1;
    # val2 := 2;
    # val1 := val1;
    result_func := function ( tree, result, keys, additional_arguments )
      local key;
        
        tree := ShallowCopy( tree );
        
        for key in keys do
            
            tree.(key) := result.(key);
            
        od;
        
        if tree.type = "EXPR_REF_FVAR" and tree.func_id = func_id and tree.name = name then
            
            return CapJitCopyWithNewFunctionIDs( value );
            
        fi;
        
        return tree;
        
    end;
    
    return CapJitIterateOverTree( tree, ReturnFirst, result_func, ReturnTrue, true );
    
end );

InstallGlobalFunction( CapJitGetNextUnusedVariableID, function ( func )
  local used_ids, pos, name;
    
    used_ids := [ ];
    
    for name in func.nams do
        
        pos := Length( name );
        
        while pos > 0 and IsDigitChar( name[pos] ) do
            
            pos := pos - 1;
            
        od;
        
        if pos > 0 and pos < Length( name ) and name[pos] = '_' then
            
            Add( used_ids, Int( name{[ pos + 1 .. Length( name ) ]} ) );
            
        fi;
        
    od;
    
    return MaximumList( used_ids, 0 ) + 1;
    
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
        
        # COVERAGE_IGNORE_NEXT_LINE
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
        
        # COVERAGE_IGNORE_NEXT_LINE
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
        
        # COVERAGE_IGNORE_NEXT_LINE
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
        
        # COVERAGE_IGNORE_NEXT_LINE
        TryNextMethod();
        
    fi;
    
    return PositionProperty( [ 1 .. tree.length ], i -> func( tree.(i) ) );
    
end );

InstallGlobalFunction( ConcatenationForSyntaxTreeLists, function ( arg... )
  local tree, index, i, j;
    
    if Length( arg ) = 1 then
        
        arg := arg[1];
        
    fi;
    
    Assert( 0, IsList( arg ) );
    Assert( 0, ForAll( arg, a -> a.type = "SYNTAX_TREE_LIST" ) );
    
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
        
        # COVERAGE_IGNORE_NEXT_LINE
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
        
        # COVERAGE_IGNORE_NEXT_LINE
        TryNextMethod();
        
    fi;
    
    return AsSyntaxTreeList( Filtered( AsListMut( tree ), func ) );
    
end );

InstallMethod( PositionsProperty,
               "for syntax tree nodes of type SYNTAX_TREE_LIST",
               [ IsRecord, IsFunction ],
               
  function ( tree, func )
    
    if not IsBound( tree.type ) or tree.type <> "SYNTAX_TREE_LIST" then
        
        # COVERAGE_IGNORE_NEXT_LINE
        TryNextMethod();
        
    fi;
    
    return PositionsProperty( AsListMut( tree ), func );
    
end );

InstallMethod( FirstOp,
               "for syntax tree nodes of type SYNTAX_TREE_LIST",
               [ IsRecord, IsFunction ],
               
  function ( tree, func )
    local elm;
    
    if not IsBound( tree.type ) or tree.type <> "SYNTAX_TREE_LIST" then
        
        # COVERAGE_IGNORE_NEXT_LINE
        TryNextMethod();
        
    fi;
    
    for elm in tree do
        
        if func( elm ) then
            
            return elm;
            
        fi;
        
    od;
    
    return fail;
    
end );

InstallMethod( LastOp,
               "for syntax tree nodes of type SYNTAX_TREE_LIST",
               [ IsRecord ],
               
  function ( tree )
    
    if not IsBound( tree.type ) or tree.type <> "SYNTAX_TREE_LIST" then
        
        # COVERAGE_IGNORE_NEXT_LINE
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
        
        # COVERAGE_IGNORE_NEXT_LINE
        TryNextMethod();
        
    fi;
    
    return ForAll( [ 1 .. tree.length ], i -> func( tree.(i) ) );
    
end );

InstallMethod( ForAnyOp,
               "for syntax tree nodes of type SYNTAX_TREE_LIST",
               [ IsRecord, IsFunction ],
               
  function ( tree, func )
    
    if not IsBound( tree.type ) or tree.type <> "SYNTAX_TREE_LIST" then
        
        # COVERAGE_IGNORE_NEXT_LINE
        TryNextMethod();
        
    fi;
    
    return ForAny( [ 1 .. tree.length ], i -> func( tree.(i) ) );
    
end );

InstallMethod( Iterator,
               "for syntax tree nodes of type SYNTAX_TREE_LIST",
               [ IsRecord ],
               
  function ( tree )
    local iter;
    
    if not IsBound( tree.type ) or tree.type <> "SYNTAX_TREE_LIST" then
        
        # COVERAGE_IGNORE_NEXT_LINE
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

InstallGlobalFunction( PrintWithCurrentlyCompiledFunctionLocation, function ( args... )
  local func;
    
    # COVERAGE_IGNORE_BLOCK_START
    if IsEmpty( CAP_JIT_INTERNAL_COMPILED_FUNCTIONS_STACK ) then
        
        CallFuncList( Print, Concatenation( args, [ "\nwhile not compiling a function. This should never happen.\n" ] ) );
        
    fi;
    
    func := Last( CAP_JIT_INTERNAL_COMPILED_FUNCTIONS_STACK );
    
    CallFuncList( Print, Concatenation( args, [ "\nwhile compiling function with name \"", NameFunction( func ), "\"\nlocated at ", FilenameFunc( func ), ":", StartlineFunc( func ), "\n\n" ] ) );
    # COVERAGE_IGNORE_BLOCK_END
    
end );

InstallGlobalFunction( DisplayWithCurrentlyCompiledFunctionLocation, function ( obj )
  local func;
    
    # COVERAGE_IGNORE_BLOCK_START
    if IsEmpty( CAP_JIT_INTERNAL_COMPILED_FUNCTIONS_STACK ) then
        
        Error( obj, "\nwhile not compiling a function. This should never happen.\n" );
        
    fi;
    
    func := Last( CAP_JIT_INTERNAL_COMPILED_FUNCTIONS_STACK );
    
    Display( obj );
    
    Print( "while compiling function with name \"", NameFunction( func ), "\"\nlocated at ", FilenameFunc( func ), ":", StartlineFunc( func ), "\n\n" );
    # COVERAGE_IGNORE_BLOCK_END
    
end );

InstallGlobalFunction( ErrorWithCurrentlyCompiledFunctionLocation, function ( args... )
  local func;
    
    # COVERAGE_IGNORE_BLOCK_START
    if IsEmpty( CAP_JIT_INTERNAL_COMPILED_FUNCTIONS_STACK ) then
        
        CallFuncList( Error, Concatenation( args, [ "\nwhile not compiling a function. This should never happen.\n" ] ) );
        
    fi;
    
    func := Last( CAP_JIT_INTERNAL_COMPILED_FUNCTIONS_STACK );
    
    CallFuncList( Error, Concatenation( args, [ "\nwhile compiling function with name \"", NameFunction( func ), "\"\nlocated at ", FilenameFunc( func ), ":", StartlineFunc( func ), "\n" ] ) );
    # COVERAGE_IGNORE_BLOCK_END
    
end );

InstallGlobalFunction( EvalStringStrict, function ( string )
  local func;
    
    func := ReadAsFunction( InputTextString( Concatenation( "return ", string, ";" ) ) );
    
    if func = fail then
        
        # COVERAGE_IGNORE_NEXT_LINE
        Error( "a syntax error has occured" );
        
    fi;
    
    return EvalString( string );
    
end );
