# SPDX-License-Identifier: GPL-2.0-or-later
# CompilerForCAP: Speed up and verify categorical algorithms
#
# Implementations
#

InstallGlobalFunction( "CAP_JIT_INTERNAL_GET_DATA_TYPE_OF_VALUE", function ( value )
  local element_types, element_type, filters, i;
    
    if value = fail then
        
        # we do not want to give fail a type yet
        return fail;
        
    fi;
    
    if IsList( value ) then
        
        if Length( value ) = 0 then
            
            return "list_with_unknown_element_type";
            
        fi;
        
        element_types := List( value, v -> CAP_JIT_INTERNAL_GET_DATA_TYPE_OF_VALUE( v ) );
        
        if ForAll( element_types, type -> type = "list_with_unknown_element_type" ) then
            
            return "list_with_unknown_element_type";
            
        fi;
        
        element_type := First( element_types, type -> type <> fail and type <> "list_with_unknown_element_type" );
        
        if element_type = fail then
            
            return fail;
            
        fi;
        
        if element_type.filter = IsList then
            
            # if some elements are list with unknown element types, use the element_type determined above
            for i in [ 1 .. Length( value ) ] do
                
                if IsList( value[i] ) and element_types[i] = "list_with_unknown_element_type" then
                    
                    element_types[i] := element_type;
                    
                fi;
                
            od;
            
        fi;
        
        if not ForAll( element_types, type -> type = element_type ) then
            
            #Error( "the list is not homogeneous, this is not supported" );
            return fail;
            
        fi;
        
        return CapJitDataTypeOfListOf( element_type );
        
    fi;
    
    if IsCapCategory( value ) then
        
        return CapJitDataTypeOfCategory( value );
        
    elif IsCapCategoryObject( value ) then
        
        return CapJitDataTypeOfObjectOfCategory( CapCategory( value ) );
        
    elif IsCapCategoryMorphism( value ) then
        
        return CapJitDataTypeOfMorphismOfCategory( CapCategory( value ) );
        
    elif IsRing( value ) then
        
        return CapJitDataTypeOfRing( value );
        
    elif IsFunction( value ) then
        
        # signature has to be set from somewhere else
        return rec( filter := IsFunction );
        
    else
        
        return fail;
        
    fi;
    
end );

InstallGlobalFunction( "CAP_JIT_INTERNAL_GET_OUTPUT_TYPE_OF_GLOBAL_FUNCTION_BY_INPUT_TYPES", function ( gvar, input_types )
  local input_filters, info, pos, category, type_signatures, output_type;
    
    # normalize to the "official" name
    gvar := NameFunction( ValueGlobal( gvar ) );
    
    input_filters := List( input_types, type -> type.filter );
    
    if IsCategory( ValueGlobal( gvar ) ) and Length( input_filters ) = 1 then
        
        return rec( filter := IsBool );
        
    fi;
    
    if IsBound( CAP_INTERNAL_METHOD_NAME_RECORD.(gvar) ) then
        
        info := CAP_INTERNAL_METHOD_NAME_RECORD.(gvar);
        
        if IsSpecializationOfFilterList( info.filter_list, input_filters ) then
            
            Assert( 0, info.filter_list[1] = "category" );
            
            return CAP_INTERNAL_GET_DATA_TYPE_FROM_STRING( info.return_type, input_types[1].category );
            
        elif info.install_convenience_without_category and IsSpecializationOfFilterList( info.filter_list{[ 2 .. Length( info.filter_list ) ]}, input_filters ) then
            
            pos := PositionProperty( info.filter_list, filter_string -> filter_string in [ "object", "morphism", "twocell", "list_of_objects", "list_of_morphisms", "list_of_twocells" ] );
            
            if pos <> fail then
                
                if StartsWith( info.filter_list[pos], "list_of_" ) then
                    
                    category := input_types[pos - 1].element_type.category;
                    
                else
                    
                    category := input_types[pos - 1].category;
                    
                fi;
                
                return CAP_INTERNAL_GET_DATA_TYPE_FROM_STRING( info.return_type, category );
                
            fi;
            
        fi;
        
    fi;
    
    if not IsBound( CAP_JIT_INTERNAL_TYPE_SIGNATURES.(gvar) ) then
        
        DisplayWithCurrentlyCompiledFunctionLocation( Concatenation( "WARNING: Could not find declaration of ", gvar, " (current input: ", String( input_filters ), ")" ) );
        return fail;
        
    fi;
    
    type_signatures := Filtered( CAP_JIT_INTERNAL_TYPE_SIGNATURES.(gvar), s -> IsSpecializationOfFilterList( s[1], input_filters ) );
    
    if Length( type_signatures ) = 0 then
        
        ErrorWithCurrentlyCompiledFunctionLocation( Concatenation( "WARNING: Could not find matching declaration of ", gvar, " for input ", String( input_filters ) ) );
        return fail;
        
    elif Length( type_signatures ) > 1 then
        
        # COVERAGE_IGNORE_NEXT_LINE
        ErrorWithCurrentlyCompiledFunctionLocation( "Found multiple matching declarations of ", gvar, " for input ", input_filters );
        
    fi;
    
    output_type := type_signatures[1][2];
    
    if IsFunction( output_type ) and NumberArgumentsFunction( output_type ) = 1 then
        
        output_type := output_type( input_types );
        
        if output_type = fail then
            
            #Error( "could not get output_type" );
            return fail;
            
        fi;
        
        Assert( 0, IsBound( output_type.filter ) );
        
    fi;
    
    return output_type;
    
end );

