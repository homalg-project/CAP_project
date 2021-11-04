#! @Chapter Examples and tests

#! @Section Tests

#! @Example

LoadPackage( "CompilerForCAP", false );
#! true

# make tests deterministic
# we want to apply logic templates, which contain functions with existing IDs,
# so we really have to use new IDs
CAP_JIT_INTERNAL_FUNCTION_ID < 10^6;
#! true
original_func_id := CAP_JIT_INTERNAL_FUNCTION_ID;;
CAP_JIT_INTERNAL_FUNCTION_ID := 10^6;;

# test that `CAP_JIT_NOT_RESOLVABLE` does not cause errors when comparing
# syntax trees
DeclareOperation( "MyNonResolvableOperation", [ ] );

func := { } -> MyNonResolvableOperation( );;

tree := ENHANCED_SYNTAX_TREE( func );;

tree2 := StructuralCopy( tree );;
tree2.bindings.BINDING_RETURN_VALUE.funcref.CAP_JIT_NOT_RESOLVABLE := true;;

CapJitIsEqualForEnhancedSyntaxTrees( tree, tree2 );
#! true

# test that `CAP_JIT_IGNORE_OPERATION` does not cause errors when comparing
# syntax trees
func := function ( L1 )
    return [
        List( List( L1, x -> x ), x -> Size( x ) ),
        List( List( L1, x -> x ), Size )
    ]; end;;

tree := ENHANCED_SYNTAX_TREE( func );;
tree := CapJitResolvedOperations( tree, [ ] );;
tree := CapJitAppliedLogic( tree, [ ] );;
tree := CapJitInlinedArguments( tree );;
tree := CapJitInlinedFunctionCalls( tree );;
tree := CapJitInlinedBindings( tree );;
tree := CapJitDroppedUnusedBindings( tree );;
CapJitPrettyPrintSyntaxTree( tree );
#! rec(
#!   0_type := "EXPR_DECLARATIVE_FUNC",
#!   1_id := 1000001,
#!   2_nams := [ "L1", "RETURN_VALUE" ],
#!   3_narg := 1,
#!   4_variadic := false,
#!   5_bindings := rec(
#!       0_type := "FVAR_BINDING_SEQ",
#!       1_names := [ "RETURN_VALUE" ],
#!       2_BINDING_RETURN_VALUE := rec(
#!           0_type := "EXPR_LIST",
#!           1_list := rec(
#!               0__type := "SYNTAX_TREE_LIST",
#!               0_length := 2,
#!               1 := rec(
#!                   0_type := "EXPR_FUNCCALL",
#!                   1_funcref := rec(
#!                       0_type := "EXPR_REF_GVAR",
#!                       1_gvar := "List" ),
#!                   2_args := rec(
#!                       0__type := "SYNTAX_TREE_LIST",
#!                       0_length := 2,
#!                       1 := rec(
#!                           0_type := "EXPR_REF_FVAR",
#!                           1_func_id := 1000001,
#!                           2_name := "L1" ),
#!                       2 := rec(
#!                           0_type := "EXPR_DECLARATIVE_FUNC",
#!                           1_id := 1000005,
#!                           2_nams := [ "logic_new_func_x", "RETURN_VALUE" ],
#!                           3_narg := 1,
#!                           4_variadic := false,
#!                           5_bindings := rec(
#!                               0_type := "FVAR_BINDING_SEQ",
#!                               1_names := [ "RETURN_VALUE" ],
#!                               2_BINDING_RETURN_VALUE := rec(
#!                                   0_type := "EXPR_FUNCCALL",
#!                                   1_CAP_JIT_IGNORE_OPERATION := true,
#!                                   2_funcref := rec(
#!                                       0_type := "EXPR_REF_GVAR",
#!                                       1_gvar := "Size" ),
#!                                   3_args := rec(
#!                                       0__type := "SYNTAX_TREE_LIST",
#!                                       0_length := 1,
#!                                       1 := rec(
#!                                           0_type := "EXPR_REF_FVAR",
#!                                           1_func_id := 1000005,
#!                                           2_name := "logic_new_func_x" ) ) ) 
#!                              ) ) ) ),
#!               2 := rec(
#!                   0_type := "EXPR_FUNCCALL",
#!                   1_funcref := rec(
#!                       0_type := "EXPR_REF_GVAR",
#!                       1_gvar := "List" ),
#!                   2_args := rec(
#!                       0__type := "SYNTAX_TREE_LIST",
#!                       0_length := 2,
#!                       1 := rec(
#!                           0_type := "EXPR_REF_FVAR",
#!                           1_func_id := 1000001,
#!                           2_name := "L1" ),
#!                       2 := rec(
#!                           0_type := "EXPR_DECLARATIVE_FUNC",
#!                           1_id := 1000008,
#!                           2_nams := [ "logic_new_func_x", "RETURN_VALUE" ],
#!                           3_narg := 1,
#!                           4_variadic := false,
#!                           5_bindings := rec(
#!                               0_type := "FVAR_BINDING_SEQ",
#!                               1_names := [ "RETURN_VALUE" ],
#!                               2_BINDING_RETURN_VALUE := rec(
#!                                   0_type := "EXPR_FUNCCALL",
#!                                   1_funcref := rec(
#!                                       0_type := "EXPR_REF_GVAR",
#!                                       1_gvar := "Size" ),
#!                                   2_args := rec(
#!                                       0__type := "SYNTAX_TREE_LIST",
#!                                       0_length := 1,
#!                                       1 := rec(
#!                                           0_type := "EXPR_REF_FVAR",
#!                                           1_func_id := 1000008,
#!                                           2_name := "logic_new_func_x" ) ) ) 
#!                              ) ) ) ) ) ) ) )

T1 := tree.bindings.BINDING_RETURN_VALUE.list.1;;
T2 := tree.bindings.BINDING_RETURN_VALUE.list.2;;

IsBound( T1.args.2.bindings.BINDING_RETURN_VALUE.CAP_JIT_IGNORE_OPERATION );
#! true

IsBound( T2.args.2.bindings.BINDING_RETURN_VALUE.CAP_JIT_IGNORE_OPERATION );
#! false

CapJitIsEqualForEnhancedSyntaxTrees( T2, T1 );
#! true

CAP_JIT_INTERNAL_FUNCTION_ID := original_func_id;;

#! @EndExample
