# SPDX-License-Identifier: GPL-2.0-or-later
# MonoidalCategories: Monoidal and monoidal (co)closed categories
#
# Implementations
#

##
InstallMethod( TestBraidingCompatability,
              [ IsCapCategoryObject, IsCapCategoryObject, IsCapCategoryObject ],
              
  function( object_a, object_b, object_c )
    local morphism_1, morphism_2;
    
    morphism_1 := Braiding( TensorProductOnObjects( object_a, object_b ), object_c );
    
    morphism_1 := PreCompose( morphism_1, AssociatorRightToLeft( object_c, object_a, object_b ) );
    
    morphism_1 := PreCompose( morphism_1,
                    TensorProductOnMorphisms( Braiding( object_c, object_a ), IdentityMorphism( object_b ) ) );
    
    morphism_2 := AssociatorLeftToRight( object_a, object_b, object_c );
    
    morphism_2 := PreCompose( morphism_2,
                    TensorProductOnMorphisms( IdentityMorphism( object_a ), Braiding( object_b, object_c ) ) );
    
    morphism_2 := PreCompose( morphism_2, AssociatorRightToLeft( object_a, object_c, object_b ) );
    
    if not ( morphism_1 = morphism_2 ) then
        
        return false;
        
    fi;
    
    morphism_1 := Braiding( object_a, TensorProductOnObjects( object_b, object_c ) );
    
    morphism_1 := PreCompose( morphism_1, AssociatorLeftToRight( object_b, object_c, object_a ) );
    
    morphism_1 := PreCompose( morphism_1,
                    TensorProductOnMorphisms( IdentityMorphism( object_b ), Braiding( object_c, object_a ) ) );
    
    morphism_2 := AssociatorRightToLeft( object_a, object_b, object_c );
    
    morphism_2 := PreCompose( morphism_2,
                    TensorProductOnMorphisms( Braiding( object_a, object_b ), IdentityMorphism( object_c ) ) );
    
    morphism_2 := PreCompose( morphism_2, AssociatorLeftToRight( object_b, object_a, object_c ) );
    
    return morphism_1 = morphism_2;
    
end );

##
InstallMethod( TestBraidingCompatabilityForAllTriplesInList,
               [ IsList ],
               
  function( object_list )
    local a, b, c, size, list, test;
    
    size := Size( object_list );
    
    list := [ 1 .. size ];
    
    for a in list do
        
        for b in list do
            
            for c in list do
                
                test := TestBraidingCompatability( object_list[a], object_list[b], object_list[c] );
                
                if not test then
                    
                    Print( "indices of failing triple: ", [ a, b, c ], "\n" );
                    
                    return false;
                    
                fi;
                
            od;
            
        od;
        
    od;
    
end );

##
InstallGlobalFunction( "BraidedMonoidalCategoriesTest",
    
    function( cat, opposite, a, b )
        
        local verbose,
              
              a_op, braiding_a_b, braiding_a_b_op, braiding_inverse_a_b, braiding_inverse_a_b_op, 
              b_op, braiding_b_a, braiding_b_a_op, braiding_inverse_b_a, braiding_inverse_b_a_op;
        
        a_op := Opposite( opposite, a );
        b_op := Opposite( opposite, b );
        
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
            
            Assert( 0, IsCongruentForMorphisms( braiding_inverse_a_b_op, Opposite( opposite, braiding_a_b ) ) );
            Assert( 0, IsCongruentForMorphisms( braiding_inverse_b_a_op, Opposite( opposite, braiding_b_a ) ) );
            
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
            
            Assert( 0, IsCongruentForMorphisms( braiding_a_b_op, Opposite( opposite, braiding_inverse_a_b ) ) );
            Assert( 0, IsCongruentForMorphisms( braiding_b_a_op, Opposite( opposite, braiding_inverse_b_a ) ) );
            
        fi;

end );
