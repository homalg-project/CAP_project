# SPDX-License-Identifier: GPL-2.0-or-later
# CompilerForCAP: Speed up computations in CAP categories
#
# Implementations
#
InstallGlobalFunction( CapJitGetCapCategoryFromArguments, function ( arguments )
  local result;
    
    if IsList( arguments ) then
        
        result := List( arguments, arg -> CapJitGetCapCategoryFromArguments( arg ) );
        
        return First( result, r -> r <> fail );
        
    elif IsCapCategory( arguments ) then
        
        return arguments;
        
    elif HasCapCategory( arguments ) then
        
        return CapCategory( arguments );
    
    else
        
        return fail;

    fi;
    
end );

InstallGlobalFunction( CapJitResolvedOperations, function ( tree, jit_args )
  local condition_func, path, record, operation, funccall_args, result, operation_name, arguments, new_tree, category, global_variable_name, operation_name_record_entry, installation_name, filter_list, replaced_filter_list, positions, index, func_to_resolve, applicable_methods, resolved_tree, parent, method;
    
    tree := StructuralCopy( tree );
  
    # find resolvable operation
    condition_func := function ( tree, path )
        
        if IsBound( tree.CAP_JIT_IGNORE_OPERATION ) and tree.CAP_JIT_IGNORE_OPERATION then
            
            return false;
            
        fi;
        
        if tree.type = "EXPR_FUNCCALL" and tree.funcref.type = "EXPR_REF_GVAR" then
            
            # not all CAP operations are operations in the GAP sense
            return tree.funcref.gvar in RecNames( CAP_INTERNAL_METHOD_NAME_RECORD ) or IsOperation( ValueGlobal( tree.funcref.gvar ) );
            
        fi;

        if tree.type = "EXPR_ELM_MAT" then
            
            return true;
            
        fi;
        
        return false;
        
    end;
    
    path := CapJitFindNodeDeep( tree, condition_func );
    
    if path = fail then
        
        return tree;
        
    fi;
    
    record := CapJitGetNodeByPath( tree, path );
    
    if record.type = "EXPR_FUNCCALL" then
        
        operation := ValueGlobal( record.funcref.gvar );

        funccall_args := record.args;
        
        result := CapJitGetFunctionCallArgumentsFromJitArgs( tree, path, jit_args );
        
    elif record.type = "EXPR_ELM_MAT" then
        
        operation := \[\,\];

        funccall_args := [ record.list, record.row, record.col ];
        
        # get values of "list", "row" and "col"
        
        arguments := [ ];
        
        result := CapJitGetExpressionValueFromJitArgs( tree, Concatenation( path, [ "list" ] ), jit_args );
        
        if result[1] <> false then
            
            arguments[1] := result[2];
            
            result := CapJitGetExpressionValueFromJitArgs( tree, Concatenation( path, [ "row" ] ), jit_args );
            
            if result[1] <> false then
                
                arguments[2] := result[2];
                
                result := CapJitGetExpressionValueFromJitArgs( tree, Concatenation( path, [ "col" ] ), jit_args );
                
                if result[1] <> false then
                    
                    arguments[3] := result[2];
                    
                    result := [ true, arguments ];
                    
                fi;
                
            fi;
            
        fi;
        
    else
        
        Error( "this should never happen" );
        
    fi;
        
    operation_name := NameFunction( operation );
    
    Info( InfoCapJit, 1, "####" );
    Info( InfoCapJit, 1, Concatenation( "Try to resolve ", operation_name, "." ) );
    
    if result[1] = false then
        
        Info( InfoCapJit, 1, "Could not get arguments. Skip resolving..." );

        record.CAP_JIT_IGNORE_OPERATION := true;
        
    else

        arguments := result[2];
        
        new_tree := fail;
        
        # special case: CapCategory
        if IsIdenticalObj( operation, CapCategory ) then
            
            Info( InfoCapJit, 1, "Determine category." );
            
            Assert( 0, Length( arguments ) = 1 and HasCapCategory( arguments[1] ) );
            
            category := CapCategory( arguments[1] );
            
            global_variable_name := CapJitGetOrCreateGlobalVariable( category );
            
            new_tree := rec(
                type := "EXPR_REF_GVAR",
                gvar := global_variable_name,
            );
            
        # special case: this is a CAP operation
        elif operation_name in RecNames( CAP_INTERNAL_METHOD_NAME_RECORD ) then
            
            Info( InfoCapJit, 1, "This is a CAP operation, try to determine category and take the added function." );

            operation_name_record_entry := CAP_INTERNAL_METHOD_NAME_RECORD.(operation_name);
            
            installation_name := operation_name_record_entry.installation_name;
            filter_list := operation_name_record_entry.filter_list;
            replaced_filter_list := CAP_INTERNAL_REPLACE_STRINGS_WITH_FILTERS( filter_list );
            
            # prepare Op
            if Concatenation( operation_name, "Op" ) = installation_name then
                
                filter_list := filter_list{[ 1 .. Length( filter_list ) - 1 ]};
                
            fi;

            Assert( 0, not IsBound( operation_name_record_entry.argument_list ) or operation_name_record_entry.argument_list = [ 1 .. Length( filter_list ) ] );
            
            # check that arguments lie in filter
            if Length( filter_list ) = Length( arguments ) and ForAll( [ 1 .. Length( filter_list ) ], i -> replaced_filter_list[i](arguments[i]) ) then
                
                # do not infer category from other_object et al.
                positions := PositionsProperty( filter_list, x -> x in [ "category", "object", "morphism", "twocell", "list_of_objects", "list_of_morphisms" ] );
                category := CapJitGetCapCategoryFromArguments( arguments{positions} );
                
                if category = fail then
                    
                    Error( "could not get category from arguments" );
                    
                fi;

                Assert( 0, CanCompute( category, operation_name ) );
                
                # find the last added function with no additional filters
                index := Last( PositionsProperty( category!.added_functions.(operation_name), f -> Length( f[2] ) = 0 ) );
                
                if IsBound( category!.stop_compilation ) and category!.stop_compilation = true then
                    
                    Info( InfoCapJit, 1, "Compilation stops at this category." );
                    
                elif index = fail then
                    
                    Info( InfoCapJit, 1, "All added functions have additional filters." );
                    
                else
                    
                    if IsBound( category!.compiled_functions.(operation_name)[index] ) then
                        
                        Info( InfoCapJit, 1, Concatenation( "Taking compiled function with index ", String( index ), "." ) );
                        
                        func_to_resolve := category!.compiled_functions.(operation_name)[index];
                        
                    else
                        
                        Info( InfoCapJit, 1, Concatenation( "Taking added function with index ", String( index ), "." ) );
                        
                        func_to_resolve := category!.added_functions.(operation_name)[index][1];
                        
                    fi;
                    
                    if IsOperation( func_to_resolve ) or IsKernelFunction( func_to_resolve ) then
                        
                        # cannot resolve recursive calls
                        if not IsIdenticalObj( func_to_resolve, operation ) then
                            
                            # will be handled in the next iteration
                            global_variable_name := CapJitGetOrCreateGlobalVariable( func_to_resolve );
                            
                            new_tree := rec(
                                type := "EXPR_FUNCCALL",
                                funcref := rec(
                                    type := "EXPR_REF_GVAR",
                                    gvar := global_variable_name,
                                ),
                                args := funccall_args,
                            );
                            
                        fi;
                        
                    else
                    
                        new_tree := rec(
                            type := "EXPR_FUNCCALL",
                            funcref := ENHANCED_SYNTAX_TREE( func_to_resolve, true ),
                            args := funccall_args,
                        );

                    fi;
                    
                fi;
            
            fi;
            
        fi;
        
        if new_tree = fail and IsOperation( operation ) then
            
            Info( InfoCapJit, 1, "Try applicable methods." );

            applicable_methods := ApplicableMethod( operation, arguments, 0, "all" );
            
            for method in applicable_methods do
                
                if not IsKernelFunction( method ) then
                
                    resolved_tree := ENHANCED_SYNTAX_TREE( method, true );
                    
                    if Length( resolved_tree.stats.statements ) >= 1 and resolved_tree.stats.statements[1].type = "STAT_PRAGMA" and resolved_tree.stats.statements[1].value = "% CAP_JIT_RESOLVE_FUNCTION" then
                        
                        Info( InfoCapJit, 1, "Found suitable applicable method." );
                        
                        # remove pragma
                        resolved_tree.stats.statements := resolved_tree.stats.statements{[ 2 .. Length( resolved_tree.stats.statements ) ]};
                        
                        new_tree := rec(
                            type := "EXPR_FUNCCALL",
                            funcref := resolved_tree,
                            args := funccall_args,
                        );

                        break;
                        
                    fi;
                    
                fi;
                
            od;
            
        fi;

        if new_tree <> fail then
            
            parent := CapJitGetNodeByPath( tree, path{[ 1 .. Length( path ) - 1 ]} );

            if IsList( parent ) then
                
                parent[Last( path )] := new_tree;
                
            else
                
                parent.(Last( path )) := new_tree;
                
            fi;
            
            Info( InfoCapJit, 1, "Successfully resolved operation." );
            
        else
            
            Info( InfoCapJit, 1, "Could not find suitable function. Skip resolving..." );
            
            record.CAP_JIT_IGNORE_OPERATION := true;
            
        fi;
                
    fi;

    # resolve next operation
    return CapJitResolvedOperations( tree, jit_args );
    
end );
