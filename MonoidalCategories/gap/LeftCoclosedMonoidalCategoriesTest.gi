# SPDX-License-Identifier: GPL-2.0-or-later
# MonoidalCategories: Monoidal and monoidal (co)closed categories
#
# Implementations
#

InstallGlobalFunction( "LeftCoclosedMonoidalCategoriesTest",
    
    function( cat, opposite, a, b, c, d, alpha, beta, gamma, delta, epsilon, zeta )
    
        local verbose,
              
              a_op, c_op,
              b_op, d_op,
              
              id_a_tensor_b, id_b_tensor_a,
              
              cohom_ab, hom_ab_op, id_cohom_ab,
              cohom_ba, hom_ba_op, id_cohom_ba,
              
              alpha_op, cohom_alpha_beta, hom_alpha_beta_op,
              beta_op,  cohom_beta_alpha, hom_beta_alpha_op,
              
              cocl_ev_ab, cocl_coev_ab, ev_ab_op, coev_ab_op,
              cocl_ev_ba, cocl_coev_ba, ev_ba_op, coev_ba_op,
              
              alpha_tensor_beta, alpha_tensor_beta_op,
              beta_tensor_alpha, beta_tensor_alpha_op,
              
              cohom_to_tensor_adjunction_on_id_cohom_ab, tensor_to_cohom_adjunction_on_id_a_tensor_b,
              cohom_to_tensor_adjunction_on_id_cohom_ba, tensor_to_cohom_adjunction_on_id_b_tensor_a,
              
              tensor_to_cohom_adjunction_on_alpha_tensor_beta, tensor_to_hom_adjunction_on_alpha_tensor_beta_op,
              tensor_to_cohom_adjunction_on_beta_tensor_alpha, tensor_to_hom_adjunction_on_beta_tensor_alpha_op,
              
              cohom_to_tensor_adjunction_on_cohom_alpha_beta, hom_to_tensor_adjunction_on_hom_alpha_beta_op,
              cohom_to_tensor_adjunction_on_cohom_beta_alpha, hom_to_tensor_adjunction_on_hom_beta_alpha_op,
              
              precocompose_abc, precompose_abc_op, postcocompose_abc, postcompose_abc_op,
              precocompose_cba, precompose_cba_op, postcocompose_cba, postcompose_cba_op,
              
              a_codual, a_dual_op, codual_alpha, dual_alpha_op,
              b_codual, b_dual_op, codual_beta, dual_beta_op,
              
              cocl_ev_for_codual_a, ev_for_dual_a_op,
              cocl_ev_for_codual_b, ev_for_dual_b_op,
              
              morphism_from_cobidual_a, morphism_to_bidual_a_op,
              morphism_from_cobidual_b, morphism_to_bidual_b_op,
              
              cohom_to_tensor_compatibility_abcd, tensor_to_hom_compatibility_abcd_op,
              cohom_to_tensor_compatibility_bdac, tensor_to_hom_compatibility_cadb_op,
              
              coduality_tensor_product_compatibility_ab, tensor_product_duality_compatibility_ab_op,
              coduality_tensor_product_compatibility_ba, tensor_product_duality_compatibility_ba_op,
              
              morphism_from_cohom_to_tensor_product_ab, morphism_from_tensor_product_to_hom_ab_op,
              morphism_from_cohom_to_tensor_product_ba, morphism_from_tensor_product_to_hom_ba_op,
              
              isomorphism_from_dual_to_hom_a_op, isomorphism_from_hom_to_dual_a_op,
              isomorphism_from_dual_to_hom_b_op, isomorphism_from_hom_to_dual_b_op,
              
              isomorphism_from_codual_to_cohom_a, isomorphism_from_cohom_to_codual_a,
              isomorphism_from_codual_to_cohom_b, isomorphism_from_cohom_to_codual_b,
              
              gamma_op, universal_property_of_codual_gamma, universal_property_of_dual_gamma_op,
              delta_op, universal_property_of_codual_delta, universal_property_of_dual_delta_op,
              
              colambda_intro_alpha, lambda_intro_alpha_op,
              colambda_intro_beta,  lambda_intro_beta_op,
              
              epsilon_op, colambda_elim_epsilon, lambda_elim_epsilon_op,
              zeta_op,    colambda_elim_zeta,    lambda_elim_zeta_op,
              
              isomorphism_from_a_to_cohom, isomorphism_from_cohom_to_a, isomorphism_from_a_to_hom_op, isomorphism_from_hom_to_a_op,
              isomorphism_from_b_to_cohom, isomorphism_from_cohom_to_b, isomorphism_from_b_to_hom_op, isomorphism_from_hom_to_b_op;
        
        a_op := Opposite( opposite, a );
        b_op := Opposite( opposite, b );
        c_op := Opposite( opposite, c );
        d_op := Opposite( opposite, d );
        
        alpha_op := Opposite( opposite, alpha );
        beta_op := Opposite( opposite, beta );
        
        verbose := ValueOption( "verbose" ) = true;
        
        if CanCompute( cat, "LeftInternalCoHomOnObjects" ) then
            
            if verbose then
                
                # COVERAGE_IGNORE_NEXT_LINE
                Display( "Testing 'LeftInternalCoHomOnObjects' ..." );
                
            fi;
            
            cohom_ab := LeftInternalCoHomOnObjects( a, b );
            cohom_ba := LeftInternalCoHomOnObjects( b, a );
            
            hom_ab_op := LeftInternalHomOnObjects( a_op, b_op );
            hom_ba_op := LeftInternalHomOnObjects( b_op, a_op );
            
            Assert( 0, IsEqualForObjects( hom_ab_op, Opposite( opposite, cohom_ba ) ) );
            Assert( 0, IsEqualForObjects( hom_ba_op, Opposite( opposite, cohom_ab ) ) );
            
            # Opposite must be self-inverse
            
            Assert( 0, IsEqualForObjects( cohom_ab, Opposite( hom_ba_op ) ) );
            Assert( 0, IsEqualForObjects( cohom_ba, Opposite( hom_ab_op ) ) );
            
            # Convenience methods in the opposite category
            
            Assert( 0, IsEqualForObjects( hom_ab_op, LeftInternalHom( a_op, b_op ) ) );
            Assert( 0, IsEqualForObjects( hom_ba_op, LeftInternalHom( b_op, a_op ) ) );
            
        fi;
        
        if CanCompute( cat, "LeftInternalCoHomOnMorphisms" ) then
            
            if verbose then
                
                # COVERAGE_IGNORE_NEXT_LINE
                Display( "Testing 'LeftInternalCoHomOnMorphisms' ..." );
                
            fi;
            
            cohom_alpha_beta := LeftInternalCoHomOnMorphisms( alpha, beta );
            cohom_beta_alpha := LeftInternalCoHomOnMorphisms( beta, alpha );
            
            hom_alpha_beta_op := LeftInternalHomOnMorphisms( alpha_op, beta_op );
            hom_beta_alpha_op := LeftInternalHomOnMorphisms( beta_op, alpha_op );
            
            Assert( 0, IsCongruentForMorphisms( hom_alpha_beta_op, Opposite( opposite, cohom_beta_alpha ) ) );
            Assert( 0, IsCongruentForMorphisms( hom_beta_alpha_op, Opposite( opposite, cohom_alpha_beta ) ) );
            
            # Opposite must be self-inverse
            
            Assert( 0, IsCongruentForMorphisms( cohom_alpha_beta, Opposite( hom_beta_alpha_op ) ) );
            Assert( 0, IsCongruentForMorphisms( cohom_beta_alpha, Opposite( hom_alpha_beta_op ) ) );
            
            # Convenience methods in the opposite category
            
            Assert( 0, IsCongruentForMorphisms( hom_alpha_beta_op, LeftInternalHom( alpha_op, beta_op ) ) );
            Assert( 0, IsCongruentForMorphisms( hom_beta_alpha_op, LeftInternalHom( beta_op, alpha_op ) ) );
            
        fi;
        
        if CanCompute( cat, "LeftCoclosedMonoidalEvaluationMorphism" ) then
            
            if verbose then
                
                # COVERAGE_IGNORE_NEXT_LINE
                Display( "Testing 'LeftCoclosedMonoidalEvaluationMorphism' ..." );
                
            fi;
            
            cocl_ev_ab := LeftCoclosedMonoidalEvaluationMorphism( a, b );
            cocl_ev_ba := LeftCoclosedMonoidalEvaluationMorphism( b, a );
            
            ev_ab_op := LeftClosedMonoidalEvaluationMorphism( a_op, b_op );
            ev_ba_op := LeftClosedMonoidalEvaluationMorphism( b_op, a_op );
            
            # Arguments must be reversed for evaluations
            Assert( 0, IsCongruentForMorphisms( cocl_ev_ab, Opposite( ev_ab_op ) ) );
            Assert( 0, IsCongruentForMorphisms( cocl_ev_ba, Opposite( ev_ba_op ) ) );
            
        fi;
        
        if CanCompute( cat, "LeftCoclosedMonoidalCoevaluationMorphism" ) then
            
            if verbose then
                
                # COVERAGE_IGNORE_NEXT_LINE
                Display( "Testing 'LeftCoclosedMonoidalCoevaluationMorphism' ..." );
                
            fi;
            
            cocl_coev_ab := LeftCoclosedMonoidalCoevaluationMorphism( a, b );
            cocl_coev_ba := LeftCoclosedMonoidalCoevaluationMorphism( b, a );
            
            coev_ab_op := LeftClosedMonoidalCoevaluationMorphism( a_op, b_op );
            coev_ba_op := LeftClosedMonoidalCoevaluationMorphism( b_op, a_op );
            
            Assert( 0, IsCongruentForMorphisms( coev_ab_op, Opposite( opposite, cocl_coev_ab ) ) );
            Assert( 0, IsCongruentForMorphisms( coev_ba_op, Opposite( opposite, cocl_coev_ba ) ) );
            
        fi;
        
        if CanCompute( cat, "TensorProductToLeftInternalCoHomAdjunctMorphism" ) then
            
            if verbose then
                
                # COVERAGE_IGNORE_NEXT_LINE
                Display( "Testing 'TensorProductToLeftInternalCoHomAdjunctMorphism' ..." );
                
            fi;
            
            ########################################
            # 
            # alpha: a → b
            # beta:  c → d
            # 
            # alpha_tensor_beta: a ⊗ c → b ⊗ d
            # beta_tensor_alpha: c ⊗ a → d ⊗ b
            #
            ########################################
            #
            # alpha_op: b → a
            # beta_op:  d → c
            #
            # alpha_tensor_beta_op: b ⊗ d → a ⊗ c
            # beta_tensor_alpha_op: d ⊗ b → c ⊗ a
            #
            ########################################
            
            alpha_tensor_beta := TensorProductOnMorphisms( alpha, beta );
            beta_tensor_alpha := TensorProductOnMorphisms( beta, alpha );
            alpha_tensor_beta_op := TensorProductOnMorphisms( opposite, alpha_op, beta_op );
            beta_tensor_alpha_op := TensorProductOnMorphisms( opposite, beta_op, alpha_op );
            
            # Adjoint( a ⊗ c → b ⊗ d )  ==  Cohom( a ⊗ c, d ) → b
            tensor_to_cohom_adjunction_on_alpha_tensor_beta := TensorProductToLeftInternalCoHomAdjunctMorphism( b, d, alpha_tensor_beta );
            
            # Adjoint( c ⊗ a → d ⊗ b )  ==  Cohom( c ⊗ a, b ) → d
            tensor_to_cohom_adjunction_on_beta_tensor_alpha := TensorProductToLeftInternalCoHomAdjunctMorphism( d, b, beta_tensor_alpha );
            
            # Adjoint( b ⊗ d → a ⊗ c )  ==  b → Hom( d, a ⊗ c )
            tensor_to_hom_adjunction_on_alpha_tensor_beta_op := TensorProductToLeftInternalHomAdjunctMorphism( b_op, d_op, alpha_tensor_beta_op );
            
            # Adjoint( d ⊗ b → c ⊗ a )  ==  d → Hom( b, c ⊗ a )
            tensor_to_hom_adjunction_on_beta_tensor_alpha_op := TensorProductToLeftInternalHomAdjunctMorphism( d_op, b_op, beta_tensor_alpha_op );
            
            # coHom( b ⊗ d, c ) → a  ==  op( a → Hom( c, b ⊗ d ) )
            Assert( 0, IsCongruentForMorphisms( tensor_to_hom_adjunction_on_alpha_tensor_beta_op, Opposite( opposite, tensor_to_cohom_adjunction_on_alpha_tensor_beta ) ) );
            
            # coHom( d ⊗ b, a ) → c  ==  op( c → Hom( a, d ⊗ b ) )
            Assert( 0, IsCongruentForMorphisms( tensor_to_hom_adjunction_on_beta_tensor_alpha_op, Opposite( opposite, tensor_to_cohom_adjunction_on_beta_tensor_alpha ) ) );
            
        fi;
        
        if CanCompute( cat, "LeftInternalCoHomToTensorProductAdjunctMorphism" ) then
            
            if verbose then
                
                # COVERAGE_IGNORE_NEXT_LINE
                Display( "Testing 'LeftInternalCoHomToTensorProductAdjunctMorphism' ..." );
                
            fi;
            
            ##################################################
            #
            # hom_alpha_beta: Hom( b, c ) → Hom( a, d )
            # hom_beta_alpha: Hom( d, a ) → Hom( c, b )
            #
            # hom_alpha_beta_op: Hom( a, d ) → Hom( b, c )
            # hom_beta_alpha_op: Hom( c, b ) → Hom( d, a )
            #
            ##################################################
            #
            # cohom_alpha_beta: coHom( a, d ) → coHom( b, c )
            # cohom_beta_alpha: coHom( c, b ) → coHom( d, a )
            #
            ##################################################
            
            # Adjoint( Cohom( a, d ) → Cohom( b, c ) )  ==  a → Cohom( b, c ) ⊗ d
            cohom_to_tensor_adjunction_on_cohom_alpha_beta := LeftInternalCoHomToTensorProductAdjunctMorphism( a, d, cohom_alpha_beta );
            
            # Adjoint( Cohom( c, b ) → Cohom( d, a ) )  ==  c → Cohom( d, a ) ⊗ b
            cohom_to_tensor_adjunction_on_cohom_beta_alpha := LeftInternalCoHomToTensorProductAdjunctMorphism( c, b, cohom_beta_alpha );
            
            # Adjoint( Hom( a, d ) → Hom( b, c ) )  ==  Hom( a, d ) ⊗ b → c
            hom_to_tensor_adjunction_on_hom_alpha_beta_op := LeftInternalHomToTensorProductAdjunctMorphism( b_op, c_op, hom_alpha_beta_op );
            
            # Adjoint( Hom( c, b ) → Hom( d, a ) )  ==  Hom( c, b ) ⊗ d → a
            hom_to_tensor_adjunction_on_hom_beta_alpha_op := LeftInternalHomToTensorProductAdjunctMorphism( d_op, a_op, hom_beta_alpha_op );
            
            # Hom( a, d ) ⊗ b → c  ==  op( c → coHom( d, a ) ⊗ b )
            Assert( 0, IsCongruentForMorphisms( hom_to_tensor_adjunction_on_hom_alpha_beta_op, Opposite( opposite, cohom_to_tensor_adjunction_on_cohom_beta_alpha ) ) );
            
            # Hom( c, b ) ⊗ d → a  ==  op( a → coHom( b, c ) ⊗ d )
            Assert( 0, IsCongruentForMorphisms( hom_to_tensor_adjunction_on_hom_beta_alpha_op, Opposite( opposite, cohom_to_tensor_adjunction_on_cohom_alpha_beta ) ) );
            
        fi;
        
        if CanCompute( cat, "LeftCoclosedMonoidalPreCoComposeMorphism" ) then
            
            if verbose then
                
                # COVERAGE_IGNORE_NEXT_LINE
                Display( "Testing 'LeftCoclosedMonoidalPreCoComposeMorphism' ..." );
                
            fi;
            
            precocompose_abc := LeftCoclosedMonoidalPreCoComposeMorphism( a, b, c );
            precocompose_cba := LeftCoclosedMonoidalPreCoComposeMorphism( c, b, a );

            precompose_abc_op := LeftClosedMonoidalPreComposeMorphism( a_op, b_op, c_op );
            precompose_cba_op := LeftClosedMonoidalPreComposeMorphism( c_op, b_op, a_op );
            
            Assert( 0, IsCongruentForMorphisms( precompose_abc_op, Opposite( opposite, precocompose_cba ) ) );
            Assert( 0, IsCongruentForMorphisms( precompose_cba_op, Opposite( opposite, precocompose_abc ) ) );
        
        fi;
        
        if CanCompute( cat, "LeftCoclosedMonoidalPostCoComposeMorphism" ) then
            
            if verbose then
                
                # COVERAGE_IGNORE_NEXT_LINE
                Display( "Testing 'LeftCoclosedMonoidalPostCoComposeMorphism' ..." );
                
            fi;
            
            postcocompose_abc := LeftCoclosedMonoidalPostCoComposeMorphism( a, b, c );
            postcocompose_cba := LeftCoclosedMonoidalPostCoComposeMorphism( c, b, a );
            
            postcompose_abc_op := LeftClosedMonoidalPostComposeMorphism( a_op, b_op, c_op );
            postcompose_cba_op := LeftClosedMonoidalPostComposeMorphism( c_op, b_op, a_op );
            
            Assert( 0, IsCongruentForMorphisms( postcompose_abc_op, Opposite( opposite, postcocompose_cba ) ) );
            Assert( 0, IsCongruentForMorphisms( postcompose_cba_op, Opposite( opposite, postcocompose_abc ) ) );
            
        fi;
        
        if CanCompute( cat, "LeftCoDualOnObjects" ) then
            
            if verbose then
                
                # COVERAGE_IGNORE_NEXT_LINE
                Display( "Testing 'LeftCoDualOnObjects' ..." );
                
            fi;
            
            a_codual := LeftCoDualOnObjects( a );
            b_codual := LeftCoDualOnObjects( b );
            
            a_dual_op := LeftDualOnObjects( a_op );
            b_dual_op := LeftDualOnObjects( b_op );
            
            Assert( 0, IsEqualForObjects( a_dual_op, Opposite( opposite, a_codual ) ) );
            Assert( 0, IsEqualForObjects( b_dual_op, Opposite( opposite, b_codual ) ) );
            
        fi;
        
        if CanCompute( cat, "LeftCoDualOnMorphisms" ) then
            
            if verbose then
                
                # COVERAGE_IGNORE_NEXT_LINE
                Display( "Testing 'LeftCoDualOnMorphisms' ..." );
                
            fi;
            
            codual_alpha := LeftCoDualOnMorphisms( alpha );
            codual_beta := LeftCoDualOnMorphisms( beta );
            
            dual_alpha_op := LeftDualOnMorphisms( alpha_op );
            dual_beta_op := LeftDualOnMorphisms( beta_op );
            
            Assert( 0, IsCongruentForMorphisms( dual_alpha_op, Opposite( opposite, codual_alpha ) ) );
            Assert( 0, IsCongruentForMorphisms( dual_beta_op, Opposite( opposite, codual_beta ) ) );
            
        fi;
        
        if CanCompute( cat, "LeftCoclosedMonoidalEvaluationForLeftCoDual" ) then
            
            if verbose then
                
                # COVERAGE_IGNORE_NEXT_LINE
                Display( "Testing 'LeftCoclosedMonoidalEvaluationForLeftCoDual' ..." );
                
            fi;
            
            cocl_ev_for_codual_a := LeftCoclosedMonoidalEvaluationForLeftCoDual( a );
            cocl_ev_for_codual_b := LeftCoclosedMonoidalEvaluationForLeftCoDual( b );
            
            ev_for_dual_a_op := LeftClosedMonoidalEvaluationForLeftDual( a_op );
            ev_for_dual_b_op := LeftClosedMonoidalEvaluationForLeftDual( b_op );
            
            Assert( 0, IsCongruentForMorphisms( ev_for_dual_a_op, Opposite( opposite, cocl_ev_for_codual_a ) ) );
            Assert( 0, IsCongruentForMorphisms( ev_for_dual_b_op, Opposite( opposite, cocl_ev_for_codual_b ) ) );
            
        fi;
        
        if CanCompute( cat, "MorphismFromLeftCoBidual" ) then
            
            if verbose then
                
                # COVERAGE_IGNORE_NEXT_LINE
                Display( "Testing 'MorphismFromLeftCoBidual' ..." );
                
            fi;
            
            morphism_from_cobidual_a := MorphismFromLeftCoBidual( a );
            morphism_from_cobidual_b := MorphismFromLeftCoBidual( b );
            
            morphism_to_bidual_a_op := MorphismToLeftBidual( a_op );
            morphism_to_bidual_b_op := MorphismToLeftBidual( b_op );
            
            Assert( 0, IsCongruentForMorphisms( morphism_to_bidual_a_op, Opposite( opposite, morphism_from_cobidual_a ) ) );
            Assert( 0, IsCongruentForMorphisms( morphism_to_bidual_b_op, Opposite( opposite, morphism_from_cobidual_b ) ) );
            
        fi;
        
        if CanCompute( cat, "LeftInternalCoHomTensorProductCompatibilityMorphism" ) then
            
            if verbose then
                
                # COVERAGE_IGNORE_NEXT_LINE
                Display( "Testing 'LeftInternalCoHomTensorProductCompatibilityMorphism' ..." );
                
            fi;
            
            # Cohom( a ⊗ b, c ⊗ d ) → Cohom( a, c ) ⊗ Cohom( b, d )
            cohom_to_tensor_compatibility_abcd := LeftInternalCoHomTensorProductCompatibilityMorphism( [ a, b, c, d ] );
            
            # Cohom( b ⊗ d, a ⊗ c ) → Cohom( b, a ) ⊗ Cohom( d, c )
            cohom_to_tensor_compatibility_bdac := LeftInternalCoHomTensorProductCompatibilityMorphism( [ b, d, a, c ] );
            
            # Hom( a, b ) ⊗ Hom( c, d ) → Hom( a ⊗ c, b ⊗ d )
            tensor_to_hom_compatibility_abcd_op := TensorProductLeftInternalHomCompatibilityMorphism( [ a_op, b_op, c_op, d_op ] );
            
            # Hom( c, a ) ⊗ Hom( d, b ) → Hom( c ⊗ d, a ⊗ b )
            tensor_to_hom_compatibility_cadb_op := TensorProductLeftInternalHomCompatibilityMorphism( [ c_op, a_op, d_op, b_op ] );
            
            # Hom( a, b ) ⊗ Hom( c, d ) → Hom( a ⊗ c, b ⊗ d )  ==  op( coHom( b ⊗ d, a ⊗ c ) → coHom( b, a ) ⊗ coHom( d, c ) )
            Assert( 0, IsCongruentForMorphisms( tensor_to_hom_compatibility_abcd_op, Opposite( opposite, cohom_to_tensor_compatibility_bdac ) ) );
            
            # Hom( c, a ) ⊗ Hom( d, b ) → Hom( c ⊗ d, a ⊗ b )  ==  op( coHom( a ⊗ b, c ⊗ d ) → coHom( a, c ) ⊗ coHom( b, d ) )
            Assert( 0, IsCongruentForMorphisms( tensor_to_hom_compatibility_cadb_op, Opposite( opposite, cohom_to_tensor_compatibility_abcd ) ) );
            
        fi;
        
        if CanCompute( cat, "LeftCoDualityTensorProductCompatibilityMorphism" ) then
            
            if verbose then
                
                # COVERAGE_IGNORE_NEXT_LINE
                Display( "Testing 'LeftCoDualityTensorProductCompatibilityMorphism' ..." );
                
            fi;
            
            # (a ⊗ b)_v → a_v ⊗ b_v
            coduality_tensor_product_compatibility_ab := LeftCoDualityTensorProductCompatibilityMorphism( a, b );
            
            # (b ⊗ a)_v → b_v ⊗ a_v
            coduality_tensor_product_compatibility_ba := LeftCoDualityTensorProductCompatibilityMorphism( b, a );
            
            # a^v ⊗ b^v → (a ⊗ b)^v
            tensor_product_duality_compatibility_ab_op := TensorProductLeftDualityCompatibilityMorphism( a_op, b_op );
            
            # b^v ⊗ a^v → (b ⊗ a)^v
            tensor_product_duality_compatibility_ba_op := TensorProductLeftDualityCompatibilityMorphism( b_op, a_op );
            
            # a^v ⊗ b^v → (a ⊗ b)^v  == op( (a ⊗ b)_v → a_v ⊗ b_v )
            Assert( 0, IsCongruentForMorphisms( tensor_product_duality_compatibility_ab_op, Opposite( opposite, coduality_tensor_product_compatibility_ab ) ) );
            
            # b^v ⊗ a^v → (b ⊗ a)^v  ==  op( (b ⊗ a)_v → b_v ⊗ a_v )
            Assert( 0, IsCongruentForMorphisms( tensor_product_duality_compatibility_ba_op, Opposite( opposite, coduality_tensor_product_compatibility_ba ) ) );
            
        fi;
        
        if CanCompute( cat, "MorphismFromLeftInternalCoHomToTensorProduct" ) then
            
            if verbose then
                
                # COVERAGE_IGNORE_NEXT_LINE
                Display( "Testing 'MorphismFromLeftInternalCoHomToTensorProduct' ..." );
                
            fi;
            
            morphism_from_cohom_to_tensor_product_ab := MorphismFromLeftInternalCoHomToTensorProduct( a, b );
            morphism_from_cohom_to_tensor_product_ba := MorphismFromLeftInternalCoHomToTensorProduct( b, a );
            
            morphism_from_tensor_product_to_hom_ab_op := MorphismFromTensorProductToLeftInternalHom( a_op, b_op );
            morphism_from_tensor_product_to_hom_ba_op := MorphismFromTensorProductToLeftInternalHom( b_op, a_op );
            
            Assert( 0, IsCongruentForMorphisms( morphism_from_tensor_product_to_hom_ab_op, Opposite( opposite, morphism_from_cohom_to_tensor_product_ba ) ) );
            Assert( 0, IsCongruentForMorphisms( morphism_from_tensor_product_to_hom_ba_op, Opposite( opposite, morphism_from_cohom_to_tensor_product_ab ) ) );
            
        fi;
        
        if CanCompute( cat, "IsomorphismFromLeftInternalCoHomFromTensorUnitToLeftCoDualObject" ) then
            
            if verbose then
                
                # COVERAGE_IGNORE_NEXT_LINE
                Display( "Testing 'IsomorphismFromLeftInternalCoHomFromTensorUnitToLeftCoDualObject' ..." );
                
            fi;
            
            isomorphism_from_cohom_to_codual_a := IsomorphismFromLeftInternalCoHomFromTensorUnitToLeftCoDualObject( a );
            isomorphism_from_cohom_to_codual_b := IsomorphismFromLeftInternalCoHomFromTensorUnitToLeftCoDualObject( b );
            
            isomorphism_from_dual_to_hom_a_op := IsomorphismFromLeftDualObjectToLeftInternalHomIntoTensorUnit( a_op );
            isomorphism_from_dual_to_hom_b_op := IsomorphismFromLeftDualObjectToLeftInternalHomIntoTensorUnit( b_op );
            
            Assert( 0, IsCongruentForMorphisms( isomorphism_from_dual_to_hom_a_op, Opposite( opposite, isomorphism_from_cohom_to_codual_a ) ) );
            Assert( 0, IsCongruentForMorphisms( isomorphism_from_dual_to_hom_b_op, Opposite( opposite, isomorphism_from_cohom_to_codual_b ) ) );
            
        fi;
        
        if CanCompute( cat, "IsomorphismFromLeftCoDualObjectToLeftInternalCoHomFromTensorUnit" ) then
            
            if verbose then
                
                # COVERAGE_IGNORE_NEXT_LINE
                Display( "Testing 'IsomorphismFromLeftCoDualObjectToLeftInternalCoHomFromTensorUnit' ..." );
                
            fi;
            
            isomorphism_from_codual_to_cohom_a := IsomorphismFromLeftCoDualObjectToLeftInternalCoHomFromTensorUnit( a );
            isomorphism_from_codual_to_cohom_b := IsomorphismFromLeftCoDualObjectToLeftInternalCoHomFromTensorUnit( b );
            
            isomorphism_from_hom_to_dual_a_op := IsomorphismFromLeftInternalHomIntoTensorUnitToLeftDualObject( a_op );
            isomorphism_from_hom_to_dual_b_op := IsomorphismFromLeftInternalHomIntoTensorUnitToLeftDualObject( b_op );
            
            Assert( 0, IsCongruentForMorphisms( isomorphism_from_hom_to_dual_a_op, Opposite( opposite, isomorphism_from_codual_to_cohom_a ) ) );
            Assert( 0, IsCongruentForMorphisms( isomorphism_from_hom_to_dual_b_op, Opposite( opposite, isomorphism_from_codual_to_cohom_b ) ) );
            
        fi;
        
        if CanCompute( cat, "UniversalPropertyOfLeftCoDual" ) then
            
            if verbose then
                
                # COVERAGE_IGNORE_NEXT_LINE
                Display( "Testing 'UniversalPropertyOfLeftCoDual' ..." );
                
            fi;
            
            gamma_op := Opposite( opposite, gamma );
            delta_op := Opposite( opposite, delta );
            
            universal_property_of_codual_gamma := UniversalPropertyOfLeftCoDual( a, b, gamma );
            universal_property_of_codual_delta := UniversalPropertyOfLeftCoDual( c, d, delta );
            
            universal_property_of_dual_gamma_op := UniversalPropertyOfLeftDual( a_op, b_op, gamma_op );
            universal_property_of_dual_delta_op := UniversalPropertyOfLeftDual( c_op, d_op, delta_op );
            
            Assert( 0, IsCongruentForMorphisms( universal_property_of_dual_gamma_op, Opposite( opposite, universal_property_of_codual_gamma ) ) );
            Assert( 0, IsCongruentForMorphisms( universal_property_of_dual_delta_op, Opposite( opposite, universal_property_of_codual_delta ) ) );
            
        fi;
        
        if CanCompute( cat, "LeftCoclosedMonoidalLambdaIntroduction" ) then
            
            if verbose then
                
                # COVERAGE_IGNORE_NEXT_LINE
                Display( "Testing 'LeftCoclosedMonoidalLambdaIntroduction' ..." );
                
            fi;
            
            colambda_intro_alpha := LeftCoclosedMonoidalLambdaIntroduction( alpha );
            colambda_intro_beta := LeftCoclosedMonoidalLambdaIntroduction( beta );
            
            lambda_intro_alpha_op := LeftClosedMonoidalLambdaIntroduction( alpha_op );
            lambda_intro_beta_op := LeftClosedMonoidalLambdaIntroduction( beta_op );
            
            Assert( 0, IsCongruentForMorphisms( lambda_intro_alpha_op, Opposite( opposite, colambda_intro_alpha ) ) );
            Assert( 0, IsCongruentForMorphisms( lambda_intro_beta_op, Opposite( opposite, colambda_intro_beta ) ) );
            
        fi;
        
        if CanCompute( cat, "LeftCoclosedMonoidalLambdaElimination" ) then
            
            if verbose then
                
                # COVERAGE_IGNORE_NEXT_LINE
                Display( "Testing 'LeftCoclosedMonoidalLambdaElimination' ..." );
                
            fi;
            
            epsilon_op := Opposite( opposite, epsilon );
            zeta_op := Opposite( opposite, zeta );
            
            colambda_elim_epsilon := LeftCoclosedMonoidalLambdaElimination( a, b, epsilon );
            colambda_elim_zeta := LeftCoclosedMonoidalLambdaElimination( c, d, zeta );
            
            lambda_elim_epsilon_op := LeftClosedMonoidalLambdaElimination( b_op, a_op, epsilon_op );
            lambda_elim_zeta_op := LeftClosedMonoidalLambdaElimination( d_op, c_op, zeta_op );
            
            Assert( 0, IsCongruentForMorphisms( lambda_elim_epsilon_op, Opposite( opposite, colambda_elim_epsilon ) ) );
            Assert( 0, IsCongruentForMorphisms( lambda_elim_zeta_op, Opposite( opposite, colambda_elim_zeta ) ) );
            
        fi;
        
        if CanCompute( cat, "IsomorphismFromObjectToLeftInternalCoHom" ) then
            
            if verbose then
                
                # COVERAGE_IGNORE_NEXT_LINE
                Display( "Testing 'IsomorphismFromObjectToLeftInternalCoHom' ..." );
                
            fi;
            
            isomorphism_from_a_to_cohom := IsomorphismFromObjectToLeftInternalCoHom( a );
            isomorphism_from_b_to_cohom := IsomorphismFromObjectToLeftInternalCoHom( b );
            
            isomorphism_from_hom_to_a_op := IsomorphismFromLeftInternalHomToObject( a_op );
            isomorphism_from_hom_to_b_op := IsomorphismFromLeftInternalHomToObject( b_op );
            
            Assert( 0, IsCongruentForMorphisms( isomorphism_from_hom_to_a_op, Opposite( opposite, isomorphism_from_a_to_cohom ) ) );
            Assert( 0, IsCongruentForMorphisms( isomorphism_from_hom_to_b_op, Opposite( opposite, isomorphism_from_b_to_cohom ) ) );
            
        fi;
        
        if CanCompute( cat, "IsomorphismFromLeftInternalCoHomToObject" ) then
            
            if verbose then
                
                # COVERAGE_IGNORE_NEXT_LINE
                Display( "Testing 'IsomorphismFromLeftInternalCoHomToObject' ..." );
                
            fi;
            
            isomorphism_from_cohom_to_a := IsomorphismFromLeftInternalCoHomToObject( a );
            isomorphism_from_cohom_to_b := IsomorphismFromLeftInternalCoHomToObject( b );
            
            isomorphism_from_a_to_hom_op := IsomorphismFromObjectToLeftInternalHom( a_op );
            isomorphism_from_b_to_hom_op := IsomorphismFromObjectToLeftInternalHom( b_op );
            
            Assert( 0, IsCongruentForMorphisms( isomorphism_from_a_to_hom_op, Opposite( opposite, isomorphism_from_cohom_to_a ) ) );
            Assert( 0, IsCongruentForMorphisms( isomorphism_from_b_to_hom_op, Opposite( opposite, isomorphism_from_cohom_to_b ) ) );
            
        fi;
        
        if CanCompute( cat, "LeftInternalCoHomOnObjects" ) and
           CanCompute( cat, "LeftCoclosedMonoidalEvaluationMorphism" ) and
           CanCompute( cat, "LeftInternalCoHomToTensorProductAdjunctMorphism" )
        
        then
            
            if verbose then
                
                # COVERAGE_IGNORE_NEXT_LINE
                Display( "Consistency between 'CoclosedEvalutionMorphism' and 'AdjunctMorphism' ..." );
                
            fi;
            
            cocl_ev_ab := LeftCoclosedMonoidalEvaluationMorphism( a, b );
            cocl_ev_ba := LeftCoclosedMonoidalEvaluationMorphism( b, a );
            
            id_cohom_ab := IdentityMorphism( LeftInternalCoHomOnObjects( a, b ) );
            id_cohom_ba := IdentityMorphism( LeftInternalCoHomOnObjects( b, a ) );
            
            # Adjoint( Cohom( a, b ) → Cohom( a, b ) )  ==  a → Cohom( a, b ) ⊗ b
            cohom_to_tensor_adjunction_on_id_cohom_ab := LeftInternalCoHomToTensorProductAdjunctMorphism( a, b, id_cohom_ab );
            
            # Adjoint( Cohom( b, a ) → Cohom( b, a ) )  ==  b → Cohom( b, a ) ⊗ a
            cohom_to_tensor_adjunction_on_id_cohom_ba := LeftInternalCoHomToTensorProductAdjunctMorphism( b, a, id_cohom_ba );
            
            Assert( 0, IsCongruentForMorphisms( cocl_ev_ba, cohom_to_tensor_adjunction_on_id_cohom_ab ) );
            Assert( 0, IsCongruentForMorphisms( cocl_ev_ab, cohom_to_tensor_adjunction_on_id_cohom_ba ) );
            
        fi;
        
        if CanCompute( cat, "TensorProductOnObjects" ) and
           CanCompute( cat, "LeftCoclosedMonoidalCoevaluationMorphism" ) and
           CanCompute( cat, "TensorProductToLeftInternalCoHomAdjunctMorphism" )
        
        then
            
            if verbose then
                
                # COVERAGE_IGNORE_NEXT_LINE
                Display( "Consistency between 'CoevalutionMorphism' and 'AdjunctMorphism' ..." );
                
            fi;
            
            cocl_coev_ab := LeftCoclosedMonoidalCoevaluationMorphism( a, b );
            cocl_coev_ba := LeftCoclosedMonoidalCoevaluationMorphism( b, a );
            
            id_a_tensor_b := IdentityMorphism( TensorProductOnObjects( a, b ) );
            id_b_tensor_a := IdentityMorphism( TensorProductOnObjects( b, a ) );
            
            # Adjoint( a ⊗ b → a ⊗ b )  ==  Cohom( a ⊗ b, b ) → a
            tensor_to_cohom_adjunction_on_id_a_tensor_b := TensorProductToLeftInternalCoHomAdjunctMorphism( a, b, id_a_tensor_b );
            
            # Adjoint( b ⊗ a → b ⊗ a )  ==  Cohom( b ⊗ a, a ) → b
            tensor_to_cohom_adjunction_on_id_b_tensor_a := TensorProductToLeftInternalCoHomAdjunctMorphism( b, a, id_b_tensor_a );
            
            Assert( 0, IsCongruentForMorphisms( cocl_coev_ba, tensor_to_cohom_adjunction_on_id_a_tensor_b ) );
            Assert( 0, IsCongruentForMorphisms( cocl_coev_ab, tensor_to_cohom_adjunction_on_id_b_tensor_a ) );
            
        fi;

end );
