#############################################################################
##
##     FreydCategoriesForCAP: Freyd categories - Formal (co)kernels for additive categories
##
##  Copyright 2018, Sebastian Posur, University of Siegen
##
#############################################################################

####################################
##
## Constructors
##
####################################

##
InstallMethod( CokernelImageClosure,
               [ IsCapCategory ],
               
  function( underlying_category )
    local cokernel_image_closure;
    
    if not HasIsAdditiveCategory( underlying_category ) then
        
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
    
    cokernel_image_closure := CreateCapCategory( Concatenation( "Cokernel image closure( ", Name( underlying_category ), " )" ) );
    
    SetFilterObj( cokernel_image_closure, IsCokernelImageClosure );
    
    SetIsAdditiveCategory( cokernel_image_closure, true );
    
    SetUnderlyingCategory( cokernel_image_closure, underlying_category );
    
    ## Freyd's theorem generalized to cokernel image closures
    if ForAll( [ "WeakKernelEmbedding", "WeakKernelLift" ], f -> CanCompute( underlying_category, f ) ) then
        
        SetIsAbelianCategory( cokernel_image_closure, true );
        
    fi;
    
    AddObjectRepresentation( cokernel_image_closure, IsCokernelImageClosureObject );
    
    AddMorphismRepresentation( cokernel_image_closure, IsCokernelImageClosureMorphism );
    
    INSTALL_FUNCTIONS_FOR_COKERNEL_IMAGE_CLOSURE( cokernel_image_closure );
    
    Finalize( cokernel_image_closure );
    
    return cokernel_image_closure;
    
end );

##
InstallMethod( CokernelImageClosureObject,
               [ IsCapCategoryMorphism, IsCapCategoryMorphism ],
               
  function( generator_morphism, relation_morphism )
    local cokernel_image_object, category;
    
    if not IsEqualForObjects( Range( generator_morphism ), Range( relation_morphism ) ) then
        
        Error ( "the ranges of the given morphisms have to be equal" );
        
    fi;

    cokernel_image_object := rec( );
    
    category := CokernelImageClosure( CapCategory( relation_morphism ) );

    ObjectifyObjectForCAPWithAttributes( cokernel_image_object, category,
                                         GeneratorMorphism, generator_morphism,
                                         RelationMorphism, relation_morphism );
    
    return cokernel_image_object;
    
end );

##
InstallMethod( AsCokernelImageClosureObject,
               [ IsCapCategoryObject ],
               
  function( object )
    local projective_object;
    
    projective_object := CokernelImageClosureObject( IdentityMorphism( object ), UniversalMorphismFromZeroObject( object ) );
    # check if this is still correct
    # SetIsProjective( projective_object, true );
    
    return projective_object;
    
end );

##
InstallMethod( AsFinitelyPresentedCokernelImageClosureObject,
               [ IsCapCategoryMorphism ],
               
  function( morphism )
    
    return CokernelImageClosureObject( IdentityMorphism( Range( morphism ) ), morphism );
    
end );

##
InstallMethod( CokernelImageClosureMorphism,
               [ IsCokernelImageClosureObject, IsCapCategoryMorphism, IsCokernelImageClosureObject ],
               
  function( source, morphism_datum, range )
    local cokernel_image_closure_morphism, category;
    
    if not IsIdenticalObj( CapCategory( morphism_datum ), UnderlyingCategory( CapCategory( source ) ) ) then
        
        Error( "The underlying category of the given morphism datum is not identical to the underlying category of the given source" );
        
    fi;
    
    if not IsEqualForObjects( Source( morphism_datum ), Source( GeneratorMorphism( source ) ) ) then
        
        Error( "The source of the given morphism datum is not equal to the source of the generator morphism of the given source object" );
        
    fi;
    
    if not IsEqualForObjects( Range( morphism_datum ), Source( GeneratorMorphism( range ) ) ) then
        
        Error( "The range of the given morphism datum is not equal to the source of the generator morphism of the given range object" );
        
    fi;
    
    cokernel_image_closure_morphism := rec( );
    
    category :=  CapCategory( source );

    ObjectifyMorphismForCAPWithAttributes( 
                             cokernel_image_closure_morphism, category,
                             Source, source,
                             Range, range,
                             MorphismDatum, morphism_datum
    );
    
    return cokernel_image_closure_morphism;
    
end );

