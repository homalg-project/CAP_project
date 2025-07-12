# SPDX-License-Identifier: GPL-2.0-or-later
# MonoidalCategories: Monoidal and monoidal (co)closed categories
#
# Implementations
#

##
InstallMethod( TestBraidingForInvertibility,
              [ IsCapCategory, IsCapCategoryObject, IsCapCategoryObject ],
              
  function( cat, object_1, object_2 )
    
    Assert( 0, HasIsBraidedMonoidalCategory( cat ) and IsBraidedMonoidalCategory( cat ) );
    Assert( 0, IsIdenticalObj( cat, CapCategory( object_1 ) ) );
    Assert( 0, IsIdenticalObj( cat, CapCategory( object_2 ) ) );
    
    return IsOne( PreCompose( Braiding( object_1, object_2 ), BraidingInverse( object_1, object_2 ) ) ) and
           IsOne( PreCompose( BraidingInverse( object_1, object_2 ), Braiding( object_1, object_2 ) ) ) and
           IsOne( PreCompose( Braiding( object_2, object_1 ), BraidingInverse( object_2, object_1 ) ) ) and
           IsOne( PreCompose( BraidingInverse( object_2, object_1 ), Braiding( object_2, object_1 ) ) );
    
end );

##
InstallMethod( TestBraidingCompatibility,
              [ IsCapCategory, IsCapCategoryObject, IsCapCategoryObject, IsCapCategoryObject ],
              
  function( cat, object_1, object_2, object_3 )
    local morphism_left, morphism_right;
    
    Assert( 0, HasIsBraidedMonoidalCategory( cat ) and IsBraidedMonoidalCategory( cat ) );
    Assert( 0, IsIdenticalObj( cat, CapCategory( object_1 ) ) );
    Assert( 0, IsIdenticalObj( cat, CapCategory( object_2 ) ) );
    Assert( 0, IsIdenticalObj( cat, CapCategory( object_3 ) ) );
    
    morphism_left := Braiding( TensorProductOnObjects( cat, object_1, object_2 ), object_3 );
    
    morphism_left := PreCompose( morphism_left, AssociatorRightToLeft( object_3, object_1, object_2 ) );
    
    morphism_left := PreCompose( morphism_left,
                    TensorProductOnMorphisms( Braiding( object_3, object_1 ), IdentityMorphism( object_2 ) ) );
    
    morphism_right := AssociatorLeftToRight( object_1, object_2, object_3 );
    
    morphism_right := PreCompose( morphism_right,
                    TensorProductOnMorphisms( IdentityMorphism( object_1 ), Braiding( object_2, object_3 ) ) );
    
    morphism_right := PreCompose( morphism_right, AssociatorRightToLeft( object_1, object_3, object_2 ) );
    
    if not ( morphism_left = morphism_right ) then
        
        return false;
        
    fi;
    
    morphism_left := Braiding( object_1, TensorProductOnObjects( cat, object_2, object_3 ) );
    
    morphism_left := PreCompose( morphism_left, AssociatorLeftToRight( object_2, object_3, object_1 ) );
    
    morphism_left := PreCompose( morphism_left,
                    TensorProductOnMorphisms( IdentityMorphism( object_2 ), Braiding( object_3, object_1 ) ) );
    
    morphism_right := AssociatorRightToLeft( object_1, object_2, object_3 );
    
    morphism_right := PreCompose( morphism_right,
                    TensorProductOnMorphisms( Braiding( object_1, object_2 ), IdentityMorphism( object_3 ) ) );
    
    morphism_right := PreCompose( morphism_right, AssociatorLeftToRight( object_2, object_1, object_3 ) );
    
    return morphism_left = morphism_right;
    
end );

##
InstallMethod( TestBraidingCompatibilityForAllTriplesInList,
               [ IsCapCategory, IsList ],
               
  function( cat, object_list )
    local a, b, c, size, list, test;
    
    size := Length( object_list );
    
    list := [ 1 .. size ];
    
    for a in list do
        
        for b in list do
            
            for c in list do
                
                test := TestBraidingCompatibility( cat, object_list[a], object_list[b], object_list[c] );
                
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
        
        if IsEmpty( MissingOperationsForConstructivenessOfCategory( cat, "IsBraidedMonoidalCategory" ) ) then
            
            Assert( 0, TestBraidingForInvertibility( cat, a, b ) );
            
            Assert( 0, TestBraidingCompatibility( cat, a, b, a ) );
            
        fi;
        
        if IsEmpty( MissingOperationsForConstructivenessOfCategory( opposite, "IsBraidedMonoidalCategory" ) ) then
            
            Assert( 0, TestBraidingForInvertibility( opposite, a_op, b_op ) );
            
            Assert( 0, TestBraidingCompatibility( opposite, a_op, b_op, a_op ) );
            
        fi;
        
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
