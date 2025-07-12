# SPDX-License-Identifier: GPL-2.0-or-later
# MonoidalCategories: Monoidal and monoidal (co)closed categories
#
# Implementations
#

##
InstallMethod( TestMonoidalUnitorsForInvertibility,
               [ IsCapCategory, IsCapCategoryObject ],
               
  function( cat, object )
    local lu, lui, ru, rui, lului, luilu, rurui, ruiru;
    
    Assert( 0, HasIsMonoidalCategory( cat ) and IsMonoidalCategory( cat ) );
    Assert( 0, IsIdenticalObj( cat, CapCategory( object ) ) );
    
    lu := LeftUnitor( object );
    lui := LeftUnitorInverse( object );
    ru := RightUnitor( object );
    rui := RightUnitorInverse( object );
    
    Assert( 0, IsWellDefined( lu ) );
    Assert( 0, IsWellDefined( lui ) );
    Assert( 0, IsWellDefined( ru ) );
    Assert( 0, IsWellDefined( rui ) );
    
    lului := PreCompose( lu, lui );
    luilu := PreCompose( lui, lu );
    rurui := PreCompose( lui, lu );
    ruiru := PreCompose( rui, ru );
    
    Assert( 0, IsWellDefined( lului ) );
    Assert( 0, IsWellDefined( luilu ) );
    Assert( 0, IsWellDefined( rurui ) );
    Assert( 0, IsWellDefined( ruiru ) );
    
    return IsOne( lului ) and
           IsOne( luilu ) and
           IsOne( rurui ) and
           IsOne( ruiru );
    
end );

##
InstallMethod( TestAssociatorForInvertibility,
               [ IsCapCategory, IsCapCategoryObject, IsCapCategoryObject, IsCapCategoryObject ],
               
  function( cat, object_1, object_2, object_3 )
    local a, ai, aai, aia;
    
    Assert( 0, HasIsMonoidalCategory( cat ) and IsMonoidalCategory( cat ) );
    Assert( 0, IsIdenticalObj( cat, CapCategory( object_1 ) ) );
    Assert( 0, IsIdenticalObj( cat, CapCategory( object_2 ) ) );
    Assert( 0, IsIdenticalObj( cat, CapCategory( object_3 ) ) );
    
    a := AssociatorLeftToRight( object_1, object_2, object_3 );
    ai := AssociatorRightToLeft( object_1, object_2, object_3 );
    
    Assert( 0, IsWellDefined( a ) );
    Assert( 0, IsWellDefined( ai ) );
    
    aai := PreCompose( a, ai );
    aia := PreCompose( ai, a );
    
    Assert( 0, IsWellDefined( aai ) );
    Assert( 0, IsWellDefined( aia ) );
    
    return IsOne( aai ) and
           IsOne( aia );
    
end );

##
InstallMethod( TestMonoidalTriangleIdentity,
               [ IsCapCategory, IsCapCategoryObject, IsCapCategoryObject ],
               
  function( cat, object_1, object_2 )
    local morphism_short, morphism_long;
    
    Assert( 0, HasIsMonoidalCategory( cat ) and IsMonoidalCategory( cat ) );
    Assert( 0, IsIdenticalObj( cat, CapCategory( object_1 ) ) );
    Assert( 0, IsIdenticalObj( cat, CapCategory( object_2 ) ) );
    
    morphism_short := TensorProductOnMorphisms( RightUnitor( object_1 ), IdentityMorphism( object_2 ) );
    
    Assert( 0, IsWellDefined( morphism_short ) );
    
    morphism_long := TensorProductOnMorphisms( IdentityMorphism( object_1 ), LeftUnitor( object_2 ) );
    
    Assert( 0, IsWellDefined( morphism_long ) );
    
    morphism_long := PreCompose( AssociatorLeftToRight( object_1, TensorUnit( cat ), object_2 ), morphism_long );
    
    Assert( 0, IsWellDefined( morphism_long ) );
    
    return IsCongruentForMorphisms( morphism_short, morphism_long );
    
end );

