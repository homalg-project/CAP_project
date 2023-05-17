# SPDX-License-Identifier: GPL-2.0-or-later
# CartesianCategories: Cartesian and cocartesian categories and various subdoctrines
#
# Implementations
#
# THIS FILE WAS AUTOMATICALLY GENERATED



InstallGlobalFunction( "BraidedCartesianCategoriesTest",
    
    function( cat, opposite, a, b )
        
        local verbose,
              
              a_op, braiding_a_b, braiding_a_b_op, braiding_inverse_a_b, braiding_inverse_a_b_op, 
              b_op, braiding_b_a, braiding_b_a_op, braiding_inverse_b_a, braiding_inverse_b_a_op;
        
        a_op := Opposite( opposite, a );
        b_op := Opposite( opposite, b );
        
        verbose := ValueOption( "verbose" ) = true;
        
        if CanCompute( cat, "CartesianBraiding" ) then
            
            if verbose then
                
                # COVERAGE_IGNORE_NEXT_LINE
                Display( "Testing 'CartesianBraiding' ..." );
                
            fi;
            
            braiding_a_b := CartesianBraiding( a, b );
            braiding_b_a := CartesianBraiding( b, a );
            
            braiding_inverse_a_b_op := CocartesianBraidingInverse( opposite, a_op, b_op );
            braiding_inverse_b_a_op := CocartesianBraidingInverse( opposite, b_op, a_op );
            
            Assert( 0, IsCongruentForMorphisms( braiding_inverse_a_b_op, Opposite( opposite, braiding_a_b ) ) );
            Assert( 0, IsCongruentForMorphisms( braiding_inverse_b_a_op, Opposite( opposite, braiding_b_a ) ) );
            
        fi;
        
        if CanCompute( cat, "CartesianBraidingInverse" ) then
            
            if verbose then
                
                # COVERAGE_IGNORE_NEXT_LINE
                Display( "Testing 'CartesianBraidingInverse' ..." );
                
            fi;
            
            braiding_inverse_a_b := CartesianBraidingInverse( a, b );
            braiding_inverse_b_a := CartesianBraidingInverse( b, a );
            
            braiding_a_b_op := CocartesianBraiding( opposite, a_op, b_op );
            braiding_b_a_op := CocartesianBraiding( opposite, b_op, a_op );
            
            Assert( 0, IsCongruentForMorphisms( braiding_a_b_op, Opposite( opposite, braiding_inverse_a_b ) ) );
            Assert( 0, IsCongruentForMorphisms( braiding_b_a_op, Opposite( opposite, braiding_inverse_b_a ) ) );
            
        fi;

end );
