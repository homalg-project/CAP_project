# SPDX-License-Identifier: GPL-2.0-or-later
# CompilerForCAP: Speed up computations in CAP categories
#
# Implementations
#
BindGlobal( "CAP_JIT_LOGIC_FUNCTIONS", [ ] );

InstallGlobalFunction( CapJitAddLogicFunction, function ( func )
    
    if not IsFunction( func ) then
        
        # COVERAGE_IGNORE_NEXT_LINE
        Error( "a logic function must be a function" );
        
    fi;
    
    if NumberArgumentsFunction( func ) <> 1 then
        
        # COVERAGE_IGNORE_NEXT_LINE
        Error( "a logic function must have exactly one argument" );
        
    fi;
    
    Add( CAP_JIT_LOGIC_FUNCTIONS, func );
    
end );

InstallGlobalFunction( CapJitAppliedLogic, function ( tree )
  local logic_function;
    
    for logic_function in CAP_JIT_LOGIC_FUNCTIONS do
        
        tree := logic_function( tree );
        
    od;
    
    tree := CapJitAppliedLogicTemplates( tree );
    
    return tree;
    
end );

# [ int1 .. int2 ] = [ int1, ..., int2 ]
CapJitAddLogicFunction( function ( tree )
  local pre_func;
    
    Info( InfoCapJit, 1, "####" );
    Info( InfoCapJit, 1, "Apply logic for ranges with known boundaries." );
    
    pre_func := function ( tree, additional_arguments )
        
        if tree.type = "EXPR_RANGE" and tree.first.type = "EXPR_INT" and tree.last.type = "EXPR_INT" then
            
            return rec(
                type := "EXPR_LIST",
                list := AsSyntaxTreeList( List(
                    [ tree.first.value .. tree.last.value ],
                    int -> rec(
                        type := "EXPR_INT",
                        value := int,
                    )
                ) ),
            );
            
        fi;
        
        return tree;
        
    end;
    
    return CapJitIterateOverTree( tree, pre_func, CapJitResultFuncCombineChildren, ReturnTrue, true );
    
end );

# [ a_1, a_2, ... ][i] => a_i
CapJitAddLogicFunction( function ( tree )
  local pre_func;
    
    Info( InfoCapJit, 1, "####" );
    Info( InfoCapJit, 1, "Apply logic for accessing elements of literal lists." );
    
    pre_func := function ( tree, additional_arguments )
      local args;
        
        if CapJitIsCallToGlobalFunction( tree, "[]" ) and tree.args.1.type = "EXPR_LIST" and tree.args.2.type = "EXPR_INT" then
            
            return tree.args.1.list.(tree.args.2.value);
            
        fi;
        
        return tree;
        
    end;
    
    return CapJitIterateOverTree( tree, pre_func, CapJitResultFuncCombineChildren, ReturnTrue, true );
    
end );

# Last( [ a_1, ..., a_n ] ) => a_n
CapJitAddLogicFunction( function ( tree )
  local pre_func;
    
    Info( InfoCapJit, 1, "####" );
    Info( InfoCapJit, 1, "Apply logic for accessing the last element of a literal list." );
    
    pre_func := function ( tree, additional_arguments )
        
        if CapJitIsCallToGlobalFunction( tree, "Last" ) and tree.args.1.type = "EXPR_LIST" then
            
            return tree.args.1.list.(tree.args.1.list.length);
            
        fi;
        
        return tree;
        
    end;
    
    return CapJitIterateOverTree( tree, pre_func, CapJitResultFuncCombineChildren, ReturnTrue, true );
    
end );

# NTuple( n, a_1, ..., a_n )[i] => a_i
CapJitAddLogicFunction( function ( tree )
  local pre_func;
    
    Info( InfoCapJit, 1, "####" );
    Info( InfoCapJit, 1, "Apply logic for accessing elements of tuples." );
    
    pre_func := function ( tree, additional_arguments )
      local args;
        
        if CapJitIsCallToGlobalFunction( tree, "[]" ) and CapJitIsCallToGlobalFunction( tree.args.1, "NTuple" ) then
            
            if tree.args.2.type <> "EXPR_INT" then
                
                # COVERAGE_IGNORE_NEXT_LINE
                Error( "You should only access tuples via literal integers." );
                
            fi;
            
            return tree.args.1.args.(tree.args.2.value + 1);
            
        fi;
        
        return tree;
        
    end;
    
    return CapJitIterateOverTree( tree, pre_func, CapJitResultFuncCombineChildren, ReturnTrue, true );
    
end );

# a = b?
CapJitAddLogicFunction( function ( tree )
  local pre_func;
    
    Info( InfoCapJit, 1, "####" );
    Info( InfoCapJit, 1, "Apply logic for equality." );
    
    pre_func := function ( tree, additional_arguments )
      local args;
        
        if tree.type = "EXPR_EQ" and tree.left.type = tree.right.type then
            
            if CapJitIsEqualForEnhancedSyntaxTrees( tree.left, tree.right ) then
                
                return rec( type := "EXPR_TRUE" );
                
            # for integers, strings, and chars we can also decide inequality
            elif tree.left.type = "EXPR_INT" or tree.left.type = "EXPR_STRING" or tree.left.type = "EXPR_CHAR" then
                
                return rec( type := "EXPR_FALSE" );
                
            fi;
            
        fi;
        
        return tree;
        
    end;
    
    return CapJitIterateOverTree( tree, pre_func, CapJitResultFuncCombineChildren, ReturnTrue, true );
    
end );

