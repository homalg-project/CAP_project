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
    # we do not want to simplify (Is)BigInt to IsInt resp. IdFunc to keep the distinction for Julia
    "IsBigInt",
    "BigInt",
] );

InstallGlobalFunction( "CapJitResolvedGlobalVariables", function ( tree )
  local result_func;
    
    Info( InfoCapJit, 1, "####" );
    Info( InfoCapJit, 1, "Resolving global variables." );
    
    # we have to use result_func instead of pre_func to correctly resolve `Attribute( UnderlyingCategory( cat ) )`
    result_func := function ( tree, result, keys, additional_arguments )
      local cat, attribute_getter, attribute_name, value, global_variable_name, data_type, resolved_tree, name, key;
        
        tree := ShallowCopy( tree );
        
        for key in keys do
            
            tree.(key) := result.(key);
            
        od;
        
        if not (IsBound( tree.CAP_JIT_NOT_RESOLVABLE ) and tree.CAP_JIT_NOT_RESOLVABLE) then
            
            # resolve category attributes
            if CapJitIsCallToGlobalFunction( tree, gvar -> not NameFunction( ValueGlobal( gvar ) ) in Concatenation( CAP_JIT_NON_RESOLVABLE_GLOBAL_VARIABLE_NAMES, RecNames( CAP_INTERNAL_METHOD_NAME_RECORD ), RecNames( CAP_JIT_INTERNAL_KNOWN_METHODS ) ) ) and tree.args.length = 1 and tree.args.1.type = "EXPR_REF_GVAR" and IsCapCategory( ValueGlobal( tree.args.1.gvar ) ) then
                
                cat := ValueGlobal( tree.args.1.gvar );
                
                attribute_getter := ValueGlobal( tree.funcref.gvar );
                
                attribute_name := NameFunction( attribute_getter );
                
                if IsBound( cat!.compiler_hints ) and IsBound( cat!.compiler_hints.category_attribute_resolving_functions ) and IsBound( cat!.compiler_hints.category_attribute_resolving_functions.(attribute_name) ) then
                    
                    tree := cat!.compiler_hints.category_attribute_resolving_functions.(attribute_name)( );
                    
                else
                    
                    value := attribute_getter( cat );
                    
                    global_variable_name := CapJitGetOrCreateGlobalVariable( value );
                    
                    if CAP_JIT_DATA_TYPE_INFERENCE_ENABLED then
                        
                        data_type := CAP_JIT_INTERNAL_GET_OUTPUT_TYPE_OF_GLOBAL_FUNCTION_BY_INPUT_TYPES( attribute_name, [ CapJitDataTypeOfCategory( cat ) ] );
                        
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
                    
                    # in GAP 4.11 and GAP 4.13, "MatElm" points to "[,]", in GAP 4.12 it's the other way round
                    if name = "MatElm" then
                        
                        # this code is only executed with GAP 4.12, but coverage information is only uploaded for GAP master
                        Assert( 0, IsIdenticalObj( \[\,\], MatElm ) );
                        
                        name := "[,]";
                        
                    fi;
                    
                    # `IsBoundGlobal` calls `CheckGlobalName`, which warns about names containing characters not in `IdentifierLetters`.
                    # This is expected for operations in CAP_JIT_INTERNAL_OPERATION_TO_SYNTAX_TREE_TRANSLATIONS, so we avoid IsBoundGlobal in this case.
                    if name <> tree.gvar and (IsBound( CAP_JIT_INTERNAL_OPERATION_TO_SYNTAX_TREE_TRANSLATIONS.(name) ) or IsBoundGlobal( name )) and IsIdenticalObj( value, ValueGlobal( name ) ) then
                        
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
