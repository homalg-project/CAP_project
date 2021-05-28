# SPDX-License-Identifier: GPL-2.0-or-later
# CompilerForCAP: Speed up computations in CAP categories
#
# Implementations
#
InstallGlobalFunction( "CapJitResolvedGlobalVariables", function ( tree )
  local pre_func;
    
    Info( InfoCapJit, 1, "####" );
    Info( InfoCapJit, 1, "Resolving global variables." );
    
    pre_func := function ( tree, additional_arguments )
      local funccall_does_not_return_fail, value, inline_tree, name, global_variable_name;
        
        funccall_does_not_return_fail := false;
        
        if IsRecord( tree ) and not (IsBound( tree.CAP_JIT_NOT_RESOLVABLE ) and tree.CAP_JIT_NOT_RESOLVABLE) then
            
            # do not resolve the global variable "Julia" since we otherwise lose information about the Julia module and operation
            if tree.type = "EXPR_REF_GVAR" and tree.gvar <> "Julia" then
                
                value := ValueGlobal( tree.gvar );
                
                # will only be used if <value> is a function
                funccall_does_not_return_fail := IsBound( tree.does_not_return_fail ) and tree.does_not_return_fail = true;
                
            elif tree.type = "EXPR_ELM_COMOBJ_NAME" and tree.comobj.type = "EXPR_REF_GVAR" and tree.comobj.gvar <> "Julia" then
                
                value := ValueGlobal( tree.comobj.gvar )!.(tree.name);
                
            elif tree.type = "EXPR_ELM_REC_NAME" and tree.record.type = "EXPR_REF_GVAR" and tree.record.gvar <> "Julia" then
                
                value := ValueGlobal( tree.record.gvar ).(tree.name);
                
            elif tree.type = "EXPR_FUNCCALL" and tree.funcref.type = "EXPR_REF_GVAR" and ForAll( tree.args, a -> a.type in [ "EXPR_REF_GVAR", "EXPR_INT", "EXPR_STRING", "EXPR_TRUE", "EXPR_FALSE" ] ) and not NameFunction( ValueGlobal( tree.funcref.gvar ) ) in Concatenation( RecNames( CAP_INTERNAL_METHOD_NAME_RECORD ), RecNames( CAP_JIT_INTERNAL_KNOWN_METHODS ) ) then
                
                value := CallFuncList( ValueGlobal( tree.funcref.gvar ), List( tree.args, function ( a )
                    
                    if a.type = "EXPR_REF_GVAR" then
                        
                        return ValueGlobal( a.gvar );
                        
                    elif a.type = "EXPR_INT" or a.type = "EXPR_STRING" then
                        
                        return a.value;
                        
                    elif a.type = "EXPR_TRUE" then
                        
                        return true;
                        
                    elif a.type = "EXPR_FALSE" then
                        
                        return false;
                        
                    else
                        
                        Error( "this should never happen" );
                        
                    fi;
                
                end ) );
                
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
                        
                        inline_tree := ENHANCED_SYNTAX_TREE( value : globalize_hvars := true );
                        
                        if Length( inline_tree.stats.statements ) >= 1 and inline_tree.stats.statements[1].type = "STAT_PRAGMA" and inline_tree.stats.statements[1].value = "% CAP_JIT_RESOLVE_FUNCTION" then
                            
                            inline_tree.stats.statements := inline_tree.stats.statements{[ 2 .. Length( inline_tree.stats.statements ) ]};
                            
                            if funccall_does_not_return_fail then
                                
                                inline_tree := CapJitRemovedReturnFail( inline_tree );
                                
                            fi;
                            
                            return inline_tree;
                            
                        fi;
                        
                    fi;
                    
                    name := NameFunction( value );
                    
                    if name in NamesGVars( ) and IsIdenticalObj( value, ValueGlobal( name ) ) then
                        
                        tree := rec(
                            type := "EXPR_REF_GVAR",
                            gvar := name,
                        );
                        
                        if funccall_does_not_return_fail then
                            
                            tree.does_not_return_fail := true;
                            
                        fi;
                        
                    fi;
                    
                fi;
                
                # could not resolve to a another value
                if tree.type = "EXPR_REF_GVAR" then
                    
                    # this was already a gvar and we could not simplify it
                    tree := ShallowCopy( tree );

                    tree.CAP_JIT_NOT_RESOLVABLE := true;

                    return tree;
                    
                else
                    
                    global_variable_name := CapJitGetOrCreateGlobalVariable( value );
                    
                    tree := rec(
                        type := "EXPR_REF_GVAR",
                        gvar := global_variable_name,
                        CAP_JIT_NOT_RESOLVABLE := true,
                    );
                    
                    Info( InfoCapJit, 1, "####" );
                    Info( InfoCapJit, 1, "Resolved a global variable." );
    
                    return tree;
                    
                fi;

            fi;
                
        fi;
        
        return tree;
        
    end;

    return CapJitIterateOverTree( tree, pre_func, CapJitResultFuncCombineChildren, ReturnTrue, true );
  
end );
