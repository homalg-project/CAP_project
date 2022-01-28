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
  local condition_func, path, record, operation, funccall_args, funccall_does_not_return_fail, operation_name, new_tree, category, resolved_tree, known_methods, func_to_resolve, global_variable_name, result, arguments, applicable_methods, parent, method;
    
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
        
        Info( InfoCapJit, 1, "This is a CAP operation, try to determine category and compile the added function." );
        
        Assert( 0, funccall_args.1.type = "EXPR_REF_GVAR" );
        
        category := ValueGlobal( funccall_args.1.gvar );
        
        Assert( 0, IsCapCategory( category ) );
        Assert( 0, CanCompute( category, operation_name ) );
        Assert( 0, not (IsBound( category!.stop_compilation ) and category!.stop_compilation = true) );
        
        resolved_tree := CapJitCompiledCAPOperationAsEnhancedSyntaxTree( category, operation_name );
        
        if funccall_does_not_return_fail then
            
            resolved_tree := CapJitRemovedReturnFail( resolved_tree );
            
        fi;
        
        new_tree := rec(
            type := "EXPR_FUNCCALL",
            funcref := resolved_tree,
            args := funccall_args,
        );
        
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
        
    else
        
        Info( InfoCapJit, 1, "Neither a CAP operation nor a known method." );
        
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
