#! @Chapter Examples and tests

#! @Section Tests

#! @Example

LoadPackage( "CompilerForCAP", false );
#! true

func := x -> MatElm( x, 1, 1 );;
tree := ENHANCED_SYNTAX_TREE( func );;
tree := CapJitResolvedGlobalVariables( tree );;
Display( ENHANCED_SYNTAX_TREE_CODE( tree ) );
#! function ( x_1 )
#!     return x_1[1, 1];
#! end

#! @EndExample
