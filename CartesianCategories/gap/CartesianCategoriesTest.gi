# SPDX-License-Identifier: GPL-2.0-or-later
# CartesianCategories: Cartesian and cocartesian categories and various subdoctrines
#
# Implementations
#
# THIS FILE WAS AUTOMATICALLY GENERATED



##
InstallMethod( TestCartesianUnitorsForInvertibility,
               [ IsCapCategory, IsCapCategoryObject ],
               
  function( cat, object )
    local lu, lui, ru, rui;
    
    Assert( 0, HasIsCartesianCategory( cat ) and IsCartesianCategory( cat ) );
    Assert( 0, IsIdenticalObj( cat, CapCategory( object ) ) );
    
    lu := CartesianLeftUnitor( object );
    lui := CartesianLeftUnitorInverse( object );
    ru := CartesianRightUnitor( object );
    rui := CartesianRightUnitorInverse( object );
    
    return IsOne( PreCompose( lu, lui ) ) and
           IsOne( PreCompose( lui, lu ) ) and
           IsOne( PreCompose( ru, rui ) ) and
           IsOne( PreCompose( rui, ru ) );
    
end );

##
InstallMethod( TestCartesianAssociatorForInvertibility,
               [ IsCapCategory, IsCapCategoryObject, IsCapCategoryObject, IsCapCategoryObject ],
               
  function( cat, object_1, object_2, object_3 )
    local a, ai;
    
    Assert( 0, HasIsCartesianCategory( cat ) and IsCartesianCategory( cat ) );
    Assert( 0, IsIdenticalObj( cat, CapCategory( object_1 ) ) );
    Assert( 0, IsIdenticalObj( cat, CapCategory( object_2 ) ) );
    Assert( 0, IsIdenticalObj( cat, CapCategory( object_3 ) ) );
    
    a := CartesianAssociatorLeftToRight( object_1, object_2, object_3 );
    ai := CartesianAssociatorRightToLeft( object_1, object_2, object_3 );
    
    return IsOne( PreCompose( a, ai ) ) and
           IsOne( PreCompose( ai, a ) );
    
end );

##
InstallMethod( TestCartesianTriangleIdentity,
               [ IsCapCategory, IsCapCategoryObject, IsCapCategoryObject ],
               
  function( cat, object_1, object_2 )
    local morphism_short, morphism_long;
    
    Assert( 0, HasIsCartesianCategory( cat ) and IsCartesianCategory( cat ) );
    Assert( 0, IsIdenticalObj( cat, CapCategory( object_1 ) ) );
    Assert( 0, IsIdenticalObj( cat, CapCategory( object_2 ) ) );
    
    morphism_short := DirectProductOnMorphisms( CartesianRightUnitor( object_1 ), IdentityMorphism( object_2 ) );
    
    morphism_long := DirectProductOnMorphisms( IdentityMorphism( object_1 ), CartesianLeftUnitor( object_2 ) );
    
    morphism_long := PreCompose( CartesianAssociatorLeftToRight( object_1, TerminalObject( cat ), object_2 ), morphism_long );
    
    return IsCongruentForMorphisms( morphism_short, morphism_long );
    
end );

##
InstallMethod( TestCartesianTriangleIdentityForAllPairsInList,
               [ IsCapCategory, IsList ],
               
  function( cat, object_list )
    local a, b, size, list, test, all_okay;
    
    size := Length( object_list );
    
    list := [ 1 .. size ];
    
    all_okay := true;
    
    for a in list do
        
        for b in list do
            
            test := TestCartesianTriangleIdentity( cat, object_list[a], object_list[b] );
            
            if not test then
                
                Print( "indices of failing pair: ", [ a, b ], "\n" );
                
                return false;
                
            fi;
            
        od;
        
    od;
    
    return all_okay;
    
end );

