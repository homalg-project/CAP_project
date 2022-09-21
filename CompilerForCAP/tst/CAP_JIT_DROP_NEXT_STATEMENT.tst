gap> START_TEST( "CAP_JIT_DROP_NEXT_STATEMENT" );

#
gap> LoadPackage( "CompilerForCAP", false );
true

#
gap> func := function ( )
>     #% CAP_JIT_DROP_NEXT_STATEMENT
>     Display( 1 ); return 1; end;;

#
gap> Display( CapJitCompiledFunction( func ) );
function (  )
    return 1;
end

#
gap> STOP_TEST( "CAP_JIT_DROP_NEXT_STATEMENT" );
