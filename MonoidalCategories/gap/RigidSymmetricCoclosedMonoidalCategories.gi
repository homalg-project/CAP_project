InstallValue( CAP_INTERNAL_RIGID_SYMMETRIC_COCLOSED_MONOIDAL_CATEGORIES_BASIC_OPERATIONS, rec( ) );

##
CAP_INTERNAL_RIGID_SYMMETRIC_COCLOSED_MONOIDAL_CATEGORIES_BASIC_OPERATIONS.DualCoEvaluationForCoDual := 
  [ [ "DualCoEvaluationForCoDualWithGivenTensorProduct", 1 ],
    [ "TensorProductOnObjects", 1 ],
    [ "CoDualOnObjects", 1 ],
    [ "TensorUnit", 1 ] ];
##
InstallMethod( DualCoEvaluationForCoDual,
               [ IsCapCategoryObject ],
               
  function( object )
    local category;
    
    category := CapCategory( object );
    
    return DualCoEvaluationForCoDualWithGivenTensorProduct( 
             TensorProductOnObjects( CoDualOnObjects( object ), object ),
             object,
             TensorUnit( category )
           );
    
end );

##
CAP_INTERNAL_RIGID_SYMMETRIC_COCLOSED_MONOIDAL_CATEGORIES_BASIC_OPERATIONS.MorphismToCoBidual := 
  [ [ "MorphismToCoBidualWithGivenCoBidual", 1 ],
    [ "CoDualOnObjects", 2 ] ];
##
InstallMethod( MorphismToCoBidual,
               [ IsCapCategoryObject ],
               
  function( object )
    
    return MorphismToCoBidualWithGivenCoBidual( object, CoDualOnObjects( CoDualOnObjects( object ) ) );
    
end );

##
CAP_INTERNAL_RIGID_SYMMETRIC_COCLOSED_MONOIDAL_CATEGORIES_BASIC_OPERATIONS.InternalCoHomTensorProductCompatibilityMorphismInverse := 
  [ [ "InternalCoHomTensorProductCompatibilityMorphismInverseWithGivenObjects", 1 ],
    [ "TensorProductOnObjects", 3 ],
    [ "InternalCoHomOnObjects", 3 ] ];
##
InstallMethod( InternalCoHomTensorProductCompatibilityMorphismInverse,
               [ IsCapCategoryObject, IsCapCategoryObject, IsCapCategoryObject, IsCapCategoryObject ],
               
  function( object_1_1, object_1_2, object_2_1, object_2_2 )
    
    return InternalCoHomTensorProductCompatibilityMorphismInverseWithGivenObjects(
             object_1_1, object_1_2, object_2_1, object_2_2,
             [ InternalCoHomOnObjects( TensorProductOnObjects( object_1_1, object_1_2 ), TensorProductOnObjects( object_2_1, object_2_2 ) ),
               TensorProductOnObjects( InternalCoHomOnObjects( object_1_1, object_2_1 ), InternalCoHomOnObjects( object_1_2, object_2_2 ) ) ]
           );

end );

##
CAP_INTERNAL_RIGID_SYMMETRIC_COCLOSED_MONOIDAL_CATEGORIES_BASIC_OPERATIONS.MorphismFromTensorProductToInternalCoHom := 
  [ [ "MorphismFromTensorProductToInternalCoHomWithGivenObjects", 1 ],
    [ "CoDualOnObjects", 1 ],
    [ "TensorProductOnObjects", 1 ],
    [ "InternalCoHomOnObjects", 1 ] ];
##
InstallMethod( MorphismFromTensorProductToInternalCoHom,
               [ IsCapCategoryObject, IsCapCategoryObject ],
               
  function( object_1, object_2 )
    
    return MorphismFromTensorProductToInternalCoHomWithGivenObjects(
             TensorProductOnObjects( object_1, DualOnObjects( object_2 ) ),
             object_1, object_2,
             InternalCoHomOnObjects( object_1, object_2 )
           );
    
end );

CAP_INTERNAL_ADD_REPLACEMENTS_FOR_METHOD_RECORD( CAP_INTERNAL_RIGID_SYMMETRIC_COCLOSED_MONOIDAL_CATEGORIES_BASIC_OPERATIONS );
