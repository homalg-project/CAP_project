gap> START_TEST( "CapJitEnableProofAssistantMode" );

#
gap> LoadPackage( "CompilerForCAP", false );
true

#
gap> dummy := DummyCategory( rec(
>     list_of_operations_to_install := [
>         "IdentityMorphism",
>         "ZeroObject",
>         "KernelObject",
>     ],
> ) );;

#
gap> StopCompilationAtPrimitivelyInstalledOperationsOfCategory( dummy );

#
gap> CapJitEnableProofAssistantMode( );

#
gap> func :=
>     cat -> KernelObject( cat, IdentityMorphism( cat, ZeroObject( cat ) ) );;

#
gap> Display( CapJitCompiledFunction( func, dummy ) );
WARNING: the CAP operation KernelObject is not compatible with the congruence \
of morphisms. Keep this in mind when writing logic templates.
WARNING: the CAP operation KernelObject is not compatible with the congruence \
of morphisms. Keep this in mind when writing logic templates.
function ( cat_1 )
    return KernelObject( cat_1, IdentityMorphism( cat_1, ZeroObject( cat_1 ) 
         ) );
end

#
gap> CapJitDisableProofAssistantMode( );

#
gap> Display( CapJitCompiledFunction( func, dummy ) );
function ( cat_1 )
    return KernelObject( cat_1, IdentityMorphism( cat_1, ZeroObject( cat_1 ) 
         ) );
end

#
gap> STOP_TEST( "CapJitEnableProofAssistantMode" );