# Length( [ a_1, ..., a_n ] ) => n
CapJitAddLogicFunction( function ( tree )
  local pre_func;
    
    Info( InfoCapJit, 1, "####" );
    Info( InfoCapJit, 1, "Apply logic for Length of literal lists." );
    
    pre_func := function ( tree, additional_arguments )
      local args;
        
        if CapJitIsCallToGlobalFunction( tree, "Length" ) and tree.args.length = 1 and tree.args.1.type = "EXPR_LIST" then
            
            return rec(
                type := "EXPR_INT",
                value := tree.args.1.list.length,
            );
            
        fi;
        
        return tree;
        
    end;
    
    return CapJitIterateOverTree( tree, pre_func, CapJitResultFuncCombineChildren, ReturnTrue, true );
    
end );

# Length( Concatenation( ... ) ) => Sum( ... )
CapJitAddLogicFunction( function ( tree )
  local pre_func;
    
    Info( InfoCapJit, 1, "####" );
    Info( InfoCapJit, 1, "Apply logic for Length of a Concatenation." );
    
    pre_func := function ( tree, additional_arguments )
      local args;
        
        if CapJitIsCallToGlobalFunction( tree, "Length" ) and tree.args.length = 1 and CapJitIsCallToGlobalFunction( tree.args.1, "Concatenation" ) then
            
            args := tree.args.1.args;
            
            if args.length = 1 then
                
                # Length( Concatenation( list ) ) -> Sum( List( list, Length ) )
                
                tree := rec(
                    type := "EXPR_FUNCCALL",
                    funcref := rec(
                        type := "EXPR_REF_GVAR",
                        gvar := "Sum",
                    ),
                    args := AsSyntaxTreeList( [
                        rec(
                            type := "EXPR_FUNCCALL",
                            funcref := rec(
                                type := "EXPR_REF_GVAR",
                                gvar := "List",
                            ),
                            args := AsSyntaxTreeList( [
                                args.1,
                                rec(
                                    type := "EXPR_REF_GVAR",
                                    gvar := "Length",
                                ),
                            ] ),
                        ),
                    ] ),
                );
                
            else
                
                # Length( Concatenation( list1, list2, ... ) ) -> Sum( [ Length( list1 ), Length( list2 ), ... ] )
                
                tree := rec(
                    type := "EXPR_FUNCCALL",
                    funcref := rec(
                        type := "EXPR_REF_GVAR",
                        gvar := "Sum",
                    ),
                    args := AsSyntaxTreeList( [
                        rec(
                            type := "EXPR_LIST",
                            list := List( args, a ->
                                rec(
                                    type := "EXPR_FUNCCALL",
                                    funcref := rec(
                                        type := "EXPR_REF_GVAR",
                                        gvar := "Length",
                                    ),
                                    args := AsSyntaxTreeList( [
                                        a,
                                    ] ),
                                )
                            ),
                        ),
                    ] ),
                );
                
            fi;
            
        fi;
        
        return tree;
        
    end;
    
    return CapJitIterateOverTree( tree, pre_func, CapJitResultFuncCombineChildren, ReturnTrue, true );
    
end );

# Concatenation( [ ... ] ) => Concatenation( ... )
# Concatenation( [ a, b, ... ], [ c, d, ... ], ... ) => [ a, b, ..., c, d, ... ]
CapJitAddLogicFunction( function ( tree )
  local pre_func;
    
    Info( InfoCapJit, 1, "####" );
    Info( InfoCapJit, 1, "Apply logic for concatenation of literal lists." );
    
    pre_func := function ( tree, additional_arguments )
      local args;
        
        # Concatenation with a single argument has different semantics
        # -> convert to version with multiple arguments
        if CapJitIsCallToGlobalFunction( tree, "Concatenation" ) and tree.args.length = 1 and tree.args.1.type = "EXPR_LIST" then
            
            args := tree.args;
            
            if args.1.list.length = 1 then
                
                tree := args.1.list.1;
                
            else
                
                tree := rec(
                    type := "EXPR_FUNCCALL",
                    funcref := tree.funcref, # Concatenation
                    args := args.1.list,
                );
                
            fi;
            
        fi;
        
        if CapJitIsCallToGlobalFunction( tree, "Concatenation" ) then
            
            args := tree.args;
            
            if args.length > 1 and ForAll( args, a -> a.type = "EXPR_LIST" ) then
                
                return rec(
                    type := "EXPR_LIST",
                    list := ConcatenationForSyntaxTreeLists( AsListMut( List( args, a -> a.list ) ) ),
                );
                
            fi;
            
        fi;
        
        return tree;
        
    end;
    
    return CapJitIterateOverTree( tree, pre_func, CapJitResultFuncCombineChildren, ReturnTrue, true );
    
end );