##
InstallMethod( TestCartesianPentagonIdentity,
               [ IsCapCategory, IsCapCategoryObject, IsCapCategoryObject, IsCapCategoryObject, IsCapCategoryObject ],
               
  function( cat, object_1, object_2, object_3, object_4 )
    local morphism_long, morphism_short;
    
    morphism_long :=
      DirectProductOnMorphisms( CartesianAssociatorLeftToRight( object_1, object_2, object_3 ), IdentityMorphism( object_4 ) );
    
    morphism_long := PreCompose( morphism_long,
      CartesianAssociatorLeftToRight( object_1, BinaryDirectProduct( cat, object_2, object_3 ), object_4 ) );
    
    morphism_long := PreCompose( morphism_long,
      DirectProductOnMorphisms( IdentityMorphism( object_1 ), CartesianAssociatorLeftToRight( object_2, object_3, object_4 ) ) );
    
    morphism_short := CartesianAssociatorLeftToRight( BinaryDirectProduct( cat, object_1, object_2 ), object_3, object_4 );
    
    morphism_short := PreCompose( morphism_short,
      CartesianAssociatorLeftToRight( object_1, object_2, BinaryDirectProduct( cat, object_3, object_4 ) ) );
    
    return IsCongruentForMorphisms( morphism_long, morphism_short );
    
end );

