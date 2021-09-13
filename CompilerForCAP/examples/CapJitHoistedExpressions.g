#! @Chapter Examples and tests

#! @Section Tests

#! @Example

LoadPackage( "CompilerForCAP" );
#! true

##
func := function( x )
    return List( [ 1 .. 9 ], y -> (y + (x + 1)) + (y + (x + 1)) ); end;;

tree := ENHANCED_SYNTAX_TREE( func );;
tree := CapJitHoistedExpressions( tree );;
compiled_func := ENHANCED_SYNTAX_TREE_CODE( tree );;
Display( compiled_func );
#! function ( x_1 )
#!     local cap_jit_hoisted_expression_1_1;
#!     cap_jit_hoisted_expression_1_1 := x_1 + 1;
#!     return List( [ 1 .. 9 ], function ( y_2 )
#!             return y_2 + cap_jit_hoisted_expression_1_1 
#!               + (y_2 + cap_jit_hoisted_expression_1_1);
#!         end );
#! end

##
func := function( x )
    return List( [ 1 .. 9 ], y -> y + List( [ 1 .. 9 ], z -> x + z ) ); end;;

tree := ENHANCED_SYNTAX_TREE( func );;
tree := CapJitHoistedExpressions( tree );;
compiled_func := ENHANCED_SYNTAX_TREE_CODE( tree );;
Display( compiled_func );
#! function ( x_1 )
#!     local cap_jit_hoisted_expression_1_1;
#!     cap_jit_hoisted_expression_1_1 := List( [ 1 .. 9 ], function ( z_2 )
#!             return x_1 + z_2;
#!         end );
#!     return List( [ 1 .. 9 ], function ( y_2 )
#!             return y_2 + cap_jit_hoisted_expression_1_1;
#!         end );
#! end

##
func := function( x )
    return List( [ 1 .. 9 ], y -> y + 1 ); end;;

tree := ENHANCED_SYNTAX_TREE( func );;
tree := CapJitHoistedExpressions( tree );;
compiled_func := ENHANCED_SYNTAX_TREE_CODE( tree );;
Display( compiled_func );
#! function ( x_1 )
#!     return List( [ 1 .. 9 ], function ( y_2 )
#!             return y_2 + 1;
#!         end );
#! end

##
func := function( x )
    return List( [ 1 .. 9 ], y -> x + 1 ); end;;

tree := ENHANCED_SYNTAX_TREE( func );;
tree := CapJitHoistedExpressions( tree );;
compiled_func := ENHANCED_SYNTAX_TREE_CODE( tree );;
Display( compiled_func );
#! function ( x_1 )
#!     local cap_jit_hoisted_expression_1_1;
#!     cap_jit_hoisted_expression_1_1 := x_1 + 1;
#!     return List( [ 1 .. 9 ], function ( y_2 )
#!             return cap_jit_hoisted_expression_1_1;
#!         end );
#! end

##
func := function( x )
    return List( [ 1 .. 9 ], function( y )
        local z; z := x + 1; return z; end ); end;;

tree := ENHANCED_SYNTAX_TREE( func );;
tree := CapJitHoistedExpressions( tree );;
compiled_func := ENHANCED_SYNTAX_TREE_CODE( tree );;
Display( compiled_func );
#! function ( x_1 )
#!     local cap_jit_hoisted_expression_1_1;
#!     cap_jit_hoisted_expression_1_1 := x_1 + 1;
#!     return List( [ 1 .. 9 ], function ( y_2 )
#!             local z_2;
#!             z_2 := cap_jit_hoisted_expression_1_1;
#!             return z_2;
#!         end );
#! end

##
func := function( x )
    return List( [ 1 .. 9 ], function( y )
        return List( [ 1 .. 9 ], z -> z + (1 + 1) ); end ); end;;

tree := ENHANCED_SYNTAX_TREE( func );;
tree := CapJitHoistedExpressions( tree );;
compiled_func := ENHANCED_SYNTAX_TREE_CODE( tree );;
Display( compiled_func );
#! function ( x_1 )
#!     local cap_jit_hoisted_expression_1_1, cap_jit_hoisted_expression_2_1;
#!     cap_jit_hoisted_expression_1_1 := 1 + 1;
#!     cap_jit_hoisted_expression_2_1 := List( [ 1 .. 9 ], function ( z_2 )
#!             return z_2 + cap_jit_hoisted_expression_1_1;
#!         end );
#!     return List( [ 1 .. 9 ], function ( y_2 )
#!             return cap_jit_hoisted_expression_2_1;
#!         end );
#! end

##
func := function( list )
    return List( [ 1 .. 9 ], function( y )
        return (y + Sum( list, a -> a )) + Sum( list, a -> a ); end ); end;;

tree := ENHANCED_SYNTAX_TREE( func );;
tree := CapJitHoistedExpressions( tree );;
compiled_func := ENHANCED_SYNTAX_TREE_CODE( tree );;
Display( compiled_func );
#! function ( list_1 )
#!     local cap_jit_hoisted_expression_1_1;
#!     cap_jit_hoisted_expression_1_1 := Sum( list_1, function ( a_2 )
#!             return a_2;
#!         end );
#!     return List( [ 1 .. 9 ], function ( y_2 )
#!             return y_2 + cap_jit_hoisted_expression_1_1 
#!               + cap_jit_hoisted_expression_1_1;
#!         end );
#! end

##
func := function( x, func )
    return List( [ 1 .. 9 ], y -> func( x + 1, x + 1, y ) ); end;;

tree := ENHANCED_SYNTAX_TREE( func );;
tree := CapJitHoistedExpressions( tree );;
compiled_func := ENHANCED_SYNTAX_TREE_CODE( tree );;
Display( compiled_func );
#! function ( x_1, func_1 )
#!     local cap_jit_hoisted_expression_1_1;
#!     cap_jit_hoisted_expression_1_1 := x_1 + 1;
#!     return List( [ 1 .. 9 ], function ( y_2 )
#!             return func_1( cap_jit_hoisted_expression_1_1, 
#!                cap_jit_hoisted_expression_1_1, y_2 );
#!         end );
#! end

#! @EndExample