InstallGlobalFunction( "CAP_JIT_INTERNAL_INFERRED_DATA_TYPES_OF_FUNCTION_BY_ARGUMENTS", function ( funcref, args, func_stack )
  local arguments_types, output_type, result, func;
    
    arguments_types := List( AsListMut( args ), a -> a.data_type );
    
    if funcref.type = "EXPR_REF_GVAR" then
        
        output_type := CAP_JIT_INTERNAL_GET_OUTPUT_TYPE_OF_GLOBAL_FUNCTION_BY_INPUT_TYPES( funcref.gvar, arguments_types );
        
        if output_type = fail then
            
            #Error( "could not get output_type" );
            return fail;
            
        fi;
        
        if IsFunction( output_type ) then
            
            result := output_type( args, func_stack );
            
            if result = fail then
                
                #Error( "could not get output_type" );
                return fail;
                
            fi;
            
            args := result.args;
            output_type := result.output_type;
            
        fi;
        
        Assert( 0, IsRecord( output_type ) );
        
        funcref := ShallowCopy( funcref );
        funcref.data_type := rec( filter := IsFunction, signature := [ List( AsListMut( args ), a -> a.data_type ), output_type ] );
        
        return rec( funcref := funcref, args := args, output_type := output_type );
        
    elif funcref.type = "EXPR_DECLARATIVE_FUNC" then
        
        func := ShallowCopy( funcref );
        
        if func.variadic then
            
            #Error( "cannot handle variadic functions yet" );
            return fail;
            
        fi;
        
        if func.narg <> Length( arguments_types ) then
            
            # COVERAGE_IGNORE_NEXT_LINE
            ErrorWithCurrentlyCompiledFunctionLocation( "applying literal function to a wrong number of arguments" );
            
        fi;
        
        func.data_type := rec( filter := IsFunction, signature := [ arguments_types, fail ] );
        
        func := CAP_JIT_INTERNAL_INFERRED_DATA_TYPES( func, func_stack );
        
        if not IsBound( func.data_type ) or func.data_type.signature[2] = fail then
            
            #Error( "could not determine data type of return value of function" );
            return fail;
            
        fi;
        
        return rec( funcref := func, args := args, output_type := func.data_type.signature[2] );
        
    else
        
        #Error( "can only handle EXPR_DECLARATIVE_FUNC and EXPR_REF_GVAR" );
        return fail;
        
    fi;
    
end );

InstallGlobalFunction( "CAP_JIT_INTERNAL_INFERRED_DATA_TYPES_OF_FUNCTION_BY_ARGUMENTS_TYPES", function ( funcref, arguments_types, func_stack )
  local output_type, func;
    
    if funcref.type = "EXPR_REF_GVAR" then
        
        output_type := CAP_JIT_INTERNAL_GET_OUTPUT_TYPE_OF_GLOBAL_FUNCTION_BY_INPUT_TYPES( funcref.gvar, arguments_types );
        
        if output_type = fail then
            
            #Error( "could not get output_type" );
            return fail;
            
        fi;
        
        if IsFunction( output_type ) then
            
            #Error( "cannot infer parametric output type by arguments types only" );
            return fail;
            
        fi;
        
        Assert( 0, IsRecord( output_type ) );
        
        funcref := ShallowCopy( funcref );
        funcref.data_type := rec( filter := IsFunction, signature := [ arguments_types, output_type ] );
        
        return funcref;
        
    elif funcref.type = "EXPR_DECLARATIVE_FUNC" then
        
        func := ShallowCopy( funcref );
        func.data_type := rec( filter := IsFunction, signature := [ arguments_types, fail ] );
        
        func := CAP_JIT_INTERNAL_INFERRED_DATA_TYPES( func, func_stack );
        
        if not IsBound( func.data_type ) or func.data_type.signature[2] = fail then
            
            #Error( "could not determine data type of return value of function" );
            return fail;
            
        fi;
        
        return func;
        
    else
        
        #Error( "can only handle EXPR_DECLARATIVE_FUNC and EXPR_REF_GVAR" );
        return fail;
        
    fi;
    
end );

