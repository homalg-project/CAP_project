# SPDX-License-Identifier: GPL-2.0-or-later
# CompilerForCAP: Speed up computations in CAP categories
#
# Implementations
#
BindGlobal( "CAP_JIT_INTERNAL_ITERATION_KEYS", rec(
    EXPR_FUNC := [ "stats" ],
    EXPR_DECLARATIVE_FUNC := [ "bindings" ],
    STAT_SEQ_STAT := [ "statements" ],
    STAT_SEQ_STAT2 := [ "statements" ],
    STAT_SEQ_STAT3 := [ "statements" ],
    STAT_SEQ_STAT4 := [ "statements" ],
    STAT_SEQ_STAT5 := [ "statements" ],
    STAT_SEQ_STAT6 := [ "statements" ],
    STAT_SEQ_STAT7 := [ "statements" ],
    STAT_ASS_LVAR := [ "rhs" ],
    STAT_ASS_FVAR := [ "rhs" ],
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
    EXPR_REF_LVAR := [ ],
    EXPR_REF_HVAR := [ ],
    EXPR_REF_FVAR := [ ],
    EXPR_REF_GVAR := [ ],
    STAT_RETURN_VOID := [ ],
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
    STAT_ASS_COMOBJ_NAME := [ "comobj", "rhs" ],
    EXPR_ELM_MAT := [ "list", "row", "col" ],
    STAT_ASS_MAT := [ "list", "row", "col", "rhs" ],
    EXPR_LIST := [ "list" ],
    STAT_RETURN_OBJ := [ "obj" ],
    EXPR_RANGE := [ "first", "last" ],
    EXPR_INT := [ ],
    EXPR_STRING := [ ],
    EXPR_CHAR := [ ],
    EXPR_TRUE := [ ],
    EXPR_FALSE := [ ],
    STAT_EMPTY := [ ],
    STAT_PRAGMA := [ ],
    STAT_CONTINUE := [ ],
    STAT_BREAK := [ ],
    EXPR_POW := [ "left", "right" ],
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
    EXPR_MOD := [ "left", "right" ],
    EXPR_NOT := [ "op" ],
    EXPR_REC := [ "keyvalue" ],
    STAT_ASSERT_2ARGS := [ "level", "condition" ],
    STAT_ASSERT_3ARGS := [ "level", "condition", "message" ],
    STAT_INFO := [ "sel", "lev", "args" ],
    BRANCH_IF := [ "condition", "body" ],
    REC_KEY_VALUE_PAIR := [ "value" ],
    EXPR_CASE := [ "branches" ],
    CASE_BRANCH := [ "condition", "value" ],
) );

InstallGlobalFunction( CapJitIterateOverTree, function ( tree, pre_func, result_func, additional_arguments_func, additional_arguments )
  local pre_func_result, result, type, keys, key;
    
    pre_func_result := pre_func( tree, additional_arguments );
    
    # check if we should stop iteration
    if pre_func_result = fail then
        
        return result_func( tree, fail, [ ], additional_arguments );
        
    fi;
    
    # continue iteration
    tree := pre_func_result;
    
    # when unenhancing an enhanced syntax tree, the "list" case can still occur
    if IsList( tree ) then
       
        result := [ ];
        
        for key in [ 1 .. Length( tree ) ] do
            
            result[key] := CapJitIterateOverTree( tree[key], pre_func, result_func, additional_arguments_func, additional_arguments_func( tree, key, additional_arguments ) );
            
        od;

        return result_func( tree, result, [ 1 .. Length( tree ) ], additional_arguments );

    fi;
    
    Assert( 0, IsRecord( tree ) );
    
    if IsBound( tree.type ) then
        
        type := tree.type;
    
    # needed for dealing with non-enhanced syntax trees
    elif SortedList( RecNames( tree ) ) = [ "body", "condition" ] then
        
        type := "BRANCH_IF";
        
    else
        
        # COVERAGE_IGNORE_BLOCK_START
        Display( tree );
        
        Error( "cannot determine type of tree" );
        # COVERAGE_IGNORE_BLOCK_END
        
    fi;
    
    if type = "SYNTAX_TREE_LIST" then
        
        keys := List( [ 1 .. tree.length ], i -> String( i ) );
        
        # check that tree.length and the record entries are in sync
        # keys are sorted as integers but not lexicographically
        Assert( 0, SortedList( Filtered( RecNames( tree ), name -> IsDigitChar( First( name ) ) ) ) = SortedList( keys ) );
        
    elif type = "FVAR_BINDING_SEQ" then
        
        keys := List( tree.names, name -> Concatenation( "BINDING_", name ) );
        
        # check that tree.names and the record entries are in sync
        Assert( 0, IsSortedList( tree.names ) );
        Assert( 0, SortedList( Filtered( RecNames( tree ), name -> StartsWith( name, "BINDING_" ) ) ) = keys );
        
    elif IsBound( CAP_JIT_INTERNAL_ITERATION_KEYS.(type) ) then
        
        keys := CAP_JIT_INTERNAL_ITERATION_KEYS.(type);
        
    else
        
        # COVERAGE_IGNORE_BLOCK_START
        Display( tree );
        
        Error( "cannot find iteration key" );
        # COVERAGE_IGNORE_BLOCK_END
        
    fi;
    
    result := rec( );
    
    for key in keys do
        
        if not IsBound( tree.(key) ) then
            
            # COVERAGE_IGNORE_BLOCK_START
            Display( tree );
            
            Error( "invalid iteration key" );
            # COVERAGE_IGNORE_BLOCK_END
            
        fi;
        
        result.(key) := CapJitIterateOverTree( tree.(key), pre_func, result_func, additional_arguments_func, additional_arguments_func( tree, key, additional_arguments ) );
        
    od;
    
    return result_func( tree, result, keys, additional_arguments );
    
end );