##
InstallMethod( TestCartesianPentagonIdentityUsingWithGivenOperations,
               [ IsCapCategory, IsCapCategoryObject, IsCapCategoryObject, IsCapCategoryObject, IsCapCategoryObject ],
               
  function( cat, object_1, object_2, object_3, object_4 )
    local t12, t12_3, t12_3_4, t34, t12_34, t2_34, t1_2_34, t23, t1_23, t1_23__4, t23_4, t1__23_4,
          assoc_12_3_to_1_23, assoc_23_4_to_2_34, assoc_1_23__4_to_1__23_4, assoc_12_3_4_to_12_34, assoc_12_34_to_1_2_34,
          morphism_long, tensor, morphism_short;
    
    Assert( 0, HasIsCartesianCategory( cat ) and IsCartesianCategory( cat ) );
    Assert( 0, IsIdenticalObj( cat, CapCategory( object_1 ) ) );
    Assert( 0, IsIdenticalObj( cat, CapCategory( object_2 ) ) );
    Assert( 0, IsIdenticalObj( cat, CapCategory( object_3 ) ) );
    Assert( 0, IsIdenticalObj( cat, CapCategory( object_4 ) ) );
    
    ## o₁ × o₂
    t12 := BinaryDirectProduct( cat, object_1, object_2 );
    
    ## (o₁ × o₂) × o₃
    t12_3 := BinaryDirectProduct( cat, t12, object_3 );
    
    ## ((o₁ × o₂) × o₃) × o₄
    t12_3_4 := BinaryDirectProduct( cat, t12_3, object_4 );
    
    ## o₃ × o₄
    t34 := BinaryDirectProduct( cat, object_3, object_4 );
    
    ## (o₁ × o₂) × (o₃ × o₄)
    t12_34 := BinaryDirectProduct( cat, t12, t34 );
    
    ## o₂ × (o₃ × o₄)
    t2_34 := BinaryDirectProduct( cat, object_2, t34 );
    
    ## o₁ × (o₂ × (o₃ × o₄))
    t1_2_34 := BinaryDirectProduct( cat, object_1, t2_34 );
    
    ## o₂ × o₃
    t23 := BinaryDirectProduct( cat, object_2, object_3 );
    
    ## o₁ × (o₂ × o₃)
    t1_23 := BinaryDirectProduct( cat, object_1, t23 );
    
    ## (o₁ × (o₂ × o₃)) × o₄
    t1_23__4 := BinaryDirectProduct( cat, t1_23, object_4 );
    
    ## (o₂ × o₃) × o₄
    t23_4 := BinaryDirectProduct( cat, t23, object_4 );
    
    ## o₁ × ((o₂ × o₃) × o₄)
    t1__23_4 := BinaryDirectProduct( cat, object_1, t23_4 );
    
    ## (o₁ × o₂) × o₃ → o₁ × (o₂ × o₃)
    assoc_12_3_to_1_23 := CartesianAssociatorLeftToRightWithGivenDirectProducts(
                               t12_3,
                               object_1, object_2, object_3,
                               t1_23 );
    
    Assert( 0, IsWellDefinedForMorphismsWithGivenSourceAndRange( t12_3, assoc_12_3_to_1_23, t1_23 ) );
    
    ## (o₂ × o₃) × o₄ → o₂ × (o₃ × o₄)
    assoc_23_4_to_2_34 := CartesianAssociatorLeftToRightWithGivenDirectProducts(
                               t23_4,
                               object_2, object_3, object_4,
                               t2_34 );
    
    Assert( 0, IsWellDefinedForMorphismsWithGivenSourceAndRange( t23_4, assoc_23_4_to_2_34, t2_34 ) );
    
    ## (o₁ × (o₂ × o₃)) × o₄ → o₁ × ((o₂ × o₃) × o₄)
    assoc_1_23__4_to_1__23_4 := CartesianAssociatorLeftToRightWithGivenDirectProducts(
                                     t1_23__4,
                                     object_1, t23, object_2,
                                     t1__23_4 );
    
    Assert( 0, IsWellDefinedForMorphismsWithGivenSourceAndRange( t1_23__4, assoc_1_23__4_to_1__23_4, t1__23_4 ) );
    
    ## ((o₁ × o₂) × o₃) × o₄ → (o₁ × o₂) × (o₃ × o₄)
    assoc_12_3_4_to_12_34 := CartesianAssociatorLeftToRightWithGivenDirectProducts(
                                     t12_3_4,
                                     t12, object_3, object_4,
                                     t12_34);
    
    Assert( 0, IsWellDefinedForMorphismsWithGivenSourceAndRange( t12_3_4, assoc_12_3_4_to_12_34, t12_34 ) );
    
    ## (o₁ × o₂) × (o₃ × o₄) → o₁ × (o₂ × (o₃ × o₄))
    assoc_12_34_to_1_2_34 := CartesianAssociatorLeftToRightWithGivenDirectProducts(
                                  t12_34,
                                  object_1, object_2, t34,
                                  t1_2_34 );
    
    Assert( 0, IsWellDefinedForMorphismsWithGivenSourceAndRange( t12_34, assoc_12_34_to_1_2_34, t1_2_34 ) );
    
    ## ((o₁ × o₂) × o₃) × o₄ → (o₁ × (o₂ × o₃)) × o₄
    morphism_long := DirectProductOnMorphismsWithGivenDirectProducts(
                             t12_3_4,
                             assoc_12_3_to_1_23, IdentityMorphism( object_4 ),
                             t1_23__4 );
    
    Assert( 0, IsWellDefinedForMorphismsWithGivenSourceAndRange( t12_3_4, morphism_long, t1_23__4 ) );
    
    ## ((o₁ × o₂) × o₃) × o₄ → o₁ × ((o₂ × o₃) × o₄)
    morphism_long := PreCompose( morphism_long, assoc_1_23__4_to_1__23_4 );
    
    Assert( 0, IsWellDefinedForMorphismsWithGivenSourceAndRange( t12_3_4, morphism_long, t1__23_4 ) );
    
    ## o₁ × ((o₂ × o₃) × o₄) → o₁ × (o₂ × (o₃ × o₄))
    tensor := DirectProductOnMorphismsWithGivenDirectProducts(
                      t1__23_4,
                      IdentityMorphism( object_1 ), assoc_23_4_to_2_34,
                      t1_2_34 );
    
    ## ((o₁ × o₂) × o₃) × o₄ → o₁ × (o₂ × (o₃ × o₄))
    morphism_long := PreCompose( morphism_long, tensor );
    
    Assert( 0, IsWellDefinedForMorphismsWithGivenSourceAndRange( t12_3_4, morphism_long, t1_2_34 ) );
    
    ##--##
    
    morphism_short := PreCompose( assoc_12_3_4_to_12_34, assoc_12_34_to_1_2_34 );
    
    Assert( 0, IsWellDefinedForMorphismsWithGivenSourceAndRange( t12_3_4, morphism_short, t1_2_34 ) );
    
    return IsCongruentForMorphisms( morphism_long, morphism_short );
    
end );