InstallGlobalFunction( CAP_JIT_INTERNAL_INFERRED_DATA_TYPES, function ( tree, initial_func_stack )
  local pre_func, result_func, additional_arguments_func;
    
    pre_func := function ( tree, func_stack )
        
        if tree.type = "EXPR_FUNCCALL" then
            
            # manual iteration in result_func
            return fail;
            
        fi;
        
        return tree;
        
    end;
    
    result_func := function ( tree, result, keys, func_stack )
      local typed_args, positions, name, rec_name, data_type, filter, func, pos, value, key, i;
        
        tree := ShallowCopy( tree );
        
        if tree.type = "EXPR_FUNCCALL" then
            
            # get data types of all arguments
            typed_args := List( tree.args, function ( a )
                
                if a.type = "EXPR_DECLARATIVE_FUNC" then
                    
                    if not IsBound( a.data_type ) then
                    
                        a := ShallowCopy( a );
                        
                        # signature has to be set from somewhere else
                        a.data_type := rec( filter := IsFunction );
                        
                    fi;
                    
                    return a;
                    
                else
                    
                    return CAP_JIT_INTERNAL_INFERRED_DATA_TYPES( a, func_stack );
                    
                fi;
                
            end );
            
            if ForAny( typed_args, a -> not IsBound( a.data_type ) ) then
                
                #Error( "could not determine data_type of all arguments" );
                # there might already be a data type set, but we want to avoid partial typings -> unbind
                Unbind( tree.data_type );
                return tree;
                
            fi;
            
            result := CAP_JIT_INTERNAL_INFERRED_DATA_TYPES_OF_FUNCTION_BY_ARGUMENTS( tree.funcref, typed_args, func_stack );
            
            if result = fail then
                
                #Error( "could not get output_type" );
                # there might already be a data type set, but we want to avoid partial typings -> unbind
                Unbind( tree.data_type );
                return tree;
                
            fi;
            
            Assert( 0, IsRecord( result.output_type ) );
            
            # check if the signatures of all functions could be determined
            if ForAny( result.args, a -> a.type = "EXPR_DECLARATIVE_FUNC" and not IsBound( a.data_type.signature ) ) then
                
                #Error( "could not determine signature of a function argument" );
                # there might already be a data type set, but we want to avoid partial typings -> unbind
                Unbind( tree.data_type );
                return tree;
                
            fi;
            
            tree.funcref := result.funcref;
            tree.args := result.args;
            tree.data_type := result.output_type;
            
            return tree;
            
        fi;
        
        for key in keys do
            
            tree.(key) := result.(key);
            
        od;
        
        if ForAny( keys, key -> not IsBound( result.(key).data_type ) ) then
            
            #Error( "could not determine data_type of all children" );
            # there might already be a data type set, but we want to avoid partial typings -> unbind
            Unbind( tree.data_type );
            return tree;
            
        fi;
        
        # only expression have proper data types
        # we still set one to signal that all children have data types set
        if not StartsWith( tree.type, "EXPR_" ) then
            
            tree.data_type := LowercaseString( tree.type );
            return tree;
            
        fi;
        
        if tree.type = "EXPR_INT" then
            
            data_type := rec( filter := IsSmallIntRep );
            
        elif tree.type = "EXPR_STRING" then
            
            data_type := rec( filter := IsStringRep );
            
        elif tree.type = "EXPR_CHAR" then
            
            data_type := rec( filter := IsChar );
            
        elif tree.type = "EXPR_TRUE" then
            
            data_type := rec( filter := IsBool );
            
        elif tree.type = "EXPR_FALSE" then
            
            data_type := rec( filter := IsBool );
            
        elif tree.type = "EXPR_EQ" then
            
            data_type := rec( filter := IsBool );
            
        elif tree.type = "EXPR_NE" then
            
            data_type := rec( filter := IsBool );
            
        elif tree.type = "EXPR_LE" then
            
            data_type := rec( filter := IsBool );
            
        elif tree.type = "EXPR_GE" then
            
            data_type := rec( filter := IsBool );
            
        elif tree.type = "EXPR_LT" then
            
            data_type := rec( filter := IsBool );
            
        elif tree.type = "EXPR_GT" then
            
            data_type := rec( filter := IsBool );
            
        elif tree.type = "EXPR_NOT" then
            
            Assert( 0, tree.op.data_type.filter = IsBool );
            
            data_type := rec( filter := IsBool );
            
        elif tree.type = "EXPR_AND" then
            
            Assert( 0, tree.left.data_type.filter = IsBool );
            Assert( 0, tree.right.data_type.filter = IsBool );
            
            data_type := rec( filter := IsBool );
            
        elif tree.type = "EXPR_OR" then
            
            Assert( 0, tree.left.data_type.filter = IsBool );
            Assert( 0, tree.right.data_type.filter = IsBool );
            
            data_type := rec( filter := IsBool );
            
        elif tree.type = "EXPR_IN" then
            
            data_type := rec( filter := IsBool );
            
        elif tree.type = "EXPR_REC" then
            
            data_type := rec( filter := IsRecord );
            
        elif tree.type = "EXPR_CASE" then
            
            if not ForAll( tree.branches, branch -> branch.condition.data_type.filter = IsBool ) then
                
                ErrorWithCurrentlyCompiledFunctionLocation( "a condition of the case expression is not a boolean" );
                
            fi;
            
            if not ForAll( tree.branches, branch -> branch.value.data_type = tree.branches.1.value.data_type ) then
                
                #Error( "the branches of the case expression are of different types, this is not supported" );
                # there might already be a data type set, but we want to avoid partial typings -> unbind
                Unbind( tree.data_type );
                return tree;
                
            fi;
            
            data_type := tree.branches.1.value.data_type;
            
        elif tree.type = "EXPR_RANGE" then
            
            # TODO
            data_type := CapJitDataTypeOfListOf( IsInt );
            
        elif tree.type = "EXPR_LIST" then
            
            if tree.list.length = 0 then
                
                if IsBound( tree.data_type ) then
                    
                    data_type := tree.data_type;
                    
                else
                    
                    # COVERAGE_IGNORE_BLOCK_START
                    PrintWithCurrentlyCompiledFunctionLocation( "WARNING: found empty list without data type. Make sure to use CapJitTypedExpression for manually written code and to properly set data types in logic functions creating empty lists." );
                    
                    return tree;
                    # COVERAGE_IGNORE_BLOCK_END
                    
                fi;
                
            else
                
                if not ForAll( tree.list, element -> element.data_type = tree.list.1.data_type ) then
                    
                    # COVERAGE_IGNORE_BLOCK_START
                    Display( "WARNING: list is not homogeneous, this is not supported. Use `NTuple` or its convenience aliases instead. The filters of the element types are:" );
                    DisplayWithCurrentlyCompiledFunctionLocation( List( AsListMut( tree.list ), element -> element.data_type.filter ) );
                    # there might already be a data type set, but we want to avoid partial typings -> unbind
                    Unbind( tree.data_type );
                    return tree;
                    # COVERAGE_IGNORE_BLOCK_END
                    
                fi;
                
                data_type := CapJitDataTypeOfListOf( tree.list.1.data_type );
                
            fi;
            
        elif tree.type = "EXPR_REF_GVAR" then
            
            if IsBound( tree.data_type ) then
                
                data_type := CAP_JIT_INTERNAL_GET_DATA_TYPE_OF_VALUE( ValueGlobal( tree.gvar ) );
                
                if data_type <> fail then
                    
                    if (data_type.filter = IsFunction and tree.data_type.filter <> IsFunction) or (data_type.filter <> IsFunction and data_type <> tree.data_type) then
                        
                        DisplayWithCurrentlyCompiledFunctionLocation( Concatenation( "the data type ", String( tree.data_type ), " of gvar ", tree.gvar, " differs from the automatically detected data type ", String( data_type ) ) );
                        
                    fi;
                    
                    data_type := tree.data_type;
                    
                fi;
                
                data_type := tree.data_type;
                
            else
                
                data_type := CAP_JIT_INTERNAL_GET_DATA_TYPE_OF_VALUE( ValueGlobal( tree.gvar ) );
                
                if data_type = fail or data_type = "list_with_unknown_element_type" then
                    
                    # "fail" explicitly has no type yet
                    if ValueGlobal( tree.gvar ) <> fail then
                        
                        DisplayWithCurrentlyCompiledFunctionLocation( Concatenation( "could not get type of gvar ", tree.gvar ) );
                        
                    fi;
                    
                    # there might already be a data type set, but we want to avoid partial typings -> unbind
                    Unbind( tree.data_type );
                    return tree;
                    
                fi;
                
            fi;
            
        elif tree.type = "EXPR_REF_FVAR" then
            
            func := SafeUniqueEntry( func_stack, func -> func.id = tree.func_id );
            
            if func.variadic then
                
                #Error( "cannot handle variadic functions yet" );
                # there might already be a data type set, but we want to avoid partial typings -> unbind
                Unbind( tree.data_type );
                return tree;
                
            fi;
            
            pos := SafeUniquePosition( func.nams, tree.name );
            
            if pos <= func.narg then
                
                if not IsBound( func.data_type ) then
                    
                    #Error( "function does not have a data type yet" );
                    # there might already be a data type set, but we want to avoid partial typings -> unbind
                    Unbind( tree.data_type );
                    return tree;
                    
                fi;
                
                data_type := func.data_type.signature[1][pos];
                
            else
                
                # due to using CapJitIterateOverTreeWithCachedBindingResults, `result` should be a syntax tree
                Assert( 0, IsBound( result.type ) );
                
                if IsBound( result.data_type ) then
                    
                    data_type := result.data_type;
                    
                else
                    
                    #Error( "could not compute data type of binding" );
                    # there might already be a data type set, but we want to avoid partial typings -> unbind
                    Unbind( tree.data_type );
                    return tree;
                    
                fi;
                
            fi;
            
        elif tree.type = "EXPR_DECLARATIVE_FUNC" then
            
            if IsBound( tree.data_type ) then
                
                Assert( 0, tree.data_type.filter = IsFunction );
                
                if IsBound( tree.bindings.BINDING_RETURN_VALUE.data_type ) then
                    
                    if tree.data_type.signature[2] = fail then
                        
                        data_type := rec( filter := IsFunction, signature := [ tree.data_type.signature[1], tree.bindings.BINDING_RETURN_VALUE.data_type ] );
                        
                    else
                        
                        Assert( 0, tree.bindings.BINDING_RETURN_VALUE.data_type = tree.data_type.signature[2] );
                        
                        data_type := tree.data_type;
                        
                    fi;
                    
                else
                    
                    #Error( "could not determine data type of return value" );
                    # there might already be a data type set, but we want to avoid partial typings -> unbind
                    Unbind( tree.data_type );
                    return tree;
                    
                fi;
                
            else
                
                #Error( "EXPR_DECLARATIVE_FUNC cannot be handled without input types" );
                return tree;
                
            fi;
            
        else
            
            DisplayWithCurrentlyCompiledFunctionLocation( Concatenation( "Cannot compute data type for syntax tree type ", tree.type, " yet." ) );
            # there might already be a data type set, but we want to avoid partial typings -> unbind
            Unbind( tree.data_type );
            return tree;
            
        fi;
        
        Assert( 0, IsRecord( data_type ) );
        
        tree.data_type := data_type;
        
        return tree;
        
    end;
    
    additional_arguments_func := function ( tree, key, func_stack )
        
        if tree.type = "EXPR_DECLARATIVE_FUNC" then
            
            return Concatenation( func_stack, [ tree ] );
            
        else
            
            return func_stack;
            
        fi;
        
    end;
    
    return CapJitIterateOverTreeWithCachedBindingResults( tree, pre_func, result_func, additional_arguments_func, initial_func_stack );
    
end );

