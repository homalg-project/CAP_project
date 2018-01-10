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

##
InstallGlobalFunction( TODO_LIST_ENTRY_FOR_MORPHISM_WITNESS_FOR_FREYD_CATEGORY,
  function( f, result, arg... )
    local entry;
    
    entry := ToDoListEntry(
                   List( arg, mor -> [ mor, "MorphismWitness" ] ),
                   result,
                   "MorphismWitness",
                   f
    );
    
    AddToToDoList( entry );
    
end );

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
        
        if not IsCongruentForMorphisms( PreCompose( MorphismWitness( morphism ), RelationMorphism( Range( morphism ) ) ),
               PreCompose( RelationMorphism( Source( morphism ) ), MorphismDatum( morphism ) ) ) then
            
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
    
    ## Basic Operations for a Category
    ##
    AddIdentityMorphism( category,
      
      function( object )
        local identity_morphism, relation_morphism;
        
        relation_morphism := RelationMorphism( object );
        
        identity_morphism := FreydCategoryMorphism( object, IdentityMorphism( Range( relation_morphism ) ), object );
        
#         SetMorphismWitness( identity_morphism, IdentityMorphism( Source( relation_morphism ) ) );
        
        return identity_morphism;
        
    end );
    
    ##
    AddPreCompose( category,
      
      function( morphism_1, morphism_2 )
        local composition;
        
        composition := PreCompose( MorphismDatum( morphism_1 ), MorphismDatum( morphism_2 ) );
        
        composition := FreydCategoryMorphism( Source( morphism_1 ), composition, Range( morphism_2 ) );
        
#         TODO_LIST_ENTRY_FOR_MORPHISM_WITNESS_FOR_FREYD_CATEGORY(
#           function( ) return PreCompose( MorphismWitness( morphism_1 ), MorphismWitness( morphism_2 ) ); end,
#           composition,
#           morphism_1,
#           morphism_2
#         );
        
        return composition;
        
    end );
    
    ## Basic Operations for an Additive Category
    ##
    
    ##
    AddAdditionForMorphisms( category,
      function( morphism_1, morphism_2 )
        local addition;
        
        addition := FreydCategoryMorphism(
                      Source( morphism_1 ),
                      AdditionForMorphisms( MorphismDatum( morphism_1 ), MorphismDatum( morphism_2 ) ),
                      Range( morphism_1 )
                    );
        
#         TODO_LIST_ENTRY_FOR_MORPHISM_WITNESS_FOR_FREYD_CATEGORY(
#           function( ) return AdditionForMorphisms( MorphismWitness( morphism_1 ), MorphismWitness( morphism_2 ) ); end,
#           addition,
#           morphism_1,
#           morphism_2
#         );
        
        return addition;
        
    end );
    
    ##
    AddAdditiveInverseForMorphisms( category,
      function( morphism )
        local additive_inverse;
        
        additive_inverse := FreydCategoryMorphism(
                              Source( morphism ),
                              AdditiveInverseForMorphisms( MorphismDatum( morphism ) ),
                              Range( morphism )
                            );
        
#         TODO_LIST_ENTRY_FOR_MORPHISM_WITNESS_FOR_FREYD_CATEGORY(
#           function( ) return AdditiveInverseForMorphisms( MorphismWitness( morphism ) ); end,
#           additive_inverse,
#           morphism
#         );
        
        return additive_inverse;
        
    end );
    
    ##
    AddZeroMorphism( category,
      function( source, range )
        local zero_morphism;
        
        zero_morphism := FreydCategoryMorphism(
                           source,
                           ZeroMorphism( Range( RelationMorphism( source ) ), Range( RelationMorphism( range ) ) ),
                           range
                         );
        
#         SetMorphismWitness( zero_morphism, ZeroMorphism( Source( RelationMorphism( source ) ), Source( RelationMorphism( range ) ) ) );
        
        return zero_morphism;
        
    end );
    
    ##
    AddZeroObject( category,
      function( )
        
        return FreydCategoryObject( ZeroObjectFunctorial( UnderlyingCategory( category ) ) );
        
    end );
    
    ##
    AddUniversalMorphismIntoZeroObjectWithGivenZeroObject( category,
      function( sink, zero_object )
        local universal_morphism;
        
        universal_morphism := FreydCategoryMorphism(
                                sink,
                                UniversalMorphismIntoZeroObject( Range( RelationMorphism( sink ) ) ),
                                zero_object
                              );
        
        return universal_morphism;
        
    end );
    
    ##
    AddUniversalMorphismFromZeroObjectWithGivenZeroObject( category,
      function( source, zero_object )
        local universal_morphism;
        
        universal_morphism := FreydCategoryMorphism(
                                zero_object,
                                UniversalMorphismFromZeroObject( Range( RelationMorphism( source ) ) ),
                                source
                              );
        
        return universal_morphism;
        
    end );
    
    ##
    AddDirectSum( category,
      function( object_list )
        
        return FreydCategoryObject( DirectSumFunctorial( List( object_list, RelationMorphism ) ) );
        
    end );
    
    ##
    AddDirectSumFunctorialWithGivenDirectSums( category,
      function( direct_sum_source, diagram, direct_sum_range )
        
        return FreydCategoryMorphism( direct_sum_source,
                                      DirectSumFunctorial( List( diagram, MorphismDatum ) ),
                                      direct_sum_range );
        
    end );
    
    ##
    AddProjectionInFactorOfDirectSumWithGivenDirectSum( category,
      function( object_list, projection_number, direct_sum_object )
        
        return FreydCategoryMorphism( direct_sum_object,
                                      ProjectionInFactorOfDirectSum( List( object_list, obj -> Range( RelationMorphism( obj ) ) ), projection_number ),
                                      object_list[projection_number]
                                    );
        
    end );
    
    ##
    AddUniversalMorphismIntoDirectSumWithGivenDirectSum( category,
      function( diagram, source, direct_sum_object )
        
        return FreydCategoryMorphism( Source( source[1] ),
                                      UniversalMorphismIntoDirectSum( List( diagram, obj -> Range( RelationMorphism( obj ) ) ),
                                                                      List( source, mor -> MorphismDatum( mor ) ) ),
                                      direct_sum_object
                                    );
        
    end );
    
    ##
    AddInjectionOfCofactorOfDirectSumWithGivenDirectSum( category,
      function( object_list, injection_number, direct_sum_object )
        
        return FreydCategoryMorphism( object_list[injection_number],
                                      InjectionOfCofactorOfDirectSum( List( object_list, obj -> Range( RelationMorphism( obj ) ) ), injection_number ),
                                      direct_sum_object
                                    );
        
    end );
    
    ##
    AddUniversalMorphismFromDirectSumWithGivenDirectSum( category,
      function( diagram, sink, direct_sum_object )
        
        return FreydCategoryMorphism( direct_sum_object,
                                      UniversalMorphismFromDirectSum( List( diagram, obj -> Range( RelationMorphism( obj ) ) ),
                                                                      List( sink, mor -> MorphismDatum( mor ) ) ),
                                      Range( sink[1] )
                                    );
        
    end );
    
end );

####################################
##
## View
##
####################################

##
InstallMethod( Display,
               [ IsFreydCategoryMorphism ],
               
  function( freyd_category_morphism )
    
    Print( "Morphism datum:\n" );
    
    Display( MorphismDatum( freyd_category_morphism ) );
    
end );


##
InstallMethod( Display,
               [ IsFreydCategoryObject ],
               
  function( freyd_category_object )
    
    Print( "Relation morphism:\n" );
    
    Display( RelationMorphism( freyd_category_object ) );
    
end );
