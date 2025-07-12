# SPDX-License-Identifier: GPL-2.0-or-later
# CartesianCategories: Cartesian and cocartesian categories and various subdoctrines
#
# Implementations
#
# THIS FILE WAS AUTOMATICALLY GENERATED



##
InstallMethod( TestCocartesianUnitorsForInvertibility,
               [ IsCapCategory, IsCapCategoryObject ],
               
  function( cat, object )
    
    Assert( 0, HasIsCocartesianCategory( cat ) and IsCocartesianCategory( cat ) );
    Assert( 0, IsIdenticalObj( cat, CapCategory( object ) ) );
    
    return IsOne( PreCompose( CocartesianLeftUnitor( object ), CocartesianLeftUnitorInverse( object ) ) ) and
           IsOne( PreCompose( CocartesianLeftUnitorInverse( object ), CocartesianLeftUnitor( object ) ) ) and
           IsOne( PreCompose( CocartesianRightUnitor( object ), CocartesianRightUnitorInverse( object ) ) ) and
           IsOne( PreCompose( CocartesianRightUnitorInverse( object ), CocartesianRightUnitor( object ) ) );
    
end );

##
InstallMethod( TestCocartesianTriangleIdentity,
               [ IsCapCategory, IsCapCategoryObject, IsCapCategoryObject ],
               
  function( cat, object_1, object_2 )
    local morphism_short, morphism_long;
    
    Assert( 0, HasIsCocartesianCategory( cat ) and IsCocartesianCategory( cat ) );
    Assert( 0, IsIdenticalObj( cat, CapCategory( object_1 ) ) );
    Assert( 0, IsIdenticalObj( cat, CapCategory( object_2 ) ) );
    
    morphism_short := CoproductOnMorphisms( CocartesianRightUnitor( object_1 ), IdentityMorphism( object_2 ) );
    
    morphism_long := CoproductOnMorphisms( IdentityMorphism( object_1 ), CocartesianLeftUnitor( object_2 ) );
    
    morphism_long := PreCompose( CocartesianAssociatorLeftToRight( object_1, InitialObject( cat ), object_2 ), morphism_long );
    
    return IsCongruentForMorphisms( morphism_short, morphism_long );
    
end );

##
InstallMethod( TestCocartesianTriangleIdentityForAllPairsInList,
               [ IsCapCategory, IsList ],
               
  function( cat, object_list )
    local a, b, size, list, test, all_okay;
    
    size := Length( object_list );
    
    list := [ 1 .. size ];
    
    all_okay := true;
    
    for a in list do
        
        for b in list do
            
            test := TestCocartesianTriangleIdentity( cat, object_list[a], object_list[b] );
            
            if not test then
                
                Print( "indices of failing pair: ", [ a, b ], "\n" );
                
                return false;
                
            fi;
            
        od;
        
    od;
    
    return all_okay;
    
end );

##
InstallMethod( TestCocartesianPentagonIdentity,
               [ IsCapCategory, IsCapCategoryObject, IsCapCategoryObject, IsCapCategoryObject, IsCapCategoryObject ],
               
  function( cat, object_1, object_2, object_3, object_4 )
    local morphism_long, morphism_short;
    
    morphism_long :=
      CoproductOnMorphisms( CocartesianAssociatorLeftToRight( object_1, object_2, object_3 ), IdentityMorphism( object_4 ) );
    
    morphism_long := PreCompose( morphism_long,
      CocartesianAssociatorLeftToRight( object_1, BinaryCoproduct( cat, object_2, object_3 ), object_4 ) );
    
    morphism_long := PreCompose( morphism_long,
      CoproductOnMorphisms( IdentityMorphism( object_1 ), CocartesianAssociatorLeftToRight( object_2, object_3, object_4 ) ) );
    
    morphism_short := CocartesianAssociatorLeftToRight( BinaryCoproduct( cat, object_1, object_2 ), object_3, object_4 );
    
    morphism_short := PreCompose( morphism_short,
      CocartesianAssociatorLeftToRight( object_1, object_2, BinaryCoproduct( cat, object_3, object_4 ) ) );
    
    return IsCongruentForMorphisms( morphism_long, morphism_short );
    
end );