##
InstallMethod( TestMonoidalTriangleIdentityForAllPairsInList,
               [ IsCapCategory, IsList ],
               
  function( cat, object_list )
    local a, b, size, list, test, all_okay;
    
    size := Length( object_list );
    
    list := [ 1 .. size ];
    
    all_okay := true;
    
    for a in list do
        
        for b in list do
            
            test := TestMonoidalTriangleIdentity( cat, object_list[a], object_list[b] );
            
            if not test then
                
                Print( "indices of failing pair: ", [ a, b ], "\n" );
                
                return false;
                
            fi;
            
        od;
        
    od;
    
    return all_okay;
    
end );

##
InstallMethod( TestMonoidalPentagonIdentity,
               [ IsCapCategory, IsCapCategoryObject, IsCapCategoryObject, IsCapCategoryObject, IsCapCategoryObject ],
               
  function( cat, object_1, object_2, object_3, object_4 )
    local morphism_long, morphism_short;
    
    morphism_long :=
      TensorProductOnMorphisms( AssociatorLeftToRight( object_1, object_2, object_3 ), IdentityMorphism( object_4 ) );
    
    Assert( 0, IsWellDefined( morphism_long ) );
    
    morphism_long := PreCompose( morphism_long,
      AssociatorLeftToRight( object_1, TensorProductOnObjects( cat, object_2, object_3 ), object_4 ) );
    
    Assert( 0, IsWellDefined( morphism_long ) );
    
    morphism_long := PreCompose( morphism_long,
      TensorProductOnMorphisms( IdentityMorphism( object_1 ), AssociatorLeftToRight( object_2, object_3, object_4 ) ) );
    
    Assert( 0, IsWellDefined( morphism_long ) );
    
    morphism_short := AssociatorLeftToRight( TensorProductOnObjects( cat, object_1, object_2 ), object_3, object_4 );
    
    Assert( 0, IsWellDefined( morphism_short ) );
    
    morphism_short := PreCompose( morphism_short,
      AssociatorLeftToRight( object_1, object_2, TensorProductOnObjects( cat, object_3, object_4 ) ) );
    
    Assert( 0, IsWellDefined( morphism_short ) );
    
    return IsCongruentForMorphisms( morphism_long, morphism_short );
    
end );

