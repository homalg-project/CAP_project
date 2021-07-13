InstallValue( CAP_INTERNAL_CLOSED_MONOIDAL_CATEGORIES_WITH_COMPATIBLE_HOMOMORPHISM_STRUCTURE_BASIC_OPERATIONS, rec( ) );

##
CAP_INTERNAL_CLOSED_MONOIDAL_CATEGORIES_WITH_COMPATIBLE_HOMOMORPHISM_STRUCTURE_BASIC_OPERATIONS.LiftAlongMorphismLiftingMorphismsFromTensorUnit :=
  [ [ "LiftAlongMorphismLiftingMorphismsFromTensorUnitWithGivenMorphism", 1 ],
    [ "MorphismLiftingMorphismsFromTensorUnit", 1 ] ];

##
InstallMethod( LiftAlongMorphismLiftingMorphismsFromTensorUnit,
               [ IsCapCategoryMorphism ],
               
  function( iota )
    
    return LiftAlongMorphismLiftingMorphismsFromTensorUnitWithGivenMorphism(
                   iota,
                   MorphismLiftingMorphismsFromTensorUnit( Range( iota ) ) );
    
end );

##
CAP_INTERNAL_CLOSED_MONOIDAL_CATEGORIES_WITH_COMPATIBLE_HOMOMORPHISM_STRUCTURE_BASIC_OPERATIONS.LiftAlongMorphismUniquelyLiftingMorphismsFromTensorUnit :=
  [ [ "LiftAlongMorphismUniquelyLiftingMorphismsFromTensorUnitWithGivenMorphism", 1 ],
    [ "MorphismUniquelyLiftingMorphismsFromTensorUnit", 1 ] ];

##
InstallMethod( LiftAlongMorphismUniquelyLiftingMorphismsFromTensorUnit,
               [ IsCapCategoryMorphism ],
               
  function( iota )
    
    return LiftAlongMorphismUniquelyLiftingMorphismsFromTensorUnitWithGivenMorphism(
                   iota,
                   MorphismUniquelyLiftingMorphismsFromTensorUnit( Range( iota ) ) );
    
end );

##
CAP_INTERNAL_ADD_REPLACEMENTS_FOR_METHOD_RECORD( CAP_INTERNAL_CLOSED_MONOIDAL_CATEGORIES_WITH_COMPATIBLE_HOMOMORPHISM_STRUCTURE_BASIC_OPERATIONS );