InstallGlobalFunction( CapJitInferredDataTypes, function ( tree )
  local orig_data_type;
    
    if tree.type <> "EXPR_DECLARATIVE_FUNC" then
        
        # COVERAGE_IGNORE_NEXT_LINE
        ErrorWithCurrentlyCompiledFunctionLocation( "CapJitInferredDataTypes can only be applied to enhanced syntax trees of functions" );
        
    fi;
    
    if not CAP_JIT_DATA_TYPE_INFERENCE_ENABLED then
        
        return tree;
        
    fi;
    
    if not IsBound( tree.data_type ) then
        
        return tree;
        
    fi;
    
    orig_data_type := tree.data_type;
    
    tree := CAP_JIT_INTERNAL_INFERRED_DATA_TYPES( tree, [ ] );
    
    # The tree might lose its type because we avoid partial typings.
    # However, in many cases it can be typed later in the compilation process (after inlining etc.).
    # Thus, we add the type back manually here.
    if not IsBound( tree.data_type ) then
        
        tree.data_type := orig_data_type;
        
    fi;
    
    return tree;
    
end );

# type signatures

CapJitAddTypeSignature( "CapFixpoint", [ IsFunction, IsFunction, IsObject ], function ( args, func_stack )
    
    args := ShallowCopy( args );
    
    args.1 := CAP_JIT_INTERNAL_INFERRED_DATA_TYPES_OF_FUNCTION_BY_ARGUMENTS_TYPES( args.1, [ args.3.data_type, args.3.data_type ], func_stack );
    args.2 := CAP_JIT_INTERNAL_INFERRED_DATA_TYPES_OF_FUNCTION_BY_ARGUMENTS_TYPES( args.2, [ args.3.data_type ], func_stack );
    
    if args.1 = fail or args.2 = fail then
        
        #Error( "could not determine output type" );
        return fail;
        
    fi;
    
    Assert( 0, args.1.data_type.signature[2].filter = IsBool );
    Assert( 0, args.2.data_type.signature[2] = args.3.data_type );
    
    return rec( args := args, output_type := args.3.data_type );
    
end );

# creating CAP category objects and morphisms
CapJitAddTypeSignature( "CreateCapCategoryObjectWithAttributes", "any", function ( input_types )
    
    Assert( 0, Length( input_types ) >= 1 );
    Assert( 0, IsOddInt( Length( input_types ) ) );
    Assert( 0, IsSpecializationOfFilter( IsCapCategory, input_types[1].filter ) );
    Assert( 0, ForAll( [ 2, 4 .. Length( input_types ) - 1 ], i -> IsSpecializationOfFilter( IsFunction, input_types[i].filter ) ) );
    
    return CapJitDataTypeOfObjectOfCategory( input_types[1].category );
    
end );

CapJitAddTypeSignature( "CreateCapCategoryMorphismWithAttributes", "any", function ( input_types )
    
    Assert( 0, Length( input_types ) >= 3 );
    Assert( 0, IsOddInt( Length( input_types ) ) );
    Assert( 0, IsSpecializationOfFilter( IsCapCategory, input_types[1].filter ) );
    Assert( 0, IsSpecializationOfFilter( IsCapCategoryObject, input_types[2].filter ) );
    Assert( 0, IsSpecializationOfFilter( IsCapCategoryObject, input_types[3].filter ) );
    Assert( 0, ForAll( [ 4, 6 .. Length( input_types ) - 1 ], i -> IsSpecializationOfFilter( IsFunction, input_types[i].filter ) ) );
    
    return CapJitDataTypeOfMorphismOfCategory( input_types[1].category );
    
end );

CapJitAddTypeSignature( "AsCapCategoryObject", [ IsCapCategory, IsObject ], function ( input_types )
  local category;
    
    category := input_types[1].category;
    
    Assert( 0, input_types[2] = CAP_INTERNAL_GET_DATA_TYPE_FROM_STRING( "object_datum", category ) );
    
    return CapJitDataTypeOfObjectOfCategory( input_types[1].category );
    
end );