##
InstallMethod( TestMonoidalPentagonIdentityUsingWithGivenOperations,
               [ IsCapCategory, IsCapCategoryObject, IsCapCategoryObject, IsCapCategoryObject, IsCapCategoryObject ],
               
  function( cat, object_1, object_2, object_3, object_4 )
    local t12, t12_3, t12_3_4, t34, t12_34, t2_34, t1_2_34, t23, t1_23, t1_23__4, t23_4, t1__23_4,
          assoc_12_3_to_1_23, assoc_23_4_to_2_34, assoc_1_23__4_to_1__23_4, assoc_12_3_4_to_12_34, assoc_12_34_to_1_2_34,
          morphism_long, tensor, morphism_short;
    
    Assert( 0, HasIsMonoidalCategory( cat ) and IsMonoidalCategory( cat ) );
    Assert( 0, IsIdenticalObj( cat, CapCategory( object_1 ) ) );
    Assert( 0, IsIdenticalObj( cat, CapCategory( object_2 ) ) );
    Assert( 0, IsIdenticalObj( cat, CapCategory( object_3 ) ) );
    Assert( 0, IsIdenticalObj( cat, CapCategory( object_4 ) ) );
    
    ## o₁ ⊗ o₂
    t12 := TensorProductOnObjects( cat, object_1, object_2 );
    
    ## (o₁ ⊗ o₂) ⊗ o₃
    t12_3 := TensorProductOnObjects( cat, t12, object_3 );
    
    ## ((o₁ ⊗ o₂) ⊗ o₃) ⊗ o₄
    t12_3_4 := TensorProductOnObjects( cat, t12_3, object_4 );
    
    ## o₃ ⊗ o₄
    t34 := TensorProductOnObjects( cat, object_3, object_4 );
    
    ## (o₁ ⊗ o₂) ⊗ (o₃ ⊗ o₄)
    t12_34 := TensorProductOnObjects( cat, t12, t34 );
    
    ## o₂ ⊗ (o₃ ⊗ o₄)
    t2_34 := TensorProductOnObjects( cat, object_2, t34 );
    
    ## o₁ ⊗ (o₂ ⊗ (o₃ ⊗ o₄))
    t1_2_34 := TensorProductOnObjects( cat, object_1, t2_34 );
    
    ## o₂ ⊗ o₃
    t23 := TensorProductOnObjects( cat, object_2, object_3 );
    
    ## o₁ ⊗ (o₂ ⊗ o₃)
    t1_23 := TensorProductOnObjects( cat, object_1, t23 );
    
    ## (o₁ ⊗ (o₂ ⊗ o₃)) ⊗ o₄
    t1_23__4 := TensorProductOnObjects( cat, t1_23, object_4 );
    
    ## (o₂ ⊗ o₃) ⊗ o₄
    t23_4 := TensorProductOnObjects( cat, t23, object_4 );
    
    ## o₁ ⊗ ((o₂ ⊗ o₃) ⊗ o₄)
    t1__23_4 := TensorProductOnObjects( cat, object_1, t23_4 );
    
    ## (o₁ ⊗ o₂) ⊗ o₃ → o₁ ⊗ (o₂ ⊗ o₃)
    assoc_12_3_to_1_23 := AssociatorLeftToRightWithGivenTensorProducts(
                               t12_3,
                               object_1, object_2, object_3,
                               t1_23 );
    
    Assert( 0, IsWellDefinedForMorphismsWithGivenSourceAndRange( t12_3, assoc_12_3_to_1_23, t1_23 ) );
    
    ## (o₂ ⊗ o₃) ⊗ o₄ → o₂ ⊗ (o₃ ⊗ o₄)
    assoc_23_4_to_2_34 := AssociatorLeftToRightWithGivenTensorProducts(
                               t23_4,
                               object_2, object_3, object_4,
                               t2_34 );
    
    Assert( 0, IsWellDefinedForMorphismsWithGivenSourceAndRange( t23_4, assoc_23_4_to_2_34, t2_34 ) );
    
    ## (o₁ ⊗ (o₂ ⊗ o₃)) ⊗ o₄ → o₁ ⊗ ((o₂ ⊗ o₃) ⊗ o₄)
    assoc_1_23__4_to_1__23_4 := AssociatorLeftToRightWithGivenTensorProducts(
                                     t1_23__4,
                                     object_1, t23, object_2,
                                     t1__23_4 );
    
    Assert( 0, IsWellDefinedForMorphismsWithGivenSourceAndRange( t1_23__4, assoc_1_23__4_to_1__23_4, t1__23_4 ) );
    
    ## ((o₁ ⊗ o₂) ⊗ o₃) ⊗ o₄ → (o₁ ⊗ o₂) ⊗ (o₃ ⊗ o₄)
    assoc_12_3_4_to_12_34 := AssociatorLeftToRightWithGivenTensorProducts(
                                     t12_3_4,
                                     t12, object_3, object_4,
                                     t12_34);
    
    Assert( 0, IsWellDefinedForMorphismsWithGivenSourceAndRange( t12_3_4, assoc_12_3_4_to_12_34, t12_34 ) );
    
    ## (o₁ ⊗ o₂) ⊗ (o₃ ⊗ o₄) → o₁ ⊗ (o₂ ⊗ (o₃ ⊗ o₄))
    assoc_12_34_to_1_2_34 := AssociatorLeftToRightWithGivenTensorProducts(
                                  t12_34,
                                  object_1, object_2, t34,
                                  t1_2_34 );
    
    Assert( 0, IsWellDefinedForMorphismsWithGivenSourceAndRange( t12_34, assoc_12_34_to_1_2_34, t1_2_34 ) );
    
    ## ((o₁ ⊗ o₂) ⊗ o₃) ⊗ o₄ → (o₁ ⊗ (o₂ ⊗ o₃)) ⊗ o₄
    morphism_long := TensorProductOnMorphismsWithGivenTensorProducts(
                             t12_3_4,
                             assoc_12_3_to_1_23, IdentityMorphism( object_4 ),
                             t1_23__4 );
    
    Assert( 0, IsWellDefinedForMorphismsWithGivenSourceAndRange( t12_3_4, morphism_long, t1_23__4 ) );
    
    ## ((o₁ ⊗ o₂) ⊗ o₃) ⊗ o₄ → o₁ ⊗ ((o₂ ⊗ o₃) ⊗ o₄)
    morphism_long := PreCompose( morphism_long, assoc_1_23__4_to_1__23_4 );
    
    Assert( 0, IsWellDefinedForMorphismsWithGivenSourceAndRange( t12_3_4, morphism_long, t1__23_4 ) );
    
    ## o₁ ⊗ ((o₂ ⊗ o₃) ⊗ o₄) → o₁ ⊗ (o₂ ⊗ (o₃ ⊗ o₄))
    tensor := TensorProductOnMorphismsWithGivenTensorProducts(
                      t1__23_4,
                      IdentityMorphism( object_1 ), assoc_23_4_to_2_34,
                      t1_2_34 );
    
    ## ((o₁ ⊗ o₂) ⊗ o₃) ⊗ o₄ → o₁ ⊗ (o₂ ⊗ (o₃ ⊗ o₄))
    morphism_long := PreCompose( morphism_long, tensor );
    
    Assert( 0, IsWellDefinedForMorphismsWithGivenSourceAndRange( t12_3_4, morphism_long, t1_2_34 ) );
    
    ##--##
    
    morphism_short := PreCompose( assoc_12_3_4_to_12_34, assoc_12_34_to_1_2_34 );
    
    Assert( 0, IsWellDefinedForMorphismsWithGivenSourceAndRange( t12_3_4, morphism_short, t1_2_34 ) );
    
    return IsCongruentForMorphisms( morphism_long, morphism_short );
    
end );

