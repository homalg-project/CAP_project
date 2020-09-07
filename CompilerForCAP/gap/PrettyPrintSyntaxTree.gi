#
# CompilerForCAP: Speed up computations in CAP categories
#
# Implementations
#
InstallGlobalFunction( CAP_JIT_INTERNAL_PREPARE_SYNTAX_TREE_FOR_PRETTY_PRINT, function ( tree, func_stack )
  local type, statements, lvars, level, hvars, func;

    if IsList( tree ) then
        
        return List( tree, t -> CAP_JIT_INTERNAL_PREPARE_SYNTAX_TREE_FOR_PRETTY_PRINT( t, func_stack ) );
        
    fi;
    
    tree := ShallowCopy( tree );
    
    if not IsBound( tree.type ) then
        Error( "record is not a syntax tree" );
    fi;
    
    type := tree.type;
    
    if type = "EXPR_FUNC" then
        
        return rec( 0_type := tree.type,
                    1_id := tree.id,
                    2_nams := tree.nams,
                    3_narg := tree.narg,
                    4_nloc := tree.nloc,
                    5_variadic := tree.variadic,
                    6_stats := CAP_JIT_INTERNAL_PREPARE_SYNTAX_TREE_FOR_PRETTY_PRINT( tree.stats, Concatenation( func_stack, [ tree ] ) ),
                  );

    elif StartsWith( type, "STAT_SEQ_STAT" ) then
        
        return rec(
            0_type := tree.type,
            1_statements := CAP_JIT_INTERNAL_PREPARE_SYNTAX_TREE_FOR_PRETTY_PRINT( tree.statements, func_stack ),
        );
        
    elif type = "STAT_ASS_LVAR" then
        
        lvars := Last( func_stack ).nams;

        Assert( 0, tree.lvar <= Length( lvars ) );
        
        return rec( 0_type := tree.type,
                    1_lvar := tree.lvar,
                    2_nvar := lvars[tree.lvar],
                    3_rhs := CAP_JIT_INTERNAL_PREPARE_SYNTAX_TREE_FOR_PRETTY_PRINT( tree.rhs, func_stack ),
                  );
        
    elif type = "STAT_ASS_FVAR" then

        func := First( func_stack, f -> f.id = tree.func_id );
        
        Assert( 0, func <> fail );
        Assert( 0, tree.pos <= Length( func.nams ) );
        
        return rec( 0_type := tree.type,
                    1_func_id := tree.func_id,
                    2_pos := tree.pos,
                    3_current_name := func.nams[tree.pos],
                    4_initial_name := tree.initial_name,
                    5_rhs := CAP_JIT_INTERNAL_PREPARE_SYNTAX_TREE_FOR_PRETTY_PRINT( tree.rhs, func_stack ),
                  );
        
    elif StartsWith( type, "EXPR_FUNCCALL" ) or StartsWith( type, "STAT_PROCCALL" ) then
        
        return rec( 0_type := tree.type,
                    1_funcref := CAP_JIT_INTERNAL_PREPARE_SYNTAX_TREE_FOR_PRETTY_PRINT( tree.funcref, func_stack ),
                    2_args := CAP_JIT_INTERNAL_PREPARE_SYNTAX_TREE_FOR_PRETTY_PRINT( tree.args, func_stack ),
                  );
        
    elif type = "EXPR_REF_GVAR" then
        
        return rec( 0_type := tree.type,
                    1_gvar := tree.gvar,
                  );
        
    elif type = "EXPR_REF_LVAR" then
        
        lvars := Last( func_stack ).nams;

        Assert( 0, tree.lvar <= Length( lvars ) );
        
        return rec( 0_type := tree.type,
                    1_lvar := tree.lvar,
                    2_nvar := lvars[tree.lvar],
                  );
        
    elif type = "EXPR_REF_FVAR" then

        func := First( func_stack, f -> f.id = tree.func_id );
        
        Assert( 0, func <> fail );
        Assert( 0, tree.pos <= Length( func.nams ) );
        
        return rec( 0_type := tree.type,
                    1_func_id := tree.func_id,
                    2_pos := tree.pos,
                    3_current_name := func.nams[tree.pos],
                    4_initial_name := tree.initial_name,
                  );
        
    elif type = "STAT_IF" or type = "STAT_IF_ELSE" then
        
        return rec( 0_type := tree.type,
                    1_branches := CAP_JIT_INTERNAL_PREPARE_SYNTAX_TREE_FOR_PRETTY_PRINT( tree.branches, func_stack ),
                  );
        
    elif type = "BRANCH_IF" then
        
        return rec( 0_type := tree.type,
                    1_condition := CAP_JIT_INTERNAL_PREPARE_SYNTAX_TREE_FOR_PRETTY_PRINT( tree.condition, func_stack ),
                    2_body := CAP_JIT_INTERNAL_PREPARE_SYNTAX_TREE_FOR_PRETTY_PRINT( tree.body, func_stack ),
                  );
        
    elif type = "EXPR_REC" then
        
        Assert( 0, Length( tree.keyvalue ) = 0 );
        
        return rec( 0_type := tree.type,
                    1_keyvalue := CAP_JIT_INTERNAL_PREPARE_SYNTAX_TREE_FOR_PRETTY_PRINT( tree.keyvalue, func_stack ),
                  );
        
    elif type = "EXPR_LIST" then
        
        return rec( 0_type := tree.type,
                    1_list := CAP_JIT_INTERNAL_PREPARE_SYNTAX_TREE_FOR_PRETTY_PRINT( tree.list, func_stack ),
                  );
        
    elif type = "STAT_RETURN_OBJ" then
        
        return rec( 0_type := tree.type,
                    1_obj := CAP_JIT_INTERNAL_PREPARE_SYNTAX_TREE_FOR_PRETTY_PRINT( tree.obj, func_stack ),
                  );
        
    elif type = "EXPR_RANGE" then
        
        return rec( 0_type := tree.type,
                    1_first := CAP_JIT_INTERNAL_PREPARE_SYNTAX_TREE_FOR_PRETTY_PRINT( tree.first, func_stack ),
                    2_last := CAP_JIT_INTERNAL_PREPARE_SYNTAX_TREE_FOR_PRETTY_PRINT( tree.last, func_stack ),
                  );
        
    elif type = "EXPR_INT" or type = "EXPR_STRING" then
        
        return rec( 0_type := tree.type,
                    1_value := tree.value,
                  );
        
    elif type = "EXPR_TRUE" or type = "EXPR_FALSE" then
        
        return rec( 0_type := tree.type,
                  );
        
    elif type = "EXPR_OR" or type = "EXPR_AND" or type = "EXPR_EQ" or type = "EXPR_NE" or type = "EXPR_PROD" or type = "EXPR_SUM" or type = "EXPR_DIFF" or type = "EXPR_LE" or type = "EXPR_LT" or type = "EXPR_GE" or type = "EXPR_GT" then
        
        return rec( 0_type := tree.type,
                    1_left := CAP_JIT_INTERNAL_PREPARE_SYNTAX_TREE_FOR_PRETTY_PRINT( tree.left, func_stack ),
                    2_right := CAP_JIT_INTERNAL_PREPARE_SYNTAX_TREE_FOR_PRETTY_PRINT( tree.right, func_stack ),
                  );
        
    elif type = "EXPR_NOT" then
        
        return rec( 0_type := tree.type,
                    1_op := CAP_JIT_INTERNAL_PREPARE_SYNTAX_TREE_FOR_PRETTY_PRINT( tree.op, func_stack ),
                  );
        
    elif type = "EXPR_ELM_COMOBJ_NAME" then
        
        return rec( 0_type := tree.type,
                    1_name := tree.name,
                    2_comobj := CAP_JIT_INTERNAL_PREPARE_SYNTAX_TREE_FOR_PRETTY_PRINT( tree.comobj, func_stack ),
                  );
        
    elif type = "EXPR_ELM_REC_NAME" then
        
        return rec( 0_type := tree.type,
                    1_name := tree.name,
                    2_record := CAP_JIT_INTERNAL_PREPARE_SYNTAX_TREE_FOR_PRETTY_PRINT( tree.record, func_stack ),
                  );
        
    elif type = "EXPR_REF_HVAR" then
        
        level := Int( tree.hvar / 2 ^ 16 );
        
        if not Length( func_stack ) - level > 0 then
            
            Error( "cannot reference an hvar outside of the stack" );
            
        fi;
        
        hvars := func_stack[Length( func_stack ) - level];
        
        Assert( 0, tree.hvar mod 2 ^ 16 <= Length( hvars ) );
        
        return rec( 0_type := tree.type,
                    1_hvar := tree.hvar,
                    2_nvar := hvars[tree.hvar mod 2 ^ 16],
                  );
        
    elif type = "EXPR_ELM_LIST" then
        
        return rec( 0_type := tree.type,
                    1_pos := CAP_JIT_INTERNAL_PREPARE_SYNTAX_TREE_FOR_PRETTY_PRINT( tree.pos, func_stack ),
                    2_list := CAP_JIT_INTERNAL_PREPARE_SYNTAX_TREE_FOR_PRETTY_PRINT( tree.list, func_stack ),
                  );
        
    elif type = "EXPR_ELM_MAT" then
        
        return rec( 0_type := tree.type,
                    1_row := CAP_JIT_INTERNAL_PREPARE_SYNTAX_TREE_FOR_PRETTY_PRINT( tree.row, func_stack ),
                    2_col := CAP_JIT_INTERNAL_PREPARE_SYNTAX_TREE_FOR_PRETTY_PRINT( tree.col, func_stack ),
                    3_list := CAP_JIT_INTERNAL_PREPARE_SYNTAX_TREE_FOR_PRETTY_PRINT( tree.list, func_stack ),
                  );
        
    else
        
        Display( tree );
        
        Error( "tree has no kown type" );
        
    fi;
    
end );

InstallGlobalFunction( CapJitPrettyPrintSyntaxTree, function ( tree )
    
    Display( CAP_JIT_INTERNAL_PREPARE_SYNTAX_TREE_FOR_PRETTY_PRINT( tree, [ ] ) );
    
end );
