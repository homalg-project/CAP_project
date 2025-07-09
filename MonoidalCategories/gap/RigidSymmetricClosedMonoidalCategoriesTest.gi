# SPDX-License-Identifier: GPL-2.0-or-later
# MonoidalCategories: Monoidal and monoidal (co)closed categories
#
# Implementations
#

##
InstallMethod( TestZigZagIdentitiesForDual,
               [ IsCapCategory, IsCapCategoryObject ],
               
  function( cat, object )
    local id_object, dual_object, id_dual_object, automorphism;
    
    Assert( 0, HasIsMonoidalCategory( cat ) and IsMonoidalCategory( cat ) );
    Assert( 0, IsIdenticalObj( cat, CapCategory( object ) ) );
    
    id_object := IdentityMorphism( object );
    
    dual_object := DualOnObjects( object );
    
    id_dual_object := IdentityMorphism( dual_object );
    
    automorphism := PreCompose( [
      LeftUnitorInverse( object ),
      TensorProductOnMorphisms( CoevaluationForDual( object ), id_object ),
      AssociatorLeftToRight( object, dual_object, object ),
      TensorProductOnMorphisms( id_object, EvaluationForDual( object ) ),
      RightUnitor( object ) ] );
    
    if not IsCongruentForMorphisms( automorphism, id_object ) then
        
        return false;
        
    fi;
    
    automorphism := PreCompose( [
      RightUnitorInverse( dual_object ),
      TensorProductOnMorphisms( id_dual_object, CoevaluationForDual( object ) ),
      AssociatorRightToLeft( dual_object, object, dual_object ),
      TensorProductOnMorphisms( EvaluationForDual( object ), id_dual_object ),
      LeftUnitor( dual_object ) ] );
    
    return IsCongruentForMorphisms( automorphism, id_dual_object );
    
end );

