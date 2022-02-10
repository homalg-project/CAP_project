# THIS FILE WAS AUTOMATICALLY GENERATED

# SPDX-License-Identifier: GPL-2.0-or-later
# Toposes: Elementary toposes
#
# Implementations
#

InstallGlobalFunction( "CartesianCategoriesTest",
    
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
        
        if CanCompute( cat, "DirectProductOnMorphisms" ) then 
            
            if verbose then
                
                # COVERAGE_IGNORE_NEXT_LINE
                Display( "Testing 'DirectProductOnMorphisms' ..." );
                
            fi;
            
            alpha_tensor_beta := DirectProductOnMorphisms( alpha, beta );
            beta_tensor_alpha := DirectProductOnMorphisms( beta, alpha );
            
            alpha_tensor_beta_op := CoproductOnMorphisms( opposite, alpha_op, beta_op );
            beta_tensor_alpha_op := CoproductOnMorphisms( opposite, beta_op, alpha_op );
            
            Assert( 0, IsCongruentForMorphisms( alpha_tensor_beta_op, Opposite( alpha_tensor_beta ) ) );
            Assert( 0, IsCongruentForMorphisms( beta_tensor_alpha_op, Opposite( beta_tensor_alpha ) ) );
            
            # Opposite must be self-inverse
            
            Assert( 0, IsCongruentForMorphisms( alpha_tensor_beta, Opposite( alpha_tensor_beta_op ) ) );
            Assert( 0, IsCongruentForMorphisms( beta_tensor_alpha, Opposite( beta_tensor_alpha_op ) ) );
            
        fi;
        
        if CanCompute( cat, "CartesianLeftUnitor" ) then
            
            if verbose then
                
                # COVERAGE_IGNORE_NEXT_LINE
                Display( "Testing 'CartesianLeftUnitor' ..." );
                
            fi;
            
            left_unitor_a := CartesianLeftUnitor( a );
            left_unitor_b := CartesianLeftUnitor( b );
            
            left_unitor_inverse_a_op := CocartesianLeftUnitorInverse( opposite, a_op );
            left_unitor_inverse_b_op := CocartesianLeftUnitorInverse( opposite, b_op );
            
            Assert( 0, IsCongruentForMorphisms( left_unitor_inverse_a_op, Opposite( left_unitor_a ) ) );
            Assert( 0, IsCongruentForMorphisms( left_unitor_inverse_b_op, Opposite( left_unitor_b ) ) );
            
        fi;
        
        if CanCompute( cat, "CartesianRightUnitor" ) then
            
            if verbose then
                
                # COVERAGE_IGNORE_NEXT_LINE
                Display( "Testing 'CartesianRightUnitor' ..." );
                
            fi;
            
            right_unitor_a := CartesianRightUnitor( a );
            right_unitor_b := CartesianRightUnitor( b );
            
            right_unitor_inverse_a_op := CocartesianRightUnitorInverse( opposite, a_op );
            right_unitor_inverse_b_op := CocartesianRightUnitorInverse( opposite, b_op );
            
            Assert( 0, IsCongruentForMorphisms( right_unitor_inverse_a_op, Opposite( right_unitor_a ) ) );
            Assert( 0, IsCongruentForMorphisms( right_unitor_inverse_b_op, Opposite( right_unitor_b ) ) );
            
        fi;
        
        if CanCompute( cat, "CartesianLeftUnitorInverse" ) then
            
            if verbose then
                
                # COVERAGE_IGNORE_NEXT_LINE
                Display( "Testing 'CartesianLeftUnitorInverse' ..." );
                
            fi;
            
            left_unitor_inverse_a := CartesianLeftUnitorInverse( a );
            left_unitor_inverse_b := CartesianLeftUnitorInverse( b );
            
            left_unitor_a_op := CocartesianLeftUnitor( opposite, a_op );
            left_unitor_b_op := CocartesianLeftUnitor( opposite, b_op );
            
            Assert( 0, IsCongruentForMorphisms( left_unitor_a_op, Opposite( left_unitor_inverse_a ) ) );
            Assert( 0, IsCongruentForMorphisms( left_unitor_b_op, Opposite( left_unitor_inverse_b ) ) );
            
        fi;
        
        if CanCompute( cat, "CartesianRightUnitorInverse" ) then
            
            if verbose then
                
                # COVERAGE_IGNORE_NEXT_LINE
                Display( "Testing 'CartesianRightUnitorInverse' ..." );
                
            fi;
            
            right_unitor_inverse_a := CartesianRightUnitorInverse( a );
            right_unitor_inverse_b := CartesianRightUnitorInverse( b );
            
            right_unitor_a_op := CocartesianRightUnitor( opposite, a_op );
            right_unitor_b_op := CocartesianRightUnitor( opposite, b_op );
            
            Assert( 0, IsCongruentForMorphisms( right_unitor_a_op, Opposite( right_unitor_inverse_a ) ) );
            Assert( 0, IsCongruentForMorphisms( right_unitor_b_op, Opposite( right_unitor_inverse_b ) ) );
            
        fi;
        
        if CanCompute( cat, "CartesianAssociatorLeftToRight" ) then
            
            if verbose then
                
                # COVERAGE_IGNORE_NEXT_LINE
                Display( "Testing 'CartesianAssociatorLeftToRight' ..." );
                
            fi;
            
            associator_left_to_right_abc := CartesianAssociatorLeftToRight( a, b, c );
            associator_left_to_right_cba := CartesianAssociatorLeftToRight( c, b, a );
            
            associator_right_to_left_abc_op := CocartesianAssociatorRightToLeft( opposite, a_op, b_op, c_op );
            associator_right_to_left_cba_op := CocartesianAssociatorRightToLeft( opposite, c_op, b_op, a_op );
            
            Assert( 0, IsCongruentForMorphisms( associator_right_to_left_abc_op, Opposite( associator_left_to_right_abc ) ) );
            Assert( 0, IsCongruentForMorphisms( associator_right_to_left_cba_op, Opposite( associator_left_to_right_cba ) ) );
            
        fi;
        
        if CanCompute( cat, "CartesianAssociatorRightToLeft" ) then
            
            if verbose then
                
                # COVERAGE_IGNORE_NEXT_LINE
                Display( "Testing 'CartesianAssociatorRightToLeft' ..." );
                
            fi;
            
            associator_right_to_left_abc := CartesianAssociatorRightToLeft( a, b, c );
            associator_right_to_left_cba := CartesianAssociatorRightToLeft( c, b, a );
            
            associator_left_to_right_abc_op := CocartesianAssociatorLeftToRight( opposite, a_op, b_op, c_op );
            associator_left_to_right_cba_op := CocartesianAssociatorLeftToRight( opposite, c_op, b_op, a_op );
            
            Assert( 0, IsCongruentForMorphisms( associator_left_to_right_abc_op, Opposite( associator_right_to_left_abc ) ) );
            Assert( 0, IsCongruentForMorphisms( associator_left_to_right_cba_op, Opposite( associator_right_to_left_cba ) ) );
            
        fi;

end );
