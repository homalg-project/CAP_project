# SPDX-License-Identifier: GPL-2.0-or-later
# Toposes: Elementary toposes
#
# Implementations
#
# THIS FILE WAS AUTOMATICALLY GENERATED



InstallGlobalFunction( "DistributiveCartesianCategoriesTest",
    
    function( cat, a, L )
        
        local opposite, verbose,
              
              a_op, left_expanding_a_L, left_expanding_a_L_op, left_factoring_a_L, left_factoring_a_L_op, 
              L_op, right_expanding_L_a, right_expanding_L_a_op, right_factoring_L_a, right_factoring_L_a_op;
        
        opposite := Opposite( cat );
        
        a_op := Opposite( a );
        L_op := List( L, l -> Opposite( l ) );
        
        verbose := ValueOption( "verbose" ) = true;
        
        if CanCompute( cat, "LeftCartesianDistributivityExpanding" ) then
            
            if verbose then
                
                # COVERAGE_IGNORE_NEXT_LINE
                Display( "Testing 'LeftCartesianDistributivityExpanding' ..." );
                
            fi;
            
            left_expanding_a_L := LeftCartesianDistributivityExpanding( a, L );
            left_factoring_a_L_op := LeftCocartesianCodistributivityFactoring( opposite, a_op, L_op );
            
            Assert( 0, IsCongruentForMorphisms( left_expanding_a_L, Opposite( left_factoring_a_L_op ) ) );
            
        fi;
        
        if CanCompute( cat, "LeftCartesianDistributivityFactoring" ) then
            
            if verbose then
                
                # COVERAGE_IGNORE_NEXT_LINE
                Display( "Testing 'LeftCartesianDistributivityFactoring' ..." );
                
            fi;
            
            left_factoring_a_L := LeftCartesianDistributivityFactoring( a, L );
            left_expanding_a_L_op := LeftCocartesianCodistributivityExpanding( opposite, a_op, L_op );
            
            Assert( 0, IsCongruentForMorphisms( left_factoring_a_L, Opposite( left_expanding_a_L_op ) ) );
            
        fi;
        
        if CanCompute( cat, "RightCartesianDistributivityExpanding" ) then
            
            if verbose then
                
                # COVERAGE_IGNORE_NEXT_LINE
                Display( "Testing 'RightCartesianDistributivityExpanding' ..." );
                
            fi;
            
            right_expanding_L_a := RightCartesianDistributivityExpanding( L, a );
            right_factoring_L_a_op := RightCocartesianCodistributivityFactoring( opposite, L_op, a_op );
            
            Assert( 0, IsCongruentForMorphisms( right_expanding_L_a, Opposite( right_factoring_L_a_op ) ) );
            
        fi;
        
        if CanCompute( cat, "RightCartesianDistributivityFactoring" ) then
            
            if verbose then
                
                # COVERAGE_IGNORE_NEXT_LINE
                Display( "Testing 'RightCartesianDistributivityFactoring' ..." );
                
            fi;
            
            right_factoring_L_a := RightCartesianDistributivityFactoring( L, a );
            right_expanding_L_a_op := RightCocartesianCodistributivityExpanding( opposite, L_op, a_op );
            
            Assert( 0, IsCongruentForMorphisms( right_factoring_L_a, Opposite( right_expanding_L_a_op ) ) );
            
        fi;
        
end );
