#############################################################################
##
##     FreydCategoriesForCAP: Freyd categories - Formal (co)kernels for additive categories
##
##  Copyright 2018, Sebastian Posur, University of Siegen
##
#############################################################################


####################################
##
## Info for Freyd categories
##
####################################

BindGlobal( "InfoFreydCategoriesForCAP", NewInfoClass("InfoFreydCategoriesForCAP") );



####################################
##
## Constructors
##
####################################

##
InstallGlobalFunction( FREYD_CATEGORY,
  function( underlying_category )
    local freyd_category, to_be_finalized, conditions;
    
    if not IsValidInputForFreydCategory( underlying_category ) then
        return false;
    fi;

    freyd_category := CreateCapCategory( Concatenation( "Freyd( ", Name( underlying_category ), " )" ) );
    
    SetFilterObj( freyd_category, IsFreydCategory );
    
    SetIsAdditiveCategory( freyd_category, true );
    
    SetUnderlyingCategory( freyd_category, underlying_category );
    
    ## Freyd's theorem
    if ForAll( [ "WeakKernelEmbedding", "WeakKernelLift" ], f -> CanCompute( underlying_category, f ) ) then
        
        SetIsAbelianCategory( freyd_category, true );
        
    fi;
    
    conditions := [ "TensorProductOnObjects",
                    "TensorProductOnMorphismsWithGivenTensorProducts",
                    "TensorUnit",
                    "AssociatorLeftToRightWithGivenTensorProducts",
                    "AssociatorRightToLeftWithGivenTensorProducts",
                    "LeftUnitorWithGivenTensorProduct",
                    "LeftUnitorInverseWithGivenTensorProduct",
                    "RightUnitorWithGivenTensorProduct",
                    "RightUnitorInverseWithGivenTensorProduct" ];
    
    if ForAll( conditions, f -> CanCompute( underlying_category, f ) ) then

      SetIsMonoidalCategory( freyd_category, true );

    fi;

    conditions := Concatenation( conditions, [ "BraidingWithGivenTensorProducts" ] );
    if ForAll( conditions, f -> CanCompute( underlying_category, f ) ) then

      SetIsSymmetricMonoidalCategory( freyd_category, true );

    fi;

    conditions := Concatenation( conditions, [ "InternalHomOnMorphismsWithGivenInternalHoms",
                                                "ProjectionOfBiasedWeakFiberProduct",
                                                "UniversalMorphismIntoBiasedWeakFiberProduct",
                                                "EvaluationMorphismWithGivenSource",
                                                "CoevaluationMorphismWithGivenRange" ] );
    if ForAll( conditions, f -> CanCompute( underlying_category, f ) ) then

      SetIsSymmetricClosedMonoidalCategory( freyd_category, true );

    fi;

    # is a Freyd category always not a strict monoidal category?
    # SetIsStrictMonoidalCategory( freyd_category, false );

    AddObjectRepresentation( freyd_category, IsFreydCategoryObject );
    
    AddMorphismRepresentation( freyd_category, IsFreydCategoryMorphism );
    
    INSTALL_FUNCTIONS_FOR_FREYD_CATEGORY( freyd_category );
    
    to_be_finalized := ValueOption( "FinalizeCategory" );
      
    if to_be_finalized = false then
      
      return freyd_category;
    
    fi;
    
    Finalize( freyd_category );
    
    return freyd_category;
    
end );

##
InstallMethod( FreydCategory,
               [ IsCapCategory ],
    FREYD_CATEGORY
);

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
InstallGlobalFunction( FREYD_CATEGORY_OBJECT,
function( relation_morphism )
    local freyd_category_object, category;
    
    freyd_category_object := rec( );
    
    category := FreydCategory( CapCategory( relation_morphism ) );

    ObjectifyObjectForCAPWithAttributes( freyd_category_object, category,
                                         RelationMorphism, relation_morphism );
    
    return freyd_category_object;
    
end );

