# SPDX-License-Identifier: GPL-2.0-or-later
# MonoidalCategories: Monoidal and monoidal (co)closed categories
#
# Implementations
#

InstallGlobalFunction( "BraidedMonoidalCategoriesTest",
    
    function( cat, a, b )
        
        local opposite, verbose,
              
              a_op, braiding_a_b, braiding_a_b_op, braiding_inverse_a_b, braiding_inverse_a_b_op, 
              b_op, braiding_b_a, braiding_b_a_op, braiding_inverse_b_a, braiding_inverse_b_a_op;
        
        opposite := Opposite( cat );
        
        a_op := Opposite( a );
        b_op := Opposite( b );
        
        verbose := ValueOption( "verbose" ) = true;
        
        if CanCompute( cat, "Braiding" ) then
            
            if verbose then
                
                # COVERAGE_IGNORE_NEXT_LINE
                Display( "Testing 'Braiding' ..." );
                
            fi;
            
            braiding_a_b := Braiding( a, b );
            braiding_b_a := Braiding( b, a );
            
            braiding_inverse_a_b_op := BraidingInverse( opposite, a_op, b_op );
            braiding_inverse_b_a_op := BraidingInverse( opposite, b_op, a_op );
            
            Assert( 0, IsCongruentForMorphisms( braiding_inverse_a_b_op, Opposite( braiding_a_b ) ) );
            Assert( 0, IsCongruentForMorphisms( braiding_inverse_b_a_op, Opposite( braiding_b_a ) ) );
            
        fi;
        
        if CanCompute( cat, "BraidingInverse" ) then
            
            if verbose then
                
                # COVERAGE_IGNORE_NEXT_LINE
                Display( "Testing 'BraidingInverse' ..." );
                
            fi;
            
            braiding_inverse_a_b := BraidingInverse( a, b );
            braiding_inverse_b_a := BraidingInverse( b, a );
            
            braiding_a_b_op := Braiding( opposite, a_op, b_op );
            braiding_b_a_op := Braiding( opposite, b_op, a_op );
            
            Assert( 0, IsCongruentForMorphisms( braiding_a_b_op, Opposite( braiding_inverse_a_b ) ) );
            Assert( 0, IsCongruentForMorphisms( braiding_b_a_op, Opposite( braiding_inverse_b_a ) ) );
            
        fi;

end );
