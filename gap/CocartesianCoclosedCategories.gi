#
# Toposes: Elementary toposes
#
# Implementations
#

InstallValue( CAP_INTERNAL_COCARTESIAN_COCLOSED_CATEGORIES_BASIC_OPERATIONS, rec( ) );

##
CAP_INTERNAL_COCARTESIAN_COCLOSED_CATEGORIES_BASIC_OPERATIONS.CoexponentialOnMorphisms :=
  [ [ "CoexponentialOnMorphismsWithGivenCoexponentials", 1 ],
    [ "CoexponentialOnObjects", 2 ] ];
##
InstallMethod( CoexponentialOnMorphisms,
               [ IsCapCategoryMorphism, IsCapCategoryMorphism ],

  function( morphism_1, morphism_2 )

    return CoexponentialOnMorphismsWithGivenCoexponentials(
             CoexponentialOnObjects( Source( morphism_1 ), Range( morphism_2 ) ),
             morphism_1, morphism_2,
             CoexponentialOnObjects( Range( morphism_1 ), Source( morphism_2 ) )
           );

end );

##
CAP_INTERNAL_COCARTESIAN_COCLOSED_CATEGORIES_BASIC_OPERATIONS.CocartesianEvaluationMorphism :=
  [ [ "CocartesianEvaluationMorphismWithGivenRange", 1 ],
    [ "Coproduct", 1 ],
    [ "CoexponentialOnObjects", 1 ] ];
##
InstallMethod( CocartesianEvaluationMorphism,
               [ IsCapCategoryObject, IsCapCategoryObject ],

  function( object_1, object_2 )

    return CocartesianEvaluationMorphismWithGivenRange(
             object_1, object_2,
             Coproduct( object_2, CoexponentialOnObjects( object_1, object_2 ) )
           );

end );

##
CAP_INTERNAL_COCARTESIAN_COCLOSED_CATEGORIES_BASIC_OPERATIONS.CocartesianCoevaluationMorphism :=
  [ [ "CocartesianCoevaluationMorphismWithGivenSource", 1 ],
    [ "Coproduct", 1 ],
    [ "CoexponentialOnObjects", 1 ] ];
##
InstallMethod( CocartesianCoevaluationMorphism,
               [ IsCapCategoryObject, IsCapCategoryObject ],

  function( object_1, object_2 )

    return CocartesianCoevaluationMorphismWithGivenSource(
             object_1, object_2,
             CoexponentialOnObjects( Coproduct( object_1, object_2 ), object_1 )
           );

end );

##
CAP_INTERNAL_COCARTESIAN_COCLOSED_CATEGORIES_BASIC_OPERATIONS.CocartesianPreCoComposeMorphism :=
  [ [ "CocartesianPreCoComposeMorphismWithGivenObjects", 1 ],
    [ "Coproduct", 1 ],
    [ "CoexponentialOnObjects", 3 ] ];
##
InstallMethod( CocartesianPreCoComposeMorphism,
               [ IsCapCategoryObject, IsCapCategoryObject, IsCapCategoryObject ],

  function( object_1, object_2, object_3 )

    return CocartesianPreCoComposeMorphismWithGivenObjects(
             CoexponentialOnObjects( object_1, object_3 ),
             object_1, object_2, object_3,
             Coproduct( CoexponentialOnObjects( object_1, object_2 ), CoexponentialOnObjects( object_2, object_3 ) )
           );

end );

##
CAP_INTERNAL_COCARTESIAN_COCLOSED_CATEGORIES_BASIC_OPERATIONS.CocartesianPostCoComposeMorphism :=
  [ [ "CocartesianPostCoComposeMorphismWithGivenObjects", 1 ],
    [ "Coproduct", 1 ],
    [ "CoexponentialOnObjects", 3 ] ];
##
InstallMethod( CocartesianPostCoComposeMorphism,
               [ IsCapCategoryObject, IsCapCategoryObject, IsCapCategoryObject ],

  function( object_1, object_2, object_3 )

    return CocartesianPostCoComposeMorphismWithGivenObjects(
             CoexponentialOnObjects( object_1, object_3 ),
             object_1, object_2, object_3,
             Coproduct( CoexponentialOnObjects( object_2, object_3 ), CoexponentialOnObjects( object_1, object_2 ) )
           );

end );

##
CAP_INTERNAL_COCARTESIAN_COCLOSED_CATEGORIES_BASIC_OPERATIONS.CocartesianDualOnMorphisms :=
  [ [ "CocartesianDualOnMorphismsWithGivenCocartesianDuals", 1 ],
    [ "CocartesianDualOnObjects", 2 ] ];
##
InstallMethod( CocartesianDualOnMorphisms,
               [ IsCapCategoryMorphism ],

  function( morphism )

    return CocartesianDualOnMorphismsWithGivenCocartesianDuals(
             CocartesianDualOnObjects( Range( morphism ) ),
             morphism,
             CocartesianDualOnObjects( Source( morphism ) )
           );

end );

##
CAP_INTERNAL_COCARTESIAN_COCLOSED_CATEGORIES_BASIC_OPERATIONS.CocartesianEvaluationForCocartesianDual :=
  [ [ "CocartesianEvaluationForCocartesianDualWithGivenCoproduct", 1 ],
    [ "Coproduct", 1 ],
    [ "CocartesianDualOnObjects", 1 ],
    [ "InitialObject", 1 ] ];
##
InstallMethod( CocartesianEvaluationForCocartesianDual,
               [ IsCapCategoryObject ],

  function( object )
    local category;

    category := CapCategory( object );

    return CocartesianEvaluationForCocartesianDualWithGivenCoproduct(
             InitialObject( category ),
             object,
             Coproduct( object, CocartesianDualOnObjects( object ) )
           );

end );

