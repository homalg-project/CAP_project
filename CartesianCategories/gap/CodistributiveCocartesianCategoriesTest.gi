# SPDX-License-Identifier: GPL-2.0-or-later
# CartesianCategories: Cartesian and cocartesian categories and various subdoctrines
#
# Implementations
#
# THIS FILE WAS AUTOMATICALLY GENERATED



InstallGlobalFunction( "CodistributiveCocartesianCategoriesTest",
    
    function( cat, a, L )
        
        local opposite, verbose,
              
              a_op, left_expanding_a_L, left_expanding_a_L_op, left_factoring_a_L, left_factoring_a_L_op, 
              L_op, right_expanding_L_a, right_expanding_L_a_op, right_factoring_L_a, right_factoring_L_a_op;
        
        opposite := Opposite( cat, "Opposite" );
        
        a_op := Opposite( opposite, a );
        L_op := List( L, l -> Opposite( opposite, l ) );
        
        verbose := ValueOption( "verbose" ) = true;
        
        if CanCompute( cat, "LeftCocartesianCodistributivityExpanding" ) then
            
            if verbose then
                
                # COVERAGE_IGNORE_NEXT_LINE
                Display( "Testing 'LeftCocartesianCodistributivityExpanding' ..." );
                
            fi;
            
            left_expanding_a_L := LeftCocartesianCodistributivityExpanding( a, L );
            left_factoring_a_L_op := LeftCartesianDistributivityFactoring( opposite, a_op, L_op );
            
            Assert( 0, IsCongruentForMorphisms( left_expanding_a_L, Opposite( left_factoring_a_L_op ) ) );
            
        fi;
        
        if CanCompute( cat, "LeftCocartesianCodistributivityFactoring" ) then
            
            if verbose then
                
                # COVERAGE_IGNORE_NEXT_LINE
                Display( "Testing 'LeftCocartesianCodistributivityFactoring' ..." );
                
            fi;
            
            left_factoring_a_L := LeftCocartesianCodistributivityFactoring( a, L );
            left_expanding_a_L_op := LeftCartesianDistributivityExpanding( opposite, a_op, L_op );
            
            Assert( 0, IsCongruentForMorphisms( left_factoring_a_L, Opposite( left_expanding_a_L_op ) ) );
            
        fi;
        
        if CanCompute( cat, "RightCocartesianCodistributivityExpanding" ) then
            
            if verbose then
                
                # COVERAGE_IGNORE_NEXT_LINE
                Display( "Testing 'RightCocartesianCodistributivityExpanding' ..." );
                
            fi;
            
            right_expanding_L_a := RightCocartesianCodistributivityExpanding( L, a );
            right_factoring_L_a_op := RightCartesianDistributivityFactoring( opposite, L_op, a_op );
            
            Assert( 0, IsCongruentForMorphisms( right_expanding_L_a, Opposite( right_factoring_L_a_op ) ) );
            
        fi;
        
        if CanCompute( cat, "RightCocartesianCodistributivityFactoring" ) then
            
            if verbose then
                
                # COVERAGE_IGNORE_NEXT_LINE
                Display( "Testing 'RightCocartesianCodistributivityFactoring' ..." );
                
            fi;
            
            right_factoring_L_a := RightCocartesianCodistributivityFactoring( L, a );
            right_expanding_L_a_op := RightCartesianDistributivityExpanding( opposite, L_op, a_op );
            
            Assert( 0, IsCongruentForMorphisms( right_factoring_L_a, Opposite( right_expanding_L_a_op ) ) );
            
        fi;
        
end );
