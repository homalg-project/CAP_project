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
InstallMethod( AdelmanCategory,
               [ IsCapCategory ],

  function( underlying_category )
    local adelman_category, func, to_be_finalized;
    
    if not HasIsAdditiveCategory( underlying_category ) then
        
        Error( "The given category should be additive" );
        
    fi;
    
    for func in [ "Lift", "Colift", "SubtractionForMorphisms", "AdditionForMorphisms", "PreCompose", "IdentityMorphism", "SolveLinearSystemInAbCategory" ] do
        
        if not CanCompute( underlying_category, func ) then
            
            Error( "The given category should be able to compute ", func );
            
        fi;
        
    od;
    
    adelman_category := CreateCapCategory( Concatenation( "Adelman category( ", Name( underlying_category ), " )" ) );
    
    SetFilterObj( adelman_category, IsAdelmanCategory );
    
    ## this is the purpose of the Adelman category
    SetIsAbelianCategory( adelman_category, true );
    
    SetUnderlyingCategory( adelman_category, underlying_category );
    
    DisableAddForCategoricalOperations( adelman_category );
    
    AddObjectRepresentation( adelman_category, IsAdelmanCategoryObject );
    
    AddMorphismRepresentation( adelman_category, IsAdelmanCategoryMorphism );
    
    INSTALL_FUNCTIONS_FOR_ADELMAN_CATEGORY( adelman_category );
    
    to_be_finalized := ValueOption( "FinalizeCategory" );
      
    if to_be_finalized = false then
      
      return adelman_category;
    
    fi;
    
    Finalize( adelman_category );
    
    return adelman_category;
    
end );


##
InstallMethod( AdelmanCategoryObject,
               [ IsCapCategoryMorphism, IsCapCategoryMorphism ],

  function( relation_morphism, corelation_morphism )
    local adelman_category_object, category;
    
    if not IsEqualForObjects( Range( relation_morphism ), Source( corelation_morphism ) ) then
    
        Error ( "the range of the relation morphism has to be equal to the source of the corelation morphism" );
    
    fi;
    
    adelman_category_object := rec( );
    
    category := AdelmanCategory( CapCategory( relation_morphism ) );
    
    ObjectifyObjectForCAPWithAttributes( adelman_category_object, category,
                                         RelationMorphism, relation_morphism,
                                         CorelationMorphism, corelation_morphism );
    
    return adelman_category_object;
    
end );

##
InstallMethod( AsAdelmanCategoryObject,
               [ IsCapCategoryObject ],
               
  function( object )
    local proj_inj_object;
    
    proj_inj_object := AdelmanCategoryObject( UniversalMorphismFromZeroObject( object ), UniversalMorphismIntoZeroObject( object ) );
    
    ## TODO: IsInjective and IsProjective
    
    return proj_inj_object;
    
end );

##
InstallMethod( AdelmanCategoryMorphism,
               [ IsAdelmanCategoryObject, IsCapCategoryMorphism, IsAdelmanCategoryObject ],
               
  function( source, morphism_datum, range )
    local adelman_category_morphism, category;
    
    if not IsIdenticalObj( CapCategory( morphism_datum ), UnderlyingCategory( CapCategory( source ) ) ) then
        
        Error( "The underlying category of the given morphism datum is not identical to the underlying category of the given source" );
        
    fi;
    
    if not IsEqualForObjects( Source( morphism_datum ), Source( CorelationMorphism( source ) ) ) then
        
        Error( "The source of the given morphism datum is not equal to the source of the corelation morphism of the given source object" );
        
    fi;
    
    if not IsEqualForObjects( Range( morphism_datum ), Source( CorelationMorphism( range ) ) ) then
        
        Error( "The range of the given morphism datum is not equal to the source of the corelation morphism of the given range object" );
        
    fi;
    
    adelman_category_morphism := rec( );
    
    category :=  CapCategory( source );
    
    ObjectifyMorphismForCAPWithAttributes( 
                             adelman_category_morphism, category,
                             Source, source,
                             Range, range,
                             MorphismDatum, morphism_datum
    );
    
    Add( category, adelman_category_morphism );
    
    return adelman_category_morphism;
    
end );

