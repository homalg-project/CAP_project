#! @Chapter Examples and tests

#! @Section Tests

#! @Example

LoadPackage( "CompilerForCAP", false );
#! true

# check that CapJitResolvedGlobalVariables is idempotent

MY_GLOBAL_FUNCTION_1 := function ( x )
    #% CAP_JIT_RESOLVE_FUNCTION
    return x; end;;

MY_GLOBAL_FUNCTION_2 := function ( x )
    #% CAP_JIT_RESOLVE_FUNCTION
    return MY_GLOBAL_FUNCTION_1( x ); end;;

MY_CAP_CATEGORY_1 := CreateCapCategory( );;
MY_CAP_CATEGORY_2 := CreateCapCategory( );;
SetUnderlyingCategory( MY_CAP_CATEGORY_1, MY_CAP_CATEGORY_2 );

DeclareAttribute( "MyAttribute", IsCapCategory );

SetMyAttribute( MY_CAP_CATEGORY_2, MY_GLOBAL_FUNCTION_2 );

func := function ( )
  return MY_GLOBAL_FUNCTION_2( MyAttribute(
        UnderlyingCategory( MY_CAP_CATEGORY_1 )
    ) ); end;;

tree := ENHANCED_SYNTAX_TREE( func );;

tree := CapJitResolvedGlobalVariables( tree );;
Display( ENHANCED_SYNTAX_TREE_CODE( tree ) );
#! function (  )
#!     return function ( x_2 )
#!             return function ( x_3 )
#!                     return x_3;
#!                 end( x_2 );
#!         end( function ( x_2 )
#!             return function ( x_3 )
#!                     return x_3;
#!                 end( x_2 );
#!         end );
#! end

tree2 := CapJitResolvedGlobalVariables( tree );;
Display( ENHANCED_SYNTAX_TREE_CODE( tree2 ) );
#! function (  )
#!     return function ( x_2 )
#!             return function ( x_3 )
#!                     return x_3;
#!                 end( x_2 );
#!         end( function ( x_2 )
#!             return function ( x_3 )
#!                     return x_3;
#!                 end( x_2 );
#!         end );
#! end

tree = tree2;
#! true

#! @EndExample
