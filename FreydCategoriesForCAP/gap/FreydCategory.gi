# SPDX-License-Identifier: GPL-2.0-or-later
# FreydCategoriesForCAP: Freyd categories - Formal (co)kernels for additive categories
#
# Implementations
#

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
    local name, freyd_category, conditions;
    
    if not IsValidInputForFreydCategory( underlying_category ) then
        return false;
    fi;
    
    name := Concatenation( "Freyd( ", Name( underlying_category ), " )" );
    
    freyd_category := CreateCapCategory( name );
    
    freyd_category!.category_as_first_argument := true;
    
    if IsBound( underlying_category!.supports_empty_limits ) then
        
        freyd_category!.supports_empty_limits := underlying_category!.supports_empty_limits;
        
    fi;
    
    freyd_category!.compiler_hints := rec(
        category_attribute_names := [
            "UnderlyingCategory",
        ],
        category_filter := IsFreydCategory,
        object_filter := IsFreydCategoryObject,
        morphism_filter := IsFreydCategoryMorphism,
    );
    
    SetFilterObj( freyd_category, IsFreydCategory );
    
    SetIsAdditiveCategory( freyd_category, true );
    
    SetUnderlyingCategory( freyd_category, underlying_category );
    
    if HasIsLinearCategoryOverCommutativeRing( underlying_category )
        and IsLinearCategoryOverCommutativeRing( underlying_category )
          and HasCommutativeRingOfLinearCategory( underlying_category ) then
      
      SetIsLinearCategoryOverCommutativeRing( freyd_category, true );
      
      SetCommutativeRingOfLinearCategory( freyd_category, CommutativeRingOfLinearCategory( underlying_category ) );
       
    fi;
    
    ## Freyd's theorem
    if ForAll( [ "WeakKernelEmbedding", "WeakKernelLift" ], f -> CanCompute( underlying_category, f ) ) then
        
        SetIsAbelianCategory( freyd_category, true );
        
        SetIsAbelianCategoryWithEnoughProjectives( freyd_category, true );
    
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
    
    AddObjectRepresentation( freyd_category, IsFreydCategoryObject and HasRelationMorphism );
    
    AddMorphismRepresentation( freyd_category, IsFreydCategoryMorphism and HasUnderlyingMorphism );
    
    INSTALL_FUNCTIONS_FOR_FREYD_CATEGORY( freyd_category );
    
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
    
    return AsFreydCategoryObject( FreydCategory( CapCategory( object ) ), object );
    
end );

##
InstallOtherMethodForCompilerForCAP( AsFreydCategoryObject,
                                     [ IsFreydCategory, IsCapCategoryObject ],
                                     
  function( cat, object )
    local projective_object;
    
    projective_object := FreydCategoryObject( cat, UniversalMorphismFromZeroObject( UnderlyingCategory( cat ), object ) );
    
    # CompilerForCAP cannot handle side effects
    #% CAP_JIT_DROP_NEXT_STATEMENT
    SetIsProjective( projective_object, true );
    
    return projective_object;
    
end );

##
InstallMethod( FreydCategoryObject,
               [ IsCapCategoryMorphism ],
               
  function( relation_morphism )
    
    return FreydCategoryObject( FreydCategory( CapCategory( relation_morphism ) ), relation_morphism );
    
end );

##
InstallOtherMethodForCompilerForCAP( FreydCategoryObject,
                                     [ IsFreydCategory, IsCapCategoryMorphism ],
                                     
  function( cat, relation_morphism )
    
    return ObjectConstructor( cat, relation_morphism );
    
end );

##
InstallMethod( AsFreydCategoryMorphism,
               [ IsCapCategoryMorphism ],
               
  function( morphism )
    
    return AsFreydCategoryMorphism( FreydCategory( CapCategory( morphism ) ), morphism );
    
end );

##
InstallOtherMethodForCompilerForCAP( AsFreydCategoryMorphism,
                                     [ IsFreydCategory, IsCapCategoryMorphism ],
                                     
  function( cat, morphism )
    
    return FreydCategoryMorphism( cat,
             AsFreydCategoryObject( cat, Source( morphism ) ),
             morphism,
             AsFreydCategoryObject( cat, Range( morphism ) )
           );
    
end );

##
InstallMethod( FreydCategoryMorphism,
               [ IsFreydCategoryObject, IsCapCategoryMorphism, IsFreydCategoryObject ],
               
  function( source, morphism_datum, range )
    
    return FreydCategoryMorphism( CapCategory( source ), source, morphism_datum, range );
    
end );

##
InstallOtherMethodForCompilerForCAP( FreydCategoryMorphism,
                                     [ IsFreydCategory, IsFreydCategoryObject, IsCapCategoryMorphism, IsFreydCategoryObject ],
                                     
  function( cat, source, morphism_datum, range )
    
    return MorphismConstructor( cat, source, morphism_datum, range );
    
end );

####################################
##
## Attributes
##
####################################

##
InstallMethod( MorphismWitness,
               [ IsFreydCategoryMorphism ],
               
  function( morphism )
    
    return Lift( PreCompose( ObjectDatum( Source( morphism ) ), MorphismDatum( morphism ) ), ObjectDatum( Range( morphism ) ) );
    
end );

##
InstallMethod( FREYD_CATEGORIES_SimplifyObjectTupleOp,
               [ IsFreydCategoryObject, IsObject ],
  function( object, i )
    local counter, rel, red, red_from_last_step, red_from, red_to;
    
    counter := 0;
    
    rel := ObjectDatum( object );
    
    red_from := IdentityMorphism( Range( rel ) );
    
    red_to := IdentityMorphism( Range( rel ) );
    
    while true do
      
      counter := counter + 1;
      
      red := SomeReductionBySplitEpiSummand( rel );
      
      red_from_last_step := SomeReductionBySplitEpiSummand_MorphismFromInputRange( rel );
      
      red_from := PreCompose( red_from, red_from_last_step );
      
      red_to := PreCompose( SomeReductionBySplitEpiSummand_MorphismToInputRange( rel ), red_to );
      
      if counter >= i or IsIsomorphism( red_from_last_step ) then
          
          break;
          
      fi;
      
      rel := red;
      
    od;
    
    return [ red, red_from, red_to ];
    
end );

####################################
##
## Operations
##
####################################

InstallMethod( WitnessForBeingCongruentToZero,
               [ IsFreydCategoryMorphism ],
               
  function( morphism )
    
    return WitnessForBeingCongruentToZero( CapCategory( morphism ), morphism );
    
end );

InstallOtherMethodForCompilerForCAP( WitnessForBeingCongruentToZero,
                                     [ IsFreydCategory, IsFreydCategoryMorphism ],
                                     
  function( cat, morphism )
    
    return Lift( UnderlyingCategory( cat ), MorphismDatum( cat, morphism ), ObjectDatum( cat, Range( morphism ) ) );
    
end );

InstallMethod( MereExistenceOfWitnessForBeingCongruentToZero,
               [ IsFreydCategoryMorphism ],
               
  function( morphism )
    
    return MereExistenceOfWitnessForBeingCongruentToZero( CapCategory( morphism ), morphism );
    
end );

InstallOtherMethodForCompilerForCAP( MereExistenceOfWitnessForBeingCongruentToZero,
                                     [ IsFreydCategory, IsFreydCategoryMorphism ],
                                     
  function( cat, morphism )
    
    return IsLiftable( UnderlyingCategory( cat ),  MorphismDatum( cat, morphism ), ObjectDatum( cat, Range( morphism ) ) );
    
end );