# CallFuncList( func, [ a, b, ... ] ) => func( a, b, ... )
CapJitAddLogicFunction( function ( tree )
  local pre_func;
    
    Info( InfoCapJit, 1, "####" );
    Info( InfoCapJit, 1, "Apply logic for CallFuncList." );
    
    pre_func := function ( tree, additional_arguments )
      local args;
        
        if CapJitIsCallToGlobalFunction( tree, "CallFuncList" ) then
            
            args := tree.args;
            
            if args.2.type = "EXPR_LIST" then
                
                return rec(
                    type := "EXPR_FUNCCALL",
                    funcref := args.1,
                    args := args.2.list,
                );
                
            fi;
            
        fi;
        
        return tree;
        
    end;
    
    return CapJitIterateOverTree( tree, pre_func, CapJitResultFuncCombineChildren, ReturnTrue, true );
    
end );

# List( [ a_1, ..., a_n ], f ) = [ f( a_1 ), ..., f( a_n ) ]
CapJitAddLogicFunction( function ( tree )
  local pre_func;
    
    Info( InfoCapJit, 1, "####" );
    Info( InfoCapJit, 1, "Apply logic for List applied to a literal list." );
    
    pre_func := function ( tree, additional_arguments )
      local args;
        
        if CapJitIsCallToGlobalFunction( tree, "List" ) then
            
            args := tree.args;
            
            if args.length = 2 and args.1.type = "EXPR_LIST" then
                
                return rec(
                    type := "EXPR_LIST",
                    list := List(
                        args.1.list,
                        entry -> rec(
                            type := "EXPR_FUNCCALL",
                            funcref := CapJitCopyWithNewFunctionIDs( args.2 ),
                            args := AsSyntaxTreeList( [ entry ] ),
                        )
                    ),
                );
                
            fi;
            
        fi;
        
        return tree;
        
    end;
    
    return CapJitIterateOverTree( tree, pre_func, CapJitResultFuncCombineChildren, ReturnTrue, true );
    
end );

# List( Concatenation( L_1, ..., L_n ), f ) = Concatenation( List( L_1, f ), ..., List( L_n, f ) )
CapJitAddLogicFunction( function ( tree )
  local pre_func;
    
    Info( InfoCapJit, 1, "####" );
    Info( InfoCapJit, 1, "Apply logic for List applied to a Concatenation with multiple arguments." ); # the case of a single argument is handled by a logic template
    
    pre_func := function ( tree, additional_arguments )
        
        if CapJitIsCallToGlobalFunction( tree, "List" ) then
            
            if tree.args.length = 2 and CapJitIsCallToGlobalFunction( tree.args.1, "Concatenation" ) and tree.args.1.args.length > 1 then
                
                return rec(
                    type := "EXPR_FUNCCALL",
                    funcref := tree.args.1.funcref, # Concatenation
                    args := List(
                        tree.args.1.args,
                        a -> rec(
                            type := "EXPR_FUNCCALL",
                            funcref := tree.funcref, # List
                            args := AsSyntaxTreeList( [
                                a,
                                CapJitCopyWithNewFunctionIDs( tree.args.2 )
                            ] ),
                        )
                    ),
                );
                
            fi;
            
        fi;
        
        return tree;
        
    end;
    
    return CapJitIterateOverTree( tree, pre_func, CapJitResultFuncCombineChildren, ReturnTrue, true );
    
end );

# AttributeGetter( CreateCapCategoryObject/MorphismWithAttributes( ..., Attribute, value, ... ) ) => value
CapJitAddLogicFunction( function ( tree )
  local pre_func;
    
    Info( InfoCapJit, 1, "####" );
    Info( InfoCapJit, 1, "Apply logic for attribute getters." );
    
    pre_func := function ( tree, additional_arguments )
      local attribute_name, args, object, list, pos;
        
        # attribute getters can also be applied to more than one argument, but we are not interested in that case
        if CapJitIsCallToGlobalFunction( tree, gvar -> IsAttribute( ValueGlobal( gvar ) ) ) and tree.args.length = 1 then
            
            attribute_name := tree.funcref.gvar;
            
            args := tree.args;
            
            object := args.1;
            
            list := fail;
            
            if CapJitIsCallToGlobalFunction( object, "CreateCapCategoryObjectWithAttributes" ) then
                
                # special case
                if attribute_name = "CapCategory" then
                    
                    return object.args.1;
                    
                fi;
                
                list := Sublist( object.args, [ 2 .. object.args.length ] );
                
            fi;
            
            if CapJitIsCallToGlobalFunction( object, "CreateCapCategoryMorphismWithAttributes" ) then
                
                # special cases
                if attribute_name = "CapCategory" then
                    
                    return object.args.1;
                    
                elif attribute_name = "Source" then
                    
                    return object.args.2;
                    
                elif attribute_name = "Range" or attribute_name = "Target" then
                    
                    return object.args.3;
                    
                fi;
                
                list := Sublist( object.args, [ 4 .. object.args.length ] );
                
            fi;
            
            if list <> fail then
                
                pos := PositionProperty( list, a -> a.type = "EXPR_REF_GVAR" and a.gvar = tree.funcref.gvar );
                
                if pos <> fail and IsOddInt( pos ) then
                    
                    Assert( 0, IsBound( list.(pos + 1) ) );
                    
                    return list.(pos + 1);
                    
                fi;
                
            fi;
            
        fi;
            
        return tree;
        
    end;
    
    return CapJitIterateOverTree( tree, pre_func, CapJitResultFuncCombineChildren, ReturnTrue, true );
    
end );

