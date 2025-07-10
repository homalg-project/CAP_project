# SPDX-License-Identifier: GPL-2.0-or-later
# CartesianCategories: Cartesian and cocartesian categories and various subdoctrines
#
# Implementations
#
# THIS FILE WAS AUTOMATICALLY GENERATED



##
InstallMethod( TestCocartesianBraidingCompatability,
              [ IsCapCategory, IsCapCategoryObject, IsCapCategoryObject, IsCapCategoryObject ],
              
  function( cat, object_1, object_2, object_3 )
    local morphism_left, morphism_right;
    
    Assert( 0, HasIsCocartesianCategory( cat ) and IsCocartesianCategory( cat ) );
    Assert( 0, IsIdenticalObj( cat, CapCategory( object_1 ) ) );
    Assert( 0, IsIdenticalObj( cat, CapCategory( object_2 ) ) );
    Assert( 0, IsIdenticalObj( cat, CapCategory( object_3 ) ) );
    
    morphism_left := CocartesianBraiding( BinaryCoproduct( cat, object_1, object_2 ), object_3 );
    
    morphism_left := PreCompose( morphism_left, CocartesianAssociatorRightToLeft( object_3, object_1, object_2 ) );
    
    morphism_left := PreCompose( morphism_left,
                    CoproductOnMorphisms( CocartesianBraiding( object_3, object_1 ), IdentityMorphism( object_2 ) ) );
    
    morphism_right := CocartesianAssociatorLeftToRight( object_1, object_2, object_3 );
    
    morphism_right := PreCompose( morphism_right,
                    CoproductOnMorphisms( IdentityMorphism( object_1 ), CocartesianBraiding( object_2, object_3 ) ) );
    
    morphism_right := PreCompose( morphism_right, CocartesianAssociatorRightToLeft( object_1, object_3, object_2 ) );
    
    if not ( morphism_left = morphism_right ) then
        
        return false;
        
    fi;
    
    morphism_left := CocartesianBraiding( object_1, BinaryCoproduct( cat, object_2, object_3 ) );
    
    morphism_left := PreCompose( morphism_left, CocartesianAssociatorLeftToRight( object_2, object_3, object_1 ) );
    
    morphism_left := PreCompose( morphism_left,
                    CoproductOnMorphisms( IdentityMorphism( object_2 ), CocartesianBraiding( object_3, object_1 ) ) );
    
    morphism_right := CocartesianAssociatorRightToLeft( object_1, object_2, object_3 );
    
    morphism_right := PreCompose( morphism_right,
                    CoproductOnMorphisms( CocartesianBraiding( object_1, object_2 ), IdentityMorphism( object_3 ) ) );
    
    morphism_right := PreCompose( morphism_right, CocartesianAssociatorLeftToRight( object_2, object_1, object_3 ) );
    
    return morphism_left = morphism_right;
    
end );

##
InstallMethod( TestCocartesianBraidingCompatabilityForAllTriplesInList,
               [ IsCapCategory, IsList ],
               
  function( cat, object_list )
    local a, b, c, size, list, test;
    
    size := Length( object_list );
    
    list := [ 1 .. size ];
    
    for a in list do
        
        for b in list do
            
            for c in list do
                
                test := TestCocartesianBraidingCompatability( cat, object_list[a], object_list[b], object_list[c] );
                
                if not test then
                    
                    Print( "indices of failing triple: ", [ a, b, c ], "\n" );
                    
                    return false;
                    
                fi;
                
            od;
            
        od;
        
    od;
    
end );

##
InstallGlobalFunction( "BraidedCocartesianCategoriesTest",
    function( cat, opposite, a, b )
        local verbose,
              
              a_op, braiding_a_b, braiding_a_b_op, braiding_inverse_a_b, braiding_inverse_a_b_op, 
              b_op, braiding_b_a, braiding_b_a_op, braiding_inverse_b_a, braiding_inverse_b_a_op;
        
        a_op := Opposite( opposite, a );
        b_op := Opposite( opposite, b );
        
        verbose := ValueOption( "verbose" ) = true;
        
        if IsEmpty( MissingOperationsForConstructivenessOfCategory( cat, "IsCocartesianCategory" ) ) then
            
            Assert( 0, TestCocartesianBraidingCompatability( cat, a, b, a ) );
            
        fi;
        
        if IsEmpty( MissingOperationsForConstructivenessOfCategory( opposite, "IsCocartesianCategory" ) ) then
            
            Assert( 0, TestCocartesianBraidingCompatability( opposite, a_op, b_op, a_op ) );
            
        fi;
        
        if CanCompute( cat, "CocartesianBraiding" ) then
            
            if verbose then
                
                # COVERAGE_IGNORE_NEXT_LINE
                Display( "Testing 'CocartesianBraiding' ..." );
                
            fi;
            
            braiding_a_b := CocartesianBraiding( a, b );
            braiding_b_a := CocartesianBraiding( b, a );
            
            braiding_inverse_a_b_op := CartesianBraidingInverse( opposite, a_op, b_op );
            braiding_inverse_b_a_op := CartesianBraidingInverse( opposite, b_op, a_op );
            
            Assert( 0, IsCongruentForMorphisms( braiding_inverse_a_b_op, Opposite( opposite, braiding_a_b ) ) );
            Assert( 0, IsCongruentForMorphisms( braiding_inverse_b_a_op, Opposite( opposite, braiding_b_a ) ) );
            
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
            
            Assert( 0, IsCongruentForMorphisms( braiding_a_b_op, Opposite( opposite, braiding_inverse_a_b ) ) );
            Assert( 0, IsCongruentForMorphisms( braiding_b_a_op, Opposite( opposite, braiding_inverse_b_a ) ) );
            
        fi;

end );