##
InstallMethod( TestCocartesianPentagonIdentityUsingWithGivenOperations,
               [ IsCapCategory, IsCapCategoryObject, IsCapCategoryObject, IsCapCategoryObject, IsCapCategoryObject ],
               
  function( cat, object_1, object_2, object_3, object_4 )
    local t12, t12_3, t12_3_4, t34, t12_34, t2_34, t1_2_34, t23, t1_23, t1_23__4, t23_4, t1__23_4,
          assoc_12_3_to_1_23, assoc_23_4_to_2_34, assoc_1_23__4_to_1__23_4, assoc_12_3_4_to_12_34, assoc_12_34_to_1_2_34,
          morphism_long, tensor, morphism_short;
    
    Assert( 0, HasIsCocartesianCategory( cat ) and IsCocartesianCategory( cat ) );
    Assert( 0, IsIdenticalObj( cat, CapCategory( object_1 ) ) );
    Assert( 0, IsIdenticalObj( cat, CapCategory( object_2 ) ) );
    Assert( 0, IsIdenticalObj( cat, CapCategory( object_3 ) ) );
    Assert( 0, IsIdenticalObj( cat, CapCategory( object_4 ) ) );
    
    ## o₁ ⊔ o₂
    t12 := BinaryCoproduct( cat, object_1, object_2 );
    
    ## (o₁ ⊔ o₂) ⊔ o₃
    t12_3 := BinaryCoproduct( cat, t12, object_3 );
    
    ## ((o₁ ⊔ o₂) ⊔ o₃) ⊔ o₄
    t12_3_4 := BinaryCoproduct( cat, t12_3, object_4 );
    
    ## o₃ ⊔ o₄
    t34 := BinaryCoproduct( cat, object_3, object_4 );
    
    ## (o₁ ⊔ o₂) ⊔ (o₃ ⊔ o₄)
    t12_34 := BinaryCoproduct( cat, t12, t34 );
    
    ## o₂ ⊔ (o₃ ⊔ o₄)
    t2_34 := BinaryCoproduct( cat, object_2, t34 );
    
    ## o₁ ⊔ (o₂ ⊔ (o₃ ⊔ o₄))
    t1_2_34 := BinaryCoproduct( cat, object_1, t2_34 );
    
    ## o₂ ⊔ o₃
    t23 := BinaryCoproduct( cat, object_2, object_3 );
    
    ## o₁ ⊔ (o₂ ⊔ o₃)
    t1_23 := BinaryCoproduct( cat, object_1, t23 );
    
    ## (o₁ ⊔ (o₂ ⊔ o₃)) ⊔ o₄
    t1_23__4 := BinaryCoproduct( cat, t1_23, object_4 );
    
    ## (o₂ ⊔ o₃) ⊔ o₄
    t23_4 := BinaryCoproduct( cat, t23, object_4 );
    
    ## o₁ ⊔ ((o₂ ⊔ o₃) ⊔ o₄)
    t1__23_4 := BinaryCoproduct( cat, object_1, t23_4 );
    
    ## (o₁ ⊔ o₂) ⊔ o₃ → o₁ ⊔ (o₂ ⊔ o₃)
    assoc_12_3_to_1_23 := CocartesianAssociatorLeftToRightWithGivenCoproducts(
                               t12_3,
                               object_1, object_2, object_3,
                               t1_23 );
    
    Assert( 0, IsWellDefinedForMorphismsWithGivenSourceAndRange( t12_3, assoc_12_3_to_1_23, t1_23 ) );
    
    ## (o₂ ⊔ o₃) ⊔ o₄ → o₂ ⊔ (o₃ ⊔ o₄)
    assoc_23_4_to_2_34 := CocartesianAssociatorLeftToRightWithGivenCoproducts(
                               t23_4,
                               object_2, object_3, object_4,
                               t2_34 );
    
    Assert( 0, IsWellDefinedForMorphismsWithGivenSourceAndRange( t23_4, assoc_23_4_to_2_34, t2_34 ) );
    
    ## (o₁ ⊔ (o₂ ⊔ o₃)) ⊔ o₄ → o₁ ⊔ ((o₂ ⊔ o₃) ⊔ o₄)
    assoc_1_23__4_to_1__23_4 := CocartesianAssociatorLeftToRightWithGivenCoproducts(
                                     t1_23__4,
                                     object_1, t23, object_2,
                                     t1__23_4 );
    
    Assert( 0, IsWellDefinedForMorphismsWithGivenSourceAndRange( t1_23__4, assoc_1_23__4_to_1__23_4, t1__23_4 ) );
    
    ## ((o₁ ⊔ o₂) ⊔ o₃) ⊔ o₄ → (o₁ ⊔ o₂) ⊔ (o₃ ⊔ o₄)
    assoc_12_3_4_to_12_34 := CocartesianAssociatorLeftToRightWithGivenCoproducts(
                                     t12_3_4,
                                     t12, object_3, object_4,
                                     t12_34);
    
    Assert( 0, IsWellDefinedForMorphismsWithGivenSourceAndRange( t12_3_4, assoc_12_3_4_to_12_34, t12_34 ) );
    
    ## (o₁ ⊔ o₂) ⊔ (o₃ ⊔ o₄) → o₁ ⊔ (o₂ ⊔ (o₃ ⊔ o₄))
    assoc_12_34_to_1_2_34 := CocartesianAssociatorLeftToRightWithGivenCoproducts(
                                  t12_34,
                                  object_1, object_2, t34,
                                  t1_2_34 );
    
    Assert( 0, IsWellDefinedForMorphismsWithGivenSourceAndRange( t12_34, assoc_12_34_to_1_2_34, t1_2_34 ) );
    
    ## ((o₁ ⊔ o₂) ⊔ o₃) ⊔ o₄ → (o₁ ⊔ (o₂ ⊔ o₃)) ⊔ o₄
    morphism_long := CoproductOnMorphismsWithGivenCoproducts(
                             t12_3_4,
                             assoc_12_3_to_1_23, IdentityMorphism( object_4 ),
                             t1_23__4 );
    
    Assert( 0, IsWellDefinedForMorphismsWithGivenSourceAndRange( t12_3_4, morphism_long, t1_23__4 ) );
    
    ## ((o₁ ⊔ o₂) ⊔ o₃) ⊔ o₄ → o₁ ⊔ ((o₂ ⊔ o₃) ⊔ o₄)
    morphism_long := PreCompose( morphism_long, assoc_1_23__4_to_1__23_4 );
    
    Assert( 0, IsWellDefinedForMorphismsWithGivenSourceAndRange( t12_3_4, morphism_long, t1__23_4 ) );
    
    ## o₁ ⊔ ((o₂ ⊔ o₃) ⊔ o₄) → o₁ ⊔ (o₂ ⊔ (o₃ ⊔ o₄))
    tensor := CoproductOnMorphismsWithGivenCoproducts(
                      t1__23_4,
                      IdentityMorphism( object_1 ), assoc_23_4_to_2_34,
                      t1_2_34 );
    
    ## ((o₁ ⊔ o₂) ⊔ o₃) ⊔ o₄ → o₁ ⊔ (o₂ ⊔ (o₃ ⊔ o₄))
    morphism_long := PreCompose( morphism_long, tensor );
    
    Assert( 0, IsWellDefinedForMorphismsWithGivenSourceAndRange( t12_3_4, morphism_long, t1_2_34 ) );
    
    ##--##
    
    morphism_short := PreCompose( assoc_12_3_4_to_12_34, assoc_12_34_to_1_2_34 );
    
    Assert( 0, IsWellDefinedForMorphismsWithGivenSourceAndRange( t12_3_4, morphism_short, t1_2_34 ) );
    
    return IsCongruentForMorphisms( morphism_long, morphism_short );
    
end );

