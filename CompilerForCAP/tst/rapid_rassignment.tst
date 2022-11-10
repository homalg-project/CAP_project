gap> START_TEST( "rapid_rassignment" );

#
gap> LoadPackage( "CompilerForCAP", false );
true

#
gap> func1 := function( x, y )
>     #% CAP_JIT_RESOLVE_FUNCTION
>     return x; end;;

#
gap> func2 := function( )
>   local var; var := 1; var := func1( 2, var ); return var; end;;

#
gap> compiled_func := CapJitCompiledFunction( func2 );;
gap> compiled_func();
2

#
gap> STOP_TEST( "rapid_rassignment" );
