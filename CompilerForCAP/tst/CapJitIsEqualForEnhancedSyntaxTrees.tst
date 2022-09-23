gap> START_TEST( "CapJitIsEqualForEnhancedSyntaxTrees" );

#
gap> LoadPackage( "CompilerForCAP", false );
true

# test that `CAP_JIT_NOT_RESOLVABLE` does not cause errors when comparing syntax trees
gap> DeclareOperation( "MyNonResolvableOperation", [ ] );

#
gap> func := { } -> MyNonResolvableOperation( );;

#
gap> tree := ENHANCED_SYNTAX_TREE( func );;

#
gap> tree2 := StructuralCopy( tree );;
gap> tree2.bindings.BINDING_RETURN_VALUE.funcref.CAP_JIT_NOT_RESOLVABLE := true;;

#
gap> CapJitIsEqualForEnhancedSyntaxTrees( tree, tree2 );
true

#
gap> STOP_TEST( "CapJitIsEqualForEnhancedSyntaxTrees" );
