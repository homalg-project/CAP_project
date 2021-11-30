#! @Chapter Examples and tests

#! @Section Tests

#! @Example

LoadPackage( "CompilerForCAP", false );
#! true

# check that CapJitInlinedBindings is idempotent
func := function ( )
  local val1, val2; val1 := 1; val2 := val1; return val2; end;;

tree := ENHANCED_SYNTAX_TREE( func );;

tree := CapJitInlinedBindings( tree );;
Display( ENHANCED_SYNTAX_TREE_CODE( tree ) );
#! function (  )
#!     local val1_1, val2_1;
#!     return 1;
#!     val2_1 := 1;
#!     val1_1 := 1;
#!     return;
#! end

tree2 := CapJitInlinedBindings( tree );;
Display( ENHANCED_SYNTAX_TREE_CODE( tree2 ) );
#! function (  )
#!     local val1_1, val2_1;
#!     return 1;
#!     val2_1 := 1;
#!     val1_1 := 1;
#!     return;
#! end

tree = tree2;
#! true

#! @EndExample