# CreateCapCategoryObjectWithAttributes( cat, Attribute, Attribute( obj ) ) => obj
# Note: Attribute( obj ) is outlined!
CapJitAddLogicFunction( function ( tree )
  local pre_func, additional_arguments_func;
    
    Info( InfoCapJit, 1, "####" );
    Info( InfoCapJit, 1, "Apply logic for unwrapping and immediately re-wrapping a CAP category object." );
    
    pre_func := function ( tree, func_stack )
      local attribute_name, func, value;
        
        # Attribute( obj ) is outlined!
        if CapJitIsCallToGlobalFunction( tree, "CreateCapCategoryObjectWithAttributes" ) and tree.args.length = 3 and tree.args.1.type = "EXPR_REF_GVAR" and IsBound( tree.args.1.data_type ) and tree.args.2.type = "EXPR_REF_GVAR" and tree.args.3.type = "EXPR_REF_FVAR" then
            
            attribute_name := tree.args.2.gvar;
            
            func := SafeUniqueEntry( func_stack, func -> func.id = tree.args.3.func_id );
            
            # check if tree.args.3 references a binding, not an argument
            if SafeUniquePosition( func.nams, tree.args.3.name ) > func.narg then
            
                value := CapJitValueOfBinding( func.bindings, tree.args.3.name );
                
                if CapJitIsCallToGlobalFunction( value, attribute_name ) and value.args.length = 1 and IsBound( value.args.1.data_type ) then
                    
                    Assert( 0, IsSpecializationOfFilter( IsCapCategory, tree.args.1.data_type.filter ) );
                    
                    if value.args.1.data_type = CapJitDataTypeOfObjectOfCategory( tree.args.1.data_type.category ) then
                        
                        return value.args.1;
                        
                    fi;
                    
                fi;
                
            fi;
            
        fi;
        
        return tree;
        
    end;
    
    additional_arguments_func := function ( tree, key, func_stack )
        
        if tree.type = "EXPR_DECLARATIVE_FUNC" then
            
            return Concatenation( func_stack, [ tree ] );
            
        else
            
            return func_stack;
            
        fi;
        
    end;
    
    return CapJitIterateOverTree( tree, pre_func, CapJitResultFuncCombineChildren, additional_arguments_func, [ ] );
    
end );


# EXPR_CASE with all branches having the same value
CapJitAddLogicFunction( function ( tree )
  local pre_func;
    
    Info( InfoCapJit, 1, "####" );
    Info( InfoCapJit, 1, "Apply logic for EXPR_CASE with all branches having the same value." );
    
    pre_func := function ( tree, additional_arguments )
        
        if tree.type = "EXPR_CASE" and tree.branches.length > 0 and ForAll( tree.branches, branch -> CapJitIsEqualForEnhancedSyntaxTrees( branch.value, tree.branches.1.value ) ) then
            
            return tree.branches.1.value;
            
        fi;
        
        return tree;
        
    end;
    
    return CapJitIterateOverTree( tree, pre_func, CapJitResultFuncCombineChildren, ReturnTrue, true );
    
end );

# func( EXPR_CASE )
CapJitAddLogicFunction( function ( tree )
  local pre_func;
    
    Info( InfoCapJit, 1, "####" );
    Info( InfoCapJit, 1, "Apply logic for func( EXPR_CASE )." );
    
    pre_func := function ( tree, additional_arguments )
        
        if tree.type = "EXPR_FUNCCALL" and tree.args.length = 1 and tree.args.1.type = "EXPR_CASE" then
            
            return rec(
                type := "EXPR_CASE",
                branches := List( tree.args.1.branches, branch -> rec(
                    type := "CASE_BRANCH",
                    condition := branch.condition,
                    value := rec(
                        type := "EXPR_FUNCCALL",
                        funcref := CapJitCopyWithNewFunctionIDs( tree.funcref ),
                        args := AsSyntaxTreeList( [
                            branch.value
                        ] ),
                    ),
                ) ),
            );
            
        fi;
        
        return tree;
        
    end;
    
    return CapJitIterateOverTree( tree, pre_func, CapJitResultFuncCombineChildren, ReturnTrue, true );
    
end );

