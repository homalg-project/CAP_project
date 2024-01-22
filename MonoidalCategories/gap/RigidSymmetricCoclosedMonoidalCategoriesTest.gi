# SPDX-License-Identifier: GPL-2.0-or-later
# MonoidalCategories: Monoidal and monoidal (co)closed categories
#
# Implementations
#

InstallGlobalFunction( "RigidSymmetricCoclosedMonoidalCategoriesTest",
    
    function( cat, opposite, a, b, c, d, alpha )
        
        local verbose,
              
              a_op, c_op,
              b_op, d_op,
              
              alpha_op,
              
              isomorphism_from_tensor_to_cohom_ab, isomorphism_from_cohom_to_tensor_ab, isomorphism_from_hom_to_tensor_ab_op, isomorphism_from_tensor_to_hom_ab_op,
              isomorphism_from_tensor_to_cohom_ba, isomorphism_from_cohom_to_tensor_ba, isomorphism_from_hom_to_tensor_ba_op, isomorphism_from_tensor_to_hom_ba_op,
              
              morphism_from_tensor_product_to_cohom_ab, morphism_from_hom_to_tensor_product_ab_op,
              morphism_from_tensor_product_to_cohom_ba, morphism_from_hom_to_tensor_product_ba_op,
              
              cohom_to_tensor_compatibility_inverse_abcd, tensor_to_hom_compatibility_inverse_abcd_op,
              cohom_to_tensor_compatibility_inverse_bdac, tensor_to_hom_compatibility_inverse_cadb_op,
              
              cocl_coev_for_codual_a, coev_for_dual_a_op,
              cocl_coev_for_codual_b, coev_for_dual_b_op,
              
              cotrace_alpha, trace_alpha_op,
              
              corank_morphism_a, rank_morphism_a_op,
              corank_morphism_b, rank_morphism_b_op,
              
              morphism_to_cobidual_a, morphism_from_bidual_a_op,
              morphism_to_cobidual_b, morphism_from_bidual_b_op;
              
        a_op := Opposite( opposite, a );
        b_op := Opposite( opposite, b );
        c_op := Opposite( opposite, c );
        d_op := Opposite( opposite, d );
        
        alpha_op := Opposite( opposite, alpha );
        
        verbose := ValueOption( "verbose" ) = true;
        
        if CanCompute( cat, "IsomorphismFromTensorProductWithCoDualObjectToInternalCoHom" ) then
            
            if verbose then
                
                # COVERAGE_IGNORE_NEXT_LINE
                Display( "Testing 'IsomorphismFromTensorProductWithCoDualObjectToInternalCoHom' ..." );
                
            fi;
            
            isomorphism_from_tensor_to_cohom_ab := IsomorphismFromTensorProductWithCoDualObjectToInternalCoHom( a, b );
            isomorphism_from_tensor_to_cohom_ba := IsomorphismFromTensorProductWithCoDualObjectToInternalCoHom( b, a );
            
            isomorphism_from_hom_to_tensor_ab_op := IsomorphismFromInternalHomToTensorProductWithDualObject( a_op, b_op );
            isomorphism_from_hom_to_tensor_ba_op := IsomorphismFromInternalHomToTensorProductWithDualObject( b_op, a_op );
            
            Assert( 0, IsCongruentForMorphisms( isomorphism_from_hom_to_tensor_ab_op, Opposite( opposite, isomorphism_from_tensor_to_cohom_ab ) ) );
            Assert( 0, IsCongruentForMorphisms( isomorphism_from_hom_to_tensor_ba_op, Opposite( opposite, isomorphism_from_tensor_to_cohom_ba ) ) );
            
        fi;
        
        if CanCompute( cat, "IsomorphismFromInternalCoHomToTensorProductWithCoDualObject" ) then
            
            if verbose then
                
                # COVERAGE_IGNORE_NEXT_LINE
                Display( "Testing 'IsomorphismFromInternalCoHomToTensorProductWithCoDualObject' ..." );
                
            fi;
            
            isomorphism_from_cohom_to_tensor_ab := IsomorphismFromInternalCoHomToTensorProductWithCoDualObject( a, b );
            isomorphism_from_cohom_to_tensor_ba := IsomorphismFromInternalCoHomToTensorProductWithCoDualObject( b, a );
            
            isomorphism_from_tensor_to_hom_ab_op := IsomorphismFromTensorProductWithDualObjectToInternalHom( a_op, b_op );
            isomorphism_from_tensor_to_hom_ba_op := IsomorphismFromTensorProductWithDualObjectToInternalHom( b_op, a_op );
            
            Assert( 0, IsCongruentForMorphisms( isomorphism_from_tensor_to_hom_ab_op, Opposite( opposite, isomorphism_from_cohom_to_tensor_ba ) ) );
            Assert( 0, IsCongruentForMorphisms( isomorphism_from_tensor_to_hom_ba_op, Opposite( opposite, isomorphism_from_cohom_to_tensor_ab ) ) );
            
        fi;
        
        if CanCompute( cat, "MorphismFromTensorProductToInternalCoHom" ) then
            
            if verbose then
                
                # COVERAGE_IGNORE_NEXT_LINE
                Display( "Testing 'MorphismFromTensorProductToInternalCoHom' ..." );
                
            fi;
            
            morphism_from_tensor_product_to_cohom_ab := MorphismFromTensorProductToInternalCoHom( a, b );
            morphism_from_tensor_product_to_cohom_ba := MorphismFromTensorProductToInternalCoHom( b, a );
            
            morphism_from_hom_to_tensor_product_ab_op := MorphismFromInternalHomToTensorProduct( a_op, b_op );
            morphism_from_hom_to_tensor_product_ba_op := MorphismFromInternalHomToTensorProduct( b_op, a_op );
            
            Assert( 0, IsCongruentForMorphisms( morphism_from_hom_to_tensor_product_ab_op, Opposite( opposite, morphism_from_tensor_product_to_cohom_ab ) ) );
            Assert( 0, IsCongruentForMorphisms( morphism_from_hom_to_tensor_product_ba_op, Opposite( opposite, morphism_from_tensor_product_to_cohom_ba ) ) );
            
        fi;
        
        if CanCompute( cat, "InternalCoHomTensorProductCompatibilityMorphismInverse" ) then
            
            if verbose then
                
                # COVERAGE_IGNORE_NEXT_LINE
                Display( "Testing 'InternalCoHomTensorProductCompatibilityMorphismInverse' ..." );
                
            fi;
            
            # Cohom( a, c ) ⊗ Cohom( b, d ) → Cohom( a ⊗ b, c ⊗ d )
            cohom_to_tensor_compatibility_inverse_abcd := InternalCoHomTensorProductCompatibilityMorphismInverse( [ a, b, c, d ] );
            
            # Cohom( b, a ) ⊗ Cohom( d, c ) → Cohom( b ⊗ d, a ⊗ c )
            cohom_to_tensor_compatibility_inverse_bdac := InternalCoHomTensorProductCompatibilityMorphismInverse( [ b, d, a, c ] );
            
            # Hom( a ⊗ c, b ⊗ d ) → Hom( a, b ) ⊗ Hom( c, d )
            tensor_to_hom_compatibility_inverse_abcd_op := TensorProductInternalHomCompatibilityMorphismInverse( [ a_op, b_op, c_op, d_op ] );
            
            # Hom( c ⊗ d, a ⊗ b ) → Hom( c, a ) ⊗ Hom( d, b )
            tensor_to_hom_compatibility_inverse_cadb_op := TensorProductInternalHomCompatibilityMorphismInverse( [ c_op, a_op, d_op, b_op ] );
            
            # Hom( a ⊗ c, b ⊗ d ) → Hom( a, b ) ⊗ Hom( c, d )  ==  op( coHom( b, a ) ⊗ coHom( d, c ) → coHom( b ⊗ d, a ⊗ c ) )
            Assert( 0, IsCongruentForMorphisms( tensor_to_hom_compatibility_inverse_abcd_op, Opposite( opposite, cohom_to_tensor_compatibility_inverse_bdac ) ) );
            
            # Hom( c ⊗ d, a ⊗ b ) → Hom( c, a ) ⊗ Hom( d, b )  ==  op( coHom( a, c ) ⊗ coHom( b, d ) → coHom( a ⊗ b, c ⊗ d ) )
            Assert( 0, IsCongruentForMorphisms( tensor_to_hom_compatibility_inverse_cadb_op, Opposite( opposite, cohom_to_tensor_compatibility_inverse_abcd ) ) );
            
        fi;
        
        if CanCompute( cat, "CoclosedCoevaluationForCoDual" ) then
            
            if verbose then
                
                # COVERAGE_IGNORE_NEXT_LINE
                Display( "Testing 'CoclosedCoevaluationForCoDual' ..." );
                
            fi;
            
            cocl_coev_for_codual_a := CoclosedCoevaluationForCoDual( a );
            cocl_coev_for_codual_b := CoclosedCoevaluationForCoDual( b );
            
            coev_for_dual_a_op := CoevaluationForDual( a_op );
            coev_for_dual_b_op := CoevaluationForDual( b_op );
            
            Assert( 0, IsCongruentForMorphisms( coev_for_dual_a_op, Opposite( opposite, cocl_coev_for_codual_a ) ) );
            Assert( 0, IsCongruentForMorphisms( coev_for_dual_b_op, Opposite( opposite, cocl_coev_for_codual_b ) ) );
            
        fi;
        
        if CanCompute( cat, "CoTraceMap" ) then
            
            if verbose then
                
                # COVERAGE_IGNORE_NEXT_LINE
                Display( "Testing 'CoTraceMap' ..." );
                
            fi;
            
            cotrace_alpha := CoTraceMap( alpha );
            
            trace_alpha_op := TraceMap( alpha_op );
            
            Assert( 0, IsCongruentForMorphisms( trace_alpha_op, Opposite( opposite, cotrace_alpha ) ) );
            
        fi;
        
        if CanCompute( cat, "CoRankMorphism" ) then
            
            if verbose then
                
                # COVERAGE_IGNORE_NEXT_LINE
                Display( "Testing 'CoRankMorphism' ..." );
                
            fi;
            
            corank_morphism_a := CoRankMorphism( a );
            corank_morphism_b := CoRankMorphism( b );
            
            rank_morphism_a_op := RankMorphism( a_op );
            rank_morphism_b_op := RankMorphism( b_op );
            
            Assert( 0, IsCongruentForMorphisms( rank_morphism_a_op, Opposite( opposite, corank_morphism_a ) ) );
            Assert( 0, IsCongruentForMorphisms( rank_morphism_b_op, Opposite( opposite, corank_morphism_b ) ) );
            
        fi;
        
        if CanCompute( cat, "MorphismToCoBidual" ) then
            
            if verbose then
                
                # COVERAGE_IGNORE_NEXT_LINE
                Display( "Testing 'MorphismToCoBidual' ..." );
                
            fi;
            
            morphism_to_cobidual_a := MorphismToCoBidual( a );
            morphism_to_cobidual_b := MorphismToCoBidual( b );
            
            morphism_from_bidual_a_op := MorphismFromBidual( a_op );
            morphism_from_bidual_b_op := MorphismFromBidual( b_op );
            
            Assert( 0, IsCongruentForMorphisms( morphism_from_bidual_a_op, Opposite( opposite, morphism_to_cobidual_a ) ) );
            Assert( 0, IsCongruentForMorphisms( morphism_from_bidual_b_op, Opposite( opposite, morphism_to_cobidual_b ) ) );
            
        fi;
        
end );
