# SPDX-License-Identifier: GPL-2.0-or-later
# MonoidalCategories: Monoidal and monoidal (co)closed categories
#
# Implementations
#

InstallGlobalFunction( "LeftCoclosedMonoidalCategoriesTestWithGiven",
    
    function( cat, opposite, a, b, c, d, alpha, beta )
    
        local verbose,
              
              a_op, c_op,
              b_op, d_op,
              
              alpha_op, cohom_alpha_beta, hom_alpha_beta_op,
              beta_op,  cohom_beta_alpha, hom_beta_alpha_op,
              
              cohom_bc, cohom_bc_x_d, hom_ad, hom_ad_x_b,
              cohom_da, cohom_da_x_b, hom_cb, hom_cb_x_d,
              
              cohom_to_tensor_adjunction_on_cohom_alpha_beta, hom_to_tensor_adjunction_on_hom_alpha_beta_op,
              cohom_to_tensor_adjunction_on_cohom_beta_alpha, hom_to_tensor_adjunction_on_hom_beta_alpha_op;
              
        a_op := Opposite( opposite, a );
        b_op := Opposite( opposite, b );
        c_op := Opposite( opposite, c );
        d_op := Opposite( opposite, d );
        
        alpha_op := Opposite( opposite, alpha );
        beta_op := Opposite( opposite, beta );
        
        verbose := ValueOption( "verbose" ) = true;
        
        if CanCompute( cat, "LeftInternalCoHomToTensorProductAdjunctMorphismWithGivenTensorProduct" ) then
            
            if verbose then
                
                # COVERAGE_IGNORE_NEXT_LINE
                Display( "Testing 'LeftInternalCoHomToTensorProductAdjunctMorphismWithGivenTensorProduct' ..." );
                
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
            
            cohom_bc := LeftInternalCoHomOnObjects( b, c );
            cohom_da := LeftInternalCoHomOnObjects( d, a );
            
            cohom_bc_x_d := TensorProductOnObjects( cohom_bc, d );
            cohom_da_x_b := TensorProductOnObjects( cohom_da, b );
            
            hom_ad := LeftInternalHomOnObjects( a_op, d_op );
            hom_cb := LeftInternalHomOnObjects( c_op, b_op );
            
            hom_ad_x_b := TensorProductOnObjects( hom_ad, b_op );
            hom_cb_x_d := TensorProductOnObjects( hom_cb, d_op );
            
            cohom_alpha_beta := LeftInternalCoHomOnMorphisms( alpha, beta );
            cohom_beta_alpha := LeftInternalCoHomOnMorphisms( beta, alpha );
            
            hom_alpha_beta_op := LeftInternalHomOnMorphisms( alpha_op, beta_op );
            hom_beta_alpha_op := LeftInternalHomOnMorphisms( beta_op, alpha_op );
            
            # Adjoint( Cohom( a, d ) → Cohom( b, c ) )  ==  a → Cohom( b, c ) ⊗ d
            cohom_to_tensor_adjunction_on_cohom_alpha_beta := LeftInternalCoHomToTensorProductAdjunctMorphismWithGivenTensorProduct( a, d, cohom_alpha_beta, cohom_bc_x_d );
            
            # Adjoint( Cohom( c, b ) → Cohom( d, a ) )  ==  c → Cohom( d, a ) ⊗ b
            cohom_to_tensor_adjunction_on_cohom_beta_alpha := LeftInternalCoHomToTensorProductAdjunctMorphismWithGivenTensorProduct( c, b, cohom_beta_alpha, cohom_da_x_b );
            
            # Adjoint( Hom( a, d ) → Hom( b, c ) )  ==  Hom( a, d ) ⊗ b → c
            hom_to_tensor_adjunction_on_hom_alpha_beta_op := LeftInternalHomToTensorProductAdjunctMorphismWithGivenTensorProduct( b_op, c_op, hom_alpha_beta_op, hom_ad_x_b );
            
            # Adjoint( Hom( c, b ) → Hom( d, a ) )  ==  Hom( c, b ) ⊗ d → a
            hom_to_tensor_adjunction_on_hom_beta_alpha_op := LeftInternalHomToTensorProductAdjunctMorphismWithGivenTensorProduct( d_op, a_op, hom_beta_alpha_op, hom_cb_x_d );
            
            # Hom( a, d ) ⊗ b → c  ==  op( c → coHom( d, a ) ⊗ b )
            Assert( 0, IsCongruentForMorphisms( hom_to_tensor_adjunction_on_hom_alpha_beta_op, Opposite( opposite, cohom_to_tensor_adjunction_on_cohom_beta_alpha ) ) );
            
            # Hom( c, b ) ⊗ d → a  ==  op( a → coHom( b, c ) ⊗ d )
            Assert( 0, IsCongruentForMorphisms( hom_to_tensor_adjunction_on_hom_beta_alpha_op, Opposite( opposite, cohom_to_tensor_adjunction_on_cohom_alpha_beta ) ) );
            
        fi;
        
end );
