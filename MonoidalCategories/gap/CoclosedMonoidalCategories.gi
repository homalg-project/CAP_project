InstallValue( CAP_INTERNAL_COCLOSED_MONOIDAL_CATEGORIES_BASIC_OPERATIONS, rec( ) );

##
CAP_INTERNAL_COCLOSED_MONOIDAL_CATEGORIES_BASIC_OPERATIONS.InternalCoHomOnMorphisms :=
  [ [ "InternalCoHomOnMorphismsWithGivenInternalCoHoms", 1 ],
    [ "InternalCoHomOnObjects", 2 ] ];
##
InstallMethod( InternalCoHomOnMorphisms,
               [ IsCapCategoryMorphism, IsCapCategoryMorphism ],

  function( morphism_1, morphism_2 )

    return InternalCoHomOnMorphismsWithGivenInternalCoHoms(
             InternalCoHomOnObjects( Source( morphism_1 ), Range( morphism_2 ) ),
             morphism_1, morphism_2,
             InternalCoHomOnObjects( Range( morphism_1 ), Source( morphism_2 ) )
           );

end );

##
CAP_INTERNAL_COCLOSED_MONOIDAL_CATEGORIES_BASIC_OPERATIONS.CoclosedEvaluationMorphism :=
  [ [ "CoclosedEvaluationMorphismWithGivenRange", 1 ],
    [ "TensorProductOnObjects", 1 ],
    [ "InternalCoHomOnObjects", 1 ] ];
##
InstallMethod( CoclosedEvaluationMorphism,
               [ IsCapCategoryObject, IsCapCategoryObject ],

  function( object_1, object_2 )

    return CoclosedEvaluationMorphismWithGivenRange(
             object_1, object_2,
             TensorProductOnObjects( object_2, InternalCoHomOnObjects( object_1, object_2 ) )
           );

end );

##
CAP_INTERNAL_COCLOSED_MONOIDAL_CATEGORIES_BASIC_OPERATIONS.CoclosedCoevaluationMorphism :=
  [ [ "CoclosedCoevaluationMorphismWithGivenSource", 1 ],
    [ "TensorProductOnObjects", 1 ],
    [ "InternalCoHomOnObjects", 1 ] ];
##
InstallMethod( CoclosedCoevaluationMorphism,
               [ IsCapCategoryObject, IsCapCategoryObject ],

  function( object_1, object_2 )

    return CoclosedCoevaluationMorphismWithGivenSource(
             object_1, object_2,
             InternalCoHomOnObjects( TensorProductOnObjects( object_1, object_2 ), object_1 )
           );

end );

##
CAP_INTERNAL_COCLOSED_MONOIDAL_CATEGORIES_BASIC_OPERATIONS.MonoidalPreCoComposeMorphism :=
  [ [ "MonoidalPreCoComposeMorphismWithGivenObjects", 1 ],
    [ "TensorProductOnObjects", 1 ],
    [ "InternalCoHomOnObjects", 3 ] ];
##
InstallMethod( MonoidalPreCoComposeMorphism,
               [ IsCapCategoryObject, IsCapCategoryObject, IsCapCategoryObject ],

  function( object_1, object_2, object_3 )

    return MonoidalPreCoComposeMorphismWithGivenObjects(
             InternalCoHomOnObjects( object_1, object_3 ),
             object_1, object_2, object_3,
             TensorProductOnObjects( InternalCoHomOnObjects( object_1, object_2 ), InternalCoHomOnObjects( object_2, object_3 ) )
           );

end );

##
CAP_INTERNAL_COCLOSED_MONOIDAL_CATEGORIES_BASIC_OPERATIONS.MonoidalPostCoComposeMorphism :=
  [ [ "MonoidalPostCoComposeMorphismWithGivenObjects", 1 ],
    [ "TensorProductOnObjects", 1 ],
    [ "InternalCoHomOnObjects", 3 ] ];
##
InstallMethod( MonoidalPostCoComposeMorphism,
               [ IsCapCategoryObject, IsCapCategoryObject, IsCapCategoryObject ],

  function( object_1, object_2, object_3 )

    return MonoidalPostCoComposeMorphismWithGivenObjects(
             InternalCoHomOnObjects( object_1, object_3 ),
             object_1, object_2, object_3,
             TensorProductOnObjects( InternalCoHomOnObjects( object_2, object_3 ), InternalCoHomOnObjects( object_1, object_2 ) )
           );

end );

