# SPDX-License-Identifier: GPL-2.0-or-later
# MonoidalCategories: Monoidal and monoidal (co)closed categories
#
# Implementations
#

##
InstallMethod( TestMonoidalPentagonIdentity,
               [ IsCapCategoryObject, IsCapCategoryObject, IsCapCategoryObject, IsCapCategoryObject ],
               
  function( object_a, object_b, object_c, object_d )
    local morphism_1, morphism_2;
    
    morphism_1 :=
      TensorProductOnMorphisms( AssociatorLeftToRight( object_a, object_b, object_c ), IdentityMorphism( object_d ) );
    
    morphism_1 := PreCompose( morphism_1,
      AssociatorLeftToRight( object_a, TensorProductOnObjects( object_b, object_c ), object_d ) );
    
    morphism_1 := PreCompose( morphism_1,
      TensorProductOnMorphisms( IdentityMorphism( object_a ), AssociatorLeftToRight( object_b, object_c, object_d ) ) );
    
    morphism_2 := AssociatorLeftToRight( TensorProductOnObjects( object_a, object_b ), object_c, object_d );
    
    morphism_2 := PreCompose( morphism_2,
      AssociatorLeftToRight( object_a, object_b, TensorProductOnObjects( object_c, object_d ) ) );
    
    return IsCongruentForMorphisms( morphism_1, morphism_2 );
    
end );

