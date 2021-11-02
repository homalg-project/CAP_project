#! @Chapter Examples and tests

#! @Section Tests

#! @Example

LoadPackage( "CompilerForCAP", false );
#! true

# check that CapJitDroppedUnusedBindings is idempotent
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

#! @EndExample