##
InstallMethod( AsAdelmanCategoryMorphism,
               [ IsCapCategoryMorphism ],
               
  function( morphism )
    
    return AdelmanCategoryMorphism(
             AsAdelmanCategoryObject( Source( morphism ) ),
             morphism,
             AsAdelmanCategoryObject( Range( morphism ) )
           );
    
end );

####################################
##
## Attributes
##
####################################

##
InstallMethod( RelationWitness,
               [ IsAdelmanCategoryMorphism ],
               
  function( morphism )
    
    return Lift( PreCompose( RelationMorphism( Source( morphism ) ), MorphismDatum( morphism ) ), RelationMorphism( Range( morphism ) ) );
    
end );

##
InstallMethod( CorelationWitness,
               [ IsAdelmanCategoryMorphism ],
               
  function( morphism )
    
    return Colift( CorelationMorphism( Source( morphism ) ), PreCompose( MorphismDatum( morphism ), CorelationMorphism( Range( morphism ) ) ) );
    
end );

##
InstallMethod( WitnessPairForBeingCongruentToZero,
               [ IsAdelmanCategoryMorphism ],
               
  function( morphism )
    local datum, left_coeffs, right_coeffs;
    
    datum := MorphismDatum( morphism );
    
    left_coeffs :=
        [ [ IdentityMorphism( Source( datum ) ), CorelationMorphism( Source( morphism ) ) ] ];
    
    right_coeffs :=
        [ [ RelationMorphism( Range( morphism ) ), IdentityMorphism( Range( datum ) ) ] ];
    
    return SolveLinearSystemInAbCategory( left_coeffs, right_coeffs, [ datum ] );
    
end );

####################################
##
## Basic operations
##
####################################

