#! @Chapter Examples and tests

#! @Section Tests

#! @Example

LoadPackage( "CompilerForCAP", false );
#! true

##
# duplicate code inside a function
func := function( x )
    return List( [ 1 .. 9 ], y -> (y + (x + 1)) + (y + (x + 1)) ); end;;

tree := ENHANCED_SYNTAX_TREE( func );;
tree := CapJitDeduplicatedExpressions( tree );;
compiled_func := ENHANCED_SYNTAX_TREE_CODE( tree );;
Display( compiled_func );
#! function ( x_1 )
#!     return List( [ 1 .. 9 ], function ( y_2 )
#!             local cap_jit_deduplicated_expression_1_2;
#!             cap_jit_deduplicated_expression_1_2 := y_2 + (x_1 + 1);
#!             return cap_jit_deduplicated_expression_1_2 
#!               + cap_jit_deduplicated_expression_1_2;
#!         end );
#! end

##
# duplicate code inside duplicate code
func := function( x, y )
    return (y + (x + 1) + (x + 1)) + (y + (x + 1) + (x + 1)); end;;

tree := ENHANCED_SYNTAX_TREE( func );;
tree := CapJitDeduplicatedExpressions( tree );;
compiled_func := ENHANCED_SYNTAX_TREE_CODE( tree );;
Display( compiled_func );
#! function ( x_1, y_1 )
#!     local cap_jit_deduplicated_expression_1_1, 
#!     cap_jit_deduplicated_expression_2_1;
#!     cap_jit_deduplicated_expression_2_1 := x_1 + 1;
#!     cap_jit_deduplicated_expression_1_1 
#!      := y_1 + cap_jit_deduplicated_expression_2_1 
#!       + cap_jit_deduplicated_expression_2_1;
#!     return cap_jit_deduplicated_expression_1_1 
#!       + cap_jit_deduplicated_expression_1_1;
#! end

##
# don't deduplicate code accross functions
func := function( )
    return [ [ x -> (x + 1) + 2 ], [ x -> (x + 1) + 3 ] ]; end;;

tree := ENHANCED_SYNTAX_TREE( func );;
tree := CapJitDeduplicatedExpressions( tree );;
compiled_func := ENHANCED_SYNTAX_TREE_CODE( tree );;
Display( compiled_func );
#! function (  )
#!     return [ [ function ( x_2 )
#!                   return x_2 + 1 + 2;
#!               end ], [ function ( x_2 )
#!                   return x_2 + 1 + 3;
#!               end ] ];
#! end

##
# duplicate code inside duplicate code at different function levels
func := {} ->
    y -> [ [ y, x -> (x + 1) + (x + 1) ], [ y, x -> (x + 1) + (x + 1) ] ];;

tree := ENHANCED_SYNTAX_TREE( func );;
tree := CapJitDeduplicatedExpressions( tree );;
compiled_func := ENHANCED_SYNTAX_TREE_CODE( tree );;
Display( compiled_func );
#! function (  )
#!     return function ( y_2 )
#!           local cap_jit_deduplicated_expression_1_2;
#!           cap_jit_deduplicated_expression_1_2 := [ y_2, function ( x_3 )
#!                     local cap_jit_deduplicated_expression_1_3;
#!                     cap_jit_deduplicated_expression_1_3 := x_3 + 1;
#!                     return cap_jit_deduplicated_expression_1_3 
#!                       + cap_jit_deduplicated_expression_1_3;
#!                 end ];
#!           return 
#!            [ cap_jit_deduplicated_expression_1_2, 
#!               cap_jit_deduplicated_expression_1_2 ];
#!       end;
#! end

##
# deduplication after hoisting in duplicated code
func := { f, L } ->
    [ f( y -> List( L, l -> y + y ) ), f( y -> List( L, l -> y + y ) ) ];;

tree := ENHANCED_SYNTAX_TREE( func );;
tree := CapJitHoistedExpressions( tree );;
tree := CapJitDeduplicatedExpressions( tree );;
compiled_func := ENHANCED_SYNTAX_TREE_CODE( tree );;
Display( compiled_func );
#! function ( f_1, L_1 )
#!     local cap_jit_deduplicated_expression_1_1;
#!     cap_jit_deduplicated_expression_1_1 := f_1( function ( y_2 )
#!             local cap_jit_hoisted_expression_1_2;
#!             cap_jit_hoisted_expression_1_2 := y_2 + y_2;
#!             return List( L_1, function ( l_3 )
#!                     return cap_jit_hoisted_expression_1_2;
#!                 end );
#!         end );
#!     return 
#!      [ cap_jit_deduplicated_expression_1_1, 
#!         cap_jit_deduplicated_expression_1_1 ];
#! end

#! @EndExample
