InstallValue( CAP_INTERNAL_RIGID_SYMMETRIC_CLOSED_MONOIDAL_CATEGORIES_BASIC_OPERATIONS, rec( ) );

##
CAP_INTERNAL_RIGID_SYMMETRIC_CLOSED_MONOIDAL_CATEGORIES_BASIC_OPERATIONS.CoevaluationForDual := 
  [ [ "CoevaluationForDualWithGivenTensorProduct", 1 ],
    [ "TensorProductOnObjects", 1 ],
    [ "DualOnObjects", 1 ],
    [ "TensorUnit", 1 ] ];
##
InstallMethod( CoevaluationForDual,
               [ IsCapCategoryObject ],
               
  function( object )
    local category;
    
    category := CapCategory( object );
    
    return CoevaluationForDualWithGivenTensorProduct( 
             TensorUnit( category ),
             object,
             TensorProductOnObjects( object, DualOnObjects( object ) )
           );
    
end );

##
CAP_INTERNAL_RIGID_SYMMETRIC_CLOSED_MONOIDAL_CATEGORIES_BASIC_OPERATIONS.MorphismFromBidual := 
  [ [ "MorphismFromBidualWithGivenBidual", 1 ],
    [ "DualOnObjects", 2 ] ];
##
InstallMethod( MorphismFromBidual,
               [ IsCapCategoryObject ],
               
  function( object )
    
    return MorphismFromBidualWithGivenBidual( object, DualOnObjects( DualOnObjects( object ) ) );
    
end );

##
CAP_INTERNAL_RIGID_SYMMETRIC_CLOSED_MONOIDAL_CATEGORIES_BASIC_OPERATIONS.TensorProductInternalHomCompatibilityMorphismInverse := 
  [ [ "TensorProductInternalHomCompatibilityMorphismInverseWithGivenObjects", 1 ],
    [ "TensorProductOnObjects", 3 ],
    [ "InternalHomOnObjects", 3 ] ];
##
InstallMethod( TensorProductInternalHomCompatibilityMorphismInverse,
               [ IsCapCategoryObject, IsCapCategoryObject, IsCapCategoryObject, IsCapCategoryObject ],
               
  function( object_1_1, object_1_2, object_2_1, object_2_2 )
    
    return TensorProductInternalHomCompatibilityMorphismInverseWithGivenObjects(
             object_1_1, object_1_2, object_2_1, object_2_2,
             [ TensorProductOnObjects( InternalHomOnObjects( object_1_1, object_1_2 ), InternalHomOnObjects( object_2_1, object_2_2 ) ),
               InternalHomOnObjects( TensorProductOnObjects( object_1_1, object_2_1 ), TensorProductOnObjects( object_1_2, object_2_2 ) ) ]
           );
    
end );

##
CAP_INTERNAL_RIGID_SYMMETRIC_CLOSED_MONOIDAL_CATEGORIES_BASIC_OPERATIONS.MorphismFromInternalHomToTensorProduct := 
  [ [ "MorphismFromInternalHomToTensorProductWithGivenObjects", 1 ],
    [ "DualOnObjects", 1 ],
    [ "TensorProductOnObjects", 1 ],
    [ "InternalHomOnObjects", 1 ] ];
##
InstallMethod( MorphismFromInternalHomToTensorProduct,
               [ IsCapCategoryObject, IsCapCategoryObject ],
               
  function( object_1, object_2 )
    
    return MorphismFromInternalHomToTensorProductWithGivenObjects(
             InternalHomOnObjects( object_1, object_2 ),
             object_1, object_2,
             TensorProductOnObjects( DualOnObjects( object_1 ), object_2 )
           );
    
end );

CAP_INTERNAL_ADD_REPLACEMENTS_FOR_METHOD_RECORD( CAP_INTERNAL_RIGID_SYMMETRIC_CLOSED_MONOIDAL_CATEGORIES_BASIC_OPERATIONS );
