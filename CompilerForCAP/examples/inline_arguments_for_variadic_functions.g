#! @Chapter Examples and tests

#! @Section Tests

LoadPackage( "CompilerForCAP" );

#! @Example

func := function ( )
  local x; x := { args... } -> 1; return x( ); end;;

Display( CapJitCompiledFunction( func ) );
#! function ( )
#!     return 1;
#! end

#! @EndExample