CapJitAddTypeSignature( "AsCapCategoryMorphism", [ IsCapCategory, IsCapCategoryObject, IsObject, IsCapCategoryObject ], function ( input_types )
  local category;
    
    category := input_types[1].category;
    
    Assert( 0, IsIdenticalObj( input_types[2].category, category ) );
    Assert( 0, IsIdenticalObj( input_types[4].category, category ) );
    Assert( 0, input_types[3] = CAP_INTERNAL_GET_DATA_TYPE_FROM_STRING( "morphism_datum", category ) );
    
    return CapJitDataTypeOfMorphismOfCategory( input_types[1].category );
    
end );

CapJitAddTypeSignature( "AsInteger", [ IsCapCategoryObject ], function ( input_types )
    
    Assert( 0, input_types[1].category!.object_attribute_name = "AsInteger" );
    Assert( 0, ObjectDatumType( input_types[1].category ).filter = IsInt );
    
    return rec( filter := IsInt );
    
end );

CapJitAddTypeSignature( "AsInteger", [ IsCapCategoryMorphism ], function ( input_types )
    
    Assert( 0, input_types[1].category!.morphism_attribute_name = "AsInteger" );
    Assert( 0, MorphismDatumType( input_types[1].category ).filter = IsInt );
    
    return rec( filter := IsInt );
    
end );

# category, object and morphism attributes
CapJitAddTypeSignature( "RangeCategoryOfHomomorphismStructure", [ IsCapCategory ], function ( input_types )
    
    return CapJitDataTypeOfCategory( RangeCategoryOfHomomorphismStructure( input_types[1].category ) );
    
end );

CapJitAddTypeSignature( "CommutativeRingOfLinearCategory", [ IsCapCategory ], function ( input_types )
    
    return CapJitDataTypeOfRing( CommutativeRingOfLinearCategory( input_types[1].category ) );
    
end );

CapJitAddTypeSignature( "CapCategory", [ IsCapCategoryCell ], function ( input_types )
    
    return CapJitDataTypeOfCategory( input_types[1].category );
    
end );

CapJitAddTypeSignature( "Source", [ IsCapCategoryMorphism ], function ( input_types )
    
    return CapJitDataTypeOfObjectOfCategory( input_types[1].category );
    
end );

CapJitAddTypeSignature( "Range", [ IsCapCategoryMorphism ], function ( input_types )
    
    return CapJitDataTypeOfObjectOfCategory( input_types[1].category );
    
end );

CapJitAddTypeSignature( "Target", [ IsCapCategoryMorphism ], function ( input_types )
    
    return CapJitDataTypeOfObjectOfCategory( input_types[1].category );
    
end );

# GAP operations
CapJitAddTypeSignature( "RETURN_TRUE", [ IsObject, IsObject ], IsBool );
CapJitAddTypeSignature( "Length", [ IsList ], IsInt );
CapJitAddTypeSignature( "IsEmpty", [ IsList ], IsBool );
CapJitAddTypeSignature( "+", [ IsInt, IsInt ], IsInt );
CapJitAddTypeSignature( "+", [ IsInt, IsSmallIntRep ], IsInt );
CapJitAddTypeSignature( "+", [ IsSmallIntRep, IsSmallIntRep ], IsSmallIntRep );
CapJitAddTypeSignature( "+", [ IsSmallIntRep, IsInt ], IsInt );
CapJitAddTypeSignature( "AdditiveInverseSameMutability", [ IsInt ], IsInt );
CapJitAddTypeSignature( "-", [ IsInt, IsInt ], IsInt );
CapJitAddTypeSignature( "-", [ IsInt, IsSmallIntRep ], IsInt );
CapJitAddTypeSignature( "-", [ IsSmallIntRep, IsSmallIntRep ], IsSmallIntRep );
CapJitAddTypeSignature( "*", [ IsInt, IsInt ], IsInt );
CapJitAddTypeSignature( "*", [ IsInt, IsSmallIntRep ], IsInt );
CapJitAddTypeSignature( "*", [ IsSmallIntRep, IsInt ], IsInt );
CapJitAddTypeSignature( "*", [ IsSmallIntRep, IsSmallIntRep ], IsInt );
CapJitAddTypeSignature( "^", [ IsInt, IsInt ], IsInt );
CapJitAddTypeSignature( "REM_INT", [ IsInt, IsInt ], IsInt );
CapJitAddTypeSignature( "QUO_INT", [ IsInt, IsInt ], IsInt );
CapJitAddTypeSignature( "IsZero", [ IsInt ], IsBool );
CapJitAddTypeSignature( "OneImmutable", [ IsIntegers ], IsInt );
CapJitAddTypeSignature( "^", [ IsPerm, IsInt ], IsPerm );
CapJitAddTypeSignature( "PermList", [ IsList ], IsPerm );
CapJitAddTypeSignature( "PermutationMat", [ IsPerm, IsInt ], CapJitDataTypeOfListOf( CapJitDataTypeOfListOf( IsInt ) ) );
CapJitAddTypeSignature( "BigInt", [ IsInt ], IsBigInt );
CapJitAddTypeSignature( "BigInt", [ IsSmallIntRep ], IsInt );

CapJitAddTypeSignature( "IS_IDENTICAL_OBJ", [ IsObject, IsObject ], function ( input_types )
    
    if IsSpecializationOfFilter( IsCapCategory, input_types[1].filter ) then
        
        return rec( filter := IsBool );
        
    else
        
        # COVERAGE_IGNORE_BLOCK_START
        PrintWithCurrentlyCompiledFunctionLocation( "WARNING: `IsIdenticalObj` should only be used for CAP categories." );
        
        return fail;
        # COVERAGE_IGNORE_BLOCK_END
        
    fi;
    
end );

CapJitAddTypeSignature( "ID_FUNC", [ IsObject ], function ( input_types )
    
    return input_types[1];
    
end );

CapJitAddTypeSignature( "NumberRows", [ IsList ], function ( input_types )
    
    Assert( 0, input_types[1].element_type.filter = IsList );
    
    return rec( filter := IsInt );
    
end );