##
InstallMethod( TestCartesianPentagonIdentityForAllQuadruplesInList,
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
                    
                    test := TestCartesianPentagonIdentity( cat, object_list[a], object_list[b], object_list[c], object_list[d] );
                    
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
InstallGlobalFunction( "CartesianCategoriesTest",
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
        
        if IsEmpty( MissingOperationsForConstructivenessOfCategory( cat, "IsCartesianCategory" ) ) then
            
            Assert( 0, ForAll( [ a, b, c ], obj -> TestCartesianUnitorsForInvertibility( cat, obj ) ) );
            
            Assert( 0, TestCartesianTriangleIdentityForAllPairsInList( cat, [ a, b, c ] ) );
            
            Assert( 0, TestCartesianAssociatorForInvertibility( cat, a, b, c ) );
            
            Assert( 0, TestCartesianPentagonIdentity( cat, a, b, c, b ) );
            
            Assert( 0, TestCartesianPentagonIdentityUsingWithGivenOperations( cat, a, b, c, b ) );
            
        fi;
        
        if IsEmpty( MissingOperationsForConstructivenessOfCategory( opposite, "IsCartesianCategory" ) ) then
            
            Assert( 0, ForAll( [ a_op, b_op, c_op ], obj -> TestCartesianUnitorsForInvertibility( opposite, obj ) ) );
            
            Assert( 0, TestCartesianTriangleIdentityForAllPairsInList( opposite, [ a_op, b_op, c_op ] ) );
            
            Assert( 0, TestCartesianAssociatorForInvertibility( opposite, a_op, b_op, c_op ) );
            
            Assert( 0, TestCartesianPentagonIdentity( opposite, a_op, b_op, c_op, b_op ) );
            
            Assert( 0, TestCartesianPentagonIdentityUsingWithGivenOperations( opposite, a_op, b_op, c_op, b_op ) );
            
        fi;
        
        if CanCompute( cat, "DirectProductOnMorphisms" ) then
            
            if verbose then
                
                # COVERAGE_IGNORE_NEXT_LINE
                Display( "Testing 'DirectProductOnMorphisms' ..." );
                
            fi;
            
            alpha_tensor_beta := DirectProductOnMorphisms( alpha, beta );
            beta_tensor_alpha := DirectProductOnMorphisms( beta, alpha );
            
            alpha_tensor_beta_op := CoproductOnMorphisms( opposite, alpha_op, beta_op );
            beta_tensor_alpha_op := CoproductOnMorphisms( opposite, beta_op, alpha_op );
            
            Assert( 0, IsCongruentForMorphisms( alpha_tensor_beta_op, Opposite( opposite, alpha_tensor_beta ) ) );
            Assert( 0, IsCongruentForMorphisms( beta_tensor_alpha_op, Opposite( opposite, beta_tensor_alpha ) ) );
            
            # Opposite must be self-inverse
            
            Assert( 0, IsCongruentForMorphisms( alpha_tensor_beta, Opposite( alpha_tensor_beta_op ) ) );
            Assert( 0, IsCongruentForMorphisms( beta_tensor_alpha, Opposite( beta_tensor_alpha_op ) ) );
            
        fi;
        
        if CanCompute( cat, "CartesianLeftUnitor" ) then
            
            if verbose then
                
                # COVERAGE_IGNORE_NEXT_LINE
                Display( "Testing 'CartesianLeftUnitor' ..." );
                
            fi;
            
            left_unitor_a := CartesianLeftUnitor( a );
            left_unitor_b := CartesianLeftUnitor( b );
            
            left_unitor_inverse_a_op := CocartesianLeftUnitorInverse( opposite, a_op );
            left_unitor_inverse_b_op := CocartesianLeftUnitorInverse( opposite, b_op );
            
            Assert( 0, IsCongruentForMorphisms( left_unitor_inverse_a_op, Opposite( opposite, left_unitor_a ) ) );
            Assert( 0, IsCongruentForMorphisms( left_unitor_inverse_b_op, Opposite( opposite, left_unitor_b ) ) );
            
        fi;
        
        if CanCompute( cat, "CartesianRightUnitor" ) then
            
            if verbose then
                
                # COVERAGE_IGNORE_NEXT_LINE
                Display( "Testing 'CartesianRightUnitor' ..." );
                
            fi;
            
            right_unitor_a := CartesianRightUnitor( a );
            right_unitor_b := CartesianRightUnitor( b );
            
            right_unitor_inverse_a_op := CocartesianRightUnitorInverse( opposite, a_op );
            right_unitor_inverse_b_op := CocartesianRightUnitorInverse( opposite, b_op );
            
            Assert( 0, IsCongruentForMorphisms( right_unitor_inverse_a_op, Opposite( opposite, right_unitor_a ) ) );
            Assert( 0, IsCongruentForMorphisms( right_unitor_inverse_b_op, Opposite( opposite, right_unitor_b ) ) );
            
        fi;
        
        if CanCompute( cat, "CartesianLeftUnitorInverse" ) then
            
            if verbose then
                
                # COVERAGE_IGNORE_NEXT_LINE
                Display( "Testing 'CartesianLeftUnitorInverse' ..." );
                
            fi;
            
            left_unitor_inverse_a := CartesianLeftUnitorInverse( a );
            left_unitor_inverse_b := CartesianLeftUnitorInverse( b );
            
            left_unitor_a_op := CocartesianLeftUnitor( opposite, a_op );
            left_unitor_b_op := CocartesianLeftUnitor( opposite, b_op );
            
            Assert( 0, IsCongruentForMorphisms( left_unitor_a_op, Opposite( opposite, left_unitor_inverse_a ) ) );
            Assert( 0, IsCongruentForMorphisms( left_unitor_b_op, Opposite( opposite, left_unitor_inverse_b ) ) );
            
        fi;
        
        if CanCompute( cat, "CartesianRightUnitorInverse" ) then
            
            if verbose then
                
                # COVERAGE_IGNORE_NEXT_LINE
                Display( "Testing 'CartesianRightUnitorInverse' ..." );
                
            fi;
            
            right_unitor_inverse_a := CartesianRightUnitorInverse( a );
            right_unitor_inverse_b := CartesianRightUnitorInverse( b );
            
            right_unitor_a_op := CocartesianRightUnitor( opposite, a_op );
            right_unitor_b_op := CocartesianRightUnitor( opposite, b_op );
            
            Assert( 0, IsCongruentForMorphisms( right_unitor_a_op, Opposite( opposite, right_unitor_inverse_a ) ) );
            Assert( 0, IsCongruentForMorphisms( right_unitor_b_op, Opposite( opposite, right_unitor_inverse_b ) ) );
            
        fi;
        
        if CanCompute( cat, "CartesianAssociatorLeftToRight" ) then
            
            if verbose then
                
                # COVERAGE_IGNORE_NEXT_LINE
                Display( "Testing 'CartesianAssociatorLeftToRight' ..." );
                
            fi;
            
            associator_left_to_right_abc := CartesianAssociatorLeftToRight( a, b, c );
            associator_left_to_right_cba := CartesianAssociatorLeftToRight( c, b, a );
            
            associator_right_to_left_abc_op := CocartesianAssociatorRightToLeft( opposite, a_op, b_op, c_op );
            associator_right_to_left_cba_op := CocartesianAssociatorRightToLeft( opposite, c_op, b_op, a_op );
            
            Assert( 0, IsCongruentForMorphisms( associator_right_to_left_abc_op, Opposite( opposite, associator_left_to_right_abc ) ) );
            Assert( 0, IsCongruentForMorphisms( associator_right_to_left_cba_op, Opposite( opposite, associator_left_to_right_cba ) ) );
            
        fi;
        
        if CanCompute( cat, "CartesianAssociatorRightToLeft" ) then
            
            if verbose then
                
                # COVERAGE_IGNORE_NEXT_LINE
                Display( "Testing 'CartesianAssociatorRightToLeft' ..." );
                
            fi;
            
            associator_right_to_left_abc := CartesianAssociatorRightToLeft( a, b, c );
            associator_right_to_left_cba := CartesianAssociatorRightToLeft( c, b, a );
            
            associator_left_to_right_abc_op := CocartesianAssociatorLeftToRight( opposite, a_op, b_op, c_op );
            associator_left_to_right_cba_op := CocartesianAssociatorLeftToRight( opposite, c_op, b_op, a_op );
            
            Assert( 0, IsCongruentForMorphisms( associator_left_to_right_abc_op, Opposite( opposite, associator_right_to_left_abc ) ) );
            Assert( 0, IsCongruentForMorphisms( associator_left_to_right_cba_op, Opposite( opposite, associator_right_to_left_cba ) ) );
            
        fi;

end );
