# SPDX-License-Identifier: GPL-2.0-or-later
# CartesianCategories: Cartesian and cocartesian categories and various subdoctrines
#
# Implementations
#
# THIS FILE WAS AUTOMATICALLY GENERATED



##
InstallMethod( TestCocartesianBraidingCompatability,
              [ IsCapCategoryObject, IsCapCategoryObject, IsCapCategoryObject ],
              
  function( object_a, object_b, object_c )
    local morphism_1, morphism_2;
    
    morphism_1 := CocartesianBraiding( Coproduct( object_a, object_b ), object_c );
    
    morphism_1 := PreCompose( morphism_1, CocartesianAssociatorRightToLeft( object_c, object_a, object_b ) );
    
    morphism_1 := PreCompose( morphism_1,
                    CoproductOnMorphisms( CocartesianBraiding( object_c, object_a ), IdentityMorphism( object_b ) ) );
    
    morphism_2 := CocartesianAssociatorLeftToRight( object_a, object_b, object_c );
    
    morphism_2 := PreCompose( morphism_2,
                    CoproductOnMorphisms( IdentityMorphism( object_a ), CocartesianBraiding( object_b, object_c ) ) );
    
    morphism_2 := PreCompose( morphism_2, CocartesianAssociatorRightToLeft( object_a, object_c, object_b ) );
    
    if not ( morphism_1 = morphism_2 ) then
        
        return false;
        
    fi;
    
    morphism_1 := CocartesianBraiding( object_a, Coproduct( object_b, object_c ) );
    
    morphism_1 := PreCompose( morphism_1, CocartesianAssociatorLeftToRight( object_b, object_c, object_a ) );
    
    morphism_1 := PreCompose( morphism_1,
                    CoproductOnMorphisms( IdentityMorphism( object_b ), CocartesianBraiding( object_c, object_a ) ) );
    
    morphism_2 := CocartesianAssociatorRightToLeft( object_a, object_b, object_c );
    
    morphism_2 := PreCompose( morphism_2,
                    CoproductOnMorphisms( CocartesianBraiding( object_a, object_b ), IdentityMorphism( object_c ) ) );
    
    morphism_2 := PreCompose( morphism_2, CocartesianAssociatorLeftToRight( object_b, object_a, object_c ) );
    
    return morphism_1 = morphism_2;
    
end );

##
InstallMethod( TestCocartesianBraidingCompatabilityForAllTriplesInList,
               [ IsList ],
               
  function( object_list )
    local a, b, c, size, list, test;
    
    size := Size( object_list );
    
    list := [ 1 .. size ];
    
    for a in list do
        
        for b in list do
            
            for c in list do
                
                test := TestCocartesianBraidingCompatability( object_list[a], object_list[b], object_list[c] );
                
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