##
CAP_INTERNAL_COCLOSED_MONOIDAL_CATEGORIES_BASIC_OPERATIONS.CoDualOnMorphisms :=
  [ [ "CoDualOnMorphismsWithGivenCoDuals", 1 ],
    [ "CoDualOnObjects", 2 ] ];
##
InstallMethod( CoDualOnMorphisms,
               [ IsCapCategoryMorphism ],

  function( morphism )

    return CoDualOnMorphismsWithGivenCoDuals(
             CoDualOnObjects( Range( morphism ) ),
             morphism,
             CoDualOnObjects( Source( morphism ) )
           );

end );

##
CAP_INTERNAL_COCLOSED_MONOIDAL_CATEGORIES_BASIC_OPERATIONS.CoclosedEvaluationForCoDual :=
  [ [ "CoclosedEvaluationForCoDualWithGivenTensorProduct", 1 ],
    [ "TensorProductOnObjects", 1 ],
    [ "CoDualOnObjects", 1 ],
    [ "TensorUnit", 1 ] ];
##
InstallMethod( CoclosedEvaluationForCoDual,
               [ IsCapCategoryObject ],

  function( object )
    local category;

    category := CapCategory( object );

    return CoclosedEvaluationForCoDualWithGivenTensorProduct(
             TensorUnit( category ),
             object,
             TensorProductOnObjects( object, CoDualOnObjects( object ) )
           );

end );

##
CAP_INTERNAL_COCLOSED_MONOIDAL_CATEGORIES_BASIC_OPERATIONS.MorphismFromCoBidual :=
  [ [ "MorphismFromCoBidualWithGivenCoBidual", 1 ],
    [ "CoDualOnObjects", 2 ] ];
##
InstallMethod( MorphismFromCoBidual,
               [ IsCapCategoryObject ],

  function( object )

    return MorphismFromCoBidualWithGivenCoBidual( CoDualOnObjects( CoDualOnObjects( object ) ), object );

end );

##
CAP_INTERNAL_COCLOSED_MONOIDAL_CATEGORIES_BASIC_OPERATIONS.InternalCoHomTensorProductCompatibilityMorphism :=
  [ [ "InternalCoHomTensorProductCompatibilityMorphismWithGivenObjects", 1 ],
    [ "TensorProductOnObjects", 3 ],
    [ "InternalCoHomOnObjects", 3 ] ];
##
InstallMethod( InternalCoHomTensorProductCompatibilityMorphism,
               [ IsCapCategoryObject, IsCapCategoryObject, IsCapCategoryObject, IsCapCategoryObject ],

  function( object_1_1, object_1_2, object_2_1, object_2_2 )

    return InternalCoHomTensorProductCompatibilityMorphismWithGivenObjects(
             object_1_1, object_1_2, object_2_1, object_2_2,
             [ InternalCoHomOnObjects( TensorProductOnObjects( object_1_1, object_1_2 ), TensorProductOnObjects( object_2_1, object_2_2 ) ),
               TensorProductOnObjects( InternalCoHomOnObjects( object_1_1, object_2_1 ), InternalCoHomOnObjects( object_1_2, object_2_2 ) ) ]
           );

end );

##
CAP_INTERNAL_COCLOSED_MONOIDAL_CATEGORIES_BASIC_OPERATIONS.CoDualityTensorProductCompatibilityMorphism :=
  [ [ "CoDualityTensorProductCompatibilityMorphismWithGivenObjects", 1 ],
    [ "CoDualOnObjects", 3 ],
    [ "TensorProductOnObjects", 2 ] ];
##
InstallMethod( CoDualityTensorProductCompatibilityMorphism,
               [ IsCapCategoryObject, IsCapCategoryObject ],

  function( object_1, object_2 )

    return CoDualityTensorProductCompatibilityMorphismWithGivenObjects(
             CoDualOnObjects( TensorProductOnObjects( object_1, object_2 ) ),
             object_1, object_2,
             TensorProductOnObjects( CoDualOnObjects( object_1 ), CoDualOnObjects( object_2 ) )
           );

end );