# helper
InstallGlobalFunction( CAP_JIT_INTERNAL_TELESCOPED_ITERATION, function ( tree, result_func_index, additional_funcs_indices, initial_value_index, additional_values_indices, list_values_indices )
  local result_func, initial_value, additional_funcs, additional_values, return_obj, cat, attribute_name, case, source, range, new_func, new_additional_funcs, arguments_references_paths, parent, new_initial_value, args, new_additional_values, new_args, new_tree, initial_value_morphism, func, path, i;
    
    Assert( 0, tree.type = "EXPR_FUNCCALL" );
    Assert( 0, tree.funcref.type = "EXPR_REF_GVAR" );
    Assert( 0, [ 1 .. tree.args.length ] = Union( [ result_func_index, initial_value_index ], additional_funcs_indices, additional_values_indices ) );
    Assert( 0, not result_func_index in additional_funcs_indices );
    Assert( 0, not initial_value_index in additional_funcs_indices );
    Assert( 0, not result_func_index in additional_values_indices );
    Assert( 0, not initial_value_index in additional_values_indices );
    
    result_func := tree.args.(result_func_index);
    initial_value := tree.args.(initial_value_index);
    additional_funcs := Sublist( tree.args, additional_funcs_indices );
    additional_values := Sublist( tree.args, additional_values_indices );
    
    if result_func.type = "EXPR_DECLARATIVE_FUNC" and ForAll( additional_funcs, f -> f.type = "EXPR_DECLARATIVE_FUNC" ) then
        
        return_obj := result_func.bindings.BINDING_RETURN_VALUE;
        
        if CapJitIsCallToGlobalFunction( return_obj, gvar -> gvar in [ "CreateCapCategoryObjectWithAttributes", "CreateCapCategoryMorphismWithAttributes" ] ) and return_obj.args.1.type = "EXPR_REF_GVAR" then
            
            cat := ValueGlobal( return_obj.args.1.gvar );
            
            Assert( 0, IsCapCategory( cat ) );
            
            attribute_name := fail;
            
            if return_obj.funcref.gvar = "CreateCapCategoryObjectWithAttributes" and return_obj.args.length = 3 and return_obj.args.2.type = "EXPR_REF_GVAR" then
                
                attribute_name := return_obj.args.2.gvar;
                
            elif return_obj.funcref.gvar = "CreateCapCategoryMorphismWithAttributes" and return_obj.args.length = 5 and return_obj.args.4.type = "EXPR_REF_GVAR" then
                
                case := fail;
                
                source := return_obj.args.2;
                
                # source might have been outlined
                if source.type = "EXPR_REF_FVAR" and source.func_id = result_func.id and SafeUniquePosition( result_func.nams, source.name ) > result_func.narg then
                    
                    source := CapJitValueOfBinding( result_func.bindings, source.name );
                    
                fi;
                
                range := return_obj.args.3;
                
                # range might have been outlined
                if range.type = "EXPR_REF_FVAR" and range.func_id = result_func.id and SafeUniquePosition( result_func.nams, range.name ) > result_func.narg then
                    
                    range := CapJitValueOfBinding( result_func.bindings, range.name );
                    
                fi;
                
                if
                    # Source can be recovered from initial_value
                    CapJitIsCallToGlobalFunction( source, "Source" ) and source.args.length = 1 and source.args.1.type = "EXPR_REF_FVAR" and source.args.1.func_id = result_func.id and source.args.1.name = result_func.nams[1] and
                    # Range can be recovered from initial_value
                    CapJitIsCallToGlobalFunction( range, gvar -> gvar in [ "Range", "Target" ] ) and range.args.length = 1 and range.args.1.type = "EXPR_REF_FVAR" and range.args.1.func_id = result_func.id and range.args.1.name = result_func.nams[1]
                then
                    
                    case := "from_initial_value";
                    attribute_name := return_obj.args.4.gvar;
                    
                elif
                    # Source and Range are global variables
                    source.type = "EXPR_REF_GVAR" and range.type = "EXPR_REF_GVAR"
                then
                    
                    case := "global_variables";
                    
                    attribute_name := return_obj.args.4.gvar;
                    
                elif
                    # Source and Range can be recovered from compiler hints
                    IsBound( cat!.compiler_hints ) and IsBound( cat!.compiler_hints.source_and_range_attributes_from_morphism_attribute )
                then
                    
                    case := "from_compiler_hints";
                    
                    attribute_name := return_obj.args.4.gvar;
                    
                    Assert( 0, attribute_name = cat!.compiler_hints.source_and_range_attributes_from_morphism_attribute.morphism_attribute_name );
                    
                fi;
                
            fi;
            
            if attribute_name <> fail then
                
                Assert( 0, IsAttribute( ValueGlobal( attribute_name ) ) );
                
                # create new func which immediately returns the attribute
                new_func := StructuralCopy( result_func );
                new_func.bindings.BINDING_RETURN_VALUE := Last( new_func.bindings.BINDING_RETURN_VALUE.args );
                
                # possibly drop outlined source and range
                new_func := CapJitDroppedUnusedBindings( new_func );
                
                # new_additional_funcs will be modified inplace
                new_additional_funcs := StructuralCopy( additional_funcs );
                
                # check if arguments are only accessed via the attribute
                for func in ConcatenationForSyntaxTreeLists( AsSyntaxTreeList( [ new_func ] ), new_additional_funcs ) do
                    
                    arguments_references_paths := CapJitFindNodes( func, { tree, path } -> tree.type = "EXPR_REF_FVAR" and tree.func_id = func.id and SafeUniquePosition( func.nams, tree.name ) <= func.narg );
                    
                    for path in arguments_references_paths do
                        
                        # check if <path> points to the first (and only) argument of a function call calling the attribute getter
                        
                        parent := CapJitGetNodeByPath( func, path{[ 1 .. Length( path ) - 2 ]} );
                        
                        if EndsWith( path, [ "args", "1" ] ) and CapJitIsCallToGlobalFunction( parent, attribute_name ) and parent.args.length = 1 then
                            
                            Assert( 0, parent.args.1.type = "EXPR_REF_FVAR" );
                            Assert( 0, parent.args.1.func_id = func.id );
                            
                            # set parent := parent.args.1, but inplace
                            parent.type := parent.args.1.type;
                            parent.func_id := parent.args.1.func_id;
                            parent.name := parent.args.1.name;
                            Unbind( parent.funcref );
                            Unbind( parent.args );
                            
                        else
                            
                            # we cannot optimize because the variable is used in a way different from simply accessing the attribute
                            return tree;
                            
                        fi;
                        
                    od;
                    
                od;
                
                # wrap initial_value in a call to the attribute
                if initial_value_index in list_values_indices then
                
                    new_initial_value := rec(
                        type := "EXPR_FUNCCALL",
                        funcref := rec(
                            type := "EXPR_REF_GVAR",
                            gvar := "List",
                        ),
                        args := AsSyntaxTreeList( [
                            initial_value,
                            rec(
                                type := "EXPR_REF_GVAR",
                                gvar := attribute_name,
                            )
                        ] ),
                    );
                    
                else
                    
                    new_initial_value := rec(
                        type := "EXPR_FUNCCALL",
                        funcref := rec(
                            type := "EXPR_REF_GVAR",
                            gvar := attribute_name,
                        ),
                        args := AsSyntaxTreeList( [
                            initial_value,
                        ] ),
                    );
                    
                fi;
                
                # wrap additional values in a call to the attribute
                
                new_additional_values := [ ];
                
                for i in [ 1 .. Length( additional_values_indices ) ] do
                    
                    if additional_values_indices[i] in list_values_indices then
                        
                        new_additional_values[i] := rec(
                            type := "EXPR_FUNCCALL",
                            funcref := rec(
                                type := "EXPR_REF_GVAR",
                                gvar := "List",
                            ),
                            args := AsSyntaxTreeList( [
                                additional_values.(i),
                                rec(
                                    type := "EXPR_REF_GVAR",
                                    gvar := attribute_name,
                                )
                            ] ),
                        );
                        
                    else
                        
                        # COVERAGE_IGNORE_NEXT_LINE
                        Error( "this case is currently not used and thus commented" );
                        #new_additional_values[i] := rec(
                            #type := "EXPR_FUNCCALL",
                            #funcref := rec(
                                #type := "EXPR_REF_GVAR",
                                #gvar := attribute_name,
                            #),
                            #args := AsSyntaxTreeList( [
                                #additional_values.(i),
                            #] ),
                        #);
                        
                    fi;
                    
                od;
                
                # form new args by collecting the variables set above
                new_args := [ ];
                new_args[result_func_index] := new_func;
                new_args[initial_value_index] := new_initial_value;
                
                for i in [ 1 .. Length( additional_funcs_indices ) ] do
                    
                    new_args[additional_funcs_indices[i]] := new_additional_funcs.(i);
                    
                od;
                
                for i in [ 1 .. Length( additional_values_indices ) ] do
                    
                    new_args[additional_values_indices[i]] := new_additional_values[i];
                    
                od;
                
                new_args := AsSyntaxTreeList( new_args );
                
                # create new tree
                if return_obj.funcref.gvar = "CreateCapCategoryObjectWithAttributes" then
                    
                    # func call to CreateCapCategoryObjectWithAttributes
                    new_tree := rec(
                        type := "EXPR_FUNCCALL",
                        funcref := rec(
                            type := "EXPR_REF_GVAR",
                            gvar := "CreateCapCategoryObjectWithAttributes"
                        ),
                        args := AsSyntaxTreeList( [
                            # the category
                            return_obj.args.1,
                            # the attribute
                            return_obj.args.2,
                            # the func call with new args
                            rec(
                                type := "EXPR_FUNCCALL",
                                funcref := tree.funcref,
                                args := new_args,
                            ),
                        ] ),
                    );
                    
                elif return_obj.funcref.gvar = "CreateCapCategoryMorphismWithAttributes" then
                    
                    if case = "from_initial_value" then
                        
                        if initial_value_index in list_values_indices then
                            
                            initial_value_morphism := rec(
                                type := "EXPR_FUNCCALL",
                                funcref := rec(
                                    type := "EXPR_REF_GVAR",
                                    gvar := "[]",
                                ),
                                args := AsSyntaxTreeList( [
                                    initial_value,
                                    rec(
                                        type := "EXPR_INT",
                                        value := 1,
                                    ),
                                ] ),
                            );
                            
                        else
                            
                            initial_value_morphism := initial_value;
                            
                        fi;
                        
                        # func call to CreateCapCategoryMorphismWithAttributes
                        new_tree := rec(
                            type := "EXPR_FUNCCALL",
                            funcref := rec(
                                type := "EXPR_REF_GVAR",
                                gvar := "CreateCapCategoryMorphismWithAttributes"
                            ),
                            args := AsSyntaxTreeList( [
                                # the category
                                return_obj.args.1,
                                # the source
                                rec(
                                    type := "EXPR_FUNCCALL",
                                    funcref := rec(
                                        type := "EXPR_REF_GVAR",
                                        gvar := "Source",
                                    ),
                                    args := AsSyntaxTreeList( [
                                        CapJitCopyWithNewFunctionIDs( initial_value_morphism )
                                    ] ),
                                ),
                                # the range
                                rec(
                                    type := "EXPR_FUNCCALL",
                                    funcref := rec(
                                        type := "EXPR_REF_GVAR",
                                        gvar := "Range",
                                    ),
                                    args := AsSyntaxTreeList( [
                                        CapJitCopyWithNewFunctionIDs( initial_value_morphism )
                                    ] ),
                                ),
                                # the attribute
                                return_obj.args.4,
                                # the func call with new args
                                rec(
                                    type := "EXPR_FUNCCALL",
                                    funcref := tree.funcref,
                                    args := new_args,
                                ),
                            ] ),
                        );
                        
                    elif case = "global_variables" then
                        
                        # func call to CreateCapCategoryMorphismWithAttributes
                        new_tree := rec(
                            type := "EXPR_FUNCCALL",
                            funcref := rec(
                                type := "EXPR_REF_GVAR",
                                gvar := "CreateCapCategoryMorphismWithAttributes"
                            ),
                            args := AsSyntaxTreeList( [
                                # the category
                                return_obj.args.1,
                                # the source
                                source,
                                # the range
                                range,
                                # the attribute
                                return_obj.args.4,
                                # the func call with new args
                                rec(
                                    type := "EXPR_FUNCCALL",
                                    funcref := tree.funcref,
                                    args := new_args,
                                ),
                            ] ),
                        );
                        
                    elif case = "from_compiler_hints" then
                        
                        # call to anonymous function because we want to reuse the morphism attribute for creating the objects
                        new_tree := rec(
                            type := "EXPR_FUNCCALL",
                            funcref := rec(
                                type := "EXPR_DECLARATIVE_FUNC",
                                id := CAP_JIT_INTERNAL_FUNCTION_ID,
                                nams := [
                                    "cap_jit_morphism_attribute",
                                    "RETURN_VALUE",
                                ],
                                narg := 0,
                                variadic := false,
                                bindings := rec(
                                    type := "FVAR_BINDING_SEQ",
                                    names := [ "cap_jit_morphism_attribute", "RETURN_VALUE" ],
                                    BINDING_cap_jit_morphism_attribute := rec(
                                        type := "EXPR_FUNCCALL",
                                        funcref := tree.funcref,
                                        args := new_args,
                                    ),
                                    BINDING_RETURN_VALUE := rec(
                                        type := "EXPR_FUNCCALL",
                                        funcref := rec(
                                            gvar := "CreateCapCategoryMorphismWithAttributes",
                                            type := "EXPR_REF_GVAR",
                                        ),
                                        args := AsSyntaxTreeList( [
                                            # the category
                                            return_obj.args.1,
                                            # the source
                                            rec(
                                                type := "EXPR_FUNCCALL",
                                                funcref := rec(
                                                    type := "EXPR_REF_GVAR",
                                                    gvar := "CreateCapCategoryObjectWithAttributes",
                                                ),
                                                args := AsSyntaxTreeList( [
                                                    # the category
                                                    return_obj.args.1,
                                                    # the object attribute
                                                    rec(
                                                        type := "EXPR_REF_GVAR",
                                                        gvar := cat!.compiler_hints.source_and_range_attributes_from_morphism_attribute.object_attribute_name,
                                                    ),
                                                    # the attribute value
                                                    rec(
                                                        type := "EXPR_FUNCCALL",
                                                        funcref := rec(
                                                            type := "EXPR_REF_GVAR",
                                                            gvar := cat!.compiler_hints.source_and_range_attributes_from_morphism_attribute.source_attribute_getter_name,
                                                        ),
                                                        args := AsSyntaxTreeList( [
                                                            rec(
                                                                type := "EXPR_REF_FVAR",
                                                                func_id := CAP_JIT_INTERNAL_FUNCTION_ID,
                                                                name := "cap_jit_morphism_attribute",
                                                            ),
                                                        ] ),
                                                    ),
                                                ] ),
                                            ),
                                            # the range
                                            rec(
                                                type := "EXPR_FUNCCALL",
                                                funcref := rec(
                                                    type := "EXPR_REF_GVAR",
                                                    gvar := "CreateCapCategoryObjectWithAttributes",
                                                ),
                                                args := AsSyntaxTreeList( [
                                                    # the category
                                                    return_obj.args.1,
                                                    # the object attribute
                                                    rec(
                                                        type := "EXPR_REF_GVAR",
                                                        gvar := cat!.compiler_hints.source_and_range_attributes_from_morphism_attribute.object_attribute_name,
                                                    ),
                                                    # the attribute value
                                                    rec(
                                                        type := "EXPR_FUNCCALL",
                                                        funcref := rec(
                                                            type := "EXPR_REF_GVAR",
                                                            gvar := cat!.compiler_hints.source_and_range_attributes_from_morphism_attribute.range_attribute_getter_name,
                                                        ),
                                                        args := AsSyntaxTreeList( [
                                                            rec(
                                                                type := "EXPR_REF_FVAR",
                                                                func_id := CAP_JIT_INTERNAL_FUNCTION_ID,
                                                                name := "cap_jit_morphism_attribute",
                                                            ),
                                                        ] ),
                                                    ),
                                                ] ),
                                            ),
                                            # the attribute
                                            return_obj.args.4,
                                            # cap_jit_morphism_attribute
                                            rec(
                                                type := "EXPR_REF_FVAR",
                                                func_id := CAP_JIT_INTERNAL_FUNCTION_ID,
                                                name := "cap_jit_morphism_attribute",
                                            ),
                                        ] ),
                                    ),
                                ),
                            ),
                            args := AsSyntaxTreeList( [ ] ),
                        );
                        CAP_JIT_INTERNAL_FUNCTION_ID := CAP_JIT_INTERNAL_FUNCTION_ID + 1;
                        
                    else
                        
                        # COVERAGE_IGNORE_NEXT_LINE
                        Error( "this should never happen" );
                        
                    fi;
                    
                else
                    
                    # COVERAGE_IGNORE_NEXT_LINE
                    Error( "this should never happen" );
                    
                fi;
                
                return new_tree;
                
            fi;
            
        fi;
        
    fi;
    
    return tree;
    
end );

