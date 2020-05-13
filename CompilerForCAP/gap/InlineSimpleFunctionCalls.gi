InstallGlobalFunction( CapJitInlinedSimpleFunctionCalls, function( tree )
  local pre_func;
    
    Info( InfoCapJit, 1, "####" );
    Info( InfoCapJit, 1, "Inline simple function calls." );
    
    pre_func := function( tree, additional_arguments )
      local statements, statement, search_paths, condition_func, func_call, search_tree, found_path, path, inline_func, counter, new_nams, inline_func_stats, offset, inline_return_statement, return_value_lvar, inlined_original_statement, ref_return_value_lvar, parent, i, search_path;
        
        if IsRecord( tree ) and tree.type = "EXPR_FUNCCALL" and tree.funcref.type = "EXPR_FUNC" and Length( tree.funcref.stats.statements ) = 1 and tree.funcref.stats.statements[1].type = "STAT_RETURN_OBJ" then
            
            if not ( Length( tree.args ) = 0 and tree.funcref.narg = 0 ) then
                
                Error( "found function call with arguments, please inline arguments first" );
                
            fi;

            Info( InfoCapJit, 1, "####" );
            Info( InfoCapJit, 1, "Inlined simple function call." );
    
            return tree.funcref.stats.statements[1].obj;
            
        fi;

        return tree;
        
    end;

    return CapJitIterateOverTree( tree, pre_func, CapJitResultFuncCombineChildren, ReturnTrue, true );
    
end );
