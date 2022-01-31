#! @Chapter Examples and tests

#! @Section Tests

LoadPackage( "CompilerForCAP" );

#! @Example

func := function ( )
    #% CAP_JIT_DROP_NEXT_STATEMENT
    Display( 1 ); return 1; end;;

Display( CapJitCompiledFunction( func ) );
#! function ( )
#!     return 1;
#! end

#! @EndExample
