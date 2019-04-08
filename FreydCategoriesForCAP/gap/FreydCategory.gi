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
InstallMethod( FreydCategory,
               [ IsCapCategory ],
               
  function( underlying_category )
    local freyd_category, to_be_finalized;
    
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
    
    freyd_category := CreateCapCategory( Concatenation( "Freyd( ", Name( underlying_category ), " )" ) );
    
    SetFilterObj( freyd_category, IsFreydCategory );
    
    SetIsAdditiveCategory( freyd_category, true );
    
    SetUnderlyingCategory( freyd_category, underlying_category );
    
    ## Freyd's theorem
    if ForAll( [ "WeakKernelEmbedding", "WeakKernelLift" ], f -> CanCompute( underlying_category, f ) ) then
        
        SetIsAbelianCategory( freyd_category, true );
        
    fi;
    
    AddObjectRepresentation( freyd_category, IsFreydCategoryObject );
    
    AddMorphismRepresentation( freyd_category, IsFreydCategoryMorphism );
    
    INSTALL_FUNCTIONS_FOR_FREYD_CATEGORY( freyd_category );
    
    ADD_MONOIDAL_STRUCTURE_TO_FREYD_CATEGORY( freyd_category );

    to_be_finalized := ValueOption( "FinalizeCategory" );
      
    if to_be_finalized = false then
      
      return freyd_category;
    
    fi;
    
    Finalize( freyd_category );
    
    return freyd_category;
    
end );

##
InstallMethod( AsFreydCategoryObject,
               [ IsCapCategoryObject ],
               
  function( object )
    local projective_object;
    
    projective_object := FreydCategoryObject( UniversalMorphismFromZeroObject( object ) );
    
    SetIsProjective( projective_object, true );
    
    return projective_object;
    
end );

##
InstallMethod( FreydCategoryObject,
               [ IsCapCategoryMorphism ],
               
  function( relation_morphism )
    local freyd_category_object, category;
    
    freyd_category_object := rec( );
    
    category := FreydCategory( CapCategory( relation_morphism ) );

    ObjectifyObjectForCAPWithAttributes( freyd_category_object, category,
                                         RelationMorphism, relation_morphism );
    
    return freyd_category_object;
    
end );

##
InstallMethod( AsFreydCategoryMorphism,
               [ IsCapCategoryMorphism ],
               
  function( morphism )
    
    return FreydCategoryMorphism(
             AsFreydCategoryObject( Source( morphism ) ),
             morphism,
             AsFreydCategoryObject( Range( morphism ) )
           );
    
end );

