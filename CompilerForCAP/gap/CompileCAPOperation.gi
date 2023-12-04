# SPDX-License-Identifier: GPL-2.0-or-later
# CompilerForCAP: Speed up computations in CAP categories
#
# Implementations
#
InstallGlobalFunction( "CapJitCompiledCAPOperationAsEnhancedSyntaxTree", function ( cat, operation_name, post_processing_enabled )
  local index, function_to_compile, global_variable_name, info, return_type, trees;
    
    Assert( 0, CanCompute( cat, operation_name ) );
    
    # find the last added function with no additional filters
    index := Last( PositionsProperty( cat!.added_functions.(operation_name), f -> Length( f[2] ) = 0 ) );
    
    if index = fail then
        
        # COVERAGE_IGNORE_NEXT_LINE
        Error( "All added functions for <operation_name> in <cat> have additional filters. Cannot continue with compilation." );
        
    fi;
    
    if not IsBound( cat!.compiled_functions_trees ) then
        
        cat!.compiled_functions_trees := rec( );
        cat!.compiled_functions_post_processed_trees := rec( );
        
    fi;
    
    if not IsBound( cat!.compiled_functions_trees.(operation_name) ) then
        
        cat!.compiled_functions_trees.(operation_name) := [ ];
        cat!.compiled_functions_post_processed_trees.(operation_name) := [ ];
        
    fi;
    
    if not IsBound( cat!.compiled_functions_trees.(operation_name)[index] ) then
        
        function_to_compile := cat!.added_functions.(operation_name)[index][1];
        
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
        
        return_type := info.return_type;
        
        if EndsWith( return_type, "fail" ) then
            
            Display( Concatenation(
                "WARNING: Compiling CAP operation ", operation_name, " with return_type ", return_type, ". ",
                "Operations returning fail usually do not fulfill the requirements that all branches of an if statement can be executed even if the corresponding condition does not hold. ",
                "This might cause errors."
            ) );
            
        fi;
        
        trees := CapJitCompiledFunctionAsEnhancedSyntaxTree( function_to_compile, "with_and_without_post_processing", cat, info.filter_list, return_type );
        
        cat!.compiled_functions_trees.(operation_name)[index] := trees[1];
        cat!.compiled_functions_post_processed_trees.(operation_name)[index] := trees[2];
        
    fi;
    
    if post_processing_enabled then
        
        return CapJitCopyWithNewFunctionIDs( cat!.compiled_functions_post_processed_trees.(operation_name)[index] );
        
    else
        
        return CapJitCopyWithNewFunctionIDs( cat!.compiled_functions_trees.(operation_name)[index] );
        
    fi;
    
end );