InstallGlobalFunction( INSTALL_FUNCTIONS_FOR_ADELMAN_CATEGORY,

  function( category )
    local underlying_category, distinguished_object, range_category, homomorphism_structure_derivation_case,
          homomorphism_structure_on_morphisms, interpret_homomorphism_as_morphism_from_distinguished_object_to_homomorphism_structure,
          interpret_morphism_from_distinguished_object_to_homomorphism_structure_as_homomorphism;
    
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
        local relation_morphism, corelation_morphism;
        
        relation_morphism := RelationMorphism( object );
        
        corelation_morphism := CorelationMorphism( object );
        
        if not IsWellDefined( relation_morphism ) 
           or not IsWellDefined( corelation_morphism ) then
            
            return false;
            
        fi;
        
        if not IsEqualForObjects( Source( corelation_morphism ), Range( relation_morphism ) ) then
            
            return false;
            
        fi;
        
        # all tests passed, so it is well-defined
        return true;
        
    end );
    
    ##
    AddIsWellDefinedForMorphisms( category,
      function( morphism )
        
        if RelationWitness( morphism ) = fail then
            
            return false;
            
        fi;
        
        if CorelationWitness( morphism ) = fail then
            
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
               and IsEqualForMorphismsOnMor( CorelationMorphism( object_1 ), CorelationMorphism( object_2 ) );
        
    end );
    
    ##
    AddIsEqualForMorphisms( category,
      function( morphism_1, morphism_2 )
        
        return IsEqualForMorphisms( MorphismDatum( morphism_1 ), MorphismDatum( morphism_2 ) );
        
    end );
    
    ##
    AddIsCongruentForMorphisms( category,
      function( morphism_1, morphism_2 )
        
        if WitnessPairForBeingCongruentToZero( SubtractionForMorphisms( morphism_1, morphism_2 ) ) = fail then
            
            return false;
            
        else
            
            return true;
            
        fi;
        
    end );
    
    ## Basic Operations for a Category
    ##
    AddIdentityMorphism( category,
      
      function( object )
        
        return AdelmanCategoryMorphism( object, IdentityMorphism( Range( RelationMorphism( object ) ) ), object );
        
    end );
    
    ##
    AddPreCompose( category,
      
      function( morphism_1, morphism_2 )
        local composition;
        
        composition := PreCompose( MorphismDatum( morphism_1 ), MorphismDatum( morphism_2 ) );
        
        return AdelmanCategoryMorphism( Source( morphism_1 ), composition, Range( morphism_2 ) );
        
    end );

    ##
    AddSubtractionForMorphisms( category,
      function( morphism_1, morphism_2 )
        local subtraction;
        
        subtraction := AdelmanCategoryMorphism(
                            Source( morphism_1 ),
                            SubtractionForMorphisms( MorphismDatum( morphism_1 ), MorphismDatum( morphism_2 ) ),
                            Range( morphism_1 )
                        );
        
        return subtraction;
        
    end );
    
    ##
    AddAdditionForMorphisms( category,
      function( morphism_1, morphism_2 )
        local addition;
        
        addition := AdelmanCategoryMorphism(
                            Source( morphism_1 ),
                            AdditionForMorphisms( MorphismDatum( morphism_1 ), MorphismDatum( morphism_2 ) ),
                            Range( morphism_1 )
                        );
        
        return addition;
        
    end );
    
    ##
    AddAdditiveInverseForMorphisms( category,
      function( morphism )
        local additive_inverse;
        
        additive_inverse := AdelmanCategoryMorphism(
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
        
        zero_morphism := AdelmanCategoryMorphism(
                           source,
                           ZeroMorphism( Range( RelationMorphism( source ) ), Range( RelationMorphism( range ) ) ),
                           range
                         );
        
        return zero_morphism;
        
    end );
    
    ##
    AddZeroObject( category,
      function( )
        
        return AsAdelmanCategoryObject( ZeroObject( underlying_category) );
        
    end );
    
    ##
    AddUniversalMorphismIntoZeroObjectWithGivenZeroObject( category,
      function( sink, zero_object )
        local universal_morphism;
        
        universal_morphism := AdelmanCategoryMorphism(
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
        
        universal_morphism := AdelmanCategoryMorphism(
                                zero_object,
                                UniversalMorphismFromZeroObject( Range( RelationMorphism( source ) ) ),
                                source
                              );
        
        return universal_morphism;
        
    end );
    
    ##
    AddDirectSum( category,
      function( object_list )
        
        return AdelmanCategoryObject( DirectSumFunctorial( List( object_list, RelationMorphism ) ),
                                      DirectSumFunctorial( List( object_list, CorelationMorphism ) ) );
        
    end );
    
    ##
    AddDirectSumFunctorialWithGivenDirectSums( category,
      function( direct_sum_source, diagram, direct_sum_range )
        
        return AdelmanCategoryMorphism( direct_sum_source,
                                        DirectSumFunctorial( List( diagram, MorphismDatum ) ),
                                        direct_sum_range );
        
    end );
    
    ##
    AddProjectionInFactorOfDirectSumWithGivenDirectSum( category,
      function( object_list, projection_number, direct_sum_object )
        
        return AdelmanCategoryMorphism( direct_sum_object,
                                        ProjectionInFactorOfDirectSum( List( object_list, obj -> Range( RelationMorphism( obj ) ) ), projection_number ),
                                        object_list[projection_number]
                                      );
        
    end );
    
    ##
    AddUniversalMorphismIntoDirectSumWithGivenDirectSum( category,
      function( diagram, source, direct_sum_object )
        
        return AdelmanCategoryMorphism( Source( source[1] ),
                                        UniversalMorphismIntoDirectSum( List( diagram, obj -> Range( RelationMorphism( obj ) ) ),
                                                                        List( source, mor -> MorphismDatum( mor ) ) ),
                                        direct_sum_object
                                      );
        
    end );
    
    ##
    AddInjectionOfCofactorOfDirectSumWithGivenDirectSum( category,
      function( object_list, injection_number, direct_sum_object )
        
        return AdelmanCategoryMorphism( object_list[injection_number],
                                        InjectionOfCofactorOfDirectSum( List( object_list, obj -> Range( RelationMorphism( obj ) ) ), injection_number ),
                                        direct_sum_object
                                      );
        
    end );
    
    ##
    AddUniversalMorphismFromDirectSumWithGivenDirectSum( category,
      function( diagram, sink, direct_sum_object )
        
        return AdelmanCategoryMorphism( direct_sum_object,
                                        UniversalMorphismFromDirectSum( List( diagram, obj -> Range( RelationMorphism( obj ) ) ),
                                                                        List( sink, mor -> MorphismDatum( mor ) ) ),
                                        Range( sink[1] )
                                      );
        
    end );
    
    ##
    AddCokernelProjection( category,
                     
      function( morphism )
        local source, range, b, bp, ap, B, Bp, App, alpha, cokernel_object;
        
        source := Source( morphism );
        
        range := Range( morphism );
        
        b := RelationMorphism( range );
        
        bp := CorelationMorphism( range );
        
        ap := CorelationMorphism( source );
        
        B := Range( b );
        
        Bp := Source( b );
        
        App := Range( ap );
        
        alpha := MorphismDatum( morphism );
        
        cokernel_object :=
            AdelmanCategoryObject(
                MorphismBetweenDirectSums( [ [ b, ZeroMorphism( Bp, App ) ], [ alpha, ap ] ] ),
                DirectSumFunctorial( [ bp, IdentityMorphism( App ) ] )
            );
        
        return AdelmanCategoryMorphism( 
            Range( morphism ),
            InjectionOfCofactorOfDirectSum( [ B, App ], 1 ),
            cokernel_object
        );
        
    end );
    
    ##
    AddCokernelColiftWithGivenCokernelObject( category,
      
      function( morphism, test_morphism, cokernel_object )
        local witness_pair, datum;
        
        witness_pair := WitnessPairForBeingCongruentToZero( PreCompose( morphism, test_morphism ) );
        
        datum :=
            UniversalMorphismFromDirectSum(
                [ MorphismDatum( test_morphism ), -witness_pair[2] ]
            );
        
        return AdelmanCategoryMorphism( cokernel_object,
                                        datum,
                                        Range( test_morphism ) );
        
    end );
    
    ##
    AddColiftAlongEpimorphism( category,
      
      function( alpha, tau )
        local witness_alpha, sigma78, sigma56, witness_test, sigma12, range_alpha, b2, datum_tau, A, B, Bp, App, sigma8, sigma6, sigma5, sigma2, sigma1;
        
        witness_alpha := WitnessPairForBeingCongruentToZero( CokernelProjection( alpha ) );
        
        sigma78 := witness_alpha[1];
        
        sigma56 := witness_alpha[2];
        
        witness_test := WitnessPairForBeingCongruentToZero( PreCompose( KernelEmbedding( alpha ), tau ) );
        
        sigma12 := witness_test[2];
        
        range_alpha := Range( alpha );
        
        b2 := CorelationMorphism( range_alpha );
        
        datum_tau := MorphismDatum( tau );
        
        A := Source( datum_tau );
        
        B := Source( b2 );
        
        Bp := Source( RelationMorphism( range_alpha) );
        
        App := Range( CorelationMorphism( Source( alpha ) ) );
        
        sigma8 := ComponentOfMorphismIntoDirectSum( sigma78, [ Bp, A ] , 2 );
        
        sigma6 := ComponentOfMorphismIntoDirectSum( sigma56, [ B, App ] , 2 );
        
        sigma5 := ComponentOfMorphismIntoDirectSum( sigma56, [ B, App ] , 1 );
        
        sigma2 := ComponentOfMorphismFromDirectSum( sigma12, [ App, B ], 2 );
        
        sigma1 := ComponentOfMorphismFromDirectSum( sigma12, [ App, B ], 1 );
        
        return AdelmanCategoryMorphism( range_alpha,
                                        PreCompose( sigma8, datum_tau ) + PreCompose( [ b2, sigma6, sigma1 ] ) + PreCompose( [ b2, sigma5, sigma2 ] ),
                                        Range( tau ) );
        
    end );
    
    ##
    AddKernelEmbedding( category,
      
      function( morphism )
        local source, range, a, ap, alpha, b, Bp, App, A, kernel_object;
        
        source := Source( morphism );
        
        range := Range( morphism );
        
        a := RelationMorphism( source );
        
        ap := CorelationMorphism( source );
        
        alpha := MorphismDatum( morphism );
        
        b := RelationMorphism( range );
        
        Bp := Source( b );
        
        App := Range( ap );
        
        A := Source( alpha );
        
        kernel_object :=
            AdelmanCategoryObject(
                DirectSumFunctorial( [ a, IdentityMorphism( Bp ) ] ),
                MorphismBetweenDirectSums( [ [ ap, alpha ], [ ZeroMorphism( Bp, App ), b ] ] )
            );
        
        return AdelmanCategoryMorphism( 
            kernel_object,
            ProjectionInFactorOfDirectSum( [ A, Bp ], 1 ),
            Source( morphism )
        );
        
    end );
    
    ##
    AddKernelLiftWithGivenKernelObject( category,
      
      function( morphism, test_morphism, kernel_object )
        local witness_pair, datum;
        
        witness_pair := WitnessPairForBeingCongruentToZero( PreCompose( test_morphism, morphism ) );
        
        datum :=
            UniversalMorphismIntoDirectSum(
                [ MorphismDatum( test_morphism ), -witness_pair[1] ]
            );
        
        return AdelmanCategoryMorphism( Source( test_morphism ),
                                        datum,
                                        kernel_object );
        
    end );
    
    ##
    AddEpimorphismFromSomeProjectiveObject( category,
        function( obj )
        local proj, rel, A;
        
        rel := CorelationMorphism( obj );
        
        A := Source( rel );
        
        proj := AdelmanCategoryObject( MorphismFromZeroObject( A ), rel );
        
        return AdelmanCategoryMorphism(
            proj,
            IdentityMorphism( A ),
            obj
        );
        
    end );
    
    ##
    AddMonomorphismIntoSomeInjectiveObject( category,
        function( obj )
        local inj, rel, B;
        
        rel := RelationMorphism( obj );
        
        B := Range( rel );
        
        inj := AdelmanCategoryObject( rel, MorphismIntoZeroObject( B ) );
        
        return AdelmanCategoryMorphism(
            obj,
            IdentityMorphism( B ),
            inj
        );
        
    end );
    
    ## Creation of a homomorphism structure for the Freyd category
    
    if ForAll( [ "DistinguishedObjectOfHomomorphismStructure" ], 
               f -> CanCompute( underlying_category, f ) ) then
        
        distinguished_object := DistinguishedObjectOfHomomorphismStructure( underlying_category );
            
        range_category := CapCategory( distinguished_object );
        
        
        ## 3 possible cases:
        ## 1) the range category is abelian
        ## 2) one could apply the Freyd category constructor to the range category to make it abelian
        ## 3) else
        
        if HasIsAbelianCategory( range_category ) 
           and IsAbelianCategory( range_category ) 
           and HasIsProjective( distinguished_object )
           and IsProjective( distinguished_object ) then
            
            SetRangeCategoryOfHomomorphismStructure( category, range_category );
            
            homomorphism_structure_derivation_case := "abelian";
            
            homomorphism_structure_on_morphisms := HomomorphismStructureOnMorphisms;
            
            distinguished_object := distinguished_object;
            
            interpret_homomorphism_as_morphism_from_distinguished_object_to_homomorphism_structure :=
                InterpretMorphismAsMorphismFromDinstinguishedObjectToHomomorphismStructure;
            
            interpret_morphism_from_distinguished_object_to_homomorphism_structure_as_homomorphism := 
                InterpretMorphismFromDinstinguishedObjectToHomomorphismStructureAsMorphism;
            
        elif  HasIsAdditiveCategory( range_category )
               and IsAdditiveCategory( range_category )
               and ForAll(
                   [ "Lift",
                     "SubtractionForMorphisms",
                     "PreCompose",
                     "Lift",
                     "ProjectionOfBiasedWeakFiberProduct",
                     "UniversalMorphismIntoBiasedWeakFiberProduct"
                      ],
                   f -> CanCompute( range_category, f ) )  then
            
            SetRangeCategoryOfHomomorphismStructure( category, FreydCategory( range_category ) );
            
            homomorphism_structure_derivation_case := "apply_freyd";
            
            homomorphism_structure_on_morphisms := 
              function( alpha, beta )
                
                return AsFreydCategoryMorphism( HomomorphismStructureOnMorphisms( alpha, beta ) );
                
            end;
            
            distinguished_object := AsFreydCategoryObject( distinguished_object );
            
            interpret_homomorphism_as_morphism_from_distinguished_object_to_homomorphism_structure :=
              function( alpha )
                return AsFreydCategoryMorphism( InterpretMorphismAsMorphismFromDinstinguishedObjectToHomomorphismStructure( alpha ) );
            end;
            
            interpret_morphism_from_distinguished_object_to_homomorphism_structure_as_homomorphism := 
              function( a, b, morphism )
                return InterpretMorphismFromDinstinguishedObjectToHomomorphismStructureAsMorphism( a, b, MorphismDatum( morphism ) );
            end;
            
        else 
            
            homomorphism_structure_derivation_case := "none";
            
        fi;
        
        if homomorphism_structure_derivation_case <> "none" then
            
            ##
            InstallMethodWithCacheFromObject( HomomorphismStructureOnObjectsForAdelmanCategoryGeneralizedEmbedding, 
                                              [ IsAdelmanCategoryObject and ObjectFilter( category ), IsAdelmanCategoryObject and ObjectFilter( category ) ],
                function( object_A, object_B )
                  local A, Ap, App, B, Bp, Bpp, a, b, ap, bp, 
                        H_A_b, H_ap_B, H_A_bp, H_a_B, H_ap_Bpp, H_Ap_b, rel, corel, ker, coker, im;
                  
                  a := RelationMorphism( object_A );
                  
                  ap := CorelationMorphism( object_A );
                  
                  b := RelationMorphism( object_B );
                  
                  bp := CorelationMorphism( object_B );
                  
                  A := Range( a );
                  
                  Ap := Source( a );
                  
                  App := Range( ap );
                  
                  B := Range( b );
                  
                  Bp := Source( b );
                  
                  Bpp := Range( bp );
                  
                  H_A_b := homomorphism_structure_on_morphisms( IdentityMorphism( A ), b );

                  H_ap_B := homomorphism_structure_on_morphisms( ap, IdentityMorphism( B ) );

                  H_A_bp := homomorphism_structure_on_morphisms( IdentityMorphism( A ), bp );

                  H_a_B := homomorphism_structure_on_morphisms( a, IdentityMorphism( B ) );

                  H_ap_Bpp := homomorphism_structure_on_morphisms( ap, IdentityMorphism( Bpp ) );

                  H_Ap_b := homomorphism_structure_on_morphisms( IdentityMorphism( Ap ), b );
                  
                  rel := UniversalMorphismFromDirectSum( [ H_A_b, H_ap_B ] );
                  
                  corel := UniversalMorphismIntoDirectSum( [ 
                      PreCompose( H_A_bp, CokernelProjection( H_ap_Bpp ) ),
                      PreCompose( H_a_B, CokernelProjection( H_Ap_b ) )
                  ] );
                  
                  ker := KernelEmbedding( corel );
                  
                  coker := CokernelProjection( rel );
                  
                  im := CoastrictionToImage( PreCompose( ker, coker ) );
                  
                  return GeneralizedMorphismBySpan( im, ker );
                  
            end );
            
            ##
            AddHomomorphismStructureOnObjects( category,
              function( object_A, object_B )
                
                return UnderlyingHonestObject( Source( HomomorphismStructureOnObjectsForAdelmanCategoryGeneralizedEmbedding( object_A, object_B ) ) );
                
            end );
            
            ##
            AddHomomorphismStructureOnMorphismsWithGivenObjects( category,
              function( source, mor_alpha, mor_beta, range )
                local alpha, beta, H_alpha_beta, composition;
                
                alpha := MorphismDatum( mor_alpha );
                
                beta := MorphismDatum( mor_beta );
                
                H_alpha_beta := homomorphism_structure_on_morphisms( alpha, beta );
                
                composition :=
                    PreCompose( [ 
                        HomomorphismStructureOnObjectsForAdelmanCategoryGeneralizedEmbedding( Range( mor_alpha ), Source( mor_beta ) ),
                        AsGeneralizedMorphismBySpan( H_alpha_beta ),
                        PseudoInverse( HomomorphismStructureOnObjectsForAdelmanCategoryGeneralizedEmbedding( Source( mor_alpha ), Range( mor_beta ) ) )
                    ] );
                
                return HonestRepresentative( composition );
                
            end );
            
             ##
            AddDistinguishedObjectOfHomomorphismStructure( category,
              function( cat )
                
                return distinguished_object;
                
            end );
            
            ##
            AddInterpretMorphismAsMorphismFromDinstinguishedObjectToHomomorphismStructure( category,
              function( mor_alpha )
                local object_A, object_B, A, B, gen, arrow, reversed, alpha, interpret;
                
                object_A := Source( mor_alpha );
                
                object_B := Range( mor_alpha );
                
                A := Range( RelationMorphism( object_A ) );
                
                B := Range( RelationMorphism( object_B ) );
                
                gen := HomomorphismStructureOnObjectsForAdelmanCategoryGeneralizedEmbedding( object_A, object_B );
                
                arrow := Arrow( gen );
                
                reversed := ReversedArrow( gen );
                
                alpha := MorphismDatum( mor_alpha );
                
                interpret := interpret_homomorphism_as_morphism_from_distinguished_object_to_homomorphism_structure( alpha );
                
                return PreCompose( LiftAlongMonomorphism( arrow, interpret ), reversed );
                
            end );
            
            ##
            AddInterpretMorphismFromDinstinguishedObjectToHomomorphismStructureAsMorphism( category,
              function( object_A, object_B, morphism )
                local gen, arrow, reversed, lift, A, B, interpret;
                
                gen := HomomorphismStructureOnObjectsForAdelmanCategoryGeneralizedEmbedding( object_A, object_B );
                
                arrow := Arrow( gen );
                
                reversed := ReversedArrow( gen );
                
                lift := PreCompose( Lift( morphism, reversed ), arrow );
                
                A := Range( RelationMorphism( object_A ) );
                
                B := Range( RelationMorphism( object_B ) );
                
                interpret := interpret_morphism_from_distinguished_object_to_homomorphism_structure_as_homomorphism( A, B, lift );
                
                return AdelmanCategoryMorphism( object_A, interpret, object_B );
                
            end );
            
        fi;
        
    fi;
    
end );

####################################
##
## View
##
####################################

##
InstallMethod( Display,
               [ IsAdelmanCategoryMorphism ],
               
  function( morphism )
    
    Print( "Morphism datum:\n" );
    
    Display( MorphismDatum( morphism ) );
    
end );


##
InstallMethod( Display,
               [ IsAdelmanCategoryObject ],
               
  function( object )
    
    Print( "Relation morphism:\n" );
    
    Display( RelationMorphism( object ) );
    
    Print( "\n--------------------\n" );
    
    Print( "Corelation morphism:\n" );
    
    Display( CorelationMorphism( object ) );
    
end );