##
InstallMethod( FreydCategoryMorphism,
               [ IsFreydCategoryObject, IsCapCategoryMorphism, IsFreydCategoryObject ],
               
  function( source, morphism_datum, range )
    local freyd_category_morphism, category;
    
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
    
    category :=  CapCategory( source );

    ObjectifyMorphismForCAPWithAttributes( 
                             freyd_category_morphism, category,
                             Source, source,
                             Range, range,
                             MorphismDatum, morphism_datum
    );
    
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

InstallMethod( WitnessForBeingCongruentToZero,
               [ IsFreydCategoryMorphism ],
               
  function( morphism )
    
    return Lift( MorphismDatum( morphism ), RelationMorphism( Range( morphism ) ) );
    
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
    local underlying_category, diagram_for_homomorphism_structure_as_kernel, 
          diagram_for_homomorphism_structure_as_kernel_on_morphisms,
          distinguished_object, range_category, homomorphism_structure_derivation_case,
          homomorphism_structure_on_objects,
          homomorphism_structure_on_morphisms,
          distinguished_object_of_homomorphism_structure,
          interpret_homomorphism_as_morphism_from_dinstinguished_object_to_homomorphism_structure,
          interpret_morphism_from_dinstinguished_object_to_homomorphism_structure_as_homomorphism;
    
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
      
        return IsEqualForMorphismsOnMor( RelationMorphism( object_1 ), RelationMorphism( object_2 ) );
      
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
        
        return FreydCategoryObject( ZeroObjectFunctorial( underlying_category ) );
        
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
    
    ## Cokernels: cokernels in Freyd categories are formal and thus very cheap
    AddCokernelProjection( category,
                     
      function( morphism )
        local range, relation_morphism, cokernel_object, cokernel_projection;
        
        range := Range( morphism );
        
        relation_morphism := RelationMorphism( range );
        
        cokernel_object := FreydCategoryObject( UniversalMorphismFromDirectSum( [ relation_morphism, MorphismDatum( morphism ) ] ) );
        
        cokernel_projection := FreydCategoryMorphism( range,
                                                      IdentityMorphism( Range( relation_morphism ) ),
                                                      cokernel_object );
        
        return cokernel_projection;
        
    end );
    
    ##
    AddCokernelColiftWithGivenCokernelObject( category,
      
      function( morphism, test_morphism, cokernel_object )
        
        return FreydCategoryMorphism( cokernel_object,
                                      MorphismDatum( test_morphism ),
                                      Range( test_morphism ) );
        
    end );
    
    if ForAll( [ "ProjectionOfBiasedWeakFiberProduct", "UniversalMorphismIntoBiasedWeakFiberProduct" ], f -> CanCompute( underlying_category, f ) ) then
        
        ## Kernels: kernels in Freyd categories are based on weak fiber products in the underlying category and thus more expensive
        AddKernelEmbedding( category,
          
          function( morphism )
            local alpha, rho_B, rho_A, projection_1, projection_2, kernel_object;
            
            alpha := MorphismDatum( morphism );
            
            rho_B := RelationMorphism( Range( morphism ) );
            
            rho_A := RelationMorphism( Source( morphism ) );
            
            ## We use the bias in the first projection of weak fiber products
            projection_1 := ProjectionOfBiasedWeakFiberProduct( alpha, rho_B );
            
            projection_2 := ProjectionOfBiasedWeakFiberProduct( projection_1, rho_A );
            
            kernel_object := FreydCategoryObject( projection_2 );
            
            return FreydCategoryMorphism( kernel_object,
                                          projection_1,
                                          Source( morphism ) );
            
        end );
        
        ##
        AddKernelLiftWithGivenKernelObject( category,
                                            
          function( morphism, test_morphism, kernel_object )
            local sigma, alpha, rho_B, tau, morphism_datum;
            
            ## for notational convenience
            alpha := MorphismDatum( morphism );
            
            rho_B := RelationMorphism( Range( morphism ) );
            
            tau := MorphismDatum( test_morphism );
            
            morphism_datum := UniversalMorphismIntoBiasedWeakFiberProduct( alpha, rho_B, tau );
            
            return FreydCategoryMorphism( Source( test_morphism ),
                                          morphism_datum,
                                          kernel_object );
            
        end );
        
        ##
        AddLiftAlongMonomorphism( category,
          
          function( alpha, test_morphism )
            local sigma, R_B, A, tau_A;
            
            sigma := WitnessForBeingCongruentToZero( PreCompose( test_morphism, CokernelProjection( alpha ) ) );
            
            R_B := Source( RelationMorphism( Range( alpha ) ) );
            
            A := Range( RelationMorphism( Source( alpha ) ) );
            
            tau_A := PreCompose( sigma, ProjectionInFactorOfDirectSum( [ R_B, A ], 2 ) );
            
            return FreydCategoryMorphism( Source( test_morphism ),
                                          tau_A,
                                          Source( alpha ) );
            
        end );
        
        ##
        AddColiftAlongEpimorphism( category,
          
          function( alpha, test_morphism )
            local witness, R_B, A, sigma_A;
            
            witness := WitnessForBeingCongruentToZero( PreCompose( alpha, CokernelProjection( alpha ) ) );
            
            R_B := Source( RelationMorphism( Range( alpha ) ) );
            
            A := Range( RelationMorphism( Source( alpha ) ) );
            
            sigma_A := PreCompose( witness, ProjectionInFactorOfDirectSum( [ R_B, A ], 2 ) );
            
            return FreydCategoryMorphism( Range( alpha ),
                                          PreCompose( sigma_A, MorphismDatum( test_morphism ) ),
                                          Range( test_morphism ) );
            
        end );
        
    fi;
    
    ##
    AddEpimorphismFromSomeProjectiveObjectForKernelObject( category,
                            
      function( morphism )
        local alpha, rho_B, projection_1, projective_object;
        
        alpha := MorphismDatum( morphism );
        
        rho_B := RelationMorphism( Range( morphism ) );
        
        ## We use the bias in the first projection of weak fiber products
        projection_1 := ProjectionOfBiasedWeakFiberProduct( alpha, rho_B );
        
        projective_object := AsFreydCategoryObject( Source( projection_1 ) );
        
        return FreydCategoryMorphism( projective_object,
                                      projection_1,
                                      Source( morphism ) );
        
    end );
    
    ##
    AddEpimorphismFromSomeProjectiveObject( category,
                          
      function( object )
        local range;
        
        range := Range( RelationMorphism( object ) );
        
        return FreydCategoryMorphism(
                 AsFreydCategoryObject( range ),
                 IdentityMorphism( range ),
                 object
               );
        
    end );
    
    ##
    if ForAll( [ "SolveLinearSystemInAbCategory",
                 "IdentityMorphism",
                 "ZeroMorphism",
                 "AdditiveInverseForMorphisms" ], 
               f -> CanCompute( underlying_category, f ) ) then
        
        AddLift( category,
                 
          function( alpha_freyd, gamma_freyd )
            local rho_A, rho_B, rho_C, alpha, gamma, A, B, C, R_A, R_B, R_C, left_coefficients, right_coefficients, right_side, solution;
            
            rho_A := RelationMorphism( Source( alpha_freyd ) );
            
            rho_B := RelationMorphism( Range( alpha_freyd ) );
            
            rho_C := RelationMorphism( Source( gamma_freyd ) );
            
            alpha := MorphismDatum( alpha_freyd );
            
            gamma := MorphismDatum( gamma_freyd );
            
            ##
            
            A := Range( rho_A );
            
            B := Range( rho_B );
            
            C := Range( rho_C );
            
            R_A := Source( rho_A );
            
            R_B := Source( rho_B );
            
            R_C := Source( rho_C );
            
            ##
            
            left_coefficients := [
              [ rho_A, -IdentityMorphism( R_A ), ZeroMorphism( R_A, A ) ],
              [ IdentityMorphism( A ), ZeroMorphism( A, R_A ), -IdentityMorphism( A ) ]
            ];
            
            right_coefficients := [
              [ IdentityMorphism( C ), rho_C, ZeroMorphism( R_B, C ) ],
              [ gamma, ZeroMorphism( R_C, B ), rho_B ]
            ];
            
            right_side := [ ZeroMorphism( R_A, C ), alpha ];
            
            solution := SolveLinearSystemInAbCategory( left_coefficients, right_coefficients, right_side );
            
            if solution = fail then
                
                return fail;
                
            fi;
            
            return FreydCategoryMorphism( Source( alpha_freyd ), solution[1], Source( gamma_freyd ) );
            
        end );
        
        AddColift( category,
                 
          function( alpha_freyd, gamma_freyd )
            local rho_A, rho_B, rho_C, alpha, gamma, A, B, C, R_A, R_B, R_C, left_coefficients, right_coefficients, right_side, solution;
            
            rho_A := RelationMorphism( Range( alpha_freyd ) );
            
            rho_B := RelationMorphism( Source( alpha_freyd ) );
            
            rho_C := RelationMorphism( Range( gamma_freyd ) );
            
            alpha := MorphismDatum( alpha_freyd );
            
            gamma := MorphismDatum( gamma_freyd );
            
            ##
            
            A := Range( rho_A );
            
            B := Range( rho_B );
            
            C := Range( rho_C );
            
            R_A := Source( rho_A );
            
            R_B := Source( rho_B );
            
            R_C := Source( rho_C );
            
            ##
            
            left_coefficients := [
              [ rho_A, -IdentityMorphism( R_A ), ZeroMorphism( R_A, B ) ],
              [ alpha, ZeroMorphism( B, R_A ), -IdentityMorphism( B ) ]
            ];
            
            right_coefficients := [
              [ IdentityMorphism( C ), rho_C, ZeroMorphism( R_C, C ) ],
              [ IdentityMorphism( C ), ZeroMorphism( R_C, C ), rho_C ]
            ];
            
            right_side := [ ZeroMorphism( R_A, C ), gamma ];
            
            solution := SolveLinearSystemInAbCategory( left_coefficients, right_coefficients, right_side );
            
            if solution = fail then
                
                return fail;
                
            fi;
            
            return FreydCategoryMorphism( Range( alpha_freyd ), solution[1], Range( gamma_freyd ) );
            
        end );
    
    fi;
    
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
            
            homomorphism_structure_on_objects := HomomorphismStructureOnObjects;
            
            homomorphism_structure_on_morphisms := HomomorphismStructureOnMorphisms;
            
            distinguished_object_of_homomorphism_structure := DistinguishedObjectOfHomomorphismStructure;
            
            interpret_homomorphism_as_morphism_from_dinstinguished_object_to_homomorphism_structure :=
              InterpretMorphismAsMorphismFromDinstinguishedObjectToHomomorphismStructure;
            
            interpret_morphism_from_dinstinguished_object_to_homomorphism_structure_as_homomorphism :=
              InterpretMorphismFromDinstinguishedObjectToHomomorphismStructureAsMorphism;
            
        elif HasIsAdditiveCategory( range_category )
                and IsAdditiveCategory( range_category )
                and ForAll(
                    [ "Lift",
                      "SubtractionForMorphisms",
                      "PreCompose",
                      "Lift",
                      "ProjectionOfBiasedWeakFiberProduct",
                      "UniversalMorphismIntoBiasedWeakFiberProduct"
                      ],
                    f -> CanCompute( underlying_category, f ) )  then
            
            if IsIdenticalObj( range_category, underlying_category ) then
                
                SetRangeCategoryOfHomomorphismStructure( category, category );
                
            else
                
                SetRangeCategoryOfHomomorphismStructure( category, FreydCategory( range_category ) );
                
            fi;
            
            homomorphism_structure_derivation_case := "apply_freyd";
            
            homomorphism_structure_on_objects :=
              function( A,B ) return AsFreydCategoryObject( HomomorphismStructureOnObjects( A, B ) ); end;
            
            homomorphism_structure_on_morphisms := 
              function( alpha, beta ) return AsFreydCategoryMorphism( HomomorphismStructureOnMorphisms( alpha, beta ) ); end;
            
            distinguished_object_of_homomorphism_structure := 
              cat -> AsFreydCategoryObject( DistinguishedObjectOfHomomorphismStructure( range_category ) );
            
            interpret_homomorphism_as_morphism_from_dinstinguished_object_to_homomorphism_structure :=
              alpha -> AsFreydCategoryMorphism(
                        InterpretMorphismAsMorphismFromDinstinguishedObjectToHomomorphismStructure( alpha )
                      );
            
            interpret_morphism_from_dinstinguished_object_to_homomorphism_structure_as_homomorphism :=
              function( A, B, alpha )
                
                return InterpretMorphismFromDinstinguishedObjectToHomomorphismStructureAsMorphism(
                        A, B, MorphismDatum( alpha ) );
              
              end;
              
        else
            
            homomorphism_structure_derivation_case := "none";
            
        fi;
        
        if not homomorphism_structure_derivation_case = "none" then
            
            diagram_for_homomorphism_structure_as_kernel := FunctionWithCache(
            
            function( object_A, object_B )
              local rho_A, rho_B, A, B, R_A, R_B, mor_1, mor_2;
              
              rho_A := RelationMorphism( object_A );
              
              rho_B := RelationMorphism( object_B );
              
              A := Range( rho_A );
              
              B := Range( rho_B );
              
              R_A := Source( rho_A );
              
              R_B := Source( rho_B );
              
              mor_1 := homomorphism_structure_on_morphisms( IdentityMorphism( A ), rho_B );
              
              mor_2 := PreCompose(
                          homomorphism_structure_on_morphisms( rho_A, IdentityMorphism( B ) ),
                          CokernelProjection( homomorphism_structure_on_morphisms( IdentityMorphism( R_A ), rho_B ) )
                        );
              
              return [ CokernelColift( mor_1, mor_2 ), mor_1 ];
              
            end );
            
            ##
            AddHomomorphismStructureOnObjects( category,
              function( object_A, object_B )
                local diagram;
                
                diagram := diagram_for_homomorphism_structure_as_kernel( object_A, object_B )[1];
                
                return KernelObject( diagram );
                
            end );
            
            ##
            diagram_for_homomorphism_structure_as_kernel_on_morphisms :=
              function( alpha, beta )
                local object_A, object_Ap, object_B, object_Bp, rho_B, rho_Bp, A, Ap, mor_1, mor_2;
                
                object_A := Range( alpha );
                
                object_Ap := Source( alpha );
                
                object_B := Source( beta );
                
                object_Bp := Range( beta );
                
                rho_B := RelationMorphism( object_B );
                
                rho_Bp := RelationMorphism( object_Bp );
                
                A := Range( RelationMorphism( object_A ) );
                
                Ap := Range( RelationMorphism( object_Ap ) );
                
                mor_1 := homomorphism_structure_on_morphisms( IdentityMorphism( A ), rho_B );
                
                mor_2 := PreCompose(
                            homomorphism_structure_on_morphisms( MorphismDatum( alpha ), MorphismDatum( beta ) ),
                            CokernelProjection( homomorphism_structure_on_morphisms( IdentityMorphism( Ap ), rho_Bp ) )
                          );
                
                return CokernelColift( mor_1, mor_2 );
                
            end;
            
            ##
            AddHomomorphismStructureOnMorphismsWithGivenObjects( category,
              function( source, alpha, beta, range )
                local object_A, object_Ap, object_B, object_Bp;
                
                object_A := Range( alpha );
                
                object_Ap := Source( alpha );
                
                object_B := Source( beta );
                
                object_Bp := Range( beta );
                
                return KernelObjectFunctorialWithGivenKernelObjects(
                          source,
                          diagram_for_homomorphism_structure_as_kernel( object_A, object_B )[1],
                          diagram_for_homomorphism_structure_as_kernel_on_morphisms( alpha, beta ),
                          diagram_for_homomorphism_structure_as_kernel( object_Ap, object_Bp )[1],
                          range
                        );
            end );
            
            ##
            AddDistinguishedObjectOfHomomorphismStructure( category,
              function( )
                
                return distinguished_object_of_homomorphism_structure( range_category );
                
            end );
            
            AddInterpretMorphismAsMorphismFromDinstinguishedObjectToHomomorphismStructure( category,
              function( alpha )
                local phi, interpretation, diagram;
                
                phi := MorphismDatum( alpha );
                
                interpretation := 
                    interpret_homomorphism_as_morphism_from_dinstinguished_object_to_homomorphism_structure( phi );
                
                diagram := diagram_for_homomorphism_structure_as_kernel( Source( alpha ), Range( alpha ) );
                
                return KernelLift( diagram[1], PreCompose( interpretation, CokernelProjection( diagram[2] ) ) );
                
            end );
        
            ##
            AddInterpretMorphismFromDinstinguishedObjectToHomomorphismStructureAsMorphism( category,
              function( A, B, morphism )
                local diagram, embedding, epsilon, lift, interpretation;
                
                diagram := diagram_for_homomorphism_structure_as_kernel( A, B );
                
                embedding := KernelEmbedding( diagram[1] );
                
                epsilon := CokernelProjection( diagram[2] );
                
                lift := ProjectiveLift( PreCompose( morphism, embedding ), epsilon );
                
                interpretation := 
                  interpret_morphism_from_dinstinguished_object_to_homomorphism_structure_as_homomorphism(
                    Range( RelationMorphism( A ) ), Range( RelationMorphism( B ) ), lift );
                
                return FreydCategoryMorphism( A, interpretation, B );
                
            end );
        
        fi;
        
    fi;

        
    
    
end );


###########################################
##
## Add monoidal structure of Freyd category
##
###########################################

InstallGlobalFunction( ADD_MONOIDAL_STRUCTURE_TO_FREYD_CATEGORY,

  function( category )
    local underlying_category;

    underlying_category := UnderlyingCategory( category );


    ######################################################################
    #
    # Tensor product
    #
    ######################################################################

    # This method requires two objects obj1, obj2 in the Freyd category.
    # It then computes the tensor product of these objects. Our strategy is as follows:
    #
    # The objects are given by the relation morphisms
    #
    # R_A --- \alpha ---> A,    R_B --- \beta ---> B
    #
    # Then we consider the following diagram
    #
    # R_A \otimes B <<----- ( R_A \otimes B ) \oplus ( A \otimes R_B ) -------> A \otimes R_B
    #       |                                                                           |
    #       |                                                                           |
    #       |---- \alpha \otimes 1_B -----> A \otimes B <------- 1_A \otimes \beta -----|
    #
    # This induces a universal morphism ( R_A \otimes B ) \oplus ( A \otimes R_B ) ---> A \otimes B.
    # We interpret this universal morphism as object in the Freyd category. This object is the
    # tensor product of obj1 and obj2. The method below returns this tensor product.
    # Note that A \otimes B,\alpha \otimes 1_B etc. are performed in the underlying category.
    AddTensorProductOnObjects( category,
      function( object1, object2 )
        local factor1, factor2, range, diagram, mor1, mor2, sink, uni;

        # construct the objects needed in the computation of the tensor product
        factor1 := TensorProductOnObjects( Source( RelationMorphism( object1 ) ), Range( RelationMorphism( object2 ) ) );
        factor2 := TensorProductOnObjects( Range( RelationMorphism( object1 ) ), Source( RelationMorphism( object2 ) ) );
        range := TensorProductOnObjects( Range( RelationMorphism( object1 ) ), Range( RelationMorphism( object2 ) ) );

        # construct the diagram
        diagram := [ factor1, factor2 ];

        # construct the sink
        mor1 := TensorProductOnMorphisms( RelationMorphism( object1 ), IdentityMorphism( Range( RelationMorphism( object2 ) ) ) );
        mor2 := TensorProductOnMorphisms( IdentityMorphism( Range( RelationMorphism( object1 ) ) ), RelationMorphism( object2 ) );
        sink := [ mor1, mor2 ];

        # compute the universal morphism
        uni := UniversalMorphismFromDirectSum( diagram, sink );

        # and return the corresponding object in the Freyd category
        return FreydCategoryObject( uni );

    end );

    # This method requires two morphisms in the Freyd category. Let us denote them as follows:
    #
    # \alpha: S_1 --- x ---> R_1,      \beta: S_2 --- y ---> R_2
    #
    # Then we compute
    # (1) S = S_1 \otimes S_2, (in the Freyd category)
    # (2) R = R_1 \otimes R_2, (in the Freyd category)
    # (3) x \otimes y (in the underlying category)
    # The method now returns the morphism S --- x \otimes y ---> R.
    AddTensorProductOnMorphismsWithGivenTensorProducts( category,
      function( source, morphism1, morphism2, range )
        local mor;

        mor := TensorProductOnMorphisms( MorphismDatum( morphism1 ), MorphismDatum( morphism2 ) );

        return FreydCategoryMorphism( source, mor, range );

    end );

    # The tensor unit is 0 ---> 1 where 0 is the zero object and 1 the tensor unit in the underlying category
    # and the morphism is the universal morphism from the zero object.
    AddTensorUnit( category,
      function( )

        return FreydCategoryObject( UniversalMorphismFromZeroObject( TensorUnit( underlying_category ) ) );

    end );

    # Given three objects a, b, c in the Freyd category, we consider
    # (1) source = ( a \otimes b ) \otimes c
    # (2) range = a \otimes ( b \otimes c ).
    # We then derive the associator associator source -> range from the associator in the underlying category.
    # Note that even if the underlying category is a strict monoidal category
    # (i.e. the associators and unitors are identities), this need not be true in the Freyd category.
    AddAssociatorLeftToRightWithGivenTensorProducts( category,
      function( source, a, b, c, range )
        local mor;

        mor := AssociatorLeftToRight( Range( RelationMorphism( a ) ),
                                      Range( RelationMorphism( b ) ),
                                      Range( RelationMorphism( c ) ) );

        return FreydCategoryMorphism( source, mor, range );
        # always well-defined?

    end );

    # Given three objects a, b, c in the Freyd category, we consider
    # (1) source = a \otimes ( b \otimes c )
    # (2) range = ( a \otimes b ) \otimes c.
    # We then derive the associator associator source -> range from the associator in the underlying category.
    # Note that even if the underlying category is a strict monoidal category
    # (i.e. the associators and unitors are identities), this need not be true in the Freyd category.
    AddAssociatorRightToLeftWithGivenTensorProducts( category,
      function( source, a, b, c, range )
        local mor;

        mor := AssociatorRightToLeft( Range( RelationMorphism( a ) ),
                                      Range( RelationMorphism( b ) ),
                                      Range( RelationMorphism( c ) ) );

        return FreydCategoryMorphism( source, mor, range );
        # always well-defined?

    end );

    # Given an object a, this method returns the left unitor 1 \otimes a -> a.
    # We derive this from the unitors of the underlying category.
    AddLeftUnitorWithGivenTensorProduct( category,
      function( a, s )

        return FreydCategoryMorphism( s, LeftUnitor( Range( RelationMorphism( a ) ) ), a );

    end );

    # Given an object a, this method returns the left unitor inverse a -> 1 \otimes a.
    # We derive from the underlying category.
    AddLeftUnitorInverseWithGivenTensorProduct( category,
      function( a, r )

        return FreydCategoryMorphism( a, LeftUnitor( Range( RelationMorphism( a ) ) ), r );

    end );

    # Given an object a, this method returns the right unitor a \otimes 1 -> a.
    # We derive from the underlying category.
    AddRightUnitorWithGivenTensorProduct( category,
      function( a, s )

        return FreydCategoryMorphism( s, RightUnitor( Range( RelationMorphism( a ) ) ), a );

    end );

    # Given an object a, this method returns the right unitor inverse a -> a \otimes 1.
    # We derive from the underlying proj-category.
    AddRightUnitorInverseWithGivenTensorProduct( category,
      function( a, r )

        return FreydCategoryMorphism( a, RightUnitorInverse( Range( RelationMorphism( a ) ) ), r );

    end );

    ######################################################################
    #
    # Symmetric Monoidal Structure
    # (i.e. braiding and its inverse given by B_a,b^{-1} = B_{b,a}
    #
    ######################################################################

    # Given two objects a and b this method derives a braiding morphism a \otimes b -> b \otimes a
    # from the braiding in the underlying category.
    AddBraidingWithGivenTensorProducts( category,
    function( s, a, b, r)
        local mor;

        mor := Braiding( Range( RelationMorphism( a ) ), Range( RelationMorphism( b ) ) );
        return FreydCategoryMorphism( s, mor, r );

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