##
InstallMethod( AsCokernelImageClosureMorphism,
               [ IsCapCategoryMorphism ],
               
  function( morphism )
    
    return CokernelImageClosureMorphism(
             AsCokernelImageClosureObject( Source( morphism ) ),
             morphism,
             AsCokernelImageClosureObject( Range( morphism ) )
           );
    
end );

##
InstallMethod( RelationOfGeneratorMorphism, 
               [ IsCokernelImageClosureObject ],
               
  function( object ) 
    
    if not CanCompute( UnderlyingCategory( CapCategory( object ) ), "ProjectionOfBiasedWeakFiberProduct" ) then

        Error( "cannot decide well-definedness since the underlying category does not have the projection of biased weak fiber products" );

    fi;

    return ProjectionOfBiasedWeakFiberProduct( GeneratorMorphism( object ), RelationMorphism( object ) );
    
end );

##
InstallMethod( WitnessForBeingCongruentToZero,
               [ IsCokernelImageClosureMorphism ],

  function( morphism )
    local range;
    
    range := Range( morphism );

    return
    Lift(
        PreCompose(
            MorphismDatum( morphism ),
            GeneratorMorphism( range )
        ),
        RelationMorphism( range )
    );

end );

####################################
##
## Basic operations
##
####################################

InstallGlobalFunction( INSTALL_FUNCTIONS_FOR_COKERNEL_IMAGE_CLOSURE,
  
  function( category )
    local underlying_category;

    underlying_category := UnderlyingCategory( category );
    
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
        local relation_morphism, generator_morphism;

        relation_morphism := RelationMorphism( object );

        generator_morphism := GeneratorMorphism( object );
        
        if not IsWellDefined( relation_morphism ) 
           or not IsWellDefined( generator_morphism ) then
            
            return false;
            
        fi;
        
        if not IsEqualForObjects( Range( generator_morphism ), Range( relation_morphism ) ) then

            return false;

        fi;

        # all tests passed, so it is well-defined
        return true;
        
    end );
    
    ##
    AddIsWellDefinedForMorphisms( category,
      function( morphism )
        local alpha, lift;
        
        alpha := PreCompose( [ 
            RelationOfGeneratorMorphism( Source( morphism ) ),
            MorphismDatum( morphism ),
            GeneratorMorphism( Range( morphism ) )
        ] );
        
        lift := Lift( alpha, RelationMorphism( Range( morphism ) ) );

        if lift = fail then
            
            return false;

        fi;
        
        # all tests passed, so it is well-defined
        return true;
        
    end );

    ## Equality Basic Operations for Objects and Morphisms
    ##
    AddIsEqualForObjects( category,
      function( object_1, object_2 )

        return IsEqualForMorphismsOnMor( RelationMorphism( object_1 ), RelationMorphism( object_2 ) ) 
               and 
               IsEqualForMorphismsOnMor( GeneratorMorphism( object_1 ), GeneratorMorphism( object_2) );

    end );
    
    ##
    AddIsEqualForMorphisms( category,
      function( morphism_1, morphism_2 )
        
        return IsEqualForMorphisms( MorphismDatum( morphism_1 ), MorphismDatum( morphism_2 ) );
        
    end );
    
    ##
    AddIsCongruentForMorphisms( category,
      function( morphism_1, morphism_2 )
        
        if WitnessForBeingCongruentToZero( SubtractionForMorphisms( morphism_1, morphism_2 ) ) = fail then
            
            return false;
            
        else
            
            return true;
            
        fi;
        
    end );

    AddIdentityMorphism( category,
      function( object )

        return CokernelImageClosureMorphism(
            object,
            IdentityMorphism( Source( GeneratorMorphism( object ) ) ),
            object
        );

    end );

    ##
    AddPreCompose( category,
      
      function( morphism_1, morphism_2 )
        local composition;
        
        composition := PreCompose( MorphismDatum( morphism_1 ), MorphismDatum( morphism_2 ) );
        
        composition := CokernelImageClosureMorphism( Source( morphism_1 ), composition, Range( morphism_2 ) );
        
        return composition;
        
    end );

    ##
    AddAdditionForMorphisms( category,
      function( morphism_1, morphism_2 )
        local addition;
        
        addition := CokernelImageClosureMorphism(
                      Source( morphism_1 ),
                      AdditionForMorphisms( MorphismDatum( morphism_1 ), MorphismDatum( morphism_2 ) ),
                      Range( morphism_1 )
                    );
        
        return addition;
        
    end );

    ##
    AddSubtractionForMorphisms( category,
      function( morphism_1, morphism_2 )
        local substraction;
        
        substraction := CokernelImageClosureMorphism(
                      Source( morphism_1 ),
                      SubtractionForMorphisms( MorphismDatum( morphism_1 ), MorphismDatum( morphism_2 ) ),
                      Range( morphism_1 )
                    );
        
        return substraction;
        
    end );
    
    ##
    AddAdditiveInverseForMorphisms( category,
      function( morphism )
        local additive_inverse;
        
        additive_inverse := CokernelImageClosureMorphism(
                              Source( morphism ),
                              AdditiveInverseForMorphisms( MorphismDatum( morphism ) ),
                              Range( morphism )
                            );
        
        return additive_inverse;
        
    end );
    
    ##
    AddZeroMorphism( category,
      function( source, range )
        local zero_morphism;
        
        zero_morphism := CokernelImageClosureMorphism(
                           source,
                           ZeroMorphism( Source( GeneratorMorphism( source ) ), Source( GeneratorMorphism( range ) ) ),
                           range
                         );
        
        return zero_morphism;
        
    end );
    
    ##
    AddZeroObject( category,
      function( )
        
        return AsCokernelImageClosureObject( ZeroObject( underlying_category ) );
        
    end );
    
    ##
    AddUniversalMorphismIntoZeroObjectWithGivenZeroObject( category,
      function( sink, zero_object )
        local universal_morphism;
        
        universal_morphism := CokernelImageClosureMorphism(
                                sink,
                                UniversalMorphismIntoZeroObject( Source( GeneratorMorphism( sink ) ) ),
                                zero_object
                              );
        
        return universal_morphism;
        
    end );
    
    ##
    AddUniversalMorphismFromZeroObjectWithGivenZeroObject( category,
      function( source, zero_object )
        local universal_morphism;
        
        universal_morphism := CokernelImageClosureMorphism(
                                zero_object,
                                UniversalMorphismFromZeroObject( Source( GeneratorMorphism( source ) ) ),
                                source
                              );
        
        return universal_morphism;
        
    end );

    ##
    AddDirectSum( category,
      function( object_list )
        
        return CokernelImageClosureObject( 
                DirectSumFunctorial( List( object_list, GeneratorMorphism ) ),
                DirectSumFunctorial( List( object_list, RelationMorphism ) )
        );
        
    end );
    
    ##
    AddDirectSumFunctorialWithGivenDirectSums( category,
      function( direct_sum_source, diagram, direct_sum_range )
        
        return CokernelImageClosureMorphism(
                    direct_sum_source,
                    DirectSumFunctorial( List( diagram, MorphismDatum ) ),
                    direct_sum_range 
        );
        
    end );
    
    ##
    AddProjectionInFactorOfDirectSumWithGivenDirectSum( category,
      function( object_list, projection_number, direct_sum_object )
        
        return CokernelImageClosureMorphism( 
                direct_sum_object,
                ProjectionInFactorOfDirectSum( List( object_list, obj -> Source( GeneratorMorphism( obj ) ) ), projection_number ),
                object_list[projection_number]
        );
        
    end );
    
    ##
    AddUniversalMorphismIntoDirectSumWithGivenDirectSum( category,
      function( diagram, source, direct_sum_object )
        
        return CokernelImageClosureMorphism(
                Source( source[1] ),
                UniversalMorphismIntoDirectSum(
                    List( diagram, obj -> Source( GeneratorMorphism( obj ) ) ),
                    List( source, mor -> MorphismDatum( mor ) ) 
                ),
                direct_sum_object
        );
        
    end );
    
    ##
    AddInjectionOfCofactorOfDirectSumWithGivenDirectSum( category,
      function( object_list, injection_number, direct_sum_object )
        
        return CokernelImageClosureMorphism(
                object_list[injection_number],
                InjectionOfCofactorOfDirectSum( List( object_list, obj -> Source( GeneratorMorphism( obj ) ) ), injection_number ),
                direct_sum_object
        );
        
    end );
    
    ##
    AddUniversalMorphismFromDirectSumWithGivenDirectSum( category,
      function( diagram, sink, direct_sum_object )
        
        return CokernelImageClosureMorphism(
                direct_sum_object,
                UniversalMorphismFromDirectSum( List( diagram, obj -> Source( GeneratorMorphism( obj ) ) ),
                List( sink, mor -> MorphismDatum( mor ) ) ),
                Range( sink[1] )
        );
        
    end );

    ##
    AddCokernelProjection( category,
                     
      function( morphism )
        local range, relation_morphism, generator_morphism, cokernel_object, cokernel_projection;
        
        range := Range( morphism );
        
        relation_morphism := RelationMorphism( range );

        generator_morphism := GeneratorMorphism( range );
        
        cokernel_object := 
            CokernelImageClosureObject(
                GeneratorMorphism( range ),
                UniversalMorphismFromDirectSum( [ 
                    relation_morphism,
                    PreCompose( MorphismDatum( morphism ), generator_morphism ) 
                ] ) 
            );
        
        cokernel_projection := 
            CokernelImageClosureMorphism(
                range,
                IdentityMorphism( Source( generator_morphism ) ),
                cokernel_object 
            );
        
        return cokernel_projection;
        
    end );
    
    ##
    AddCokernelColiftWithGivenCokernelObject( category,
      
      function( morphism, test_morphism, cokernel_object )
        
        return 
            CokernelImageClosureMorphism( 
                cokernel_object,
                MorphismDatum( test_morphism ),
                Range( test_morphism ) 
            );
        
    end );
    
    ##
    AddImageObject( category,
      
      function( morphism )
        local range;

        range := Range( morphism );

        return 
            CokernelImageClosureObject( 
                PreCompose( MorphismDatum( morphism ), GeneratorMorphism( range ) ),
                RelationMorphism( range )
            );
    end );

    ##
    AddImageEmbeddingWithGivenImageObject( category,
      
      function( morphism, image )
        
        return
            CokernelImageClosureMorphism(
                image,
                MorphismDatum( morphism ),
                Range( morphism )
            );
    end );

    ##
    AddCoastrictionToImageWithGivenImageObject( category,
      
      function( morphism, image )
        local source;

        source := Source( morphism );

        return
            CokernelImageClosureMorphism(
                source,
                IdentityMorphism( Source( GeneratorMorphism( source ) ) ),
                image
            );
        
    end );

    ##
    AddUniversalMorphismFromImageWithGivenImageObject( category,
      
      function( morphism, test_factorization, image )
        local tau;

        tau := test_factorization[1];

        return
            CokernelImageClosureMorphism(
                image,
                MorphismDatum( tau ),
                Range( tau )
            );
        
    end );

    if ForAll( [ "ProjectionOfBiasedWeakFiberProduct", "UniversalMorphismIntoBiasedWeakFiberProduct" ], f -> CanCompute( underlying_category, f ) ) then

        ##
        AddKernelEmbedding( category,
          
          function( morphism )
            local range, projection, source, kernel;

            range := Range( morphism );

            projection := 
                ProjectionOfBiasedWeakFiberProduct(
                    PreCompose( MorphismDatum( morphism ), GeneratorMorphism( range ) ),
                    RelationMorphism( range )
                );
            
            source := Source( morphism );

            kernel := CokernelImageClosureObject(
                PreCompose( projection, GeneratorMorphism( source ) ),
                RelationMorphism( source )
            );

            return
                CokernelImageClosureMorphism(
                    kernel,
                    projection,
                    source
                );
        end );

        ##
        AddKernelLiftWithGivenKernelObject( category,
          
          function( morphism, test_morphism, kernel )
            local range, u;

            range := Range( morphism );

            u := UniversalMorphismIntoBiasedWeakFiberProduct(
                PreCompose( MorphismDatum( morphism ), GeneratorMorphism( range ) ),
                RelationMorphism( range ),
                MorphismDatum( test_morphism )
            );
            
            return
                CokernelImageClosureMorphism(
                    Source( test_morphism ),
                    u,
                    kernel
                );
        end );

        ##
        AddEpimorphismFromSomeProjectiveObject( category,
          
          function( object ) 
            local proj_object;

            proj_object := Source( GeneratorMorphism( object ) );

            return
                CokernelImageClosureMorphism(
                    AsCokernelImageClosureObject( proj_object ),
                    IdentityMorphism( proj_object ),
                    object
                );
        end );

        ##
        AddLiftAlongMonomorphism( category,
          
          function( alpha, tau )
            local A,B, gamma_B, rho_B, lift, Au, RBu;

            A := Source( alpha );

            B := Range( alpha );

            gamma_B := GeneratorMorphism( B );

            rho_B := RelationMorphism( B );

            lift := Lift(
                PreCompose( MorphismDatum( tau ), gamma_B ),
                UniversalMorphismFromDirectSum(
                    [ PreCompose( MorphismDatum( alpha ), gamma_B ), rho_B ]
                )
            );

            Au := Source( GeneratorMorphism( A ) );

            RBu := Source( RelationMorphism( B ) );

            lift := ComponentOfMorphismIntoDirectSum( lift, [ Au, RBu ], 1 );

            return
                CokernelImageClosureMorphism(
                    Source( tau ),
                    lift,
                    A
                );
            
        end );
    
    fi;

    


