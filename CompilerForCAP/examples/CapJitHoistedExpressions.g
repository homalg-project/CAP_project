#! @Chapter Examples and tests

#! @Section Tests

#! @Example

LoadPackage( "CompilerForCAP" );
#! true

##
# hoisting with deduplication
func := function( x )
    return List( [ 1 .. 9 ], y -> (y + (x + 1)) + (y + (x + 1)) ); end;;

tree := ENHANCED_SYNTAX_TREE( func );;
tree := CapJitHoistedExpressions( tree );;
compiled_func := ENHANCED_SYNTAX_TREE_CODE( tree );;
Display( compiled_func );
#! function ( x_1 )
#!     local hoisted_1_1;
#!     hoisted_1_1 := x_1 + 1;
#!     return List( [ 1 .. 9 ], function ( y_2 )
#!             return y_2 + hoisted_1_1 + (y_2 + hoisted_1_1);
#!         end );
#! end

##
# hoisting of whole functions
func := function( x )
    return List( [ 1 .. 9 ], y -> y + List( [ 1 .. 9 ], z -> x + z ) ); end;;

tree := ENHANCED_SYNTAX_TREE( func );;
tree := CapJitHoistedExpressions( tree );;
compiled_func := ENHANCED_SYNTAX_TREE_CODE( tree );;
Display( compiled_func );
#! function ( x_1 )
#!     local hoisted_1_1;
#!     hoisted_1_1 := List( [ 1 .. 9 ], function ( z_2 )
#!             return x_1 + z_2;
#!         end );
#!     return List( [ 1 .. 9 ], function ( y_2 )
#!             return y_2 + hoisted_1_1;
#!         end );
#! end

##
# no hoisting of constants
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
# hoisting of returned expressions
func := function( x )
    return List( [ 1 .. 9 ], y -> x + 1 ); end;;

tree := ENHANCED_SYNTAX_TREE( func );;
tree := CapJitHoistedExpressions( tree );;
compiled_func := ENHANCED_SYNTAX_TREE_CODE( tree );;
Display( compiled_func );
#! function ( x_1 )
#!     local hoisted_1_1;
#!     hoisted_1_1 := x_1 + 1;
#!     return List( [ 1 .. 9 ], function ( y_2 )
#!             return hoisted_1_1;
#!         end );
#! end

##
# hoisting of assigned expressions
func := function( x )
    return List( [ 1 .. 9 ], function( y )
        local z; z := x + 1; return z; end ); end;;

tree := ENHANCED_SYNTAX_TREE( func );;
tree := CapJitHoistedExpressions( tree );;
compiled_func := ENHANCED_SYNTAX_TREE_CODE( tree );;
Display( compiled_func );
#! function ( x_1 )
#!     local hoisted_1_1;
#!     hoisted_1_1 := x_1 + 1;
#!     return List( [ 1 .. 9 ], function ( y_2 )
#!             local z_2;
#!             z_2 := hoisted_1_1;
#!             return z_2;
#!         end );
#! end

##
# hosted expressions inside hosted expressions
func := function( x )
    return List( [ 1 .. 9 ], function( y )
        return List( [ 1 .. 9 ], z -> z + (1 + 1) ); end ); end;;

tree := ENHANCED_SYNTAX_TREE( func );;
tree := CapJitHoistedExpressions( tree );;
compiled_func := ENHANCED_SYNTAX_TREE_CODE( tree );;
Display( compiled_func );
#! function ( x_1 )
#!     local hoisted_1_1, hoisted_2_1;
#!     hoisted_1_1 := 1 + 1;
#!     hoisted_2_1 := List( [ 1 .. 9 ], function ( z_2 )
#!             return z_2 + hoisted_1_1;
#!         end );
#!     return List( [ 1 .. 9 ], function ( y_2 )
#!             return hoisted_2_1;
#!         end );
#! end

##
# deduplication of more complex trees, e.g. functions
func := function( list )
    return List( [ 1 .. 9 ], function( y )
        return (y + Sum( list, a -> a )) + Sum( list, a -> a ); end ); end;;

tree := ENHANCED_SYNTAX_TREE( func );;
tree := CapJitHoistedExpressions( tree );;
compiled_func := ENHANCED_SYNTAX_TREE_CODE( tree );;
Display( compiled_func );
#! function ( list_1 )
#!     local hoisted_1_1;
#!     hoisted_1_1 := Sum( list_1, function ( a_2 )
#!             return a_2;
#!         end );
#!     return List( [ 1 .. 9 ], function ( y_2 )
#!             return y_2 + hoisted_1_1 + hoisted_1_1;
#!         end );
#! end

