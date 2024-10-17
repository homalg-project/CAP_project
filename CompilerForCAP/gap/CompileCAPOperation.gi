# SPDX-License-Identifier: GPL-2.0-or-later
# CompilerForCAP: Speed up and verify categorical algorithms
#
# Implementations
#
InstallGlobalFunction( "CapJitCompiledCAPOperationAsEnhancedSyntaxTree", function ( cat, operation_name )
  local function_to_compile, global_variable_name, info;
    
    Assert( 0, CanCompute( cat, operation_name ) );
    
    if not IsBound( cat!.compiled_functions_trees ) then
        
        cat!.compiled_functions_trees := rec( );
        
    fi;
    
    if not IsBound( cat!.compiled_functions_trees.(operation_name) ) then
        
        if IsBound( cat!.cached_precompiled_functions.(operation_name) ) then
            
            function_to_compile := cat!.cached_precompiled_functions.(operation_name);
            
        else
            
            function_to_compile := cat!.operations.(operation_name).func;
            
        fi;
        
        if IsOperation( function_to_compile ) or IsKernelFunction( function_to_compile ) then
            
            global_variable_name := CapJitGetOrCreateGlobalVariable( function_to_compile );
            
            function_to_compile := EvalString( ReplacedStringViaRecord(
                "{ input_arguments... } -> global_variable_name( input_arguments... )",
                rec(
                    input_arguments := CAP_INTERNAL_METHOD_NAME_RECORD.(operation_name).input_arguments_names,
                    global_variable_name := global_variable_name,
                )
            ) );
            
        fi;
        
        info := CAP_INTERNAL_METHOD_NAME_RECORD.(operation_name);
        
        cat!.compiled_functions_trees.(operation_name) := CapJitCompiledFunctionAsEnhancedSyntaxTree( function_to_compile, cat, info.filter_list, info.return_type );
        
    fi;
    
    return CapJitCopyWithNewFunctionIDs( cat!.compiled_functions_trees.(operation_name) );
    
end );
