#! @Chapter Examples and tests

#! @Section Tests

#! @Example

LoadPackage( "CompilerForCAP", false );
#! true

# test that `CAP_JIT_NOT_RESOLVABLE` does not cause errors when comparing
# syntax trees
DeclareOperation( "MyNonResolvableOperation", [ ] );

func := { } -> MyNonResolvableOperation( );;

tree := ENHANCED_SYNTAX_TREE( func );;

tree2 := StructuralCopy( tree );;
tree2.bindings.BINDING_RETURN_VALUE.funcref.CAP_JIT_NOT_RESOLVABLE := true;;

CapJitIsEqualForEnhancedSyntaxTrees( tree, tree2 );
#! true

#! @EndExample
