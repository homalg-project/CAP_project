# SPDX-License-Identifier: GPL-2.0-or-later
# MonoidalCategories: Monoidal and monoidal (co)closed categories
#
# Implementations
#

InstallGlobalFunction( "MonoidalCategoriesTest",
    
    function( cat, a, b, c, alpha, beta )
    
        local opposite, verbose,
              
              a_op,
              b_op,
              c_op,
              
              alpha_op,
              beta_op,
              
              a_tensor_b,    alpha_tensor_beta,
              b_tensor_a,    beta_tensor_alpha,
              a_tensor_b_op, alpha_tensor_beta_op,
              b_tensor_a_op, beta_tensor_alpha_op,
              
              left_unitor_a,    left_unitor_inverse_a,    right_unitor_a,    right_unitor_inverse_a,
              left_unitor_b,    left_unitor_inverse_b,    right_unitor_b,    right_unitor_inverse_a_op,
              left_unitor_a_op, left_unitor_inverse_a_op, right_unitor_a_op, right_unitor_inverse_b,
              left_unitor_b_op, left_unitor_inverse_b_op, right_unitor_b_op, right_unitor_inverse_b_op,
              
              associator_left_to_right_abc, associator_left_to_right_abc_op, associator_right_to_left_abc, associator_right_to_left_abc_op,
              associator_left_to_right_cba, associator_left_to_right_cba_op, associator_right_to_left_cba, associator_right_to_left_cba_op;

        opposite := Opposite( cat );
        
        a_op := Opposite( a );
        b_op := Opposite( b );
        c_op := Opposite( c );
        
        alpha_op := Opposite( alpha );
        beta_op := Opposite( beta );
        
        verbose := ValueOption( "verbose" ) = true;
        
        if CanCompute( cat, "TensorProductOnMorphisms" ) then 
            
            if verbose then
                
                # COVERAGE_IGNORE_NEXT_LINE
                Display( "Testing 'TensorProductOnMorphisms' ..." );
                
            fi;
            
            alpha_tensor_beta := TensorProductOnMorphisms( alpha, beta );
            beta_tensor_alpha := TensorProductOnMorphisms( beta, alpha );
            
            alpha_tensor_beta_op := TensorProductOnMorphisms( opposite, alpha_op, beta_op );
            beta_tensor_alpha_op := TensorProductOnMorphisms( opposite, beta_op, alpha_op );
            
            Assert( 0, IsCongruentForMorphisms( alpha_tensor_beta_op, Opposite( alpha_tensor_beta ) ) );
            Assert( 0, IsCongruentForMorphisms( beta_tensor_alpha_op, Opposite( beta_tensor_alpha ) ) );
            
            # Opposite must be self-inverse
            
            Assert( 0, IsCongruentForMorphisms( alpha_tensor_beta, Opposite( alpha_tensor_beta_op ) ) );
            Assert( 0, IsCongruentForMorphisms( beta_tensor_alpha, Opposite( beta_tensor_alpha_op ) ) );
            
        fi;
        
        if CanCompute( cat, "LeftUnitor" ) then
            
            if verbose then
                
                # COVERAGE_IGNORE_NEXT_LINE
                Display( "Testing 'LeftUnitor' ..." );
                
            fi;
            
            left_unitor_a := LeftUnitor( a );
            left_unitor_b := LeftUnitor( b );
            
            left_unitor_inverse_a_op := LeftUnitorInverse( opposite, a_op );
            left_unitor_inverse_b_op := LeftUnitorInverse( opposite, b_op );
            
            Assert( 0, IsCongruentForMorphisms( left_unitor_inverse_a_op, Opposite( left_unitor_a ) ) );
            Assert( 0, IsCongruentForMorphisms( left_unitor_inverse_b_op, Opposite( left_unitor_b ) ) );
            
        fi;
        
        if CanCompute( cat, "RightUnitor" ) then
            
            if verbose then
                
                # COVERAGE_IGNORE_NEXT_LINE
                Display( "Testing 'RightUnitor' ..." );
                
            fi;
            
            right_unitor_a := RightUnitor( a );
            right_unitor_b := RightUnitor( b );
            
            right_unitor_inverse_a_op := RightUnitorInverse( opposite, a_op );
            right_unitor_inverse_b_op := RightUnitorInverse( opposite, b_op );
            
            Assert( 0, IsCongruentForMorphisms( right_unitor_inverse_a_op, Opposite( right_unitor_a ) ) );
            Assert( 0, IsCongruentForMorphisms( right_unitor_inverse_b_op, Opposite( right_unitor_b ) ) );
            
        fi;
        
        if CanCompute( cat, "LeftUnitorInverse" ) then
            
            if verbose then
                
                # COVERAGE_IGNORE_NEXT_LINE
                Display( "Testing 'LeftUnitorInverse' ..." );
                
            fi;
            
            left_unitor_inverse_a := LeftUnitorInverse( a );
            left_unitor_inverse_b := LeftUnitorInverse( b );
            
            left_unitor_a_op := LeftUnitor( opposite, a_op );
            left_unitor_b_op := LeftUnitor( opposite, b_op );
            
            Assert( 0, IsCongruentForMorphisms( left_unitor_a_op, Opposite( left_unitor_inverse_a ) ) );
            Assert( 0, IsCongruentForMorphisms( left_unitor_b_op, Opposite( left_unitor_inverse_b ) ) );
            
        fi;
        
        if CanCompute( cat, "RightUnitorInverse" ) then
            
            if verbose then
                
                # COVERAGE_IGNORE_NEXT_LINE
                Display( "Testing 'RightUnitorInverse' ..." );
                
            fi;
            
            right_unitor_inverse_a := RightUnitorInverse( a );
            right_unitor_inverse_b := RightUnitorInverse( b );
            
            right_unitor_a_op := RightUnitor( opposite, a_op );
            right_unitor_b_op := RightUnitor( opposite, b_op );
            
            Assert( 0, IsCongruentForMorphisms( right_unitor_a_op, Opposite( right_unitor_inverse_a ) ) );
            Assert( 0, IsCongruentForMorphisms( right_unitor_b_op, Opposite( right_unitor_inverse_b ) ) );
            
        fi;
        
        if CanCompute( cat, "AssociatorLeftToRight" ) then
            
            if verbose then
                
                # COVERAGE_IGNORE_NEXT_LINE
                Display( "Testing 'AssociatorLeftToRight' ..." );
                
            fi;
            
            associator_left_to_right_abc := AssociatorLeftToRight( a, b, c );
            associator_left_to_right_cba := AssociatorLeftToRight( c, b, a );
            
            associator_right_to_left_abc_op := AssociatorRightToLeft( opposite, a_op, b_op, c_op );
            associator_right_to_left_cba_op := AssociatorRightToLeft( opposite, c_op, b_op, a_op );
            
            Assert( 0, IsCongruentForMorphisms( associator_right_to_left_abc_op, Opposite( associator_left_to_right_abc ) ) );
            Assert( 0, IsCongruentForMorphisms( associator_right_to_left_cba_op, Opposite( associator_left_to_right_cba ) ) );
            
        fi;
        
        if CanCompute( cat, "AssociatorRightToLeft" ) then
            
            if verbose then
                
                # COVERAGE_IGNORE_NEXT_LINE
                Display( "Testing 'AssociatorRightToLeft' ..." );
                
            fi;
            
            associator_right_to_left_abc := AssociatorRightToLeft( a, b, c );
            associator_right_to_left_cba := AssociatorRightToLeft( c, b, a );
            
            associator_left_to_right_abc_op := AssociatorLeftToRight( opposite, a_op, b_op, c_op );
            associator_left_to_right_cba_op := AssociatorLeftToRight( opposite, c_op, b_op, a_op );
            
            Assert( 0, IsCongruentForMorphisms( associator_left_to_right_abc_op, Opposite( associator_right_to_left_abc ) ) );
            Assert( 0, IsCongruentForMorphisms( associator_left_to_right_cba_op, Opposite( associator_right_to_left_cba ) ) );
            
        fi;

end );