CapJitAddTypeSignature( "NumberColumns", [ IsList ], function ( input_types )
    
    Assert( 0, input_types[1].element_type.filter = IsList );
    
    return rec( filter := IsInt );
    
end );

CapJitAddTypeSignature( "ListWithIdenticalEntries", [ IsInt, IsObject ], function ( input_types )
    
    return CapJitDataTypeOfListOf( input_types[2] );
    
end );

CapJitAddTypeSignature( "Concatenation", "any", function ( input_types )
    local l;
    
    l := Length( input_types );
    
    if l = 0 then
        #Error( "empty Concatenation\n" );
        return fail;
    elif l = 1 then
        Assert( 0, input_types[1].filter = IsList );
        Assert( 0, input_types[1].element_type.filter = IsList );
        return CapJitDataTypeOfListOf( input_types[1].element_type.element_type );
    else
        Assert( 0, input_types[1].filter = IsList );
        Assert( 0, ForAll( [ 1 .. l - 1 ], i -> input_types[i] = input_types[i+1] ) );
        return input_types[1];
    fi;
    
end );

CapJitAddTypeSignature( "Difference", [ IsList, IsList ], function ( input_types )
    
    Assert( 0, input_types[1] = input_types[2] );
    
    return input_types[1];
    
end );

CapJitAddTypeSignature( "Cartesian", [ IsList ], function ( input_types )
    
    Assert( 0, input_types[1].element_type.filter = IsList );
    
    return input_types[1];
    
end );

CapJitAddTypeSignature( "Combinations", [ IsList, IsInt ], function ( input_types )
    
    return CapJitDataTypeOfListOf( input_types[1] );
    
end );

CapJitAddTypeSignature( "Reversed", [ IsList ], function ( input_types )
    
    return input_types[1];
    
end );

CapJitAddTypeSignature( "Sum", [ IsList ], function ( input_types )
    
    return input_types[1].element_type;
    
end );

CapJitAddTypeSignature( "Product", [ IsList ], function ( input_types )
    
    return input_types[1].element_type;
    
end );

CapJitAddTypeSignature( "Random", [ IsList ], function ( input_types )
    
    return input_types[1].element_type;
    
end );

CapJitAddTypeSignature( "[]", [ IsList, IsInt ], function ( input_types )
    
    return input_types[1].element_type;
    
end );

CapJitAddTypeSignature( "[]", [ IsList, IsSmallIntRep ], function ( input_types )
    
    return input_types[1].element_type;
    
end );

CapJitAddTypeSignature( "{}", [ IsList, IsList ], function ( input_types )
    
    return input_types[1];
    
end );

CapJitAddTypeSignature( "SSortedList", [ IsList ], function ( input_types )
    
    return input_types[1];
    
end );

CapJitAddTypeSignature( "DuplicateFreeList", [ IsList ], function ( input_types )
    
    return input_types[1];
    
end );

CapJitAddTypeSignature( "First", [ IsList, IsFunction ], function ( args, func_stack )
    
    # COVERAGE_IGNORE_BLOCK_START
    PrintWithCurrentlyCompiledFunctionLocation( "WARNING: `First` might return fail and thus cannot be handled by the type system currently. Please use `SafeUniqueEntry` (or `SafeFirst`) instead." );
    
    return fail;
    # COVERAGE_IGNORE_BLOCK_END
    
end );

CapJitAddTypeSignature( "SafeFirst", [ IsList, IsFunction ], function ( args, func_stack )
    
    args := ShallowCopy( args );
    
    args.2 := CAP_JIT_INTERNAL_INFERRED_DATA_TYPES_OF_FUNCTION_BY_ARGUMENTS_TYPES( args.2, [ args.1.data_type.element_type ], func_stack );
    
    if args.2 = fail then
        
        #Error( "could not determine output type" );
        return fail;
        
    fi;
    
    return rec( args := args, output_type := args.1.data_type.element_type );
    
end );

CapJitAddTypeSignature( "SafeUniqueEntry", [ IsList, IsFunction ], function ( args, func_stack )
    
    args := ShallowCopy( args );
    
    args.2 := CAP_JIT_INTERNAL_INFERRED_DATA_TYPES_OF_FUNCTION_BY_ARGUMENTS_TYPES( args.2, [ args.1.data_type.element_type ], func_stack );
    
    if args.2 = fail then
        
        #Error( "could not determine output type" );
        return fail;
        
    fi;
    
    return rec( args := args, output_type := args.1.data_type.element_type );
    
end );

CapJitAddTypeSignature( "Position", [ IsList, IsObject ], function ( input_types )
    
    # COVERAGE_IGNORE_BLOCK_START
    Assert( 0, input_types[1].element_type = input_types[2] );
    
    PrintWithCurrentlyCompiledFunctionLocation( "WARNING: `Position` might return fail and thus cannot be handled by the type system currently. Please use `Safe(Unique)Position` instead." );
    
    return fail;
    # COVERAGE_IGNORE_BLOCK_END
    
end );

CapJitAddTypeSignature( "SafePosition", [ IsList, IsObject ], function ( input_types )
    
    Assert( 0, input_types[1].element_type = input_types[2] );
    
    if CapJitDataTypeIsNestedListOfSimpleLiterals( input_types[2] ) then
        
        return rec( filter := IsInt );
        
    else
        
        # COVERAGE_IGNORE_BLOCK_START
        PrintWithCurrentlyCompiledFunctionLocation( "WARNING: `SafePosition` should only be used for integers, strings, characters or (nested) lists thereof." );
        
        return fail;
        # COVERAGE_IGNORE_BLOCK_END
        
    fi;
    
end );

CapJitAddTypeSignature( "SafeUniquePosition", [ IsList, IsObject ], function ( input_types )
    
    Assert( 0, input_types[1].element_type = input_types[2] );
    
    if CapJitDataTypeIsNestedListOfSimpleLiterals( input_types[2] ) then
        
        return rec( filter := IsInt );
        
    else
        
        # COVERAGE_IGNORE_BLOCK_START
        PrintWithCurrentlyCompiledFunctionLocation( "WARNING: `SafeUniquePosition` should only be used for integers, strings, characters or (nested) lists thereof." );
        
        return fail;
        # COVERAGE_IGNORE_BLOCK_END
        
    fi;
    
end );

