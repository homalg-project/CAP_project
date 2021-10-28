InstallValue( CAP_INTERNAL_CLOSED_MONOIDAL_CATEGORIES_WITH_COMPATIBLE_HOMOMORPHISM_STRUCTURE_BASIC_OPERATIONS, rec( ) );

##
CAP_INTERNAL_CLOSED_MONOIDAL_CATEGORIES_WITH_COMPATIBLE_HOMOMORPHISM_STRUCTURE_BASIC_OPERATIONS.LiftAlongMorphismLiftingMorphismsFromTensorUnit :=
  [ [ "LiftAlongMorphismLiftingMorphismsFromTensorUnitWithGivenMorphism", 1 ],
    [ "MorphismLiftingMorphismsFromTensorUnit", 1 ] ];

##
InstallMethod( LiftAlongMorphismLiftingMorphismsFromTensorUnit,
               [ IsCapCategoryMorphism ],
               
  function( iota )
    
    return LiftAlongMorphismLiftingMorphismsFromTensorUnit( CapCategory( iota ), iota );
    
end );

##
InstallOtherMethod( LiftAlongMorphismLiftingMorphismsFromTensorUnit,
               [ IsCapCategory, IsCapCategoryMorphism ],
               
  function( cat, iota )
    
    return LiftAlongMorphismLiftingMorphismsFromTensorUnitWithGivenMorphism(
                   cat,
                   iota,
                   MorphismLiftingMorphismsFromTensorUnit( cat, Range( iota ) ) );
    
end );

##
CAP_INTERNAL_CLOSED_MONOIDAL_CATEGORIES_WITH_COMPATIBLE_HOMOMORPHISM_STRUCTURE_BASIC_OPERATIONS.LiftAlongMorphismUniquelyLiftingMorphismsFromTensorUnit :=
  [ [ "LiftAlongMorphismUniquelyLiftingMorphismsFromTensorUnitWithGivenMorphism", 1 ],
    [ "MorphismUniquelyLiftingMorphismsFromTensorUnit", 1 ] ];

##
InstallMethod( LiftAlongMorphismUniquelyLiftingMorphismsFromTensorUnit,
               [ IsCapCategoryMorphism ],
               
  function( iota )
    
    return LiftAlongMorphismUniquelyLiftingMorphismsFromTensorUnit( CapCategory( iota ), iota );
    
end );

##
InstallOtherMethod( LiftAlongMorphismUniquelyLiftingMorphismsFromTensorUnit,
               [ IsCapCategory, IsCapCategoryMorphism ],
               
  function( cat, iota )
    
    return LiftAlongMorphismUniquelyLiftingMorphismsFromTensorUnitWithGivenMorphism(
                   cat,
                   iota,
                   MorphismUniquelyLiftingMorphismsFromTensorUnit( cat, Range( iota ) ) );
    
end );

##
CAP_INTERNAL_ADD_REPLACEMENTS_FOR_METHOD_RECORD( CAP_INTERNAL_CLOSED_MONOIDAL_CATEGORIES_WITH_COMPATIBLE_HOMOMORPHISM_STRUCTURE_BASIC_OPERATIONS );
