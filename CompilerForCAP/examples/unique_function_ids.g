#! @Chapter Examples and tests

#! @Section Tests

LoadPackage( "CompilerForCAP" );

#! @Example

func := function( )
  local id; id := y -> y; return [ id, id ]; end;;

# we are not interested in the output, but only that this does not throw
# an error due to some function id being used multiple times
CapJitCompiledFunction( func );;

#! @EndExample
