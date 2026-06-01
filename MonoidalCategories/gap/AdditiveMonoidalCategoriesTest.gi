# SPDX-License-Identifier: GPL-2.0-or-later
# MonoidalCategories: Monoidal and monoidal (co)closed categories
#
# Implementations
#

InstallGlobalFunction( "AdditiveMonoidalCategoriesTest",
    
    function( cat, opposite, a, L, M )
        
        local verbose,
              
              a_op, left_expanding_a_L, left_expanding_a_L_op, left_factoring_a_L, left_factoring_a_L_op, 
              L_op, right_expanding_L_a, right_expanding_L_a_op, right_factoring_L_a, right_factoring_L_a_op;
        
        a_op := Opposite( opposite, a );
        L_op := List( L, l -> Opposite( opposite, l ) );
        
        verbose := ValueOption( "verbose" ) = true;
        
        if CanCompute( cat, "LeftDistributivityExpanding" ) then
            
            if verbose then
                
                # COVERAGE_IGNORE_NEXT_LINE
                Display( "Testing 'LeftDistributivityExpanding' ..." );
                
            fi;
            
            left_expanding_a_L := LeftDistributivityExpanding( a, L );
            left_factoring_a_L_op := LeftDistributivityFactoring( opposite, a_op, L_op );
            
            Assert( 0, IsCongruentForMorphisms( left_expanding_a_L, Opposite( left_factoring_a_L_op ) ) );
            
        fi;
        
        if CanCompute( cat, "LeftDistributivityExpandingUsingMultiplicities" ) then
            
            if verbose then
                
                # COVERAGE_IGNORE_NEXT_LINE
                Display( "Testing 'LeftDistributivityExpandingUsingMultiplicities' ..." );
                
            fi;
            
            left_expanding_a_L := LeftDistributivityExpandingUsingMultiplicities( a, L, M );
            left_factoring_a_L_op := LeftDistributivityFactoringUsingMultiplicities( opposite, a_op, L_op, M );
            
            Assert( 0, IsCongruentForMorphisms( left_expanding_a_L, Opposite( left_factoring_a_L_op ) ) );
            
        fi;
        
        if CanCompute( cat, "LeftDistributivityFactoring" ) then
            
            if verbose then
                
                # COVERAGE_IGNORE_NEXT_LINE
                Display( "Testing 'LeftDistributivityFactoring' ..." );
                
            fi;
            
            left_factoring_a_L := LeftDistributivityFactoring( a, L );
            left_expanding_a_L_op := LeftDistributivityExpanding( opposite, a_op, L_op );
            
            Assert( 0, IsCongruentForMorphisms( left_factoring_a_L, Opposite( left_expanding_a_L_op ) ) );
            
        fi;
        
        if CanCompute( cat, "LeftDistributivityFactoringUsingMultiplicities" ) then
            
            if verbose then
                
                # COVERAGE_IGNORE_NEXT_LINE
                Display( "Testing 'LeftDistributivityFactoringUsingMultiplicities' ..." );
                
            fi;
            
            left_factoring_a_L := LeftDistributivityFactoringUsingMultiplicities( a, L, M );
            left_expanding_a_L_op := LeftDistributivityExpandingUsingMultiplicities( opposite, a_op, L_op, M );
            
            Assert( 0, IsCongruentForMorphisms( left_factoring_a_L, Opposite( left_expanding_a_L_op ) ) );
            
        fi;
        
        if CanCompute( cat, "RightDistributivityExpanding" ) then
            
            if verbose then
                
                # COVERAGE_IGNORE_NEXT_LINE
                Display( "Testing 'RightDistributivityExpanding' ..." );
                
            fi;
            
            right_expanding_L_a := RightDistributivityExpanding( L, a );
            right_factoring_L_a_op := RightDistributivityFactoring( opposite, L_op, a_op );
            
            Assert( 0, IsCongruentForMorphisms( right_expanding_L_a, Opposite( right_factoring_L_a_op ) ) );
            
        fi;
        
        if CanCompute( cat, "RightDistributivityExpandingUsingMultiplicities" ) then
            
            if verbose then
                
                # COVERAGE_IGNORE_NEXT_LINE
                Display( "Testing 'RightDistributivityExpandingUsingMultiplicities' ..." );
                
            fi;
            
            right_expanding_L_a := RightDistributivityExpandingUsingMultiplicities( L, M, a );
            right_factoring_L_a_op := RightDistributivityFactoringUsingMultiplicities( opposite, L_op, M, a_op );
            
            Assert( 0, IsCongruentForMorphisms( right_expanding_L_a, Opposite( right_factoring_L_a_op ) ) );
            
        fi;
        
        if CanCompute( cat, "RightDistributivityFactoring" ) then
            
            if verbose then
                
                # COVERAGE_IGNORE_NEXT_LINE
                Display( "Testing 'RightDistributivityFactoring' ..." );
                
            fi;
            
            right_factoring_L_a := RightDistributivityFactoring( L, a );
            right_expanding_L_a_op := RightDistributivityExpanding( opposite, L_op, a_op );
            
            Assert( 0, IsCongruentForMorphisms( right_factoring_L_a, Opposite( right_expanding_L_a_op ) ) );
            
        fi;
        
        if CanCompute( cat, "RightDistributivityFactoringUsingMultiplicities" ) then
            
            if verbose then
                
                # COVERAGE_IGNORE_NEXT_LINE
                Display( "Testing 'RightDistributivityFactoringUsingMultiplicities' ..." );
                
            fi;
            
            right_factoring_L_a := RightDistributivityFactoringUsingMultiplicities( L, M, a );
            right_expanding_L_a_op := RightDistributivityExpandingUsingMultiplicities( opposite, L_op, M, a_op );
            
            Assert( 0, IsCongruentForMorphisms( right_factoring_L_a, Opposite( right_expanding_L_a_op ) ) );
            
        fi;
end );
