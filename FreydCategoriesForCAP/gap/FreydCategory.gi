#############################################################################
##
##     FreydCategoriesForCAP: Freyd categories - Formal (co)kernels for additive categories
##
##  Copyright 2018, Sebastian Posur, University of Siegen
##
#############################################################################

DeclareRepresentation( "IsFreydCategoryObjectRep",
                       IsFreydCategoryObject and IsAttributeStoringRep,
                       [ ] );

BindGlobal( "TheFamilyOfFreydCategoryObjects",
        NewFamily( "TheFamilyOfFreydCategoryObjects" ) );

BindGlobal( "TheTypeOfFreydCategoryObjects",
        NewType( TheFamilyOfFreydCategoryObjects,
                IsFreydCategoryObjectRep ) );

DeclareRepresentation( "IsFreydCategoryMorphismRep",
                       IsFreydCategoryMorphism and IsAttributeStoringRep,
                       [ ] );

BindGlobal( "TheFamilyOfFreydCategoryMorphisms",
        NewFamily( "TheFamilyOfFreydCategoryMorphisms" ) );

BindGlobal( "TheTypeOfFreydCategoryMorphisms",
        NewType( TheFamilyOfFreydCategoryMorphisms,
                IsFreydCategoryMorphismRep ) );

####################################
##
## Constructors
##
####################################

##
InstallMethod( FreydCategory,
               [ IsCapCategory ],
               
  function( underlying_category )
    local freyd_category;
    
    if not IsAdditiveCategory( underlying_category ) then
        
        Error( "The given category should be additive" );
        
    fi;
    
    ## for IsCongruentForMorphisms to be correct
    if not CanCompute( underlying_category, "Lift" ) then
        
        Error( "The given category should be able to compute Lift" );
        
    fi;
    
    if not CanCompute( underlying_category, "SubtractionForMorphisms" ) then
        
        Error( "The given category should be able to compute SubtractionForMorphisms" );
        
    fi;
    
    if not CanCompute( underlying_category, "PreCompose" ) then
        
        Error( "The given category should be able to compute PreCompose" );
        
    fi;
    
    freyd_category := CreateCapCategory( Concatenation( "Freyd category of ", Name( underlying_category ) ) );
    
    SetFilterObj( freyd_category, IsFreydCategory );
    
    SetIsAdditiveCategory( freyd_category, true );
    
    SetUnderlyingCategory( freyd_category, underlying_category );
    
    ## Freyd's theorem
    if ForAll( [ "WeakKernelEmbedding", "WeakKernelLift" ], f -> CanCompute( underlying_category, f ) ) then
        
        SetIsAbelianCategory( freyd_category, true );
        
    fi;
    
    INSTALL_FUNCTIONS_FOR_FREYD_CATEGORY( freyd_category );
    
    Finalize( freyd_category );
    
    return freyd_category;
    
end );

##
InstallMethod( FreydCategoryObject,
               [ IsCapCategoryMorphism ],
               
  function( relation_morphism )
    local freyd_category_object;
    
    freyd_category_object := rec( );
    
    ObjectifyWithAttributes( freyd_category_object, TheTypeOfFreydCategoryObjects,
                             RelationMorphism, relation_morphism );
    
    Add( FreydCategory( CapCategory( relation_morphism ) ), freyd_category_object );
    
    return freyd_category_object;
    
end );

##
InstallMethod( FreydCategoryMorphism,
               [ IsFreydCategoryObject, IsCapCategoryMorphism, IsFreydCategoryObject ],
               
  function( source, morphism_datum, range )
    local freyd_category_morphism;
    
    if not IsIdenticalObj( CapCategory( morphism_datum ), UnderlyingCategory( CapCategory( source ) ) ) then
        
        Error( "The underlying category of the given morphism datum is not identical to the underlying category of the given source" );
        
    fi;
    
    if not IsEqualForObjects( Source( morphism_datum ), Range( RelationMorphism( source ) ) ) then
        
        Error( "The source of the given morphism datum is not equal to the range of the relation morphism of the given source object" );
        
    fi;
    
    if not IsEqualForObjects( Range( morphism_datum ), Range( RelationMorphism( range ) ) ) then
        
        Error( "The range of the given morphism datum is not equal to the range of the relation morphism of the given range object" );
        
    fi;
    
    freyd_category_morphism := rec( );
    
    ObjectifyWithAttributes( freyd_category_morphism, TheTypeOfFreydCategoryMorphisms,
                             Source, source,
                             Range, range,
                             MorphismDatum, morphism_datum
    );

    Add( CapCategory( source ), freyd_category_morphism );
    
    return freyd_category_morphism;
    
end );

####################################
##
## Attributes
##
####################################

InstallMethod( MorphismWitness,
               [ IsFreydCategoryMorphism ],
               
  function( morphism )
    
    return Lift( PreCompose( RelationMorphism( Source( morphism ) ), MorphismDatum( morphism ) ), RelationMorphism( Range( morphism ) ) );
    
end );

####################################
##
## Operations
##
####################################

InstallMethodWithCacheFromObject( WitnessForBeingCongruent,
                                  [ IsFreydCategoryMorphism, IsFreydCategoryMorphism ],
                                   
  function( morphism_1, morphism_2 )
    local subtraction;
    
    subtraction := SubtractionForMorphisms( MorphismDatum( morphism_1 ), MorphismDatum( morphism_2 ) );
    
    return Lift( subtraction, RelationMorphism( Range( morphism_1 ) ) );
    
end );

####################################
##
## Basic operations
##
####################################

InstallGlobalFunction( INSTALL_FUNCTIONS_FOR_FREYD_CATEGORY,
  
  function( category )
    
    ##
    AddIsEqualForCacheForObjects( category,
      IsIdenticalObj );
    
    ##
    AddIsEqualForCacheForMorphisms( category,
      IsIdenticalObj );
    
    ## Well-defined for objects and morphisms
    ##
    AddIsWellDefinedForObjects( category,
      function( object )
        
        if not IsWellDefined( RelationMorphism( object ) ) then
            
            return false;
            
        fi;
        
        # all tests passed, so it is well-defined
        return true;
        
    end );
    
    ##
    AddIsWellDefinedForMorphisms( category,
      function( morphism )
        
        if MorphismWitness( morphism ) = fail then
            
            return false;
            
        fi;
        
        # all tests passed, so it is well-defined
        return true;
        
    end );
    
    ## Equality Basic Operations for Objects and Morphisms
    ##
    AddIsEqualForObjects( category,
      function( object_1, object_2 )
      
        return IsEqualForMorphisms( RelationMorphism( object_1 ), RelationMorphism( object_2 ) );
      
    end );
    
    ##
    AddIsEqualForMorphisms( category,
      function( morphism_1, morphism_2 )
        
        return IsEqualForMorphisms( MorphismDatum( morphism_1 ), MorphismDatum( morphism_2 ) );
        
    end );
    
    ##
    AddIsCongruentForMorphisms( category,
      function( morphism_1, morphism_2 )
        
        if WitnessForBeingCongruent( morphism_1, morphism_2 ) = fail then
            
            return false;
            
        else
            
            return true;
            
        fi;
        
    end );
    
    
    
end );















