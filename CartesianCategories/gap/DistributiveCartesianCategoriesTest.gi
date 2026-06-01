# SPDX-License-Identifier: GPL-2.0-or-later
# CartesianCategories: Cartesian and cocartesian categories and various subdoctrines
#
# Implementations
#
# THIS FILE WAS AUTOMATICALLY GENERATED



InstallGlobalFunction( "DistributiveCartesianCategoriesTest",
    
    function( cat, opposite, a, L, M )
        
        local verbose,
              
              a_op, left_expanding_a_L, left_expanding_a_L_op, left_factoring_a_L, left_factoring_a_L_op, 
              L_op, right_expanding_L_a, right_expanding_L_a_op, right_factoring_L_a, right_factoring_L_a_op;
        
        a_op := Opposite( opposite, a );
        L_op := List( L, l -> Opposite( opposite, l ) );
        
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
        
        if CanCompute( cat, "LeftCartesianDistributivityExpandingUsingMultiplicities" ) then
            
            if verbose then
                
                # COVERAGE_IGNORE_NEXT_LINE
                Display( "Testing 'LeftCartesianDistributivityExpandingUsingMultiplicities' ..." );
                
            fi;
            
            left_expanding_a_L := LeftCartesianDistributivityExpandingUsingMultiplicities( a, L, M );
            left_factoring_a_L_op := LeftCartesianDistributivityFactoringUsingMultiplicities( opposite, a_op, L_op, M );
            
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
        
        if CanCompute( cat, "LeftCartesianDistributivityFactoringUsingMultiplicities" ) then
            
            if verbose then
                
                # COVERAGE_IGNORE_NEXT_LINE
                Display( "Testing 'LeftCartesianDistributivityFactoringUsingMultiplicities' ..." );
                
            fi;
            
            left_factoring_a_L := LeftCartesianDistributivityFactoringUsingMultiplicities( a, L, M );
            left_expanding_a_L_op := LeftCartesianDistributivityExpandingUsingMultiplicities( opposite, a_op, L_op, M );
            
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
        
        if CanCompute( cat, "RightCartesianDistributivityExpandingUsingMultiplicities" ) then
            
            if verbose then
                
                # COVERAGE_IGNORE_NEXT_LINE
                Display( "Testing 'RightCartesianDistributivityExpandingUsingMultiplicities' ..." );
                
            fi;
            
            right_expanding_L_a := RightCartesianDistributivityExpandingUsingMultiplicities( L, M, a );
            right_factoring_L_a_op := RightCartesianDistributivityFactoringUsingMultiplicities( opposite, L_op, M, a_op );
            
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
        
        if CanCompute( cat, "RightCartesianDistributivityFactoringUsingMultiplicities" ) then
            
            if verbose then
                
                # COVERAGE_IGNORE_NEXT_LINE
                Display( "Testing 'RightCartesianDistributivityFactoringUsingMultiplicities' ..." );
                
            fi;
            
            right_factoring_L_a := RightCartesianDistributivityFactoringUsingMultiplicities( L, M, a );
            right_expanding_L_a_op := RightCartesianDistributivityExpandingUsingMultiplicities( opposite, L_op, M, a_op );
            
            Assert( 0, IsCongruentForMorphisms( right_factoring_L_a, Opposite( right_expanding_L_a_op ) ) );
            
        fi;
end );
