# SPDX-License-Identifier: GPL-2.0-or-later
# CompilerForCAP: Speed up and verify categorical algorithms
#
# Implementations
#
InstallGlobalFunction( CAP_JIT_INTERNAL_CONDITION_IMPLIES_CONDITION, function ( cond1, cond2 )
    
    # check if cond1 implies cond2, i.e. if ( cond1 = true => cond2 = true )
    if cond2.type = "EXPR_TRUE" then
        
        # anything implies true
        return true;
        
    elif cond1.type = "EXPR_FALSE" then
        
        # false implies everything
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
        
    elif CapJitIsEqualForEnhancedSyntaxTrees( cond1, cond2 ) then
        
        return true;
        
    # symmetry of equality: also check equality of syntax trees with swapped arguments
    elif cond1.type = "EXPR_EQ" and cond2.type = "EXPR_EQ" and CapJitIsEqualForEnhancedSyntaxTrees( cond1.left, cond2.right ) and CapJitIsEqualForEnhancedSyntaxTrees( cond1.right, cond2.left ) then
        
        return true;
        
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
      local branches, handled_condition, new_branches, current_outer_condition, pre_func, i;
        
        if tree.type = "EXPR_CASE" then
            
            branches := tree.branches;
            
            # there must always be an "else" case
            Assert( 0, Last( branches ).condition.type = "EXPR_TRUE" );
            
            # the union (= or) of all conditions already handled by the preceding case branches
            # empty "or" = false
            handled_condition := rec( type := "EXPR_FALSE" );
            
            new_branches := [ ];
            
            for i in [ 1 .. branches.length ] do
                
                # check if the whole branch is already handled, if yes: skip
                if CAP_JIT_INTERNAL_CONDITION_IMPLIES_CONDITION( branches.(i).condition, handled_condition ) = true then
                    
                    continue;
                    
                fi;
                
                current_outer_condition := branches.(i).condition;
                
                # for every EXPR_CASE in the value of this branch, drop handled conditions
                pre_func := function ( tree, additional_arguments )
                    
                    if tree.type = "EXPR_CASE" then
                        
                        tree := ShallowCopy( tree );
                        
                        tree.branches := List( tree.branches, function ( branch )
                            
                            if CAP_JIT_INTERNAL_CONDITION_IMPLIES_CONDITION( current_outer_condition, branch.condition ) = true then
                                
                                return rec(
                                    type := "CASE_BRANCH",
                                    condition := rec(
                                        type := "EXPR_TRUE",
                                    ),
                                    value := branch.value,
                                );
                                
                            else
                                
                                return branch;
                                
                            fi;
                            
                        end );
                        
                        tree.branches := Filtered( tree.branches, branch -> not (CAP_JIT_INTERNAL_CONDITION_IMPLIES_CONDITION( branch.condition, handled_condition ) = true) );
                        
                        if tree.branches.length = 0 then
                            
                            # COVERAGE_IGNORE_NEXT_LINE
                            Error( "No branches remain, this should never happen." );
                            
                        fi;
                        
                    fi;
                    
                    return tree;
                    
                end;
                
                Add( new_branches, rec(
                    type := "CASE_BRANCH",
                    condition := branches.(i).condition,
                    value := CapJitIterateOverTree( branches.(i).value, pre_func, CapJitResultFuncCombineChildren, ReturnTrue, true ),
                ) );
                
                handled_condition := rec(
                    type := "EXPR_OR",
                    left := handled_condition,
                    right := branches.(i).condition,
                );
                
            od;
            
            tree.branches := AsSyntaxTreeList( new_branches );
            
            # normalize
            if tree.branches.length = 1 then
                
                # There is always an else clause,
                # so if only one branch remains it must be implied by `true`
                # and the only condition with this property is `true`.
                Assert( 0, tree.branches.1.condition.type = "EXPR_TRUE" );
                
                tree := tree.branches.1.value;
                
            fi;
            
        fi;
        
        return tree;
        
    end;
    
    return CapJitIterateOverTree( tree, pre_func, CapJitResultFuncCombineChildren, ReturnTrue, true );
    
end );
