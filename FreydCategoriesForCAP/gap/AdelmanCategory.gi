# SPDX-License-Identifier: GPL-2.0-or-later
# FreydCategoriesForCAP: Freyd categories - Formal (co)kernels for additive categories
#
# Implementations
#

####################################
##
## Constructors
##
####################################

##
InstallMethod( AdelmanCategory,
               [ IsCapCategory ],

  FunctionWithNamedArguments(
  [
    [ "FinalizeCategory", true ],
  ],
  function( CAP_NAMED_ARGUMENTS, underlying_category )
    local adelman_category, func;
    
    if not HasIsAdditiveCategory( underlying_category ) then
        
        Error( "The given category should be additive" );
        
    fi;
    
    for func in [ "Lift", "IsLiftable", "Colift", "IsColiftable", "SubtractionForMorphisms", "AdditionForMorphisms", "PreCompose", "IdentityMorphism" ] do
        
        if not CanCompute( underlying_category, func ) then
            
            Error( "The given category should be able to compute ", func );
            
        fi;
        
    od;
    
    if not CanCompute( underlying_category, "SolveLinearSystemInAbCategory" ) then
        
        Info( InfoFreydCategoriesForCAP, 2, "Warning: the constructed Adelman category cannot decide congruence for morphisms" );
        
    fi;
    
    adelman_category := CreateCapCategory( Concatenation( "Adelman category( ", Name( underlying_category ), " )" ), IsAdelmanCategory, IsAdelmanCategoryObject, IsAdelmanCategoryMorphism, IsCapCategoryTwoCell );
    
    adelman_category!.compiler_hints := rec(
        category_attribute_names := [
            "UnderlyingCategory",
        ],
    );
    
    ## this is the purpose of the Adelman category
    SetIsAbelianCategory( adelman_category, true );
    
    SetIsLocallyOfFiniteProjectiveDimension( adelman_category, true );
    SetIsLocallyOfFiniteInjectiveDimension( adelman_category, true );
    
    SetUnderlyingCategory( adelman_category, underlying_category );
    
    if HasIsLinearCategoryOverCommutativeRing( underlying_category ) and
       IsLinearCategoryOverCommutativeRing( underlying_category ) and
       HasCommutativeRingOfLinearCategory( underlying_category ) then
      
      SetIsLinearCategoryOverCommutativeRing( adelman_category, true );
      
      SetCommutativeRingOfLinearCategory( adelman_category, CommutativeRingOfLinearCategory( underlying_category ) );
       
    fi;
    
    DisableAddForCategoricalOperations( adelman_category );
    
    INSTALL_FUNCTIONS_FOR_ADELMAN_CATEGORY( adelman_category );
    
    HandlePrecompiledTowers( adelman_category, underlying_category, "AdelmanCategory" );
    
    if CAP_NAMED_ARGUMENTS.FinalizeCategory then
        
        Finalize( adelman_category );
        
    fi;
    
    return adelman_category;
    
end ) );


##
InstallMethod( AdelmanCategoryObject,
               [ IsCapCategoryMorphism, IsCapCategoryMorphism ],

  function( relation_morphism, corelation_morphism )
    
    return AdelmanCategoryObject( AdelmanCategory( CapCategory( relation_morphism ) ), relation_morphism, corelation_morphism );
    
end );

##
InstallOtherMethodForCompilerForCAP( AdelmanCategoryObject,
                                     [ IsAdelmanCategory, IsCapCategoryMorphism, IsCapCategoryMorphism ],
                                     
  function( category, relation_morphism, corelation_morphism )
    
    if not IsEqualForObjects( Range( relation_morphism ), Source( corelation_morphism ) ) then
    
        Error( "the range of the relation morphism has to be equal to the source of the co-relation morphism" );
    
    fi;
    
    return CreateCapCategoryObjectWithAttributes( category,
                                                  RelationMorphism, relation_morphism,
                                                  CorelationMorphism, corelation_morphism );
    
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
    
    return AdelmanCategoryMorphism( CapCategory( source ), source, morphism_datum, range );
    
end );

