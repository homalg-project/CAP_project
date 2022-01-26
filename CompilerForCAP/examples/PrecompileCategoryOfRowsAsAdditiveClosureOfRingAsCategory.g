#! @Chapter Examples and tests

#! @Section Tests

#! @Example

LoadPackage( "FreydCategoriesForCAP", false );
#! true
ReadPackage( "FreydCategoriesForCAP",
    "gap/CategoryOfRowsAsAdditiveClosureOfRingAsCategory_CompilerLogic.gi");
#! true

# We only compile one very special case:
# The homomorphism structure for homalg exterior rings over fields.

QQ := HomalgFieldOfRationalsInSingular( );;
QQxy := QQ * "x,y";;
EEE := KoszulDualRing( QQxy );;

category_constructor :=
    homalg_ring -> CategoryOfRowsAsAdditiveClosureOfRingAsCategory(
        homalg_ring
    );;

given_arguments := [ EEE ];;
package_name := "FreydCategoriesForCAP";;
compiled_category_name := Concatenation(
    "CategoryOfRowsAsAdditiveClosureOfRingAsCategoryOf",
    "HomalgExteriorRingOverFieldPrecompiled"
);;
operations := [
    "DistinguishedObjectOfHomomorphismStructure",
    "HomomorphismStructureOnObjects",
    "HomomorphismStructureOnMorphismsWithGivenObjects",
    Concatenation(
        "InterpretMorphismAsMorphismFromDistinguishedObject",
        "ToHomomorphismStructureWithGivenObjects"
    ),
    Concatenation(
        "InterpretMorphismFromDistinguishedObject",
        "ToHomomorphismStructureAsMorphism"
    ),
];;

CapJitPrecompileCategoryAndCompareResult(
    category_constructor,
    given_arguments,
    package_name,
    compiled_category_name :
    operations := operations
);

# check that the compiled code is loaded automatically
cat := CategoryOfRows( EEE );;
CanCompute( cat, "HomomorphismStructureOnMorphismsWithGivenObjects" );
#! true

#! @EndExample
