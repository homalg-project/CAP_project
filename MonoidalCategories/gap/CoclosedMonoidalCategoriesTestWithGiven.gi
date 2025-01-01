# SPDX-License-Identifier: GPL-2.0-or-later
# MonoidalCategories: Monoidal and monoidal (co)closed categories
#
# Implementations
#

InstallGlobalFunction( "CoclosedMonoidalCategoriesTestWithGiven",
    
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
        
        if CanCompute( cat, "InternalCoHomToTensorProductLeftAdjunctMorphismWithGivenTensorProduct" ) then
            
            if verbose then
                
                # COVERAGE_IGNORE_NEXT_LINE
                Display( "Testing 'InternalCoHomToTensorProductLeftAdjunctMorphismWithGivenTensorProduct' ..." );
                
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
            
            cohom_bc := InternalCoHomOnObjects( b, c );
            cohom_da := InternalCoHomOnObjects( d, a );
            
            cohom_bc_x_d := TensorProductOnObjects( cohom_bc, d );
            cohom_da_x_b := TensorProductOnObjects( cohom_da, b );
            
            hom_ad := InternalHomOnObjects( a_op, d_op );
            hom_cb := InternalHomOnObjects( c_op, b_op );
            
            hom_ad_x_b := TensorProductOnObjects( hom_ad, b_op );
            hom_cb_x_d := TensorProductOnObjects( hom_cb, d_op );
            
            cohom_alpha_beta := InternalCoHomOnMorphisms( alpha, beta );
            cohom_beta_alpha := InternalCoHomOnMorphisms( beta, alpha );
            
            hom_alpha_beta_op := InternalHomOnMorphisms( alpha_op, beta_op );
            hom_beta_alpha_op := InternalHomOnMorphisms( beta_op, alpha_op );
            
            # Adjoint( coHom( a, d ) → coHom( b, c ) )  ==  a → coHom( b, c ) ⊗ d
            cohom_to_tensor_adjunction_on_cohom_alpha_beta := InternalCoHomToTensorProductLeftAdjunctMorphismWithGivenTensorProduct( a, d, cohom_alpha_beta, cohom_bc_x_d );
            
            # Adjoint( coHom( c, b ) → coHom( d, a ) )  ==  c → coHom( d, a ) ⊗ b
            cohom_to_tensor_adjunction_on_cohom_beta_alpha := InternalCoHomToTensorProductLeftAdjunctMorphismWithGivenTensorProduct( c, b, cohom_beta_alpha, cohom_da_x_b );
            
            # Adjoint( Hom( a, d ) → Hom( b, c ) )  ==  Hom( a, d ) ⊗ b → c
            hom_to_tensor_adjunction_on_hom_alpha_beta_op := InternalHomToTensorProductLeftAdjunctMorphismWithGivenTensorProduct( b_op, c_op, hom_alpha_beta_op, hom_ad_x_b );
            
            # Adjoint( Hom( c, b ) → Hom( d, a ) )  ==  Hom( c, b ) ⊗ d → a
            hom_to_tensor_adjunction_on_hom_beta_alpha_op := InternalHomToTensorProductLeftAdjunctMorphismWithGivenTensorProduct( d_op, a_op, hom_beta_alpha_op, hom_cb_x_d );
            
            # Hom( a, d ) ⊗ b → c  ==  op( c → coHom( d, a ) ⊗ b )
            Assert( 0, IsCongruentForMorphisms( hom_to_tensor_adjunction_on_hom_alpha_beta_op, Opposite( opposite, cohom_to_tensor_adjunction_on_cohom_beta_alpha ) ) );
            
            # Hom( c, b ) ⊗ d → a  ==  op( a → coHom( b, c ) ⊗ d )
            Assert( 0, IsCongruentForMorphisms( hom_to_tensor_adjunction_on_hom_beta_alpha_op, Opposite( opposite, cohom_to_tensor_adjunction_on_cohom_alpha_beta ) ) );
            
        fi;
        
end );
