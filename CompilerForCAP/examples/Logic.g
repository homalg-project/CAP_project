#! @Chapter Examples and tests

#! @Section Tests

#! @Example

LoadPackage( "CompilerForCAP", false );
#! true

func := function ( )
  return List( [ 1, 2 ], x -> x ); end;;

tree := ENHANCED_SYNTAX_TREE( func );;
tree := CapJitAppliedLogic( tree );;
Display( ENHANCED_SYNTAX_TREE_CODE( tree ) );
#! function (  )
#!     return [ function ( x_2 )
#!                 return x_2;
#!             end( 1 ), function ( x_2 )
#!                 return x_2;
#!             end( 2 ) ];
#! end

func := function ( )
  return Concatenation( [ 1, 2 ], [ 3, 4 ] ); end;;

tree := ENHANCED_SYNTAX_TREE( func );;
tree := CapJitAppliedLogic( tree );;
Display( ENHANCED_SYNTAX_TREE_CODE( tree ) );
#! function (  )
#!     return [ 1, 2, 3, 4 ];
#! end

func := function ( )
  return Concatenation( [ [ 1, 2 ], [ 3, 4 ] ] ); end;;

tree := ENHANCED_SYNTAX_TREE( func );;
tree := CapJitAppliedLogic( tree );;
Display( ENHANCED_SYNTAX_TREE_CODE( tree ) );
#! function (  )
#!     return [ 1, 2, 3, 4 ];
#! end

func := function ( my_func )
  return CallFuncList( my_func, [ 1, 2 ] ); end;;

tree := ENHANCED_SYNTAX_TREE( func );;
tree := CapJitAppliedLogic( tree );;
Display( ENHANCED_SYNTAX_TREE_CODE( tree ) );
#! function ( my_func_1 )
#!     return my_func_1( 1, 2 );
#! end

func := function ( x )
  if 1 = 2 then return 1; elif x = x then return 2; else return 3; fi; end;;

tree := ENHANCED_SYNTAX_TREE( func );;
tree := CapJitAppliedLogic( tree );;
Display( ENHANCED_SYNTAX_TREE_CODE( tree ) );
#! function ( x_1 )
#!     if false then
#!         return 1;
#!     elif true then
#!         return 2;
#!     else
#!         return 3;
#!     fi;
#!     return;
#! end

func := function ( x )
  return Length( [ 1, 2, 3 ] ); end;;

tree := ENHANCED_SYNTAX_TREE( func );;
tree := CapJitAppliedLogic( tree );;
Display( ENHANCED_SYNTAX_TREE_CODE( tree ) );
#! function ( x_1 )
#!     return 3;
#! end

func := function ( x )
  return [ 1 .. 3 ]; end;;

tree := ENHANCED_SYNTAX_TREE( func );;
tree := CapJitAppliedLogic( tree );;
Display( ENHANCED_SYNTAX_TREE_CODE( tree ) );
#! function ( x_1 )
#!     return [ 1, 2, 3 ];
#! end

#! @EndExample
