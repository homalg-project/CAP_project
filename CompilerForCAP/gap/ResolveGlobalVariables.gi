# SPDX-License-Identifier: GPL-2.0-or-later
# CompilerForCAP: Speed up computations in CAP categories
#
# Implementations
#
BindGlobal( "CAP_JIT_NON_RESOLVABLE_GLOBAL_VARIABLE_NAMES", [
    "Julia", # if we resolve this, we lose information about the Julia module and operation
    "List",
    "ListN",
    "CreateCapCategoryObjectWithAttributes",
    "CreateCapCategoryMorphismWithAttributes",
    "CAP_JIT_INCOMPLETE_LOGIC",
] );

InstallGlobalFunction( "CapJitResolvedGlobalVariables", function ( tree )
  local result_func;
    
    Info( InfoCapJit, 1, "####" );
    Info( InfoCapJit, 1, "Resolving global variables." );
    
    # we have to use result_func instead of pre_func to correctly resolve `Attribute( UnderlyingCategory( cat ) )`
    result_func := function ( tree, result, keys, additional_arguments )
      local value, global_variable_name, data_type, resolved_tree, name, key;
        
        tree := ShallowCopy( tree );
        
        for key in keys do
            
            tree.(key) := result.(key);
            
        od;
        
        if not (IsBound( tree.CAP_JIT_NOT_RESOLVABLE ) and tree.CAP_JIT_NOT_RESOLVABLE) then
            
            # resolve category attributes
            if CapJitIsCallToGlobalFunction( tree, gvar -> not NameFunction( ValueGlobal( gvar ) ) in Concatenation( CAP_JIT_NON_RESOLVABLE_GLOBAL_VARIABLE_NAMES, RecNames( CAP_INTERNAL_METHOD_NAME_RECORD ), RecNames( CAP_JIT_INTERNAL_KNOWN_METHODS ) ) ) and tree.args.length = 1 and tree.args.1.type = "EXPR_REF_GVAR" and IsCapCategory( ValueGlobal( tree.args.1.gvar ) ) then
                
                value := ValueGlobal( tree.funcref.gvar )( ValueGlobal( tree.args.1.gvar ) );
                
                global_variable_name := CapJitGetOrCreateGlobalVariable( value );
                
                if CAP_JIT_DATA_TYPE_INFERENCE_ENABLED then
                    
                    data_type := CAP_JIT_INTERNAL_GET_OUTPUT_TYPE_OF_GLOBAL_FUNCTION_BY_INPUT_TYPES( NameFunction( ValueGlobal( tree.funcref.gvar ) ), [ CapJitDataTypeOfCategory( ValueGlobal( tree.args.1.gvar ) ) ] );
                    
                else
                    
                    data_type := fail;
                    
                fi;
                
                tree := rec(
                    type := "EXPR_REF_GVAR",
                    gvar := global_variable_name,
                );
                
                if data_type <> fail then
                    
                    tree.data_type := data_type;
                    
                fi;
                
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
                            
                            return CapJitResolvedGlobalVariables( resolved_tree );
                            
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
    
    return CapJitIterateOverTree( tree, ReturnFirst, result_func, ReturnTrue, true );
    
end );
