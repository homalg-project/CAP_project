gap> START_TEST( "unique_function_ids" );

#
gap> LoadPackage( "CompilerForCAP", false );
true

#
gap> func := function( )
>   local id; id := y -> y; return [ id, id ]; end;;

# we are not interested in the output, but only that this does not throw
# an error due to some function id being used multiple times
gap> CapJitCompiledFunction( func );;

#
gap> STOP_TEST( "unique_function_ids" );
