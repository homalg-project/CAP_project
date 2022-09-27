gap> START_TEST( "CapJitEnableStepByStepCompilation" );

#
gap> LoadPackage( "CompilerForCAP", false );
true

#
gap> CapJitDisableDataTypeInference( );

#
gap> CapJitEnableStepByStepCompilation( );

#
gap> dummy := DummyCategory( rec(
>     list_of_operations_to_install := [
>         "ZeroObject",
>         "ZeroMorphism",
>     ],
> ) );;

#
gap> StopCompilationAtPrimitivelyInstalledOperationsOfCategory( dummy );

#
gap> func := cat -> ZeroObjectFunctorialWithGivenZeroObjects( cat,
>     ZeroObject( cat ),
>     ZeroObject( cat )
> );;

#
gap> compiled_func := CapJitCompiledFunction( func, dummy );;
gap> Display( compiled_func );
function ( cat_1 )
    return ZeroObjectFunctorial( cat_1 );
end

#
gap> compiled_func := CapJitCompiledFunction( compiled_func, dummy );;
gap> Display( compiled_func );
function ( cat_1 )
    local deduped_1_1;
    deduped_1_1 := ZeroObject( cat_1 );
    return ZeroMorphism( cat_1, deduped_1_1, deduped_1_1 );
end

#
#
#
gap> CapJitDisableStepByStepCompilation( );

#
gap> dummy := DummyCategory( rec(
>     list_of_operations_to_install := [
>         "ZeroObject",
>         "ZeroMorphism",
>     ],
> ) );;

#
gap> StopCompilationAtPrimitivelyInstalledOperationsOfCategory( dummy );
gap> func := cat -> ZeroObjectFunctorialWithGivenZeroObjects( cat,
>     ZeroObject( cat ),
>     ZeroObject( cat )
> );;

#
gap> compiled_func := CapJitCompiledFunction( func, dummy );;
gap> Display( compiled_func );
function ( cat_1 )
    local deduped_1_1;
    deduped_1_1 := ZeroObject( cat_1 );
    return ZeroMorphism( cat_1, deduped_1_1, deduped_1_1 );
end

#
#
gap> CapJitEnableDataTypeInference( );

#
gap> STOP_TEST( "CapJitEnableStepByStepCompilation" );
