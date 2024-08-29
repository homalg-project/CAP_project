# SPDX-License-Identifier: GPL-2.0-or-later
# CompilerForCAP: Speed up and verify categorical algorithms
#
# Implementations
#
InstallGlobalFunction( "CapJitCompiledCAPOperationAsEnhancedSyntaxTree", function ( cat, operation_name, post_processing_enabled )
  local function_to_compile, global_variable_name, info, trees;
    
    Assert( 0, CanCompute( cat, operation_name ) );
    
    if not IsBound( cat!.compiled_functions_trees ) then
        
        cat!.compiled_functions_trees := rec( );
        cat!.compiled_functions_post_processed_trees := rec( );
        
    fi;
    
    if not IsBound( cat!.compiled_functions_trees.(operation_name) ) then
        
        function_to_compile := Last( cat!.added_functions.(operation_name) );
        
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
        
        trees := CapJitCompiledFunctionAsEnhancedSyntaxTree( function_to_compile, "with_and_without_post_processing", cat, info.filter_list, info.return_type );
        
        cat!.compiled_functions_trees.(operation_name) := trees[1];
        cat!.compiled_functions_post_processed_trees.(operation_name) := trees[2];
        
    fi;
    
    if post_processing_enabled then
        
        return CapJitCopyWithNewFunctionIDs( cat!.compiled_functions_post_processed_trees.(operation_name) );
        
    else
        
        return CapJitCopyWithNewFunctionIDs( cat!.compiled_functions_trees.(operation_name) );
        
    fi;
    
end );
