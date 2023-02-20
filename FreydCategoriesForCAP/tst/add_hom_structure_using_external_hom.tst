gap> START_TEST( "add_hom_structure_using_external_hom" );

#
gap> LoadPackage( "FreydCategoriesForCAP", false );
true
gap> dummy := DummyCategory( rec(
>                list_of_operations_to_install :=  [
>                    "MultiplyWithElementOfCommutativeRingForMorphisms",
>                    "PreComposeList",
>                    "SumOfMorphisms" ],
>                properties := [ "IsLinearCategoryOverCommutativeRing" ] ) : FinalizeCategory := false );;
gap> AddBasisOfExternalHom( dummy, ReturnNothing );
gap> AddCoefficientsOfMorphism( dummy, ReturnNothing );
gap> field := HomalgFieldOfRationals( );
Q
gap> SetCommutativeRingOfLinearCategory( dummy, field );
gap> SetRangeCategoryOfHomomorphismStructure( dummy, CategoryOfRows( field ) );
gap> SetIsEquippedWithHomomorphismStructure( dummy, true );
gap> Finalize( dummy );;
gap> IsLinearCategoryOverCommutativeRing( dummy );
true
gap> ForAll( [  "HomomorphismStructureOnObjects",
>               "HomomorphismStructureOnMorphismsWithGivenObjects",
>               "DistinguishedObjectOfHomomorphismStructure",
>               "InterpretMorphismAsMorphismFromDistinguishedObjectToHomomorphismStructureWithGivenObjects",
>               "InterpretMorphismFromDistinguishedObjectToHomomorphismStructureAsMorphism" ], m -> CanCompute( dummy, m ) );
true

#
gap> STOP_TEST( "add_hom_structure_using_external_hom" );
