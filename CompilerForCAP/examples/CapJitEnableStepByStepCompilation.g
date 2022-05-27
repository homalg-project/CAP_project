#! @Chapter Examples and tests

#! @Section Tests

#! @Example

LoadPackage( "CompilerForCAP", false );
#! true

CapJitDisableDataTypeInference( );

CapJitEnableStepByStepCompilation( );

dummy := DummyCategory( rec(
    list_of_operations_to_install := [
        "ZeroObject",
        "ZeroMorphism",
    ],
) );;

StopCompilationAtPrimitivelyInstalledOperationsOfCategory( dummy );

func := cat -> ZeroObjectFunctorialWithGivenZeroObjects( cat,
    ZeroObject( cat ),
    ZeroObject( cat )
);;

compiled_func := CapJitCompiledFunction( func, dummy );;
Display( compiled_func );
#! function ( cat_1 )
#!     return ZeroObjectFunctorial( cat_1 );
#! end

compiled_func := CapJitCompiledFunction( compiled_func, dummy );;
Display( compiled_func );
#! function ( cat_1 )
#!     local deduped_1_1;
#!     deduped_1_1 := ZeroObject( cat_1 );
#!     return ZeroMorphism( cat_1, deduped_1_1, deduped_1_1 );
#! end



CapJitDisableStepByStepCompilation( );

dummy := DummyCategory( rec(
    list_of_operations_to_install := [
        "ZeroObject",
        "ZeroMorphism",
    ],
) );;

StopCompilationAtPrimitivelyInstalledOperationsOfCategory( dummy );

func := cat -> ZeroObjectFunctorialWithGivenZeroObjects( cat,
    ZeroObject( cat ),
    ZeroObject( cat )
);;

compiled_func := CapJitCompiledFunction( func, dummy );;
Display( compiled_func );
#! function ( cat_1 )
#!     local deduped_1_1;
#!     deduped_1_1 := ZeroObject( cat_1 );
#!     return ZeroMorphism( cat_1, deduped_1_1, deduped_1_1 );
#! end


CapJitEnableDataTypeInference( );


#! @EndExample