##
InstallOtherMethodForCompilerForCAP( AdelmanCategoryMorphism,
                                     [ IsAdelmanCategory, IsAdelmanCategoryObject, IsCapCategoryMorphism, IsAdelmanCategoryObject ],
                                     
  function( category, source, morphism_datum, range )
    local adelman_category_morphism;
    
    if not IsIdenticalObj( CapCategory( morphism_datum ), UnderlyingCategory( CapCategory( source ) ) ) then
        
        Error( "The underlying category of the given morphism datum is not identical to the underlying category of the given source" );
        
    fi;
    
    if not IsEqualForObjects( Source( morphism_datum ), Source( CorelationMorphism( source ) ) ) then
        
        Error( "The source of the given morphism datum is not equal to the source of the co-relation morphism of the given source object" );
        
    fi;
    
    if not IsEqualForObjects( Range( morphism_datum ), Source( CorelationMorphism( range ) ) ) then
        
        Error( "The range of the given morphism datum is not equal to the source of the co-relation morphism of the given range object" );
        
    fi;
    
    adelman_category_morphism := CreateCapCategoryMorphismWithAttributes( category,
                                                                          source,
                                                                          range,
                                                                          UnderlyingMorphism, morphism_datum );
    
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

##
# backwards compatibility
InstallOtherMethod( MorphismDatum,
                    [ IsAdelmanCategoryMorphism ],
                    
  function( morphism )
    
    return UnderlyingMorphism( morphism );
    
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
    
    return Lift( PreCompose( RelationMorphism( Source( morphism ) ), UnderlyingMorphism( morphism ) ), RelationMorphism( Range( morphism ) ) );
    
end );

##
InstallMethod( CorelationWitness,
               [ IsAdelmanCategoryMorphism ],
               
  function( morphism )
    
    return Colift( CorelationMorphism( Source( morphism ) ), PreCompose( UnderlyingMorphism( morphism ), CorelationMorphism( Range( morphism ) ) ) );
    
end );

##
InstallMethod( WitnessPairForBeingCongruentToZero,
               [ IsAdelmanCategoryMorphism ],
               
  function( morphism )
    local datum, left_coeffs, right_coeffs;
    
    datum := UnderlyingMorphism( morphism );
    
    left_coeffs :=
        [ [ IdentityMorphism( Source( datum ) ), CorelationMorphism( Source( morphism ) ) ] ];
    
    right_coeffs :=
        [ [ RelationMorphism( Range( morphism ) ), IdentityMorphism( Range( datum ) ) ] ];
    
    return SolveLinearSystemInAbCategory( left_coeffs, right_coeffs, [ datum ] );
    
end );

##
InstallMethod( MereExistenceOfWitnessPairForBeingCongruentToZero,
               [ IsAdelmanCategoryMorphism ],
               
  function( morphism )
    
    return MereExistenceOfWitnessPairForBeingCongruentToZero( CapCategory( morphism ), morphism );
    
end );

##
InstallOtherMethodForCompilerForCAP( MereExistenceOfWitnessPairForBeingCongruentToZero,
                                     [ IsAdelmanCategory, IsAdelmanCategoryMorphism ],
                                     
  function( cat, morphism )
    local datum, left_coeffs, right_coeffs;
    
    datum := UnderlyingMorphism( morphism );
    
    left_coeffs :=
        [ [ IdentityMorphism( UnderlyingCategory( cat ), Source( datum ) ), CorelationMorphism( Source( morphism ) ) ] ];
    
    right_coeffs :=
        [ [ RelationMorphism( Range( morphism ) ), IdentityMorphism( UnderlyingCategory( cat ), Range( datum ) ) ] ];
    
    return MereExistenceOfSolutionOfLinearSystemInAbCategory( UnderlyingCategory( cat ), left_coeffs, right_coeffs, [ datum ] );
    
end );

##
InstallMethod( IsSequenceAsAdelmanCategoryObject,
               [ IsAdelmanCategoryObject ],
               
  function( object )
    
    return IsZeroForMorphisms( PreCompose( RelationMorphism( object ), CorelationMorphism( object ) ) );
    
end );

####################################
##
## Basic operations
##
####################################

InstallGlobalFunction( INSTALL_FUNCTIONS_FOR_ADELMAN_CATEGORY,

  function( category )
    local underlying_category, range_category, underlying_distinguished_object, homomorphism_structure_derivation_case,
          homomorphism_structure_on_morphisms, distinguished_object, interpret_homomorphism_as_morphism_from_distinguished_object_to_homomorphism_structure,
          interpret_morphism_from_distinguished_object_to_homomorphism_structure_as_homomorphism;
    
    underlying_category := UnderlyingCategory( category );
    
    ## Well-defined for objects and morphisms
    ##
    AddIsWellDefinedForObjects( category,
      function( cat, object )
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
      function( cat, morphism )
        
        if not IsLiftable( PreCompose( RelationMorphism( Source( morphism ) ), UnderlyingMorphism( morphism ) ), RelationMorphism( Range( morphism ) ) ) then
            
            return false;
            
        fi;
        
        if not IsColiftable( CorelationMorphism( Source( morphism ) ), PreCompose( UnderlyingMorphism( morphism ), CorelationMorphism( Range( morphism ) ) ) ) then
            
            return false;
            
        fi;
        
        # all tests passed, so it is well-defined
        return true;
        
    end );
    
    ## Equality Basic Operations for Objects and Morphisms
    ##
    AddIsEqualForObjects( category,
      function( cat, object_1, object_2 )
        
        return IsEqualForMorphismsOnMor( RelationMorphism( object_1 ), RelationMorphism( object_2 ) ) and
               IsEqualForMorphismsOnMor( CorelationMorphism( object_1 ), CorelationMorphism( object_2 ) );
        
    end );
    
    ##
    AddIsEqualForMorphisms( category,
      function( cat, morphism_1, morphism_2 )
        
        return IsEqualForMorphisms( UnderlyingMorphism( morphism_1 ), UnderlyingMorphism( morphism_2 ) );
        
    end );
    
    ##
    AddIsCongruentForMorphisms( category,
      function( cat, morphism_1, morphism_2 )
        
        return MereExistenceOfWitnessPairForBeingCongruentToZero( cat, SubtractionForMorphisms( cat, morphism_1, morphism_2 ) );
        
    end );
    
    ##
    AddIsZeroForMorphisms( category,
      function( cat, morphism )
        
        return MereExistenceOfWitnessPairForBeingCongruentToZero( cat, morphism );
        
    end );
    
    ## Basic Operations for a Category
    ##
    AddIdentityMorphism( category,
      
      function( cat, object )
        
        return AdelmanCategoryMorphism( cat, object, IdentityMorphism( Range( RelationMorphism( object ) ) ), object );
        
    end );
    
    ##
    AddPreCompose( category,
      
      function( cat, morphism_1, morphism_2 )
        local composition;
        
        composition := PreCompose( UnderlyingCategory( cat ), UnderlyingMorphism( morphism_1 ), UnderlyingMorphism( morphism_2 ) );
        
        return AdelmanCategoryMorphism( cat, Source( morphism_1 ), composition, Range( morphism_2 ) );
        
    end );

    ##
    AddSubtractionForMorphisms( category,
      function( cat, morphism_1, morphism_2 )
        local subtraction;
        
        subtraction := AdelmanCategoryMorphism( cat,
                            Source( morphism_1 ),
                            SubtractionForMorphisms( UnderlyingCategory( cat ), UnderlyingMorphism( morphism_1 ), UnderlyingMorphism( morphism_2 ) ),
                            Range( morphism_1 )
                        );
        
        return subtraction;
        
    end );
    
    ##
    AddAdditionForMorphisms( category,
      function( cat, morphism_1, morphism_2 )
        local addition;
        
        addition := AdelmanCategoryMorphism( cat,
                            Source( morphism_1 ),
                            AdditionForMorphisms( UnderlyingMorphism( morphism_1 ), UnderlyingMorphism( morphism_2 ) ),
                            Range( morphism_1 )
                        );
        
        return addition;
        
    end );
    
    ##
    AddAdditiveInverseForMorphisms( category,
      function( cat, morphism )
        local additive_inverse;
        
        additive_inverse := AdelmanCategoryMorphism( cat,
                              Source( morphism ),
                              AdditiveInverseForMorphisms( UnderlyingMorphism( morphism ) ),
                              Range( morphism )
                            );
        
        return additive_inverse;
        
    end );
    
    ##
    AddZeroMorphism( category,
      function( cat, source, range )
        local zero_morphism;
        
        zero_morphism := AdelmanCategoryMorphism( cat,
                           source,
                           ZeroMorphism( Range( RelationMorphism( source ) ), Range( RelationMorphism( range ) ) ),
                           range
                         );
        
        return zero_morphism;
        
    end );
    
    ##
    AddZeroObject( category,
      function( cat )
        
        return AsAdelmanCategoryObject( ZeroObject( underlying_category) );
        
    end );
    
    ##
    AddUniversalMorphismIntoZeroObjectWithGivenZeroObject( category,
      function( cat, sink, zero_object )
        local universal_morphism;
        
        universal_morphism := AdelmanCategoryMorphism( cat,
                                sink,
                                UniversalMorphismIntoZeroObject( Range( RelationMorphism( sink ) ) ),
                                zero_object
                              );
        
        return universal_morphism;
        
    end );
    
    ##
    AddUniversalMorphismFromZeroObjectWithGivenZeroObject( category,
      function( cat, source, zero_object )
        local universal_morphism;
        
        universal_morphism := AdelmanCategoryMorphism( cat,
                                zero_object,
                                UniversalMorphismFromZeroObject( Range( RelationMorphism( source ) ) ),
                                source
                              );
        
        return universal_morphism;
        
    end );
    
    ##
    AddDirectSum( category,
      function( cat, object_list )
        
        return AdelmanCategoryObject( cat, DirectSumFunctorial( List( object_list, RelationMorphism ) ),
                                      DirectSumFunctorial( List( object_list, CorelationMorphism ) ) );
        
    end );
    
    ##
    AddDirectSumFunctorialWithGivenDirectSums( category,
      function( cat, direct_sum_source, source_diagram, diagram, range_diagram, direct_sum_range )
        
        return AdelmanCategoryMorphism( cat, direct_sum_source,
                                        DirectSumFunctorial( List( diagram, UnderlyingMorphism ) ),
                                        direct_sum_range );
        
    end );
    
    ##
    AddProjectionInFactorOfDirectSumWithGivenDirectSum( category,
      function( cat, object_list, projection_number, direct_sum_object )
        
        return AdelmanCategoryMorphism( cat, direct_sum_object,
                                        ProjectionInFactorOfDirectSum( List( object_list, obj -> Range( RelationMorphism( obj ) ) ), projection_number ),
                                        object_list[projection_number]
                                      );
        
    end );
    
    ##
    AddUniversalMorphismIntoDirectSumWithGivenDirectSum( category,
      function( cat, diagram, test_object, source, direct_sum_object )
        
        return AdelmanCategoryMorphism( cat, Source( source[1] ),
                                        UniversalMorphismIntoDirectSum( List( diagram, obj -> Range( RelationMorphism( obj ) ) ),
                                                                        List( source, mor -> UnderlyingMorphism( mor ) ) ),
                                        direct_sum_object
                                      );
        
    end );
    
    ##
    AddInjectionOfCofactorOfDirectSumWithGivenDirectSum( category,
      function( cat, object_list, injection_number, direct_sum_object )
        
        return AdelmanCategoryMorphism( cat, object_list[injection_number],
                                        InjectionOfCofactorOfDirectSum( List( object_list, obj -> Range( RelationMorphism( obj ) ) ), injection_number ),
                                        direct_sum_object
                                      );
        
    end );
    
    ##
    AddUniversalMorphismFromDirectSumWithGivenDirectSum( category,
      function( cat, diagram, test_object, sink, direct_sum_object )
        
        return AdelmanCategoryMorphism( cat, direct_sum_object,
                                        UniversalMorphismFromDirectSum( List( diagram, obj -> Range( RelationMorphism( obj ) ) ),
                                                                        List( sink, mor -> UnderlyingMorphism( mor ) ) ),
                                        Range( sink[1] )
                                      );
        
    end );
    
    ##
    AddCokernelProjection( category,
                     
      function( cat, morphism )
        local source, range, b, bp, ap, B, Bp, App, alpha, cokernel_object;
        
        source := Source( morphism );
        
        range := Range( morphism );
        
        b := RelationMorphism( range );
        
        bp := CorelationMorphism( range );
        
        ap := CorelationMorphism( source );
        
        B := Range( b );
        
        Bp := Source( b );
        
        App := Range( ap );
        
        alpha := UnderlyingMorphism( morphism );
        
        cokernel_object :=
            AdelmanCategoryObject( cat,
                MorphismBetweenDirectSums( UnderlyingCategory( cat ), [ Bp, Source( ap ) ], [ [ b, ZeroMorphism( UnderlyingCategory( cat ), Bp, App ) ], [ alpha, ap ] ], [ B, App ] ),
                DirectSumFunctorial( UnderlyingCategory( cat ), [ bp, IdentityMorphism( UnderlyingCategory( cat ), App ) ] )
            );
        
        return AdelmanCategoryMorphism( cat,
            Range( morphism ),
            InjectionOfCofactorOfDirectSum( UnderlyingCategory( cat ), [ B, App ], 1 ),
            cokernel_object
        );
        
    end );
    
    ##
    AddCokernelColiftWithGivenCokernelObject( category,
      
      function( cat, morphism, test_object, test_morphism, cokernel_object )
        local witness_pair, datum;
        
        witness_pair := WitnessPairForBeingCongruentToZero( PreCompose( morphism, test_morphism ) );
        
        datum :=
            UniversalMorphismFromDirectSum(
                [ UnderlyingMorphism( test_morphism ), -witness_pair[2] ]
            );
        
        return AdelmanCategoryMorphism( cat, cokernel_object,
                                        datum,
                                        Range( test_morphism ) );
        
    end );
    
    ##
    AddColiftAlongEpimorphism( category,
      
      function( cat, alpha, tau )
        local witness_alpha, sigma78, sigma56, witness_test, sigma12, range_alpha, b2, datum_tau, A, B, Bp, App, sigma8, sigma6, sigma5, sigma2, sigma1;
        
        witness_alpha := WitnessPairForBeingCongruentToZero( CokernelProjection( alpha ) );
        
        sigma78 := witness_alpha[1];
        
        sigma56 := witness_alpha[2];
        
        witness_test := WitnessPairForBeingCongruentToZero( PreCompose( KernelEmbedding( alpha ), tau ) );
        
        sigma12 := witness_test[2];
        
        range_alpha := Range( alpha );
        
        b2 := CorelationMorphism( range_alpha );
        
        datum_tau := UnderlyingMorphism( tau );
        
        A := Source( datum_tau );
        
        B := Source( b2 );
        
        Bp := Source( RelationMorphism( range_alpha) );
        
        App := Range( CorelationMorphism( Source( alpha ) ) );
        
        sigma8 := ComponentOfMorphismIntoDirectSum( sigma78, [ Bp, A ] , 2 );
        
        sigma6 := ComponentOfMorphismIntoDirectSum( sigma56, [ B, App ] , 2 );
        
        sigma5 := ComponentOfMorphismIntoDirectSum( sigma56, [ B, App ] , 1 );
        
        sigma2 := ComponentOfMorphismFromDirectSum( sigma12, [ App, B ], 2 );
        
        sigma1 := ComponentOfMorphismFromDirectSum( sigma12, [ App, B ], 1 );
        
        return AdelmanCategoryMorphism( cat, range_alpha,
                                        PreCompose( sigma8, datum_tau ) + PreCompose( [ b2, sigma6, sigma1 ] ) + PreCompose( [ b2, sigma5, sigma2 ] ),
                                        Range( tau ) );
        
    end );
    
    ##
    AddKernelEmbedding( category,
      
      function( cat, morphism )
        local source, range, a, ap, alpha, b, Bp, App, A, kernel_object;
        
        source := Source( morphism );
        
        range := Range( morphism );
        
        a := RelationMorphism( source );
        
        ap := CorelationMorphism( source );
        
        alpha := UnderlyingMorphism( morphism );
        
        b := RelationMorphism( range );
        
        Bp := Source( b );
        
        App := Range( ap );
        
        A := Source( alpha );
        
        kernel_object :=
            AdelmanCategoryObject( cat,
                DirectSumFunctorial( [ a, IdentityMorphism( Bp ) ] ),
                MorphismBetweenDirectSums( [ [ ap, alpha ], [ ZeroMorphism( Bp, App ), b ] ] )
            );
        
        return AdelmanCategoryMorphism( cat,
            kernel_object,
            ProjectionInFactorOfDirectSum( [ A, Bp ], 1 ),
            Source( morphism )
        );
        
    end );
    
    ##
    AddKernelLiftWithGivenKernelObject( category,
      
      function( cat, morphism, test_object, test_morphism, kernel_object )
        local witness_pair, datum;
        
        witness_pair := WitnessPairForBeingCongruentToZero( PreCompose( test_morphism, morphism ) );
        
        datum :=
            UniversalMorphismIntoDirectSum(
                [ UnderlyingMorphism( test_morphism ), -witness_pair[1] ]
            );
        
        return AdelmanCategoryMorphism( cat, Source( test_morphism ),
                                        datum,
                                        kernel_object );
        
    end );
    
    ##
    AddEpimorphismFromSomeProjectiveObject( category,
        function( cat, obj )
        local proj, rel, A;
        
        rel := CorelationMorphism( obj );
        
        A := Source( rel );
        
        proj := AdelmanCategoryObject( cat, MorphismFromZeroObject( A ), rel );
        
        return AdelmanCategoryMorphism( cat,
            proj,
            IdentityMorphism( A ),
            obj
        );
        
    end );
    
    ##
    AddMonomorphismIntoSomeInjectiveObject( category,
        function( cat, obj )
        local inj, rel, B;
        
        rel := RelationMorphism( obj );
        
        B := Range( rel );
        
        inj := AdelmanCategoryObject( cat, rel, MorphismIntoZeroObject( B ) );
        
        return AdelmanCategoryMorphism( cat,
            obj,
            IdentityMorphism( B ),
            inj
        );
        
    end );
    
    if ForAll( [ "MultiplyWithElementOfCommutativeRingForMorphisms" ],
               f -> CanCompute( underlying_category, f ) ) then
        
        AddMultiplyWithElementOfCommutativeRingForMorphisms( category,
          { cat, r, alpha } -> AdelmanCategoryMorphism( cat,
                              Source( alpha ),
                              MultiplyWithElementOfCommutativeRingForMorphisms( r, UnderlyingMorphism( alpha ) ),
                              Range( alpha )
                            )
        );
    
    fi;
    
    ## Creation of a homomorphism structure for the Freyd category
    
    if ForAll( [ "DistinguishedObjectOfHomomorphismStructure" ],
               f -> CanCompute( underlying_category, f ) ) then
        
        range_category := RangeCategoryOfHomomorphismStructure( underlying_category );
        
        underlying_distinguished_object := DistinguishedObjectOfHomomorphismStructure( underlying_category );
        
        ## 3 possible cases:
        ## 1) the range category is abelian
        ## 2) one could apply the Freyd category constructor to the range category to make it abelian
        ## 3) else
        
        if HasIsAbelianCategory( range_category ) and
           IsAbelianCategory( range_category ) and
           (HasIsProjective( underlying_distinguished_object ) or (CanCompute( range_category, "IsProjective" ) and OperationWeight( range_category, "IsProjective" ) <= 50)) and
           IsProjective( underlying_distinguished_object ) then
            
            SetRangeCategoryOfHomomorphismStructure( category, range_category );
            SetIsEquippedWithHomomorphismStructure( category, true );
            
            homomorphism_structure_derivation_case := "abelian";
            
            homomorphism_structure_on_morphisms := HomomorphismStructureOnMorphisms;
            
            distinguished_object := cat -> underlying_distinguished_object;
            
            interpret_homomorphism_as_morphism_from_distinguished_object_to_homomorphism_structure :=
                InterpretMorphismAsMorphismFromDistinguishedObjectToHomomorphismStructure;
            
            interpret_morphism_from_distinguished_object_to_homomorphism_structure_as_homomorphism := 
                InterpretMorphismFromDistinguishedObjectToHomomorphismStructureAsMorphism;
            
        elif  HasIsAdditiveCategory( range_category ) and
              IsAdditiveCategory( range_category ) and
              ForAll(
                   [ "Lift",
                     "SubtractionForMorphisms",
                     "PreCompose",
                     "Lift",
                     "ProjectionOfBiasedWeakFiberProduct",
                     "UniversalMorphismIntoBiasedWeakFiberProduct"
                      ],
                   f -> CanCompute( range_category, f ) )  then
            
            SetRangeCategoryOfHomomorphismStructure( category, FreydCategory( range_category ) );
            SetIsEquippedWithHomomorphismStructure( category, true );
            
            homomorphism_structure_derivation_case := "apply_freyd";
            
            homomorphism_structure_on_morphisms := 
              function( alpha, beta )
                
                return AsFreydCategoryMorphism( HomomorphismStructureOnMorphisms( alpha, beta ) );
                
            end;
            
            distinguished_object := cat -> AsFreydCategoryObject( underlying_distinguished_object );
            
            interpret_homomorphism_as_morphism_from_distinguished_object_to_homomorphism_structure :=
              function( alpha )
                return AsFreydCategoryMorphism( InterpretMorphismAsMorphismFromDistinguishedObjectToHomomorphismStructure( alpha ) );
            end;
            
            interpret_morphism_from_distinguished_object_to_homomorphism_structure_as_homomorphism := 
              function( a, b, morphism )
                return InterpretMorphismFromDistinguishedObjectToHomomorphismStructureAsMorphism( a, b, UnderlyingMorphism( morphism ) );
            end;
            
        else 
            
            homomorphism_structure_derivation_case := "none";
            
        fi;
        
        if homomorphism_structure_derivation_case <> "none" then
            
            ##
            # this is expensive, so we assume a weight of 400 which will be used below
            InstallMethodWithCacheFromObject( HomomorphismStructureOnObjectsForAdelmanCategoryGeneralizedEmbedding,
                                              [ ObjectFilter( category ), ObjectFilter( category ) ],
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
              function( cat, object_A, object_B )
                
                return UnderlyingHonestObject( Source( HomomorphismStructureOnObjectsForAdelmanCategoryGeneralizedEmbedding( object_A, object_B ) ) );
                
            end, 100 + 400 );
            
            ##
            AddHomomorphismStructureOnMorphisms( category,
              function( cat, mor_alpha, mor_beta )
                local alpha, beta, H_alpha_beta, composition;
                
                alpha := UnderlyingMorphism( mor_alpha );
                
                beta := UnderlyingMorphism( mor_beta );
                
                H_alpha_beta := homomorphism_structure_on_morphisms( alpha, beta );
                
                composition :=
                    PreCompose( [ 
                        HomomorphismStructureOnObjectsForAdelmanCategoryGeneralizedEmbedding( Range( mor_alpha ), Source( mor_beta ) ),
                        AsGeneralizedMorphismBySpan( H_alpha_beta ),
                        PseudoInverse( HomomorphismStructureOnObjectsForAdelmanCategoryGeneralizedEmbedding( Source( mor_alpha ), Range( mor_beta ) ) )
                    ] );
                
                return HonestRepresentative( composition );
                
            end, 100 + 2 * 400 );
            
             ##
            AddDistinguishedObjectOfHomomorphismStructure( category, distinguished_object );
            
            ##
            AddInterpretMorphismAsMorphismFromDistinguishedObjectToHomomorphismStructure( category,
              function( cat, mor_alpha )
                local object_A, object_B, A, B, gen, arrow, reversed, alpha, interpret;
                
                object_A := Source( mor_alpha );
                
                object_B := Range( mor_alpha );
                
                A := Range( RelationMorphism( object_A ) );
                
                B := Range( RelationMorphism( object_B ) );
                
                gen := HomomorphismStructureOnObjectsForAdelmanCategoryGeneralizedEmbedding( object_A, object_B );
                
                arrow := Arrow( gen );
                
                reversed := ReversedArrow( gen );
                
                alpha := UnderlyingMorphism( mor_alpha );
                
                interpret := interpret_homomorphism_as_morphism_from_distinguished_object_to_homomorphism_structure( alpha );
                
                return PreCompose( LiftAlongMonomorphism( arrow, interpret ), reversed );
                
            end, 100 + 400 );
            
            ##
            AddInterpretMorphismFromDistinguishedObjectToHomomorphismStructureAsMorphism( category,
              function( cat, object_A, object_B, morphism )
                local gen, arrow, reversed, lift, A, B, interpret;
                
                gen := HomomorphismStructureOnObjectsForAdelmanCategoryGeneralizedEmbedding( object_A, object_B );
                
                arrow := Arrow( gen );
                
                reversed := ReversedArrow( gen );
                
                lift := PreCompose( Lift( morphism, reversed ), arrow );
                
                A := Range( RelationMorphism( object_A ) );
                
                B := Range( RelationMorphism( object_B ) );
                
                interpret := interpret_morphism_from_distinguished_object_to_homomorphism_structure_as_homomorphism( A, B, lift );
                
                return AdelmanCategoryMorphism( cat, object_A, interpret, object_B );
                
            end, 100 + 400 );
            
        fi;
        
    fi;
    
end );

####################################
##
## Functors and natural transformations
##
####################################

##
InstallMethod( AdelmanCategoryFunctorInducedByUniversalProperty,
               [ IsCapFunctor ],
               
  function( functor ) 
    local source, range, induced_functor;
    
    range := AsCapCategory( Range( functor ) );
    
    if not ( HasIsAbelianCategory( range ) and IsAbelianCategory( range ) ) then
        
        Error( "The range of the given category has to be abelian" );
        
    fi;
    
    if not ForAll( [ "HomologyObject", "HomologyObjectFunctorialWithGivenHomologyObjects" ], f -> CanCompute( range, f ) ) then
        
        Error( "The range of the given category has to be able to compute HomologyObject and HomologyObjectFunctorialWithGivenHomologyObjects" );
        
    fi;
    
    source := AdelmanCategory( AsCapCategory( Source( functor ) ) );
    
    induced_functor :=
        CapFunctor( 
            Concatenation( "Functor induced by universal property of Adelman category applied to ", Name( functor ) ),
            source, range
    );
    
    AddObjectFunction( induced_functor,
      function( adelman_obj )
        local alpha, beta;
        
        alpha := ApplyFunctor( functor, RelationMorphism( adelman_obj ) );
        
        beta := ApplyFunctor( functor, CorelationMorphism( adelman_obj ) );
        
        return HomologyObject( alpha, beta );
        
    end );
    
    AddMorphismFunction( induced_functor,
      function( new_source, mor, new_range )
        local alpha, beta, epsilon, gamma, delta;
        
        alpha := ApplyFunctor( functor, RelationMorphism( Source( mor ) ) );
        
        beta := ApplyFunctor( functor, CorelationMorphism( Source( mor ) ) );
        
        gamma := ApplyFunctor( functor, RelationMorphism( Range( mor ) ) );
        
        delta := ApplyFunctor( functor, CorelationMorphism( Range( mor ) ) );
        
        epsilon := ApplyFunctor( functor, UnderlyingMorphism( mor ) );
        
        return HomologyObjectFunctorialWithGivenHomologyObjects(
            new_source,
            [ alpha, beta, epsilon, gamma, delta ],
            new_range
        );
        
    end );
    
    return induced_functor;
    
end );

##
InstallMethod( EmbeddingFunctorOfFreydCategoryIntoAdelmanCategory,
               [ IsCapCategory ],
               
  function( underlying_category ) 
    local source, range, emb_functor;
    
    source := FreydCategory( underlying_category );
    
    range := AdelmanCategory( underlying_category );
    
    emb_functor :=
        CapFunctor( 
            Concatenation( "Embedding functor of Freyd category of ", Name( underlying_category ), " into its Adelman category" ),
            source, range
    );
    
    AddObjectFunction( emb_functor,
      function( freyd_obj )
        local alpha;
        
        alpha := RelationMorphism( freyd_obj );
        
        return AdelmanCategoryObject( alpha, MorphismIntoZeroObject( Range( alpha ) ) );
        
    end );
    
    AddMorphismFunction( emb_functor,
      function( new_source, mor, new_range )
        
        return AdelmanCategoryMorphism(
            new_source,
            UnderlyingMorphism( mor ),
            new_range
        );
        
    end );
    
    return emb_functor;
    
end );

##
InstallMethod( RightSatelliteAsEndofunctorOfAdelmanCategory,
               [ IsCapCategory ],
               
  function( underlying_category )
    local adel, right_sat;
    
    adel := AdelmanCategory( underlying_category );
    
    right_sat := CapFunctor(
        Concatenation( "Right satellite functor for ", Name( adel ) ),
        adel, adel
    );
    
    AddObjectFunction( right_sat,
      function( adel_obj )
        local alpha;
        
        if not IsSequenceAsAdelmanCategoryObject( adel_obj ) then
            
            Error( "The case that the input object is not a sequence is not supported yet" );
            
        fi;
        
        alpha := CorelationMorphism( adel_obj );
        
        return AdelmanCategoryObject( alpha, WeakCokernelProjection( alpha ) );
        
    end );
    
    AddMorphismFunction( right_sat,
      function( new_source, mor, new_range )
        
        return AdelmanCategoryMorphism(
            new_source,
            CorelationWitness( mor ),
            new_range
        );
        
    end );
    
    return right_sat;
    
end );

##
InstallMethod( LeftSatelliteAsEndofunctorOfAdelmanCategory,
               [ IsCapCategory ],
  function( underlying_category )
    local adel, left_sat;
    
    adel := AdelmanCategory( underlying_category );
    
    left_sat := CapFunctor(
        Concatenation( "Left satellite functor for ", Name( adel ) ),
        adel, adel
    );
    
    AddObjectFunction( left_sat,
      function( adel_obj )
        local beta;
        
        if not IsSequenceAsAdelmanCategoryObject( adel_obj ) then
            
            Error( "The case that the input object is not a sequence is not supported yet" );
            
        fi;
        
        beta := RelationMorphism( adel_obj );
        
        return AdelmanCategoryObject( WeakKernelEmbedding( beta ), beta );
        
    end );
    
    AddMorphismFunction( left_sat,
      function( new_source, mor, new_range )
        
        return AdelmanCategoryMorphism(
            new_source,
            RelationWitness( mor ),
            new_range
        );
        
    end );
    
    return left_sat;
    
end );

##
InstallMethod( UnitOfSatelliteAdjunctionOfAdelmanCategory,
               [ IsCapCategory ],
               
  function( underlying_category )
    local adel, id, lsat, rsat, range, unit;
    
    adel := AdelmanCategory( underlying_category );
    
    id := IdentityMorphism( AsCatObject( adel ) );
    
    lsat := LeftSatelliteAsEndofunctorOfAdelmanCategory( underlying_category );;
    
    rsat := RightSatelliteAsEndofunctorOfAdelmanCategory( underlying_category );;
    
    range := PreCompose( rsat, lsat );
    
    unit := NaturalTransformation(
        Concatenation( "Unit of satellite adjunction for ",  Name( adel ) ),
        id, range
    );
    
    AddNaturalTransformationFunction( unit,
      function( id_object, adel_obj, s_object )
        
        if not IsSequenceAsAdelmanCategoryObject( adel_obj ) then
            
            Error( "The case that the input object is not a sequence is not supported yet" );
            
        fi;
        
        return AdelmanCategoryMorphism(
            id_object,
            IdentityMorphism( Source( CorelationMorphism( adel_obj ) ) ),
            s_object
        );
        
    end );
    
    return unit;
    
end );

##
InstallMethod( CounitOfSatelliteAdjunctionOfAdelmanCategory,
               [ IsCapCategory ],
               
  function( underlying_category )
    local adel, id, lsat, rsat, source, counit;
    
    adel := AdelmanCategory( underlying_category );
    
    id := IdentityMorphism( AsCatObject( adel ) );
    
    lsat := LeftSatelliteAsEndofunctorOfAdelmanCategory( underlying_category );;
    
    rsat := RightSatelliteAsEndofunctorOfAdelmanCategory( underlying_category );;
    
    source := PreCompose( lsat, rsat );
    
    counit := NaturalTransformation(
        Concatenation( "Counit of satellite adjunction for ",  Name( adel ) ),
        source, id
    );
    
    AddNaturalTransformationFunction( counit,
      function( s_object, adel_obj, id_object )
        
        if not IsSequenceAsAdelmanCategoryObject( adel_obj ) then
            
            Error( "The case that the input object is not a sequence is not supported yet" );
            
        fi;
        
        return AdelmanCategoryMorphism(
            s_object,
            IdentityMorphism( Source( CorelationMorphism( adel_obj ) ) ),
            id_object
        );
        
    end );
    
    return counit;
    
end );

##
InstallMethod( ProjectionFunctorAdelmanCategoryToFreydCategory,
               [ IsCapCategory ],
               
  function( underlying_category )
    
    return AdelmanCategoryFunctorInducedByUniversalProperty( EmbeddingFunctorIntoFreydCategory( underlying_category ) );
    
end );

####################################
##
## Exactness properties: objects as functors
##
####################################

##
InstallMethod( IsExact,
               [ IsAdelmanCategoryObject ],
               
  function( object )
    
    return IsLeftExact( object ) and IsRightExact( object );
    
end );

##
InstallMethod( IsLeftExact,
               [ IsAdelmanCategoryObject ],
               
  function( object )
    
    return IsProjective( object );
    
end );

##
InstallMethod( IsRightExact,
               [ IsAdelmanCategoryObject ],
               
  function( object )
    
    return IsInjective( object );
    
end );

##
InstallMethod( IsImagePreserving,
               [ IsAdelmanCategoryObject ],
               
  function( object )
    
    return IsMonoPreserving( object ) and IsEpiPreserving( object );
    
end );

##
InstallMethod( IsMonoPreserving,
               [ IsAdelmanCategoryObject ],
               
  function( object )
    
    return ProjectiveDimension( object ) <= 1;
    
end );

##
InstallMethod( IsEpiPreserving,
               [ IsAdelmanCategoryObject ],
               
  function( object )
    
    return InjectiveDimension( object ) <= 1;
    
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
    
    Display( UnderlyingMorphism( morphism ) );
    
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

#= comment for Julia
##
InstallMethod( LaTeXOutput,
               [ IsAdelmanCategoryObject ],
  function( object )
    local rel, corel, r, m, c, rel_dat, corel_dat;
    
    rel := RelationMorphism( object );
    
    corel := CorelationMorphism( object );
    
    r := LaTeXOutput( Source( rel ) );
    
    m := LaTeXOutput( Range( rel ) );
    
    c := LaTeXOutput( Range( corel ) );
    
    rel_dat := LaTeXOutput( rel : OnlyDatum := true );
    
    corel_dat := LaTeXOutput( corel : OnlyDatum := true );
    
    m := Concatenation( """{  \color{blue}{""", m, "} }" );
    
    return Concatenation(
      """{ \big(""",
      r,
      "\\xrightarrow{",
      rel_dat,
      "}",
      m,
      "\\xrightarrow{",
      corel_dat,
      "}",
      c,
      """\big)}"""
    );
    
end );

##
InstallMethod( LaTeXOutput,
               [ IsAdelmanCategoryMorphism ],
  function( mor )
    local datum;
    
    datum := LaTeXOutput( UnderlyingMorphism( mor ) : OnlyDatum := true );
    
    return Concatenation(
      LaTeXOutput( Source( mor ) ),
      """{\color{blue}{\xrightarrow{""",
      datum,
      """}}}""",
      LaTeXOutput( Range( mor ) )
    );
    
end );
# =#

####################################
##
## Convenience
##
####################################

##
InstallOtherMethod( \/,
              [ IsCapCategoryObject, IsAdelmanCategory ],
              
  function( object, adel )
    
    if not IsIdenticalObj( CapCategory( object ), UnderlyingCategory( adel ) ) then
        
        Error( "The category of the given object is not identical to the underlying category of the given Adelman category" );
        
    fi;
    
    return AsAdelmanCategoryObject( object );
    
end );

##
InstallOtherMethod( \/,
               [ IsFreydCategoryObject, IsAdelmanCategory ],
  function( freyd_obj, adel )
    local underlying_category;
    
    underlying_category := UnderlyingCategory( CapCategory( freyd_obj ) );
    
    if not IsIdenticalObj( underlying_category, UnderlyingCategory( adel ) ) then
        
        TryNextMethod();
        
    fi;
    
    return ApplyFunctor( EmbeddingFunctorOfFreydCategoryIntoAdelmanCategory( underlying_category ), freyd_obj );;
    
end );

##
InstallOtherMethod( \/,
              [ IsCapCategoryMorphism, IsAdelmanCategory ],
  function( morphism, adel )
    
    if not IsIdenticalObj( CapCategory( morphism ), UnderlyingCategory( adel ) ) then
        
        Error( "The category of the given morphism is not identical to the underlying category of the given Adelman category" );
        
    fi;
    
    return AsAdelmanCategoryMorphism( morphism );
    
end );

####################################
##
## Down
##
####################################

##
InstallMethod( Down,
               [ IsAdelmanCategoryObject ],
  function( obj )
    
    return [ RelationMorphism( obj ), CorelationMorphism( obj ) ];
    
end );

##
InstallMethod( DownOnlyMorphismData,
               [ IsAdelmanCategoryMorphism ],
  function( mor )
    
    return UnderlyingMorphism( mor );
    
end );