end );

####################################
##
## View
##
####################################

##
InstallMethod( Display,
               [ IsCokernelImageClosureObject ],
               
  function( object )
    
    Print( "Generator morphism:\n" );
    
    Display( GeneratorMorphism( object ) );
    
    Print( "------------------\n" );
    Print( "Relation morphism:\n" );
    
    Display( RelationMorphism( object ) );

end );

##
InstallMethod( Display,
               [ IsCokernelImageClosureMorphism ],
               
  function( cokernel_image_closure_morphism )
    
    Print( "Morphism datum:\n" );
    
    Display( MorphismDatum( cokernel_image_closure_morphism ) );
    
end );

####################################
##
## Functors
##
####################################

##
InstallMethod( FunctorCokernelImageClosureToFreydCategory,
               [ IsCapCategory ],
               
  function( underlying_category )
    local cokernel_image_closure, freyd_category, functor;
    
    cokernel_image_closure := CokernelImageClosure( underlying_category );
    
    if not HasIsAbelianCategory( cokernel_image_closure ) and IsAbelianCategory( cokernel_image_closure ) then
        
        Error( "The cokernel image closure of the given additive category is not abelian" );
        
    fi;
    
    freyd_category := FreydCategory( underlying_category );
    
    functor := CapFunctor( Concatenation( "Functor Cokernel image closure to Freyd category of ", Name( underlying_category ) ), cokernel_image_closure, freyd_category );
    
    AddObjectFunction( functor,
      function( cokernel_image_closure_object )
        
        return FreydCategoryObject(
                ProjectionOfBiasedWeakFiberProduct( GeneratorMorphism( cokernel_image_closure_object ), RelationMorphism( cokernel_image_closure_object ) )
        );
        
    end );
    
    AddMorphismFunction( functor,
      function( new_source, morphism, new_range )
        
        return FreydCategoryMorphism( new_source, MorphismDatum( morphism ), new_range );
        
    end );
    
    return functor;

end );