##
InstallMethod( TestMonoidalPentagonIdentityForAllQuadruplesInList,
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
                    
                    test := TestMonoidalPentagonIdentity( object_list[a], object_list[b], object_list[c], object_list[d] );
                    
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
InstallGlobalFunction( "MonoidalCategoriesTest",
    
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
        
        if CanCompute( cat, "TensorProductOnMorphisms" ) then
            
            if verbose then
                
                # COVERAGE_IGNORE_NEXT_LINE
                Display( "Testing 'TensorProductOnMorphisms' ..." );
                
            fi;
            
            alpha_tensor_beta := TensorProductOnMorphisms( alpha, beta );
            beta_tensor_alpha := TensorProductOnMorphisms( beta, alpha );
            
            alpha_tensor_beta_op := TensorProductOnMorphisms( opposite, alpha_op, beta_op );
            beta_tensor_alpha_op := TensorProductOnMorphisms( opposite, beta_op, alpha_op );
            
            Assert( 0, IsCongruentForMorphisms( alpha_tensor_beta_op, Opposite( opposite, alpha_tensor_beta ) ) );
            Assert( 0, IsCongruentForMorphisms( beta_tensor_alpha_op, Opposite( opposite, beta_tensor_alpha ) ) );
            
            # Opposite must be self-inverse
            
            Assert( 0, IsCongruentForMorphisms( alpha_tensor_beta, Opposite( alpha_tensor_beta_op ) ) );
            Assert( 0, IsCongruentForMorphisms( beta_tensor_alpha, Opposite( beta_tensor_alpha_op ) ) );
            
        fi;
        
        if CanCompute( cat, "LeftUnitor" ) then
            
            if verbose then
                
                # COVERAGE_IGNORE_NEXT_LINE
                Display( "Testing 'LeftUnitor' ..." );
                
            fi;
            
            left_unitor_a := LeftUnitor( a );
            left_unitor_b := LeftUnitor( b );
            
            left_unitor_inverse_a_op := LeftUnitorInverse( opposite, a_op );
            left_unitor_inverse_b_op := LeftUnitorInverse( opposite, b_op );
            
            Assert( 0, IsCongruentForMorphisms( left_unitor_inverse_a_op, Opposite( opposite, left_unitor_a ) ) );
            Assert( 0, IsCongruentForMorphisms( left_unitor_inverse_b_op, Opposite( opposite, left_unitor_b ) ) );
            
        fi;
        
        if CanCompute( cat, "RightUnitor" ) then
            
            if verbose then
                
                # COVERAGE_IGNORE_NEXT_LINE
                Display( "Testing 'RightUnitor' ..." );
                
            fi;
            
            right_unitor_a := RightUnitor( a );
            right_unitor_b := RightUnitor( b );
            
            right_unitor_inverse_a_op := RightUnitorInverse( opposite, a_op );
            right_unitor_inverse_b_op := RightUnitorInverse( opposite, b_op );
            
            Assert( 0, IsCongruentForMorphisms( right_unitor_inverse_a_op, Opposite( opposite, right_unitor_a ) ) );
            Assert( 0, IsCongruentForMorphisms( right_unitor_inverse_b_op, Opposite( opposite, right_unitor_b ) ) );
            
        fi;
        
        if CanCompute( cat, "LeftUnitorInverse" ) then
            
            if verbose then
                
                # COVERAGE_IGNORE_NEXT_LINE
                Display( "Testing 'LeftUnitorInverse' ..." );
                
            fi;
            
            left_unitor_inverse_a := LeftUnitorInverse( a );
            left_unitor_inverse_b := LeftUnitorInverse( b );
            
            left_unitor_a_op := LeftUnitor( opposite, a_op );
            left_unitor_b_op := LeftUnitor( opposite, b_op );
            
            Assert( 0, IsCongruentForMorphisms( left_unitor_a_op, Opposite( opposite, left_unitor_inverse_a ) ) );
            Assert( 0, IsCongruentForMorphisms( left_unitor_b_op, Opposite( opposite, left_unitor_inverse_b ) ) );
            
        fi;
        
        if CanCompute( cat, "RightUnitorInverse" ) then
            
            if verbose then
                
                # COVERAGE_IGNORE_NEXT_LINE
                Display( "Testing 'RightUnitorInverse' ..." );
                
            fi;
            
            right_unitor_inverse_a := RightUnitorInverse( a );
            right_unitor_inverse_b := RightUnitorInverse( b );
            
            right_unitor_a_op := RightUnitor( opposite, a_op );
            right_unitor_b_op := RightUnitor( opposite, b_op );
            
            Assert( 0, IsCongruentForMorphisms( right_unitor_a_op, Opposite( opposite, right_unitor_inverse_a ) ) );
            Assert( 0, IsCongruentForMorphisms( right_unitor_b_op, Opposite( opposite, right_unitor_inverse_b ) ) );
            
        fi;
        
        if CanCompute( cat, "AssociatorLeftToRight" ) then
            
            if verbose then
                
                # COVERAGE_IGNORE_NEXT_LINE
                Display( "Testing 'AssociatorLeftToRight' ..." );
                
            fi;
            
            associator_left_to_right_abc := AssociatorLeftToRight( a, b, c );
            associator_left_to_right_cba := AssociatorLeftToRight( c, b, a );
            
            associator_right_to_left_abc_op := AssociatorRightToLeft( opposite, a_op, b_op, c_op );
            associator_right_to_left_cba_op := AssociatorRightToLeft( opposite, c_op, b_op, a_op );
            
            Assert( 0, IsCongruentForMorphisms( associator_right_to_left_abc_op, Opposite( opposite, associator_left_to_right_abc ) ) );
            Assert( 0, IsCongruentForMorphisms( associator_right_to_left_cba_op, Opposite( opposite, associator_left_to_right_cba ) ) );
            
        fi;
        
        if CanCompute( cat, "AssociatorRightToLeft" ) then
            
            if verbose then
                
                # COVERAGE_IGNORE_NEXT_LINE
                Display( "Testing 'AssociatorRightToLeft' ..." );
                
            fi;
            
            associator_right_to_left_abc := AssociatorRightToLeft( a, b, c );
            associator_right_to_left_cba := AssociatorRightToLeft( c, b, a );
            
            associator_left_to_right_abc_op := AssociatorLeftToRight( opposite, a_op, b_op, c_op );
            associator_left_to_right_cba_op := AssociatorLeftToRight( opposite, c_op, b_op, a_op );
            
            Assert( 0, IsCongruentForMorphisms( associator_left_to_right_abc_op, Opposite( opposite, associator_right_to_left_abc ) ) );
            Assert( 0, IsCongruentForMorphisms( associator_left_to_right_cba_op, Opposite( opposite, associator_right_to_left_cba ) ) );
            
        fi;

end );
