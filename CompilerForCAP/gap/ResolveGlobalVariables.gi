# SPDX-License-Identifier: GPL-2.0-or-later
# CompilerForCAP: Speed up computations in CAP categories
#
# Implementations
#
BindGlobal( "CAP_JIT_NON_RESOLVABLE_GLOBAL_VARIABLE_NAMES", [
    "Julia", # if we resolve this, we lose information about the Julia module and operation
    "List",
    "ListN",
    "ObjectifyObjectForCAPWithAttributes",
    "ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes",
] );

InstallGlobalFunction( "CapJitResolvedGlobalVariables", function ( tree )
  local pre_func;
    
    Info( InfoCapJit, 1, "####" );
    Info( InfoCapJit, 1, "Resolving global variables." );
    
    pre_func := function ( tree, additional_arguments )
      local value, resolved_tree, name, attr, cat, global_variable_name;
        
        if not (IsBound( tree.CAP_JIT_NOT_RESOLVABLE ) and tree.CAP_JIT_NOT_RESOLVABLE) then
            
            # resolve category attributes
            if CapJitIsCallToGlobalFunction( tree, gvar -> not NameFunction( ValueGlobal( gvar ) ) in Concatenation( CAP_JIT_NON_RESOLVABLE_GLOBAL_VARIABLE_NAMES, RecNames( CAP_INTERNAL_METHOD_NAME_RECORD ), RecNames( CAP_JIT_INTERNAL_KNOWN_METHODS ) ) ) and tree.args.length = 1 and tree.args.1.type = "EXPR_REF_GVAR" and IsCapCategory( ValueGlobal( tree.args.1.gvar ) ) then
                
                value := ValueGlobal( tree.funcref.gvar )( ValueGlobal( tree.args.1.gvar ) );
                
                global_variable_name := CapJitGetOrCreateGlobalVariable( value );
                
                tree := rec(
                    type := "EXPR_REF_GVAR",
                    gvar := global_variable_name,
                );
                
            fi;
            
            # try to resolve global functions
            if tree.type = "EXPR_REF_GVAR" and not tree.gvar in CAP_JIT_NON_RESOLVABLE_GLOBAL_VARIABLE_NAMES then
                
                value := ValueGlobal( tree.gvar );
                
                if IsFunction( value ) then
                    
                    if not IsKernelFunction( value ) and not IsOperation( value ) then
                        
                        resolved_tree := ENHANCED_SYNTAX_TREE( value : globalize_hvars := true, only_if_CAP_JIT_RESOLVE_FUNCTION := true );
                        
                        if resolved_tree <> fail then
                            
                            if IsBound( tree.does_not_return_fail ) and tree.does_not_return_fail = true then
                                
                                resolved_tree := CapJitRemovedReturnFail( resolved_tree );
                                
                            fi;
                            
                            return resolved_tree;
                            
                        fi;
                        
                    fi;
                    
                    # normalize to the "official" name
                    name := NameFunction( value );
                    
                    if name <> tree.gvar and IsBoundGlobal( name ) and IsIdenticalObj( value, ValueGlobal( name ) ) then
                        
                        tree := ShallowCopy( tree );
                        
                        tree.gvar := name;
                        tree.CAP_JIT_NOT_RESOLVABLE := true;
                        
                        return tree;
                        
                    fi;
                    
                fi;
                
                # do not consider this tree again
                tree := ShallowCopy( tree );
                
                tree.CAP_JIT_NOT_RESOLVABLE := true;
                
                return tree;
                
            fi;
            
        fi;
        
        return tree;
        
    end;
    
    return CapJitIterateOverTree( tree, pre_func, CapJitResultFuncCombineChildren, ReturnTrue, true );
    
end );
