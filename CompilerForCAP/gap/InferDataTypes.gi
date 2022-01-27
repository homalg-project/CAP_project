# SPDX-License-Identifier: GPL-2.0-or-later
# CompilerForCAP: Speed up computations in CAP categories
#
# Implementations
#

BindGlobal( "CAP_JIT_INTERNAL_GLOBAL_VARIABLE_FILTERS", [
    "IsHomalgRing",
    "IsHomalgRingElement",
    "IsHomalgMatrix",
    "IsHomalgRingMap",
    "IsRingAsCategoryObject",
] );

InstallGlobalFunction( "CAP_JIT_INTERNAL_LOAD_DEFERRED_TYPE_SIGNATURES", function ( )
  local package_name, signature;
    
    for package_name in RecNames( CAP_JIT_INTERNAL_TYPE_SIGNATURES_DEFERRED ) do
        
        if IsPackageMarkedForLoading( package_name, "" ) then
            
            for signature in CAP_JIT_INTERNAL_TYPE_SIGNATURES_DEFERRED.(package_name) do
                
                CapJitAddTypeSignature( signature[1], List( signature[2], x -> EvalString( x ) ), EvalString( signature[3] ) );
                
            od;
            
            Unbind( CAP_JIT_INTERNAL_TYPE_SIGNATURES_DEFERRED.(package_name) );
            
        fi;
        
    od;
    
end );

InstallGlobalFunction( "CAP_JIT_INTERNAL_GET_OUTPUT_TYPE_OF_GLOBAL_FUNCTION_BY_INPUT_FILTERS", function ( gvar, input_filters )
  local type_signatures, package_name, signature;
    
    if IsCategory( ValueGlobal( gvar ) ) and Length( input_filters ) = 1 then
        
        return rec( filter := IsBool );
        
    fi;
    
    if not IsBound( CAP_JIT_INTERNAL_TYPE_SIGNATURES.(gvar) ) then
        
        # try to load deferred type signatures
        CAP_JIT_INTERNAL_LOAD_DEFERRED_TYPE_SIGNATURES( );
        
    fi;
    
    if not IsBound( CAP_JIT_INTERNAL_TYPE_SIGNATURES.(gvar) ) then
        
        Display( Concatenation( "WARNING: Could not find declaration of ", gvar, " (current input: ", String( input_filters ), ")" ) );
        return fail;
        
    fi;
    
    type_signatures := Filtered( CAP_JIT_INTERNAL_TYPE_SIGNATURES.(gvar), s -> IsSpecializationOfFilterList( s[1], input_filters ) );
    
    if Length( type_signatures ) = 0 then
        
        # try to load deferred type signatures
        CAP_JIT_INTERNAL_LOAD_DEFERRED_TYPE_SIGNATURES( );
        
        type_signatures := Filtered( CAP_JIT_INTERNAL_TYPE_SIGNATURES.(gvar), s -> IsSpecializationOfFilterList( s[1], input_filters ) );
        
    fi;
    
    if Length( type_signatures ) = 0 then
        
        Display( Concatenation( "WARNING: Could not find matching declaration of ", gvar, " for input ", String( input_filters ) ) );
        return fail;
        
    elif Length( type_signatures ) > 1 then
        
        # COVERAGE_IGNORE_NEXT_LINE
        Error( "Found multiple matching declarations of ", gvar, " for input ", input_filters );
        
    fi;
    
    return type_signatures[1][2];
    
end );

InstallGlobalFunction( "CAP_JIT_INTERNAL_INFERRED_DATA_TYPES_OF_FUNCTION_BY_ARGUMENTS", function ( funcref, args, func_stack )
  local output_type, result;
    
    if funcref.type = "EXPR_REF_GVAR" then
        
        output_type := CAP_JIT_INTERNAL_GET_OUTPUT_TYPE_OF_GLOBAL_FUNCTION_BY_INPUT_FILTERS( funcref.gvar, List( AsListMut( args ), a -> a.data_type.filter ) );
        
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
        
    else
        
        #Error( "can only handle EXPR_REF_GVAR" );
        return fail;
        
    fi;
    
end );