CapJitAddTypeSignature( "Positions", [ IsList, IsObject ], function ( input_types )
    
    Assert( 0, input_types[1].element_type = input_types[2] );
    
    if CapJitDataTypeIsNestedListOfSimpleLiterals( input_types[2] ) then
        
        return CapJitDataTypeOfListOf( IsInt );
        
    else
        
        # COVERAGE_IGNORE_BLOCK_START
        PrintWithCurrentlyCompiledFunctionLocation( "WARNING: `Positions` should only be used for integers, strings, characters or (nested) lists thereof." );
        
        return fail;
        # COVERAGE_IGNORE_BLOCK_END
        
    fi;
    
end );

CapJitAddTypeSignature( "SafePositionProperty", [ IsList, IsFunction ], function ( args, func_stack )
    
    args := ShallowCopy( args );
    
    args.2 := CAP_JIT_INTERNAL_INFERRED_DATA_TYPES_OF_FUNCTION_BY_ARGUMENTS_TYPES( args.2, [ args.1.data_type.element_type ], func_stack );
    
    if args.2 = fail then
        
        #Error( "could not determine output type" );
        return fail;
        
    fi;
    
    return rec( args := args, output_type := rec( filter := IsInt ) );
    
end );

CapJitAddTypeSignature( "SafeUniquePositionProperty", [ IsList, IsFunction ], function ( args, func_stack )
    
    args := ShallowCopy( args );
    
    args.2 := CAP_JIT_INTERNAL_INFERRED_DATA_TYPES_OF_FUNCTION_BY_ARGUMENTS_TYPES( args.2, [ args.1.data_type.element_type ], func_stack );
    
    if args.2 = fail then
        
        #Error( "could not determine output type" );
        return fail;
        
    fi;
    
    return rec( args := args, output_type := rec( filter := IsInt ) );
    
end );

CapJitAddTypeSignature( "PositionsProperty", [ IsList, IsFunction ], function ( args, func_stack )
    
    args := ShallowCopy( args );
    
    args.2 := CAP_JIT_INTERNAL_INFERRED_DATA_TYPES_OF_FUNCTION_BY_ARGUMENTS_TYPES( args.2, [ args.1.data_type.element_type ], func_stack );
    
    if args.2 = fail then
        
        #Error( "could not determine output type" );
        return fail;
        
    fi;
    
    return rec( args := args, output_type := CapJitDataTypeOfListOf( IsInt ) );
    
end );

CapJitAddTypeSignature( "NTuple", "any", function ( input_types )
    
    Assert( 0, input_types[1].filter = IsInt );
    
    return rec( filter := IsNTuple, element_types := input_types{[ 2 .. Length( input_types ) ]} );
    
end );

CapJitAddTypeSignature( "Pair", [ IsObject, IsObject ], function ( input_types )
    
    return rec( filter := IsNTuple, element_types := input_types );
    
end );

CapJitAddTypeSignature( "Triple", [ IsObject, IsObject, IsObject ], function ( input_types )
    
    return rec( filter := IsNTuple, element_types := input_types );
    
end );

CapJitAddTypeSignature( "[]", [ IsNTuple, IsInt ], function ( args, func_stack )
    
    if args.2.type <> "EXPR_INT" then
        
        # COVERAGE_IGNORE_NEXT_LINE
        ErrorWithCurrentlyCompiledFunctionLocation( "You should only access tuples via literal integers." );
        
    fi;
    
    return rec( args := args, output_type := args.1.data_type.element_types[args.2.value] );
    
end );

CapJitAddTypeSignature( "Tuples", [ IsList, IsInt ], function ( input_types )
    
    return CapJitDataTypeOfListOf( input_types[1] );
    
end );

CapJitAddTypeSignature( "*", [ IsInt, IsList ], function ( input_types )
  local element_type;
    
    if input_types[2].element_type.filter = IsList then
        
        # matrix case
        element_type := CAP_JIT_INTERNAL_GET_OUTPUT_TYPE_OF_GLOBAL_FUNCTION_BY_INPUT_TYPES( "*", [ rec( filter := IsInt ), input_types[2].element_type.element_type ] );
        
    else
        
        # list case
        element_type := CAP_JIT_INTERNAL_GET_OUTPUT_TYPE_OF_GLOBAL_FUNCTION_BY_INPUT_TYPES( "*", [ rec( filter := IsInt ), input_types[2].element_type ] );
        
    fi;
    
    if element_type = fail then
        
        #Error( "could not determine element_type" );
        return fail;
        
    fi;
    
    if IsFunction( element_type ) then
        
        #Error( "cannot infer parametric output type by arguments types only" );
        return fail;
        
    fi;
    
    if input_types[2].element_type.filter = IsList then
        
        return CapJitDataTypeOfListOf( CapJitDataTypeOfListOf( element_type ) );
        
    else
        
        return CapJitDataTypeOfListOf( element_type );
        
    fi;
    
end );

CapJitAddTypeSignature( "[,]", [ IsList, IsInt, IsInt ], function ( input_types )
    
    Assert( 0, input_types[1].element_type.filter = IsList );
    
    return input_types[1].element_type.element_type;
    
end );

CapJitAddTypeSignature( "LazyHList", [ IsList, IsFunction ], function ( args, func_stack )
    
    args := ShallowCopy( args );
    
    args.2 := CAP_JIT_INTERNAL_INFERRED_DATA_TYPES_OF_FUNCTION_BY_ARGUMENTS_TYPES( args.2, [ args.1.data_type.element_type ], func_stack );
    
    if args.2 = fail then
        
        #Error( "could not determine output type" );
        return fail;
        
    fi;
    
    return rec( args := args, output_type := CapJitDataTypeOfListOf( args.2.data_type.signature[2] ) );
    
end );

CapJitAddTypeSignature( "List", [ IsList, IsFunction ], function ( args, func_stack )
    
    args := ShallowCopy( args );
    
    args.2 := CAP_JIT_INTERNAL_INFERRED_DATA_TYPES_OF_FUNCTION_BY_ARGUMENTS_TYPES( args.2, [ args.1.data_type.element_type ], func_stack );
    
    if args.2 = fail then
        
        #Error( "could not determine output type" );
        return fail;
        
    fi;
    
    return rec( args := args, output_type := CapJitDataTypeOfListOf( args.2.data_type.signature[2] ) );
    
end );

