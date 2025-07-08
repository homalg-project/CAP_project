# SPDX-License-Identifier: GPL-2.0-or-later
# CartesianCategories: Cartesian and cocartesian categories and various subdoctrines
#
# Implementations
#
# THIS FILE WAS AUTOMATICALLY GENERATED



##
InstallMethod( TestCocartesianPentagonIdentity,
               [ IsCapCategoryObject, IsCapCategoryObject, IsCapCategoryObject, IsCapCategoryObject ],
               
  function( object_a, object_b, object_c, object_d )
    local morphism_1, morphism_2;
    
    morphism_1 :=
      CoproductOnMorphisms( CocartesianAssociatorLeftToRight( object_a, object_b, object_c ), IdentityMorphism( object_d ) );
    
    morphism_1 := PreCompose( morphism_1,
      CocartesianAssociatorLeftToRight( object_a, Coproduct( object_b, object_c ), object_d ) );
    
    morphism_1 := PreCompose( morphism_1,
      CoproductOnMorphisms( IdentityMorphism( object_a ), CocartesianAssociatorLeftToRight( object_b, object_c, object_d ) ) );
    
    morphism_2 := CocartesianAssociatorLeftToRight( Coproduct( object_a, object_b ), object_c, object_d );
    
    morphism_2 := PreCompose( morphism_2,
      CocartesianAssociatorLeftToRight( object_a, object_b, Coproduct( object_c, object_d ) ) );
    
    return IsCongruentForMorphisms( morphism_1, morphism_2 );
    
end );

##
InstallMethod( TestCocartesianPentagonIdentityForAllQuadruplesInList,
               [ IsList ],
               
  function( object_list )
    local a, b, c, d, size, list, test, all_okay;
    
    size := Size( object_list );
    
    list := [ 1 .. size ];
    
    all_okay := true;

    for a in list do
        
        for b in list do
            
            for c in list do
                
                for d in list do
                    
                    test := TestCocartesianPentagonIdentity( object_list[a], object_list[b], object_list[c], object_list[d] );
                    
                    if not test then
                        
                        Print( "indices of failing quadruple: ", [ a, b, c, d ], "\n" );
                        
                        return false;
                        
                    fi;
                    
                od;
                
            od;
            
            
        od;
        
    od;
    
    return all_okay;
    
end );

