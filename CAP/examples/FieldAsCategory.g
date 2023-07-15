LoadPackage( "LinearAlgebraForCAP" );

##
DeclareCategory( "IsFieldAsCategory",
                 IsCapCategory and IsAbCategory );

DeclareCategory( "IsObjectInFieldAsCategory",
                 IsCapCategoryObject );

DeclareCategory( "IsMorphismInFieldAsCategory",
                 IsCapCategoryMorphism );

DeclareGlobalFunction( "INSTALL_FUNCTIONS_FOR_FIELD_AS_CATEGORY" );

## Constructors
DeclareAttribute( "FieldAsCategory",
                  IsFieldForHomalg );

DeclareAttribute( "FieldAsCategoryUniqueObject",
                  IsFieldAsCategory );

DeclareOperation( "FieldAsCategoryMorphism",
                  [ IsFieldAsCategory, IsRingElement ] );

## Attributes
DeclareAttribute( "UnderlyingFieldElement",
                  IsMorphismInFieldAsCategory );

DeclareAttribute( "UnderlyingFieldForHomalg",
                  IsFieldAsCategory );

## Constructors

##
InstallMethod( FieldAsCategory,
               [ IsFieldForHomalg ],
               
  function( field )
    local category;
    
    category := CreateCapCategoryWithDataTypes(
                        Concatenation( "Field as category( ", RingName( field )," )"  ),
                        IsFieldAsCategory,
                        IsObjectInFieldAsCategory,
                        IsMorphismInFieldAsCategory and HasUnderlyingFieldElement,
                        IsCapCategoryTwoCell,
                        fail,
                        IsRingElement,
                        fail
                        : overhead := false );
    
    category!.category_as_first_argument := true;
    
    SetUnderlyingFieldForHomalg( category, field );
    
    SetRangeCategoryOfHomomorphismStructure( category, MatrixCategory( field ) );
    SetIsEquippedWithHomomorphismStructure( category, true );
    
    INSTALL_FUNCTIONS_FOR_FIELD_AS_CATEGORY( category );
    
    Finalize( category );
    
    return category;
    
end );

##
InstallMethod( FieldAsCategoryUniqueObject,
               [ IsFieldAsCategory ],
               
  function( category )
    local unique_object;
    
    unique_object := CreateCapCategoryObjectWithAttributes( category );
    
    return unique_object;
    
end );

##
InstallMethod( FieldAsCategoryMorphism,
               [ IsFieldAsCategory, IsRingElement ],
               
  function( category, element )
    local morphism, unique_object;
    
    unique_object := FieldAsCategoryUniqueObject( category );
    
    morphism := CreateCapCategoryMorphismWithAttributes( category,
                                                         unique_object,
                                                         unique_object,
                                                         UnderlyingFieldElement, element );
    
    return morphism;
    
end );

##
InstallMethod( ViewString,
               [ IsMorphismInFieldAsCategory ],

  function( alpha )

    return String( UnderlyingFieldElement( alpha ) );

end );

## Basic operations

InstallGlobalFunction( INSTALL_FUNCTIONS_FOR_FIELD_AS_CATEGORY,
  
  function( category )
    local field, vec, tunit;
    
    field := UnderlyingFieldForHomalg( category );
    
    ##
    AddIsEqualForObjects( category,
      function( cat, a, b )
      
        return true;
      
    end );
    
    ##
    AddIsEqualForMorphisms( category,
      function( cat, alpha, beta )
        
        return UnderlyingFieldElement( alpha ) = UnderlyingFieldElement( beta );
        
    end );
    
    ##
    AddPreCompose( category,
      function( cat, alpha, beta )
            
        return FieldAsCategoryMorphism(
                 cat,
                 UnderlyingFieldElement( alpha ) * UnderlyingFieldElement( beta ) );
            
    end );
    
    ##
    AddIdentityMorphism( category,
      function( cat, a )
        
        return FieldAsCategoryMorphism(
                 cat,
                 One( field ) );
        
    end );
    
    ##
    AddAdditionForMorphisms( category,
      function( cat, alpha, beta )
            
        return FieldAsCategoryMorphism( 
                 cat,
                 UnderlyingFieldElement( alpha ) + UnderlyingFieldElement( beta ) );
            
    end );
    
    vec := RangeCategoryOfHomomorphismStructure( category );
    
    tunit := TensorUnit( vec );
    
    ## Homomorphism structure
    AddHomomorphismStructureOnObjects( category,
      function( cat, a, b )
        
        return tunit;
        
    end );
    
    AddHomomorphismStructureOnMorphisms( category,
      function( cat, alpha, beta )
        
        return VectorSpaceMorphism( 
            tunit,
            HomalgMatrix( [ [ UnderlyingFieldElement( alpha ) * UnderlyingFieldElement( beta ) ] ], 1, 1, field ),
            tunit
        );
        
    end );
    
    AddDistinguishedObjectOfHomomorphismStructure( category,
      function( cat )
        
        return tunit;
        
    end );
    
    AddInterpretMorphismAsMorphismFromDistinguishedObjectToHomomorphismStructure( category,
      function( cat, alpha )
        
        return VectorSpaceMorphism(
            tunit,
            HomalgMatrix( [ [ UnderlyingFieldElement( alpha ) ] ], 1, 1, field ),
            tunit
        );
        
    end );
    
    AddInterpretMorphismFromDistinguishedObjectToHomomorphismStructureAsMorphism( category,
      function( cat, a, b, mor )
        
        return FieldAsCategoryMorphism(
                 cat,
                 EntriesOfHomalgMatrix( UnderlyingMatrix( mor ) )[1] );
        
    end );
    
end );
