#! @Chapter Examples and tests

#! @Section Tests

LoadPackage( "CompilerForCAP" );

#! @Example

func1 := function( x, y )
    #% CAP_JIT_RESOLVE_FUNCTION
    return x; end;;

func2 := function( )
  local var; var := 1; var := func1( 2, var ); return var; end;;

compiled_func := CapJitCompiledFunction( func2 );;
compiled_func();
#! 2

#! @EndExample
