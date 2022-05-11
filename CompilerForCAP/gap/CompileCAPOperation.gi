# SPDX-License-Identifier: GPL-2.0-or-later
# CompilerForCAP: Speed up computations in CAP categories
#
# Implementations
#
InstallGlobalFunction( "CapJitCompiledCAPOperationAsEnhancedSyntaxTree", function ( cat, operation_name )
  local index, function_to_compile, info, filter_list, return_type;
    
    if not (IsBound( cat!.category_as_first_argument ) and cat!.category_as_first_argument = true) then
        
        # COVERAGE_IGNORE_NEXT_LINE
        Error( "only CAP operations of categories with `cat!.category_as_first_argument = true` can be compiled" );
        
    fi;
    
    # find the last added function with no additional filters
    index := Last( PositionsProperty( cat!.added_functions.(operation_name), f -> Length( f[2] ) = 0 ) );
    
    if index = fail then
        
        # COVERAGE_IGNORE_NEXT_LINE
        Error( "All added functions for <operation_name> in <cat> have additional filters. Cannot continue with compilation." );
        
    fi;
    
    if not IsBound( cat!.compiled_functions_trees ) then
        
        cat!.compiled_functions_trees := rec( );
        
    fi;
    
    if not IsBound( cat!.compiled_functions_trees.(operation_name) ) then
        
        cat!.compiled_functions_trees.(operation_name) := [ ];
        
    fi;
    
    if not IsBound( cat!.compiled_functions_trees.(operation_name)[index] ) then
        
        function_to_compile := cat!.added_functions.(operation_name)[index][1];
        
        if IsOperation( function_to_compile ) or IsKernelFunction( function_to_compile ) then
            
            # COVERAGE_IGNORE_NEXT_LINE
            Error( "compiling operations or kernel functions is not supported." );
            
        fi;
        
        info := CAP_INTERNAL_METHOD_NAME_RECORD.(operation_name);
        
        return_type := info.return_type;
        
        if IsString( return_type ) and EndsWith( return_type, "fail" ) then
            
            Display( Concatenation(
                "WARNING: Compiling CAP operation ", operation_name, " with return_type ", return_type, ". ",
                "Operations returning fail usually do not fulfill the requirements that all branches of an if statement can be executed even if the corresponding condition does not hold. ",
                "This might cause errors."
            ) );
            
        fi;
        
        cat!.compiled_functions_trees.(operation_name)[index] := CapJitCompiledFunctionAsEnhancedSyntaxTree( function_to_compile, cat, info.filter_list, return_type );
        
    fi;
    
    return CapJitCopyWithNewFunctionIDs( cat!.compiled_functions_trees.(operation_name)[index] );
    
end );
