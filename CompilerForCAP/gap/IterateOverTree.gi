# SPDX-License-Identifier: GPL-2.0-or-later
# CompilerForCAP: Speed up and verify categorical algorithms
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
    SYNTAX_TREE_VARIABLE := [ ],
) );

BindGlobal( "SYNTAX_TREE_LIST_KEYS", [ ] );

InstallGlobalFunction( CapJitIterateOverTree, function ( tree, pre_func, result_func, additional_arguments_func, initial_additional_arguments )
    
    return CAP_JIT_INTERNAL_ITERATE_OVER_TREE( tree, pre_func, result_func, additional_arguments_func, initial_additional_arguments, false );
    
end );

InstallGlobalFunction( CapJitIterateOverTreeWithCachedBindingResults, function ( tree, pre_func, result_func, additional_arguments_func, initial_additional_arguments )
    
    return CAP_JIT_INTERNAL_ITERATE_OVER_TREE( tree, pre_func, result_func, additional_arguments_func, initial_additional_arguments, true );
    
end );

BindGlobal( "CAP_JIT_INTERNAL_ITERATE_OVER_TREE_CACHE", rec( ) );

InstallGlobalFunction( CAP_JIT_INTERNAL_ITERATE_OVER_TREE, function ( tree, pre_func, result_func, additional_arguments_func, additional_arguments, cache_binding_results )
  local pre_func_result, result, type, keys, cache, binding_name, key;
    
    pre_func_result := pre_func( tree, additional_arguments );
    
    # check if we should stop the iteration
    if pre_func_result = fail then
        
        return result_func( tree, fail, [ ], additional_arguments );
        
    fi;
    
    # continue iteration
    tree := pre_func_result;
    
    # when unenhancing an enhanced syntax tree, the "list" case can still occur
    if IsList( tree ) then
       
        result := [ ];
        
        for key in [ 1 .. Length( tree ) ] do
            
            result[key] := CAP_JIT_INTERNAL_ITERATE_OVER_TREE( tree[key], pre_func, result_func, additional_arguments_func, additional_arguments_func( tree, key, additional_arguments ), cache_binding_results );
            
        od;

        return result_func( tree, result, [ 1 .. Length( tree ) ], additional_arguments );

    fi;
    
    type := tree.type;
    
    if type = "SYNTAX_TREE_LIST" then
        
        if tree.length = 0 then
            
            keys := [ ];
            
        else
            
            if not IsBound( SYNTAX_TREE_LIST_KEYS[tree.length] ) then
                
                SYNTAX_TREE_LIST_KEYS[tree.length] := List( [ 1 .. tree.length ], i -> String( i ) );
                
            fi;
            
            keys := SYNTAX_TREE_LIST_KEYS[tree.length];
            
        fi;
        
        # check that tree.length and the record entries are in sync
        # keys are sorted as integers but not lexicographically
        Assert( 3, SortedList( Filtered( RecNames( tree ), name -> IsDigitChar( First( name ) ) ) ) = SortedList( keys ) );
        
    elif type = "FVAR_BINDING_SEQ" then
        
        keys := List( tree.names, name -> Concatenation( "BINDING_", name ) );
        
        # check that tree.names and the record entries are in sync
        Assert( 3, IsEqualSet( Filtered( RecNames( tree ), name -> StartsWith( name, "BINDING_" ) ), keys ) );
        
    else
        
        keys := CAP_JIT_INTERNAL_ITERATION_KEYS.(type);
        
    fi;
    
    if not cache_binding_results or (type <> "EXPR_DECLARATIVE_FUNC" and type <> "EXPR_REF_FVAR") then
        
        result := rec( );
        
        for key in keys do
            
            result.(key) := CAP_JIT_INTERNAL_ITERATE_OVER_TREE( tree.(key), pre_func, result_func, additional_arguments_func, additional_arguments_func( tree, key, additional_arguments ), cache_binding_results );
            
        od;
        
    else
        
        if type = "EXPR_DECLARATIVE_FUNC" then
            
            Assert( 0, keys = [ "bindings" ] );
            
            if IsBound( CAP_JIT_INTERNAL_ITERATE_OVER_TREE_CACHE.(tree.id) ) then
                
                # COVERAGE_IGNORE_NEXT_LINE
                Error( "there is already a cache for this function" );
                
            fi;
            
            CAP_JIT_INTERNAL_ITERATE_OVER_TREE_CACHE.(tree.id) := rec(
                bindings := tree.bindings,
                additional_arguments := additional_arguments_func( tree, "bindings", additional_arguments ),
                results := rec( ),
                keys := [ ],
            );
            
            cache := CAP_JIT_INTERNAL_ITERATE_OVER_TREE_CACHE.(tree.id);
            
            # start iteration from RETURN_VALUE
            # this populates the results of other used bindings, see EXPR_REF_FVAR below
            cache.results.BINDING_RETURN_VALUE := CAP_JIT_INTERNAL_ITERATE_OVER_TREE( tree.bindings.BINDING_RETURN_VALUE, pre_func, result_func, additional_arguments_func, additional_arguments_func( tree.bindings, "BINDING_RETURN_VALUE", cache.additional_arguments ), cache_binding_results );
            
            # add BINDING_RETURN_VALUE to keys AFTER the iteration to reproduce the dependency order
            Add( cache.keys, "BINDING_RETURN_VALUE" );
            
            result := rec( bindings := result_func( tree.bindings, cache.results, cache.keys, cache.additional_arguments ) );
            
            Unbind( CAP_JIT_INTERNAL_ITERATE_OVER_TREE_CACHE.(tree.id) );
            
        elif type = "EXPR_REF_FVAR" then
            
            Assert( 0, IsEmpty( keys ) );
            
            cache := CAP_JIT_INTERNAL_ITERATE_OVER_TREE_CACHE.(tree.func_id);
            binding_name := Concatenation( "BINDING_", tree.name );
            
            # check if this is the name of a binding (i.e. not a function parameter)
            if IsBound( cache.bindings.(binding_name) ) then
                
                if not IsBound( cache.results.(binding_name) ) then
                    
                    cache.results.(binding_name) := CAP_JIT_INTERNAL_ITERATE_OVER_TREE( cache.bindings.(binding_name), pre_func, result_func, additional_arguments_func, additional_arguments_func( cache.bindings, binding_name, cache.additional_arguments ), cache_binding_results );
                    
                    # add binding_nams to keys AFTER the iteration to reproduce the dependency order
                    Add( cache.keys, binding_name );
                    
                fi;
                
                result := cache.results.(binding_name);
                
            else
                
                result := rec( );
                
            fi;
            
        fi;
        
    fi;
    
    return result_func( tree, result, keys, additional_arguments );
    
end );