##
# hosting of expressions in lists, e.g. function call arguments
func := function( x, func )
    return List( [ 1 .. 9 ], y -> func( x + 1, x + 1, y ) ); end;;

tree := ENHANCED_SYNTAX_TREE( func );;
tree := CapJitHoistedExpressions( tree );;
compiled_func := ENHANCED_SYNTAX_TREE_CODE( tree );;
Display( compiled_func );
#! function ( x_1, func_1 )
#!     local hoisted_1_1;
#!     hoisted_1_1 := x_1 + 1;
#!     return List( [ 1 .. 9 ], function ( y_2 )
#!             return func_1( hoisted_1_1, hoisted_1_1, y_2 );
#!         end );
#! end

##
# restrict hoisting to if/else branches (where possible)
func := function( x )
    if x < 0 then return 0; else return y -> [ x + 1, z -> y + 1 ]; fi; end;;

tree := ENHANCED_SYNTAX_TREE( func );;
tree := CapJitHoistedExpressions( tree );;
compiled_func := ENHANCED_SYNTAX_TREE_CODE( tree );;
Display( compiled_func );
#! function ( x_1 )
#!     local hoisted_1_1;
#!     if x_1 < 0 then
#!         return 0;
#!     else
#!         hoisted_1_1 := x_1 + 1;
#!         return function ( y_2 )
#!               local hoisted_1_2;
#!               hoisted_1_2 := y_2 + 1;
#!               return [ hoisted_1_1, function ( z_3 )
#!                         return hoisted_1_2;
#!                     end ];
#!           end;
#!     fi;
#!     return;
#! end

func := function( x )
    if x < 0 then return y -> [ x + 1, z -> y + 1 ]; else return 0; fi; end;;

tree := ENHANCED_SYNTAX_TREE( func );;
tree := CapJitHoistedExpressions( tree );;
compiled_func := ENHANCED_SYNTAX_TREE_CODE( tree );;
Display( compiled_func );
#! function ( x_1 )
#!     local hoisted_1_1;
#!     if x_1 < 0 then
#!         hoisted_1_1 := x_1 + 1;
#!         return function ( y_2 )
#!               local hoisted_1_2;
#!               hoisted_1_2 := y_2 + 1;
#!               return [ hoisted_1_1, function ( z_3 )
#!                         return hoisted_1_2;
#!                     end ];
#!           end;
#!     else
#!         return 0;
#!     fi;
#!     return;
#! end

func := function( x )
  if x < 0 then return y -> [ y, x+1 ]; else return y -> [ y, x+1 ]; fi; end;;

tree := ENHANCED_SYNTAX_TREE( func );;
tree := CapJitHoistedExpressions( tree );;
compiled_func := ENHANCED_SYNTAX_TREE_CODE( tree );;
Display( compiled_func );
#! function ( x_1 )
#!     local hoisted_1_1;
#!     hoisted_1_1 := x_1 + 1;
#!     if x_1 < 0 then
#!         return function ( y_2 )
#!               return [ y_2, hoisted_1_1 ];
#!           end;
#!     else
#!         return function ( y_2 )
#!               return [ y_2, hoisted_1_1 ];
#!           end;
#!     fi;
#!     return;
#! end

# CapJitHoistedBindings

# we have to work hard to not write semicolons so AutoDoc
# does not begin a new statement
func := EvalString( ReplacedString( """function (  )
  local var1, func1, func2@
    
    var1 := 1@
    
    func1 := function ( )
      local var2, var3@
        
        var2 := var1 + 1@
        
        var3 := var2 + 2@
        
        return var3@
        
    end@
    
    func2 := function ( )
      local var4, var5@
        
        var4 := var1 + 1@
        
        var5 := var4 + 2@
        
        return var5@
        
    end@
    
    return [ func1, func2 ]@
    
end""", "@", ";" ) );;

tree := ENHANCED_SYNTAX_TREE( func );;
tree := CapJitHoistedBindings( tree );;
compiled_func := ENHANCED_SYNTAX_TREE_CODE( tree );;
Display( compiled_func );
#! function (  )
#!     local var1_1, func1_1, func2_1, hoisted_3_1, hoisted_4_1;
#!     var1_1 := 1;
#!     hoisted_3_1 := var1_1 + 1;
#!     hoisted_4_1 := hoisted_3_1 + 2;
#!     func2_1 := function (  )
#!           return hoisted_4_1;
#!       end;
#!     func1_1 := function (  )
#!           return hoisted_4_1;
#!       end;
#!     return [ func1_1, func2_1 ];
#! end

#! @EndExample
