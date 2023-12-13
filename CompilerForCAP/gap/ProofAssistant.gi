# SPDX-License-Identifier: GPL-2.0-or-later
# CompilerForCAP: Speed up and verify categorical algorithms
#
# Implementations
#

CAP_JIT_PROOF_ASSISTANT_MODE_ENABLED := false;

InstallGlobalFunction( CapJitEnableProofAssistantMode, function ( )
    
    CAP_JIT_PROOF_ASSISTANT_MODE_ENABLED := true;
    
end );

InstallGlobalFunction( CapJitDisableProofAssistantMode, function ( )
    
    CAP_JIT_PROOF_ASSISTANT_MODE_ENABLED := false;
    
end );

# various logic templates which usually only appear in proofs

# literal booleans together with `and` and `or`
CapJitAddLogicTemplate(
    rec(
        variable_names := [ "value" ],
        src_template := "true and value",
        dst_template := "value",
        apply_in_proof_assistant_mode := "only",
    )
);

CapJitAddLogicTemplate(
    rec(
        variable_names := [ "value" ],
        src_template := "value and true",
        dst_template := "value",
        apply_in_proof_assistant_mode := "only",
    )
);

CapJitAddLogicTemplate(
    rec(
        variable_names := [ "value" ],
        src_template := "false and value",
        dst_template := "false",
        apply_in_proof_assistant_mode := "only",
    )
);

CapJitAddLogicTemplate(
    rec(
        variable_names := [ "value" ],
        src_template := "value and false",
        dst_template := "false",
        apply_in_proof_assistant_mode := "only",
    )
);

CapJitAddLogicTemplate(
    rec(
        variable_names := [ "value" ],
        src_template := "true or value",
        dst_template := "true",
        apply_in_proof_assistant_mode := "only",
    )
);

CapJitAddLogicTemplate(
    rec(
        variable_names := [ "value" ],
        src_template := "value or true",
        dst_template := "true",
        apply_in_proof_assistant_mode := "only",
    )
);

CapJitAddLogicTemplate(
    rec(
        variable_names := [ "value" ],
        src_template := "false or value",
        dst_template := "value",
        apply_in_proof_assistant_mode := "only",
    )
);

CapJitAddLogicTemplate(
    rec(
        variable_names := [ "value" ],
        src_template := "value or false",
        dst_template := "value",
        apply_in_proof_assistant_mode := "only",
    )
);

# not true => false
# Note: GAP simplifies `not true` to `false` during parsing, so we have to specify src_template_tree directly
CapJitAddLogicTemplate(
    rec(
        variable_names := [ ],
        src_template := "not true",
        src_template_tree := rec(
            type := "EXPR_NOT",
            op := rec(
                type := "EXPR_TRUE",
            ),
        ),
        dst_template := "false",
        apply_in_proof_assistant_mode := "only",
    )
);

# not false => true
# Note: GAP simplifies `not false` to `true` during parsing, so we have to specify src_template_tree directly
CapJitAddLogicTemplate(
    rec(
        variable_names := [ ],
        src_template := "not false",
        src_template_tree := rec(
            type := "EXPR_NOT",
            op := rec(
                type := "EXPR_FALSE",
            ),
        ),
        dst_template := "true",
        apply_in_proof_assistant_mode := "only",
    )
);

# ForAll( list, l -> true ) => true
CapJitAddLogicTemplate(
    rec(
        variable_names := [ "list" ],
        src_template := "ForAll( list, l -> true )",
        dst_template := "true",
        apply_in_proof_assistant_mode := "only",
    )
);

# ForAll( [ ], func ) => true
# Note: the empty list can be of arbitrary type, so to avoid the warning about empty lists without types, we have to provide src_template_tree directly
CapJitAddLogicTemplate(
    rec(
        variable_names := [ "func" ],
        src_template := "ForAll( [ ], func )",
        src_template_tree := rec(
            type := "EXPR_FUNCCALL",
            funcref := rec(
                type := "EXPR_REF_GVAR",
                gvar := "ForAll",
            ),
            args := AsSyntaxTreeList( [
                rec(
                    type := "EXPR_LIST",
                    list := AsSyntaxTreeList( [ ] ),
                ),
                rec(
                    type := "SYNTAX_TREE_VARIABLE",
                    id := 1,
                ),
            ] ),
        ),
        dst_template := "true",
        apply_in_proof_assistant_mode := "only",
    )
);

# IsEqualForObjects( expr, expr ) => true
CapJitAddLogicTemplate(
    rec(
        variable_names := [ "cat", "expr" ],
        src_template := "IsEqualForObjects( cat, expr, expr )",
        dst_template := "true",
        apply_in_proof_assistant_mode := "only",
    )
);

# IsCongruentForMorphisms( expr, expr ) => true
CapJitAddLogicTemplate(
    rec(
        variable_names := [ "cat", "mor" ],
        src_template := "IsCongruentForMorphisms( cat, mor, mor )",
        dst_template := "true",
        apply_in_proof_assistant_mode := "only",
    )
);

