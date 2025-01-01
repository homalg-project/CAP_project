# SPDX-License-Identifier: GPL-2.0-or-later
# MonoidalCategories: Monoidal and monoidal (co)closed categories
#
# Implementations
#

InstallGlobalFunction( "ClosedMonoidalCategoriesTest",
    
    function( cat, opposite, a, b, c, d, alpha, beta, gamma, delta, epsilon, zeta )
        
        local verbose,
              
              a_op, c_op,
              b_op, d_op,
              
              id_a_tensor_b, id_b_tensor_a,
              
              hom_ab, cohom_ab_op, id_hom_ab,
              hom_ba, cohom_ba_op, id_hom_ba,
              
              alpha_op, hom_alpha_beta, cohom_alpha_beta_op,
              beta_op,  hom_beta_alpha, cohom_beta_alpha_op,
              
              ev_ab, coev_ab, cocl_ev_ab_op, cocl_coev_ab_op,
              ev_ba, coev_ba, cocl_ev_ba_op, cocl_coev_ba_op,
              
              raiso, laiso, H_ab_ba_c,
              
              alpha_tensor_beta, alpha_tensor_beta_op,
              beta_tensor_alpha, beta_tensor_alpha_op,
              
              hom_to_tensor_adjunction_on_id_hom_ab, tensor_to_hom_adjunction_on_id_a_tensor_b,
              hom_to_tensor_adjunction_on_id_hom_ba, tensor_to_hom_adjunction_on_id_b_tensor_a,

              tensor_to_hom_adjunction_on_alpha_tensor_beta, tensor_to_cohom_adjunction_on_alpha_tensor_beta_op,
              tensor_to_hom_adjunction_on_beta_tensor_alpha, tensor_to_cohom_adjunction_on_beta_tensor_alpha_op,
              
              hom_to_tensor_adjunction_on_hom_alpha_beta, cohom_to_tensor_adjunction_on_cohom_alpha_beta_op,
              hom_to_tensor_adjunction_on_hom_beta_alpha, cohom_to_tensor_adjunction_on_cohom_beta_alpha_op,
              
              precompose_abc, precocompose_abc_op, postcompose_abc, postcocompose_abc_op, 
              precompose_cba, precocompose_cba_op, postcompose_cba, postcocompose_cba_op,
              
              a_dual, a_codual_op, dual_alpha, codual_alpha_op,
              b_dual, b_codual_op, dual_beta, codual_beta_op,
              
              ev_for_dual_a, cocl_ev_for_codual_a_op,
              ev_for_dual_b, cocl_ev_for_codual_b_op,
                  
              morphism_to_bidual_a, morphism_from_cobidual_a_op,
              morphism_to_bidual_b, morphism_from_cobidual_b_op,
              
              tensor_to_hom_compatibility_abcd, cohom_to_tensor_compatibility_abcd_op,
              tensor_to_hom_compatibility_cadb, cohom_to_tensor_compatibility_bdac_op,
              
              tensor_product_duality_compatibility_ab, coduality_tensor_product_compatibility_ab_op,
              tensor_product_duality_compatibility_ba, coduality_tensor_product_compatibility_ba_op,
              
              morphism_from_tensor_product_to_hom_ab, morphism_from_cohom_to_tensor_product_ab_op,
              morphism_from_tensor_product_to_hom_ba, morphism_from_cohom_to_tensor_product_ba_op,
              
              isomorphism_from_dual_to_hom_a, isomorphism_from_hom_to_dual_a,
              isomorphism_from_dual_to_hom_b, isomorphism_from_hom_to_dual_b,
              
              isomorphism_from_codual_to_cohom_a_op, isomorphism_from_cohom_to_codual_a_op,
              isomorphism_from_codual_to_cohom_b_op, isomorphism_from_cohom_to_codual_b_op,
              
              gamma_op, universal_property_of_dual_gamma, universal_property_of_codual_gamma_op,
              delta_op, universal_property_of_dual_delta, universal_property_of_codual_delta_op,
              
              lambda_intro_alpha, colambda_intro_alpha_op,
              lambda_intro_beta,  colambda_intro_beta_op,
              
              epsilon_op, lambda_elim_epsilon, colambda_elim_epsilon_op,
              zeta_op,    lambda_elim_zeta,    colambda_elim_zeta_op,
              
              isomorphism_from_a_to_hom, isomorphism_from_hom_to_a, isomorphism_from_a_to_cohom_op, isomorphism_from_cohom_to_a_op,
              isomorphism_from_b_to_hom, isomorphism_from_hom_to_b, isomorphism_from_b_to_cohom_op, isomorphism_from_cohom_to_b_op;
        
        a_op := Opposite( opposite, a );
        b_op := Opposite( opposite, b );
        c_op := Opposite( opposite, c );
        d_op := Opposite( opposite, d );
        
        alpha_op := Opposite( opposite, alpha );
        beta_op := Opposite( opposite, beta );
        
        verbose := ValueOption( "verbose" ) = true;
        
        if CanCompute( cat, "InternalHomOnObjects" ) then
            
            if verbose then
                
                # COVERAGE_IGNORE_NEXT_LINE
                Display( "Testing 'InternalHomOnObjects' ..." );
                
            fi;
            
            hom_ab := InternalHomOnObjects( a, b );
            hom_ba := InternalHomOnObjects( b, a );
            
            cohom_ab_op := InternalCoHomOnObjects( a_op, b_op );
            cohom_ba_op := InternalCoHomOnObjects( b_op, a_op );
            
            Assert( 0, IsEqualForObjects( cohom_ab_op, Opposite( opposite, hom_ba ) ) );
            Assert( 0, IsEqualForObjects( cohom_ba_op, Opposite( opposite, hom_ab ) ) );
            
            # Opposite must be self-inverse
            
            Assert( 0, IsEqualForObjects( hom_ab, Opposite( cohom_ba_op ) ) );
            Assert( 0, IsEqualForObjects( hom_ba, Opposite( cohom_ab_op ) ) );
            
            # Convenience methods in the opposite category
            
            Assert( 0, IsEqualForObjects( cohom_ab_op, InternalCoHom( a_op, b_op ) ) );
            Assert( 0, IsEqualForObjects( cohom_ba_op, InternalCoHom( b_op, a_op ) ) );
            
        fi;
        
        if CanCompute( cat, "InternalHomOnMorphisms" ) then
            
            if verbose then
                
                # COVERAGE_IGNORE_NEXT_LINE
                Display( "Testing 'InternalHomOnMorphisms' ..." );
                
            fi;
            
            hom_alpha_beta := InternalHomOnMorphisms( alpha, beta );
            hom_beta_alpha := InternalHomOnMorphisms( beta, alpha );
            
            cohom_alpha_beta_op := InternalCoHomOnMorphisms( alpha_op, beta_op );
            cohom_beta_alpha_op := InternalCoHomOnMorphisms( beta_op, alpha_op );
            
            Assert( 0, IsCongruentForMorphisms( cohom_alpha_beta_op, Opposite( opposite, hom_beta_alpha ) ) );
            Assert( 0, IsCongruentForMorphisms( cohom_beta_alpha_op, Opposite( opposite, hom_alpha_beta ) ) );
            
            # Opposite must be self-inverse
            
            Assert( 0, IsCongruentForMorphisms( hom_alpha_beta, Opposite( cohom_beta_alpha_op ) ) );
            Assert( 0, IsCongruentForMorphisms( hom_beta_alpha, Opposite( cohom_alpha_beta_op ) ) );
            
            # Convenience methods in the opposite category
            
            Assert( 0, IsCongruentForMorphisms( cohom_alpha_beta_op, InternalCoHom( alpha_op, beta_op ) ) );
            Assert( 0, IsCongruentForMorphisms( cohom_beta_alpha_op, InternalCoHom( beta_op, alpha_op ) ) );
            
        fi;
        
        if CanCompute( cat, "ClosedMonoidalRightEvaluationMorphism" ) then
            
            if verbose then
                
                # COVERAGE_IGNORE_NEXT_LINE
                Display( "Testing 'ClosedMonoidalRightEvaluationMorphism' ..." );
                
            fi;
            
            ev_ab := ClosedMonoidalRightEvaluationMorphism( a, b );
            ev_ba := ClosedMonoidalRightEvaluationMorphism( b, a );
            
            cocl_ev_ab_op := CoclosedMonoidalRightEvaluationMorphism( a_op, b_op );
            cocl_ev_ba_op := CoclosedMonoidalRightEvaluationMorphism( b_op, a_op );
            
            # Arguments must be reversed for evaluations
            Assert( 0, IsCongruentForMorphisms( cocl_ev_ab_op, Opposite( opposite, ev_ab ) ) );
            Assert( 0, IsCongruentForMorphisms( cocl_ev_ba_op, Opposite( opposite, ev_ba ) ) );
            
        fi;
        
        if CanCompute( cat, "ClosedMonoidalRightCoevaluationMorphism" ) then
            
            if verbose then
                
                # COVERAGE_IGNORE_NEXT_LINE
                Display( "Testing 'ClosedMonoidalRightEvaluationMorphism' ..." );
                
            fi;
            
            coev_ab := ClosedMonoidalRightCoevaluationMorphism( a, b );
            coev_ba := ClosedMonoidalRightCoevaluationMorphism( b, a );
            
            cocl_coev_ab_op := CoclosedMonoidalRightCoevaluationMorphism( a_op, b_op );
            cocl_coev_ba_op := CoclosedMonoidalRightCoevaluationMorphism( b_op, a_op );
            
            Assert( 0, IsCongruentForMorphisms( cocl_coev_ab_op, Opposite( opposite, coev_ab ) ) );
            Assert( 0, IsCongruentForMorphisms( cocl_coev_ba_op, Opposite( opposite, coev_ba ) ) );
            
        fi;
        
        if CanCompute( cat, "ClosedMonoidalLeftEvaluationMorphism" ) then
            
            if verbose then
                
                # COVERAGE_IGNORE_NEXT_LINE
                Display( "Testing 'ClosedMonoidalLeftEvaluationMorphism' ..." );
                
            fi;
            
            ev_ab := ClosedMonoidalLeftEvaluationMorphism( a, b );
            ev_ba := ClosedMonoidalLeftEvaluationMorphism( b, a );
            
            cocl_ev_ab_op := CoclosedMonoidalLeftEvaluationMorphism( a_op, b_op );
            cocl_ev_ba_op := CoclosedMonoidalLeftEvaluationMorphism( b_op, a_op );
            
            # Arguments must be reversed for evaluations
            Assert( 0, IsCongruentForMorphisms( cocl_ev_ab_op, Opposite( opposite, ev_ab ) ) );
            Assert( 0, IsCongruentForMorphisms( cocl_ev_ba_op, Opposite( opposite, ev_ba ) ) );
            
        fi;
        
        if CanCompute( cat, "ClosedMonoidalLeftCoevaluationMorphism" ) then
            
            if verbose then
                
                # COVERAGE_IGNORE_NEXT_LINE
                Display( "Testing 'ClosedMonoidalLeftEvaluationMorphism' ..." );
                
            fi;
            
            coev_ab := ClosedMonoidalLeftCoevaluationMorphism( a, b );
            coev_ba := ClosedMonoidalLeftCoevaluationMorphism( b, a );
            
            cocl_coev_ab_op := CoclosedMonoidalLeftCoevaluationMorphism( a_op, b_op );
            cocl_coev_ba_op := CoclosedMonoidalLeftCoevaluationMorphism( b_op, a_op );
            
            Assert( 0, IsCongruentForMorphisms( cocl_coev_ab_op, Opposite( opposite, coev_ab ) ) );
            Assert( 0, IsCongruentForMorphisms( cocl_coev_ba_op, Opposite( opposite, coev_ba ) ) );
            
        fi;
        
        if CanCompute( cat, "TensorProductToInternalHomRightAdjunctionIsomorphism" ) then
            
            if verbose then
                
                # COVERAGE_IGNORE_NEXT_LINE
                Display( "Testing 'TensorProductToInternalHomRightAdjunctionIsomorphism' ..." );
                
            fi;
            
            raiso := TensorProductToInternalHomRightAdjunctionIsomorphism( a, b, c );
            
            Assert( 0, IsIsomorphism( raiso ) );
            
            if CanCompute( cat, "TensorProductToInternalHomLeftAdjunctionIsomorphism" ) then
                
                laiso := TensorProductToInternalHomLeftAdjunctionIsomorphism( b, a, c );
                
                Assert( 0, IsIsomorphism( laiso ) );
                
                if CanCompute( cat, "Braiding" ) then
                    
                    H_ab_ba_c := HomStructure( Braiding( a, b ), c );
                    
                    Assert( 0, IsIsomorphism( H_ab_ba_c ) );
                    
                    Assert( 0, IsEqualForMorphisms( laiso, PreCompose( H_ab_ba_c, raiso ) ) );
                    
                fi;
                
            fi;
            
        fi;
        
        if CanCompute( cat, "InternalHomToTensorProductRightAdjunctionIsomorphism" ) then
            
            if verbose then
                
                # COVERAGE_IGNORE_NEXT_LINE
                Display( "Testing 'InternalHomToTensorProductRightAdjunctionIsomorphism' ..." );
                
            fi;
            
            raiso := InternalHomToTensorProductRightAdjunctionIsomorphism( a, b, c );
            
            Assert( 0, IsIsomorphism( raiso ) );
            
            if CanCompute( cat, "InternalHomToTensorProductLeftAdjunctionIsomorphism" ) then
                
                laiso := InternalHomToTensorProductLeftAdjunctionIsomorphism( b, a, c );
                
                Assert( 0, IsIsomorphism( laiso ) );
                
                if CanCompute( cat, "Braiding" ) then
                    
                    H_ab_ba_c := HomStructure( Braiding( a, b ), c );
                    
                    Assert( 0, IsIsomorphism( H_ab_ba_c ) );
                    
                    Assert( 0, IsEqualForMorphisms( raiso, PreCompose( H_ab_ba_c, laiso ) ) );
                    
                fi;
                
            fi;
            
        fi;
        
        if CanCompute( cat, "TensorProductToInternalHomLeftAdjunctMorphism" ) then
            
            if verbose then
                
                # COVERAGE_IGNORE_NEXT_LINE
                Display( "Testing 'TensorProductToInternalHomLeftAdjunctMorphism' ..." );
                
            fi;
            
            ######################################
            # 
            # alpha: a → b
            # beta:  c → d
            # 
            # alpha_tensor_beta: a ⊗ c → b ⊗ d
            # beta_tensor_alpha: c ⊗ a → d ⊗ b
            #
            ######################################
            #
            # alpha_op: b → a
            # beta_op:  d → c
            #
            # alpha_tensor_beta_op: b ⊗ d → a ⊗ c
            # beta_tensor_alpha_op: d ⊗ b → c ⊗ a
            #
            ######################################
            
            alpha_tensor_beta := TensorProductOnMorphisms( alpha, beta );
            beta_tensor_alpha := TensorProductOnMorphisms( beta, alpha );
            alpha_tensor_beta_op := TensorProductOnMorphisms( opposite, alpha_op, beta_op );
            beta_tensor_alpha_op := TensorProductOnMorphisms( opposite, beta_op, alpha_op );
            
            # Adjoint( a ⊗ c → b ⊗ d )  ==  a → Hom( c, b ⊗ d )
            tensor_to_hom_adjunction_on_alpha_tensor_beta := TensorProductToInternalHomLeftAdjunctMorphism( a, c, alpha_tensor_beta );
            
            # Adjoint( c ⊗ a → d ⊗ b )  ==  c → Hom( a, d ⊗ b )
            tensor_to_hom_adjunction_on_beta_tensor_alpha := TensorProductToInternalHomLeftAdjunctMorphism( c, a, beta_tensor_alpha );
            
            # Adjoint( b ⊗ d → a ⊗ c )  ==  Cohom( b ⊗ d, c ) → a
            tensor_to_cohom_adjunction_on_alpha_tensor_beta_op := TensorProductToInternalCoHomLeftAdjunctMorphism( a_op, c_op, alpha_tensor_beta_op );
            
            # Adjoint( d ⊗ b → c ⊗ a )  ==  Cohom( d ⊗ b, a ) → c
            tensor_to_cohom_adjunction_on_beta_tensor_alpha_op := TensorProductToInternalCoHomLeftAdjunctMorphism( c_op, a_op, beta_tensor_alpha_op );
            
            # coHom( b ⊗ d, c ) → a  ==  op( a → Hom( c, b ⊗ d ) )
            Assert( 0, IsCongruentForMorphisms( tensor_to_cohom_adjunction_on_alpha_tensor_beta_op, Opposite( opposite, tensor_to_hom_adjunction_on_alpha_tensor_beta ) ) );
            
            # coHom( d ⊗ b, a ) → c  ==  op( c → Hom( a, d ⊗ b ) )
            Assert( 0, IsCongruentForMorphisms( tensor_to_cohom_adjunction_on_beta_tensor_alpha_op, Opposite( opposite, tensor_to_hom_adjunction_on_beta_tensor_alpha ) ) );
            
        fi;
        
        if CanCompute( cat, "InternalHomToTensorProductLeftAdjunctMorphism" ) then
            
            if verbose then
                
                # COVERAGE_IGNORE_NEXT_LINE
                Display( "Testing 'InternalHomToTensorProductLeftAdjunctMorphism' ..." );
                
            fi;
            
            #####################################################
            #
            # hom_alpha_beta: Hom( b, c ) → Hom( a, d )
            # hom_beta_alpha: Hom( d, a ) → Hom( c, b )
            #
            #####################################################
            #
            # cohom_alpha_beta: coHom( a, d ) → coHom( b, c )
            # cohom_beta_alpha: coHom( c, b ) → coHom( d, a )
            #
            # cohom_alpha_beta_op: coHom( b, c ) → coHom( a, d )
            # cohom_beta_alpha_op: coHom( d, a ) → coHom( c, b )
            #
            #####################################################
            
            # Adjoint( Hom( b, c ) → Hom( a, d ) )  ==  Hom( b, c ) ⊗ a → d
            hom_to_tensor_adjunction_on_hom_alpha_beta := InternalHomToTensorProductLeftAdjunctMorphism( a, d, hom_alpha_beta );
            
            # Adjoint( Hom( d, a ) → Hom( c, b ) )  ==  Hom( d, a ) ⊗ c → b
            hom_to_tensor_adjunction_on_hom_beta_alpha := InternalHomToTensorProductLeftAdjunctMorphism( c, b, hom_beta_alpha );
            
            # Adjoint( Cohom( b, c ) → Cohom( a, d ) )  ==  b → Cohom( a, d ) ⊗ c
            cohom_to_tensor_adjunction_on_cohom_alpha_beta_op := InternalCoHomToTensorProductLeftAdjunctMorphism( b_op, c_op, cohom_alpha_beta_op );
            
            # Adjoint( Cohom( d, a ) → Cohom( c, b ) )  ==  d → Cohom( c, b ) ⊗ a
            cohom_to_tensor_adjunction_on_cohom_beta_alpha_op := InternalCoHomToTensorProductLeftAdjunctMorphism( d_op, a_op, cohom_beta_alpha_op );
            
            # b → coHom( a, d ) ⊗ c  ==  op( Hom( d, a ) ⊗ c → b )
            Assert( 0, IsCongruentForMorphisms( cohom_to_tensor_adjunction_on_cohom_alpha_beta_op, Opposite( opposite, hom_to_tensor_adjunction_on_hom_beta_alpha ) ) );
            
            # d → coHom( c, b ) ⊗ a  ==  op( Hom( b, c ) ⊗ a → d )
            Assert( 0, IsCongruentForMorphisms( cohom_to_tensor_adjunction_on_cohom_beta_alpha_op, Opposite( opposite, hom_to_tensor_adjunction_on_hom_alpha_beta ) ) );
            
        fi;
        
        if CanCompute( cat, "MonoidalPreComposeMorphism" ) then
            
            if verbose then
                
                # COVERAGE_IGNORE_NEXT_LINE
                Display( "Testing 'MonoidalPreComposeMorphism' ..." );
                
            fi;
            
            precompose_abc := MonoidalPreComposeMorphism( a, b, c );
            precompose_cba := MonoidalPreComposeMorphism( c, b, a );

            precocompose_abc_op := MonoidalPreCoComposeMorphism( a_op, b_op, c_op );
            precocompose_cba_op := MonoidalPreCoComposeMorphism( c_op, b_op, a_op );
            
            Assert( 0, IsCongruentForMorphisms( precocompose_abc_op, Opposite( opposite, precompose_cba ) ) );
            Assert( 0, IsCongruentForMorphisms( precocompose_cba_op, Opposite( opposite, precompose_abc ) ) );

        fi;
            
        if CanCompute( cat, "MonoidalPostComposeMorphism" ) then
            
            if verbose then
                
                # COVERAGE_IGNORE_NEXT_LINE
                Display( "Testing 'MonoidalPostComposeMorphism' ..." );
                
            fi;
            
            postcompose_abc := MonoidalPostComposeMorphism( a, b, c );
            postcompose_cba := MonoidalPostComposeMorphism( c, b, a );
            
            postcocompose_abc_op := MonoidalPostCoComposeMorphism( a_op, b_op, c_op );
            postcocompose_cba_op := MonoidalPostCoComposeMorphism( c_op, b_op, a_op );
            
            Assert( 0, IsCongruentForMorphisms( postcocompose_abc_op, Opposite( opposite, postcompose_cba ) ) );
            Assert( 0, IsCongruentForMorphisms( postcocompose_cba_op, Opposite( opposite, postcompose_abc ) ) );
            
        fi;
        
        if CanCompute( cat, "DualOnObjects" ) then
            
            if verbose then
                
                # COVERAGE_IGNORE_NEXT_LINE
                Display( "Testing 'DualOnObjects' ..." );
                
            fi;
            
            a_dual := DualOnObjects( a );
            b_dual := DualOnObjects( b );
            
            a_codual_op := CoDualOnObjects( a_op );
            b_codual_op := CoDualOnObjects( b_op );
            
            Assert( 0, IsEqualForObjects( a_codual_op, Opposite( opposite, a_dual ) ) );
            Assert( 0, IsEqualForObjects( b_codual_op, Opposite( opposite, b_dual ) ) );
            
        fi;
        
        if CanCompute( cat, "DualOnMorphisms" ) then
            
            if verbose then
                
                # COVERAGE_IGNORE_NEXT_LINE
                Display( "Testing 'DualOnMorphisms' ..." );
                
            fi;
            
            dual_alpha := DualOnMorphisms( alpha );
            dual_beta := DualOnMorphisms( beta );
            
            codual_alpha_op := CoDualOnMorphisms( alpha_op );
            codual_beta_op := CoDualOnMorphisms( beta_op );
            
            Assert( 0, IsCongruentForMorphisms( codual_alpha_op, Opposite( opposite, dual_alpha ) ) );
            Assert( 0, IsCongruentForMorphisms( codual_beta_op, Opposite( opposite, dual_beta ) ) );
            
        fi;
        
        if CanCompute( cat, "EvaluationForDual" ) then
            
            if verbose then
                
                # COVERAGE_IGNORE_NEXT_LINE
                Display( "Testing 'EvaluationForDual' ..." );
                
            fi;
            
            ev_for_dual_a := EvaluationForDual( a );
            ev_for_dual_b := EvaluationForDual( b );
            
            cocl_ev_for_codual_a_op := CoclosedEvaluationForCoDual( a_op );
            cocl_ev_for_codual_b_op := CoclosedEvaluationForCoDual( b_op );
            
            Assert( 0, IsCongruentForMorphisms( cocl_ev_for_codual_a_op, Opposite( opposite, ev_for_dual_a ) ) );
            Assert( 0, IsCongruentForMorphisms( cocl_ev_for_codual_b_op, Opposite( opposite, ev_for_dual_b ) ) );
            
        fi;
        
        if CanCompute( cat, "MorphismToBidual" ) then
            
            if verbose then
                
                # COVERAGE_IGNORE_NEXT_LINE
                Display( "Testing 'MorphismToBidual' ..." );
                
            fi;
            
            morphism_to_bidual_a := MorphismToBidual( a );
            morphism_to_bidual_b := MorphismToBidual( b );
            
            morphism_from_cobidual_a_op := MorphismFromCoBidual( a_op );
            morphism_from_cobidual_b_op := MorphismFromCoBidual( b_op );
            
            Assert( 0, IsCongruentForMorphisms( morphism_from_cobidual_a_op, Opposite( opposite, morphism_to_bidual_a ) ) );
            Assert( 0, IsCongruentForMorphisms( morphism_from_cobidual_b_op, Opposite( opposite, morphism_to_bidual_b ) ) );
            
        fi;
        
        if CanCompute( cat, "TensorProductInternalHomCompatibilityMorphism" ) then
            
            if verbose then
                
                # COVERAGE_IGNORE_NEXT_LINE
                Display( "Testing 'TensorProductInternalHomCompatibilityMorphism' ..." );
                
            fi;
            
            # Hom( a, b ) ⊗ Hom( c, d ) → Hom( a ⊗ c, b ⊗ d )
            tensor_to_hom_compatibility_abcd := TensorProductInternalHomCompatibilityMorphism( [ a, b, c, d ] );
            
            # Hom( c, a ) ⊗ Hom( d, b ) → Hom( c ⊗ d, a ⊗ b )
            tensor_to_hom_compatibility_cadb := TensorProductInternalHomCompatibilityMorphism( [ c, a, d, b ] );
            
            # Cohom( a ⊗ b, c ⊗ d ) → Cohom( a, c ) ⊗ Cohom( b, d )
            cohom_to_tensor_compatibility_abcd_op := InternalCoHomTensorProductCompatibilityMorphism( [ a_op, b_op, c_op, d_op ] );
            
            # Cohom( b ⊗ d, a ⊗ c ) → Cohom( b, a ) ⊗ Cohom( d, c )
            cohom_to_tensor_compatibility_bdac_op := InternalCoHomTensorProductCompatibilityMorphism( [ b_op, d_op, a_op, c_op ] );
            
            # coHom( a ⊗ b, c ⊗ d ) → coHom( a, c ) ⊗ coHom( b, d )  ==  op( Hom( c, a ) ⊗ Hom( d, b ) → Hom( c ⊗ d, a ⊗ b ) )
            Assert( 0, IsCongruentForMorphisms( cohom_to_tensor_compatibility_abcd_op, Opposite( opposite, tensor_to_hom_compatibility_cadb ) ) );
            
            # coHom( b ⊗ d, a ⊗ c ) → coHom( b, a ) ⊗ coHom( d, c )  ==  op( Hom( a, b ) ⊗ Hom( c, d ) → Hom( a ⊗ c, b ⊗ d ) )
            Assert( 0, IsCongruentForMorphisms( cohom_to_tensor_compatibility_bdac_op, Opposite( opposite, tensor_to_hom_compatibility_abcd ) ) );
            
        fi;
        
        if CanCompute( cat, "TensorProductDualityCompatibilityMorphism" ) then
            
            if verbose then
                
                # COVERAGE_IGNORE_NEXT_LINE
                Display( "Testing 'TensorProductDualityCompatibilityMorphism' ..." );
                
            fi;
            
            # a^v ⊗ b^v → (a ⊗ b)^v
            tensor_product_duality_compatibility_ab := TensorProductDualityCompatibilityMorphism( a, b );
            
            # b^v ⊗ a^v → (b ⊗ a)^v
            tensor_product_duality_compatibility_ba := TensorProductDualityCompatibilityMorphism( b, a );
            
            # (a ⊗ b)_v → a_v ⊗ b_v
            coduality_tensor_product_compatibility_ab_op := CoDualityTensorProductCompatibilityMorphism( a_op, b_op );
            
            # (b ⊗ a)_v → b_v ⊗ a_v
            coduality_tensor_product_compatibility_ba_op := CoDualityTensorProductCompatibilityMorphism( b_op, a_op );
            
            # (a ⊗ b)_v → a_v ⊗ b_v  ==  op( a^v ⊗ b^v → (a ⊗ b)^v )
            Assert( 0, IsCongruentForMorphisms( coduality_tensor_product_compatibility_ab_op, Opposite( opposite, tensor_product_duality_compatibility_ab ) ) );
            
            # (b ⊗ a)_v → b_v ⊗ a_v  ==  op( b^v ⊗ a^v → (b ⊗ a)^v )
            Assert( 0, IsCongruentForMorphisms( coduality_tensor_product_compatibility_ba_op, Opposite( opposite, tensor_product_duality_compatibility_ba ) ) );
            
        fi;
        
        if CanCompute( cat, "MorphismFromTensorProductToInternalHom" ) then
            
            if verbose then
                
                # COVERAGE_IGNORE_NEXT_LINE
                Display( "Testing 'MorphismFromTensorProductToInternalHom' ..." );
                
            fi;
            
            morphism_from_tensor_product_to_hom_ab := MorphismFromTensorProductToInternalHom( a, b );
            morphism_from_tensor_product_to_hom_ba := MorphismFromTensorProductToInternalHom( b, a );

            morphism_from_cohom_to_tensor_product_ab_op := MorphismFromInternalCoHomToTensorProduct( a_op, b_op );
            morphism_from_cohom_to_tensor_product_ba_op := MorphismFromInternalCoHomToTensorProduct( b_op, a_op );
            
            Assert( 0, IsCongruentForMorphisms( morphism_from_cohom_to_tensor_product_ab_op, Opposite( opposite, morphism_from_tensor_product_to_hom_ba ) ) );
            Assert( 0, IsCongruentForMorphisms( morphism_from_cohom_to_tensor_product_ba_op, Opposite( opposite, morphism_from_tensor_product_to_hom_ab ) ) );
            
        fi;
        
        if CanCompute( cat, "IsomorphismFromDualObjectToInternalHomIntoTensorUnit" ) then
            
            if verbose then
                
                # COVERAGE_IGNORE_NEXT_LINE
                Display( "Testing 'IsomorphismFromDualObjectToInternalHomIntoTensorUnit' ..." );
                
            fi;
            
            isomorphism_from_dual_to_hom_a := IsomorphismFromDualObjectToInternalHomIntoTensorUnit( a );
            isomorphism_from_dual_to_hom_b := IsomorphismFromDualObjectToInternalHomIntoTensorUnit( b );
            
            isomorphism_from_cohom_to_codual_a_op := IsomorphismFromInternalCoHomFromTensorUnitToCoDualObject( a_op );
            isomorphism_from_cohom_to_codual_b_op := IsomorphismFromInternalCoHomFromTensorUnitToCoDualObject( b_op );
            
            Assert( 0, IsCongruentForMorphisms( isomorphism_from_cohom_to_codual_a_op, Opposite( opposite, isomorphism_from_dual_to_hom_a ) ) );
            Assert( 0, IsCongruentForMorphisms( isomorphism_from_cohom_to_codual_b_op, Opposite( opposite, isomorphism_from_dual_to_hom_b ) ) );
            
        fi;
        
        if CanCompute( cat, "IsomorphismFromInternalHomIntoTensorUnitToDualObject" ) then
            
            if verbose then
                
                # COVERAGE_IGNORE_NEXT_LINE
                Display( "Testing 'IsomorphismFromInternalHomIntoTensorUnitToDualObject' ..." );
                
            fi;
            
            isomorphism_from_hom_to_dual_a := IsomorphismFromInternalHomIntoTensorUnitToDualObject( a );
            isomorphism_from_hom_to_dual_b := IsomorphismFromInternalHomIntoTensorUnitToDualObject( b );
            
            isomorphism_from_codual_to_cohom_a_op := IsomorphismFromCoDualObjectToInternalCoHomFromTensorUnit( a_op );
            isomorphism_from_codual_to_cohom_b_op := IsomorphismFromCoDualObjectToInternalCoHomFromTensorUnit( b_op );
            
            Assert( 0, IsCongruentForMorphisms( isomorphism_from_codual_to_cohom_a_op, Opposite( opposite, isomorphism_from_hom_to_dual_a ) ) );
            Assert( 0, IsCongruentForMorphisms( isomorphism_from_codual_to_cohom_b_op, Opposite( opposite, isomorphism_from_hom_to_dual_b ) ) );
            
        fi;
        
        if CanCompute( cat, "UniversalPropertyOfDual" ) then
            
            if verbose then
                
                # COVERAGE_IGNORE_NEXT_LINE
                Display( "Testing 'UniversalPropertyOfDual' ..." );
                
            fi;
            
            gamma_op := Opposite( opposite, gamma );
            delta_op := Opposite( opposite, delta );
            
            universal_property_of_dual_gamma := UniversalPropertyOfDual( a, b, gamma );
            universal_property_of_dual_delta := UniversalPropertyOfDual( c, d, delta );

            universal_property_of_codual_gamma_op := UniversalPropertyOfCoDual( a_op, b_op, gamma_op );
            universal_property_of_codual_delta_op := UniversalPropertyOfCoDual( c_op, d_op, delta_op );
            
            Assert( 0, IsCongruentForMorphisms( universal_property_of_codual_gamma_op, Opposite( opposite, universal_property_of_dual_gamma ) ) );
            Assert( 0, IsCongruentForMorphisms( universal_property_of_codual_delta_op, Opposite( opposite, universal_property_of_dual_delta ) ) );
            
        fi;
        
        if CanCompute( cat, "LambdaIntroduction" ) then
            
            if verbose then
                
                # COVERAGE_IGNORE_NEXT_LINE
                Display( "Testing 'LambdaIntroduction' ..." );
                
            fi;
            
            lambda_intro_alpha := LambdaIntroduction( alpha );
            lambda_intro_beta := LambdaIntroduction( beta );
            
            colambda_intro_alpha_op := CoLambdaIntroduction( alpha_op );
            colambda_intro_beta_op := CoLambdaIntroduction( beta_op );
            
            Assert( 0, IsCongruentForMorphisms( colambda_intro_alpha_op, Opposite( opposite, lambda_intro_alpha ) ) );
            Assert( 0, IsCongruentForMorphisms( colambda_intro_beta_op, Opposite( opposite, lambda_intro_beta ) ) );
            
        fi;
        
        if CanCompute( cat, "LambdaElimination" ) then
            
            if verbose then
                
                # COVERAGE_IGNORE_NEXT_LINE
                Display( "Testing 'LambdaElimination' ..." );
                
            fi;
            
            epsilon_op := Opposite( opposite, epsilon );
            zeta_op := Opposite( opposite, zeta );
            
            lambda_elim_epsilon := LambdaElimination( a, b, epsilon );
            lambda_elim_zeta := LambdaElimination( c, d, zeta );

            colambda_elim_epsilon_op := CoLambdaElimination( b_op, a_op, epsilon_op );
            colambda_elim_zeta_op := CoLambdaElimination( d_op, c_op, zeta_op );
            
            Assert( 0, IsCongruentForMorphisms( colambda_elim_epsilon_op, Opposite( opposite, lambda_elim_epsilon ) ) );
            Assert( 0, IsCongruentForMorphisms( colambda_elim_zeta_op, Opposite( opposite, lambda_elim_zeta ) ) );
            
        fi;
        
        if CanCompute( cat, "IsomorphismFromObjectToInternalHom" ) then
            
            if verbose then
                
                # COVERAGE_IGNORE_NEXT_LINE
                Display( "Testing 'IsomorphismFromObjectToInternalHom' ..." );
                
            fi;
            
            isomorphism_from_a_to_hom := IsomorphismFromObjectToInternalHom( a );
            isomorphism_from_b_to_hom := IsomorphismFromObjectToInternalHom( b );
            
            isomorphism_from_cohom_to_a_op := IsomorphismFromInternalCoHomToObject( a_op );
            isomorphism_from_cohom_to_b_op := IsomorphismFromInternalCoHomToObject( b_op );
            
            Assert( 0, IsCongruentForMorphisms( isomorphism_from_cohom_to_a_op, Opposite( opposite, isomorphism_from_a_to_hom ) ) );
            Assert( 0, IsCongruentForMorphisms( isomorphism_from_cohom_to_b_op, Opposite( opposite, isomorphism_from_b_to_hom ) ) );
            
        fi;
        
        if CanCompute( cat, "IsomorphismFromInternalHomToObject" ) then
            
            if verbose then
                
                # COVERAGE_IGNORE_NEXT_LINE
                Display( "Testing 'IsomorphismFromInternalHomToObject' ..." );
                
            fi;
            
            isomorphism_from_hom_to_a := IsomorphismFromInternalHomToObject( a );
            isomorphism_from_hom_to_b := IsomorphismFromInternalHomToObject( b );
            
            isomorphism_from_a_to_cohom_op := IsomorphismFromObjectToInternalCoHom( a_op );
            isomorphism_from_b_to_cohom_op := IsomorphismFromObjectToInternalCoHom( b_op );
            
            Assert( 0, IsCongruentForMorphisms( isomorphism_from_a_to_cohom_op, Opposite( opposite, isomorphism_from_hom_to_a ) ) );
            Assert( 0, IsCongruentForMorphisms( isomorphism_from_b_to_cohom_op, Opposite( opposite, isomorphism_from_hom_to_b ) ) );
            
        fi;
        
        if CanCompute( cat, "InternalHomOnObjects" ) and
           CanCompute( cat, "ClosedMonoidalLeftEvaluationMorphism" ) and
           CanCompute( cat, "InternalHomToTensorProductLeftAdjunctMorphism" )
        
        then
            
            if verbose then
                
                # COVERAGE_IGNORE_NEXT_LINE
                Display( "Consistency between 'EvalutionMorphism' and 'AdjunctMorphism' ..." );
                
            fi;
            
            ev_ab := ClosedMonoidalLeftEvaluationMorphism( a, b );
            ev_ba := ClosedMonoidalLeftEvaluationMorphism( b, a );
            
            id_hom_ab := IdentityMorphism( InternalHomOnObjects( a, b ) );
            id_hom_ba := IdentityMorphism( InternalHomOnObjects( b, a ) );
            
            # Adjoint( Hom( a, b ) → Hom( a, b ) )  ==  Hom( a, b ) ⊗ a → b
            hom_to_tensor_adjunction_on_id_hom_ab := InternalHomToTensorProductLeftAdjunctMorphism( a, b, id_hom_ab );
            
            # Adjoint( Hom( b, a ) → Hom( b, a ) )  ==  Hom( b, a ) ⊗ b → a
            hom_to_tensor_adjunction_on_id_hom_ba := InternalHomToTensorProductLeftAdjunctMorphism( b, a, id_hom_ba );
            
            Assert( 0, IsCongruentForMorphisms( ev_ab, hom_to_tensor_adjunction_on_id_hom_ab ) );
            Assert( 0, IsCongruentForMorphisms( ev_ba, hom_to_tensor_adjunction_on_id_hom_ba ) );
            
        fi;
        
        if CanCompute( cat, "TensorProductOnObjects" ) and
           CanCompute( cat, "ClosedMonoidalLeftCoevaluationMorphism" ) and
           CanCompute( cat, "TensorProductToInternalHomLeftAdjunctMorphism" )
        
        then
            
            if verbose then
                
                # COVERAGE_IGNORE_NEXT_LINE
                Display( "Consistency between 'CoevalutionMorphism' and 'AdjunctMorphism' ..." );
                
            fi;
            
            coev_ab := ClosedMonoidalLeftCoevaluationMorphism( a, b );
            coev_ba := ClosedMonoidalLeftCoevaluationMorphism( b, a );
            
            id_a_tensor_b := IdentityMorphism( TensorProductOnObjects( cat, a, b ) );
            id_b_tensor_a := IdentityMorphism( TensorProductOnObjects( cat, b, a ) );
            
            # Adjoint( a ⊗ b → a ⊗ b )  ==  a → Hom( b, a ⊗ b )
            tensor_to_hom_adjunction_on_id_a_tensor_b := TensorProductToInternalHomLeftAdjunctMorphism( a, b, id_a_tensor_b );
            
            # Adjoint( b ⊗ a → b ⊗ a )  ==  b → Hom( a, b ⊗ a )
            tensor_to_hom_adjunction_on_id_b_tensor_a := TensorProductToInternalHomLeftAdjunctMorphism( b, a, id_b_tensor_a );
            
            Assert( 0, IsCongruentForMorphisms( coev_ba, tensor_to_hom_adjunction_on_id_a_tensor_b ) );
            Assert( 0, IsCongruentForMorphisms( coev_ab, tensor_to_hom_adjunction_on_id_b_tensor_a ) );
            
        fi;

end );