##
InstallMethod( TestCocartesianPentagonIdentityForAllQuadruplesInList,
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
                    
                    test := TestCocartesianPentagonIdentity( cat, object_list[a], object_list[b], object_list[c], object_list[d] );
                    
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
        
        if IsEmpty( MissingOperationsForConstructivenessOfCategory( cat, "IsCocartesianCategory" ) ) then
            
            Assert( 0, ForAll( [ a, b, c ], obj -> TestCocartesianUnitorsForInvertibility( cat, obj ) ) );
            
            Assert( 0, TestCocartesianTriangleIdentityForAllPairsInList( cat, [ a, b, c ] ) );
            
            Assert( 0, TestCocartesianPentagonIdentity( cat, a, b, c, b ) );
            
            Assert( 0, TestCocartesianPentagonIdentityUsingWithGivenOperations( cat, a, b, c, b ) );
            
        fi;
        
        if IsEmpty( MissingOperationsForConstructivenessOfCategory( opposite, "IsCocartesianCategory" ) ) then
            
            Assert( 0, ForAll( [ a_op, b_op, c_op ], obj -> TestCocartesianUnitorsForInvertibility( opposite, obj ) ) );
            
            Assert( 0, TestCocartesianTriangleIdentityForAllPairsInList( opposite, [ a_op, b_op, c_op ] ) );
            
            Assert( 0, TestCocartesianPentagonIdentity( opposite, a_op, b_op, c_op, b_op ) );
            
            Assert( 0, TestCocartesianPentagonIdentityUsingWithGivenOperations( opposite, a_op, b_op, c_op, b_op ) );
            
        fi;
        
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