##
InstallMethod( TestMonoidalPentagonIdentityForAllQuadruplesInList,
               [ IsCapCategory, IsList ],
               
  function( cat, object_list )
    local a, b, c, d, size, list, test, all_okay;
    
    size := Length( object_list );
    
    list := [ 1 .. size ];
    
    all_okay := true;
    
    for a in list do
        
        for b in list do
            
            for c in list do
                
                for d in list do
                    
                    test := TestMonoidalPentagonIdentity( cat, object_list[a], object_list[b], object_list[c], object_list[d] );
                    
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
        
        if IsEmpty( MissingOperationsForConstructivenessOfCategory( cat, "IsMonoidalCategory" ) ) then
            
            Assert( 0, ForAll( [ a, b, c ], obj -> TestMonoidalUnitorsForInvertibility( cat, obj ) ) );
            
            Assert( 0, TestMonoidalTriangleIdentityForAllPairsInList( cat, [ a, b, c ] ) );
            
            Assert( 0, TestAssociatorForInvertibility( cat, a, b, c ) );
            
            Assert( 0, TestMonoidalPentagonIdentity( cat, a, b, c, b ) );
            
            Assert( 0, TestMonoidalPentagonIdentityUsingWithGivenOperations( cat, a, b, c, b ) );
            
        fi;
        
        if IsEmpty( MissingOperationsForConstructivenessOfCategory( opposite, "IsMonoidalCategory" ) ) then
            
            Assert( 0, ForAll( [ a_op, b_op, c_op ], obj -> TestMonoidalUnitorsForInvertibility( opposite, obj ) ) );
            
            Assert( 0, TestMonoidalTriangleIdentityForAllPairsInList( opposite, [ a_op, b_op, c_op ] ) );
            
            Assert( 0, TestAssociatorForInvertibility( opposite, a_op, b_op, c_op ) );
            
            Assert( 0, TestMonoidalPentagonIdentity( opposite, a_op, b_op, c_op, b_op ) );
            
            Assert( 0, TestMonoidalPentagonIdentityUsingWithGivenOperations( opposite, a_op, b_op, c_op, b_op ) );
            
        fi;
        
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
