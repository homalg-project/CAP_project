# SPDX-License-Identifier: GPL-2.0-or-later
# Toposes: Elementary toposes
#
# Implementations
#
# THIS FILE WAS AUTOMATICALLY GENERATED



InstallGlobalFunction( "CartesianClosedCategoriesTest",
    
    function( cat, a, b, c, d, alpha, beta, gamma, delta, epsilon, zeta )
        
        local opposite, verbose,
              
              a_op, c_op,
              b_op, d_op,
              
              id_a_tensor_b, id_b_tensor_a,
              
              exp_ab, coexp_ab_op, id_exp_ab,
              exp_ba, coexp_ba_op, id_exp_ba,
              
              alpha_op, exp_alpha_beta, coexp_alpha_beta_op,
              beta_op,  exp_beta_alpha, coexp_beta_alpha_op,
              
              ev_ab, coev_ab, coca_ev_ab_op, coca_coev_ab_op,
              ev_ba, coev_ba, coca_ev_ba_op, coca_coev_ba_op,
              
              alpha_tensor_beta, alpha_tensor_beta_op,
              beta_tensor_alpha, beta_tensor_alpha_op,
              
              exp_to_tensor_adjunction_on_id_exp_ab, tensor_to_exp_adjunction_on_id_a_tensor_b,
              exp_to_tensor_adjunction_on_id_exp_ba, tensor_to_exp_adjunction_on_id_b_tensor_a,

              tensor_to_exp_adjunction_on_alpha_tensor_beta, tensor_to_coexp_adjunction_on_alpha_tensor_beta_op,
              tensor_to_exp_adjunction_on_beta_tensor_alpha, tensor_to_coexp_adjunction_on_beta_tensor_alpha_op,
              
              exp_to_tensor_adjunction_on_exp_alpha_beta, coexp_to_tensor_adjunction_on_coexp_alpha_beta_op,
              exp_to_tensor_adjunction_on_exp_beta_alpha, coexp_to_tensor_adjunction_on_coexp_beta_alpha_op,
              
              precompose_abc, precocompose_abc_op, postcompose_abc, postcocompose_abc_op, 
              precompose_cba, precocompose_cba_op, postcompose_cba, postcocompose_cba_op,
              
              a_dual, a_codual_op, dual_alpha, codual_alpha_op,
              b_dual, b_codual_op, dual_beta, codual_beta_op,
              
              ev_for_dual_a, coca_ev_for_codual_a_op,
              ev_for_dual_b, coca_ev_for_codual_b_op,
                  
              morphism_to_bidual_a, morphism_from_cobidual_a_op,
              morphism_to_bidual_b, morphism_from_cobidual_b_op,
              
              tensor_to_exp_compatibility_abcd, coexp_to_tensor_compatibility_abcd_op,
              tensor_to_exp_compatibility_cadb, coexp_to_tensor_compatibility_bdac_op,
              
              direct_product_duality_compatibility_ab, coduality_direct_product_compatibility_ab_op,
              direct_product_duality_compatibility_ba, coduality_direct_product_compatibility_ba_op,
              
              morphism_from_direct_product_to_exp_ab, morphism_from_coexp_to_direct_product_ab_op,
              morphism_from_direct_product_to_exp_ba, morphism_from_coexp_to_direct_product_ba_op,
              
              isomorphism_from_dual_to_exp_a, isomorphism_from_exp_to_dual_a,
              isomorphism_from_dual_to_exp_b, isomorphism_from_exp_to_dual_b,
              
              isomorphism_from_codual_to_coexp_a_op, isomorphism_from_coexp_to_codual_a_op,
              isomorphism_from_codual_to_coexp_b_op, isomorphism_from_coexp_to_codual_b_op,
              
              gamma_op, universal_property_of_dual_gamma, universal_property_of_codual_gamma_op,
              delta_op, universal_property_of_dual_delta, universal_property_of_codual_delta_op,
              
              lambda_intro_alpha, colambda_intro_alpha_op,
              lambda_intro_beta,  colambda_intro_beta_op,
              
              epsilon_op, lambda_elim_epsilon, colambda_elim_epsilon_op,
              zeta_op,    lambda_elim_zeta,    colambda_elim_zeta_op,
              
              isomorphism_from_a_to_hom, isomorphism_from_exp_to_a, isomorphism_from_a_to_coexp_op, isomorphism_from_coexp_to_a_op,
              isomorphism_from_b_to_hom, isomorphism_from_exp_to_b, isomorphism_from_b_to_coexp_op, isomorphism_from_coexp_to_b_op;
        
        opposite := Opposite( cat );
        
        a_op := Opposite( a );
        b_op := Opposite( b );
        c_op := Opposite( c );
        d_op := Opposite( d );
        
        alpha_op := Opposite( alpha );
        beta_op := Opposite( beta );
        
        verbose := ValueOption( "verbose" ) = true;
        
        if CanCompute( cat, "ExponentialOnObjects" ) then
            
            if verbose then
                
                # COVERAGE_IGNORE_NEXT_LINE
                Display( "Testing 'ExponentialOnObjects' ..." );
                
            fi;
            
            exp_ab := ExponentialOnObjects( a, b );
            exp_ba := ExponentialOnObjects( b, a );
            
            coexp_ab_op := CoexponentialOnObjects( a_op, b_op );
            coexp_ba_op := CoexponentialOnObjects( b_op, a_op );
            
            Assert( 0, IsEqualForObjects( coexp_ab_op, Opposite( exp_ba ) ) );
            Assert( 0, IsEqualForObjects( coexp_ba_op, Opposite( exp_ab ) ) );
            
            # Opposite must be self-inverse
            
            Assert( 0, IsEqualForObjects( exp_ab, Opposite( coexp_ba_op ) ) );
            Assert( 0, IsEqualForObjects( exp_ba, Opposite( coexp_ab_op ) ) );
            
            # Convenience methods in the opposite category
            
            Assert( 0, IsEqualForObjects( coexp_ab_op, Coexponential( a_op, b_op ) ) );
            Assert( 0, IsEqualForObjects( coexp_ba_op, Coexponential( b_op, a_op ) ) );
            
        fi;
        
        if CanCompute( cat, "ExponentialOnMorphisms" ) then
            
            if verbose then
                
                # COVERAGE_IGNORE_NEXT_LINE
                Display( "Testing 'ExponentialOnMorphisms' ..." );
                
            fi;
            
            exp_alpha_beta := ExponentialOnMorphisms( alpha, beta );
            exp_beta_alpha := ExponentialOnMorphisms( beta, alpha );
            
            coexp_alpha_beta_op := CoexponentialOnMorphisms( alpha_op, beta_op );
            coexp_beta_alpha_op := CoexponentialOnMorphisms( beta_op, alpha_op );
            
            Assert( 0, IsCongruentForMorphisms( coexp_alpha_beta_op, Opposite( exp_beta_alpha ) ) );
            Assert( 0, IsCongruentForMorphisms( coexp_beta_alpha_op, Opposite( exp_alpha_beta ) ) );
            
            # Opposite must be self-inverse
            
            Assert( 0, IsCongruentForMorphisms( exp_alpha_beta, Opposite( coexp_beta_alpha_op ) ) );
            Assert( 0, IsCongruentForMorphisms( exp_beta_alpha, Opposite( coexp_alpha_beta_op ) ) );
            
            # Convenience methods in the opposite category
            
            Assert( 0, IsCongruentForMorphisms( coexp_alpha_beta_op, Coexponential( alpha_op, beta_op ) ) );
            Assert( 0, IsCongruentForMorphisms( coexp_beta_alpha_op, Coexponential( beta_op, alpha_op ) ) );
            
        fi;
        
        if CanCompute( cat, "CartesianEvaluationMorphism" ) then
            
            if verbose then
                
                # COVERAGE_IGNORE_NEXT_LINE
                Display( "Testing 'CartesianEvaluationMorphism' ..." );
                
            fi;
            
            ev_ab := CartesianEvaluationMorphism( a, b );
            ev_ba := CartesianEvaluationMorphism( b, a );
            
            coca_ev_ab_op := CocartesianEvaluationMorphism( a_op, b_op );
            coca_ev_ba_op := CocartesianEvaluationMorphism( b_op, a_op );
            
            # Arguments must be reversed for evaluations
            Assert( 0, IsCongruentForMorphisms( coca_ev_ab_op, Opposite( ev_ba ) ) );
            Assert( 0, IsCongruentForMorphisms( coca_ev_ba_op, Opposite( ev_ab ) ) );
            
        fi;
        
        if CanCompute( cat, "CartesianCoevaluationMorphism" ) then
            
            if verbose then
                
                # COVERAGE_IGNORE_NEXT_LINE
                Display( "Testing 'CartesianCoevaluationMorphism' ..." );
                
            fi;
            
            coev_ab := CartesianCoevaluationMorphism( a, b );
            coev_ba := CartesianCoevaluationMorphism( b, a );
            
            coca_coev_ab_op := CocartesianCoevaluationMorphism( a_op, b_op );
            coca_coev_ba_op := CocartesianCoevaluationMorphism( b_op, a_op );
            
            Assert( 0, IsCongruentForMorphisms( coca_coev_ab_op, Opposite( coev_ab ) ) );
            Assert( 0, IsCongruentForMorphisms( coca_coev_ba_op, Opposite( coev_ba ) ) );
            
        fi;
        
        if CanCompute( cat, "DirectProductToExponentialAdjunctionMap" ) then
            
            if verbose then
                
                # COVERAGE_IGNORE_NEXT_LINE
                Display( "Testing 'DirectProductToExponentialAdjunctionMap' ..." );
                
            fi;
            
            ######################################
            # 
            # alpha: a -> b
            # beta:  c -> d
            # 
            # alpha_tensor_beta: a x c -> b x d
            # beta_tensor_alpha: c x a -> d x b
            #
            ######################################
            #
            # alpha_op: b -> a
            # beta_op:  d -> c
            #
            # alpha_tensor_beta_op: b x d -> a x c
            # beta_tensor_alpha_op: d x b -> c x a
            #
            ######################################
            
            alpha_tensor_beta := DirectProductOnMorphisms( alpha, beta );
            beta_tensor_alpha := DirectProductOnMorphisms( beta, alpha );
            alpha_tensor_beta_op := CoproductOnMorphisms( opposite, alpha_op, beta_op );
            beta_tensor_alpha_op := CoproductOnMorphisms( opposite, beta_op, alpha_op );
            
            # Adjoint( a x c -> b x d )  ==  a -> Exp( c, b x d )
            tensor_to_exp_adjunction_on_alpha_tensor_beta := DirectProductToExponentialAdjunctionMap( a, c, alpha_tensor_beta );
            
            # Adjoint( c x a -> d x b )  ==  c -> Exp( a, d x b )
            tensor_to_exp_adjunction_on_beta_tensor_alpha := DirectProductToExponentialAdjunctionMap( c, a, beta_tensor_alpha );
            
            # Adjoint( b x d -> a x c )  ==  Coexp( b x d, c ) -> a
            tensor_to_coexp_adjunction_on_alpha_tensor_beta_op := CoproductToCoexponentialAdjunctionMap( a_op, c_op, alpha_tensor_beta_op );
            
            # Adjoint( d x b -> c x a )  ==  Coexp( d x b, a ) -> c
            tensor_to_coexp_adjunction_on_beta_tensor_alpha_op := CoproductToCoexponentialAdjunctionMap( c_op, a_op, beta_tensor_alpha_op );
            
            # Coexp( b x d, c ) -> a  ==  op( a -> Exp( c, b x d ) )
            Assert( 0, IsCongruentForMorphisms( tensor_to_coexp_adjunction_on_alpha_tensor_beta_op, Opposite( tensor_to_exp_adjunction_on_alpha_tensor_beta ) ) );
            
            # Coexp( d x b, a ) -> c  ==  op( c -> Exp( a, d x b ) )
            Assert( 0, IsCongruentForMorphisms( tensor_to_coexp_adjunction_on_beta_tensor_alpha_op, Opposite( tensor_to_exp_adjunction_on_beta_tensor_alpha ) ) );
            
        fi;
        
        if CanCompute( cat, "ExponentialToDirectProductAdjunctionMap" ) then
            
            if verbose then
                
                # COVERAGE_IGNORE_NEXT_LINE
                Display( "Testing 'ExponentialToDirectProductAdjunctionMap' ..." );
                
            fi;
            
            #####################################################
            #
            # exp_alpha_beta: Exp( b, c ) -> Exp( a, d )
            # exp_beta_alpha: Exp( d, a ) -> Exp( c, b )
            #
            # exp_alpha_beta_op: Exp( a, d ) -> Exp( b, c )
            # exp_beta_alpha_op: Exp( c, b ) -> Exp( d, a )
            #
            #####################################################
            #
            # coexp_alpha_beta: Coexp( a, d ) -> Coexp( b, c )
            # coexp_beta_alpha: Coexp( c, b ) -> Coexp( d, a )
            #
            # coexp_alpha_beta_op: Coexp( b, c ) -> Coexp( a, d )
            # coexp_beta_alpha_op: Coexp( d, a ) -> Coexp( c, b )
            #
            #####################################################
            
            # Adjoint( Exp( b, c ) -> Exp( a, d ) )  ==  Exp( b, c ) x a -> d
            exp_to_tensor_adjunction_on_exp_alpha_beta := ExponentialToDirectProductAdjunctionMap( a, d, exp_alpha_beta );
            
            # Adjoint( Exp( d, a ) -> Exp( c, b ) )  ==  Exp( d, a ) x c -> b
            exp_to_tensor_adjunction_on_exp_beta_alpha := ExponentialToDirectProductAdjunctionMap( c, b, exp_beta_alpha );
            
            # Adjoint( Coexp( b, c ) -> Coexp( a, d ) )  ==  b -> Coexp( a, d ) x c
            coexp_to_tensor_adjunction_on_coexp_alpha_beta_op := CoexponentialToCoproductAdjunctionMap( b_op, c_op, coexp_alpha_beta_op );
            
            # Adjoint( Coexp( d, a ) -> Coexp( c, b ) )  ==  d -> Coexp( c, b ) x a
            coexp_to_tensor_adjunction_on_coexp_beta_alpha_op := CoexponentialToCoproductAdjunctionMap( d_op, a_op, coexp_beta_alpha_op );
            
            # b -> Coexp( a, d ) x c  ==  op( Exp( d, a ) x c -> b )
            Assert( 0, IsCongruentForMorphisms( coexp_to_tensor_adjunction_on_coexp_alpha_beta_op, Opposite( exp_to_tensor_adjunction_on_exp_beta_alpha ) ) );
            
            # d -> Coexp( c, b ) x a  ==  op( Exp( b, c ) x a -> d )
            Assert( 0, IsCongruentForMorphisms( coexp_to_tensor_adjunction_on_coexp_beta_alpha_op, Opposite( exp_to_tensor_adjunction_on_exp_alpha_beta ) ) );
            
        fi;
        
        if CanCompute( cat, "CartesianPreComposeMorphism" ) then
            
            if verbose then
                
                # COVERAGE_IGNORE_NEXT_LINE
                Display( "Testing 'CartesianPreComposeMorphism' ..." );
                
            fi;
            
            precompose_abc := CartesianPreComposeMorphism( a, b, c );
            precompose_cba := CartesianPreComposeMorphism( c, b, a );

            precocompose_abc_op := CocartesianPreCoComposeMorphism( a_op, b_op, c_op );
            precocompose_cba_op := CocartesianPreCoComposeMorphism( c_op, b_op, a_op );
            
            Assert( 0, IsCongruentForMorphisms( precocompose_abc_op, Opposite( precompose_cba ) ) );
            Assert( 0, IsCongruentForMorphisms( precocompose_cba_op, Opposite( precompose_abc ) ) );

        fi;
            
        if CanCompute( cat, "CartesianPostComposeMorphism" ) then
            
            if verbose then
                
                # COVERAGE_IGNORE_NEXT_LINE
                Display( "Testing 'CartesianPostComposeMorphism' ..." );
                
            fi;
            
            postcompose_abc := CartesianPostComposeMorphism( a, b, c );
            postcompose_cba := CartesianPostComposeMorphism( c, b, a );
            
            postcocompose_abc_op := CocartesianPostCoComposeMorphism( a_op, b_op, c_op );
            postcocompose_cba_op := CocartesianPostCoComposeMorphism( c_op, b_op, a_op );
            
            Assert( 0, IsCongruentForMorphisms( postcocompose_abc_op, Opposite( postcompose_cba ) ) );
            Assert( 0, IsCongruentForMorphisms( postcocompose_cba_op, Opposite( postcompose_abc ) ) );
            
        fi;
        
        if CanCompute( cat, "CartesianDualOnObjects" ) then
            
            if verbose then
                
                # COVERAGE_IGNORE_NEXT_LINE
                Display( "Testing 'CartesianDualOnObjects' ..." );
                
            fi;
            
            a_dual := CartesianDualOnObjects( a );
            b_dual := CartesianDualOnObjects( b );
            
            a_codual_op := CocartesianDualOnObjects( a_op );
            b_codual_op := CocartesianDualOnObjects( b_op );
            
            Assert( 0, IsEqualForObjects( a_codual_op, Opposite( a_dual ) ) );
            Assert( 0, IsEqualForObjects( b_codual_op, Opposite( b_dual ) ) );
            
        fi;
        
        if CanCompute( cat, "CartesianDualOnMorphisms" ) then
            
            if verbose then
                
                # COVERAGE_IGNORE_NEXT_LINE
                Display( "Testing 'CartesianDualOnMorphisms' ..." );
                
            fi;
            
            dual_alpha := CartesianDualOnMorphisms( alpha );
            dual_beta := CartesianDualOnMorphisms( beta );
            
            codual_alpha_op := CocartesianDualOnMorphisms( alpha_op );
            codual_beta_op := CocartesianDualOnMorphisms( beta_op );
            
            Assert( 0, IsCongruentForMorphisms( codual_alpha_op, Opposite( dual_alpha ) ) );
            Assert( 0, IsCongruentForMorphisms( codual_beta_op, Opposite( dual_beta ) ) );
            
        fi;
        
        if CanCompute( cat, "CartesianEvaluationForCartesianDual" ) then
            
            if verbose then
                
                # COVERAGE_IGNORE_NEXT_LINE
                Display( "Testing 'CartesianEvaluationForCartesianDual' ..." );
                
            fi;
            
            ev_for_dual_a := CartesianEvaluationForCartesianDual( a );
            ev_for_dual_b := CartesianEvaluationForCartesianDual( b );
            
            coca_ev_for_codual_a_op := CocartesianEvaluationForCocartesianDual( a_op );
            coca_ev_for_codual_b_op := CocartesianEvaluationForCocartesianDual( b_op );
            
            Assert( 0, IsCongruentForMorphisms( coca_ev_for_codual_a_op, Opposite( ev_for_dual_a ) ) );
            Assert( 0, IsCongruentForMorphisms( coca_ev_for_codual_b_op, Opposite( ev_for_dual_b ) ) );
            
        fi;
        
        if CanCompute( cat, "MorphismToCartesianBidual" ) then
            
            if verbose then
                
                # COVERAGE_IGNORE_NEXT_LINE
                Display( "Testing 'MorphismToCartesianBidual' ..." );
                
            fi;
            
            morphism_to_bidual_a := MorphismToCartesianBidual( a );
            morphism_to_bidual_b := MorphismToCartesianBidual( b );
            
            morphism_from_cobidual_a_op := MorphismFromCocartesianBidual( a_op );
            morphism_from_cobidual_b_op := MorphismFromCocartesianBidual( b_op );
            
            Assert( 0, IsCongruentForMorphisms( morphism_from_cobidual_a_op, Opposite( morphism_to_bidual_a ) ) );
            Assert( 0, IsCongruentForMorphisms( morphism_from_cobidual_b_op, Opposite( morphism_to_bidual_b ) ) );
            
        fi;
        
        if CanCompute( cat, "DirectProductExponentialCompatibilityMorphism" ) then
            
            if verbose then
                
                # COVERAGE_IGNORE_NEXT_LINE
                Display( "Testing 'DirectProductExponentialCompatibilityMorphism' ..." );
                
            fi;
            
            # Exp( a, b ) x Exp( c, d ) -> Exp( a x c, b x d )
            tensor_to_exp_compatibility_abcd := DirectProductExponentialCompatibilityMorphism( [ a, b, c, d ] );
            
            # Exp( c, a ) x Exp( d, b ) -> Exp( c x d, a x b )
            tensor_to_exp_compatibility_cadb := DirectProductExponentialCompatibilityMorphism( [ c, a, d, b ] );
            
            # Coexp( a x b, c x d ) -> Coexp( a, c ) x Coexp( b, d )
            coexp_to_tensor_compatibility_abcd_op := CoexponentialCoproductCompatibilityMorphism( [ a_op, b_op, c_op, d_op ] );
            
            # Coexp( b x d, a x c ) -> Coexp( b, a ) x Coexp( d, c )
            coexp_to_tensor_compatibility_bdac_op := CoexponentialCoproductCompatibilityMorphism( [ b_op, d_op, a_op, c_op ] );
            
            # Coexp( a x b, c x d ) -> Coexp( a, c ) x Coexp( b, d )  ==  op( Exp( c, a ) x Exp( d, b ) -> Exp( c x d, a x b ) )
            Assert( 0, IsCongruentForMorphisms( coexp_to_tensor_compatibility_abcd_op, Opposite( tensor_to_exp_compatibility_cadb ) ) );
            
            # Coexp( b x d, a x c ) -> Coexp( b, a ) x Coexp( d, c )  ==  op( Exp( a, b ) x Exp( c, d ) -> Exp( a x c, b x d ) )
            Assert( 0, IsCongruentForMorphisms( coexp_to_tensor_compatibility_bdac_op, Opposite( tensor_to_exp_compatibility_abcd ) ) );
            
        fi;
        
        if CanCompute( cat, "DirectProductCartesianDualityCompatibilityMorphism" ) then
            
            if verbose then
                
                # COVERAGE_IGNORE_NEXT_LINE
                Display( "Testing 'DirectProductCartesianDualityCompatibilityMorphism' ..." );
                
            fi;
            
            # a^v x b^v -> (a x b)^v
            direct_product_duality_compatibility_ab := DirectProductCartesianDualityCompatibilityMorphism( a, b );
            
            # b^v x a^v -> (b x a)^v
            direct_product_duality_compatibility_ba := DirectProductCartesianDualityCompatibilityMorphism( b, a );
            
            # (a x b)_v -> a_v x b_v
            coduality_direct_product_compatibility_ab_op := CocartesianDualityCoproductCompatibilityMorphism( a_op, b_op );
            
            # (b x a)_v -> b_v x a_v
            coduality_direct_product_compatibility_ba_op := CocartesianDualityCoproductCompatibilityMorphism( b_op, a_op );
            
            # (a x b)_v -> a_v x b_v  ==  op( a^v x b^v -> (a x b)^v )
            Assert( 0, IsCongruentForMorphisms( coduality_direct_product_compatibility_ab_op, Opposite( direct_product_duality_compatibility_ab ) ) );
            
            # (b x a)_v -> b_v x a_v  ==  op( b^v x a^v -> (b x a)^v )
            Assert( 0, IsCongruentForMorphisms( coduality_direct_product_compatibility_ba_op, Opposite( direct_product_duality_compatibility_ba ) ) );
            
        fi;
        
        if CanCompute( cat, "MorphismFromDirectProductToExponential" ) then
            
            if verbose then
                
                # COVERAGE_IGNORE_NEXT_LINE
                Display( "Testing 'MorphismFromDirectProductToExponential' ..." );
                
            fi;
            
            morphism_from_direct_product_to_exp_ab := MorphismFromDirectProductToExponential( a, b );
            morphism_from_direct_product_to_exp_ba := MorphismFromDirectProductToExponential( b, a );

            morphism_from_coexp_to_direct_product_ab_op := MorphismFromCoexponentialToCoproduct( a_op, b_op );
            morphism_from_coexp_to_direct_product_ba_op := MorphismFromCoexponentialToCoproduct( b_op, a_op );
            
            Assert( 0, IsCongruentForMorphisms( morphism_from_coexp_to_direct_product_ab_op, Opposite( morphism_from_direct_product_to_exp_ba ) ) );
            Assert( 0, IsCongruentForMorphisms( morphism_from_coexp_to_direct_product_ba_op, Opposite( morphism_from_direct_product_to_exp_ab ) ) );
            
        fi;
        
        if CanCompute( cat, "IsomorphismFromCartesianDualToExponential" ) then
            
            if verbose then
                
                # COVERAGE_IGNORE_NEXT_LINE
                Display( "Testing 'IsomorphismFromCartesianDualToExponential' ..." );
                
            fi;
            
            isomorphism_from_dual_to_exp_a := IsomorphismFromCartesianDualToExponential( a );
            isomorphism_from_dual_to_exp_b := IsomorphismFromCartesianDualToExponential( b );
            
            isomorphism_from_coexp_to_codual_a_op := IsomorphismFromCoexponentialToCocartesianDual( a_op );
            isomorphism_from_coexp_to_codual_b_op := IsomorphismFromCoexponentialToCocartesianDual( b_op );
            
            Assert( 0, IsCongruentForMorphisms( isomorphism_from_coexp_to_codual_a_op, Opposite( isomorphism_from_dual_to_exp_a ) ) );
            Assert( 0, IsCongruentForMorphisms( isomorphism_from_coexp_to_codual_b_op, Opposite( isomorphism_from_dual_to_exp_b ) ) );
            
        fi;
        
        if CanCompute( cat, "IsomorphismFromExponentialToCartesianDual" ) then
            
            if verbose then
                
                # COVERAGE_IGNORE_NEXT_LINE
                Display( "Testing 'IsomorphismFromExponentialToCartesianDual' ..." );
                
            fi;
            
            isomorphism_from_exp_to_dual_a := IsomorphismFromExponentialToCartesianDual( a );
            isomorphism_from_exp_to_dual_b := IsomorphismFromExponentialToCartesianDual( b );
            
            isomorphism_from_codual_to_coexp_a_op := IsomorphismFromCocartesianDualToCoexponential( a_op );
            isomorphism_from_codual_to_coexp_b_op := IsomorphismFromCocartesianDualToCoexponential( b_op );
            
            Assert( 0, IsCongruentForMorphisms( isomorphism_from_codual_to_coexp_a_op, Opposite( isomorphism_from_exp_to_dual_a ) ) );
            Assert( 0, IsCongruentForMorphisms( isomorphism_from_codual_to_coexp_b_op, Opposite( isomorphism_from_exp_to_dual_b ) ) );
            
        fi;
        
        if CanCompute( cat, "UniversalPropertyOfCartesianDual" ) then
            
            if verbose then
                
                # COVERAGE_IGNORE_NEXT_LINE
                Display( "Testing 'UniversalPropertyOfCartesianDual' ..." );
                
            fi;
            
            gamma_op := Opposite( gamma );
            delta_op := Opposite( delta );
            
            universal_property_of_dual_gamma := UniversalPropertyOfCartesianDual( a, b, gamma );
            universal_property_of_dual_delta := UniversalPropertyOfCartesianDual( c, d, delta );

            universal_property_of_codual_gamma_op := UniversalPropertyOfCocartesianDual( a_op, b_op, gamma_op );
            universal_property_of_codual_delta_op := UniversalPropertyOfCocartesianDual( c_op, d_op, delta_op );
            
            Assert( 0, IsCongruentForMorphisms( universal_property_of_codual_gamma_op, Opposite( universal_property_of_dual_gamma ) ) );
            Assert( 0, IsCongruentForMorphisms( universal_property_of_codual_delta_op, Opposite( universal_property_of_dual_delta ) ) );
            
        fi;
        
        if CanCompute( cat, "CartesianLambdaIntroduction" ) then
            
            if verbose then
                
                # COVERAGE_IGNORE_NEXT_LINE
                Display( "Testing 'CartesianLambdaIntroduction' ..." );
                
            fi;
            
            lambda_intro_alpha := CartesianLambdaIntroduction( alpha );
            lambda_intro_beta := CartesianLambdaIntroduction( beta );
            
            colambda_intro_alpha_op := CocartesianLambdaIntroduction( alpha_op );
            colambda_intro_beta_op := CocartesianLambdaIntroduction( beta_op );
            
            Assert( 0, IsCongruentForMorphisms( colambda_intro_alpha_op, Opposite( lambda_intro_alpha ) ) );
            Assert( 0, IsCongruentForMorphisms( colambda_intro_beta_op, Opposite( lambda_intro_beta ) ) );
            
        fi;
        
        if CanCompute( cat, "CartesianLambdaElimination" ) then
            
            if verbose then
                
                # COVERAGE_IGNORE_NEXT_LINE
                Display( "Testing 'CartesianLambdaElimination' ..." );
                
            fi;
            
            epsilon_op := Opposite( epsilon );
            zeta_op := Opposite( zeta );
            
            lambda_elim_epsilon := CartesianLambdaElimination( a, b, epsilon );
            lambda_elim_zeta := CartesianLambdaElimination( c, d, zeta );

            colambda_elim_epsilon_op := CocartesianLambdaElimination( b_op, a_op, epsilon_op );
            colambda_elim_zeta_op := CocartesianLambdaElimination( d_op, c_op, zeta_op );
            
            Assert( 0, IsCongruentForMorphisms( colambda_elim_epsilon_op, Opposite( lambda_elim_epsilon ) ) );
            Assert( 0, IsCongruentForMorphisms( colambda_elim_zeta_op, Opposite( lambda_elim_zeta ) ) );
            
        fi;
        
        if CanCompute( cat, "IsomorphismFromObjectToExponential" ) then
            
            if verbose then
                
                # COVERAGE_IGNORE_NEXT_LINE
                Display( "Testing 'IsomorphismFromObjectToExponential' ..." );
                
            fi;
            
            isomorphism_from_a_to_hom := IsomorphismFromObjectToExponential( a );
            isomorphism_from_b_to_hom := IsomorphismFromObjectToExponential( b );
            
            isomorphism_from_coexp_to_a_op := IsomorphismFromCoexponentialToObject( a_op );
            isomorphism_from_coexp_to_b_op := IsomorphismFromCoexponentialToObject( b_op );
            
            Assert( 0, IsCongruentForMorphisms( isomorphism_from_coexp_to_a_op, Opposite( isomorphism_from_a_to_hom ) ) );
            Assert( 0, IsCongruentForMorphisms( isomorphism_from_coexp_to_b_op, Opposite( isomorphism_from_b_to_hom ) ) );
            
        fi;
        
        if CanCompute( cat, "IsomorphismFromExponentialToObject" ) then
            
            if verbose then
                
                # COVERAGE_IGNORE_NEXT_LINE
                Display( "Testing 'IsomorphismFromExponentialToObject' ..." );
                
            fi;
            
            isomorphism_from_exp_to_a := IsomorphismFromExponentialToObject( a );
            isomorphism_from_exp_to_b := IsomorphismFromExponentialToObject( b );
            
            isomorphism_from_a_to_coexp_op := IsomorphismFromObjectToCoexponential( a_op );
            isomorphism_from_b_to_coexp_op := IsomorphismFromObjectToCoexponential( b_op );
            
            Assert( 0, IsCongruentForMorphisms( isomorphism_from_a_to_coexp_op, Opposite( isomorphism_from_exp_to_a ) ) );
            Assert( 0, IsCongruentForMorphisms( isomorphism_from_b_to_coexp_op, Opposite( isomorphism_from_exp_to_b ) ) );
            
        fi;
        
        if CanCompute( cat, "ExponentialOnObjects" ) and
           CanCompute( cat, "CartesianEvaluationMorphism" ) and
           CanCompute( cat, "ExponentialToDirectProductAdjunctionMap" )
        
        then
            
            if verbose then
                
                # COVERAGE_IGNORE_NEXT_LINE
                Display( "Consistency between 'EvalutionMorphism' and 'AdjunctionMap' ..." );
                
            fi;
            
            ev_ab := CartesianEvaluationMorphism( a, b );
            ev_ba := CartesianEvaluationMorphism( b, a );
            
            id_exp_ab := IdentityMorphism( ExponentialOnObjects( a, b ) );
            id_exp_ba := IdentityMorphism( ExponentialOnObjects( b, a ) );
            
            # Adjoint( Exp( a. b ) -> Exp( a, b ) )  ==  Exp( a, b ) x a -> b
            exp_to_tensor_adjunction_on_id_exp_ab := ExponentialToDirectProductAdjunctionMap( a, b, id_exp_ab );
            
            # Adjoint( Exp( b, a ) -> Exp( b, a ) )  ==  Exp( b, a ) x b -> a
            exp_to_tensor_adjunction_on_id_exp_ba := ExponentialToDirectProductAdjunctionMap( b, a, id_exp_ba );
            
            Assert( 0, IsCongruentForMorphisms( ev_ab, exp_to_tensor_adjunction_on_id_exp_ab ) );
            Assert( 0, IsCongruentForMorphisms( ev_ba, exp_to_tensor_adjunction_on_id_exp_ba ) );
            
        fi;
        
        if CanCompute( cat, "DirectProduct" ) and
           CanCompute( cat, "CartesianCoevaluationMorphism" ) and
           CanCompute( cat, "DirectProductToExponentialAdjunctionMap" )
        
        then
            
            if verbose then
                
                # COVERAGE_IGNORE_NEXT_LINE
                Display( "Consistency between 'CoevalutionMorphism' and 'AdjunctionMap' ..." );
                
            fi;
            
            coev_ab := CartesianCoevaluationMorphism( a, b );
            coev_ba := CartesianCoevaluationMorphism( b, a );
            
            id_a_tensor_b := IdentityMorphism( DirectProduct( a, b ) );
            id_b_tensor_a := IdentityMorphism( DirectProduct( b, a ) );
            
            # Adjoint( a x b -> a x b )  ==  a -> Exp( b, a x b )
            tensor_to_exp_adjunction_on_id_a_tensor_b := DirectProductToExponentialAdjunctionMap( a, b, id_a_tensor_b );
            
            # Adjoint( b x a -> b x a )  ==  b -> Exp( a, b x a )
            tensor_to_exp_adjunction_on_id_b_tensor_a := DirectProductToExponentialAdjunctionMap( b, a, id_b_tensor_a );
            
            Assert( 0, IsCongruentForMorphisms( coev_ab, tensor_to_exp_adjunction_on_id_a_tensor_b ) );
            Assert( 0, IsCongruentForMorphisms( coev_ba, tensor_to_exp_adjunction_on_id_b_tensor_a ) );
            
        fi;

end );
