#! @Chapter Examples and tests

#! @Section Tests

LoadPackage( "CompilerForCAP" );

#! @Example

KeyDependentOperation( "MyKeyDependentOperation",
                       IsGroup, IsInt, ReturnTrue );;

InstallMethod( MyKeyDependentOperationOp,
    [ IsGroup, IsInt ],
    function( G, int )
        #% CAP_JIT_RESOLVE_FUNCTION
        return int; end );;

G := SymmetricGroup(3);;

MyKeyDependentOperation( G, 2 ) = 2;
#! true

MyFunction := G -> MyKeyDependentOperation( G, 2 );;

compiled_func := CapJitCompiledFunction( MyFunction, [ G ] );;

Display( compiled_func );
#! function ( G_1 )
#!     return 2;
#! end

#! @EndExample