InstallMethodWithCacheFromObject( INTERNAL_HOM_EMBEDDING,
                                  [ IsFreydCategory, IsFreydCategoryObject, IsFreydCategoryObject ],
    function( cat, a, b )
      local source, range, mor;

      # compute source
      source := InternalHomOnMorphisms( UnderlyingCategory( cat ), IdentityMorphism( UnderlyingCategory( cat ), Range( ObjectDatum( cat, a ) ) ),
                                        ObjectDatum( cat, b ) );
      source := FreydCategoryObject( cat, source );
      
      # compute range
      range := InternalHomOnMorphisms( UnderlyingCategory( cat ), IdentityMorphism( UnderlyingCategory( cat ), Source( ObjectDatum( cat, a ) ) ),
                                       ObjectDatum( cat, b ) );
      range := FreydCategoryObject( cat, range );
      
      # compute mapping
      mor := InternalHomOnMorphisms( UnderlyingCategory( cat ), ObjectDatum( cat, a ),
                                     IdentityMorphism( UnderlyingCategory( cat ), Range( ObjectDatum( cat, b ) ) ) );

      # construct hom embedding
      return KernelEmbedding( cat, FreydCategoryMorphism( cat, source, mor, range ) );

end : ArgumentNumber := 2 );

####################################
##
## Basic operations
##
####################################

