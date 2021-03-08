LoadPackage( "LinearAlgebraForCAP" );

##
DeclareCategory( "IsFieldAsCategoryObject",
                 IsCapCategoryObject );

DeclareCategory( "IsFieldAsCategoryMorphism",
                 IsCapCategoryMorphism );

DeclareGlobalFunction( "INSTALL_FUNCTIONS_FOR_FIELD_AS_CATEGORY" );

DeclareCategory( "IsFieldAsCategory",
                 IsCapCategory and IsAbCategory );

## Constructors
DeclareAttribute( "FieldAsCategory",
                  IsFieldForHomalg );

DeclareAttribute( "FieldAsCategoryUniqueObject",
                  IsFieldAsCategory );

DeclareOperation( "FieldAsCategoryMorphism",
                  [ IsRingElement, IsFieldAsCategory ] );

## Attributes
DeclareAttribute( "UnderlyingFieldElement",
                  IsFieldAsCategoryMorphism );

DeclareAttribute( "UnderlyingFieldForHomalg",
                  IsFieldAsCategory );

## Constructors

##
InstallMethod( FieldAsCategory,
               [ IsFieldForHomalg ],
               
  function( field )
    local category;
    
    category := CreateCapCategory( Concatenation( "Field as category( ", RingName( field )," )"  ) : overhead := false );
    
    SetFilterObj( category, IsFieldAsCategory );
    
    SetUnderlyingFieldForHomalg( category, field );
    
    SetRangeCategoryOfHomomorphismStructure( category, MatrixCategory( field ) );
    
    AddObjectRepresentation( category, IsFieldAsCategoryObject );
    
    AddMorphismRepresentation( category, IsFieldAsCategoryMorphism and HasUnderlyingFieldElement );

    INSTALL_FUNCTIONS_FOR_FIELD_AS_CATEGORY( category );
    
    Finalize( category );
    
    return category;
    
end );

##
InstallMethod( FieldAsCategoryUniqueObject,
               [ IsFieldAsCategory ],
               
  function( category )
    local unique_object;
    
    unique_object := ObjectifyObjectForCAPWithAttributes( rec( ),
                                                          category
    );
    
    Add( category, unique_object );
    
    return unique_object;
    
end );

##
InstallMethod( FieldAsCategoryMorphism,
               [ IsRingElement, IsFieldAsCategory ],
               
  function( element, category )
    local morphism, unique_object;
    
    unique_object := FieldAsCategoryUniqueObject( category );
    
    morphism := ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec( ), category,
                                           unique_object,
                                           unique_object,
                                           UnderlyingFieldElement, element
    );
    
    Add( category, morphism );
    
    return morphism;
    
end );

##
InstallMethod( ViewObj,
               [ IsFieldAsCategoryMorphism ],

  function( alpha )

    Print( String( UnderlyingFieldElement( alpha ) ) );

end );

## Basic operations

InstallGlobalFunction( INSTALL_FUNCTIONS_FOR_FIELD_AS_CATEGORY,
  
  function( category )
    local field, vec, tunit;
    
    field := UnderlyingFieldForHomalg( category );
    
    ##
    AddIsEqualForCacheForObjects( category,
      IsIdenticalObj );
    
    ##
    AddIsEqualForCacheForMorphisms( category,
      IsIdenticalObj );
    
    ##
    AddIsEqualForObjects( category,
      function( a, b )
      
        return true;
      
    end );
    
    ##
    AddIsEqualForMorphisms( category,
      function( alpha, beta )
        
        return UnderlyingFieldElement( alpha ) = UnderlyingFieldElement( beta );
        
    end );
    
    ##
    AddPreCompose( category,
      function( alpha, beta )
            
        return FieldAsCategoryMorphism( 
            UnderlyingFieldElement( alpha ) * UnderlyingFieldElement( beta ),
            category
        );
            
    end );
    
    ##
    AddIdentityMorphism( category,
      function( a )
        
        return FieldAsCategoryMorphism(
            One( field ),
            category
        );
        
    end );
    
    ##
    AddAdditionForMorphisms( category,
      function( alpha, beta )
            
        return FieldAsCategoryMorphism( 
            UnderlyingFieldElement( alpha ) + UnderlyingFieldElement( beta ),
            category
        );
            
    end );
    
    vec := RangeCategoryOfHomomorphismStructure( category );
    
    tunit := TensorUnit( vec );
    
    ## Homomorphism structure
    AddHomomorphismStructureOnObjects( category,
      function( a, b )
        
        return tunit;
        
    end );
    
    AddHomomorphismStructureOnMorphismsWithGivenObjects( category,
      function( source, alpha, beta, range )
        
        return VectorSpaceMorphism( 
            tunit,
            HomalgMatrix( [ [ UnderlyingFieldElement( alpha ) * UnderlyingFieldElement( beta ) ] ], 1, 1, field ),
            tunit
        );
        
    end );
    
    AddDistinguishedObjectOfHomomorphismStructure( category,
      function()
        
        return tunit;
        
    end );
    
    AddInterpretMorphismAsMorphismFromDistinguishedObjectToHomomorphismStructure( category,
      function( alpha )
        
        return VectorSpaceMorphism(
            tunit,
            HomalgMatrix( [ [ UnderlyingFieldElement( alpha ) ] ], 1, 1, field ),
            tunit
        );
        
    end );
    
    AddInterpretMorphismFromDistinguishedObjectToHomomorphismStructureAsMorphism( category,
      function( a, b, mor )
        
        return FieldAsCategoryMorphism(
            EntriesOfHomalgMatrix( UnderlyingMatrix( mor ) )[1],
            category
        );
        
    end );
    
end );
