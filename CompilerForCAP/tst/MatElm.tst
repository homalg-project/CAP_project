gap> START_TEST( "MatElm" );

#
gap> LoadPackage( "CompilerForCAP", false );
true

#
gap> func := x -> MatElm( x, 1, 1 );;
gap> tree := ENHANCED_SYNTAX_TREE( func );;
gap> tree := CapJitResolvedGlobalVariables( tree );;
gap> Display( ENHANCED_SYNTAX_TREE_CODE( tree ) );
function ( x_1 )
    return \[\,\]( x_1, 1, 1 );
end

#
gap> STOP_TEST( "MatElm" );
