# SPDX-License-Identifier: GPL-2.0-or-later
# MonoidalCategories: Monoidal and monoidal (co)closed categories
#
# Implementations
#

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
        
        if CanCompute( cat, "IsomorphismFromTensorProductWithLeftDualObjectToLeftInternalHom" ) then
            
            if verbose then
                
                # COVERAGE_IGNORE_NEXT_LINE
                Display( "Testing 'IsomorphismFromTensorProductWithLeftDualObjectToLeftInternalHom' ..." );
                
            fi;
            
            isomorphism_from_tensor_to_hom_ab := IsomorphismFromTensorProductWithLeftDualObjectToLeftInternalHom( a, b );
            isomorphism_from_tensor_to_hom_ba := IsomorphismFromTensorProductWithLeftDualObjectToLeftInternalHom( b, a );
            
            isomorphism_from_cohom_to_tensor_ab_op := IsomorphismFromLeftInternalCoHomToTensorProductWithLeftCoDualObject( a_op, b_op );
            isomorphism_from_cohom_to_tensor_ba_op := IsomorphismFromLeftInternalCoHomToTensorProductWithLeftCoDualObject( b_op, a_op );
            
            Assert( 0, IsCongruentForMorphisms( isomorphism_from_cohom_to_tensor_ab_op, Opposite( opposite, isomorphism_from_tensor_to_hom_ba ) ) );
            Assert( 0, IsCongruentForMorphisms( isomorphism_from_cohom_to_tensor_ba_op, Opposite( opposite, isomorphism_from_tensor_to_hom_ab ) ) );
            
        fi;
        
        if CanCompute( cat, "IsomorphismFromLeftInternalHomToTensorProductWithLeftDualObject" ) then
            
            if verbose then
                
                # COVERAGE_IGNORE_NEXT_LINE
                Display( "Testing 'IsomorphismFromLeftInternalHomToTensorProductWithLeftDualObject' ..." );
                
            fi;
            
            isomorphism_from_hom_to_tensor_ab := IsomorphismFromLeftInternalHomToTensorProductWithLeftDualObject( a, b );
            isomorphism_from_hom_to_tensor_ba := IsomorphismFromLeftInternalHomToTensorProductWithLeftDualObject( b, a );
            
            isomorphism_from_tensor_to_cohom_ab_op := IsomorphismFromTensorProductWithLeftCoDualObjectToLeftInternalCoHom( a_op, b_op );
            isomorphism_from_tensor_to_cohom_ba_op := IsomorphismFromTensorProductWithLeftCoDualObjectToLeftInternalCoHom( b_op, a_op );
            
            Assert( 0, IsCongruentForMorphisms( isomorphism_from_tensor_to_cohom_ab_op, Opposite( opposite, isomorphism_from_hom_to_tensor_ab ) ) );
            Assert( 0, IsCongruentForMorphisms( isomorphism_from_tensor_to_cohom_ba_op, Opposite( opposite, isomorphism_from_hom_to_tensor_ba ) ) );
            
        fi;
        
        if CanCompute( cat, "MorphismFromLeftInternalHomToTensorProduct" ) then
            
            if verbose then
                
                # COVERAGE_IGNORE_NEXT_LINE
                Display( "Testing 'MorphismFromLeftInternalHomToTensorProduct' ..." );
                
            fi;
            
            morphism_from_hom_to_tensor_product_ab := MorphismFromLeftInternalHomToTensorProduct( a, b );
            morphism_from_hom_to_tensor_product_ba := MorphismFromLeftInternalHomToTensorProduct( b, a );
            
            morphism_from_tensor_product_to_cohom_ab_op := MorphismFromTensorProductToLeftInternalCoHom( a_op, b_op );
            morphism_from_tensor_product_to_cohom_ba_op := MorphismFromTensorProductToLeftInternalCoHom( b_op, a_op );
            
            Assert( 0, IsCongruentForMorphisms( morphism_from_tensor_product_to_cohom_ab_op, Opposite( opposite, morphism_from_hom_to_tensor_product_ab ) ) );
            Assert( 0, IsCongruentForMorphisms( morphism_from_tensor_product_to_cohom_ba_op, Opposite( opposite, morphism_from_hom_to_tensor_product_ba ) ) );
            
        fi;
        
        if CanCompute( cat, "TensorProductLeftInternalHomCompatibilityMorphismInverse" ) then
            
            if verbose then
                
                # COVERAGE_IGNORE_NEXT_LINE
                Display( "Testing 'TensorProductLeftInternalHomCompatibilityMorphismInverse' ..." );
                
            fi;
            
            # Hom( a ⊗ c, b ⊗ d ) → Hom( a, b ) ⊗ Hom( c, d )
            tensor_to_hom_compatibility_inverse_abcd := TensorProductLeftInternalHomCompatibilityMorphismInverse( [ a, b, c, d ] );
            
            # Hom( c ⊗ d, a ⊗ b ) → Hom( c, a ) ⊗ Hom( d, b )
            tensor_to_hom_compatibility_inverse_cadb := TensorProductLeftInternalHomCompatibilityMorphismInverse( [ c, a, d, b ] );
            
            # Cohom( a, c ) ⊗ Cohom( b, d ) → Cohom( a ⊗ b, c ⊗ d )
            cohom_to_tensor_compatibility_inverse_abcd_op := LeftInternalCoHomTensorProductCompatibilityMorphismInverse( [ a_op, b_op, c_op, d_op ] );
            
            # Cohom( b, a ) ⊗ Cohom( d, c ) → Cohom( b ⊗ d, a ⊗ c )
            cohom_to_tensor_compatibility_inverse_bdac_op := LeftInternalCoHomTensorProductCompatibilityMorphismInverse( [ b_op, d_op, a_op, c_op ] );
            
            # coHom( a, c ) ⊗ coHom( b, d ) → coHom( a ⊗ b, c ⊗ d )  ==  op( Hom( c ⊗ d, a ⊗ b ) → Hom( c, a ) ⊗ Hom( d, b ) )
            Assert( 0, IsCongruentForMorphisms( cohom_to_tensor_compatibility_inverse_abcd_op, Opposite( opposite, tensor_to_hom_compatibility_inverse_cadb ) ) );
            
            # coHom( b, a ) ⊗ coHom( d, c ) → coHom( b ⊗ d, a ⊗ c )  ==  op( Hom( a ⊗ c, b ⊗ d ) → Hom( a, b ) ⊗ Hom( c, d ) )
            Assert( 0, IsCongruentForMorphisms( cohom_to_tensor_compatibility_inverse_bdac_op, Opposite( opposite, tensor_to_hom_compatibility_inverse_abcd ) ) );
            
        fi;
        
        if CanCompute( cat, "CoevaluationForLeftDual" ) then
            
            if verbose then
                
                # COVERAGE_IGNORE_NEXT_LINE
                Display( "Testing 'CoevaluationForLeftDual' ..." );
                
            fi;
            
            coev_for_dual_a := CoevaluationForLeftDual( a );
            coev_for_dual_b := CoevaluationForLeftDual( b );
            
            cocl_coev_for_codual_a_op := LeftCoclosedMonoidalCoevaluationForLeftCoDual( a_op );
            cocl_coev_for_codual_b_op := LeftCoclosedMonoidalCoevaluationForLeftCoDual( b_op );
            
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
        
        if CanCompute( cat, "MorphismFromLeftBidual" ) then
            
            if verbose then
                
                # COVERAGE_IGNORE_NEXT_LINE
                Display( "Testing 'MorphismFromLeftBidual' ..." );
                
            fi;
            
            morphism_from_bidual_a := MorphismFromLeftBidual( a );
            morphism_from_bidual_b := MorphismFromLeftBidual( b );
            
            morphism_to_cobidual_a_op := MorphismToLeftCoBidual( a_op );
            morphism_to_cobidual_b_op := MorphismToLeftCoBidual( b_op );
            
            Assert( 0, IsCongruentForMorphisms( morphism_to_cobidual_a_op, Opposite( opposite, morphism_from_bidual_a ) ) );
            Assert( 0, IsCongruentForMorphisms( morphism_to_cobidual_b_op, Opposite( opposite, morphism_from_bidual_b ) ) );
            
        fi;
        
end );