InstallGlobalFunction( INSTALL_FUNCTIONS_FOR_FREYD_CATEGORY,
  
  function( category )
    local underlying_category, diagram_for_homomorphism_structure_as_kernel, 
          diagram_for_homomorphism_structure_as_kernel_on_morphisms,
          distinguished_object, underlying_range_category, range_category, homomorphism_structure_derivation_case,
          homomorphism_structure_on_objects,
          homomorphism_structure_on_morphisms,
          distinguished_object_of_homomorphism_structure,
          interpret_homomorphism_as_morphism_from_dinstinguished_object_to_homomorphism_structure,
          interpret_morphism_from_dinstinguished_object_to_homomorphism_structure_as_homomorphism,
          is_possible_to_install,
          not_supported, to_be_tested,
          lift_via_linear_system_func,
          colift_via_linear_system_func;
    
    underlying_category := UnderlyingCategory( category );
    
    is_possible_to_install := function( to_be_installed, to_be_tested )
        local not_supported;
        
        # test which methods are supported by the underlying category
        not_supported := [];
        Perform( to_be_tested, function(x) if not CanCompute( underlying_category, x ) then 
                                            Add( not_supported, x );
                                         fi; end);
        
        # methods cannot be installed, so inform the user
        if not IsEmpty( not_supported ) then
            Info( InfoFreydCategoriesForCAP, 2,
                    Concatenation( "The operation(s)\n",
                                   to_be_installed,
                                    "\ncould not be installed because the underlying category cannot compute\n",
                                    JoinStringsWithSeparator( not_supported, ", " ) ) );
            return false;
        fi;
        
        # other methods can be installed
        return true;
        
    end;
    
    ##
    AddObjectConstructor( category,
      function( cat, relation_morphism )
        
        #% CAP_JIT_DROP_NEXT_STATEMENT
        CAP_INTERNAL_ASSERT_IS_MORPHISM_OF_CATEGORY( relation_morphism, UnderlyingCategory( cat ), {} -> "the object datum given to the object constructor of <cat>" );
        
        return ObjectifyObjectForCAPWithAttributes( rec( ), cat,
                                                    RelationMorphism, relation_morphism );
        
    end );
    
    ##
    AddObjectDatum( category,
      function( cat, obj )
        
        return RelationMorphism( obj );
        
    end );
    
    ##
    AddMorphismConstructor( category,
      function( cat, source, morphism_datum, range )
        
        #% CAP_JIT_DROP_NEXT_STATEMENT
        CAP_INTERNAL_ASSERT_IS_MORPHISM_OF_CATEGORY( morphism_datum, UnderlyingCategory( cat ), {} -> "the morphism datum given to the morphism constructor of <cat>" );
        
        if not IsEqualForObjects( UnderlyingCategory( cat ), Source( morphism_datum ), Range( ObjectDatum( cat, source ) ) ) then
            
            Error( "The source of the given morphism datum is not equal to the range of the relation morphism of the given source object" );
            
        fi;
        
        if not IsEqualForObjects( UnderlyingCategory( cat ), Range( morphism_datum ), Range( ObjectDatum( cat, range ) ) ) then
            
            Error( "The range of the given morphism datum is not equal to the range of the relation morphism of the given range object" );
            
        fi;
        
        return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes(
                                 rec( ), cat,
                                 source,
                                 range,
                                 UnderlyingMorphism, morphism_datum
        );
        
    end );
    
    ##
    AddMorphismDatum( category,
      function( cat, mor )
        
        return UnderlyingMorphism( mor );
        
    end );
    
    ## Well-defined for objects and morphisms
    ##
    AddIsWellDefinedForObjects( category,
      function( cat, object )
        
        if not IsWellDefinedForMorphisms( underlying_category, ObjectDatum( cat, object ) ) then
            
            return false;
            
        fi;
        
        # all tests passed, so it is well-defined
        return true;
        
    end );
    
    ##
    AddIsWellDefinedForMorphisms( category,
      function( cat, morphism )
        
        if not IsWellDefinedForMorphisms( underlying_category, MorphismDatum( cat, morphism ) ) then
            
            return false;
            
        elif not IsLiftable( underlying_category, PreCompose( underlying_category, ObjectDatum( cat, Source( morphism ) ), MorphismDatum( cat, morphism ) ), ObjectDatum( cat, Range( morphism ) ) ) then
          
          return false;
          
        fi;
        
        # all tests passed, so it is well-defined
        return true;
        
    end );
    
    ## Equality Basic Operations for Objects and Morphisms
    ##
    AddIsEqualForObjects( category,
      function( cat, object_1, object_2 )
      
        return IsEqualForMorphismsOnMor( underlying_category, ObjectDatum( cat, object_1 ), ObjectDatum( cat, object_2 ) );
      
    end );
    
    ##
    AddIsEqualForMorphisms( category,
      function( cat, morphism_1, morphism_2 )
        
        return IsEqualForMorphisms( underlying_category, MorphismDatum( cat, morphism_1 ), MorphismDatum( cat, morphism_2 ) );
        
    end );
    
    ##
    AddIsCongruentForMorphisms( category,
      function( cat, morphism_1, morphism_2 )
        
        return MereExistenceOfWitnessForBeingCongruentToZero( cat, SubtractionForMorphisms( cat, morphism_1, morphism_2 ) );
        
    end );
    
    ## Basic Operations for a Category
    ##
    AddIdentityMorphism( category,
      
      function( cat, object )
        local identity_morphism, relation_morphism;
        
        relation_morphism := ObjectDatum( cat, object );
        
        identity_morphism := FreydCategoryMorphism( cat, object, IdentityMorphism( underlying_category, Range( relation_morphism ) ), object );
        
        return identity_morphism;
        
    end );
    
    ##
    AddPreCompose( category,
      
      function( cat, morphism_1, morphism_2 )
        local composition;
        
        composition := PreCompose( underlying_category, MorphismDatum( cat, morphism_1 ), MorphismDatum( cat, morphism_2 ) );
        
        composition := FreydCategoryMorphism( cat, Source( morphism_1 ), composition, Range( morphism_2 ) );
        
        return composition;
        
    end );
    
    ## Basic Operations for an Additive Category
    ##
    
    ##
    AddAdditionForMorphisms( category,
      function( cat, morphism_1, morphism_2 )
        local addition;
        
        addition := FreydCategoryMorphism( cat,
                      Source( morphism_1 ),
                      AdditionForMorphisms( underlying_category, MorphismDatum( cat, morphism_1 ), MorphismDatum( cat, morphism_2 ) ),
                      Range( morphism_1 )
                    );
        
        return addition;
        
    end );
    
    ##
    AddAdditiveInverseForMorphisms( category,
      function( cat, morphism )
        local additive_inverse;
        
        additive_inverse := FreydCategoryMorphism( cat,
                              Source( morphism ),
                              AdditiveInverseForMorphisms( underlying_category, MorphismDatum( cat, morphism ) ),
                              Range( morphism )
                            );
        
        return additive_inverse;
        
    end );
    
    ##
    AddZeroMorphism( category,
      function( cat, source, range )
        local zero_morphism;
        
        zero_morphism := FreydCategoryMorphism( cat,
                           source,
                           ZeroMorphism( underlying_category, Range( ObjectDatum( cat, source ) ), Range( ObjectDatum( cat, range ) ) ),
                           range
                         );
        
        return zero_morphism;
        
    end );
    
    ##
    AddZeroObject( category,
      function( cat )
        
        return FreydCategoryObject( cat, ZeroObjectFunctorial( underlying_category ) );
        
    end );
    
    ##
    AddUniversalMorphismIntoZeroObjectWithGivenZeroObject( category,
      function( cat, sink, zero_object )
        local universal_morphism;
        
        universal_morphism := FreydCategoryMorphism( cat,
                                sink,
                                UniversalMorphismIntoZeroObject( underlying_category, Range( ObjectDatum( cat, sink ) ) ),
                                zero_object
                              );
        
        return universal_morphism;
        
    end );
    
    ##
    AddUniversalMorphismFromZeroObjectWithGivenZeroObject( category,
      function( cat, source, zero_object )
        local universal_morphism;
        
        universal_morphism := FreydCategoryMorphism( cat,
                                zero_object,
                                UniversalMorphismFromZeroObject( underlying_category, Range( ObjectDatum( cat, source ) ) ),
                                source
                              );
        
        return universal_morphism;
        
    end );
    
    ##
    AddIsZeroForMorphisms( category,
      function( cat, mor )
        
        return MereExistenceOfWitnessForBeingCongruentToZero( cat, mor );
        
    end );
    
    ##
    AddDirectSum( category,
      function( cat, object_list )
        
        return FreydCategoryObject( cat, DirectSumFunctorial( underlying_category, List( object_list, obj -> ObjectDatum( cat, obj ) ) ) );
        
    end );
    
    ##
    AddDirectSumFunctorialWithGivenDirectSums( category,
      function( cat, direct_sum_source, source_diagram, diagram, range_diagram, direct_sum_range )
        
        return FreydCategoryMorphism( cat, direct_sum_source,
                                      DirectSumFunctorial( underlying_category, List( diagram, x -> MorphismDatum( cat, x ) ) ),
                                      direct_sum_range );
        
    end );
    
    ##
    AddProjectionInFactorOfDirectSumWithGivenDirectSum( category,
      function( cat, object_list, projection_number, direct_sum_object )
        
        return FreydCategoryMorphism( cat, direct_sum_object,
                                      ProjectionInFactorOfDirectSum( underlying_category, List( object_list, obj -> Range( ObjectDatum( cat, obj ) ) ), projection_number ),
                                      object_list[projection_number]
                                    );
        
    end );
    
    ##
    AddUniversalMorphismIntoDirectSumWithGivenDirectSum( category,
      function( cat, diagram, test_object, source, direct_sum_object )
        
        return FreydCategoryMorphism( cat, test_object,
                                      UniversalMorphismIntoDirectSum( underlying_category,
                                                                      List( diagram, obj -> Range( ObjectDatum( cat, obj ) ) ),
                                                                      Range( ObjectDatum( cat, test_object ) ),
                                                                      List( source, mor -> MorphismDatum( cat, mor ) ) ),
                                      direct_sum_object
                                    );
        
    end );
    
    ##
    AddInjectionOfCofactorOfDirectSumWithGivenDirectSum( category,
      function( cat, object_list, injection_number, direct_sum_object )
        
        return FreydCategoryMorphism( cat, object_list[injection_number],
                                      InjectionOfCofactorOfDirectSum( underlying_category, List( object_list, obj -> Range( ObjectDatum( cat, obj ) ) ), injection_number ),
                                      direct_sum_object
                                    );
        
    end );
    
    ##
    AddUniversalMorphismFromDirectSumWithGivenDirectSum( category,
      function( cat, diagram, test_object, sink, direct_sum_object )
        
        return FreydCategoryMorphism( cat, direct_sum_object,
                                      UniversalMorphismFromDirectSum( underlying_category,
                                                                      List( diagram, obj -> Range( ObjectDatum( cat, obj ) ) ),
                                                                      Range( ObjectDatum( cat, test_object ) ),
                                                                      List( sink, mor -> MorphismDatum( cat, mor ) ) ),
                                      test_object
                                    );
        
    end );
    
    ## Cokernels: cokernels in Freyd categories are formal and thus very cheap
    AddCokernelProjection( category,
                     
      function( cat, morphism )
        local range, relation_morphism, cokernel_object, cokernel_projection;
        
        range := Range( morphism );
        
        relation_morphism := ObjectDatum( cat, range );
        
        cokernel_object := FreydCategoryObject( cat,
            UniversalMorphismFromDirectSum( underlying_category,
                [ Source( relation_morphism ), Source( MorphismDatum( cat, morphism ) ) ],
                Range( relation_morphism ),
                [ relation_morphism, MorphismDatum( cat, morphism ) ]
            )
        );
        
        cokernel_projection := FreydCategoryMorphism( cat, range,
                                                      IdentityMorphism( underlying_category, Range( relation_morphism ) ),
                                                      cokernel_object );
        
        return cokernel_projection;
        
    end );
    
    ##
    AddCokernelColiftWithGivenCokernelObject( category,
      
      function( cat, morphism, test_object, test_morphism, cokernel_object )
        
        return FreydCategoryMorphism( cat, cokernel_object,
                                      MorphismDatum( cat, test_morphism ),
                                      Range( test_morphism ) );
        
    end );
    
    if is_possible_to_install( "MultiplyWithElementOfCommutativeRingForMorphisms",
                               [ "MultiplyWithElementOfCommutativeRingForMorphisms" ] ) then
        
        AddMultiplyWithElementOfCommutativeRingForMorphisms( category,
          { cat, r, alpha } -> FreydCategoryMorphism( cat,
                              Source( alpha ),
                              MultiplyWithElementOfCommutativeRingForMorphisms( underlying_category, r, MorphismDatum( cat, alpha ) ),
                              Range( alpha )
                            )
        );
    
    fi;
    
    if is_possible_to_install( "KernelEmbedding",
                               [ "ProjectionOfBiasedWeakFiberProduct" ] ) then
    
        ## Kernels: kernels in Freyd categories are based on weak fiber products in the underlying category and thus more expensive
        AddKernelEmbedding( category,
          
          function( cat, morphism )
            local alpha, rho_B, rho_A, projection_1, projection_2, kernel_object;
            
            alpha := MorphismDatum( cat, morphism );
            
            rho_B := ObjectDatum( cat, Range( morphism ) );
            
            rho_A := ObjectDatum( cat, Source( morphism ) );
            
            ## We use the bias in the first projection of weak fiber products
            projection_1 := ProjectionOfBiasedWeakFiberProduct( underlying_category, alpha, rho_B );
            
            projection_2 := ProjectionOfBiasedWeakFiberProduct( underlying_category, projection_1, rho_A );
            
            kernel_object := FreydCategoryObject( cat, projection_2 );
            
            return FreydCategoryMorphism( cat, kernel_object,
                                          projection_1,
                                          Source( morphism ) );
            
        end );
    
    fi;
    
    if is_possible_to_install( "KernelLiftWithGivenKernelObject",
                               [ "UniversalMorphismIntoBiasedWeakFiberProduct" ] ) then
        ##
        AddKernelLiftWithGivenKernelObject( category,
                                            
          function( cat, morphism, test_object, test_morphism, kernel_object )
            local sigma, alpha, rho_B, tau, morphism_datum;
            
            ## for notational convenience
            alpha := MorphismDatum( cat, morphism );
            
            rho_B := ObjectDatum( cat, Range( morphism ) );
            
            tau := MorphismDatum( cat, test_morphism );
            
            morphism_datum := UniversalMorphismIntoBiasedWeakFiberProduct( underlying_category, alpha, rho_B, tau );
            
            return FreydCategoryMorphism( cat, Source( test_morphism ),
                                          morphism_datum,
                                          kernel_object );
            
        end );

    fi;
    
    if is_possible_to_install( "LiftAlongMonomorphism, ColiftAlongEpimorphism",
                               [ "Lift" ] ) then ## Lift is implicit in WitnessForBeingCongruentToZero
        
        ##
        AddLiftAlongMonomorphism( category,
            
            function( cat, alpha, test_morphism )
            local sigma, R_B, A, tau_A;
            
            sigma := WitnessForBeingCongruentToZero( cat, PreCompose( cat, test_morphism, CokernelProjection( cat, alpha ) ) );
            
            R_B := Source( ObjectDatum( cat, Range( alpha ) ) );
            
            A := Range( ObjectDatum( cat, Source( alpha ) ) );
            
            tau_A := ComponentOfMorphismIntoDirectSum( underlying_category, sigma, [ R_B, A ], 2 );
            
            return FreydCategoryMorphism( cat, Source( test_morphism ), tau_A, Source( alpha ) );
        
        end, 200 ); # should be as expensive as ColiftAlongEpimorphism, see below
        
        ##
        AddColiftAlongEpimorphism( category,
            
            function( cat, alpha, test_morphism )
            local witness, R_B, A, sigma_A;
            
            witness := WitnessForBeingCongruentToZero( cat, CokernelProjection( cat, alpha ) );
            
            R_B := Source( ObjectDatum( cat, Range( alpha ) ) );
            
            A := Range( ObjectDatum( cat, Source( alpha ) ) );
            
            sigma_A := ComponentOfMorphismIntoDirectSum( underlying_category, witness, [ R_B, A ], 2 );
            
            return FreydCategoryMorphism( cat, Range( alpha ), PreCompose( underlying_category, sigma_A, MorphismDatum( cat, test_morphism ) ), Range( test_morphism ) );
        
        end, 200 ); # must be more expensive than CokernelColiftWithGivenCokernelObject but cheaper than Colift
        
    fi;
    
    if is_possible_to_install( "EpimorphismFromSomeProjectiveObjectForKernelObject",
                               [ "ProjectionOfBiasedWeakFiberProduct" ] ) then
    
        ##
        AddEpimorphismFromSomeProjectiveObjectForKernelObject( category,

        function( cat, morphism )
            local alpha, rho_B, projection_1, projective_object;

            alpha := MorphismDatum( cat, morphism );

            rho_B := ObjectDatum( cat, Range( morphism ) );

            ## We use the bias in the first projection of weak fiber products
            projection_1 := ProjectionOfBiasedWeakFiberProduct( underlying_category, alpha, rho_B );

            projective_object := AsFreydCategoryObject( cat, Source( projection_1 ) );

            return FreydCategoryMorphism( cat, projective_object, projection_1, Source( morphism ) );

        end );

    fi;

    ##
    AddEpimorphismFromSomeProjectiveObject( category,
                          
      function( cat, object )
        local range;
        
        range := Range( ObjectDatum( cat, object ) );
        
        return FreydCategoryMorphism( cat,
                 AsFreydCategoryObject( cat, range ),
                 IdentityMorphism( underlying_category, range ),
                 object
               );
        
    end );
    
    lift_via_linear_system_func := function( cat, alpha_freyd, gamma_freyd )
            local rho_A, rho_B, rho_C, alpha, gamma, A, B, C, R_A, R_B, R_C, left_coefficients, right_coefficients, right_side;
            #% CAP_JIT_RESOLVE_FUNCTION
            
            rho_A := ObjectDatum( cat, Source( alpha_freyd ) );
            
            rho_B := ObjectDatum( cat, Range( alpha_freyd ) );
            
            rho_C := ObjectDatum( cat, Source( gamma_freyd ) );
            
            alpha := MorphismDatum( cat, alpha_freyd );
            
            gamma := MorphismDatum( cat, gamma_freyd );
            
            ##
            
            A := Range( rho_A );
            
            B := Range( rho_B );
            
            C := Range( rho_C );
            
            R_A := Source( rho_A );
            
            R_B := Source( rho_B );
            
            R_C := Source( rho_C );
            
            ##
            
            left_coefficients := [
              [ rho_A, AdditiveInverseForMorphisms( underlying_category, IdentityMorphism( underlying_category, R_A ) ), ZeroMorphism( underlying_category, R_A, A ) ],
              [ IdentityMorphism( underlying_category, A ), ZeroMorphism( underlying_category, A, R_A ), AdditiveInverseForMorphisms( underlying_category, IdentityMorphism( underlying_category, A ) ) ]
            ];
            
            right_coefficients := [
              [ IdentityMorphism( underlying_category, C ), rho_C, ZeroMorphism( underlying_category, R_B, C ) ],
              [ gamma, ZeroMorphism( underlying_category, R_C, B ), rho_B ]
            ];
            
            right_side := [ ZeroMorphism( underlying_category, R_A, C ), alpha ];
            
            return [ left_coefficients, right_coefficients, right_side ];
            
        end;
    
    colift_via_linear_system_func := function( cat, alpha_freyd, gamma_freyd )
            local rho_A, rho_B, rho_C, alpha, gamma, A, B, C, R_A, R_B, R_C, left_coefficients, right_coefficients, right_side;
            #% CAP_JIT_RESOLVE_FUNCTION
            
            rho_A := ObjectDatum( cat, Range( alpha_freyd ) );
            
            rho_B := ObjectDatum( cat, Source( alpha_freyd ) );
            
            rho_C := ObjectDatum( cat, Range( gamma_freyd ) );
            
            alpha := MorphismDatum( cat, alpha_freyd );
            
            gamma := MorphismDatum( cat, gamma_freyd );
            
            ##
            
            A := Range( rho_A );
            
            B := Range( rho_B );
            
            C := Range( rho_C );
            
            R_A := Source( rho_A );
            
            R_B := Source( rho_B );
            
            R_C := Source( rho_C );
            
            ##
            
            left_coefficients := [
              [ rho_A, AdditiveInverseForMorphisms( underlying_category, IdentityMorphism( underlying_category, R_A ) ), ZeroMorphism( underlying_category, R_A, B ) ],
              [ alpha, ZeroMorphism( underlying_category, B, R_A ), AdditiveInverseForMorphisms( underlying_category, IdentityMorphism( underlying_category, B ) ) ]
            ];
            
            right_coefficients := [
              [ IdentityMorphism( underlying_category, C ), rho_C, ZeroMorphism( underlying_category, R_C, C ) ],
              [ IdentityMorphism( underlying_category, C ), ZeroMorphism( underlying_category, R_C, C ), rho_C ]
            ];
            
            right_side := [ ZeroMorphism( underlying_category, R_A, C ), gamma ];
            
            return [ left_coefficients, right_coefficients, right_side ];
            
        end;
    
    ##
    if is_possible_to_install( "Lift, Colift",
                               [ "SolveLinearSystemInAbCategory" ] ) then
        
        ##
        AddLift( category,
                 
          function( cat, alpha_freyd, gamma_freyd )
            local data, solution;
            
            data := lift_via_linear_system_func( cat, alpha_freyd, gamma_freyd );
            
            solution := SolveLinearSystemInAbCategory( underlying_category, data[1], data[2], data[3] );
            
            return FreydCategoryMorphism( cat, Source( alpha_freyd ), solution[1], Source( gamma_freyd ) );
            
        end, 300 );
        
        ##
        AddColift( category,
                 
          function( cat, alpha_freyd, gamma_freyd )
            local data, solution;
            
            data := colift_via_linear_system_func( cat, alpha_freyd, gamma_freyd );
            
            solution := SolveLinearSystemInAbCategory( underlying_category, data[1], data[2], data[3] );
            
            return FreydCategoryMorphism( cat, Range( alpha_freyd ), solution[1], Range( gamma_freyd ) );
            
        end, 300 );

    fi;
    
    ##
    if is_possible_to_install( "IsLiftable, IsColiftable",
                               [ "MereExistenceOfSolutionOfLinearSystemInAbCategory" ] ) then
        ##
        AddIsLiftable( category,
                 
          function( cat, alpha_freyd, gamma_freyd )
            local data;
            
            data := lift_via_linear_system_func( cat, alpha_freyd, gamma_freyd );
            
            return MereExistenceOfSolutionOfLinearSystemInAbCategory( underlying_category, data[1], data[2], data[3] );
            
        end, 200 );
        
        ##
        AddIsColiftable( category,
                 
          function( cat, alpha_freyd, gamma_freyd )
            local data;
            
            data := colift_via_linear_system_func( cat, alpha_freyd, gamma_freyd );
            
            return MereExistenceOfSolutionOfLinearSystemInAbCategory( underlying_category, data[1], data[2], data[3] );
            
        end, 200 );
        
    fi;
    
    
    
    ## Creation of a homomorphism structure for the Freyd category
    if is_possible_to_install( "Homomorphism structure",
                               [ "DistinguishedObjectOfHomomorphismStructure" ] ) then
        
        distinguished_object := DistinguishedObjectOfHomomorphismStructure( underlying_category );
        
        underlying_range_category := CapCategory( distinguished_object );
        
        ## 3 possible cases:
        ## 1) the range category is abelian
        ## 2) one could apply the Freyd category constructor to the range category to make it abelian
        ## 3) else
        if HasIsAbelianCategory( underlying_range_category )
            and IsAbelianCategory( underlying_range_category )
            and HasIsProjective( distinguished_object )
            and IsProjective( distinguished_object ) then
            
            SetRangeCategoryOfHomomorphismStructure( category, underlying_range_category );
            
            homomorphism_structure_derivation_case := "abelian";
            
            homomorphism_structure_on_objects := HomomorphismStructureOnObjects;
            
            homomorphism_structure_on_morphisms := HomomorphismStructureOnMorphisms;
            
            distinguished_object_of_homomorphism_structure := DistinguishedObjectOfHomomorphismStructure;
            
            interpret_homomorphism_as_morphism_from_dinstinguished_object_to_homomorphism_structure :=
              InterpretMorphismAsMorphismFromDistinguishedObjectToHomomorphismStructure;
            
            interpret_morphism_from_dinstinguished_object_to_homomorphism_structure_as_homomorphism :=
              InterpretMorphismFromDistinguishedObjectToHomomorphismStructureAsMorphism;
            
        elif HasIsAdditiveCategory( underlying_range_category )
                and IsAdditiveCategory( underlying_range_category )
                and ForAll(
                    [ "ProjectionOfBiasedWeakFiberProduct", "UniversalMorphismIntoBiasedWeakFiberProduct" ],
                    f -> CanCompute( underlying_range_category, f ) )  then
            
            if IsIdenticalObj( underlying_range_category, underlying_category ) then
                
                range_category := category;
                
            else
                
                range_category := FreydCategory( underlying_range_category : FinalizeCategory := true );
                
            fi;
            
            SetRangeCategoryOfHomomorphismStructure( category, range_category );
            
            homomorphism_structure_derivation_case := "apply_freyd";
            
            homomorphism_structure_on_objects :=
              function( A, B ) return AsFreydCategoryObject( range_category, HomomorphismStructureOnObjects( A, B ) ); end;
            
            homomorphism_structure_on_morphisms := 
              function( alpha, beta ) return AsFreydCategoryMorphism( range_category, HomomorphismStructureOnMorphisms( alpha, beta ) ); end;
            
            distinguished_object_of_homomorphism_structure := 
              cat -> AsFreydCategoryObject( range_category, DistinguishedObjectOfHomomorphismStructure( cat ) );
            
            interpret_homomorphism_as_morphism_from_dinstinguished_object_to_homomorphism_structure :=
              alpha -> AsFreydCategoryMorphism( range_category,
                        InterpretMorphismAsMorphismFromDistinguishedObjectToHomomorphismStructure( alpha )
                      );
            
            interpret_morphism_from_dinstinguished_object_to_homomorphism_structure_as_homomorphism :=
              function( A, B, alpha )
                
                return InterpretMorphismFromDistinguishedObjectToHomomorphismStructureAsMorphism(
                        A, B, MorphismDatum( alpha ) );
              
              end;
              
        else
            
            homomorphism_structure_derivation_case := "none";
            
        fi;
        
        if not homomorphism_structure_derivation_case = "none" then
            
            diagram_for_homomorphism_structure_as_kernel := FunctionWithCache(
            
            function( object_A, object_B )
              local rho_A, rho_B, A, B, R_A, R_B, mor_1, mor_2;
              
              rho_A := ObjectDatum( object_A );
              
              rho_B := ObjectDatum( object_B );
              
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
              function( cat, object_A, object_B )
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
                
                rho_B := ObjectDatum( object_B );
                
                rho_Bp := ObjectDatum( object_Bp );
                
                A := Range( ObjectDatum( object_A ) );
                
                Ap := Range( ObjectDatum( object_Ap ) );
                
                mor_1 := homomorphism_structure_on_morphisms( IdentityMorphism( A ), rho_B );
                
                mor_2 := PreCompose(
                            homomorphism_structure_on_morphisms( MorphismDatum( alpha ), MorphismDatum( beta ) ),
                            CokernelProjection( homomorphism_structure_on_morphisms( IdentityMorphism( Ap ), rho_Bp ) )
                          );
                
                return CokernelColift( mor_1, mor_2 );
                
            end;
            
            ##
            AddHomomorphismStructureOnMorphismsWithGivenObjects( category,
              function( cat, source, alpha, beta, range )
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
              function( cat )
                
                return distinguished_object_of_homomorphism_structure( underlying_category );
                
            end );
            
            AddInterpretMorphismAsMorphismFromDistinguishedObjectToHomomorphismStructure( category,
              function( cat, alpha )
                local phi, interpretation, diagram;
                
                phi := MorphismDatum( cat, alpha );
                
                interpretation := 
                    interpret_homomorphism_as_morphism_from_dinstinguished_object_to_homomorphism_structure( phi );
                
                diagram := diagram_for_homomorphism_structure_as_kernel( Source( alpha ), Range( alpha ) );
                
                return KernelLift( diagram[1], PreCompose( interpretation, CokernelProjection( diagram[2] ) ) );
                
            end );
        
            ##
            AddInterpretMorphismFromDistinguishedObjectToHomomorphismStructureAsMorphism( category,
              function( cat, A, B, morphism )
                local diagram, embedding, epsilon, lift, interpretation;
                
                diagram := diagram_for_homomorphism_structure_as_kernel( A, B );
                
                embedding := KernelEmbedding( diagram[1] );
                
                epsilon := CokernelProjection( diagram[2] );
                
                lift := ProjectiveLift( PreCompose( morphism, embedding ), epsilon );
                
                interpretation := 
                  interpret_morphism_from_dinstinguished_object_to_homomorphism_structure_as_homomorphism(
                    Range( ObjectDatum( A ) ), Range( ObjectDatum( B ) ), lift );
                
                return FreydCategoryMorphism( cat, A, interpretation, B );
                
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
            function( cat, object1, object2 )
                local factor1, factor2, range, diagram, mor1, mor2, sink, uni;
                
                # construct the objects needed in the computation of the tensor product
                factor1 := TensorProductOnObjects( underlying_category, Source( ObjectDatum( cat, object1 ) ), Range( ObjectDatum( cat, object2 ) ) );
                factor2 := TensorProductOnObjects( underlying_category, Range( ObjectDatum( cat, object1 ) ), Source( ObjectDatum( cat, object2 ) ) );
                range := TensorProductOnObjects( underlying_category, Range( ObjectDatum( cat, object1 ) ), Range( ObjectDatum( cat, object2 ) ) );
                
                # construct the diagram
                diagram := [ factor1, factor2 ];
                
                # construct the sink
                mor1 := TensorProductOnMorphisms( underlying_category, ObjectDatum( cat, object1 ), IdentityMorphism( underlying_category, Range( ObjectDatum( cat, object2 ) ) ) );
                mor2 := TensorProductOnMorphisms( underlying_category, IdentityMorphism( underlying_category, Range( ObjectDatum( cat, object1 ) ) ), ObjectDatum( cat, object2 ) );
                sink := [ mor1, mor2 ];
                
                # compute the universal morphism
                uni := UniversalMorphismFromDirectSum( underlying_category, diagram, range, sink );
                
                # and return the corresponding object in the Freyd category
                return FreydCategoryObject( cat, uni );
                
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
            function( cat, source, morphism1, morphism2, range )
                local mor;
                
                mor := TensorProductOnMorphisms( underlying_category, MorphismDatum( cat, morphism1 ), MorphismDatum( cat, morphism2 ) );
                
                return FreydCategoryMorphism( cat, source, mor, range );
                
        end );
        
    fi;
    
    # The tensor unit is 0 ---> 1 where 0 is the zero object and 1 the tensor unit in the underlying category
    # and the morphism is the universal morphism from the zero object.
    if is_possible_to_install( "TensorUnit", [ "TensorUnit" ] ) then
        
        AddTensorUnit( category,
            function( cat )
            
            return FreydCategoryObject( cat, UniversalMorphismFromZeroObject( underlying_category, TensorUnit( underlying_category ) ) );
            
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
            function( cat, source, a, b, c, range )
                local mor;
                
                mor := AssociatorLeftToRightWithGivenTensorProducts( underlying_category,
                    Range( ObjectDatum( cat, source ) ),
                    Range( ObjectDatum( cat, a ) ),
                    Range( ObjectDatum( cat, b ) ),
                    Range( ObjectDatum( cat, c ) ),
                    Range( ObjectDatum( cat, range ) )
                );
                
                return FreydCategoryMorphism( cat, source, mor, range );
                
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
            function( cat, source, a, b, c, range )
                local mor;
                
                mor := AssociatorRightToLeftWithGivenTensorProducts( underlying_category,
                    Range( ObjectDatum( cat, source ) ),
                    Range( ObjectDatum( cat, a ) ),
                    Range( ObjectDatum( cat, b ) ),
                    Range( ObjectDatum( cat, c ) ),
                    Range( ObjectDatum( cat, range ) )
                );
                
                return FreydCategoryMorphism( cat, source, mor, range );
                
        end );
        
    fi;
    
    # Given an object a, this method returns the left unitor 1 \otimes a -> a.
    # We derive this from the unitors of the underlying category.
    if is_possible_to_install( "LeftUnitorWithGivenTensorProduct", [ "LeftUnitorWithGivenTensorProduct" ] ) then
        
        AddLeftUnitorWithGivenTensorProduct( category,
            function( cat, a, s )
            
            return FreydCategoryMorphism( cat, s, LeftUnitor( underlying_category, Range( ObjectDatum( cat, a ) ) ), a );
            
        end );
        
    fi;
    
    # Given an object a, this method returns the left unitor inverse a -> 1 \otimes a.
    # We derive from the underlying category.
    if is_possible_to_install( "LeftUnitorInverseWithGivenTensorProduct", [ "LeftUnitorInverseWithGivenTensorProduct" ] ) then
        
        AddLeftUnitorInverseWithGivenTensorProduct( category,
            function( cat, a, r )
            
            return FreydCategoryMorphism( cat, a, LeftUnitorInverse( underlying_category, Range( ObjectDatum( cat, a ) ) ), r );
            
        end );
        
    fi;
    
    # Given an object a, this method returns the right unitor a \otimes 1 -> a.
    # We derive from the underlying category.
    if is_possible_to_install( "RightUnitorWithGivenTensorProduct", [ "RightUnitorWithGivenTensorProduct" ] ) then
        
        AddRightUnitorWithGivenTensorProduct( category,
            function( cat, a, s )
            
            return FreydCategoryMorphism( cat, s, RightUnitor( underlying_category, Range( ObjectDatum( cat, a ) ) ), a );
            
        end );
        
    fi;
    
    # Given an object a, this method returns the right unitor inverse a -> a \otimes 1.
    # We derive from the underlying proj-category.
    if is_possible_to_install( "RightUnitorInverseWithGivenTensorProduct", [ "RightUnitorInverseWithGivenTensorProduct" ] ) then
        
        AddRightUnitorInverseWithGivenTensorProduct( category,
            function( cat, a, r )
            
            return FreydCategoryMorphism( cat, a, RightUnitorInverse( underlying_category, Range( ObjectDatum( cat, a ) ) ), r );
            
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
        function( cat, s, a, b, r)
            local mor;
            
            mor := Braiding( underlying_category, Range( ObjectDatum( cat, a ) ), Range( ObjectDatum( cat, b ) ) );
            return FreydCategoryMorphism( cat, s, mor, r );
            
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
            function( cat, a, b )
            
            return Source( INTERNAL_HOM_EMBEDDING( cat, a, b ) );
            
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
            function( cat, s, alpha, beta, r )
                local kernel1, kernel2, mor, bridge_mapping;
                
                # (1) extract the Hom-embeddings
                kernel1 := INTERNAL_HOM_EMBEDDING( cat, Range( alpha ), Source( beta ) );
                kernel2 := INTERNAL_HOM_EMBEDDING( cat, Source( alpha ), Range( beta ) );
                
                # (2) construct the bridge_mapping A^vee \otimes B -> A'^\vee \otimes b'
                mor := InternalHomOnMorphisms( underlying_category, MorphismDatum( cat, alpha ), MorphismDatum( cat, beta ) );
                bridge_mapping := FreydCategoryMorphism( cat, Range( kernel1 ), mor, Range( kernel2 ) );
                
                # (3) finally return the lift of the corresponding diagram
                return LiftAlongMonomorphism( cat, kernel2, PreCompose( cat, kernel1, bridge_mapping ) );
                
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
            function( cat, A, B, S )
                local a, b, emb_a, emb_b, proj_A, proj_B, id_emb_a, Hom_embedding1, Hom_embedding2, Hom_emb_aB, epi_concat, eval_concat, colift_along_epi;
                
                # (0) define quantities
                a := Range( ObjectDatum( cat, A ) );
                b := Range( ObjectDatum( cat, B ) );
                emb_a := AsFreydCategoryObject( cat, a );
                emb_b := AsFreydCategoryObject( cat, b );
                proj_A := EpimorphismFromSomeProjectiveObject( cat, A );
                proj_B := EpimorphismFromSomeProjectiveObject( cat, B );
                id_emb_a := IdentityMorphism( cat, emb_a );
                
                # (1) the hom-embedding
                Hom_embedding1 := InternalHomOnMorphisms( cat, proj_A, IdentityMorphism( cat, B ) );
                Hom_emb_aB := Range( Hom_embedding1 );
                Hom_embedding2 := TensorProductOnMorphisms( cat, Hom_embedding1, IdentityMorphism( cat, A ) );
                
                # (2) concatenation of epis
                epi_concat := TensorProductOnMorphisms( cat, InternalHomOnMorphisms( cat, id_emb_a, proj_B ), id_emb_a );
                epi_concat := PreCompose( cat, epi_concat, TensorProductOnMorphisms( cat, IdentityMorphism( cat, Hom_emb_aB ), proj_A ) );
                
                # (3) compute "evaluation" fom Hom( emb_a,b ) \otimes emb_a -> b
                eval_concat := PreCompose( cat, AsFreydCategoryMorphism( cat, EvaluationMorphism( underlying_category, a, b ) ), proj_B );
                
                # (4) colift along epi
                colift_along_epi := ColiftAlongEpimorphism( cat, epi_concat, eval_concat );

                # (5) compose to finally construct the evaluation morphism in the Freyd category
                return PreCompose( cat, Hom_embedding2, colift_along_epi );
                
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
            function( cat, A, B, R )
                local a, b, emb_b, proj_B, A_tensor_B, proj_A_tensor_B, mono, tau, lift;

                # (0) define quantities
                a := Range( ObjectDatum( cat, A ) );
                b := Range( ObjectDatum( cat, B ) );
                emb_b := AsFreydCategoryObject( cat, b );
                proj_B := EpimorphismFromSomeProjectiveObject( cat, B );
                A_tensor_B := TensorProductOnObjects( cat, A, B );
                proj_A_tensor_B := EpimorphismFromSomeProjectiveObject( cat, A_tensor_B );
                
                # (1) construct monomorphism
                mono := InternalHomOnMorphisms( cat, proj_B, IdentityMorphism( cat, A_tensor_B ) );
            
                # (2) construct morphism from coevaluation in underlying category
                tau := PreCompose( cat, AsFreydCategoryMorphism( cat, CoevaluationMorphism( underlying_category, a, b ) ), InternalHomOnMorphisms( cat, IdentityMorphism( cat, emb_b ), proj_A_tensor_B ) );
                
                # (3) compute lift along mono
                lift := LiftAlongMonomorphism( cat, mono, tau );
                
                # (4) construct the coevaluation morphism
                return FreydCategoryMorphism( cat, A, MorphismDatum( cat, lift ), Source( mono ) );
                
        end );
    
    fi;
    
    ## Simplification methods
    
    if is_possible_to_install( "Simplify object",
                               [ "SomeReductionBySplitEpiSummand" ] ) then
      
      ##
      AddSimplifyObject( category,
        function( cat, object, i )
          
          return FreydCategoryObject( cat, FREYD_CATEGORIES_SimplifyObjectTuple( object, i )[1] );
          
      end );
      
      ##
      AddSimplifyObject_IsoFromInputObject( category,
        function( cat, object, i )
          
          return FreydCategoryMorphism( cat,
            object,
            FREYD_CATEGORIES_SimplifyObjectTuple( object, i )[2],
            FreydCategoryObject( cat, FREYD_CATEGORIES_SimplifyObjectTuple( object, i )[1] )
          );
          
      end );
      
      ##
      AddSimplifyObject_IsoToInputObject( category,
        function( cat, object, i )
          
          return FreydCategoryMorphism( cat,
            FreydCategoryObject( cat, FREYD_CATEGORIES_SimplifyObjectTuple( object, i )[1] ),
            FREYD_CATEGORIES_SimplifyObjectTuple( object, i )[3],
            object
          );
          
      end );
      
    fi;
    
    ## Random Methods by Lists
    ##
    if ForAll( [ "RandomObjectByList",
                 "RandomMorphismWithFixedSourceByList",
                 "RandomMorphismWithFixedRangeByList",
                 "RandomMorphismByList",
                 "InjectionOfFirstCofactorOfWeakBiPushout",
                 "InjectionOfSecondCofactorOfWeakBiPushout",
                 "ProjectionInSecondFactorOfWeakBiFiberProduct" ], m -> CanCompute( underlying_category, m ) ) then
      
      ##
      AddRandomObjectByList( category,
        function ( cat, L )
          
          return FreydCategoryObject( cat, RandomMorphismByList( underlying_category, L ) );
          
      end );
      
      ##
      AddRandomMorphismWithFixedSourceByList( category,
        function ( cat, S, L )
          local rho_S, rho, delta, mu_1, mu_2;
          
          rho_S := RelationMorphism( S );
          
          rho := RandomMorphismWithFixedSourceByList( underlying_category, Source( rho_S ), L );
          
          mu_1 := InjectionOfFirstCofactorOfWeakBiPushout( underlying_category, rho_S, rho );
          mu_2 := InjectionOfSecondCofactorOfWeakBiPushout( underlying_category, rho_S, rho );
          
          delta := RandomMorphismWithFixedSourceByList( underlying_category, Range( mu_1 ), L );
          
          mu_1 := PreCompose( underlying_category, mu_1, delta );
          mu_2 := PreCompose( underlying_category, mu_2, delta );
          
          return FreydCategoryMorphism( cat, S, mu_1, FreydCategoryObject( cat, mu_2 ) );
          
      end );
      
      ##
      AddRandomMorphismWithFixedRangeByList( category,
        function ( cat, R, L )
          local rho_R, rho, rho_S, delta;
          
          rho_R := RelationMorphism( R );
          
          rho := RandomMorphismWithFixedRangeByList( underlying_category, Range( rho_R ), L );
          
          rho_S := ProjectionInSecondFactorOfWeakBiFiberProduct( rho_R, rho );
          
          delta := RandomMorphismWithFixedRangeByList( underlying_category, Source( rho_S ), L );
          
          rho_S := PreCompose( underlying_category, delta, rho_S );
          
          return FreydCategoryMorphism( cat, FreydCategoryObject( cat, rho_S ), rho, R );
          
      end );
      
      if CanCompute( underlying_category, "IsZeroForObjects" ) and
          CanCompute( underlying_category, "RandomMorphismWithFixedSourceAndRangeByList" ) and
            HasRangeCategoryOfHomomorphismStructure( category ) and
              ( IsIdenticalObj( RangeCategoryOfHomomorphismStructure( category ), category ) or
                IsIdenticalObj( RangeCategoryOfHomomorphismStructure( category ), underlying_category ) ) then
        
        ## The above two restrictions ensure that L will be passed to the underlying category.
        ##
        AddRandomMorphismWithFixedSourceAndRangeByList( category,
          function ( cat, S, R, L )
            
            if IsZeroForObjects( underlying_category, Source( RelationMorphism( S ) ) ) then
              
              return FreydCategoryMorphism(
                        cat,
                        S,
                        RandomMorphismWithFixedSourceAndRangeByList(
                          underlying_category,
                          Range( RelationMorphism( S ) ),
                          Range( RelationMorphism( R ) ),
                          L ),
                        R );
            
            else
              # If the category has homomorphism structure over itself then
              # this case delegates to the above case since the source of the relation morphism
              # of DistinguishedObjectOfHomomorphismStructure( cat ) is zero.
              return InterpretMorphismFromDistinguishedObjectToHomomorphismStructureAsMorphism(
                        cat,
                        S,
                        R,
                        RandomMorphismWithFixedSourceAndRangeByList(
                          RangeCategoryOfHomomorphismStructure( cat ),
                          DistinguishedObjectOfHomomorphismStructure( cat ),
                          HomomorphismStructureOnObjects( cat, S, R ),
                          L ) );
            
            fi;
            
        end );
        
        ##
        AddRandomMorphismByList( category,
          function ( cat, L )
            
            if not ( Length( L ) = 3 and ForAll( L, IsList ) ) then
              Error( "The input should be a list consisting of three lists\n" );
            fi;
            
            return RandomMorphismWithFixedSourceAndRangeByList(
                      cat,
                      RandomObjectByList( cat, L[1] ),
                      RandomObjectByList( cat, L[2] ),
                      L[3] );
        end );
        
      fi;
    
    fi;
   
    ## Random Methods by Integers
    ##
    if ForAll( [ "RandomObjectByInteger",
                 "RandomMorphismWithFixedSourceByInteger",
                 "RandomMorphismWithFixedRangeByInteger",
                 "RandomMorphismByInteger",
                 "InjectionOfFirstCofactorOfWeakBiPushout",
                 "InjectionOfSecondCofactorOfWeakBiPushout",
                 "ProjectionInSecondFactorOfWeakBiFiberProduct" ], m -> CanCompute( underlying_category, m ) ) then

      
      ##
      AddRandomObjectByInteger( category,
        function ( cat, n )
          
          return FreydCategoryObject( cat, RandomMorphismByInteger( underlying_category, n ) );
          
      end );
      
      ##
      AddRandomMorphismWithFixedSourceByInteger( category,
        function ( cat, S, n )
          local rho_S, rho, delta, mu_1, mu_2;
          
          rho_S := RelationMorphism( S );
          
          rho := RandomMorphismWithFixedSourceByInteger( underlying_category, Source( rho_S ), n );
          
          mu_1 := InjectionOfFirstCofactorOfWeakBiPushout( underlying_category, rho_S, rho );
          mu_2 := InjectionOfSecondCofactorOfWeakBiPushout( underlying_category, rho_S, rho );
          
          delta := RandomMorphismWithFixedSourceByInteger( underlying_category, Range( mu_1 ), n );
          
          mu_1 := PreCompose( underlying_category, mu_1, delta );
          mu_2 := PreCompose( underlying_category, mu_2, delta );
          
          return FreydCategoryMorphism( cat, S, mu_1, FreydCategoryObject( cat, mu_2 ) );
          
      end );
       
      ##
      AddRandomMorphismWithFixedRangeByInteger( category,
        function ( cat, R, n )
          local rho_R, rho, rho_S, delta;
          
          rho_R := RelationMorphism( R );
          
          rho := RandomMorphismWithFixedRangeByInteger( underlying_category, Range( rho_R ), n );
          
          rho_S := ProjectionInSecondFactorOfWeakBiFiberProduct( rho_R, rho );
          
          delta := RandomMorphismWithFixedRangeByInteger( underlying_category, Source( rho_S ), n );
          
          rho_S := PreCompose( underlying_category, delta, rho_S );
          
          return FreydCategoryMorphism( cat, FreydCategoryObject( cat, rho_S ), rho, R );
          
      end );
      
      if CanCompute( underlying_category, "IsZeroForObjects" ) and
          CanCompute( underlying_category, "RandomMorphismWithFixedSourceAndRangeByInteger" ) and
            HasRangeCategoryOfHomomorphismStructure( category ) and
              ( IsIdenticalObj( RangeCategoryOfHomomorphismStructure( category ), category ) or
                IsIdenticalObj( RangeCategoryOfHomomorphismStructure( category ), underlying_category ) ) then
        
        ##
        AddRandomMorphismWithFixedSourceAndRangeByInteger( category,
          function ( cat, S, R, n )
            
            if IsZeroForObjects( underlying_category, Source( RelationMorphism( S ) ) ) then
              
              return FreydCategoryMorphism(
                        cat,
                        S,
                        RandomMorphismWithFixedSourceAndRangeByInteger(
                          underlying_category,
                          Range( RelationMorphism( S ) ),
                          Range( RelationMorphism( R ) ),
                          n ),
                        R );
            
            else
              # If the category has homomorphism structure over itself, then
              # this case delegates to the above case since the source of the relation morphism
              # of DistinguishedObjectOfHomomorphismStructure( cat ) is zero.
              return InterpretMorphismFromDistinguishedObjectToHomomorphismStructureAsMorphism(
                        cat,
                        S,
                        R,
                        RandomMorphismWithFixedSourceAndRangeByInteger(
                          RangeCategoryOfHomomorphismStructure( cat ),
                          DistinguishedObjectOfHomomorphismStructure( cat ),
                          HomomorphismStructureOnObjects( cat, S, R ),
                          n ) );
            
            fi;
            
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
               [ IsFreydCategoryMorphism ],
               
  function( freyd_category_morphism )
    
    Print( Concatenation( "\n", "--------------------------------\n" ) );
    Print( "Source:\n" );
    Print( "--------------------------------\n\n" );
    Display( ObjectDatum( Source( freyd_category_morphism ) ) );
    Print( Concatenation( "\n\n", "--------------------------------", "\n" ) );
    
    Print( "Morphism datum:\n" );
    Print( "--------------------------------\n\n" );
    Display( MorphismDatum( freyd_category_morphism ) );
    Print( Concatenation( "\n\n", "--------------------------------", "\n" ) );
    
    Print( "Range:\n" );
    Print( "--------------------------------\n\n" );
    Display( ObjectDatum( Range( freyd_category_morphism ) ) );
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
    Display( ObjectDatum( freyd_category_object ) );
    Print( Concatenation( "\n\n", "--------------------------------", "\n" ) );
    
    Print( "General description:\n" );
    Print( "--------------------------------\n\n" );
    Print( Concatenation( StringMutable( freyd_category_object ), "\n\n" ) );
    
end );

##
InstallMethod( LaTeXOutput,
               [ IsFreydCategoryObject ],
  function( object )
    local rel, corel, r, m, c, rel_dat, corel_dat;
    
    rel := ObjectDatum( object );
    
    r := LaTeXOutput( Source( rel ) );
    
    m := LaTeXOutput( Range( rel ) );
    
    rel_dat := LaTeXOutput( rel : OnlyDatum := true );
    
    return Concatenation(
      "\\big(",
      r,
      "\\xrightarrow{",
      rel_dat,
      "}",
      m,
      "\\big)_{\\mathcal{A}}"
    );
    
end );

##
InstallMethod( LaTeXOutput,
               [ IsFreydCategoryMorphism ],
  function( mor )
    local datum;
    
    datum := LaTeXOutput( MorphismDatum( mor ) : OnlyDatum := true );
    
    if ValueOption( "OnlyDatum" ) = true then
       
       return Concatenation(
        """{\color{blue}{""",
        datum,
        """}}"""
      );
      
    else
      
      return Concatenation(
        "{ \\tiny ", LaTeXOutput( Source( mor ) ), "}",
        """{\color{blue}{\xrightarrow{""",
        datum,
        """}}}""",
        "{ \\tiny ", LaTeXOutput( Range( mor ) ), "}"
      );
      
    fi;
    
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
    if not IsFinalized( category ) then

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
                      "IsLiftable"
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
##  Functors
##
####################################################################################

##
InstallMethod( EmbeddingFunctorIntoFreydCategory,
               [ IsCapCategory ],
               
  function( underlying_category )
    local freyd_category, emb_functor;
    
    freyd_category := FreydCategory( underlying_category );
    
    emb_functor := CapFunctor(
      Concatenation( "Embedding functor of ", Name( underlying_category ), " into its Freyd category" ),
      underlying_category,
      freyd_category
    );
    
    AddObjectFunction( emb_functor,
      function( obj )
        
        return AsFreydCategoryObject( obj );
        
    end );
    
    AddMorphismFunction( emb_functor,
      function( new_source, mor, new_range )
        
        return FreydCategoryMorphism( new_source, mor, new_range );
        
    end );
    
    return emb_functor;
    
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
      
        Error( "The power must be non-negative! \n" );
            
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
      
        Error( "The power must be non-negative! \n" );
      
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

####################################
##
## Convenience
##
####################################

##
InstallOtherMethod( \/,
               [ IsHomalgMatrix, IsFreydCategory ],
               
  function( mat, freyd_category )
    
    return mat/UnderlyingCategory( freyd_category )/freyd_category;
    
end );

##
InstallOtherMethod( \/,
               [ IsCapCategoryObject, IsFreydCategory ],
               
  function( obj, freyd_category )
    
    if not IsIdenticalObj( UnderlyingCategory( freyd_category ), CapCategory( obj ) ) then
      
      Error( "The underlying category of the given Freyd category has to be equal to the category of the given object" );
      
    fi;
    
    return AsFreydCategoryObject( freyd_category, obj );
    
end );

####################################
##
## Down
##
####################################

##
InstallMethod( Down,
               [ IsFreydCategoryObject ],
  function( obj )
    
    return ObjectDatum( obj );
    
end );

##
InstallMethod( DownOnlyMorphismData,
               [ IsFreydCategoryMorphism ],
  function( mor )
    
    return MorphismDatum( mor );
    
end );