##
CAP_INTERNAL_COCARTESIAN_COCLOSED_CATEGORIES_BASIC_OPERATIONS.MorphismFromCocartesianBidual :=
  [ [ "MorphismFromCocartesianBidualWithGivenCocartesianBidual", 1 ],
    [ "CocartesianDualOnObjects", 2 ] ];
##
InstallMethod( MorphismFromCocartesianBidual,
               [ IsCapCategoryObject ],

  function( object )

    return MorphismFromCocartesianBidualWithGivenCocartesianBidual( CocartesianDualOnObjects( CocartesianDualOnObjects( object ) ), object );

end );

##
CAP_INTERNAL_COCARTESIAN_COCLOSED_CATEGORIES_BASIC_OPERATIONS.CoexponentialCoproductCompatibilityMorphism :=
  [ [ "CoexponentialCoproductCompatibilityMorphismWithGivenObjects", 1 ],
    [ "Coproduct", 3 ],
    [ "CoexponentialOnObjects", 3 ] ];
##
InstallMethod( CoexponentialCoproductCompatibilityMorphism,
               [ IsCapCategoryObject, IsCapCategoryObject, IsCapCategoryObject, IsCapCategoryObject ],

  function( object_1_1, object_1_2, object_2_1, object_2_2 )

    return CoexponentialCoproductCompatibilityMorphismWithGivenObjects(
             object_1_1, object_1_2, object_2_1, object_2_2,
             [ CoexponentialOnObjects( Coproduct( object_1_1, object_1_2 ), Coproduct( object_2_1, object_2_2 ) ),
               Coproduct( CoexponentialOnObjects( object_1_1, object_2_1 ), CoexponentialOnObjects( object_1_2, object_2_2 ) ) ]
           );

end );

##
CAP_INTERNAL_COCARTESIAN_COCLOSED_CATEGORIES_BASIC_OPERATIONS.CocartesianDualityCoproductCompatibilityMorphism :=
  [ [ "CocartesianDualityCoproductCompatibilityMorphismWithGivenObjects", 1 ],
    [ "CocartesianDualOnObjects", 3 ],
    [ "Coproduct", 2 ] ];
##
InstallMethod( CocartesianDualityCoproductCompatibilityMorphism,
               [ IsCapCategoryObject, IsCapCategoryObject ],

  function( object_1, object_2 )

    return CocartesianDualityCoproductCompatibilityMorphismWithGivenObjects(
             CocartesianDualOnObjects( Coproduct( object_1, object_2 ) ),
             object_1, object_2,
             Coproduct( CocartesianDualOnObjects( object_1 ), CocartesianDualOnObjects( object_2 ) )
           );

end );

##
CAP_INTERNAL_COCARTESIAN_COCLOSED_CATEGORIES_BASIC_OPERATIONS.MorphismFromCoexponentialToCoproduct :=
  [ [ "MorphismFromCoexponentialToCoproductWithGivenObjects", 1 ],
    [ "CocartesianDualOnObjects", 1 ],
    [ "Coproduct", 1 ],
    [ "CoexponentialOnObjects", 1 ] ];
##
InstallMethod( MorphismFromCoexponentialToCoproduct,
               [ IsCapCategoryObject, IsCapCategoryObject ],

  function( object_1, object_2 )

    return MorphismFromCoexponentialToCoproductWithGivenObjects(
             CoexponentialOnObjects( object_1, object_2 ),
             object_1, object_2,
             Coproduct( object_1, CocartesianDualOnObjects( object_2 ) )
           );

end );

##
CAP_INTERNAL_COCARTESIAN_COCLOSED_CATEGORIES_BASIC_OPERATIONS.IsomorphismFromCoexponentialToObject :=
  [ [ "IsomorphismFromCoexponentialToObjectWithGivenCoexponential", 1 ],
    [ "InitialObject", 1 ],
    [ "CoexponentialOnObjects", 1 ] ];
##
InstallMethod( IsomorphismFromCoexponentialToObject,
               [ IsCapCategoryObject ],

  function( object )
    local category;

    category := CapCategory( object );

    return IsomorphismFromCoexponentialToObjectWithGivenCoexponential( object, CoexponentialOnObjects( object, InitialObject( category ) ) );

end );

##
InstallMethod( IsomorphismFromCoexponentialToObject,
               [ IsCapCategoryObject and IsCellOfSkeletalCategory ],

  function( object )

    return IsomorphismFromCoexponentialToObjectWithGivenCoexponential( object, object );

end );

##
CAP_INTERNAL_COCARTESIAN_COCLOSED_CATEGORIES_BASIC_OPERATIONS.IsomorphismFromObjectToCoexponential :=
  [ [ "IsomorphismFromObjectToCoexponentialWithGivenCoexponential", 1 ],
    [ "InitialObject", 1 ],
    [ "CoexponentialOnObjects", 1 ] ];
##
InstallMethod( IsomorphismFromObjectToCoexponential,
               [ IsCapCategoryObject ],

  function( object )
    local category;

    category := CapCategory( object );

    return IsomorphismFromObjectToCoexponentialWithGivenCoexponential( object, CoexponentialOnObjects( object, InitialObject( category ) ) );

end );

##
InstallMethod( IsomorphismFromObjectToCoexponential,
               [ IsCapCategoryObject and IsCellOfSkeletalCategory ],

  function( object )

    return IsomorphismFromObjectToCoexponentialWithGivenCoexponential( object, object );

end );

CAP_INTERNAL_ADD_REPLACEMENTS_FOR_METHOD_RECORD( CAP_INTERNAL_COCARTESIAN_COCLOSED_CATEGORIES_BASIC_OPERATIONS );
