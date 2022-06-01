#! @Chapter Examples and tests

#! @Section Tests

#! @Example

LoadPackage( "CompilerForCAP", false );
#! true

dummy := DummyCategory( rec(
    list_of_operations_to_install := [
        "IdentityMorphism",
        "ZeroObject",
        "KernelObject",
    ],
) );;

StopCompilationAtPrimitivelyInstalledOperationsOfCategory( dummy );

CapJitEnableProofAssistantMode( );

func :=
    cat -> KernelObject( cat, IdentityMorphism( cat, ZeroObject( cat ) ) );;

Display( CapJitCompiledFunction( func, dummy ) );
#! WARNING: the CAP operation KernelObject is not compatible with the congruence \
#! of morphisms. Keep this in mind when writing logic templates.
#! WARNING: the CAP operation KernelObject is not compatible with the congruence \
#! of morphisms. Keep this in mind when writing logic templates.
#! function ( cat_1 )
#!     return KernelObject( cat_1, IdentityMorphism( cat_1, ZeroObject( cat_1 ) 
#!          ) );
#! end

CapJitDisableProofAssistantMode( );

Display( CapJitCompiledFunction( func, dummy ) );
#! function ( cat_1 )
#!     return KernelObject( cat_1, IdentityMorphism( cat_1, ZeroObject( cat_1 ) 
#!          ) );
#! end

#! @EndExample
