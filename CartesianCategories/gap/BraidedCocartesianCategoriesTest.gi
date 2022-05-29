# SPDX-License-Identifier: GPL-2.0-or-later
# CartesianCategories: Cartesian and cocartesian categories and various subdoctrines
#
# Implementations
#
# THIS FILE WAS AUTOMATICALLY GENERATED



InstallGlobalFunction( "BraidedCocartesianCategoriesTest",
    
    function( cat, a, b )
        
        local opposite, verbose,
              
              a_op, braiding_a_b, braiding_a_b_op, braiding_inverse_a_b, braiding_inverse_a_b_op, 
              b_op, braiding_b_a, braiding_b_a_op, braiding_inverse_b_a, braiding_inverse_b_a_op;
        
        opposite := Opposite( cat );
        
        a_op := Opposite( a );
        b_op := Opposite( b );
        
        verbose := ValueOption( "verbose" ) = true;
        
        if CanCompute( cat, "CocartesianBraiding" ) then
            
            if verbose then
                
                # COVERAGE_IGNORE_NEXT_LINE
                Display( "Testing 'CocartesianBraiding' ..." );
                
            fi;
            
            braiding_a_b := CocartesianBraiding( a, b );
            braiding_b_a := CocartesianBraiding( b, a );
            
            braiding_inverse_a_b_op := CartesianBraidingInverse( opposite, a_op, b_op );
            braiding_inverse_b_a_op := CartesianBraidingInverse( opposite, b_op, a_op );
            
            Assert( 0, IsCongruentForMorphisms( braiding_inverse_a_b_op, Opposite( braiding_a_b ) ) );
            Assert( 0, IsCongruentForMorphisms( braiding_inverse_b_a_op, Opposite( braiding_b_a ) ) );
            
        fi;
        
        if CanCompute( cat, "CocartesianBraidingInverse" ) then
            
            if verbose then
                
                # COVERAGE_IGNORE_NEXT_LINE
                Display( "Testing 'CocartesianBraidingInverse' ..." );
                
            fi;
            
            braiding_inverse_a_b := CocartesianBraidingInverse( a, b );
            braiding_inverse_b_a := CocartesianBraidingInverse( b, a );
            
            braiding_a_b_op := CartesianBraiding( opposite, a_op, b_op );
            braiding_b_a_op := CartesianBraiding( opposite, b_op, a_op );
            
            Assert( 0, IsCongruentForMorphisms( braiding_a_b_op, Opposite( braiding_inverse_a_b ) ) );
            Assert( 0, IsCongruentForMorphisms( braiding_b_a_op, Opposite( braiding_inverse_b_a ) ) );
            
        fi;

end );
