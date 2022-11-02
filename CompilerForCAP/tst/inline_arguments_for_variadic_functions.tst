gap> START_TEST( "inline_arguments_for_variadic_functions" );

#
gap> LoadPackage( "CompilerForCAP", false );
true

#
gap> func := function ( )
>   local x; x := { args... } -> 1; return x( ); end;;

#
gap> Display( CapJitCompiledFunction( func ) );
function (  )
    return 1;
end

#
gap> STOP_TEST( "inline_arguments_for_variadic_functions" );