##
CAP_INTERNAL_COCLOSED_MONOIDAL_CATEGORIES_BASIC_OPERATIONS.MorphismFromInternalCoHomToTensorProduct :=
  [ [ "MorphismFromInternalCoHomToTensorProductWithGivenObjects", 1 ],
    [ "CoDualOnObjects", 1 ],
    [ "TensorProductOnObjects", 1 ],
    [ "InternalCoHomOnObjects", 1 ] ];
##
InstallMethod( MorphismFromInternalCoHomToTensorProduct,
               [ IsCapCategoryObject, IsCapCategoryObject ],

  function( object_1, object_2 )

    return MorphismFromInternalCoHomToTensorProductWithGivenObjects(
             InternalCoHomOnObjects( object_1, object_2 ),
             object_1, object_2,
             TensorProductOnObjects( object_1, CoDualOnObjects( object_2 ) )
           );

end );

##
CAP_INTERNAL_COCLOSED_MONOIDAL_CATEGORIES_BASIC_OPERATIONS.IsomorphismFromInternalCoHomToObject :=
  [ [ "IsomorphismFromInternalCoHomToObjectWithGivenInternalCoHom", 1 ],
    [ "TensorUnit", 1 ],
    [ "InternalCoHomOnObjects", 1 ] ];
##
InstallMethod( IsomorphismFromInternalCoHomToObject,
               [ IsCapCategoryObject ],

  function( object )
    local category;

    category := CapCategory( object );

    return IsomorphismFromInternalCoHomToObjectWithGivenInternalCoHom( object, InternalCoHomOnObjects( object, TensorUnit( category ) ) );

end );

##
InstallMethod( IsomorphismFromInternalCoHomToObject,
               [ IsCapCategoryObject and IsCellOfSkeletalCategory ],

  function( object )

    return IsomorphismFromInternalCoHomToObjectWithGivenInternalCoHom( object, object );

end );

##
CAP_INTERNAL_COCLOSED_MONOIDAL_CATEGORIES_BASIC_OPERATIONS.IsomorphismFromObjectToInternalCoHom :=
  [ [ "IsomorphismFromObjectToInternalCoHomWithGivenInternalCoHom", 1 ],
    [ "TensorUnit", 1 ],
    [ "InternalCoHomOnObjects", 1 ] ];
##
InstallMethod( IsomorphismFromObjectToInternalCoHom,
               [ IsCapCategoryObject ],

  function( object )
    local category;

    category := CapCategory( object );

    return IsomorphismFromObjectToInternalCoHomWithGivenInternalCoHom( object, InternalCoHomOnObjects( object, TensorUnit( category ) ) );

end );

##
InstallMethod( IsomorphismFromObjectToInternalCoHom,
               [ IsCapCategoryObject and IsCellOfSkeletalCategory ],

  function( object )

    return IsomorphismFromObjectToInternalCoHomWithGivenInternalCoHom( object, object );

end );

CAP_INTERNAL_ADD_REPLACEMENTS_FOR_METHOD_RECORD( CAP_INTERNAL_COCLOSED_MONOIDAL_CATEGORIES_BASIC_OPERATIONS );

####################################
# Convenience Methods
####################################

##
InstallMethod( InternalCoHom,
        [ IsCapCategoryObject, IsCapCategoryObject ],
        
  InternalCoHomOnObjects );

##
InstallMethod( InternalCoHom,
        [ IsCapCategoryMorphism, IsCapCategoryMorphism ],
        
  InternalCoHomOnMorphisms );

##
InstallMethod( InternalCoHom,
        [ IsCapCategoryObject, IsCapCategoryMorphism ],
        
  function( a, beta )
    
    return InternalCoHomOnMorphisms( IdentityMorphism( a ), beta );
    
end );

##
InstallMethod( InternalCoHom,
        [ IsCapCategoryMorphism, IsCapCategoryObject ],
        
  function( alpha, b )
    
    return InternalCoHomOnMorphisms( alpha, IdentityMorphism( b ) );
    
end );
