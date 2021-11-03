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
      local funccall_does_not_return_fail, is_attribute_or_component_of_category, value, inline_tree, name, global_variable_name;
        
        funccall_does_not_return_fail := false;
        is_attribute_or_component_of_category := false;
        
        if not (IsBound( tree.CAP_JIT_NOT_RESOLVABLE ) and tree.CAP_JIT_NOT_RESOLVABLE) then
            
            if tree.type = "EXPR_REF_GVAR" and not tree.gvar in CAP_JIT_NON_RESOLVABLE_GLOBAL_VARIABLE_NAMES then
                
                value := ValueGlobal( tree.gvar );
                
                # will only be used if <value> is a function
                funccall_does_not_return_fail := IsBound( tree.does_not_return_fail ) and tree.does_not_return_fail = true;
                
            elif tree.type = "EXPR_ELM_COMOBJ_NAME" and tree.comobj.type = "EXPR_REF_GVAR" and not tree.comobj.gvar in CAP_JIT_NON_RESOLVABLE_GLOBAL_VARIABLE_NAMES then
                
                value := ValueGlobal( tree.comobj.gvar )!.(tree.name);
                
                if IsCapCategory( ValueGlobal( tree.comobj.gvar ) ) then
                    
                    is_attribute_or_component_of_category := true;
                    
                fi;
                
            elif tree.type = "EXPR_ELM_REC_NAME" and tree.record.type = "EXPR_REF_GVAR" and not tree.record.gvar in CAP_JIT_NON_RESOLVABLE_GLOBAL_VARIABLE_NAMES then
                
                value := ValueGlobal( tree.record.gvar ).(tree.name);
                
            elif tree.type = "EXPR_FUNCCALL" and tree.funcref.type = "EXPR_REF_GVAR" and ForAll( tree.args, a -> a.type in [ "EXPR_REF_GVAR", "EXPR_INT", "EXPR_STRING", "EXPR_TRUE", "EXPR_FALSE" ] ) and not NameFunction( ValueGlobal( tree.funcref.gvar ) ) in Concatenation( CAP_JIT_NON_RESOLVABLE_GLOBAL_VARIABLE_NAMES, RecNames( CAP_INTERNAL_METHOD_NAME_RECORD ), RecNames( CAP_JIT_INTERNAL_KNOWN_METHODS ) ) then
                
                value := CallFuncList( ValueGlobal( tree.funcref.gvar ), AsListMut( List( tree.args, function ( a )
                    
                    if a.type = "EXPR_REF_GVAR" then
                        
                        return ValueGlobal( a.gvar );
                        
                    elif a.type = "EXPR_INT" or a.type = "EXPR_STRING" then
                        
                        return a.value;
                        
                    elif a.type = "EXPR_TRUE" then
                        
                        return true;
                        
                    elif a.type = "EXPR_FALSE" then
                        
                        return false;
                        
                    else
                        
                        # COVERAGE_IGNORE_NEXT_LINE
                        Error( "this should never happen" );
                        
                    fi;
                
                end ) ) );
                
                if tree.args.length = 1 and tree.args.1.type = "EXPR_REF_GVAR" and IsCapCategory( ValueGlobal( tree.args.1.gvar ) ) then
                    
                    is_attribute_or_component_of_category := true;
                    
                fi;
                
            fi;
            
            if IsBound( value ) then
                
                if IsInt( value ) then
                    
                    return rec(
                        type := "EXPR_INT",
                        value := value,
                    );
                    
                elif IsString( value ) then
                    
                    return rec(
                        type := "EXPR_STRING",
                        value := value,
                    );
                
                elif value = true then
                    
                    return rec(
                        type := "EXPR_TRUE",
                    );
                
                elif value = false then
                    
                    return rec(
                        type := "EXPR_FALSE",
                    );
                
                elif IsFunction( value ) then
                    
                    if not IsKernelFunction( value ) and not IsOperation( value ) then
                        
                        inline_tree := ENHANCED_SYNTAX_TREE( value : globalize_hvars := true, only_if_CAP_JIT_RESOLVE_FUNCTION := true );
                        
                        if inline_tree <> fail then
                            
                            if funccall_does_not_return_fail then
                                
                                inline_tree := CapJitRemovedReturnFail( inline_tree );
                                
                            fi;
                            
                            return inline_tree;
                            
                        fi;
                        
                    fi;
                    
                    name := NameFunction( value );
                    
                    if IsBoundGlobal( name ) and IsIdenticalObj( value, ValueGlobal( name ) ) then
                        
                        tree := rec(
                            type := "EXPR_REF_GVAR",
                            gvar := name,
                        );
                        
                        if funccall_does_not_return_fail then
                            
                            tree.does_not_return_fail := true;
                            
                        fi;
                        
                    fi;
                    
                fi;
                
                # could not resolve to another value
                # store attributes or components of categories in a new global variable (because those can be turned back into code using compiler hints)
                if is_attribute_or_component_of_category then
                    
                    global_variable_name := CapJitGetOrCreateGlobalVariable( value );
                    
                    return rec(
                        type := "EXPR_REF_GVAR",
                        gvar := global_variable_name,
                        CAP_JIT_NOT_RESOLVABLE := true,
                    );
                    
                else
                    
                    tree := ShallowCopy( tree );
                    
                    tree.CAP_JIT_NOT_RESOLVABLE := true;
                    
                    return tree;
                    
                fi;
                
            fi;
            
        fi;
        
        return tree;
        
    end;
    
    return CapJitIterateOverTree( tree, pre_func, CapJitResultFuncCombineChildren, ReturnTrue, true );
    
end );