# CapFixpoint
CapJitAddLogicFunction( function ( tree )
  local pre_func;
    
    Info( InfoCapJit, 1, "####" );
    Info( InfoCapJit, 1, "Apply logic for CapFixpoint." );
    
    pre_func := function ( tree, additional_arguments )
      local args;
        
        if CapJitIsCallToGlobalFunction( tree, "CapFixpoint" ) then
            
            args := tree.args;
            
            Assert( 0, args.length = 3 );
            
            return CAP_JIT_INTERNAL_TELESCOPED_ITERATION( tree, 2, [ 1 ], 3, [ ], [ ] );
            
        fi;
        
        return tree;
        
    end;
    
    return CapJitIterateOverTree( tree, pre_func, CapJitResultFuncCombineChildren, ReturnTrue, true );
    
end );

# Iterated
CapJitAddLogicFunction( function ( tree )
  local pre_func;
    
    Info( InfoCapJit, 1, "####" );
    Info( InfoCapJit, 1, "Apply logic for Iterated." );
    
    pre_func := function ( tree, additional_arguments )
      local args, list, func, entries, new_tree, i;
        
        if CapJitIsCallToGlobalFunction( tree, "Iterated" ) then
            
            args := tree.args;
            
            Assert( 0, args.length = 2 or args.length = 3 );
            
            list := args.1;
            func := args.2;
            
            if list.type = "EXPR_LIST" then
                
                entries := list.list;
                
                # if we have an initial value, preprend it to the entries
                if args.length = 3 then
                    
                    entries := ConcatenationForSyntaxTreeLists( AsSyntaxTreeList( [ args.3 ] ), entries );
                    
                fi;
                
                Assert( 0, entries.length > 0 );
                
                new_tree := entries.1;
                
                for i in [ 2 .. entries.length ] do
                    
                    new_tree := rec(
                        type := "EXPR_FUNCCALL",
                        funcref := CapJitCopyWithNewFunctionIDs( func ),
                        args := AsSyntaxTreeList( [
                            new_tree,
                            entries.(i)
                        ] ),
                    );
                    
                od;
                
                return new_tree;
                
            else
                
                if args.length = 2 then
                    
                    return CAP_JIT_INTERNAL_TELESCOPED_ITERATION( tree, 2, [ ], 1, [ ], [ 1 ] );
                    
                elif args.length = 3 then
                    
                    return CAP_JIT_INTERNAL_TELESCOPED_ITERATION( tree, 2, [ ], 3, [ 1 ], [ 1 ] );
                    
                else
                    
                    # COVERAGE_IGNORE_NEXT_LINE
                    Error( "this should never happen" );
                    
                fi;
                
            fi;
            
        fi;
        
        return tree;
        
    end;
    
    return CapJitIterateOverTree( tree, pre_func, CapJitResultFuncCombineChildren, ReturnTrue, true );
    
end );
