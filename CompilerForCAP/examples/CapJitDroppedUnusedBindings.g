#! @Chapter Examples and tests

#! @Section Tests

#! @Example

LoadPackage( "CompilerForCAP", false );
#! true

# check that CapJitDroppedUnusedBindings is idempotent
# (one function level)
func := function ( )
  local val1, val2; val1 := 1; val2 := val1; return 1; end;;

tree := ENHANCED_SYNTAX_TREE( func );;

tree := CapJitDroppedUnusedBindings( tree );;
Display( ENHANCED_SYNTAX_TREE_CODE( tree ) );
#! function (  )
#!     return 1;
#! end

tree2 := CapJitDroppedUnusedBindings( tree );;
Display( ENHANCED_SYNTAX_TREE_CODE( tree2 ) );
#! function (  )
#!     return 1;
#! end

tree = tree2;
#! true

# check that CapJitDroppedUnusedBindings is idempotent
# (multiple function levels)
# we have to work hard to not write semicolons so AutoDoc
# does not begin a new statement
func := EvalString( ReplacedString( """function( x )
  local val1@
    
    val1 := 1@
    
    return function ( )
      local val2@
        
        val2 := val1@
        
        return 1@
        
    end@
    
end""", "@", ";" ) );;

tree := ENHANCED_SYNTAX_TREE( func );;

tree := CapJitDroppedUnusedBindings( tree );;
Display( ENHANCED_SYNTAX_TREE_CODE( tree ) );
#! function ( x_1 )
#!     return function (  )
#!           return 1;
#!       end;
#! end

tree2 := CapJitDroppedUnusedBindings( tree );;
Display( ENHANCED_SYNTAX_TREE_CODE( tree2 ) );
#! function ( x_1 )
#!     return function (  )
#!           return 1;
#!       end;
#! end

tree = tree2;
#! true

#! @EndExample
