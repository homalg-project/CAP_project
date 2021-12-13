# SPDX-License-Identifier: GPL-2.0-or-later
# CompilerForCAP: Speed up computations in CAP categories
#
# Implementations
#
BindGlobal( "CAP_JIT_NON_RESOLVABLE_OPERATION_NAMES", [
    "DecideZeroColumns",
    "DecideZeroRows",
    "IsZero",
] );

InstallGlobalFunction( CapJitResolvedOperations, function ( tree, jit_args )
  local condition_func, path, record, operation, funccall_args, funccall_does_not_return_fail, operation_name, new_tree, category, index, func_to_resolve, result, example_input, global_variable_name, resolved_tree, known_methods, pos, arguments, applicable_methods, parent, method;
    
    tree := StructuralCopy( tree );
  
    # find resolvable operation
    condition_func := function ( tree, path )
      local operation, operation_name, category;
        
        if IsBound( tree.CAP_JIT_IGNORE_OPERATION ) and tree.CAP_JIT_IGNORE_OPERATION then
            
            return false;
            
        fi;
        
        if tree.type = "EXPR_FUNCCALL" and tree.funcref.type = "EXPR_REF_GVAR" then
            
            operation := ValueGlobal( tree.funcref.gvar );
            
            operation_name := NameFunction( operation );
            
            # check if this is a CAP operation which is not a convenience method or if we know methods for this operation
            if (operation_name in RecNames( CAP_INTERNAL_METHOD_NAME_RECORD ) and tree.args.length = Length( CAP_INTERNAL_METHOD_NAME_RECORD.(operation_name).filter_list )) or operation_name in RecNames( CAP_JIT_INTERNAL_KNOWN_METHODS ) then
                
                # we can resolve CAP operations if and only if the category is known, i.e., stored in a global variable
                if tree.args.1.type = "EXPR_REF_GVAR" then
                    
                    category := ValueGlobal( tree.args.1.gvar );
                    
                    Assert( 0, IsCapCategory( category ) );
                    
                    if IsBound( category!.stop_compilation ) and category!.stop_compilation = true then
                        
                        return false;
                        
                    else
                        
                        return true;
                        
                    fi;
                    
                else
                    
                    return false;
                    
                fi;
                
            fi;
            
            if IsOperation( operation ) and not operation_name in CAP_JIT_NON_RESOLVABLE_OPERATION_NAMES then
                
                return true;
                
            fi;
            
        fi;
        
        return false;
        
    end;
    
    path := CapJitFindNodeDeep( tree, condition_func );
    
    if path = fail then
        
        Info( InfoCapJit, 1, "Could not find operation to resolve" );
        
        return tree;
        
    fi;
    
    record := CapJitGetNodeByPath( tree, path );
    
    operation := ValueGlobal( record.funcref.gvar );
    
    funccall_args := record.args;
    
    funccall_does_not_return_fail := IsBound( record.funcref.does_not_return_fail ) and record.funcref.does_not_return_fail = true;
    
    operation_name := NameFunction( operation );
    
    Info( InfoCapJit, 1, "####" );
    Info( InfoCapJit, 1, Concatenation( "Try to resolve ", operation_name, "." ) );
    
    new_tree := fail;
    
    # check if this is a CAP operation which is not a convenience method
    if operation_name in RecNames( CAP_INTERNAL_METHOD_NAME_RECORD ) and funccall_args.length = Length( CAP_INTERNAL_METHOD_NAME_RECORD.(operation_name).filter_list ) then
        
        Info( InfoCapJit, 1, "This is a CAP operation, try to determine category and take the added function." );
        
        Assert( 0, funccall_args.1.type = "EXPR_REF_GVAR" );
        
        category := ValueGlobal( funccall_args.1.gvar );
        
        Assert( 0, IsCapCategory( category ) );
        Assert( 0, CanCompute( category, operation_name ) );
        Assert( 0, not (IsBound( category!.stop_compilation ) and category!.stop_compilation = true) );
        
        if not (IsBound( category!.category_as_first_argument ) and category!.category_as_first_argument = true) then
            
            # COVERAGE_IGNORE_NEXT_LINE
            Error( "only operations of categories with `category!.category_as_first_argument = true` can be resolved" );
            
        fi;
        
        # find the last added function with no additional filters
        index := Last( PositionsProperty( category!.added_functions.(operation_name), f -> Length( f[2] ) = 0 ) );
        
        if index = fail then
            
            # COVERAGE_IGNORE_NEXT_LINE
            Error( "All added functions for <operation> in <category> have additional filters. Cannot continue with compilation." );
            
        fi;
        
        func_to_resolve := category!.added_functions.(operation_name)[index][1];
        
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
                
                if funccall_does_not_return_fail then
                    
                    new_tree.funcref.does_not_return_fail := true;
                    
                fi;
                
            fi;
            
        else
            
            if IsBound( category!.compiled_functions_trees.(operation_name)[index] ) then
                
                Info( InfoCapJit, 1, Concatenation( "Taking compiled function with index ", String( index ), "." ) );
                
                resolved_tree := CapJitCopyWithNewFunctionIDs( category!.compiled_functions_trees.(operation_name)[index] );
                
            else
                
                Info( InfoCapJit, 1, Concatenation( "Taking added function with index ", String( index ), "." ) );
                
                if not tree.variadic and Length( jit_args ) = tree.narg then
                    
                    result := CapJitGetFunctionCallArgumentsFromJitArgs( tree, path, jit_args );
                    
                else
                    
                    result := [ false ];
                    
                fi;
                
                if result[1] = false then
                    
                    example_input := [ category ];
                    
                else
                    
                    example_input := result[2];
                    
                fi;
                
                resolved_tree := CapJitCompiledFunctionAsEnhancedSyntaxTree( func_to_resolve, example_input );
                
                category!.compiled_functions_trees.(operation_name)[index] := resolved_tree;
                
            fi;
            
            if funccall_does_not_return_fail then
                
                resolved_tree := CapJitRemovedReturnFail( resolved_tree );
                
            fi;
            
            new_tree := rec(
                type := "EXPR_FUNCCALL",
                funcref := resolved_tree,
                args := funccall_args,
            );
            
        fi;
        
    # check if we know methods for this operation
    elif operation_name in RecNames( CAP_JIT_INTERNAL_KNOWN_METHODS ) then
        
        Info( InfoCapJit, 1, "Methods are known for this operation." );
        
        Assert( 0, funccall_args.1.type = "EXPR_REF_GVAR" );
        
        category := ValueGlobal( funccall_args.1.gvar );
        
        Assert( 0, IsCapCategory( category ) );
        Assert( 0, not (IsBound( category!.stop_compilation ) and category!.stop_compilation = true) );
        
        known_methods := Filtered( CAP_JIT_INTERNAL_KNOWN_METHODS.(operation_name),
            m -> Length( m.filters ) = funccall_args.length and m.filters[1]( category )
        );
        
        if not IsEmpty( known_methods ) then
            
            if Length( known_methods ) > 1 then
                
                # COVERAGE_IGNORE_NEXT_LINE
                Error( "Found more than one known method for ", operation_name, " with correct length and category filter" );
                
            fi;
            
            func_to_resolve := known_methods[1].method;
            
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
                    
                    if funccall_does_not_return_fail then
                        
                        new_tree.funcref.does_not_return_fail := true;
                        
                    fi;
                    
                fi;
                
            else
                
                resolved_tree := ENHANCED_SYNTAX_TREE( func_to_resolve : globalize_hvars := true );
                
                if funccall_does_not_return_fail then
                    
                    resolved_tree := CapJitRemovedReturnFail( resolved_tree );
                    
                fi;
                
                new_tree := rec(
                    type := "EXPR_FUNCCALL",
                    funcref := resolved_tree,
                    args := funccall_args,
                );
                
            fi;
            
        fi;
        
    elif Length( jit_args ) = tree.narg and not tree.variadic then
        
        result := CapJitGetFunctionCallArgumentsFromJitArgs( tree, path, jit_args );
        
        if result[1] = false then
            
            Info( InfoCapJit, 1, "Could not get arguments. Skip resolving..." );
            
            record.CAP_JIT_IGNORE_OPERATION := true;
            
        else
            
            arguments := result[2];
            
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
                
            elif IsOperation( operation ) then
                
                Info( InfoCapJit, 1, "Try applicable methods." );
                
                # check if we deal with a KeyDependentOperation
                if operation in WRAPPER_OPERATIONS then
                    
                    operation_name := Concatenation( operation_name, "Op" );
                    
                    Assert( 0, IsBoundGlobal( operation_name ) );
                    
                    operation := ValueGlobal( operation_name );
                    
                fi;
                
                applicable_methods := ApplicableMethod( operation, arguments, 0, "all" );
                
                for method in applicable_methods do
                    
                    if not IsKernelFunction( method ) then
                        
                        resolved_tree := ENHANCED_SYNTAX_TREE( method : globalize_hvars := true, only_if_CAP_JIT_RESOLVE_FUNCTION );
                        
                        if resolved_tree <> fail then
                            
                            Info( InfoCapJit, 1, "Found suitable applicable method." );
                            
                            if funccall_does_not_return_fail then
                                
                                resolved_tree := CapJitRemovedReturnFail( resolved_tree );
                                
                            fi;
                            
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

        fi;
        
    else
        
        Info( InfoCapJit, 1, "Not enough JIT arguments for getting the function via `ApplicableMethod`." );
        
    fi;
    
    if new_tree <> fail then
        
        parent := CapJitGetNodeByPath( tree, path{[ 1 .. Length( path ) - 1 ]} );
        
        parent.(Last( path )) := new_tree;
        
        Info( InfoCapJit, 1, "Successfully resolved operation." );
        
    else
        
        Info( InfoCapJit, 1, "Could not find suitable function. Skip resolving..." );
        
        record.CAP_JIT_IGNORE_OPERATION := true;
        
    fi;
    
    # resolve next operation
    return CapJitResolvedOperations( tree, jit_args );
    
end );
