# SPDX-License-Identifier: GPL-2.0-or-later
# MonoidalCategories: Monoidal and monoidal (co)closed categories
#
# Implementations
#

InstallGlobalFunction( "CoclosedMonoidalCategoriesTest",
    
    function( cat, a, b, c, d, alpha, beta, gamma, delta, epsilon, zeta )
    
        local opposite, verbose,
              
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
        
        
        opposite := Opposite( cat );
        
        a_op := Opposite( a );
        b_op := Opposite( b );
        c_op := Opposite( c );
        d_op := Opposite( d );
        
        alpha_op := Opposite( alpha );
        beta_op := Opposite( beta );
        
        verbose := ValueOption( "verbose" ) = true;
        
        if CanCompute( cat, "InternalCoHomOnObjects" ) then
            
            if verbose then
                
                # COVERAGE_IGNORE_NEXT_LINE
                Display( "Testing 'InternalCoHomOnObjects' ..." );
                
            fi;
            
            cohom_ab := InternalCoHomOnObjects( a, b );
            cohom_ba := InternalCoHomOnObjects( b, a );
            
            hom_ab_op := InternalHomOnObjects( a_op, b_op );
            hom_ba_op := InternalHomOnObjects( b_op, a_op );
            
            Assert( 0, IsEqualForObjects( hom_ab_op, Opposite( cohom_ba ) ) );
            Assert( 0, IsEqualForObjects( hom_ba_op, Opposite( cohom_ab ) ) );
            
            # Opposite must be self-inverse
            
            Assert( 0, IsEqualForObjects( cohom_ab, Opposite( hom_ba_op ) ) );
            Assert( 0, IsEqualForObjects( cohom_ba, Opposite( hom_ab_op ) ) );
            
            # Convenience methods in the opposite category
            
            Assert( 0, IsEqualForObjects( hom_ab_op, InternalHom( a_op, b_op ) ) );
            Assert( 0, IsEqualForObjects( hom_ba_op, InternalHom( b_op, a_op ) ) );
            
        fi;
        
        if CanCompute( cat, "InternalCoHomOnMorphisms" ) then
            
            if verbose then
                
                # COVERAGE_IGNORE_NEXT_LINE
                Display( "Testing 'InternalCoHomOnMorphisms' ..." );
                
            fi;
            
            cohom_alpha_beta := InternalCoHomOnMorphisms( alpha, beta );
            cohom_beta_alpha := InternalCoHomOnMorphisms( beta, alpha );
            
            hom_alpha_beta_op := InternalHomOnMorphisms( alpha_op, beta_op );
            hom_beta_alpha_op := InternalHomOnMorphisms( beta_op, alpha_op );
            
            Assert( 0, IsCongruentForMorphisms( hom_alpha_beta_op, Opposite( cohom_beta_alpha ) ) );
            Assert( 0, IsCongruentForMorphisms( hom_beta_alpha_op, Opposite( cohom_alpha_beta ) ) );
            
            # Opposite must be self-inverse
            
            Assert( 0, IsCongruentForMorphisms( cohom_alpha_beta, Opposite( hom_beta_alpha_op ) ) );
            Assert( 0, IsCongruentForMorphisms( cohom_beta_alpha, Opposite( hom_alpha_beta_op ) ) );
            
            # Convenience methods in the opposite category
            
            Assert( 0, IsCongruentForMorphisms( hom_alpha_beta_op, InternalHom( alpha_op, beta_op ) ) );
            Assert( 0, IsCongruentForMorphisms( hom_beta_alpha_op, InternalHom( beta_op, alpha_op ) ) );
            
        fi;
        
        if CanCompute( cat, "CoclosedEvaluationMorphism" ) then
            
            if verbose then
                
                # COVERAGE_IGNORE_NEXT_LINE
                Display( "Testing 'CoclosedEvaluationMorphism' ..." );
                
            fi;
            
            cocl_ev_ab := CoclosedEvaluationMorphism( a, b );
            cocl_ev_ba := CoclosedEvaluationMorphism( b, a );
            
            ev_ab_op := EvaluationMorphism( a_op, b_op );
            ev_ba_op := EvaluationMorphism( b_op, a_op );
            
            # Arguments must be reversed for evaluations
            Assert( 0, IsCongruentForMorphisms( cocl_ev_ab, Opposite( ev_ba_op ) ) );
            Assert( 0, IsCongruentForMorphisms( cocl_ev_ba, Opposite( ev_ab_op ) ) );
            
        fi;
        
        if CanCompute( cat, "CoclosedCoevaluationMorphism" ) then
            
            if verbose then
                
                # COVERAGE_IGNORE_NEXT_LINE
                Display( "Testing 'CoclosedCoevaluationMorphism' ..." );
                
            fi;
            
            cocl_coev_ab := CoclosedCoevaluationMorphism( a, b );
            cocl_coev_ba := CoclosedCoevaluationMorphism( b, a );
            
            coev_ab_op := CoevaluationMorphism( a_op, b_op );
            coev_ba_op := CoevaluationMorphism( b_op, a_op );
            
            Assert( 0, IsCongruentForMorphisms( coev_ab_op, Opposite( cocl_coev_ab ) ) );
            Assert( 0, IsCongruentForMorphisms( coev_ba_op, Opposite( cocl_coev_ba ) ) );
            
        fi;
        
        if CanCompute( cat, "TensorProductToInternalCoHomAdjunctionMap" ) then
            
            if verbose then
                
                # COVERAGE_IGNORE_NEXT_LINE
                Display( "Testing 'TensorProductToInternalCoHomAdjunctionMap' ..." );
                
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
            tensor_to_cohom_adjunction_on_alpha_tensor_beta := TensorProductToInternalCoHomAdjunctionMap( b, d, alpha_tensor_beta );
            
            # Adjoint( c ⊗ a → d ⊗ b )  ==  Cohom( c ⊗ a, b ) → d
            tensor_to_cohom_adjunction_on_beta_tensor_alpha := TensorProductToInternalCoHomAdjunctionMap( d, b, beta_tensor_alpha );
            
            # Adjoint( b ⊗ d → a ⊗ c )  ==  b → Hom( d, a ⊗ c )
            tensor_to_hom_adjunction_on_alpha_tensor_beta_op := TensorProductToInternalHomAdjunctionMap( b_op, d_op, alpha_tensor_beta_op );
            
            # Adjoint( d ⊗ b → c ⊗ a )  ==  d → Hom( b, c ⊗ a )
            tensor_to_hom_adjunction_on_beta_tensor_alpha_op := TensorProductToInternalHomAdjunctionMap( d_op, b_op, beta_tensor_alpha_op );
            
            # Cohom( b ⊗ d, c ) → a  ==  op( a → Hom( c, b ⊗ d ) )
            Assert( 0, IsCongruentForMorphisms( tensor_to_hom_adjunction_on_alpha_tensor_beta_op, Opposite( tensor_to_cohom_adjunction_on_alpha_tensor_beta ) ) );
            
            # Cohom( d ⊗ b, a ) → c  ==  op( c → Hom( a, d ⊗ b ) )
            Assert( 0, IsCongruentForMorphisms( tensor_to_hom_adjunction_on_beta_tensor_alpha_op, Opposite( tensor_to_cohom_adjunction_on_beta_tensor_alpha ) ) );
            
        fi;
        
        if CanCompute( cat, "InternalCoHomToTensorProductAdjunctionMap" ) then
            
            if verbose then
                
                # COVERAGE_IGNORE_NEXT_LINE
                Display( "Testing 'InternalCoHomToTensorProductAdjunctionMap' ..." );
                
            fi;
            
            #####################################################
            #
            # hom_alpha_beta: Hom( b, c ) → Hom( a, d )
            # hom_beta_alpha: Hom( d, a ) → Hom( c, b )
            #
            # hom_alpha_beta_op: Hom( a, d ) → Hom( b, c )
            # hom_beta_alpha_op: Hom( c, b ) → Hom( d, a )
            #
            #####################################################
            #
            # cohom_alpha_beta: Cohom( a, d ) → Cohom( b, c )
            # cohom_beta_alpha: Cohom( c, b ) → Cohom( d, a )
            #
            # cohom_alpha_beta_op: Cohom( b, c ) → Cohom( a, d )
            # cohom_beta_alpha_op: Cohom( d, a ) → Cohom( c, b )
            #
            #####################################################
            
            # Adjoint( Hom( b, c ) → Hom( a, d ) )  ==  Hom( b, c ) ⊗ a → d
            cohom_to_tensor_adjunction_on_cohom_alpha_beta := InternalCoHomToTensorProductAdjunctionMap( a, d, cohom_alpha_beta );
            
            # Adjoint( Hom( d, a ) → Hom( c, b ) )  ==  Hom( d, a ) ⊗ c → b
            cohom_to_tensor_adjunction_on_cohom_beta_alpha := InternalCoHomToTensorProductAdjunctionMap( c, b, cohom_beta_alpha );
            
            # Adjoint( Cohom( b, c ) → Cohom( a, d ) )  ==  b → Cohom( a, d ) ⊗ c
            hom_to_tensor_adjunction_on_hom_alpha_beta_op := InternalHomToTensorProductAdjunctionMap( b_op, c_op, hom_alpha_beta_op );
            
            # Adjoint( Cohom( d, a ) → Cohom( c, b ) )  ==  d → Cohom( c, b ) ⊗ a
            hom_to_tensor_adjunction_on_hom_beta_alpha_op := InternalHomToTensorProductAdjunctionMap( d_op, a_op, hom_beta_alpha_op );
            
            # b → Cohom( a, d ) ⊗ c  ==  op( Hom( d, a ) ⊗ c → b )
            Assert( 0, IsCongruentForMorphisms( hom_to_tensor_adjunction_on_hom_alpha_beta_op, Opposite( cohom_to_tensor_adjunction_on_cohom_beta_alpha ) ) );
            
            # d → Cohom( c, b ) ⊗ a  ==  op( Hom( b, c ) ⊗ a → d )
            Assert( 0, IsCongruentForMorphisms( hom_to_tensor_adjunction_on_hom_beta_alpha_op, Opposite( cohom_to_tensor_adjunction_on_cohom_alpha_beta ) ) );
            
        fi;
        
        if CanCompute( cat, "MonoidalPreCoComposeMorphism" ) then
            
            if verbose then
                
                # COVERAGE_IGNORE_NEXT_LINE
                Display( "Testing 'MonoidalPreCoComposeMorphism' ..." );
                
            fi;
            
            precocompose_abc := MonoidalPreCoComposeMorphism( a, b, c );
            precocompose_cba := MonoidalPreCoComposeMorphism( c, b, a );

            precompose_abc_op := MonoidalPreComposeMorphism( a_op, b_op, c_op );
            precompose_cba_op := MonoidalPreComposeMorphism( c_op, b_op, a_op );
            
            Assert( 0, IsCongruentForMorphisms( precompose_abc_op, Opposite( precocompose_cba ) ) );
            Assert( 0, IsCongruentForMorphisms( precompose_cba_op, Opposite( precocompose_abc ) ) );
        
        fi;
        
        if CanCompute( cat, "MonoidalPostCoComposeMorphism" ) then
            
            if verbose then
                
                # COVERAGE_IGNORE_NEXT_LINE
                Display( "Testing 'MonoidalPostCoComposeMorphism' ..." );
                
            fi;
            
            postcocompose_abc := MonoidalPostCoComposeMorphism( a, b, c );
            postcocompose_cba := MonoidalPostCoComposeMorphism( c, b, a );
            
            postcompose_abc_op := MonoidalPostComposeMorphism( a_op, b_op, c_op );
            postcompose_cba_op := MonoidalPostComposeMorphism( c_op, b_op, a_op );
            
            Assert( 0, IsCongruentForMorphisms( postcompose_abc_op, Opposite( postcocompose_cba ) ) );
            Assert( 0, IsCongruentForMorphisms( postcompose_cba_op, Opposite( postcocompose_abc ) ) );
            
        fi;
        
        if CanCompute( cat, "CoDualOnObjects" ) then
            
            if verbose then
                
                # COVERAGE_IGNORE_NEXT_LINE
                Display( "Testing 'CoDualOnObjects' ..." );
                
            fi;
            
            a_codual := CoDualOnObjects( a );
            b_codual := CoDualOnObjects( b );
            
            a_dual_op := DualOnObjects( a_op );
            b_dual_op := DualOnObjects( b_op );
            
            Assert( 0, IsEqualForObjects( a_dual_op, Opposite( a_codual ) ) );
            Assert( 0, IsEqualForObjects( b_dual_op, Opposite( b_codual ) ) );
            
        fi;
        
        if CanCompute( cat, "CoDualOnMorphisms" ) then
            
            if verbose then
                
                # COVERAGE_IGNORE_NEXT_LINE
                Display( "Testing 'CoDualOnMorphisms' ..." );
                
            fi;
            
            codual_alpha := CoDualOnMorphisms( alpha );
            codual_beta := CoDualOnMorphisms( beta );
            
            dual_alpha_op := DualOnMorphisms( alpha_op );
            dual_beta_op := DualOnMorphisms( beta_op );
            
            Assert( 0, IsCongruentForMorphisms( dual_alpha_op, Opposite( codual_alpha ) ) );
            Assert( 0, IsCongruentForMorphisms( dual_beta_op, Opposite( codual_beta ) ) );
            
        fi;
        
        if CanCompute( cat, "CoclosedEvaluationForCoDual" ) then
            
            if verbose then
                
                # COVERAGE_IGNORE_NEXT_LINE
                Display( "Testing 'CoclosedEvaluationForCoDual' ..." );
                
            fi;
            
            cocl_ev_for_codual_a := CoclosedEvaluationForCoDual( a );
            cocl_ev_for_codual_b := CoclosedEvaluationForCoDual( b );
            
            ev_for_dual_a_op := EvaluationForDual( a_op );
            ev_for_dual_b_op := EvaluationForDual( b_op );
            
            Assert( 0, IsCongruentForMorphisms( ev_for_dual_a_op, Opposite( cocl_ev_for_codual_a ) ) );
            Assert( 0, IsCongruentForMorphisms( ev_for_dual_b_op, Opposite( cocl_ev_for_codual_b ) ) );
            
        fi;
        
        if CanCompute( cat, "MorphismFromCoBidual" ) then
            
            if verbose then
                
                # COVERAGE_IGNORE_NEXT_LINE
                Display( "Testing 'MorphismFromCoBidual' ..." );
                
            fi;
            
            morphism_from_cobidual_a := MorphismFromCoBidual( a );
            morphism_from_cobidual_b := MorphismFromCoBidual( b );
            
            morphism_to_bidual_a_op := MorphismToBidual( a_op );
            morphism_to_bidual_b_op := MorphismToBidual( b_op );
            
            Assert( 0, IsCongruentForMorphisms( morphism_to_bidual_a_op, Opposite( morphism_from_cobidual_a ) ) );
            Assert( 0, IsCongruentForMorphisms( morphism_to_bidual_b_op, Opposite( morphism_from_cobidual_b ) ) );
            
        fi;
        
        if CanCompute( cat, "InternalCoHomTensorProductCompatibilityMorphism" ) then
            
            if verbose then
                
                # COVERAGE_IGNORE_NEXT_LINE
                Display( "Testing 'InternalCoHomTensorProductCompatibilityMorphism' ..." );
                
            fi;
            
            # Cohom( a ⊗ b, c ⊗ d ) → Cohom( a, c ) ⊗ Cohom( b, d )
            cohom_to_tensor_compatibility_abcd := InternalCoHomTensorProductCompatibilityMorphism( [ a, b, c, d ] );
            
            # Cohom( b ⊗ d, a ⊗ c ) → Cohom( b, a ) ⊗ Cohom( d, c )
            cohom_to_tensor_compatibility_bdac := InternalCoHomTensorProductCompatibilityMorphism( [ b, d, a, c ] );
            
            # Hom( a, b ) ⊗ Hom( c, d ) → Hom( a ⊗ c, b ⊗ d )
            tensor_to_hom_compatibility_abcd_op := TensorProductInternalHomCompatibilityMorphism( [ a_op, b_op, c_op, d_op ] );
            
            # Hom( c, a ) ⊗ Hom( d, b ) → Hom( c ⊗ d, a ⊗ b )
            tensor_to_hom_compatibility_cadb_op := TensorProductInternalHomCompatibilityMorphism( [ c_op, a_op, d_op, b_op ] );
            
            # Hom( a, b ) ⊗ Hom( c, d ) → Hom( a ⊗ c, b ⊗ d )  ==  op( Cohom( b ⊗ d, a ⊗ c ) → Cohom( b, a ) ⊗ Cohom( d, c ) )
            Assert( 0, IsCongruentForMorphisms( tensor_to_hom_compatibility_abcd_op, Opposite( cohom_to_tensor_compatibility_bdac ) ) );
            
            # Hom( c, a ) ⊗ Hom( d, b ) → Hom( c ⊗ d, a ⊗ b )  ==  op( Cohom( a ⊗ b, c ⊗ d ) → Cohom( a, c ) ⊗ Cohom( b, d ) )
            Assert( 0, IsCongruentForMorphisms( tensor_to_hom_compatibility_cadb_op, Opposite( cohom_to_tensor_compatibility_abcd ) ) );
            
        fi;
        
        if CanCompute( cat, "CoDualityTensorProductCompatibilityMorphism" ) then
            
            if verbose then
                
                # COVERAGE_IGNORE_NEXT_LINE
                Display( "Testing 'CoDualityTensorProductCompatibilityMorphism' ..." );
                
            fi;
            
            # (a ⊗ b)_v → a_v ⊗ b_v
            coduality_tensor_product_compatibility_ab := CoDualityTensorProductCompatibilityMorphism( a, b );
            
            # (b ⊗ a)_v → b_v ⊗ a_v
            coduality_tensor_product_compatibility_ba := CoDualityTensorProductCompatibilityMorphism( b, a );
            
            # a^v ⊗ b^v → (a ⊗ b)^v
            tensor_product_duality_compatibility_ab_op := TensorProductDualityCompatibilityMorphism( a_op, b_op );
            
            # b^v ⊗ a^v → (b ⊗ a)^v
            tensor_product_duality_compatibility_ba_op := TensorProductDualityCompatibilityMorphism( b_op, a_op );
            
            # a^v ⊗ b^v → (a ⊗ b)^v  == op( (a ⊗ b)_v → a_v ⊗ b_v )
            Assert( 0, IsCongruentForMorphisms( tensor_product_duality_compatibility_ab_op, Opposite( coduality_tensor_product_compatibility_ab ) ) );
            
            # b^v ⊗ a^v → (b ⊗ a)^v  ==  op( (b ⊗ a)_v → b_v ⊗ a_v )
            Assert( 0, IsCongruentForMorphisms( tensor_product_duality_compatibility_ba_op, Opposite( coduality_tensor_product_compatibility_ba ) ) );
            
        fi;
        
        if CanCompute( cat, "MorphismFromInternalCoHomToTensorProduct" ) then
            
            if verbose then
                
                # COVERAGE_IGNORE_NEXT_LINE
                Display( "Testing 'MorphismFromInternalCoHomToTensorProduct' ..." );
                
            fi;
            
            morphism_from_cohom_to_tensor_product_ab := MorphismFromInternalCoHomToTensorProduct( a, b );
            morphism_from_cohom_to_tensor_product_ba := MorphismFromInternalCoHomToTensorProduct( b, a );
            
            morphism_from_tensor_product_to_hom_ab_op := MorphismFromTensorProductToInternalHom( a_op, b_op );
            morphism_from_tensor_product_to_hom_ba_op := MorphismFromTensorProductToInternalHom( b_op, a_op );
            
            Assert( 0, IsCongruentForMorphisms( morphism_from_tensor_product_to_hom_ab_op, Opposite( morphism_from_cohom_to_tensor_product_ba ) ) );
            Assert( 0, IsCongruentForMorphisms( morphism_from_tensor_product_to_hom_ba_op, Opposite( morphism_from_cohom_to_tensor_product_ab ) ) );
            
        fi;
        
        if CanCompute( cat, "IsomorphismFromInternalCoHomFromTensorUnitToCoDualObject" ) then
            
            if verbose then
                
                # COVERAGE_IGNORE_NEXT_LINE
                Display( "Testing 'IsomorphismFromInternalCoHomFromTensorUnitToCoDualObject' ..." );
                
            fi;
            
            isomorphism_from_cohom_to_codual_a := IsomorphismFromInternalCoHomFromTensorUnitToCoDualObject( a );
            isomorphism_from_cohom_to_codual_b := IsomorphismFromInternalCoHomFromTensorUnitToCoDualObject( b );
            
            isomorphism_from_dual_to_hom_a_op := IsomorphismFromDualObjectToInternalHomIntoTensorUnit( a_op );
            isomorphism_from_dual_to_hom_b_op := IsomorphismFromDualObjectToInternalHomIntoTensorUnit( b_op );
            
            Assert( 0, IsCongruentForMorphisms( isomorphism_from_dual_to_hom_a_op, Opposite( isomorphism_from_cohom_to_codual_a ) ) );
            Assert( 0, IsCongruentForMorphisms( isomorphism_from_dual_to_hom_b_op, Opposite( isomorphism_from_cohom_to_codual_b ) ) );
            
        fi;
        
        if CanCompute( cat, "IsomorphismFromCoDualObjectToInternalCoHomFromTensorUnit" ) then
            
            if verbose then
                
                # COVERAGE_IGNORE_NEXT_LINE
                Display( "Testing 'IsomorphismFromCoDualObjectToInternalCoHomFromTensorUnit' ..." );
                
            fi;
            
            isomorphism_from_codual_to_cohom_a := IsomorphismFromCoDualObjectToInternalCoHomFromTensorUnit( a );
            isomorphism_from_codual_to_cohom_b := IsomorphismFromCoDualObjectToInternalCoHomFromTensorUnit( b );
            
            isomorphism_from_hom_to_dual_a_op := IsomorphismFromInternalHomIntoTensorUnitToDualObject( a_op );
            isomorphism_from_hom_to_dual_b_op := IsomorphismFromInternalHomIntoTensorUnitToDualObject( b_op );
            
            Assert( 0, IsCongruentForMorphisms( isomorphism_from_hom_to_dual_a_op, Opposite( isomorphism_from_codual_to_cohom_a ) ) );
            Assert( 0, IsCongruentForMorphisms( isomorphism_from_hom_to_dual_b_op, Opposite( isomorphism_from_codual_to_cohom_b ) ) );
            
        fi;
        
        if CanCompute( cat, "UniversalPropertyOfCoDual" ) then
            
            if verbose then
                
                # COVERAGE_IGNORE_NEXT_LINE
                Display( "Testing 'UniversalPropertyOfCoDual' ..." );
                
            fi;
            
            gamma_op := Opposite( gamma );
            delta_op := Opposite( delta );
            
            universal_property_of_codual_gamma := UniversalPropertyOfCoDual( a, b, gamma );
            universal_property_of_codual_delta := UniversalPropertyOfCoDual( c, d, delta );
            
            universal_property_of_dual_gamma_op := UniversalPropertyOfDual( a_op, b_op, gamma_op );
            universal_property_of_dual_delta_op := UniversalPropertyOfDual( c_op, d_op, delta_op );
            
            Assert( 0, IsCongruentForMorphisms( universal_property_of_dual_gamma_op, Opposite( universal_property_of_codual_gamma ) ) );
            Assert( 0, IsCongruentForMorphisms( universal_property_of_dual_delta_op, Opposite( universal_property_of_codual_delta ) ) );
            
        fi;
        
        if CanCompute( cat, "CoLambdaIntroduction" ) then
            
            if verbose then
                
                # COVERAGE_IGNORE_NEXT_LINE
                Display( "Testing 'CoLambdaIntroduction' ..." );
                
            fi;
            
            colambda_intro_alpha := CoLambdaIntroduction( alpha );
            colambda_intro_beta := CoLambdaIntroduction( beta );
            
            lambda_intro_alpha_op := LambdaIntroduction( alpha_op );
            lambda_intro_beta_op := LambdaIntroduction( beta_op );
            
            Assert( 0, IsCongruentForMorphisms( lambda_intro_alpha_op, Opposite( colambda_intro_alpha ) ) );
            Assert( 0, IsCongruentForMorphisms( lambda_intro_beta_op, Opposite( colambda_intro_beta ) ) );
            
        fi;
        
        if CanCompute( cat, "CoLambdaElimination" ) then
            
            if verbose then
                
                # COVERAGE_IGNORE_NEXT_LINE
                Display( "Testing 'CoLambdaElimination' ..." );
                
            fi;
            
            epsilon_op := Opposite( epsilon );
            zeta_op := Opposite( zeta );
            
            colambda_elim_epsilon := CoLambdaElimination( a, b, epsilon );
            colambda_elim_zeta := CoLambdaElimination( c, d, zeta );
            
            lambda_elim_epsilon_op := LambdaElimination( b_op, a_op, epsilon_op );
            lambda_elim_zeta_op := LambdaElimination( d_op, c_op, zeta_op );
            
            Assert( 0, IsCongruentForMorphisms( lambda_elim_epsilon_op, Opposite( colambda_elim_epsilon ) ) );
            Assert( 0, IsCongruentForMorphisms( lambda_elim_zeta_op, Opposite( colambda_elim_zeta ) ) );
            
        fi;
        
        if CanCompute( cat, "IsomorphismFromObjectToInternalCoHom" ) then
            
            if verbose then
                
                # COVERAGE_IGNORE_NEXT_LINE
                Display( "Testing 'IsomorphismFromObjectToInternalCoHom' ..." );
                
            fi;
            
            isomorphism_from_a_to_cohom := IsomorphismFromObjectToInternalCoHom( a );
            isomorphism_from_b_to_cohom := IsomorphismFromObjectToInternalCoHom( b );
            
            isomorphism_from_hom_to_a_op := IsomorphismFromInternalHomToObject( a_op );
            isomorphism_from_hom_to_b_op := IsomorphismFromInternalHomToObject( b_op );
            
            Assert( 0, IsCongruentForMorphisms( isomorphism_from_hom_to_a_op, Opposite( isomorphism_from_a_to_cohom ) ) );
            Assert( 0, IsCongruentForMorphisms( isomorphism_from_hom_to_b_op, Opposite( isomorphism_from_b_to_cohom ) ) );
            
        fi;
        
        if CanCompute( cat, "IsomorphismFromInternalCoHomToObject" ) then
            
            if verbose then
                
                # COVERAGE_IGNORE_NEXT_LINE
                Display( "Testing 'IsomorphismFromInternalCoHomToObject' ..." );
                
            fi;
            
            isomorphism_from_cohom_to_a := IsomorphismFromInternalCoHomToObject( a );
            isomorphism_from_cohom_to_b := IsomorphismFromInternalCoHomToObject( b );
            
            isomorphism_from_a_to_hom_op := IsomorphismFromObjectToInternalHom( a_op );
            isomorphism_from_b_to_hom_op := IsomorphismFromObjectToInternalHom( b_op );
            
            Assert( 0, IsCongruentForMorphisms( isomorphism_from_a_to_hom_op, Opposite( isomorphism_from_cohom_to_a ) ) );
            Assert( 0, IsCongruentForMorphisms( isomorphism_from_b_to_hom_op, Opposite( isomorphism_from_cohom_to_b ) ) );
            
        fi;
        
        if CanCompute( cat, "InternalCoHomOnObjects" ) and
           CanCompute( cat, "CoclosedEvaluationMorphism" ) and
           CanCompute( cat, "InternalCoHomToTensorProductAdjunctionMap" )
        
        then
            
            if verbose then
                
                # COVERAGE_IGNORE_NEXT_LINE
                Display( "Consistency between 'CoclosedEvalutionMorphism' and 'AdjunctionMap' ..." );
                
            fi;
            
            cocl_ev_ab := CoclosedEvaluationMorphism( a, b );
            cocl_ev_ba := CoclosedEvaluationMorphism( b, a );
            
            id_cohom_ab := IdentityMorphism( InternalCoHomOnObjects( a, b ) );
            id_cohom_ba := IdentityMorphism( InternalCoHomOnObjects( b, a ) );
            
            # Adjoint( Cohom( a, b ) → Cohom( a, b ) )  ==  a → Cohom( a, b ) ⊗ b
            cohom_to_tensor_adjunction_on_id_cohom_ab := InternalCoHomToTensorProductAdjunctionMap( a, b, id_cohom_ab );
            
            # Adjoint( Cohom( b, a ) → Cohom( b, a ) )  ==  b → Cohom( b, a ) ⊗ a
            cohom_to_tensor_adjunction_on_id_cohom_ba := InternalCoHomToTensorProductAdjunctionMap( b, a, id_cohom_ba );
            
            Assert( 0, IsCongruentForMorphisms( cocl_ev_ab, cohom_to_tensor_adjunction_on_id_cohom_ab ) );
            Assert( 0, IsCongruentForMorphisms( cocl_ev_ba, cohom_to_tensor_adjunction_on_id_cohom_ba ) );
            
        fi;
        
        if CanCompute( cat, "TensorProductOnObjects" ) and
           CanCompute( cat, "CoclosedCoevaluationMorphism" ) and
           CanCompute( cat, "TensorProductToInternalCoHomAdjunctionMap" )
        
        then
            
            if verbose then
                
                # COVERAGE_IGNORE_NEXT_LINE
                Display( "Consistency between 'CoevalutionMorphism' and 'AdjunctionMap' ..." );
                
            fi;
            
            cocl_coev_ab := CoclosedCoevaluationMorphism( a, b );
            cocl_coev_ba := CoclosedCoevaluationMorphism( b, a );
            
            id_a_tensor_b := IdentityMorphism( TensorProductOnObjects( a, b ) );
            id_b_tensor_a := IdentityMorphism( TensorProductOnObjects( b, a ) );
            
            # Adjoint( a ⊗ b → a ⊗ b )  ==  Cohom( a ⊗ b, b ) → a
            tensor_to_cohom_adjunction_on_id_a_tensor_b := TensorProductToInternalCoHomAdjunctionMap( a, b, id_a_tensor_b );
            
            # Adjoint( b ⊗ a → b ⊗ a )  ==  Cohom( b ⊗ a, a ) → b
            tensor_to_cohom_adjunction_on_id_b_tensor_a := TensorProductToInternalCoHomAdjunctionMap( b, a, id_b_tensor_a );
            
            Assert( 0, IsCongruentForMorphisms( cocl_coev_ab, tensor_to_cohom_adjunction_on_id_a_tensor_b ) );
            Assert( 0, IsCongruentForMorphisms( cocl_coev_ba, tensor_to_cohom_adjunction_on_id_b_tensor_a ) );
            
        fi;

end );