##
InstallMethod( FunctorFreydCategoryToCokernelImageClosure,
               [ IsCapCategory ],
               
  function( underlying_category )
    local cokernel_image_closure, freyd_category, functor;
    
    cokernel_image_closure := CokernelImageClosure( underlying_category );
    
    freyd_category := FreydCategory( underlying_category );
    
    functor := CapFunctor( Concatenation( "Functor Freyd category to Cokernel image closure of ", Name( underlying_category ) ), freyd_category, cokernel_image_closure );
    
    AddObjectFunction( functor,
      function( freyd_category_object )
        
        return AsFinitelyPresentedCokernelImageClosureObject( RelationMorphism( freyd_category_object ) );
        
    end );
    
    AddMorphismFunction( functor,
      function( new_source, morphism, new_range )
        
        return CokernelImageClosureMorphism( new_source, MorphismDatum( morphism ), new_range );
        
    end );
    
    return functor;

end );

#######################################
##
## Natural Transformations
##
#######################################

##
InstallMethod( NaturalIsomorphismFromIdentityToFinitePresentationOfCokernelImageClosureObject,
               [ IsCapCategory ],
               
  function( underlying_category )
    local cokernel_image_closure, auto, natural_isomorphism;
    
    cokernel_image_closure := CokernelImageClosure( underlying_category );
    
    auto := PreCompose( 
        FunctorCokernelImageClosureToFreydCategory( underlying_category ),
        FunctorFreydCategoryToCokernelImageClosure( underlying_category )
    );
    
    natural_isomorphism := NaturalTransformation(
        Concatenation( "Natural isomorphism from Id to FinitePresentationOfCokernelImageClosureObject over ",  Name( underlying_category ) ),
        IdentityMorphism( AsCatObject( cokernel_image_closure ) ), auto 
    );
    
    AddNaturalTransformationFunction( natural_isomorphism,
      function( id_object, object, standard_object )
        
        return CokernelImageClosureMorphism(
            id_object, IdentityMorphism( Source( GeneratorMorphism( object ) ) ), standard_object
        );
        
    end );
    
    return natural_isomorphism;
    
end );

##
InstallMethod( NaturalIsomorphismFromFinitePresentationOfCokernelImageClosureObjectToIdentity,
               [ IsCapCategory ],
               
  function( underlying_category )
    local cokernel_image_closure, auto, natural_isomorphism;
    
    cokernel_image_closure := CokernelImageClosure( underlying_category );
    
    auto := PreCompose( 
        FunctorCokernelImageClosureToFreydCategory( underlying_category ),
        FunctorFreydCategoryToCokernelImageClosure( underlying_category )
    );
    
    natural_isomorphism := NaturalTransformation( 
        Concatenation( "Natural isomorphism from FinitePresentationOfCokernelImageClosureObject to Id over ",  Name( underlying_category ) ),
        auto, IdentityMorphism( AsCatObject( cokernel_image_closure ) ) 
    );
    
    AddNaturalTransformationFunction( natural_isomorphism,
      function( standard_object, object, id_object )
        
        return CokernelImageClosureMorphism(
           standard_object, IdentityMorphism( Source( GeneratorMorphism( object ) ) ), id_object 
        );
        
    end );
    
    return natural_isomorphism;
    
end );
