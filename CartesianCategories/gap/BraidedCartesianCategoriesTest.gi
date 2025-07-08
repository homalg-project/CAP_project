# SPDX-License-Identifier: GPL-2.0-or-later
# CartesianCategories: Cartesian and cocartesian categories and various subdoctrines
#
# Implementations
#
# THIS FILE WAS AUTOMATICALLY GENERATED



##
InstallMethod( TestCartesianBraidingCompatability,
              [ IsCapCategoryObject, IsCapCategoryObject, IsCapCategoryObject ],
              
  function( object_a, object_b, object_c )
    local morphism_1, morphism_2;
    
    morphism_1 := CartesianBraiding( DirectProduct( object_a, object_b ), object_c );
    
    morphism_1 := PreCompose( morphism_1, CartesianAssociatorRightToLeft( object_c, object_a, object_b ) );
    
    morphism_1 := PreCompose( morphism_1,
                    DirectProductOnMorphisms( CartesianBraiding( object_c, object_a ), IdentityMorphism( object_b ) ) );
    
    morphism_2 := CartesianAssociatorLeftToRight( object_a, object_b, object_c );
    
    morphism_2 := PreCompose( morphism_2,
                    DirectProductOnMorphisms( IdentityMorphism( object_a ), CartesianBraiding( object_b, object_c ) ) );
    
    morphism_2 := PreCompose( morphism_2, CartesianAssociatorRightToLeft( object_a, object_c, object_b ) );
    
    if not ( morphism_1 = morphism_2 ) then
        
        return false;
        
    fi;
    
    morphism_1 := CartesianBraiding( object_a, DirectProduct( object_b, object_c ) );
    
    morphism_1 := PreCompose( morphism_1, CartesianAssociatorLeftToRight( object_b, object_c, object_a ) );
    
    morphism_1 := PreCompose( morphism_1,
                    DirectProductOnMorphisms( IdentityMorphism( object_b ), CartesianBraiding( object_c, object_a ) ) );
    
    morphism_2 := CartesianAssociatorRightToLeft( object_a, object_b, object_c );
    
    morphism_2 := PreCompose( morphism_2,
                    DirectProductOnMorphisms( CartesianBraiding( object_a, object_b ), IdentityMorphism( object_c ) ) );
    
    morphism_2 := PreCompose( morphism_2, CartesianAssociatorLeftToRight( object_b, object_a, object_c ) );
    
    return morphism_1 = morphism_2;
    
end );

##
InstallMethod( TestCartesianBraidingCompatabilityForAllTriplesInList,
               [ IsList ],
               
  function( object_list )
    local a, b, c, size, list, test;
    
    size := Size( object_list );
    
    list := [ 1 .. size ];
    
    for a in list do
        
        for b in list do
            
            for c in list do
                
                test := TestCartesianBraidingCompatability( object_list[a], object_list[b], object_list[c] );
                
                if not test then
                    
                    Print( "indices of failing triple: ", [ a, b, c ], "\n" );
                    
                    return false;
                    
                fi;
                
            od;
            
        od;
        
    od;
    
end );

##
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
