# SPDX-License-Identifier: GPL-2.0-or-later
# CompilerForCAP: Speed up computations in CAP categories
#
# Implementations
#
InstallGlobalFunction( CAP_JIT_INTERNAL_CONDITION_IMPLIES_CONDITION, function ( cond1, cond2 )
    
    # check if cond1 implies cond2, i.e. if ( cond1 = true => cond2 = true )
    if cond1 = cond2 then
        
        return true;

    elif cond1.type = "EXPR_OR" then
        
        if CAP_JIT_INTERNAL_CONDITION_IMPLIES_CONDITION( cond1.left, cond2 ) = true and CAP_JIT_INTERNAL_CONDITION_IMPLIES_CONDITION( cond1.right, cond2 ) = true then
            
            return true;
            
        fi;
        
    elif cond2.type = "EXPR_OR" then
        
        if CAP_JIT_INTERNAL_CONDITION_IMPLIES_CONDITION( cond1, cond2.left ) = true then
            
            return true;
            
        fi;
        
        if CAP_JIT_INTERNAL_CONDITION_IMPLIES_CONDITION( cond1, cond2.right ) = true then
            
            return true;
            
        fi;
        
    fi;
    
    return fail;
    
end );

InstallGlobalFunction( CapJitDroppedHandledEdgeCases, function ( tree )
  local handled_edge_cases, pre_func, result_func, additional_arguments_func;
    
    Info( InfoCapJit, 1, "####" );
    Info( InfoCapJit, 1, "Drop handled edge cases." );
    
    tree := StructuralCopy( tree );
    
    handled_edge_cases := [ ];
    
    pre_func := function ( tree, additional_arguments )
      local branches, handled_conditions, new_branches, pre_func, i;
        
        if tree.type = "EXPR_CASE" then
            
            branches := tree.branches;
            
            handled_conditions := [ branches.1.condition ];
            
            new_branches := [ branches.1 ];
            
            for i in [ 2 .. branches.length ] do
                
                # check if the whole branch is already handled, if yes: skip
                if ForAny( handled_conditions, handled_condition -> CAP_JIT_INTERNAL_CONDITION_IMPLIES_CONDITION( branches.(i).condition, handled_condition ) = true ) then
                    
                    continue;
                    
                fi;
                
                # for every EXPR_CASE in the value of this branch, drop handled conditions
                pre_func := function ( tree, additional_arguments )
                    
                    if tree.type = "EXPR_CASE" then
                        
                        tree := ShallowCopy( tree );
                        
                        tree.branches := Filtered( tree.branches, branch -> not ForAny( handled_conditions, handled_condition -> CAP_JIT_INTERNAL_CONDITION_IMPLIES_CONDITION( branch.condition, handled_condition ) = true ) );
                        
                        if tree.branches.length = 0 then
                            
                            # COVERAGE_IGNORE_NEXT_LINE
                            Error( "No branches remain, this should never happen." );
                            
                        fi;
                        
                        # normalize
                        if tree.branches.length = 1 and tree.branches.1.condition.type = "EXPR_TRUE" then
                            
                            tree := tree.branches.1.value;
                            
                        fi;
                        
                    fi;
                    
                    return tree;
                    
                end;
                
                Add( new_branches, rec(
                    type := "CASE_BRANCH",
                    condition := branches.(i).condition,
                    value := CapJitIterateOverTree( branches.(i).value, pre_func, CapJitResultFuncCombineChildren, ReturnTrue, true ),
                ) );
                
                Add( handled_conditions, branches.(i).condition );
                
            od;
            
            tree.branches := AsSyntaxTreeList( new_branches );
            
            # normalize
            if tree.branches.length = 1 and tree.branches.1.condition.type = "EXPR_TRUE" then
                
                tree := tree.branches.1.value;
                
            fi;
            
        fi;
        
        return tree;
        
    end;
    
    return CapJitIterateOverTree( tree, pre_func, CapJitResultFuncCombineChildren, ReturnTrue, true );
    
end );