##
InstallMethod( FreydCategoryObject,
               [ IsCapCategoryMorphism ],
    FREYD_CATEGORY_OBJECT
);

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
InstallGlobalFunction( FREYD_CATEGORY_MORPHISM,
  function( source, morphism_datum, range )
    local freyd_category_morphism, category;
    
    if not IsIdenticalObj( CapCategory( morphism_datum ), UnderlyingCategory( CapCategory( source ) ) ) then
        
        Error( "The underlying category of the given morphism datum is not identical to the underlying category of the given source" );
        
    fi;
    
    if not IsIdenticalObj( CapCategory( morphism_datum ), UnderlyingCategory( CapCategory( range ) ) ) then
        
        Error( "The underlying category of the given morphism datum is not identical to the underlying category of the given range" );
        
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

##
InstallMethod( FreydCategoryMorphism,
               [ IsFreydCategoryObject, IsCapCategoryMorphism, IsFreydCategoryObject ],
               FREYD_CATEGORY_MORPHISM
);


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

InstallMethodWithCacheFromObject( INTERNAL_HOM_EMBEDDING,
                           [ IsFreydCategoryObject, IsFreydCategoryObject ],
    function( a, b )
      local source, range, mor;

      # compute source
      source := InternalHomOnMorphisms( IdentityMorphism( Range( RelationMorphism( a ) ) ), 
                                        RelationMorphism( b ) );
      source:= FreydCategoryObject( source );
      
      # compute range
      range := InternalHomOnMorphisms( IdentityMorphism( Source( RelationMorphism( a ) ) ), 
                                       RelationMorphism( b ) );
      range := FreydCategoryObject( range );
      
      # compute mapping
      mor := InternalHomOnMorphisms( RelationMorphism( a ), 
                                     IdentityMorphism( Range( RelationMorphism( b ) ) ) );

      # construct hom embedding
      return KernelEmbedding( FreydCategoryMorphism( source, mor, range ) );

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
          interpret_morphism_from_dinstinguished_object_to_homomorphism_structure_as_homomorphism,
          is_possible_to_install,
          not_supported, to_be_tested;
    
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
    
    
    is_possible_to_install := function( to_be_installed, to_be_tested )
        local not_supported;
        
        # test which methods are supported by the underlying category
        not_supported := [];
        Perform( to_be_tested, function(x) if not CanCompute( underlying_category, x ) then 
                                            Append( not_supported, x ); 
                                         fi; end);
        
        # methods cannot be installed, so inform the user
        if not IsEmpty( not_supported ) then
            Info( InfoFreydCategoriesForCAP, 2,
                    Concatenation( "The operation(s) ",
                                   to_be_installed,
                                    " could not be installed because the underlying category cannot compute ",
                                    JoinStringsWithSeparator( not_supported, ", " ) ) );
            return false;
        fi;
        
        # other methods can be installed
        return true;
        
    end;
    
    
    if is_possible_to_install( "KernelEmbedding, KernelLiftWithGivenKernelObject",
                               [ "ProjectionOfBiasedWeakFiberProduct", "UniversalMorphismIntoBiasedWeakFiberProduct" ] ) then
    
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

    fi;
    
    
    AddLiftAlongMonomorphism( category,
        
        function( alpha, test_morphism )
        local sigma, R_B, A, tau_A;
        
        sigma := WitnessForBeingCongruentToZero( PreCompose( test_morphism, CokernelProjection( alpha ) ) );
        
        R_B := Source( RelationMorphism( Range( alpha ) ) );
        
        A := Range( RelationMorphism( Source( alpha ) ) );
        
        tau_A := PreCompose( sigma, ProjectionInFactorOfDirectSum( [ R_B, A ], 2 ) );
        
        return FreydCategoryMorphism( Source( test_morphism ), tau_A, Source( alpha ) );
    
    end );
    
    ##
    AddColiftAlongEpimorphism( category,
        
        function( alpha, test_morphism )
        local witness, R_B, A, sigma_A;
        
        witness := WitnessForBeingCongruentToZero( PreCompose( alpha, CokernelProjection( alpha ) ) );
        
        R_B := Source( RelationMorphism( Range( alpha ) ) );
        
        A := Range( RelationMorphism( Source( alpha ) ) );
        
        sigma_A := PreCompose( witness, ProjectionInFactorOfDirectSum( [ R_B, A ], 2 ) );
        
        return FreydCategoryMorphism( Range( alpha ), PreCompose( sigma_A, MorphismDatum( test_morphism ) ), Range( test_morphism ) );
    
    end );
    
    
    
    if is_possible_to_install( "EpimorphismFromSomeProjectiveObjectForKernelObject",
                               [ "ProjectionOfBiasedWeakFiberProduct" ] ) then
    
        ##
        AddEpimorphismFromSomeProjectiveObjectForKernelObject( category,

        function( morphism )
            local alpha, rho_B, projection_1, projective_object;

            alpha := MorphismDatum( morphism );

            rho_B := RelationMorphism( Range( morphism ) );

            ## We use the bias in the first projection of weak fiber products
            projection_1 := ProjectionOfBiasedWeakFiberProduct( alpha, rho_B );

            projective_object := AsFreydCategoryObject( Source( projection_1 ) );

            return FreydCategoryMorphism( projective_object, projection_1, Source( morphism ) );

        end );

    fi;

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
    if is_possible_to_install( "Lift, Colift",
                               [ "SolveLinearSystemInAbCategory" ] ) then
        
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
              [ rho_A, AdditiveInverseForMorphisms( IdentityMorphism( R_A ) ), ZeroMorphism( R_A, A ) ],
              [ IdentityMorphism( A ), ZeroMorphism( A, R_A ), AdditiveInverseForMorphisms( IdentityMorphism( A ) ) ]
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
              [ rho_A, AdditiveInverseForMorphisms( IdentityMorphism( R_A ) ), ZeroMorphism( R_A, B ) ],
              [ alpha, ZeroMorphism( B, R_A ), AdditiveInverseForMorphisms( IdentityMorphism( B ) ) ]
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
    if is_possible_to_install( "Homomorphism structure",
                               [ "DistinguishedObjectOfHomomorphismStructure" ] ) then
        
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
                    [ "ProjectionOfBiasedWeakFiberProduct", "UniversalMorphismIntoBiasedWeakFiberProduct" ],
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
    if is_possible_to_install( "TensorProductOnObjects",
                               [ "TensorProductOnObjects", "TensorProductOnMorphismsWithGivenTensorProducts" ] ) then
        
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
        
    fi;
    
    # This method requires two morphisms in the Freyd category. Let us denote them as follows:
    #
    # \alpha: S_1 --- x ---> R_1,      \beta: S_2 --- y ---> R_2
    #
    # Then we compute
    # (1) S = S_1 \otimes S_2, (in the Freyd category)
    # (2) R = R_1 \otimes R_2, (in the Freyd category)
    # (3) x \otimes y (in the underlying category)
    # The method now returns the morphism S --- x \otimes y ---> R.
    
    
    if is_possible_to_install( "TensorProductOnMorphismsWithGivenTensorProducts",
                               [ "TensorProductOnMorphismsWithGivenTensorProducts" ] ) then
        
        AddTensorProductOnMorphismsWithGivenTensorProducts( category,
            function( source, morphism1, morphism2, range )
                local mor;
                
                mor := TensorProductOnMorphisms( MorphismDatum( morphism1 ), MorphismDatum( morphism2 ) );
                
                return FreydCategoryMorphism( source, mor, range );
                
        end );
        
    fi;
    
    # The tensor unit is 0 ---> 1 where 0 is the zero object and 1 the tensor unit in the underlying category
    # and the morphism is the universal morphism from the zero object.
    if is_possible_to_install( "TensorUnit", [ "TensorUnit" ] ) then
        
        AddTensorUnit( category,
            function( )
            
            return FreydCategoryObject( UniversalMorphismFromZeroObject( TensorUnit( underlying_category ) ) );
            
        end );
        
    fi;
    
    # Given three objects a, b, c in the Freyd category, we consider
    # (1) source = ( a \otimes b ) \otimes c
    # (2) range = a \otimes ( b \otimes c ).
    # We then derive the associator associator source -> range from the associator in the underlying category.
    # Note that even if the underlying category is a strict monoidal category
    # (i.e. the associators and unitors are identities), this need not be true in the Freyd category.
    if is_possible_to_install( "AssociatorLeftToRightWithGivenTensorProducts", [ "AssociatorLeftToRightWithGivenTensorProducts" ] ) then
        
        AddAssociatorLeftToRightWithGivenTensorProducts( category,
            function( source, a, b, c, range )
                local mor;
                
                mor := AssociatorLeftToRight( Range( RelationMorphism( a ) ),
                                              Range( RelationMorphism( b ) ),
                                              Range( RelationMorphism( c ) ) );
                
                return FreydCategoryMorphism( source, mor, range );
                
        end );
        
    fi;

    # Given three objects a, b, c in the Freyd category, we consider
    # (1) source = a \otimes ( b \otimes c )
    # (2) range = ( a \otimes b ) \otimes c.
    # We then derive the associator associator source -> range from the associator in the underlying category.
    # Note that even if the underlying category is a strict monoidal category
    # (i.e. the associators and unitors are identities), this need not be true in the Freyd category.
    if is_possible_to_install( "AssociatorRightToLeftWithGivenTensorProducts", [ "AssociatorRightToLeftWithGivenTensorProducts" ] ) then
        
        AddAssociatorRightToLeftWithGivenTensorProducts( category,
            function( source, a, b, c, range )
                local mor;
                
                mor := AssociatorRightToLeft( Range( RelationMorphism( a ) ),
                                              Range( RelationMorphism( b ) ),
                                              Range( RelationMorphism( c ) ) );
                
                return FreydCategoryMorphism( source, mor, range );
                
        end );
        
    fi;
    
    # Given an object a, this method returns the left unitor 1 \otimes a -> a.
    # We derive this from the unitors of the underlying category.
    if is_possible_to_install( "LeftUnitorWithGivenTensorProduct", [ "LeftUnitorWithGivenTensorProduct" ] ) then
        
        AddLeftUnitorWithGivenTensorProduct( category,
            function( a, s )
            
            return FreydCategoryMorphism( s, LeftUnitor( Range( RelationMorphism( a ) ) ), a );
            
        end );
        
    fi;
    
    # Given an object a, this method returns the left unitor inverse a -> 1 \otimes a.
    # We derive from the underlying category.
    if is_possible_to_install( "LeftUnitorInverseWithGivenTensorProduct", [ "LeftUnitorInverseWithGivenTensorProduct" ] ) then
        
        AddLeftUnitorInverseWithGivenTensorProduct( category,
            function( a, r )
            
            return FreydCategoryMorphism( a, LeftUnitorInverse( Range( RelationMorphism( a ) ) ), r );
            
        end );
        
    fi;
    
    # Given an object a, this method returns the right unitor a \otimes 1 -> a.
    # We derive from the underlying category.
    if is_possible_to_install( "RightUnitorWithGivenTensorProduct", [ "RightUnitorWithGivenTensorProduct" ] ) then
        
        AddRightUnitorWithGivenTensorProduct( category,
            function( a, s )
            
            return FreydCategoryMorphism( s, RightUnitor( Range( RelationMorphism( a ) ) ), a );
            
        end );
        
    fi;
    
    # Given an object a, this method returns the right unitor inverse a -> a \otimes 1.
    # We derive from the underlying proj-category.
    if is_possible_to_install( "RightUnitorInverseWithGivenTensorProduct", [ "RightUnitorInverseWithGivenTensorProduct" ] ) then
        
        AddRightUnitorInverseWithGivenTensorProduct( category,
            function( a, r )
            
            return FreydCategoryMorphism( a, RightUnitorInverse( Range( RelationMorphism( a ) ) ), r );
            
        end );
        
    fi;
    
    
    ######################################################################
    #
    # Symmetric Monoidal Structure
    # (i.e. braiding and its inverse given by B_a,b^{-1} = B_{b,a}
    #
    ######################################################################

    # Given two objects a and b this method derives a braiding morphism a \otimes b -> b \otimes a
    # from the braiding in the underlying category.
    
    if is_possible_to_install( "BraidingWithGivenTensorProducts", [ "BraidingWithGivenTensorProducts" ] ) then
        
        AddBraidingWithGivenTensorProducts( category,
        function( s, a, b, r)
            local mor;
            
            mor := Braiding( Range( RelationMorphism( a ) ), Range( RelationMorphism( b ) ) );
            return FreydCategoryMorphism( s, mor, r );
            
        end );
        
    fi;
    
    
    ######################################################################
    #
    # Symmetric Closed Monoidal Structure
    #
    ######################################################################

    # Given two Freyd objects a = (A <- RA) and b = (B <- RB) we compute Hom( a, b ).
    # To this end, we first use the following exact sequence:
    #
    # 0 -> Hom( a,b ) -> Hom( A, b ) -> Hom( R_1, b )
    #
    # Subsequently, we compute Hom( A, b ), Hom( R_1, b ) and their mapping. This we achieve by
    # noting that:
    # 
    # Hom( A, b ) = FreydCategoryObject( Hom( A, B ) <-- Hom( A, RB ) )
    # Hom( RA, b ) = FreydCategoryObject( Hom( RA, B ) <-- HOm( RA, RB ) )
    #
    # and the morphism in question is given by
    # Hom( A, B ) --> Hom( RA, B )
    #
    # Of this morphism we compute the kernel
    
    if is_possible_to_install( "InternalHomOnObjects", 
                               [ "InternalHomOnMorphismsWithGivenInternalHoms", "ProjectionOfBiasedWeakFiberProduct", "UniversalMorphismIntoBiasedWeakFiberProduct" ] ) then
        
        AddInternalHomOnObjects( category,
            function( a, b )
            
            return Source( INTERNAL_HOM_EMBEDDING( a, b ) );
            
        end );
        
    fi;
    
    # Given two morphisms \alpha and \beta, this method derives the internal hom, i.e. Hom( \alpha, \beta).
    # Assume that \alpha: a -> a' and \beta: b -> b' and the objects 
    # a,a',b,b' are given by relation morphisms R_X -> X for x \in \{ a, a', b, b')
    # Then we wish to construct a morphism Hom( a', b ) -> Hom( a, b' ).
    # We construct this morphism by repeating the strategy for the computation of the internal hom on objects.
    # Explicitly, we look at the following diagram
    #
    # 0 -> Hom( a', b ) --kernel1--> Hom( A', b ) ---> Hom( R_A', b )
    #                                       |
    #                                       |
    #                                      rho
    #                                       |
    #                                       v
    # 0 -> Hom( a, b' ) --kernel2--> Hom( A, b' ) ---> Hom( R_A, b' )
    #
    # We compute kernel1 and kernel2 by using the INTERNAL_HOM_EMBEDDING method.
    #
    # To compute the map rho, we note that
    # (i)  Hom( A', b ) = FreydObject( Hom( A', R_B ) -> Hom( A', B ) )
    # (ii) Hom( A, b' ) = FreydObject( Hom( A, R_B' ) -> Hom( A, B' ) )
    # Therefore, we just need to construct a mapping in the underlying category
    # rho : Hom( A', R_B ) -> Hom( A, R_B' )
    # This we achieve by using the morphism datums of alpha, beta. These are
    # MorphismDatum( alpha ) = A -> A'
    # MorphismDatum( beta ) = B -> B'
    # Consequently InternalHomOnMorphisms( MorphismDatum( alpha ), MorphismDatum( beta ) ) is exactly
    # the morphism that we are looking for. It gives rise to a morphism rho in FreydCategory.
    #
    # Finally, Lift( rho \circ kernel1, kernel2 ) produces the required mapping mu: Hom( a',b) -> Hom( a, b')
    
    if is_possible_to_install( "InternalHomOnMorphismsWithGivenInternalHoms", 
                               [ "InternalHomOnMorphismsWithGivenInternalHoms", "ProjectionOfBiasedWeakFiberProduct", "UniversalMorphismIntoBiasedWeakFiberProduct" ] ) then
                               
        AddInternalHomOnMorphismsWithGivenInternalHoms( category,
            function( s, alpha, beta, r )
                local kernel1, kernel2, mor, bridge_mapping;
                
                # (1) extract the Hom-embeddings
                kernel1 := INTERNAL_HOM_EMBEDDING( Range( alpha ), Source( beta ) );
                kernel2 := INTERNAL_HOM_EMBEDDING( Source( alpha ), Range( beta ) );
                
                # (2) construct the bridge_mapping A^vee \otimes B -> A'^\vee \otimes b'
                mor := InternalHomOnMorphisms( MorphismDatum( alpha ), MorphismDatum( beta ) );
                bridge_mapping := FreydCategoryMorphism( Range( kernel1 ), mor, Range( kernel2 ) );
                
                # (3) finally return the lift of the corresponding diagram
                return LiftAlongMonomorphism( kernel2, PreCompose( kernel1, bridge_mapping ) );
                
        end );
        
    fi;
    
    ######################################################################
    #
    # (Co-)evaluation
    #
    ######################################################################
    
    # Given objects A,B in Freyd, we can construct the evaluation morphism Hom( A, B ) \otimes A -> B.
    # To this end let us assume that A: R_a --rho_a--> a and B: R_b --rho_b--> b. Then consider the following diagram:
    #
    # Hom( A, B ) \otimes B               ---> B
    #           |                       ---    ^
    #           | Hom_emb          colift c    |
    #           v              ----            |
    # Hom( a,B ) \otimes A ----                |
    #           ^                              |
    #           | beta                         | delta
    #           |                              |
    # Hom( a,B ) \otimes a                     |
    #           ^                              |
    #           | alpha                        |
    #           |               gamma          |
    # Hom( a,b ) \otimes a ------------------> b
    #
    # The composition of the Hom_embedding "Hom_emb" and of the colift "c" is the evaluation morphism.
    # Below we denote alpha beta as epi_concat and gamma delta as eval_concat.
    
    if is_possible_to_install( "EvaluationMorphismWithGivenSource",
                                [ "InternalHomOnMorphismsWithGivenInternalHoms", "ProjectionOfBiasedWeakFiberProduct", 
                                  "UniversalMorphismIntoBiasedWeakFiberProduct", "TensorProductOnObjects",
                                  "TensorProductOnMorphismsWithGivenTensorProducts", "EvaluationMorphismWithGivenSource" ] ) then
        
        AddEvaluationMorphismWithGivenSource( category,
            function( A, B, S )
                local a, b, emb_a, emb_b, proj_A, proj_B, id_emb_a, Hom_embedding, Hom_emb_aB, epi_concat, eval_concat, colift_along_epi;
                
                # (0) define quantities
                a := Range( RelationMorphism( A ) );
                b := Range( RelationMorphism( B ) );
                emb_a := AsFreydCategoryObject( a );
                emb_b := AsFreydCategoryObject( b );
                proj_A := EpimorphismFromSomeProjectiveObject( A );
                proj_B := EpimorphismFromSomeProjectiveObject( B );
                id_emb_a := IdentityMorphism( emb_a );
                
                # (1) the hom-embedding
                Hom_embedding := InternalHomOnMorphisms( proj_A, IdentityMorphism( B ) );
                Hom_emb_aB := Range( Hom_embedding );
                Hom_embedding := TensorProductOnMorphisms( Hom_embedding, IdentityMorphism( A ) );
                
                # (2) concatenation of epis
                epi_concat := TensorProductOnMorphisms( InternalHomOnMorphisms( id_emb_a, proj_B ), id_emb_a );
                epi_concat := PreCompose( epi_concat, TensorProductOnMorphisms( IdentityMorphism( Hom_emb_aB ), proj_A ) );
                
                # (3) compute "evaluation" fom Hom( emb_a,b ) \otimes emb_a -> b
                eval_concat := PreCompose( AsFreydCategoryMorphism( EvaluationMorphism( a, b ) ), proj_B );
                
                # (4) colift along epi
                colift_along_epi := ColiftAlongEpimorphism( epi_concat, eval_concat );

                # (5) compose to finally construct the evaluation morphism in the Freyd category
                return PreCompose( Hom_embedding, colift_along_epi );
                
        end );
        
    fi;
    
    # Given objects A,B we can construct the coevaluation morphism A -> Hom( B, A \otimes B ).
    # To this end let us assume that A: R_a --rho_a--> a and B: R_b --rho_b--> b. Then consider the following diagram:
    #
    # Hom( B, A \otimes B )                    A
    #           |           <-----             ^
    #           | mono           ---           |
    #           v                   ---        |
    # Hom( b, A \otimes B )           lift     |
    #           ^                       ---    |
    #           | beta                    ---  |
    #           |                 coev      ---|
    # Hom( b, a \otimes b ) <---------------- a
    #
    # We compute the Lift and use its morphism datum to construct the co_evaluation morphism.
    # Below we denote the concatenation of coev and beta by tau.
    
    if is_possible_to_install( "CoevaluationMorphismWithGivenRange",
                                [ "InternalHomOnMorphismsWithGivenInternalHoms", "ProjectionOfBiasedWeakFiberProduct", 
                                  "UniversalMorphismIntoBiasedWeakFiberProduct", "TensorProductOnObjects",
                                  "TensorProductOnMorphismsWithGivenTensorProducts", "CoevaluationMorphismWithGivenRange" ] ) then
        
        AddCoevaluationMorphismWithGivenRange( category,
            function( A, B, R )
                local a, b, emb_b, proj_B, A_tensor_B, proj_A_tensor_B, mono, tau, lift;

                # (0) define quantities
                a := Range( RelationMorphism( A ) );
                b := Range( RelationMorphism( B ) );
                emb_b := AsFreydCategoryObject( b );
                proj_B := EpimorphismFromSomeProjectiveObject( B );
                A_tensor_B := TensorProductOnObjects( A, B );
                proj_A_tensor_B := EpimorphismFromSomeProjectiveObject( A_tensor_B );
                
                # (1) construct monomorphism
                mono := InternalHomOnMorphisms( proj_B, IdentityMorphism( A_tensor_B ) );
            
                # (2) construct morphism from coevaluation in underlying category
                tau := PreCompose( AsFreydCategoryMorphism( CoevaluationMorphism( a,b ) ), InternalHomOnMorphisms( IdentityMorphism( emb_b ), proj_A_tensor_B ) );
                
                # (3) compute lift along mono
                lift := LiftAlongMonomorphism( mono, tau );
                
                # (4) construct the coevaluation morphism
                return FreydCategoryMorphism( A, MorphismDatum( lift ), Source( mono ) );
                
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
               [ IsFreydCategoryMorphism ],
               
  function( freyd_category_morphism )
    
    Print( Concatenation( "\n", "--------------------------------\n" ) );
    Print( "Source:\n" );
    Print( "--------------------------------\n\n" );
    Display( RelationMorphism( Source( freyd_category_morphism ) ) );
    Print( Concatenation( "\n\n", "--------------------------------", "\n" ) );
    
    Print( "Morphism datum:\n" );
    Print( "--------------------------------\n\n" );
    Display( MorphismDatum( freyd_category_morphism ) );
    Print( Concatenation( "\n\n", "--------------------------------", "\n" ) );
    
    Print( "Range:\n" );
    Print( "--------------------------------\n\n" );
    Display( RelationMorphism( Range( freyd_category_morphism ) ) );
    Print( Concatenation( "\n\n", "--------------------------------", "\n" ) );
    
    Print( "General description:\n" );
    Print( "--------------------------------\n\n" );
    Print( Concatenation( StringMutable( freyd_category_morphism ), "\n\n" ) );
    
end );


##
InstallMethod( Display,
               [ IsFreydCategoryObject ],
               
  function( freyd_category_object )
    
    Print( Concatenation( "\n", "--------------------------------\n" ) );
    Print( "Relation morphism:\n" );
    Print( "--------------------------------\n\n" );
    Display( RelationMorphism( freyd_category_object ) );
    Print( Concatenation( "\n\n", "--------------------------------", "\n" ) );
    
    Print( "General description:\n" );
    Print( "--------------------------------\n\n" );
    Print( Concatenation( StringMutable( freyd_category_object ), "\n\n" ) );
    
end );

####################################################################################
##
##  Determine properties of input category for Freyd category
##
####################################################################################

InstallGlobalFunction( IsValidInputForFreydCategory,
  function( category )
    local result, installed_ops, required_ops, i;

    # set return value
    result := true;

    # first check if the category has been finalized (i.e. no methods are to be added...)
    if not HasIsFinalized( category ) or not IsFinalized( category ) then

        Error( "Underlying category must be finalized" );
        result := false;

    fi;

    # compare required and installed methods
    required_ops := [ "IsCongruentForMorphisms",
                      "IsEqualForMorphisms",
                      "IsWellDefinedForMorphisms",
                      "IsEqualForMorphismsOnMor",
                      "PreCompose",
                      "IdentityMorphism",
                      "AdditionForMorphisms",
                      "SubtractionForMorphisms",
                      "AdditiveInverseForMorphisms",
                      "ZeroMorphism",
                      "ZeroObject",
                      "UniversalMorphismIntoZeroObject",
                      "UniversalMorphismFromZeroObject",
                      "ZeroObjectFunctorial",
                      "DirectSum",
                      "DirectSumFunctorialWithGivenDirectSums",
                      "ProjectionInFactorOfDirectSum",
                      "UniversalMorphismIntoDirectSum",
                      "InjectionOfCofactorOfDirectSum",
                      "UniversalMorphismFromDirectSum",
                      "Lift"
                      ];
    installed_ops := ListInstalledOperationsOfCategory( category );

    for i in required_ops do

      if not CanCompute( category, i ) then

        Error( Concatenation( i, " cannot be computed but is needed for an underlying category of Freyd category" ) );
        result := false;

      fi;

    od;

    # if all required methods are installed, check if the category is also additive
    if not HasIsAdditiveCategory( category ) then

      Error( "an underlying category of a Freyd category must be additive, but the attribute is not set for the category in question" );
      result := false;

    fi;

    # return result of this operation
    return result;

end );


####################################################################################
##
##  Section Powers of objects and morphisms
##
####################################################################################

# for convenience allow "*" to indicate the tensor product on objects
InstallMethod( \*,
               "powers of presentations",
               [ IsFreydCategoryObject, IsFreydCategoryObject ],
  function( freyd_object1, freyd_object2 )
    
    return TensorProductOnObjects( freyd_object1, freyd_object2 );
    
end );

# for convenience allow "*" to indicate the tensor product on morphisms
InstallMethod( \*,
               "powers of presentations",
               [ IsFreydCategoryMorphism, IsFreydCategoryMorphism ],
  function( freyd_morphism1, freyd_morphism2 )
    
    return TensorProductOnMorphisms( freyd_morphism1, freyd_morphism2 );
    
end );

# allow "^p" to indicate the p-th power, i.e. p-times tensor product of an object with itself
InstallMethod( \^,
               "powers of presentations",
               [ IsFreydCategoryObject, IsInt ],
  function( freyd_object, power )
    local res, i;
    
      if power < 0 then
      
        return Error( "The power must be non-negative! \n" );
            
      elif power = 0 then
      
        return TensorUnit( CapCategory( freyd_object ) );
      
      elif power = 1 then
      
        return freyd_object;
        
      else
      
        res := freyd_object;
        
        for i in [ 1 .. power - 1 ] do
          res := res * freyd_object;
        od;
      
        return res;
      
      fi;
    
end );

# allow "^p" to indicate the p-th power, i.e. p-times tensor product of a morphism with itself
InstallMethod( \^,
               "powers of presentations",
               [ IsFreydCategoryMorphism, IsInt ],
  function( freyd_morphism, power )
    local res, i;
    
      if power < 0 then
      
        return Error( "The power must be non-negative! \n" );
      
      elif power = 0 then
      
        return IdentityMorphism( TensorUnit( CapCategory( freyd_morphism ) ) );
      
      elif power = 1 then
      
        return freyd_morphism;
        
      else
      
        res := freyd_morphism;
        
        for i in [ 1 .. power - 1 ] do
          res := res * freyd_morphism;
        od;
        
        return res;
      
      fi;
    
end );
