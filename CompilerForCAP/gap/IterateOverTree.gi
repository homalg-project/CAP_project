#
# CompilerForCAP: Speed up computations in CAP categories
#
# Implementations
#
BindGlobal( "CAP_JIT_INTERNAL_ITERATION_KEYS", rec(
    EXPR_FUNC := "stats",
    STAT_SEQ_STAT := "statements",
    STAT_SEQ_STAT2 := "statements",
    STAT_SEQ_STAT3 := "statements",
    STAT_SEQ_STAT4 := "statements",
    STAT_SEQ_STAT5 := "statements",
    STAT_SEQ_STAT6 := "statements",
    STAT_SEQ_STAT7 := "statements",
    STAT_ASS_LVAR := "rhs",
    STAT_ASS_FVAR := "rhs",
    EXPR_FUNCCALL := [ "funcref", "args" ],
    EXPR_FUNCCALL_0ARGS := [ "funcref", "args" ],
    EXPR_FUNCCALL_1ARGS := [ "funcref", "args" ],
    EXPR_FUNCCALL_2ARGS := [ "funcref", "args" ],
    EXPR_FUNCCALL_3ARGS := [ "funcref", "args" ],
    EXPR_FUNCCALL_4ARGS := [ "funcref", "args" ],
    EXPR_FUNCCALL_5ARGS := [ "funcref", "args" ],
    EXPR_FUNCCALL_6ARGS := [ "funcref", "args" ],
    EXPR_FUNCCALL_XARGS := [ "funcref", "args" ],
    STAT_PROCCALL := [ "funcref", "args" ],
    STAT_PROCCALL_0ARGS := [ "funcref", "args" ],
    STAT_PROCCALL_1ARGS := [ "funcref", "args" ],
    STAT_PROCCALL_2ARGS := [ "funcref", "args" ],
    STAT_PROCCALL_3ARGS := [ "funcref", "args" ],
    STAT_PROCCALL_4ARGS := [ "funcref", "args" ],
    STAT_PROCCALL_5ARGS := [ "funcref", "args" ],
    STAT_PROCCALL_6ARGS := [ "funcref", "args" ],
    STAT_PROCCALL_XARGS := [ "funcref", "args" ],
    EXPR_REF_LVAR := fail,
    EXPR_REF_HVAR := fail,
    EXPR_REF_FVAR := fail,
    EXPR_REF_GVAR := fail,
    STAT_RETURN_VOID := fail,
    STAT_IF := [ "branches" ],
    STAT_IF_ELSE := [ "branches" ],
    STAT_IF_ELIF := [ "branches" ],
    STAT_IF_ELIF_ELSE := [ "branches" ],
    STAT_FOR := [ "variable", "collection", "body" ],
    STAT_ASS_LIST := [ "list", "pos", "rhs" ],
    EXPR_ELM_LIST := [ "list", "pos" ],
    EXPR_ELMS_LIST := [ "list", "poss" ],
    EXPR_ISB_LIST := [ "list", "pos" ],
    EXPR_ELM_REC_NAME := [ "record" ],
    EXPR_ELM_REC_EXPR := [ "record", "expression" ],
    EXPR_ISB_REC_EXPR := [ "record", "expression" ],
    EXPR_ELM_COMOBJ_NAME := [ "comobj" ],
    EXPR_ISB_COMOBJ_NAME := [ "comobj" ],
    EXPR_ELM_MAT := [ "list", "row", "col" ],
    EXPR_LIST := "list",
    STAT_RETURN_OBJ := "obj",
    EXPR_RANGE := [ "first", "last" ],
    EXPR_INT := fail,
    EXPR_STRING := fail,
    EXPR_TRUE := fail,
    EXPR_FALSE := fail,
    STAT_EMPTY := fail,
    STAT_PRAGMA := fail,
    STAT_CONTINUE := fail,
    STAT_BREAK := fail,
    EXPR_PROD := [ "left", "right" ],
    EXPR_QUO := [ "left", "right" ],
    EXPR_SUM := [ "left", "right" ],
    EXPR_AINV := [ "op" ],
    EXPR_DIFF := [ "left", "right" ],
    EXPR_EQ := [ "left", "right" ],
    EXPR_NE := [ "left", "right" ],
    EXPR_LE := [ "left", "right" ],
    EXPR_GE := [ "left", "right" ],
    EXPR_LT := [ "left", "right" ],
    EXPR_GT := [ "left", "right" ],
    EXPR_AND := [ "left", "right" ],
    EXPR_OR := [ "left", "right" ],
    EXPR_IN := [ "left", "right" ],
    EXPR_NOT := [ "op" ],
    EXPR_REC := [ "keyvalue" ],
    STAT_ASSERT_2ARGS := [ "level", "condition" ],
    STAT_ASSERT_3ARGS := [ "level", "condition", "message" ],
    STAT_INFO := [ "sel", "lev", "args" ],
    BRANCH_IF := [ "condition", "body" ],
    REC_KEY_VALUE_PAIR := [ "value" ],
) );

InstallGlobalFunction( CapJitIterateOverTree, function( tree, pre_func, result_func, additional_arguments_func, additional_arguments )
  local pre_func_result, result, type, keys, key;
    
    pre_func_result := pre_func( tree, additional_arguments );
    
    # check if we should stop iteration
    if pre_func_result = fail then
        
        return result_func( tree, fail, additional_arguments );
        
    fi;
    
    # continue iteration
    tree := pre_func_result;
    
    if IsList( tree ) then
       
        result := [];
        
        for key in [ 1 .. Length( tree ) ] do
            
            result[key] := CapJitIterateOverTree( tree[key], pre_func, result_func, additional_arguments_func, additional_arguments_func( tree, key, additional_arguments ) );
            
        od;

        return result_func( tree, result, additional_arguments );

    fi;
    
    if not IsRecord( tree ) then
        
        Display( tree );
        
        Error( "tree is neither a list nor a record" );
        
    fi;
    
    if IsBound(tree.type) then
        
        type := tree.type; 
    
    elif SortedList( RecNames( tree ) ) = [ "body", "condition" ] then
        
        type := "BRANCH_IF";
        
    else
        
        Display( tree );
        
        Error( "cannot determine type of tree" );
        
    fi;
    
    if not IsBound(CAP_JIT_INTERNAL_ITERATION_KEYS.(type)) then
        
        Display( tree );
        
        Error( "cannot find iteration key" );

    fi;
    
    result := rec();

    keys := CAP_JIT_INTERNAL_ITERATION_KEYS.(type);
    if keys <> fail then
       
        if IsString( keys ) then
            
            keys := [ keys ];
            
        fi;

        for key in keys do
           
            if not IsBound(tree.(key)) then
                
                Display( tree );
        
                Error( "invalid iteration key" );
            
            fi;
            
            result.(key) := CapJitIterateOverTree( tree.(key), pre_func, result_func, additional_arguments_func, additional_arguments_func( tree, key, additional_arguments ) );

        od;
        
    fi;

    return result_func( tree, result, additional_arguments );
    
end );