##
InstallGlobalFunction( "RigidSymmetricClosedMonoidalCategoriesTest",
    function( cat, opposite, a, b, c, d, alpha )
        local verbose,
              
              a_op, c_op,
              b_op, d_op,
              
              alpha_op,
              
              isomorphism_from_tensor_to_hom_ab, isomorphism_from_hom_to_tensor_ab, isomorphism_from_cohom_to_tensor_ab_op, isomorphism_from_tensor_to_cohom_ab_op,
              isomorphism_from_tensor_to_hom_ba, isomorphism_from_hom_to_tensor_ba, isomorphism_from_cohom_to_tensor_ba_op, isomorphism_from_tensor_to_cohom_ba_op,
              
              morphism_from_hom_to_tensor_product_ab, morphism_from_tensor_product_to_cohom_ab_op,
              morphism_from_hom_to_tensor_product_ba, morphism_from_tensor_product_to_cohom_ba_op,
              
              tensor_to_hom_compatibility_inverse_abcd, cohom_to_tensor_compatibility_inverse_abcd_op,
              tensor_to_hom_compatibility_inverse_cadb, cohom_to_tensor_compatibility_inverse_bdac_op,
              
              coev_for_dual_a, cocl_coev_for_codual_a_op,
              coev_for_dual_b, cocl_coev_for_codual_b_op,
              
              trace_alpha, cotrace_alpha_op,
              
              rank_morphism_a, corank_morphism_a_op,
              rank_morphism_b, corank_morphism_b_op,
              
              morphism_from_bidual_a, morphism_to_cobidual_a_op,
              morphism_from_bidual_b, morphism_to_cobidual_b_op;
        
        a_op := Opposite( opposite, a );
        b_op := Opposite( opposite, b );
        c_op := Opposite( opposite, c );
        d_op := Opposite( opposite, d );
        
        alpha_op := Opposite( opposite, alpha );
        
        verbose := ValueOption( "verbose" ) = true;
        
        if IsEmpty( MissingOperationsForConstructivenessOfCategory( cat, "IsRigidSymmetricClosedMonoidalCategory" ) ) then
            
            Assert( 0, ForAll( [ a, b, c, d ], obj -> TestZigZagIdentitiesForDual( cat, obj ) ) );
            
        fi;
        
        if IsEmpty( MissingOperationsForConstructivenessOfCategory( opposite, "IsRigidSymmetricClosedMonoidalCategory" ) ) then
            
            Assert( 0, ForAll( [ a_op, b_op, c_op, d_op ], obj_op -> TestZigZagIdentitiesForDual( opposite, obj_op ) ) );
            
        fi;
        
        if CanCompute( cat, "IsomorphismFromTensorProductWithDualObjectToInternalHom" ) then
            
            if verbose then
                
                # COVERAGE_IGNORE_NEXT_LINE
                Display( "Testing 'IsomorphismFromTensorProductWithDualObjectToInternalHom' ..." );
                
            fi;
            
            isomorphism_from_tensor_to_hom_ab := IsomorphismFromTensorProductWithDualObjectToInternalHom( a, b );
            isomorphism_from_tensor_to_hom_ba := IsomorphismFromTensorProductWithDualObjectToInternalHom( b, a );
            
            isomorphism_from_cohom_to_tensor_ab_op := IsomorphismFromInternalCoHomToTensorProductWithCoDualObject( a_op, b_op );
            isomorphism_from_cohom_to_tensor_ba_op := IsomorphismFromInternalCoHomToTensorProductWithCoDualObject( b_op, a_op );
            
            Assert( 0, IsCongruentForMorphisms( isomorphism_from_cohom_to_tensor_ab_op, Opposite( opposite, isomorphism_from_tensor_to_hom_ba ) ) );
            Assert( 0, IsCongruentForMorphisms( isomorphism_from_cohom_to_tensor_ba_op, Opposite( opposite, isomorphism_from_tensor_to_hom_ab ) ) );
            
        fi;
        
        if CanCompute( cat, "IsomorphismFromInternalHomToTensorProductWithDualObject" ) then
            
            if verbose then
                
                # COVERAGE_IGNORE_NEXT_LINE
                Display( "Testing 'IsomorphismFromInternalHomToTensorProductWithDualObject' ..." );
                
            fi;
            
            isomorphism_from_hom_to_tensor_ab := IsomorphismFromInternalHomToTensorProductWithDualObject( a, b );
            isomorphism_from_hom_to_tensor_ba := IsomorphismFromInternalHomToTensorProductWithDualObject( b, a );
            
            isomorphism_from_tensor_to_cohom_ab_op := IsomorphismFromTensorProductWithCoDualObjectToInternalCoHom( a_op, b_op );
            isomorphism_from_tensor_to_cohom_ba_op := IsomorphismFromTensorProductWithCoDualObjectToInternalCoHom( b_op, a_op );
            
            Assert( 0, IsCongruentForMorphisms( isomorphism_from_tensor_to_cohom_ab_op, Opposite( opposite, isomorphism_from_hom_to_tensor_ab ) ) );
            Assert( 0, IsCongruentForMorphisms( isomorphism_from_tensor_to_cohom_ba_op, Opposite( opposite, isomorphism_from_hom_to_tensor_ba ) ) );
            
        fi;
        
        if CanCompute( cat, "MorphismFromInternalHomToTensorProduct" ) then
            
            if verbose then
                
                # COVERAGE_IGNORE_NEXT_LINE
                Display( "Testing 'MorphismFromInternalHomToTensorProduct' ..." );
                
            fi;
            
            morphism_from_hom_to_tensor_product_ab := MorphismFromInternalHomToTensorProduct( a, b );
            morphism_from_hom_to_tensor_product_ba := MorphismFromInternalHomToTensorProduct( b, a );
            
            morphism_from_tensor_product_to_cohom_ab_op := MorphismFromTensorProductToInternalCoHom( a_op, b_op );
            morphism_from_tensor_product_to_cohom_ba_op := MorphismFromTensorProductToInternalCoHom( b_op, a_op );
            
            Assert( 0, IsCongruentForMorphisms( morphism_from_tensor_product_to_cohom_ab_op, Opposite( opposite, morphism_from_hom_to_tensor_product_ab ) ) );
            Assert( 0, IsCongruentForMorphisms( morphism_from_tensor_product_to_cohom_ba_op, Opposite( opposite, morphism_from_hom_to_tensor_product_ba ) ) );
            
        fi;
        
        if CanCompute( cat, "TensorProductInternalHomCompatibilityMorphismInverse" ) then
            
            if verbose then
                
                # COVERAGE_IGNORE_NEXT_LINE
                Display( "Testing 'TensorProductInternalHomCompatibilityMorphismInverse' ..." );
                
            fi;
            
            # Hom( a ⊗ c, b ⊗ d ) → Hom( a, b ) ⊗ Hom( c, d )
            tensor_to_hom_compatibility_inverse_abcd := TensorProductInternalHomCompatibilityMorphismInverse( [ a, b, c, d ] );
            
            # Hom( c ⊗ d, a ⊗ b ) → Hom( c, a ) ⊗ Hom( d, b )
            tensor_to_hom_compatibility_inverse_cadb := TensorProductInternalHomCompatibilityMorphismInverse( [ c, a, d, b ] );
            
            # Cohom( a, c ) ⊗ Cohom( b, d ) → Cohom( a ⊗ b, c ⊗ d )
            cohom_to_tensor_compatibility_inverse_abcd_op := InternalCoHomTensorProductCompatibilityMorphismInverse( [ a_op, b_op, c_op, d_op ] );
            
            # Cohom( b, a ) ⊗ Cohom( d, c ) → Cohom( b ⊗ d, a ⊗ c )
            cohom_to_tensor_compatibility_inverse_bdac_op := InternalCoHomTensorProductCompatibilityMorphismInverse( [ b_op, d_op, a_op, c_op ] );
            
            # coHom( a, c ) ⊗ coHom( b, d ) → coHom( a ⊗ b, c ⊗ d )  ==  op( Hom( c ⊗ d, a ⊗ b ) → Hom( c, a ) ⊗ Hom( d, b ) )
            Assert( 0, IsCongruentForMorphisms( cohom_to_tensor_compatibility_inverse_abcd_op, Opposite( opposite, tensor_to_hom_compatibility_inverse_cadb ) ) );
            
            # coHom( b, a ) ⊗ coHom( d, c ) → coHom( b ⊗ d, a ⊗ c )  ==  op( Hom( a ⊗ c, b ⊗ d ) → Hom( a, b ) ⊗ Hom( c, d ) )
            Assert( 0, IsCongruentForMorphisms( cohom_to_tensor_compatibility_inverse_bdac_op, Opposite( opposite, tensor_to_hom_compatibility_inverse_abcd ) ) );
            
        fi;
        
        if CanCompute( cat, "CoevaluationForDual" ) then
            
            if verbose then
                
                # COVERAGE_IGNORE_NEXT_LINE
                Display( "Testing 'CoevaluationForDual' ..." );
                
            fi;
            
            coev_for_dual_a := CoevaluationForDual( a );
            coev_for_dual_b := CoevaluationForDual( b );
            
            cocl_coev_for_codual_a_op := CoclosedCoevaluationForCoDual( a_op );
            cocl_coev_for_codual_b_op := CoclosedCoevaluationForCoDual( b_op );
            
            Assert( 0, IsCongruentForMorphisms( cocl_coev_for_codual_a_op, Opposite( opposite, coev_for_dual_a ) ) );
            Assert( 0, IsCongruentForMorphisms( cocl_coev_for_codual_b_op, Opposite( opposite, coev_for_dual_b ) ) );
            
        fi;
        
        if CanCompute( cat, "TraceMap" ) then
            
            if verbose then
                
                # COVERAGE_IGNORE_NEXT_LINE
                Display( "Testing 'TraceMap' ..." );
                
            fi;
            
            trace_alpha := TraceMap( alpha );
            
            cotrace_alpha_op := CoTraceMap( alpha_op );
            
            Assert( 0, IsCongruentForMorphisms( cotrace_alpha_op, Opposite( opposite, trace_alpha ) ) );
            
        fi;
        
        if CanCompute( cat, "RankMorphism" ) then
            
            if verbose then
                
                # COVERAGE_IGNORE_NEXT_LINE
                Display( "Testing 'RankMorphism' ..." );
                
            fi;
            
            rank_morphism_a := RankMorphism( a );
            rank_morphism_b := RankMorphism( b );
            
            corank_morphism_a_op := CoRankMorphism( a_op );
            corank_morphism_b_op := CoRankMorphism( b_op );
            
            Assert( 0, IsCongruentForMorphisms( corank_morphism_a_op, Opposite( opposite, rank_morphism_a ) ) );
            Assert( 0, IsCongruentForMorphisms( corank_morphism_b_op, Opposite( opposite, rank_morphism_b ) ) );
            
        fi;
        
        if CanCompute( cat, "MorphismFromBidual" ) then
            
            if verbose then
                
                # COVERAGE_IGNORE_NEXT_LINE
                Display( "Testing 'MorphismFromBidual' ..." );
                
            fi;
            
            morphism_from_bidual_a := MorphismFromBidual( a );
            morphism_from_bidual_b := MorphismFromBidual( b );
            
            morphism_to_cobidual_a_op := MorphismToCoBidual( a_op );
            morphism_to_cobidual_b_op := MorphismToCoBidual( b_op );
            
            Assert( 0, IsCongruentForMorphisms( morphism_to_cobidual_a_op, Opposite( opposite, morphism_from_bidual_a ) ) );
            Assert( 0, IsCongruentForMorphisms( morphism_to_cobidual_b_op, Opposite( opposite, morphism_from_bidual_b ) ) );
            
        fi;
        
end );
