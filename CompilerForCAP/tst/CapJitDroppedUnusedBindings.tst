gap> START_TEST( "CapJitDroppedUnusedBindings" );

#
gap> LoadPackage( "CompilerForCAP", false );
true

# check that CapJitDroppedUnusedBindings is idempotent
# (one function level)
gap> func := function ( )
>   local val1, val2; val1 := 1; val2 := val1; return 1; end;;

#
gap> tree := ENHANCED_SYNTAX_TREE( func );;

#
gap> tree := CapJitDroppedUnusedBindings( tree );;
gap> Display( ENHANCED_SYNTAX_TREE_CODE( tree ) );
function (  )
    return 1;
end

#
gap> tree2 := CapJitDroppedUnusedBindings( tree );;
gap> Display( ENHANCED_SYNTAX_TREE_CODE( tree2 ) );
function (  )
    return 1;
end

#
gap> tree = tree2;
true

# check that CapJitDroppedUnusedBindings is idempotent
# (multiple function levels)
gap> func := function( x )
>   local val1;
>     
>     val1 := 1;
>     
>     return function ( )
>       local val2;
>         
>         val2 := val1;
>         
>         return 1;
>         
>     end;
>     
> end;;

#
gap> tree := ENHANCED_SYNTAX_TREE( func );;

#
gap> tree := CapJitDroppedUnusedBindings( tree );;
gap> Display( ENHANCED_SYNTAX_TREE_CODE( tree ) );
function ( x_1 )
    return function (  )
          return 1;
      end;
end

#
gap> tree2 := CapJitDroppedUnusedBindings( tree );;
gap> Display( ENHANCED_SYNTAX_TREE_CODE( tree2 ) );
function ( x_1 )
    return function (  )
          return 1;
      end;
end

#
gap> tree = tree2;
true

#
gap> STOP_TEST( "CapJitDroppedUnusedBindings" );
