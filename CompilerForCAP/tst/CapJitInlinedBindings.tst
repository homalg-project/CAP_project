gap> START_TEST( "CapJitInlinedBindings" );

#
gap> LoadPackage( "CompilerForCAP", false );
true
gap> LoadPackage( "LinearAlgebraForCAP", false );
true

# check that CapJitInlinedBindings is idempotent
gap> func := function ( )
>   local val1, val2; val1 := 1; val2 := val1; return val2; end;;

#
gap> tree := ENHANCED_SYNTAX_TREE( func );;

#
gap> tree := CapJitInlinedBindings( tree );;
gap> Display( ENHANCED_SYNTAX_TREE_CODE( tree ) );
function (  )
    return 1;
end

#
gap> tree2 := CapJitInlinedBindings( tree );;
gap> Display( ENHANCED_SYNTAX_TREE_CODE( tree2 ) );
function (  )
    return 1;
end

#
gap> tree = tree2;
true

#
#
# check that CapJitInlinedBindingsToVariableReferences is idempotent
gap> func := function ( )
>   local f1, f2; f1 := IdFunc; f2 := f1; return f2; end;;

#
gap> tree := ENHANCED_SYNTAX_TREE( func );;

#
gap> tree := CapJitInlinedBindingsToVariableReferences( tree );;
gap> Display( ENHANCED_SYNTAX_TREE_CODE( tree ) );
function (  )
    return IdFunc;
end

#
gap> tree2 := CapJitInlinedBindingsToVariableReferences( tree );;
gap> Display( ENHANCED_SYNTAX_TREE_CODE( tree2 ) );
function (  )
    return IdFunc;
end

#
gap> tree = tree2;
true

#
gap> STOP_TEST( "CapJitInlinedBindings" );
