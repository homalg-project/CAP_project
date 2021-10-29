# SPDX-License-Identifier: GPL-2.0-or-later
# CompilerForCAP: Speed up computations in CAP categories
#
# Implementations
#
InstallGlobalFunction( CapJitInlinedBindings, function ( tree )
  local inline_gvars_only, pre_func, additional_arguments_func;
    
    inline_gvars_only := ValueOption( "inline_gvars_only" ) = true;
    
    pre_func := function ( tree, func_stack )
      local func, value;
        
        if tree.type = "EXPR_REF_FVAR" then
            
            Info( InfoCapJit, 1, "####" );
            Info( InfoCapJit, 1, "Inline binding with name ", tree.name, "." );
            
            func := First( func_stack, func -> func.id = tree.func_id );
            Assert( 0, func <> fail );
            
            # the fvar might be an argument, which has no binding
            if Position( func.nams, tree.name ) > func.narg then
                
                value := CapJitValueOfBinding( func.bindings, tree.name );
                
                if not inline_gvars_only or value.type = "EXPR_REF_GVAR" then
                    
                    return CapJitCopyWithNewFunctionIDs( value );
                    
                fi;
                
            fi;
            
        fi;
        
        return tree;
        
    end;
    
    additional_arguments_func := function ( tree, key, func_stack )
        
        if tree.type = "EXPR_DECLARATIVE_FUNC" then
            
            return Concatenation( func_stack, [ tree ] );
            
        else
            
            return func_stack;
            
        fi;
        
    end;
    
    return CapJitIterateOverTree( tree, pre_func, CapJitResultFuncCombineChildren, additional_arguments_func, [ ] );
    
end );

InstallGlobalFunction( CapJitInlinedBindingsToGlobalVariables, function ( tree )
    
    return CapJitInlinedBindings( tree : inline_gvars_only := true );
    
end );
