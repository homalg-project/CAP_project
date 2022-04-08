#! @Chapter Examples and tests

#! @Section Tests

#! @Example

LoadPackage( "CompilerForCAP", false );
#! true
LoadPackage( "LinearAlgebraForCAP", false );
#! true

# check that CapJitInlinedBindings is idempotent
func := function ( )
  local val1, val2; val1 := 1; val2 := val1; return val2; end;;

tree := ENHANCED_SYNTAX_TREE( func );;

tree := CapJitInlinedBindings( tree );;
Display( ENHANCED_SYNTAX_TREE_CODE( tree ) );
#! function (  )
#!     return 1;
#! end

tree2 := CapJitInlinedBindings( tree );;
Display( ENHANCED_SYNTAX_TREE_CODE( tree2 ) );
#! function (  )
#!     return 1;
#! end

tree = tree2;
#! true



# check that CapJitInlinedBindingsToVariableReferences is idempotent
func := function ( )
  local f1, f2; f1 := IdFunc; f2 := f1; return f2; end;;

tree := ENHANCED_SYNTAX_TREE( func );;

tree := CapJitInlinedBindingsToVariableReferences( tree );;
Display( ENHANCED_SYNTAX_TREE_CODE( tree ) );
#! function (  )
#!     return IdFunc;
#! end

tree2 := CapJitInlinedBindingsToVariableReferences( tree );;
Display( ENHANCED_SYNTAX_TREE_CODE( tree2 ) );
#! function (  )
#!     return IdFunc;
#! end

tree = tree2;
#! true

#! @EndExample