CapJitAddTypeSignature( "ForAll", [ IsList, IsFunction ], function ( args, func_stack )
    
    args := ShallowCopy( args );
    
    args.2 := CAP_JIT_INTERNAL_INFERRED_DATA_TYPES_OF_FUNCTION_BY_ARGUMENTS_TYPES( args.2, [ args.1.data_type.element_type ], func_stack );
    
    if args.2 = fail then
        
        #Error( "could not determine output type" );
        return fail;
        
    fi;
    
    Assert( 0, args.2.data_type.signature[2].filter = IsBool );
    
    return rec( args := args, output_type := rec( filter := IsBool ) );
    
end );

CapJitAddTypeSignature( "ForAny", [ IsList, IsFunction ], function ( args, func_stack )
    
    args := ShallowCopy( args );
    
    args.2 := CAP_JIT_INTERNAL_INFERRED_DATA_TYPES_OF_FUNCTION_BY_ARGUMENTS_TYPES( args.2, [ args.1.data_type.element_type ], func_stack );
    
    if args.2 = fail then
        
        #Error( "could not determine output type" );
        return fail;
        
    fi;
    
    Assert( 0, args.2.data_type.signature[2].filter = IsBool );
    
    return rec( args := args, output_type := rec( filter := IsBool ) );
    
end );

CapJitAddTypeSignature( "Filtered", [ IsList, IsFunction ], function ( args, func_stack )
    
    args := ShallowCopy( args );
    
    args.2 := CAP_JIT_INTERNAL_INFERRED_DATA_TYPES_OF_FUNCTION_BY_ARGUMENTS_TYPES( args.2, [ args.1.data_type.element_type ], func_stack );
    
    if args.2 = fail then
        
        #Error( "could not determine output type" );
        return fail;
        
    fi;
    
    Assert( 0, args.2.data_type.signature[2].filter = IsBool );
    
    return rec( args := args, output_type := args.1.data_type );
    
end );

CapJitAddTypeSignature( "ListN", [ IsList, IsList, IsFunction ], function ( args, func_stack )
    
    args := ShallowCopy( args );
    
    args.3 := CAP_JIT_INTERNAL_INFERRED_DATA_TYPES_OF_FUNCTION_BY_ARGUMENTS_TYPES( args.3, [ args.1.data_type.element_type, args.2.data_type.element_type ], func_stack );
    
    if args.3 = fail then
        
        #Error( "could not determine output type" );
        return fail;
        
    fi;
    
    return rec( args := args, output_type := CapJitDataTypeOfListOf( args.3.data_type.signature[2] ) );
    
end );

CapJitAddTypeSignature( "ListX", [ IsList, IsList, IsFunction ], function ( args, func_stack )
    
    args := ShallowCopy( args );
    
    args.3 := CAP_JIT_INTERNAL_INFERRED_DATA_TYPES_OF_FUNCTION_BY_ARGUMENTS_TYPES( args.3, [ args.1.data_type.element_type, args.2.data_type.element_type ], func_stack );
    
    if args.3 = fail then
        
        #Error( "could not determine output type" );
        return fail;
        
    fi;
    
    return rec( args := args, output_type := CapJitDataTypeOfListOf( args.3.data_type.signature[2] ) );
    
end );

CapJitAddTypeSignature( "Sum", [ IsList, IsFunction ], function ( args, func_stack )
    
    args := ShallowCopy( args );
    
    args.2 := CAP_JIT_INTERNAL_INFERRED_DATA_TYPES_OF_FUNCTION_BY_ARGUMENTS_TYPES( args.2, [ args.1.data_type.element_type ], func_stack );
    
    if args.2 = fail then
        
        #Error( "could not determine output type" );
        return fail;
        
    fi;
    
    return rec( args := args, output_type := args.2.data_type.signature[2] );
    
end );

CapJitAddTypeSignature( "Product", [ IsList, IsFunction ], function ( args, func_stack )
    
    args := ShallowCopy( args );
    
    args.2 := CAP_JIT_INTERNAL_INFERRED_DATA_TYPES_OF_FUNCTION_BY_ARGUMENTS_TYPES( args.2, [ args.1.data_type.element_type ], func_stack );
    
    if args.2 = fail then
        
        #Error( "could not determine output type" );
        return fail;
        
    fi;
    
    return rec( args := args, output_type := args.2.data_type.signature[2] );
    
end );

CapJitAddTypeSignature( "Iterated", [ IsList, IsFunction ], function ( args, func_stack )
    
    args := ShallowCopy( args );
    
    args.2 := CAP_JIT_INTERNAL_INFERRED_DATA_TYPES_OF_FUNCTION_BY_ARGUMENTS_TYPES( args.2, [ args.1.data_type.element_type, args.1.data_type.element_type ], func_stack );
    
    if args.2 = fail then
        
        #Error( "could not determine output type" );
        return fail;
        
    fi;
    
    return rec( args := args, output_type := args.2.data_type.signature[2] );
    
end );

CapJitAddTypeSignature( "Iterated", [ IsList, IsFunction, IsObject ], function ( args, func_stack )
    
    Assert( 0, args.1.data_type.element_type = args.3.data_type );
    
    args := ShallowCopy( args );
    
    args.2 := CAP_JIT_INTERNAL_INFERRED_DATA_TYPES_OF_FUNCTION_BY_ARGUMENTS_TYPES( args.2, [ args.1.data_type.element_type, args.1.data_type.element_type ], func_stack );
    
    if args.2 = fail then
        
        #Error( "could not determine output type" );
        return fail;
        
    fi;
    
    return rec( args := args, output_type := args.2.data_type.signature[2] );
    
end );

CapJitAddTypeSignature( "Iterated", [ IsList, IsFunction, IsObject, IsObject ], function ( args, func_stack )
    
    Assert( 0, args.1.data_type.element_type = args.3.data_type );
    Assert( 0, args.1.data_type.element_type = args.4.data_type );
    
    args := ShallowCopy( args );
    
    args.2 := CAP_JIT_INTERNAL_INFERRED_DATA_TYPES_OF_FUNCTION_BY_ARGUMENTS_TYPES( args.2, [ args.1.data_type.element_type, args.1.data_type.element_type ], func_stack );
    
    if args.2 = fail then
        
        #Error( "could not determine output type" );
        return fail;
        
    fi;
    
    return rec( args := args, output_type := args.2.data_type.signature[2] );
    
end );
