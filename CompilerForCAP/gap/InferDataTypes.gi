# SPDX-License-Identifier: GPL-2.0-or-later
# CompilerForCAP: Speed up computations in CAP categories
#
# Implementations
#

BindGlobal( "CAP_JIT_INTERNAL_GLOBAL_VARIABLE_FILTERS", [ ] );

BindGlobal( "CAP_JIT_INTERNAL_TYPE_SIGNATURES", rec( ) );

InstallGlobalFunction( "CapJitAddTypeSignature", function ( name, input_filters, output_data_type )
    
    if not IsList( input_filters ) then
        
        # COVERAGE_IGNORE_NEXT_LINE
        Error( "<input_filters> must be a list" );
        
    fi;
    
    if not ForAll( input_filters, filter -> IsFilter( filter ) ) then
        
        # COVERAGE_IGNORE_NEXT_LINE
        Error( "<input_filters> must be a list of filters" );
        
    fi;
    
    if not IsBound( CAP_JIT_INTERNAL_TYPE_SIGNATURES.(name) ) then
        
        CAP_JIT_INTERNAL_TYPE_SIGNATURES.(name) := [ ];
        
    fi;
    
    if ForAny( CAP_JIT_INTERNAL_TYPE_SIGNATURES.(name), signature -> IsSpecializationOfFilterList( signature[1], input_filters ) or IsSpecializationOfFilterList( input_filters, signature[1] ) ) then
        
        # COVERAGE_IGNORE_NEXT_LINE
        Error( "there already exists a signature for ", name, " with filters implying the current filters or being implied by them" );
        
    fi;
    
    if not ForAny( [ IsFilter, IsRecord, IsFunction ], f -> f( output_data_type ) ) then
        
        # COVERAGE_IGNORE_NEXT_LINE
        Error( "<output_data_type> must be a filter, a record, or a function" );
        
    fi;
    
    if IsFilter( output_data_type ) then
        
        output_data_type := rec( filter := output_data_type );
        
    fi;
    
    Add( CAP_JIT_INTERNAL_TYPE_SIGNATURES.(name), [ input_filters, output_data_type ] );
    
end );

InstallGlobalFunction( "CAP_JIT_INTERNAL_GET_OUTPUT_TYPE_OF_GLOBAL_FUNCTION_BY_INPUT_FILTERS", function ( gvar, input_filters )
  local type_signatures;
    
    if not IsBound( CAP_JIT_INTERNAL_TYPE_SIGNATURES.(gvar) ) then
        
        #Error( "Could not find declaration of ", gvar, " (current input: ", input_filters, ")" );
        return fail;
        
    fi;
    
    type_signatures := Filtered( CAP_JIT_INTERNAL_TYPE_SIGNATURES.(gvar), s -> IsSpecializationOfFilterList( s[1], input_filters ) );
    
    if Length( type_signatures ) = 0 then
        
        #Error( "Could not find matching declaration of ", gvar, " for input ", input_filters );
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
      local data_type, filter, func, pos, key;
        
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
            
            filter := First( CAP_JIT_INTERNAL_GLOBAL_VARIABLE_FILTERS, filter -> filter( ValueGlobal( tree.gvar ) ) );
            
            if IsCapCategory( ValueGlobal( tree.gvar ) ) then
                
                data_type := rec( filter := IsCapCategory, category := ValueGlobal( tree.gvar ) );
                
            elif IsList( ValueGlobal( tree.gvar ) ) and Length( ValueGlobal( tree.gvar ) ) > 0 then
                
                filter := First( CAP_JIT_INTERNAL_GLOBAL_VARIABLE_FILTERS, filter -> filter( ValueGlobal( tree.gvar )[1] ) );
                
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
