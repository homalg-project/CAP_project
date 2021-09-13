# SPDX-License-Identifier: GPL-2.0-or-later
# CompilerForCAP: Speed up computations in CAP categories
#
# Implementations
#
InstallGlobalFunction( CapJitDetectedTernaryConditionalExpressions, function ( tree )
  local pre_func;
    
    pre_func := function ( tree, additional_arguments )
      local body_if_true, body_if_false, statement_if_true, statement_if_false;
        
        if tree.type = "STAT_IF_ELSE" then
            
            Assert( 0, tree.branches.length = 2 );
            Assert( 0, tree.branches.2.condition.type = "EXPR_TRUE" );
            
            body_if_true := tree.branches.1.body;
            body_if_false := tree.branches.2.body;
            
            if body_if_true.statements.length = 1 and body_if_false.statements.length = 1 then
                
                statement_if_true := body_if_true.statements.1;
                statement_if_false := body_if_false.statements.1;
                
                if statement_if_true.type = "STAT_RETURN_OBJ" and statement_if_false.type = "STAT_RETURN_OBJ" then
                    
                    tree := rec(
                        type := "STAT_RETURN_OBJ",
                        obj := rec(
                            type := "EXPR_CONDITIONAL",
                            condition := tree.branches.1.condition,
                            expr_if_true := statement_if_true.obj,
                            expr_if_false := statement_if_false.obj,
                        ),
                    );
                    
                fi;
                
            fi;
            
        fi;
        
        return tree;
        
    end;
    
    return CapJitIterateOverTree( tree, pre_func, CapJitResultFuncCombineChildren, ReturnTrue, true );
    
end );