InstallGlobalFunction( "CAP_JIT_INTERNAL_INFERRED_DATA_TYPES_OF_FUNCTION_BY_ARGUMENTS_TYPES", function ( funcref, arguments_types, func_stack )
  local output_type, func;
    
    if funcref.type = "EXPR_REF_GVAR" then
        
        output_type := CAP_JIT_INTERNAL_GET_OUTPUT_TYPE_OF_GLOBAL_FUNCTION_BY_INPUT_FILTERS( funcref.gvar, List( arguments_types, type -> type.filter ) );
        
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
        
        func := CAP_JIT_INTERNAL_INFERRED_DATA_TYPES_WITH_INITIAL_FUNC_STACK( func, func_stack );
        
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

InstallGlobalFunction( "CAP_JIT_INTERNAL_INFERRED_DATA_TYPES_WITH_INITIAL_FUNC_STACK", function ( tree, initial_func_stack )
  local pre_func, result_func, additional_arguments_func;
    
    pre_func := function ( tree, func_stack )
        
        if tree.type = "EXPR_FUNCCALL" then
            
            # manual iteration in result_func
            return fail;
            
        fi;
        
        return tree;
        
    end;
    
    result_func := function ( tree, result, keys, func_stack )
      local data_type, filter, func, pos, key, i;
        
        tree := ShallowCopy( tree );
        
        if tree.type = "EXPR_FUNCCALL" then
            
            # get data types of all arguments
            tree.args := List( tree.args, function ( a )
                
                if a.type = "EXPR_DECLARATIVE_FUNC" then
                    
                    a := ShallowCopy( a );
                    
                    # signature has to be set from somewhere else
                    a.data_type := rec( filter := IsFunction );
                    
                    return a;
                    
                else
                    
                    return CAP_JIT_INTERNAL_INFERRED_DATA_TYPES_WITH_INITIAL_FUNC_STACK( a, func_stack );
                    
                fi;
                
            end );
            
            if ForAny( tree.args, a -> not IsBound( a.data_type ) ) then
                
                #Error( "could not determine data_type of all arguments" );
                # there might already be a data type set, but we want to avoid partial typings -> unbind
                Unbind( tree.data_type );
                return tree;
                
            fi;
            
            result := CAP_JIT_INTERNAL_INFERRED_DATA_TYPES_OF_FUNCTION_BY_ARGUMENTS( tree.funcref, tree.args, func_stack );
            
            if result = fail then
                
                #Error( "could not get output_type" );
                # there might already be a data type set, but we want to avoid partial typings -> unbind
                Unbind( tree.data_type );
                return tree;
                
            fi;
            
            Assert( 0, IsRecord( result.output_type ) );
            
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
            
            data_type := rec( filter := IsInt );
            
        elif tree.type = "EXPR_STRING" then
            
            data_type := rec( filter := IsString );
            
        elif tree.type = "EXPR_TRUE" then
            
            data_type := rec( filter := IsBool );
            
        elif tree.type = "EXPR_FALSE" then
            
            data_type := rec( filter := IsBool );
            
        elif tree.type = "EXPR_REC" then
            
            data_type := rec( filter := IsRecord );
            
        elif tree.type = "EXPR_CASE" then
            
            if not ForAll( tree.branches, branch -> branch.condition.filter = IsBool ) then
                
                Error( "a condition of the case expression is not a boolean" );
                
            fi;
            
            if not ForAll( tree.branches, branch -> branch.value.data_type = tree.branches.1.value.data_type ) then
                
                #Error( "the branches of the case expression are of different types, this is not supported" );
                # there might already be a data type set, but we want to avoid partial typings -> unbind
                Unbind( tree.data_type );
                return tree;
                
            fi;
            
            data_type := tree.branches.1.value.data_type;
            
        elif tree.type = "EXPR_RANGE" then
            
            data_type := rec( filter := IsList, element_type := rec( filter := IsInt ) );
            
        elif tree.type = "EXPR_LIST" then
            
            if tree.list.length = 0 then
                
                #Error( "cannot infer the type of empty lists" );
                # there might already be a data type set, but we want to avoid partial typings -> unbind
                Unbind( tree.data_type );
                return tree;
                
            fi;
            
            if not ForAll( tree.list, element -> element.data_type = tree.list.1.data_type ) then
                
                #Error( "the list is not homogeneous, this is not supported" );
                # there might already be a data type set, but we want to avoid partial typings -> unbind
                Unbind( tree.data_type );
                return tree;
                
            fi;
            
            data_type := rec( filter := IsList, element_type := tree.list.1.data_type );
            
        elif tree.type = "EXPR_REF_GVAR" then
            
            for i in [ 1 .. Length( CAP_JIT_INTERNAL_GLOBAL_VARIABLE_FILTERS ) ] do
                
                if IsString( CAP_JIT_INTERNAL_GLOBAL_VARIABLE_FILTERS[i] ) and IsBoundGlobal( CAP_JIT_INTERNAL_GLOBAL_VARIABLE_FILTERS[i] ) then
                    
                    CAP_JIT_INTERNAL_GLOBAL_VARIABLE_FILTERS[i] := ValueGlobal( CAP_JIT_INTERNAL_GLOBAL_VARIABLE_FILTERS[i] );
                    
                fi;
                
            od;
            
            filter := First( CAP_JIT_INTERNAL_GLOBAL_VARIABLE_FILTERS, filter -> IsFilter( filter ) and filter( ValueGlobal( tree.gvar ) ) );
            
            if IsCapCategory( ValueGlobal( tree.gvar ) ) then
                
                data_type := rec( filter := IsCapCategory, category := ValueGlobal( tree.gvar ) );
                
            elif IsList( ValueGlobal( tree.gvar ) ) and Length( ValueGlobal( tree.gvar ) ) > 0 then
                
                filter := First( CAP_JIT_INTERNAL_GLOBAL_VARIABLE_FILTERS, filter -> IsFilter( filter ) and filter( ValueGlobal( tree.gvar )[1] ) );
                
                if filter <> fail then
                    
                    if not ForAll( ValueGlobal( tree.gvar ), x -> filter( x ) ) then
                        
                        #Error( "the list is not homogeneous, this is not supported" );
                        # there might already be a data type set, but we want to avoid partial typings -> unbind
                        Unbind( tree.data_type );
                        return tree;
                        
                    fi;
                    
                    data_type := rec( filter := IsList, element_type := rec( filter := filter ) );
                    
                else
                    
                    #Error( "could not find type of gvar ", tree.gvar );
                    # there might already be a data type set, but we want to avoid partial typings -> unbind
                    Unbind( tree.data_type );
                    return tree;
                    
                fi;
                
            elif filter <> fail then
                
                data_type := rec( filter := filter );
                
            elif IsFunction( ValueGlobal( tree.gvar ) ) then
                
                # signature has to be set from somewhere else
                data_type := rec( filter := IsFunction );
                
            else
                
                #Error( "could not find type of gvar ", tree.gvar );
                # there might already be a data type set, but we want to avoid partial typings -> unbind
                Unbind( tree.data_type );
                return tree;
                
            fi;
            
        elif tree.type = "EXPR_REF_FVAR" then
            
            func := First( func_stack, func -> func.id = tree.func_id );
            Assert( 0, func <> fail );
            
            if func.variadic then
                
                #Error( "cannot handle variadic functions yet" );
                # there might already be a data type set, but we want to avoid partial typings -> unbind
                Unbind( tree.data_type );
                return tree;
                
            fi;
            
            pos := Position( func.nams, tree.name );
            
            if pos > func.narg then
                
                #Error( "getting the type of a binding is not supported yet" );
                # there might already be a data type set, but we want to avoid partial typings -> unbind
                Unbind( tree.data_type );
                return tree;
                
            fi;
            
            if not IsBound( func.data_type ) then
                
                #Error( "function does not have a data type yet" );
                # there might already be a data type set, but we want to avoid partial typings -> unbind
                Unbind( tree.data_type );
                return tree;
                
            fi;
            
            data_type := func.data_type.signature[1][pos];
            
        elif tree.type = "EXPR_DECLARATIVE_FUNC" then
            
            if IsBound( tree.data_type ) then
                
                Assert( 0, tree.data_type.filter = IsFunction );
                
                if tree.data_type.signature[2] = fail then
                    
                    data_type := rec( filter := IsFunction, signature := [ tree.data_type.signature[1], tree.bindings.BINDING_RETURN_VALUE.data_type ] );
                    
                else
                    
                    Assert( 0, tree.bindings.BINDING_RETURN_VALUE.data_type = tree.data_type.signature[2] );
                    
                    data_type := tree.data_type;
                    
                fi;
                
            else
                
                #Error( "EXPR_DECLARATIVE_FUNC cannot be handled without input types" );
                # there might already be a data type set, but we want to avoid partial typings -> unbind
                Unbind( tree.data_type );
                return tree;
                
            fi;
            
        else
            
            #Error( "Cannot compute data type for syntax tree type ", tree.type, " yet." );
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
    
    return CapJitIterateOverTree( tree, pre_func, result_func, additional_arguments_func, initial_func_stack );
    
end );

InstallGlobalFunction( CapJitInferredDataTypes, function ( tree )
    
    return CAP_JIT_INTERNAL_INFERRED_DATA_TYPES_WITH_INITIAL_FUNC_STACK( tree, [ ] );
    
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

# Objectify*ForCAPWithAttributes
CapJitAddTypeSignature( "ObjectifyObjectForCAPWithAttributes", [ IsRecord, IsCapCategory, IsFunction, IsObject ], function ( args, func_stack )
    
    return rec( args := args, output_type := rec( filter := args.2.data_type.category!.object_representation, category := args.2.data_type.category ) );
    
end );

CapJitAddTypeSignature( "ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes", [ IsRecord, IsCapCategory, IsCapCategoryObject, IsCapCategoryObject, IsFunction, IsObject ], function ( args, func_stack )
    
    return rec( args := args, output_type := rec( filter := args.2.data_type.category!.morphism_representation, category := args.2.data_type.category ) );
    
end );

# object and morphism attributes
CapJitAddTypeSignature( "CapCategory", [ IsCapCategoryCell ], function ( args, func_stack )
    
    return rec( args := args, output_type := rec( filter := IsCapCategory, category := args.1.data_type.category ) );
    
end );

CapJitAddTypeSignature( "Source", [ IsCapCategoryMorphism ], function ( args, func_stack )
    
    return rec( args := args, output_type := rec( filter := args.1.data_type.category!.object_representation, category := args.1.data_type.category ) );
    
end );

CapJitAddTypeSignature( "Range", [ IsCapCategoryMorphism ], function ( args, func_stack )
    
    return rec( args := args, output_type := rec( filter := args.1.data_type.category!.object_representation, category := args.1.data_type.category ) );
    
end );

# GAP operations
CapJitAddTypeSignature( "Length", [ IsList ], IsInt );
CapJitAddTypeSignature( "+", [ IsInt, IsInt ], IsInt );
CapJitAddTypeSignature( "-", [ IsInt, IsInt ], IsInt );
CapJitAddTypeSignature( "*", [ IsInt, IsInt ], IsInt );
CapJitAddTypeSignature( "REM_INT", [ IsInt, IsInt ], IsInt );
CapJitAddTypeSignature( "QUO_INT", [ IsInt, IsInt ], IsInt );
CapJitAddTypeSignature( "IsZero", [ IsInt ], IsBool );
CapJitAddTypeSignature( "IS_IDENTICAL_OBJ", [ IsObject, IsObject ], IsBool );
CapJitAddTypeSignature( "PermList", [ IsList ], IsPerm );
CapJitAddTypeSignature( "PermutationMat", [ IsPerm, IsInt ], rec( filter := IsList, element_type := rec( filter := IsList, element_type := IsInt ) ) );

CapJitAddTypeSignature( "NumberRows", [ IsList ], function ( args, func_stack )
    
    Assert( 0, args.1.data_type.element_type.filter = IsList );
    
    return rec( args := args, output_type := rec( filter := IsInt ) );
    
end );

CapJitAddTypeSignature( "NumberColumns", [ IsList ], function ( args, func_stack )
    
    Assert( 0, args.1.data_type.element_type.filter = IsList );
    
    return rec( args := args, output_type := rec( filter := IsInt ) );
    
end );

CapJitAddTypeSignature( "ListWithIdenticalEntries", [ IsInt, IsObject ], function ( args, func_stack )
    
    return rec( args := args, output_type := rec( filter := IsList, element_type := args.2.data_type ) );
    
end );

CapJitAddTypeSignature( "Concatenation", [ IsList ], function ( args, func_stack )
    
    Assert( 0, args.1.data_type.element_type.filter = IsList );
    
    return rec( args := args, output_type := rec( filter := IsList, element_type := args.1.data_type.element_type.element_type ) );
    
end );

CapJitAddTypeSignature( "Sum", [ IsList ], function ( args, func_stack )
    
    return rec( args := args, output_type := args.1.data_type.element_type );
    
end );

CapJitAddTypeSignature( "[]", [ IsList, IsInt ], function ( args, func_stack )
    
    return rec( args := args, output_type := args.1.data_type.element_type );
    
end );

CapJitAddTypeSignature( "{}", [ IsList, IsList ], function ( args, func_stack )
    
    return rec( args := args, output_type := args.1.data_type );
    
end );

CapJitAddTypeSignature( "MatElm", [ IsList, IsInt, IsInt ], function ( args, func_stack )
    
    Assert( 0, args.1.data_type.element_type.filter = IsList );
    
    return rec( args := args, output_type := args.1.data_type.element_type.element_type );
    
end );

CapJitAddTypeSignature( "List", [ IsList, IsFunction ], function ( args, func_stack )
    
    args := ShallowCopy( args );
    
    args.2 := CAP_JIT_INTERNAL_INFERRED_DATA_TYPES_OF_FUNCTION_BY_ARGUMENTS_TYPES( args.2, [ args.1.data_type.element_type ], func_stack );
    
    if args.2 = fail then
        
        #Error( "could not determine output type" );
        return fail;
        
    fi;
    
    return rec( args := args, output_type := rec( filter := IsList, element_type := args.2.data_type.signature[2] ) );
    
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

CapJitAddTypeSignature( "ListN", [ IsList, IsList, IsFunction ], function ( args, func_stack )
    
    args := ShallowCopy( args );
    
    args.3 := CAP_JIT_INTERNAL_INFERRED_DATA_TYPES_OF_FUNCTION_BY_ARGUMENTS_TYPES( args.3, [ args.1.data_type.element_type, args.2.data_type.element_type ], func_stack );
    
    if args.3 = fail then
        
        #Error( "could not determine output type" );
        return fail;
        
    fi;
    
    return rec( args := args, output_type := rec( filter := IsList, element_type := args.3.data_type.signature[2] ) );
    
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

CapJitAddTypeSignature( "Iterated", [ IsList, IsFunction ], function ( args, func_stack )
    
    args := ShallowCopy( args );
    
    args.2 := CAP_JIT_INTERNAL_INFERRED_DATA_TYPES_OF_FUNCTION_BY_ARGUMENTS_TYPES( args.2, [ args.1.data_type.element_type, args.1.data_type.element_type ], func_stack );
    
    if args.2 = fail then
        
        #Error( "could not determine output type" );
        return fail;
        
    fi;
    
    return rec( args := args, output_type := args.2.data_type.signature[2] );
    
end );

# homalg operations
CapJitAddTypeSignatureDeferred( "MatricesForHomalg", "HomalgMatrix", [ "IsList", "IsInt", "IsInt", "IsHomalgRing" ], "IsHomalgMatrix" );
CapJitAddTypeSignatureDeferred( "MatricesForHomalg", "HomalgMatrixListList", [ "IsList", "IsInt", "IsInt", "IsHomalgRing" ], "IsHomalgMatrix" );
CapJitAddTypeSignatureDeferred( "MatricesForHomalg", "HomalgIdentityMatrix", [ "IsInt", "IsHomalgRing" ], "IsHomalgMatrix" );
CapJitAddTypeSignatureDeferred( "MatricesForHomalg", "HomalgZeroMatrix", [ "IsInt", "IsInt", "IsHomalgRing" ], "IsHomalgMatrix" );
CapJitAddTypeSignatureDeferred( "MatricesForHomalg", "IsZero", [ "IsHomalgMatrix" ], "IsBool" );
CapJitAddTypeSignatureDeferred( "MatricesForHomalg", "MatElm", [ "IsHomalgMatrix", "IsInt", "IsInt" ], "IsHomalgRingElement" );
CapJitAddTypeSignatureDeferred( "MatricesForHomalg", "ConvertRowToMatrix", [ "IsHomalgMatrix", "IsInt", "IsInt" ], "IsHomalgMatrix" );
CapJitAddTypeSignatureDeferred( "MatricesForHomalg", "ConvertColumnToMatrix", [ "IsHomalgMatrix", "IsInt", "IsInt" ], "IsHomalgMatrix" );
CapJitAddTypeSignatureDeferred( "MatricesForHomalg", "ConvertMatrixToRow", [ "IsHomalgMatrix" ], "IsHomalgMatrix" );
CapJitAddTypeSignatureDeferred( "MatricesForHomalg", "ConvertMatrixToColumn", [ "IsHomalgMatrix" ], "IsHomalgMatrix" );
CapJitAddTypeSignatureDeferred( "MatricesForHomalg", "CertainRows", [ "IsHomalgMatrix", "IsList" ], "IsHomalgMatrix" );
CapJitAddTypeSignatureDeferred( "MatricesForHomalg", "CertainColumns", [ "IsHomalgMatrix", "IsList" ], "IsHomalgMatrix" );
CapJitAddTypeSignatureDeferred( "MatricesForHomalg", "KroneckerMat", [ "IsHomalgMatrix", "IsHomalgMatrix" ], "IsHomalgMatrix" );
CapJitAddTypeSignatureDeferred( "MatricesForHomalg", "DualKroneckerMat", [ "IsHomalgMatrix", "IsHomalgMatrix" ], "IsHomalgMatrix" );
CapJitAddTypeSignatureDeferred( "MatricesForHomalg", "LeftDivide", [ "IsHomalgMatrix", "IsHomalgMatrix" ], "IsHomalgMatrix" );
CapJitAddTypeSignatureDeferred( "MatricesForHomalg", "RightDivide", [ "IsHomalgMatrix", "IsHomalgMatrix" ], "IsHomalgMatrix" );
CapJitAddTypeSignatureDeferred( "MatricesForHomalg", "SyzygiesOfRows", [ "IsHomalgMatrix" ], "IsHomalgMatrix" );
CapJitAddTypeSignatureDeferred( "MatricesForHomalg", "SyzygiesOfColumns", [ "IsHomalgMatrix" ], "IsHomalgMatrix" );
CapJitAddTypeSignatureDeferred( "MatricesForHomalg", "SyzygiesOfRows", [ "IsHomalgMatrix", "IsHomalgMatrix" ], "IsHomalgMatrix" );
CapJitAddTypeSignatureDeferred( "MatricesForHomalg", "SyzygiesOfColumns", [ "IsHomalgMatrix", "IsHomalgMatrix" ], "IsHomalgMatrix" );
CapJitAddTypeSignatureDeferred( "MatricesForHomalg", "ReducedSyzygiesOfRows", [ "IsHomalgMatrix" ], "IsHomalgMatrix" );
CapJitAddTypeSignatureDeferred( "MatricesForHomalg", "ReducedSyzygiesOfColumns", [ "IsHomalgMatrix" ], "IsHomalgMatrix" );
CapJitAddTypeSignatureDeferred( "MatricesForHomalg", "ReducedSyzygiesOfRows", [ "IsHomalgMatrix", "IsHomalgMatrix" ], "IsHomalgMatrix" );
CapJitAddTypeSignatureDeferred( "MatricesForHomalg", "ReducedSyzygiesOfColumns", [ "IsHomalgMatrix", "IsHomalgMatrix" ], "IsHomalgMatrix" );
CapJitAddTypeSignatureDeferred( "MatricesForHomalg", "NumberRows", [ "IsHomalgMatrix" ], "IsInt" );
CapJitAddTypeSignatureDeferred( "MatricesForHomalg", "NumberColumns", [ "IsHomalgMatrix" ], "IsInt" );
CapJitAddTypeSignatureDeferred( "MatricesForHomalg", "RowRankOfMatrix", [ "IsHomalgMatrix" ], "IsInt" );
CapJitAddTypeSignatureDeferred( "MatricesForHomalg", "ColumnRankOfMatrix", [ "IsHomalgMatrix" ], "IsInt" );
CapJitAddTypeSignatureDeferred( "MatricesForHomalg", "UnionOfRows", [ "IsHomalgRing", "IsInt", "IsList" ], "IsHomalgMatrix" );
CapJitAddTypeSignatureDeferred( "MatricesForHomalg", "UnionOfColumns", [ "IsHomalgRing", "IsInt", "IsList" ], "IsHomalgMatrix" );
CapJitAddTypeSignatureDeferred( "MatricesForHomalg", "UnionOfRows", [ "IsHomalgMatrix", "IsHomalgMatrix", "IsHomalgMatrix" ], "IsHomalgMatrix" );
CapJitAddTypeSignatureDeferred( "MatricesForHomalg", "UnionOfColumns", [ "IsHomalgMatrix", "IsHomalgMatrix", "IsHomalgMatrix" ], "IsHomalgMatrix" );
CapJitAddTypeSignatureDeferred( "MatricesForHomalg", "DiagMat", [ "IsHomalgRing", "IsList" ], "IsHomalgMatrix" );
CapJitAddTypeSignatureDeferred( "MatricesForHomalg", "TransposedMatrix", [ "IsHomalgMatrix" ], "IsHomalgMatrix" );
CapJitAddTypeSignatureDeferred( "MatricesForHomalg", "CoefficientsWithGivenMonomials", [ "IsHomalgMatrix", "IsHomalgMatrix" ], "IsHomalgMatrix" );
CapJitAddTypeSignatureDeferred( "MatricesForHomalg", "CoefficientsWithGivenMonomials", [ "IsHomalgRingElement", "IsHomalgMatrix" ], "IsHomalgMatrix" );
CapJitAddTypeSignatureDeferred( "MatricesForHomalg", "CoercedMatrix", [ "IsHomalgRing", "IsHomalgRing", "IsHomalgMatrix" ], "IsHomalgMatrix" );
CapJitAddTypeSignatureDeferred( "MatricesForHomalg", "CoercedMatrix", [ "IsHomalgRing", "IsHomalgMatrix" ], "IsHomalgMatrix" );
CapJitAddTypeSignatureDeferred( "MatricesForHomalg", "Pullback", [ "IsHomalgRingMap", "IsHomalgMatrix" ], "IsHomalgMatrix" );
CapJitAddTypeSignatureDeferred( "MatricesForHomalg", "EntriesOfHomalgMatrix", [ "IsHomalgMatrix" ], "rec( filter := IsList, element_type := rec( filter := IsHomalgRingElement ) )" );
CapJitAddTypeSignatureDeferred( "MatricesForHomalg", "EntriesOfHomalgMatrixAsListList", [ "IsHomalgMatrix" ], "rec( filter := IsList, element_type := rec( filter := IsList, element_type := rec( filter := IsHomalgRingElement ) ) )" );
CapJitAddTypeSignatureDeferred( "MatricesForHomalg", "DecideZeroRows", [ "IsHomalgMatrix", "IsHomalgMatrix" ], "IsHomalgMatrix" );
CapJitAddTypeSignatureDeferred( "MatricesForHomalg", "DecideZeroColumns", [ "IsHomalgMatrix", "IsHomalgMatrix" ], "IsHomalgMatrix" );

CapJitAddTypeSignatureDeferred( "MatricesForHomalg", "+", [ "IsHomalgMatrix", "IsHomalgMatrix" ], "IsHomalgMatrix" );

CapJitAddTypeSignatureDeferred( "MatricesForHomalg", "*", [ "IsHomalgRingElement", "IsHomalgRingElement" ], "IsHomalgRingElement" );
CapJitAddTypeSignatureDeferred( "MatricesForHomalg", "*", [ "IsInt", "IsHomalgMatrix" ], "IsHomalgMatrix" );
CapJitAddTypeSignatureDeferred( "MatricesForHomalg", "*", [ "IsHomalgMatrix", "IsInt" ], "IsHomalgMatrix" );
CapJitAddTypeSignatureDeferred( "MatricesForHomalg", "*", [ "IsHomalgRingElement", "IsHomalgMatrix" ], "IsHomalgMatrix" );
CapJitAddTypeSignatureDeferred( "MatricesForHomalg", "*", [ "IsHomalgMatrix", "IsHomalgRingElement" ], "IsHomalgMatrix" );
CapJitAddTypeSignatureDeferred( "MatricesForHomalg", "*", [ "IsHomalgMatrix", "IsHomalgMatrix" ], "IsHomalgMatrix" );

# QPA operations
CapJitAddTypeSignatureDeferred( "QPA", "VertexIndex", [ "IsQuiverVertex" ], "IsInt" );
CapJitAddTypeSignatureDeferred( "QPA", "Representative", [ "IsQuotientOfPathAlgebraElement" ], "IsPathAlgebraElement" );
CapJitAddTypeSignatureDeferred( "QPA", "IsZero", [ "IsPathAlgebraElement" ], "IsBool" );
CapJitAddTypeSignatureDeferred( "QPA", "IsZero", [ "IsQuotientOfPathAlgebraElement" ], "IsBool" );
CapJitAddTypeSignatureDeferred( "QPA", "+", [ "IsPathAlgebraElement", "IsPathAlgebraElement" ], "IsPathAlgebraElement" );
CapJitAddTypeSignatureDeferred( "QPA", "+", [ "IsQuotientOfPathAlgebraElement", "IsQuotientOfPathAlgebraElement" ], "IsQuotientOfPathAlgebraElement" );
CapJitAddTypeSignatureDeferred( "QPA", "*", [ "IsPathAlgebraElement", "IsPathAlgebraElement" ], "IsPathAlgebraElement" );
CapJitAddTypeSignatureDeferred( "QPA", "*", [ "IsQuotientOfPathAlgebraElement", "IsQuotientOfPathAlgebraElement" ], "IsQuotientOfPathAlgebraElement" );