##
InstallGlobalFunction( "CocartesianCategoriesTest",
    
    function( cat, opposite, a, b, c, alpha, beta )
    
        local verbose,
              
              a_op,
              b_op,
              c_op,
              
              alpha_op,
              beta_op,
              
              a_tensor_b,    alpha_tensor_beta,
              b_tensor_a,    beta_tensor_alpha,
              a_tensor_b_op, alpha_tensor_beta_op,
              b_tensor_a_op, beta_tensor_alpha_op,
              
              left_unitor_a,    left_unitor_inverse_a,    right_unitor_a,    right_unitor_inverse_a,
              left_unitor_b,    left_unitor_inverse_b,    right_unitor_b,    right_unitor_inverse_a_op,
              left_unitor_a_op, left_unitor_inverse_a_op, right_unitor_a_op, right_unitor_inverse_b,
              left_unitor_b_op, left_unitor_inverse_b_op, right_unitor_b_op, right_unitor_inverse_b_op,
              
              associator_left_to_right_abc, associator_left_to_right_abc_op, associator_right_to_left_abc, associator_right_to_left_abc_op,
              associator_left_to_right_cba, associator_left_to_right_cba_op, associator_right_to_left_cba, associator_right_to_left_cba_op;
        
        a_op := Opposite( opposite, a );
        b_op := Opposite( opposite, b );
        c_op := Opposite( opposite, c );
        
        alpha_op := Opposite( opposite, alpha );
        beta_op := Opposite( opposite, beta );
        
        verbose := ValueOption( "verbose" ) = true;
        
        if CanCompute( cat, "CoproductOnMorphisms" ) then
            
            if verbose then
                
                # COVERAGE_IGNORE_NEXT_LINE
                Display( "Testing 'CoproductOnMorphisms' ..." );
                
            fi;
            
            alpha_tensor_beta := CoproductOnMorphisms( alpha, beta );
            beta_tensor_alpha := CoproductOnMorphisms( beta, alpha );
            
            alpha_tensor_beta_op := DirectProductOnMorphisms( opposite, alpha_op, beta_op );
            beta_tensor_alpha_op := DirectProductOnMorphisms( opposite, beta_op, alpha_op );
            
            Assert( 0, IsCongruentForMorphisms( alpha_tensor_beta_op, Opposite( opposite, alpha_tensor_beta ) ) );
            Assert( 0, IsCongruentForMorphisms( beta_tensor_alpha_op, Opposite( opposite, beta_tensor_alpha ) ) );
            
            # Opposite must be self-inverse
            
            Assert( 0, IsCongruentForMorphisms( alpha_tensor_beta, Opposite( alpha_tensor_beta_op ) ) );
            Assert( 0, IsCongruentForMorphisms( beta_tensor_alpha, Opposite( beta_tensor_alpha_op ) ) );
            
        fi;
        
        if CanCompute( cat, "CocartesianLeftUnitor" ) then
            
            if verbose then
                
                # COVERAGE_IGNORE_NEXT_LINE
                Display( "Testing 'CocartesianLeftUnitor' ..." );
                
            fi;
            
            left_unitor_a := CocartesianLeftUnitor( a );
            left_unitor_b := CocartesianLeftUnitor( b );
            
            left_unitor_inverse_a_op := CartesianLeftUnitorInverse( opposite, a_op );
            left_unitor_inverse_b_op := CartesianLeftUnitorInverse( opposite, b_op );
            
            Assert( 0, IsCongruentForMorphisms( left_unitor_inverse_a_op, Opposite( opposite, left_unitor_a ) ) );
            Assert( 0, IsCongruentForMorphisms( left_unitor_inverse_b_op, Opposite( opposite, left_unitor_b ) ) );
            
        fi;
        
        if CanCompute( cat, "CocartesianRightUnitor" ) then
            
            if verbose then
                
                # COVERAGE_IGNORE_NEXT_LINE
                Display( "Testing 'CocartesianRightUnitor' ..." );
                
            fi;
            
            right_unitor_a := CocartesianRightUnitor( a );
            right_unitor_b := CocartesianRightUnitor( b );
            
            right_unitor_inverse_a_op := CartesianRightUnitorInverse( opposite, a_op );
            right_unitor_inverse_b_op := CartesianRightUnitorInverse( opposite, b_op );
            
            Assert( 0, IsCongruentForMorphisms( right_unitor_inverse_a_op, Opposite( opposite, right_unitor_a ) ) );
            Assert( 0, IsCongruentForMorphisms( right_unitor_inverse_b_op, Opposite( opposite, right_unitor_b ) ) );
            
        fi;
        
        if CanCompute( cat, "CocartesianLeftUnitorInverse" ) then
            
            if verbose then
                
                # COVERAGE_IGNORE_NEXT_LINE
                Display( "Testing 'CocartesianLeftUnitorInverse' ..." );
                
            fi;
            
            left_unitor_inverse_a := CocartesianLeftUnitorInverse( a );
            left_unitor_inverse_b := CocartesianLeftUnitorInverse( b );
            
            left_unitor_a_op := CartesianLeftUnitor( opposite, a_op );
            left_unitor_b_op := CartesianLeftUnitor( opposite, b_op );
            
            Assert( 0, IsCongruentForMorphisms( left_unitor_a_op, Opposite( opposite, left_unitor_inverse_a ) ) );
            Assert( 0, IsCongruentForMorphisms( left_unitor_b_op, Opposite( opposite, left_unitor_inverse_b ) ) );
            
        fi;
        
        if CanCompute( cat, "CocartesianRightUnitorInverse" ) then
            
            if verbose then
                
                # COVERAGE_IGNORE_NEXT_LINE
                Display( "Testing 'CocartesianRightUnitorInverse' ..." );
                
            fi;
            
            right_unitor_inverse_a := CocartesianRightUnitorInverse( a );
            right_unitor_inverse_b := CocartesianRightUnitorInverse( b );
            
            right_unitor_a_op := CartesianRightUnitor( opposite, a_op );
            right_unitor_b_op := CartesianRightUnitor( opposite, b_op );
            
            Assert( 0, IsCongruentForMorphisms( right_unitor_a_op, Opposite( opposite, right_unitor_inverse_a ) ) );
            Assert( 0, IsCongruentForMorphisms( right_unitor_b_op, Opposite( opposite, right_unitor_inverse_b ) ) );
            
        fi;
        
        if CanCompute( cat, "CocartesianAssociatorLeftToRight" ) then
            
            if verbose then
                
                # COVERAGE_IGNORE_NEXT_LINE
                Display( "Testing 'CocartesianAssociatorLeftToRight' ..." );
                
            fi;
            
            associator_left_to_right_abc := CocartesianAssociatorLeftToRight( a, b, c );
            associator_left_to_right_cba := CocartesianAssociatorLeftToRight( c, b, a );
            
            associator_right_to_left_abc_op := CartesianAssociatorRightToLeft( opposite, a_op, b_op, c_op );
            associator_right_to_left_cba_op := CartesianAssociatorRightToLeft( opposite, c_op, b_op, a_op );
            
            Assert( 0, IsCongruentForMorphisms( associator_right_to_left_abc_op, Opposite( opposite, associator_left_to_right_abc ) ) );
            Assert( 0, IsCongruentForMorphisms( associator_right_to_left_cba_op, Opposite( opposite, associator_left_to_right_cba ) ) );
            
        fi;
        
        if CanCompute( cat, "CocartesianAssociatorRightToLeft" ) then
            
            if verbose then
                
                # COVERAGE_IGNORE_NEXT_LINE
                Display( "Testing 'CocartesianAssociatorRightToLeft' ..." );
                
            fi;
            
            associator_right_to_left_abc := CocartesianAssociatorRightToLeft( a, b, c );
            associator_right_to_left_cba := CocartesianAssociatorRightToLeft( c, b, a );
            
            associator_left_to_right_abc_op := CartesianAssociatorLeftToRight( opposite, a_op, b_op, c_op );
            associator_left_to_right_cba_op := CartesianAssociatorLeftToRight( opposite, c_op, b_op, a_op );
            
            Assert( 0, IsCongruentForMorphisms( associator_left_to_right_abc_op, Opposite( opposite, associator_right_to_left_abc ) ) );
            Assert( 0, IsCongruentForMorphisms( associator_left_to_right_cba_op, Opposite( opposite, associator_right_to_left_cba ) ) );
            
        fi;

end );
