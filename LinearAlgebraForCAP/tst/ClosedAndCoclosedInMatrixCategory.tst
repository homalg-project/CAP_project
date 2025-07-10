#################################################################################################
# Test the correspondences between the closed and coclosed structure of the category of matrices
#################################################################################################

gap> START_TEST("ClosedAndCoclosedInMatrixCategory.tst");

gap> LoadPackage( "LinearAlgebraForCAP", false );
true

gap> Q := HomalgFieldOfRationals();;
gap> mc := MatrixCategory( Q );;

##############################################################
# Tensor, Hom and Cohom on objects
##############################################################

# Tensor objects and internal (co)homs

gap> a := MatrixCategoryObject( mc, 2 );;
gap> b := MatrixCategoryObject( mc, 3 );;
gap> c := MatrixCategoryObject( mc, 6 );;
gap> d := MatrixCategoryObject( mc, 4 );;

gap> z := ZeroObject( mc );;
gap> u := TensorUnit( mc );;

gap> a_tensor_b := TensorProductOnObjects( a, b );;
gap> b_tensor_a := TensorProductOnObjects( b, a );;
gap> c_tensor_d := TensorProductOnObjects( c, d );;
gap> d_tensor_c := TensorProductOnObjects( d, c );;

gap> 0_tensor_a := TensorProductOnObjects( z, a );;
gap> a_tensor_0 := TensorProductOnObjects( a, z );;

gap> hom_ab := InternalHomOnObjects( a, b );;
gap> hom_ba := InternalHomOnObjects( b, a );;
gap> hom_cd := InternalHomOnObjects( c, d );;
gap> hom_dc := InternalHomOnObjects( d, c );;

gap> hom_0a := InternalHomOnObjects( z, a );;
gap> hom_a0 := InternalHomOnObjects( a, z );;

gap> cohom_ab := InternalCoHomOnObjects( a, b );;
gap> cohom_ba := InternalCoHomOnObjects( b, a );;
gap> cohom_cd := InternalCoHomOnObjects( c, d );;
gap> cohom_dc := InternalCoHomOnObjects( d, c );;

gap> cohom_0a := InternalCoHomOnObjects( z, a );;
gap> cohom_a0 := InternalCoHomOnObjects( a, z );;

# Correspondence on internal (co)homs

gap> hom_ab = cohom_ba;
true
gap> hom_ba = cohom_ab;
true
gap> hom_cd = cohom_dc;
true
gap> hom_dc = cohom_cd;
true

gap> hom_0a = cohom_a0;
true
gap> hom_a0 = cohom_0a;
true

gap> hom_ab = hom_cd;
false
gap> hom_ab = hom_dc;
false
gap> hom_ab = cohom_cd;
false
gap> hom_ab = cohom_dc;
false

# Correspondence with convenience methods

gap> a_tensor_b = TensorProduct( a, b );
true
gap> b_tensor_a = TensorProduct( b, a );
true
gap> c_tensor_d = TensorProduct( c, d );
true
gap> d_tensor_c = TensorProduct( d, c );
true

gap> a = TensorProductOp( [ a ], a ); # Special case in TensorProductOp
true
gap> b = TensorProductOp( [ b ], b ); # Special case in TensorProductOp
true

gap> hom_ab = InternalCoHom( b, a );
true
gap> hom_ba = InternalCoHom( a, b );
true
gap> hom_cd = InternalCoHom( d, c );
true
gap> hom_dc = InternalCoHom( c, d);
true

gap> hom_0a = InternalCoHom( a, z );
true
gap> hom_a0 = InternalCoHom( z, a );
true

gap> cohom_ab = InternalHom( b, a );
true
gap> cohom_ba = InternalHom( a, b );
true
gap> cohom_cd = InternalHom( d, c );
true
gap> cohom_dc = InternalHom( c, d);
true

gap> cohom_0a = InternalHom( a, z );
true
gap> cohom_a0 = InternalHom( z, a );
true

################################################################
# Tensor, Hom and CoHom on morphisms
################################################################

# Morphisms

gap> id_a := IdentityMorphism( a );;
gap> id_b := IdentityMorphism( b );;

gap> alpha := VectorSpaceMorphism( a, HomalgMatrix( [ 2 .. 7 ], 2, 3, Q ), b );;
gap> beta := VectorSpaceMorphism( c, HomalgMatrix( [ 8 .. 31 ], 6, 4, Q ), d );;
gap> gamma := VectorSpaceMorphism( b, HomalgMatrix( [ -8 .. 9 ], 3, 6, Q ), c );;

gap> alpha_gamma := PreCompose( alpha, gamma );;
gap> gamma_beta := PreCompose( gamma, beta );;
gap> alpha_gamma_beta := PreCompose( [ alpha, gamma, beta ] );;

gap> alpha_tensor_beta := TensorProductOnMorphisms( alpha, beta );;
gap> beta_tensor_alpha := TensorProductOnMorphisms( beta, alpha );;

gap> hom_alpha_id_a := InternalHomOnMorphisms( alpha, id_a );;
gap> hom_alpha_id_b := InternalHomOnMorphisms( alpha, id_b );;
gap> hom_id_a_alpha := InternalHomOnMorphisms( id_a, alpha );;
gap> hom_id_b_alpha := InternalHomOnMorphisms( id_b, alpha );;

gap> hom_alpha_beta := InternalHomOnMorphisms( alpha, beta );;
gap> hom_beta_alpha := InternalHomOnMorphisms( beta, alpha );;

gap> cohom_alpha_id_a := InternalCoHomOnMorphisms( alpha, id_a );;
gap> cohom_alpha_id_b := InternalCoHomOnMorphisms( alpha, id_b );;
gap> cohom_id_a_alpha := InternalCoHomOnMorphisms( id_a, alpha );;
gap> cohom_id_b_alpha := InternalCoHomOnMorphisms( id_b, alpha );;

gap> cohom_alpha_beta := InternalCoHomOnMorphisms( alpha, beta );;
gap> cohom_beta_alpha := InternalCoHomOnMorphisms( beta, alpha );;

gap> alpha_transposed := VectorSpaceMorphism( b, TransposedMatrix( UnderlyingMatrix( alpha ) ), a );;
gap> beta_transposed := VectorSpaceMorphism( d, TransposedMatrix( UnderlyingMatrix( beta ) ), c );;

gap> alpha_tensor_beta_transposed := TensorProductOnMorphisms( alpha_transposed, beta_transposed );;
gap> beta_tensor_alpha_transposed := TensorProductOnMorphisms( beta_transposed, alpha_transposed );;

gap> hom_alpha_beta_transposed := InternalHomOnMorphisms( alpha_transposed, beta_transposed );;
gap> hom_beta_alpha_transposed := InternalHomOnMorphisms( beta_transposed, alpha_transposed );;

gap> cohom_alpha_beta_transposed := InternalCoHomOnMorphisms( alpha_transposed, beta_transposed );;
gap> cohom_beta_alpha_transposed := InternalCoHomOnMorphisms( beta_transposed, alpha_transposed );;

# Correspondence on internal (co)homs

gap> hom_alpha_beta = cohom_beta_alpha;
true
gap> hom_beta_alpha = cohom_alpha_beta;
true

gap> hom_alpha_beta = cohom_alpha_beta;
false
gap> hom_alpha_beta = hom_beta_alpha;
false
gap> hom_alpha_beta = hom_beta_alpha;
false

gap> cohom_alpha_beta = cohom_beta_alpha;
false
gap> cohom_alpha_beta = cohom_beta_alpha;
false

# Correspondence with convenience methods

gap> alpha_tensor_beta = TensorProduct( alpha, beta );
true
gap> beta_tensor_alpha = TensorProduct( beta, alpha );
true

gap> alpha = TensorProductOp( [ alpha ], alpha ); # Special case in TensorProductOp
true
gap> beta = TensorProductOp( [ beta ], beta ); # Special case in TensorProductOp
true

gap> hom_alpha_beta = InternalCoHom( beta, alpha );
true
gap> hom_beta_alpha = InternalCoHom( alpha, beta );
true

gap> cohom_alpha_beta = InternalHom( beta, alpha );
true
gap> cohom_beta_alpha = InternalHom( alpha, beta );
true

gap> hom_alpha_id_a = InternalHom( alpha, a );
true
gap> hom_alpha_id_b = InternalHom( alpha, b );
true
gap> hom_id_a_alpha = InternalHom( a, alpha );
true
gap> hom_id_b_alpha = InternalHom( b, alpha );
true

gap> cohom_alpha_id_a = InternalCoHom( alpha, a );
true
gap> cohom_alpha_id_b = InternalCoHom( alpha, b );
true
gap> cohom_id_a_alpha = InternalCoHom( a, alpha );
true
gap> cohom_id_b_alpha = InternalCoHom( b, alpha );
true

######################################################
# Unitors
######################################################

# Unitors

gap> left_unitor_a := LeftUnitor( a );;
gap> left_unitor_b := LeftUnitor( b );;
gap> left_unitor_c := LeftUnitor( c );;
gap> left_unitor_d := LeftUnitor( d );;

gap> right_unitor_a := RightUnitor( a );;
gap> right_unitor_b := RightUnitor( b );;
gap> right_unitor_c := RightUnitor( c );;
gap> right_unitor_d := RightUnitor( d );;

# Inverse unitors

gap> left_unitor_inverse_a := LeftUnitorInverse( a );;
gap> left_unitor_inverse_b := LeftUnitorInverse( b );;
gap> left_unitor_inverse_c := LeftUnitorInverse( c );;
gap> left_unitor_inverse_d := LeftUnitorInverse( d );;

gap> right_unitor_inverse_a := RightUnitorInverse( a );;
gap> right_unitor_inverse_b := RightUnitorInverse( b );;
gap> right_unitor_inverse_c := RightUnitorInverse( c );;
gap> right_unitor_inverse_d := RightUnitorInverse( d );;

# Opposite correspondence

gap> UnderlyingMatrix( left_unitor_a ) = TransposedMatrix( UnderlyingMatrix( left_unitor_inverse_a ) );
true
gap> UnderlyingMatrix( left_unitor_b ) = TransposedMatrix( UnderlyingMatrix( left_unitor_inverse_b ) );
true
gap> UnderlyingMatrix( left_unitor_c ) = TransposedMatrix( UnderlyingMatrix( left_unitor_inverse_c ) );
true
gap> UnderlyingMatrix( left_unitor_d ) = TransposedMatrix( UnderlyingMatrix( left_unitor_inverse_d ) );
true

gap> UnderlyingMatrix( right_unitor_a ) = TransposedMatrix( UnderlyingMatrix( right_unitor_inverse_a ) ) ;
true
gap> UnderlyingMatrix( right_unitor_b ) = TransposedMatrix( UnderlyingMatrix( right_unitor_inverse_b ) ) ;
true
gap> UnderlyingMatrix( right_unitor_c ) = TransposedMatrix( UnderlyingMatrix( right_unitor_inverse_c ) ) ;
true
gap> UnderlyingMatrix( right_unitor_d ) = TransposedMatrix( UnderlyingMatrix( right_unitor_inverse_d ) ) ;
true

gap> UnderlyingMatrix( left_unitor_b ) = TransposedMatrix( UnderlyingMatrix( left_unitor_inverse_a ) );
false
gap> UnderlyingMatrix( left_unitor_b ) = TransposedMatrix( UnderlyingMatrix( left_unitor_inverse_c ) );
false
gap> UnderlyingMatrix( left_unitor_b ) = TransposedMatrix( UnderlyingMatrix( left_unitor_inverse_d ) );
false

gap> UnderlyingMatrix( left_unitor_inverse_c ) = TransposedMatrix( UnderlyingMatrix( left_unitor_a ) );
false
gap> UnderlyingMatrix( left_unitor_inverse_c ) = TransposedMatrix( UnderlyingMatrix( left_unitor_b ) );
false
gap> UnderlyingMatrix( left_unitor_inverse_c ) = TransposedMatrix( UnderlyingMatrix( left_unitor_d ) );
false

gap> UnderlyingMatrix( right_unitor_a ) = TransposedMatrix( UnderlyingMatrix( right_unitor_inverse_b ) ) ;
false
gap> UnderlyingMatrix( right_unitor_a ) = TransposedMatrix( UnderlyingMatrix( right_unitor_inverse_c ) ) ;
false
gap> UnderlyingMatrix( right_unitor_a ) = TransposedMatrix( UnderlyingMatrix( right_unitor_inverse_d ) ) ;
false

gap> UnderlyingMatrix( right_unitor_inverse_d ) = TransposedMatrix( UnderlyingMatrix( right_unitor_a ) ) ;
false
gap> UnderlyingMatrix( right_unitor_inverse_d ) = TransposedMatrix( UnderlyingMatrix( right_unitor_b ) ) ;
false
gap> UnderlyingMatrix( right_unitor_inverse_d ) = TransposedMatrix( UnderlyingMatrix( right_unitor_c ) ) ;
false

######################################################
# Associators
######################################################

gap> associator_left_to_right_abc := AssociatorLeftToRight( a, b, c );;
gap> associator_left_to_right_bcd := AssociatorLeftToRight( b, c, d );;
gap> associator_left_to_right_acd := AssociatorLeftToRight( a, c, d );;
gap> associator_left_to_right_cba := AssociatorLeftToRight( c, b, a );;
gap> associator_left_to_right_dcb := AssociatorLeftToRight( d, c, b );;

gap> associator_right_to_left_abc := AssociatorRightToLeft( a, b, c );;
gap> associator_right_to_left_bcd := AssociatorRightToLeft( b, c, d );;
gap> associator_right_to_left_acd := AssociatorRightToLeft( a, c, d );;
gap> associator_right_to_left_cba := AssociatorRightToLeft( c, b, a );;
gap> associator_right_to_left_dcb := AssociatorRightToLeft( d, c, b );;

# Opposite correspondence

gap> UnderlyingMatrix( associator_left_to_right_abc ) = TransposedMatrix( UnderlyingMatrix( associator_right_to_left_abc ) );
true
gap> UnderlyingMatrix( associator_left_to_right_bcd ) = TransposedMatrix( UnderlyingMatrix( associator_right_to_left_bcd ) );
true
gap> UnderlyingMatrix( associator_left_to_right_acd ) = TransposedMatrix( UnderlyingMatrix( associator_right_to_left_acd ) );
true
gap> UnderlyingMatrix( associator_left_to_right_cba ) = TransposedMatrix( UnderlyingMatrix( associator_right_to_left_cba ) );
true
gap> UnderlyingMatrix( associator_left_to_right_dcb ) = TransposedMatrix( UnderlyingMatrix( associator_right_to_left_dcb ) );
true

gap> UnderlyingMatrix( associator_right_to_left_abc ) = TransposedMatrix( UnderlyingMatrix( associator_left_to_right_abc ) );
true
gap> UnderlyingMatrix( associator_right_to_left_bcd ) = TransposedMatrix( UnderlyingMatrix( associator_left_to_right_bcd ) );
true
gap> UnderlyingMatrix( associator_right_to_left_acd ) = TransposedMatrix( UnderlyingMatrix( associator_left_to_right_acd ) );
true
gap> UnderlyingMatrix( associator_right_to_left_cba ) = TransposedMatrix( UnderlyingMatrix( associator_left_to_right_cba ) );
true
gap> UnderlyingMatrix( associator_right_to_left_dcb ) = TransposedMatrix( UnderlyingMatrix( associator_left_to_right_dcb ) );
true

gap> UnderlyingMatrix( associator_left_to_right_cba ) = TransposedMatrix( UnderlyingMatrix( associator_right_to_left_bcd ) );
false
gap> UnderlyingMatrix( associator_left_to_right_cba ) = TransposedMatrix( UnderlyingMatrix( associator_right_to_left_acd ) );
false
gap> UnderlyingMatrix( associator_left_to_right_cba ) = TransposedMatrix( UnderlyingMatrix( associator_right_to_left_dcb ) );
false

gap> UnderlyingMatrix( associator_right_to_left_acd ) = TransposedMatrix( UnderlyingMatrix( associator_left_to_right_abc ) );
false
gap> UnderlyingMatrix( associator_right_to_left_acd ) = TransposedMatrix( UnderlyingMatrix( associator_left_to_right_bcd ) );
false
gap> UnderlyingMatrix( associator_right_to_left_acd ) = TransposedMatrix( UnderlyingMatrix( associator_left_to_right_cba ) );
false

######################################################
# Braiding
######################################################

gap> braiding_a_b := Braiding( a, b );;
gap> braiding_b_a := Braiding( b, a );;
gap> braiding_c_d := Braiding( c, d );;
gap> braiding_d_c := Braiding( d, c );;

gap> braiding_0_a := Braiding( z, a );;
gap> braiding_a_0 := Braiding( a, z );;

gap> braiding_inverse_a_b := BraidingInverse( a, b );;
gap> braiding_inverse_b_a := BraidingInverse( b, a );;
gap> braiding_inverse_c_d := BraidingInverse( c, d );;
gap> braiding_inverse_d_c := BraidingInverse( d, c );;

gap> braiding_inverse_0_a := BraidingInverse( z, a );;
gap> braiding_inverse_a_0 := BraidingInverse( a, z );;

# Opposite correspondence

gap> braiding_a_b = braiding_inverse_b_a;
true
gap> braiding_b_a = braiding_inverse_a_b;
true
gap> braiding_c_d = braiding_inverse_d_c;
true
gap> braiding_d_c = braiding_inverse_c_d;
true

gap> braiding_0_a = braiding_inverse_a_0;
true
gap> braiding_a_0 = braiding_inverse_0_a;
true

gap> braiding_a_b = braiding_inverse_a_b;
false
gap> braiding_a_b = braiding_inverse_c_d;
false
gap> braiding_a_b = braiding_inverse_d_c;
false

gap> braiding_c_d = braiding_inverse_a_b;
false
gap> braiding_c_d = braiding_inverse_b_a;
false
gap> braiding_c_d = braiding_inverse_c_d;
false

gap> TestBraidingCompatibility( mc, a, b, c );
true
gap> TestBraidingCompatibility( mc, c, b, a );
true
gap> TestBraidingCompatibility( mc, b, a, c );
true

######################################################
# Identity morphisms
######################################################

# Identities for tensor objects

gap> id_a_tensor_b := IdentityMorphism( a_tensor_b );;
gap> id_b_tensor_a := IdentityMorphism( b_tensor_a );;
gap> id_c_tensor_d := IdentityMorphism( c_tensor_d );;
gap> id_d_tensor_c := IdentityMorphism( d_tensor_c );;

gap> id_0_tensor_a := IdentityMorphism( 0_tensor_a );;
gap> id_a_tensor_0 := IdentityMorphism( a_tensor_0 );;

# Identities for internal (co)homs

gap> id_hom_ab := IdentityMorphism( hom_ab );;
gap> id_hom_ba := IdentityMorphism (hom_ba );;
gap> id_hom_cd := IdentityMorphism( hom_cd );;
gap> id_hom_dc := IdentityMorphism( hom_dc );;

gap> id_hom_0a := IdentityMorphism( hom_0a );;
gap> id_hom_a0 := IdentityMorphism( hom_a0 );;

gap> id_cohom_ab := IdentityMorphism( cohom_ab );;
gap> id_cohom_ba := IdentityMorphism( cohom_ba );;
gap> id_cohom_cd := IdentityMorphism( cohom_cd );;
gap> id_cohom_dc := IdentityMorphism( cohom_dc );;

gap> id_cohom_0a := IdentityMorphism( cohom_0a );;
gap> id_cohom_a0 := IdentityMorphism( cohom_a0 );;

# Correspondence bewtween identities of internal (co)homs

gap> id_hom_ab = id_cohom_ba;
true
gap> id_hom_ba = id_cohom_ab;
true
gap> id_hom_cd = id_cohom_dc;
true
gap> id_hom_dc = id_cohom_cd;
true

gap> id_hom_0a = id_cohom_a0;
true
gap> id_hom_a0 = id_cohom_0a;
true

gap> id_hom_cd = id_hom_ab;
false
gap> id_hom_cd = id_hom_ba;
false
gap> id_hom_cd = id_cohom_ab;
false
gap> id_hom_cd = id_cohom_ba;
false

gap> id_cohom_ab = id_hom_cd;
false
gap> id_cohom_ab = id_hom_dc;
false
gap> id_cohom_ab = id_cohom_cd;
false
gap> id_cohom_ab = id_cohom_dc;
false

#####################################################
# Left units and counits
#####################################################

# Units and counits for rows

gap> left_ev_ab := ClosedMonoidalLeftEvaluationMorphism( a, b );;
gap> left_ev_ba := ClosedMonoidalLeftEvaluationMorphism( b, a );;
gap> left_ev_cd := ClosedMonoidalLeftEvaluationMorphism( c, d );;
gap> left_ev_dc := ClosedMonoidalLeftEvaluationMorphism( d, c );;

gap> left_ev_0a := ClosedMonoidalLeftEvaluationMorphism( z, a );;
gap> left_ev_a0 := ClosedMonoidalLeftEvaluationMorphism( a, z );;

gap> left_coev_ab := ClosedMonoidalLeftCoevaluationMorphism( a, b );;
gap> left_coev_ba := ClosedMonoidalLeftCoevaluationMorphism( b, a );;
gap> left_coev_cd := ClosedMonoidalLeftCoevaluationMorphism( c, d );;
gap> left_coev_dc := ClosedMonoidalLeftCoevaluationMorphism( d, c );;

gap> left_coev_0a := ClosedMonoidalLeftCoevaluationMorphism( z, a );;
gap> left_coev_a0 := ClosedMonoidalLeftCoevaluationMorphism( a, z );;

gap> left_cocl_ev_ab := CoclosedMonoidalLeftEvaluationMorphism( a, b );;
gap> left_cocl_ev_ba := CoclosedMonoidalLeftEvaluationMorphism( b, a );;
gap> left_cocl_ev_cd := CoclosedMonoidalLeftEvaluationMorphism( c, d );;
gap> left_cocl_ev_dc := CoclosedMonoidalLeftEvaluationMorphism( d, c );;

gap> left_cocl_ev_0a := CoclosedMonoidalLeftEvaluationMorphism( z, a );;
gap> left_cocl_ev_a0 := CoclosedMonoidalLeftEvaluationMorphism( a, z );;

gap> left_cocl_coev_ab := CoclosedMonoidalLeftCoevaluationMorphism( a, b );;
gap> left_cocl_coev_ba := CoclosedMonoidalLeftCoevaluationMorphism( b, a );;
gap> left_cocl_coev_cd := CoclosedMonoidalLeftCoevaluationMorphism( c, d );;
gap> left_cocl_coev_dc := CoclosedMonoidalLeftCoevaluationMorphism( d, c );;

gap> left_cocl_coev_0a := CoclosedMonoidalLeftCoevaluationMorphism( z, a );;
gap> left_cocl_coev_a0 := CoclosedMonoidalLeftCoevaluationMorphism( a, z );;

# Correspondence between left (co)units and their coclosed parts

# Arguments must be reversed for evaluations
gap> UnderlyingMatrix( left_ev_ab ) = TransposedMatrix( UnderlyingMatrix( left_cocl_ev_ab ) );
true
gap> UnderlyingMatrix( left_ev_ba ) = TransposedMatrix( UnderlyingMatrix( left_cocl_ev_ba ) );
true
gap> UnderlyingMatrix( left_ev_cd ) = TransposedMatrix( UnderlyingMatrix( left_cocl_ev_cd ) );
true
gap> UnderlyingMatrix( left_ev_dc ) = TransposedMatrix( UnderlyingMatrix( left_cocl_ev_dc ) );
true

gap> UnderlyingMatrix( left_ev_0a ) = TransposedMatrix( UnderlyingMatrix( left_cocl_ev_0a ) );
true
gap> UnderlyingMatrix( left_ev_a0 ) = TransposedMatrix( UnderlyingMatrix( left_cocl_ev_a0 ) );
true

gap> UnderlyingMatrix( left_coev_ab ) = TransposedMatrix( UnderlyingMatrix( left_cocl_coev_ab ) );
true
gap> UnderlyingMatrix( left_coev_ba ) = TransposedMatrix( UnderlyingMatrix( left_cocl_coev_ba ) );
true
gap> UnderlyingMatrix( left_coev_cd ) = TransposedMatrix( UnderlyingMatrix( left_cocl_coev_cd ) );
true
gap> UnderlyingMatrix( left_coev_dc ) = TransposedMatrix( UnderlyingMatrix( left_cocl_coev_dc ) );
true

gap> UnderlyingMatrix( left_coev_0a ) = TransposedMatrix( UnderlyingMatrix( left_cocl_coev_0a ) );
true
gap> UnderlyingMatrix( left_coev_a0 ) = TransposedMatrix( UnderlyingMatrix( left_cocl_coev_a0 ) );
true

gap> left_ev_ba = left_cocl_ev_ba;
false
gap> left_ev_ba = left_cocl_ev_cd;
false
gap> left_ev_ba = left_cocl_ev_dc;
false

gap> left_coev_dc = left_cocl_coev_cd;
false
gap> left_coev_dc = left_cocl_coev_ab;
false
gap> left_coev_dc = left_cocl_coev_ba;
false

gap> left_cocl_ev_cd = left_ev_ab;
false
gap> left_cocl_ev_cd = left_ev_ba;
false
gap> left_cocl_ev_cd = left_ev_cd;
false

gap> left_cocl_coev_ab = left_coev_ba;
false
gap> left_cocl_coev_ab = left_coev_cd;
false
gap> left_cocl_coev_ab = left_coev_dc;
false

#####################################################
# Left adjunction maps on identities
#####################################################

# Closed and coclosed left adjunction maps for rows

gap> tensor_to_hom_left_adjunction_on_id_a_tensor_b := TensorProductToInternalHomLeftAdjunctMorphism( a, b, id_a_tensor_b );;
gap> tensor_to_hom_left_adjunction_on_id_b_tensor_a := TensorProductToInternalHomLeftAdjunctMorphism( b, a, id_b_tensor_a );;
gap> tensor_to_hom_left_adjunction_on_id_c_tensor_d := TensorProductToInternalHomLeftAdjunctMorphism( c, d, id_c_tensor_d );;
gap> tensor_to_hom_left_adjunction_on_id_d_tensor_c := TensorProductToInternalHomLeftAdjunctMorphism( d, c, id_d_tensor_c );;

gap> tensor_to_hom_left_adjunction_on_id_0_tensor_a := TensorProductToInternalHomLeftAdjunctMorphism( z, a, id_0_tensor_a );;
gap> tensor_to_hom_left_adjunction_on_id_a_tensor_0 := TensorProductToInternalHomLeftAdjunctMorphism( a, z, id_a_tensor_0 );;

gap> hom_to_tensor_left_adjunction_on_id_hom_ab := InternalHomToTensorProductLeftAdjunctMorphism( a, b, id_hom_ab );;
gap> hom_to_tensor_left_adjunction_on_id_hom_ba := InternalHomToTensorProductLeftAdjunctMorphism( b, a, id_hom_ba );;
gap> hom_to_tensor_left_adjunction_on_id_hom_cd := InternalHomToTensorProductLeftAdjunctMorphism( c, d, id_hom_cd );;
gap> hom_to_tensor_left_adjunction_on_id_hom_dc := InternalHomToTensorProductLeftAdjunctMorphism( d, c, id_hom_dc );;

gap> hom_to_tensor_left_adjunction_on_id_hom_0a := InternalHomToTensorProductLeftAdjunctMorphism( z, a, id_hom_0a );;
gap> hom_to_tensor_left_adjunction_on_id_hom_a0 := InternalHomToTensorProductLeftAdjunctMorphism( a, z, id_hom_a0 );;

gap> tensor_to_cohom_left_adjunction_on_id_a_tensor_b := TensorProductToInternalCoHomLeftAdjunctMorphism( a, b, id_a_tensor_b );;
gap> tensor_to_cohom_left_adjunction_on_id_b_tensor_a := TensorProductToInternalCoHomLeftAdjunctMorphism( b, a, id_b_tensor_a );;
gap> tensor_to_cohom_left_adjunction_on_id_c_tensor_d := TensorProductToInternalCoHomLeftAdjunctMorphism( c, d, id_c_tensor_d );;
gap> tensor_to_cohom_left_adjunction_on_id_d_tensor_c := TensorProductToInternalCoHomLeftAdjunctMorphism( d, c, id_d_tensor_c );;

gap> tensor_to_cohom_left_adjunction_on_id_0_tensor_a := TensorProductToInternalCoHomLeftAdjunctMorphism( z, a, id_0_tensor_a );;
gap> tensor_to_cohom_left_adjunction_on_id_a_tensor_0 := TensorProductToInternalCoHomLeftAdjunctMorphism( a, z, id_a_tensor_0 );;

gap> cohom_to_tensor_left_adjunction_on_id_cohom_ab := InternalCoHomToTensorProductLeftAdjunctMorphism( a, b, id_cohom_ab );;
gap> cohom_to_tensor_left_adjunction_on_id_cohom_ba := InternalCoHomToTensorProductLeftAdjunctMorphism( b, a, id_cohom_ba );;
gap> cohom_to_tensor_left_adjunction_on_id_cohom_cd := InternalCoHomToTensorProductLeftAdjunctMorphism( c, d, id_cohom_cd );;
gap> cohom_to_tensor_left_adjunction_on_id_cohom_dc := InternalCoHomToTensorProductLeftAdjunctMorphism( d, c, id_cohom_dc );;

gap> cohom_to_tensor_left_adjunction_on_id_cohom_0a := InternalCoHomToTensorProductLeftAdjunctMorphism( z, a, id_cohom_0a );;
gap> cohom_to_tensor_left_adjunction_on_id_cohom_a0 := InternalCoHomToTensorProductLeftAdjunctMorphism( a, z, id_cohom_a0 );;

# Correspondence between closed and coclosed left adjunction maps

# ev = Transposed( coclev ), arguments must be reversed for evaluations

gap> UnderlyingMatrix( hom_to_tensor_left_adjunction_on_id_hom_ab ) = TransposedMatrix( UnderlyingMatrix( cohom_to_tensor_left_adjunction_on_id_cohom_ba ) ); # Hom( a, b ) x a -> b  ==  Tr( b -> Cohom( b, a ) x a )
true
gap> UnderlyingMatrix( hom_to_tensor_left_adjunction_on_id_hom_ba ) = TransposedMatrix( UnderlyingMatrix( cohom_to_tensor_left_adjunction_on_id_cohom_ab ) ); # Hom( b, a ) x b -> a  ==  Tr( a -> Cohom( a, b ) x b )
true
gap> UnderlyingMatrix( hom_to_tensor_left_adjunction_on_id_hom_cd ) = TransposedMatrix( UnderlyingMatrix( cohom_to_tensor_left_adjunction_on_id_cohom_dc ) ); # Hom( c, d ) x c -> d  ==  Tr( d -> Cohom( d, c ) x c )
true
gap> UnderlyingMatrix( hom_to_tensor_left_adjunction_on_id_hom_dc ) = TransposedMatrix( UnderlyingMatrix( cohom_to_tensor_left_adjunction_on_id_cohom_cd ) ); # Hom( d, c ) x d -> c  ==  Tr( c -> Cohom( c, d ) x d )
true

gap> UnderlyingMatrix( hom_to_tensor_left_adjunction_on_id_hom_0a ) = TransposedMatrix( UnderlyingMatrix( cohom_to_tensor_left_adjunction_on_id_cohom_a0 ) ); # Hom( 0, a ) x 0 -> a  ==  Tr( a -> Cohom( a, 0 ) x 0 )
true
gap> UnderlyingMatrix( hom_to_tensor_left_adjunction_on_id_hom_a0 ) = TransposedMatrix( UnderlyingMatrix( cohom_to_tensor_left_adjunction_on_id_cohom_0a ) ); # Hom( a, 0 ) x a -> 0  ==  Tr( 0 -> Cohom( 0, a ) x a )
true

gap> UnderlyingMatrix( left_ev_ab ) = TransposedMatrix( UnderlyingMatrix( cohom_to_tensor_left_adjunction_on_id_cohom_ba ) );
true
gap> UnderlyingMatrix( left_ev_ba ) = TransposedMatrix( UnderlyingMatrix( cohom_to_tensor_left_adjunction_on_id_cohom_ab ) );
true
gap> UnderlyingMatrix( left_ev_cd ) = TransposedMatrix( UnderlyingMatrix( cohom_to_tensor_left_adjunction_on_id_cohom_dc ) );
true
gap> UnderlyingMatrix( left_ev_dc ) = TransposedMatrix( UnderlyingMatrix( cohom_to_tensor_left_adjunction_on_id_cohom_cd ) );
true

gap> UnderlyingMatrix( left_ev_0a ) = TransposedMatrix( UnderlyingMatrix( cohom_to_tensor_left_adjunction_on_id_cohom_a0 ) );
true
gap> UnderlyingMatrix( left_ev_a0 ) = TransposedMatrix( UnderlyingMatrix( cohom_to_tensor_left_adjunction_on_id_cohom_0a ) );
true

# left_coev = Transposed( coclcoev )

gap> UnderlyingMatrix( tensor_to_hom_left_adjunction_on_id_a_tensor_b ) = TransposedMatrix( UnderlyingMatrix( tensor_to_cohom_left_adjunction_on_id_a_tensor_b ) ); # a -> Hom( b, a x b )  ==  Tr( Cohom( a x b, b) -> a )
true
gap> UnderlyingMatrix( tensor_to_hom_left_adjunction_on_id_b_tensor_a ) = TransposedMatrix( UnderlyingMatrix( tensor_to_cohom_left_adjunction_on_id_b_tensor_a ) ); # b -> Hom( a, b x a )  ==  Tr( Cohom( b x a, a) -> b )
true
gap> UnderlyingMatrix( tensor_to_hom_left_adjunction_on_id_c_tensor_d ) = TransposedMatrix( UnderlyingMatrix( tensor_to_cohom_left_adjunction_on_id_c_tensor_d ) ); # c -> Hom( d, c x d )  ==  Tr( Cohom( d x c, c) -> d )
true
gap> UnderlyingMatrix( tensor_to_hom_left_adjunction_on_id_d_tensor_c ) = TransposedMatrix( UnderlyingMatrix( tensor_to_cohom_left_adjunction_on_id_d_tensor_c ) ); # d -> Hom( c, d x c )  ==  Tr( Cohom( c x d, d) -> c )
true

gap> UnderlyingMatrix( tensor_to_hom_left_adjunction_on_id_0_tensor_a ) = TransposedMatrix( UnderlyingMatrix( tensor_to_cohom_left_adjunction_on_id_0_tensor_a ) ); # 0 -> Hom( a, 0 x a )  ==  Tr( Cohom( 0 x a, a) -> 0 )
true
gap> UnderlyingMatrix( tensor_to_hom_left_adjunction_on_id_a_tensor_0 ) = TransposedMatrix( UnderlyingMatrix( tensor_to_cohom_left_adjunction_on_id_a_tensor_0 ) ); # a -> Hom( 0, a x 0 )  ==  Tr( Cohom( a x 0, 0) -> a )
true

gap> UnderlyingMatrix( left_coev_ba ) = TransposedMatrix( UnderlyingMatrix( tensor_to_cohom_left_adjunction_on_id_a_tensor_b ) );
true
gap> UnderlyingMatrix( left_coev_ab ) = TransposedMatrix( UnderlyingMatrix( tensor_to_cohom_left_adjunction_on_id_b_tensor_a ) );
true
gap> UnderlyingMatrix( left_coev_dc ) = TransposedMatrix( UnderlyingMatrix( tensor_to_cohom_left_adjunction_on_id_c_tensor_d ) );
true
gap> UnderlyingMatrix( left_coev_cd ) = TransposedMatrix( UnderlyingMatrix( tensor_to_cohom_left_adjunction_on_id_d_tensor_c ) );
true

gap> UnderlyingMatrix( left_coev_a0 ) = TransposedMatrix( UnderlyingMatrix( tensor_to_cohom_left_adjunction_on_id_0_tensor_a ) );
true
gap> UnderlyingMatrix( left_coev_0a ) = TransposedMatrix( UnderlyingMatrix( tensor_to_cohom_left_adjunction_on_id_a_tensor_0 ) );
true

# coclev = Transposed( ev ), arguments must be reversed for evaluations

gap> UnderlyingMatrix( cohom_to_tensor_left_adjunction_on_id_cohom_ab ) = TransposedMatrix( UnderlyingMatrix( hom_to_tensor_left_adjunction_on_id_hom_ba ) ); # a -> Cohom( a, b ) x b  ==  Tr( Hom( b, a ) x b -> a )
true
gap> UnderlyingMatrix( cohom_to_tensor_left_adjunction_on_id_cohom_ba ) = TransposedMatrix( UnderlyingMatrix( hom_to_tensor_left_adjunction_on_id_hom_ab ) ); # b -> Cohom( b, a ) x a  ==  Tr( Hom( a, b ) x a -> b )
true
gap> UnderlyingMatrix( cohom_to_tensor_left_adjunction_on_id_cohom_cd ) = TransposedMatrix( UnderlyingMatrix( hom_to_tensor_left_adjunction_on_id_hom_dc ) ); # c -> Cohom( c, d ) x d  ==  Tr( Hom( d, c ) x d -> c )
true
gap> UnderlyingMatrix( cohom_to_tensor_left_adjunction_on_id_cohom_dc ) = TransposedMatrix( UnderlyingMatrix( hom_to_tensor_left_adjunction_on_id_hom_cd ) ); # d -> Cohom( d, c ) x c  ==  Tr( Hom( c, d ) x c -> d )
true

gap> UnderlyingMatrix( cohom_to_tensor_left_adjunction_on_id_cohom_0a ) = TransposedMatrix( UnderlyingMatrix( hom_to_tensor_left_adjunction_on_id_hom_a0 ) ); # 0 -> Cohom( 0, a ) x a  ==  Tr( Hom( a, 0 ) x a -> 0 )
true
gap> UnderlyingMatrix( cohom_to_tensor_left_adjunction_on_id_cohom_a0 ) = TransposedMatrix( UnderlyingMatrix( hom_to_tensor_left_adjunction_on_id_hom_0a ) ); # a -> Cohom( a, 0 ) x 0  ==  Tr( Hom( 0, a ) x 0 -> a )
true

gap> UnderlyingMatrix( left_cocl_ev_ba ) = TransposedMatrix( UnderlyingMatrix( hom_to_tensor_left_adjunction_on_id_hom_ba ) );
true
gap> UnderlyingMatrix( left_cocl_ev_ab ) = TransposedMatrix( UnderlyingMatrix( hom_to_tensor_left_adjunction_on_id_hom_ab ) );
true
gap> UnderlyingMatrix( left_cocl_ev_dc ) = TransposedMatrix( UnderlyingMatrix( hom_to_tensor_left_adjunction_on_id_hom_dc ) );
true
gap> UnderlyingMatrix( left_cocl_ev_cd ) = TransposedMatrix( UnderlyingMatrix( hom_to_tensor_left_adjunction_on_id_hom_cd ) );
true

gap> UnderlyingMatrix( left_cocl_ev_a0 ) = TransposedMatrix( UnderlyingMatrix( hom_to_tensor_left_adjunction_on_id_hom_a0 ) );
true
gap> UnderlyingMatrix( left_cocl_ev_0a ) = TransposedMatrix( UnderlyingMatrix( hom_to_tensor_left_adjunction_on_id_hom_0a ) );
true

# coclcoev = Transposed( left_coev )

gap> UnderlyingMatrix( tensor_to_cohom_left_adjunction_on_id_a_tensor_b ) = TransposedMatrix( UnderlyingMatrix( tensor_to_hom_left_adjunction_on_id_a_tensor_b ) ); # Cohom( a x b, b ) -> a  ==  Tr( a -> Hom( b, a x b ) )
true
gap> UnderlyingMatrix( tensor_to_cohom_left_adjunction_on_id_b_tensor_a ) = TransposedMatrix( UnderlyingMatrix( tensor_to_hom_left_adjunction_on_id_b_tensor_a ) ); # Cohom( b x a, a ) -> b  ==  Tr( b -> Hom( a, b x a ) )
true
gap> UnderlyingMatrix( tensor_to_cohom_left_adjunction_on_id_c_tensor_d ) = TransposedMatrix( UnderlyingMatrix( tensor_to_hom_left_adjunction_on_id_c_tensor_d ) ); # Cohom( c x d, d ) -> c  ==  Tr( c -> Hom( d, c x d ) )
true
gap> UnderlyingMatrix( tensor_to_cohom_left_adjunction_on_id_d_tensor_c ) = TransposedMatrix( UnderlyingMatrix( tensor_to_hom_left_adjunction_on_id_d_tensor_c ) ); # Cohom( d x c, c ) -> d  ==  Tr( d -> Hom( c, d x c ) )
true

gap> UnderlyingMatrix( tensor_to_cohom_left_adjunction_on_id_0_tensor_a ) = TransposedMatrix( UnderlyingMatrix( tensor_to_hom_left_adjunction_on_id_0_tensor_a ) ); # Cohom( 0 x a, a ) -> 0  ==  Tr( 0 -> Hom( a, 0 x a ) )
true
gap> UnderlyingMatrix( tensor_to_cohom_left_adjunction_on_id_a_tensor_0 ) = TransposedMatrix( UnderlyingMatrix( tensor_to_hom_left_adjunction_on_id_a_tensor_0 ) ); # Cohom( a x 0, 0 ) -> a  ==  Tr( a -> Hom( 0, a x 0 ) )
true

gap> UnderlyingMatrix( left_cocl_coev_ba ) = TransposedMatrix( UnderlyingMatrix( tensor_to_hom_left_adjunction_on_id_a_tensor_b ) );
true
gap> UnderlyingMatrix( left_cocl_coev_ab ) = TransposedMatrix( UnderlyingMatrix( tensor_to_hom_left_adjunction_on_id_b_tensor_a ) );
true
gap> UnderlyingMatrix( left_cocl_coev_dc ) = TransposedMatrix( UnderlyingMatrix( tensor_to_hom_left_adjunction_on_id_c_tensor_d ) );
true
gap> UnderlyingMatrix( left_cocl_coev_cd ) = TransposedMatrix( UnderlyingMatrix( tensor_to_hom_left_adjunction_on_id_d_tensor_c ) );
true

gap> UnderlyingMatrix( left_cocl_coev_a0 ) = TransposedMatrix( UnderlyingMatrix( tensor_to_hom_left_adjunction_on_id_0_tensor_a ) );
true
gap> UnderlyingMatrix( left_cocl_coev_0a ) = TransposedMatrix( UnderlyingMatrix( tensor_to_hom_left_adjunction_on_id_a_tensor_0 ) );
true

#####################################################
# Left adjunction maps on non-identities
#####################################################

gap> tensor_to_hom_left_adjunction_on_alpha_tensor_beta := TensorProductToInternalHomLeftAdjunctMorphism( a, c, alpha_tensor_beta );;
gap> tensor_to_hom_left_adjunction_on_beta_tensor_alpha := TensorProductToInternalHomLeftAdjunctMorphism( c, a, beta_tensor_alpha );;
gap> tensor_to_hom_left_adjunction_on_alpha_tensor_beta_transposed := TensorProductToInternalHomLeftAdjunctMorphism( a, c, alpha_tensor_beta_transposed );;
gap> tensor_to_hom_left_adjunction_on_beta_tensor_alpha_transposed := TensorProductToInternalHomLeftAdjunctMorphism( c, a, beta_tensor_alpha_transposed );;

gap> tensor_to_cohom_left_adjunction_on_alpha_tensor_beta := TensorProductToInternalCoHomLeftAdjunctMorphism( a, c, alpha_tensor_beta );;
gap> tensor_to_cohom_left_adjunction_on_beta_tensor_alpha := TensorProductToInternalCoHomLeftAdjunctMorphism( c, a, beta_tensor_alpha );;
gap> tensor_to_cohom_left_adjunction_on_alpha_tensor_beta_transposed := TensorProductToInternalCoHomLeftAdjunctMorphism( a, c, alpha_tensor_beta_transposed );;
gap> tensor_to_cohom_left_adjunction_on_beta_tensor_alpha_transposed := TensorProductToInternalCoHomLeftAdjunctMorphism( c, a, beta_tensor_alpha_transposed );;

gap> hom_to_tensor_left_adjunction_on_hom_alpha_beta := InternalHomToTensorProductLeftAdjunctMorphism( a, d, hom_alpha_beta );;
gap> hom_to_tensor_left_adjunction_on_hom_beta_alpha := InternalHomToTensorProductLeftAdjunctMorphism( c, b, hom_beta_alpha );;
gap> hom_to_tensor_left_adjunction_on_hom_alpha_beta_transposed := InternalHomToTensorProductLeftAdjunctMorphism( b, c, hom_alpha_beta_transposed );;
gap> hom_to_tensor_left_adjunction_on_hom_beta_alpha_transposed := InternalHomToTensorProductLeftAdjunctMorphism( d, a, hom_beta_alpha_transposed );;

gap> cohom_to_tensor_left_adjunction_on_cohom_alpha_beta := InternalCoHomToTensorProductLeftAdjunctMorphism( a, d, cohom_alpha_beta );;
gap> cohom_to_tensor_left_adjunction_on_cohom_beta_alpha := InternalCoHomToTensorProductLeftAdjunctMorphism( c, b, cohom_beta_alpha );;
gap> cohom_to_tensor_left_adjunction_on_cohom_alpha_beta_transposed := InternalCoHomToTensorProductLeftAdjunctMorphism( b, c, cohom_alpha_beta_transposed );;
gap> cohom_to_tensor_left_adjunction_on_cohom_beta_alpha_transposed := InternalCoHomToTensorProductLeftAdjunctMorphism( d, a, cohom_beta_alpha_transposed );;

# Correspondence on left adjunction maps on tensor products

################################################
#                                              #
# alpha: a -> b                                #
# beta:  c -> d                                #
#                                              #
# alpha_tensor_beta: a x c -> b x d            #
# beta_tensor_alpha: c x a -> d x b            #
#                                              #
# alpha_transposed: b -> a                     #
# beta_transposed:  d -> c                     #
#                                              #
# alpha_tensor_beta_transposed: b x d -> a x c #
# beta_tensor_alpha_transposed: d x b -> c x a #
#                                              #
################################################

gap> UnderlyingMatrix( tensor_to_hom_left_adjunction_on_alpha_tensor_beta ) = TransposedMatrix( UnderlyingMatrix( tensor_to_cohom_left_adjunction_on_alpha_tensor_beta_transposed ) ); # a -> Hom( c, b x d )  ==  Tr( Cohom( a x c, d ) -> b )
true

gap> UnderlyingMatrix( tensor_to_hom_left_adjunction_on_beta_tensor_alpha ) = TransposedMatrix( UnderlyingMatrix( tensor_to_cohom_left_adjunction_on_beta_tensor_alpha_transposed ) ); # c -> Hom( a, d x b )  ==  Tr( Cohom( d x b, a ) -> c )
true

gap> UnderlyingMatrix( tensor_to_cohom_left_adjunction_on_alpha_tensor_beta ) = TransposedMatrix( UnderlyingMatrix( tensor_to_hom_left_adjunction_on_alpha_tensor_beta_transposed ) ); # Cohom( a x c, d ) -> b  ==  Tr( b -> Hom( d, a x c ) )
true

gap> UnderlyingMatrix( tensor_to_cohom_left_adjunction_on_beta_tensor_alpha ) = TransposedMatrix( UnderlyingMatrix( tensor_to_hom_left_adjunction_on_beta_tensor_alpha_transposed ) ); # Cohom( c x a, b ) -> d  ==  Tr( d -> Hom( b, c x a ) )
true

# Correspondence on left adjunction maps on internal (co)homs

###############################################################
#                                                             #
# hom_alpha_beta: Hom( b, c ) -> Hom( a, d )                  #
# hom_beta_alpha: Hom( d, a ) -> Hom( c, b )                  #
#                                                             #
# hom_alpha_beta_transposed: Hom( a, d ) -> Hom( b, c )       #
# hom_beta_alpha_transposed: Hom( c, b ) -> Hom( d, a )       #
#                                                             #
###############################################################
#                                                             #
# cohom_alpha_beta: Cohom( a, d ) -> Cohom( b, c )            #
# cohom_beta_alpha: Cohom( c, b ) -> Cohom( d, a )            #
#                                                             #
# cohom_alpha_beta_transposed: Cohom( b, c ) -> Cohom( a, d ) #
# cohom_beta_alpha_transposed: Cohom( d, a ) -> Cohom( c, b ) #
#                                                             #
###############################################################

gap> UnderlyingMatrix( hom_to_tensor_left_adjunction_on_hom_alpha_beta ) = TransposedMatrix( UnderlyingMatrix( cohom_to_tensor_left_adjunction_on_cohom_beta_alpha_transposed ) ); # Hom( b, c ) x a -> d  ==  Tr( d -> Cohom( c, b ) x a )
true

gap> UnderlyingMatrix( hom_to_tensor_left_adjunction_on_hom_beta_alpha ) = TransposedMatrix( UnderlyingMatrix( cohom_to_tensor_left_adjunction_on_cohom_alpha_beta_transposed ) ); # Hom( d, a ) x c -> b  ==  Tr( b -> Cohom( a, d ) x c )
true

gap> UnderlyingMatrix( cohom_to_tensor_left_adjunction_on_cohom_alpha_beta ) = TransposedMatrix( UnderlyingMatrix( hom_to_tensor_left_adjunction_on_hom_beta_alpha_transposed ) ); # a -> Cohom( b, c ) x d  ==  Tr( Hom( c, b ) x d -> a )
true

gap> UnderlyingMatrix( cohom_to_tensor_left_adjunction_on_cohom_beta_alpha ) = TransposedMatrix( UnderlyingMatrix( hom_to_tensor_left_adjunction_on_hom_alpha_beta_transposed ) ); # c -> Cohom( d, a ) x b  ==  Tr( Hom( a, d ) x b -> c )
true

#####################################################
# Right units and counits
#####################################################

# Units and counits for rows

gap> right_ev_ab := ClosedMonoidalRightEvaluationMorphism( a, b );;
gap> right_ev_ba := ClosedMonoidalRightEvaluationMorphism( b, a );;
gap> right_ev_cd := ClosedMonoidalRightEvaluationMorphism( c, d );;
gap> right_ev_dc := ClosedMonoidalRightEvaluationMorphism( d, c );;

gap> right_ev_0a := ClosedMonoidalRightEvaluationMorphism( z, a );;
gap> right_ev_a0 := ClosedMonoidalRightEvaluationMorphism( a, z );;

gap> right_coev_ab := ClosedMonoidalRightCoevaluationMorphism( a, b );;
gap> right_coev_ba := ClosedMonoidalRightCoevaluationMorphism( b, a );;
gap> right_coev_cd := ClosedMonoidalRightCoevaluationMorphism( c, d );;
gap> right_coev_dc := ClosedMonoidalRightCoevaluationMorphism( d, c );;

gap> right_coev_0a := ClosedMonoidalRightCoevaluationMorphism( z, a );;
gap> right_coev_a0 := ClosedMonoidalRightCoevaluationMorphism( a, z );;

gap> right_cocl_ev_ab := CoclosedMonoidalRightEvaluationMorphism( a, b );;
gap> right_cocl_ev_ba := CoclosedMonoidalRightEvaluationMorphism( b, a );;
gap> right_cocl_ev_cd := CoclosedMonoidalRightEvaluationMorphism( c, d );;
gap> right_cocl_ev_dc := CoclosedMonoidalRightEvaluationMorphism( d, c );;

gap> right_cocl_ev_0a := CoclosedMonoidalRightEvaluationMorphism( z, a );;
gap> right_cocl_ev_a0 := CoclosedMonoidalRightEvaluationMorphism( a, z );;

gap> right_cocl_coev_ab := CoclosedMonoidalRightCoevaluationMorphism( a, b );;
gap> right_cocl_coev_ba := CoclosedMonoidalRightCoevaluationMorphism( b, a );;
gap> right_cocl_coev_cd := CoclosedMonoidalRightCoevaluationMorphism( c, d );;
gap> right_cocl_coev_dc := CoclosedMonoidalRightCoevaluationMorphism( d, c );;

gap> right_cocl_coev_0a := CoclosedMonoidalRightCoevaluationMorphism( z, a );;
gap> right_cocl_coev_a0 := CoclosedMonoidalRightCoevaluationMorphism( a, z );;

# Correspondence between right (co)units and their coclosed parts

# Arguments must be reversed for evaluations
gap> UnderlyingMatrix( right_ev_ab ) = TransposedMatrix( UnderlyingMatrix( right_cocl_ev_ab ) );
true
gap> UnderlyingMatrix( right_ev_ba ) = TransposedMatrix( UnderlyingMatrix( right_cocl_ev_ba ) );
true
gap> UnderlyingMatrix( right_ev_cd ) = TransposedMatrix( UnderlyingMatrix( right_cocl_ev_cd ) );
true
gap> UnderlyingMatrix( right_ev_dc ) = TransposedMatrix( UnderlyingMatrix( right_cocl_ev_dc ) );
true

gap> UnderlyingMatrix( right_ev_0a ) = TransposedMatrix( UnderlyingMatrix( right_cocl_ev_0a ) );
true
gap> UnderlyingMatrix( right_ev_a0 ) = TransposedMatrix( UnderlyingMatrix( right_cocl_ev_a0 ) );
true

gap> UnderlyingMatrix( right_coev_ab ) = TransposedMatrix( UnderlyingMatrix( right_cocl_coev_ab ) );
true
gap> UnderlyingMatrix( right_coev_ba ) = TransposedMatrix( UnderlyingMatrix( right_cocl_coev_ba ) );
true
gap> UnderlyingMatrix( right_coev_cd ) = TransposedMatrix( UnderlyingMatrix( right_cocl_coev_cd ) );
true
gap> UnderlyingMatrix( right_coev_dc ) = TransposedMatrix( UnderlyingMatrix( right_cocl_coev_dc ) );
true

gap> UnderlyingMatrix( right_coev_0a ) = TransposedMatrix( UnderlyingMatrix( right_cocl_coev_0a ) );
true
gap> UnderlyingMatrix( right_coev_a0 ) = TransposedMatrix( UnderlyingMatrix( right_cocl_coev_a0 ) );
true

gap> right_ev_ba = right_cocl_ev_ba;
false
gap> right_ev_ba = right_cocl_ev_cd;
false
gap> right_ev_ba = right_cocl_ev_dc;
false

gap> right_coev_dc = right_cocl_coev_cd;
false
gap> right_coev_dc = right_cocl_coev_ab;
false
gap> right_coev_dc = right_cocl_coev_ba;
false

gap> right_cocl_ev_cd = right_ev_ab;
false
gap> right_cocl_ev_cd = right_ev_ba;
false
gap> right_cocl_ev_cd = right_ev_cd;
false

gap> right_cocl_coev_ab = right_coev_ba;
false
gap> right_cocl_coev_ab = right_coev_cd;
false
gap> right_cocl_coev_ab = right_coev_dc;
false

#####################################################
# Right adjunction maps on identities
#####################################################

# Closed and coclosed right adjunction maps for rows

gap> tensor_to_hom_right_adjunction_on_id_a_tensor_b := TensorProductToInternalHomRightAdjunctMorphism( a, b, id_a_tensor_b );;
gap> tensor_to_hom_right_adjunction_on_id_b_tensor_a := TensorProductToInternalHomRightAdjunctMorphism( b, a, id_b_tensor_a );;
gap> tensor_to_hom_right_adjunction_on_id_c_tensor_d := TensorProductToInternalHomRightAdjunctMorphism( c, d, id_c_tensor_d );;
gap> tensor_to_hom_right_adjunction_on_id_d_tensor_c := TensorProductToInternalHomRightAdjunctMorphism( d, c, id_d_tensor_c );;

gap> tensor_to_hom_right_adjunction_on_id_0_tensor_a := TensorProductToInternalHomRightAdjunctMorphism( z, a, id_0_tensor_a );;
gap> tensor_to_hom_right_adjunction_on_id_a_tensor_0 := TensorProductToInternalHomRightAdjunctMorphism( a, z, id_a_tensor_0 );;

gap> hom_to_tensor_right_adjunction_on_id_hom_ab := InternalHomToTensorProductRightAdjunctMorphism( a, b, id_hom_ab );;
gap> hom_to_tensor_right_adjunction_on_id_hom_ba := InternalHomToTensorProductRightAdjunctMorphism( b, a, id_hom_ba );;
gap> hom_to_tensor_right_adjunction_on_id_hom_cd := InternalHomToTensorProductRightAdjunctMorphism( c, d, id_hom_cd );;
gap> hom_to_tensor_right_adjunction_on_id_hom_dc := InternalHomToTensorProductRightAdjunctMorphism( d, c, id_hom_dc );;

gap> hom_to_tensor_right_adjunction_on_id_hom_0a := InternalHomToTensorProductRightAdjunctMorphism( z, a, id_hom_0a );;
gap> hom_to_tensor_right_adjunction_on_id_hom_a0 := InternalHomToTensorProductRightAdjunctMorphism( a, z, id_hom_a0 );;

gap> tensor_to_cohom_right_adjunction_on_id_a_tensor_b := TensorProductToInternalCoHomRightAdjunctMorphism( a, b, id_a_tensor_b );;
gap> tensor_to_cohom_right_adjunction_on_id_b_tensor_a := TensorProductToInternalCoHomRightAdjunctMorphism( b, a, id_b_tensor_a );;
gap> tensor_to_cohom_right_adjunction_on_id_c_tensor_d := TensorProductToInternalCoHomRightAdjunctMorphism( c, d, id_c_tensor_d );;
gap> tensor_to_cohom_right_adjunction_on_id_d_tensor_c := TensorProductToInternalCoHomRightAdjunctMorphism( d, c, id_d_tensor_c );;

gap> tensor_to_cohom_right_adjunction_on_id_0_tensor_a := TensorProductToInternalCoHomRightAdjunctMorphism( z, a, id_0_tensor_a );;
gap> tensor_to_cohom_right_adjunction_on_id_a_tensor_0 := TensorProductToInternalCoHomRightAdjunctMorphism( a, z, id_a_tensor_0 );;

gap> cohom_to_tensor_right_adjunction_on_id_cohom_ab := InternalCoHomToTensorProductRightAdjunctMorphism( a, b, id_cohom_ab );;
gap> cohom_to_tensor_right_adjunction_on_id_cohom_ba := InternalCoHomToTensorProductRightAdjunctMorphism( b, a, id_cohom_ba );;
gap> cohom_to_tensor_right_adjunction_on_id_cohom_cd := InternalCoHomToTensorProductRightAdjunctMorphism( c, d, id_cohom_cd );;
gap> cohom_to_tensor_right_adjunction_on_id_cohom_dc := InternalCoHomToTensorProductRightAdjunctMorphism( d, c, id_cohom_dc );;

gap> cohom_to_tensor_right_adjunction_on_id_cohom_0a := InternalCoHomToTensorProductRightAdjunctMorphism( z, a, id_cohom_0a );;
gap> cohom_to_tensor_right_adjunction_on_id_cohom_a0 := InternalCoHomToTensorProductRightAdjunctMorphism( a, z, id_cohom_a0 );;

# Correspondence between closed and coclosed right adjunction maps

# ev = Transposed( coclev ), arguments must be reversed for evaluations

gap> UnderlyingMatrix( hom_to_tensor_right_adjunction_on_id_hom_ab ) = TransposedMatrix( UnderlyingMatrix( cohom_to_tensor_right_adjunction_on_id_cohom_ba ) ); # Hom( a, b ) x a -> b  ==  Tr( b -> Cohom( b, a ) x a )
true
gap> UnderlyingMatrix( hom_to_tensor_right_adjunction_on_id_hom_ba ) = TransposedMatrix( UnderlyingMatrix( cohom_to_tensor_right_adjunction_on_id_cohom_ab ) ); # Hom( b, a ) x b -> a  ==  Tr( a -> Cohom( a, b ) x b )
true
gap> UnderlyingMatrix( hom_to_tensor_right_adjunction_on_id_hom_cd ) = TransposedMatrix( UnderlyingMatrix( cohom_to_tensor_right_adjunction_on_id_cohom_dc ) ); # Hom( c, d ) x c -> d  ==  Tr( d -> Cohom( d, c ) x c )
true
gap> UnderlyingMatrix( hom_to_tensor_right_adjunction_on_id_hom_dc ) = TransposedMatrix( UnderlyingMatrix( cohom_to_tensor_right_adjunction_on_id_cohom_cd ) ); # Hom( d, c ) x d -> c  ==  Tr( c -> Cohom( c, d ) x d )
true

gap> UnderlyingMatrix( hom_to_tensor_right_adjunction_on_id_hom_0a ) = TransposedMatrix( UnderlyingMatrix( cohom_to_tensor_right_adjunction_on_id_cohom_a0 ) ); # Hom( 0, a ) x 0 -> a  ==  Tr( a -> Cohom( a, 0 ) x 0 )
true
gap> UnderlyingMatrix( hom_to_tensor_right_adjunction_on_id_hom_a0 ) = TransposedMatrix( UnderlyingMatrix( cohom_to_tensor_right_adjunction_on_id_cohom_0a ) ); # Hom( a, 0 ) x a -> 0  ==  Tr( 0 -> Cohom( 0, a ) x a )
true

gap> UnderlyingMatrix( right_ev_ab ) = TransposedMatrix( UnderlyingMatrix( cohom_to_tensor_right_adjunction_on_id_cohom_ba ) );
true
gap> UnderlyingMatrix( right_ev_ba ) = TransposedMatrix( UnderlyingMatrix( cohom_to_tensor_right_adjunction_on_id_cohom_ab ) );
true
gap> UnderlyingMatrix( right_ev_cd ) = TransposedMatrix( UnderlyingMatrix( cohom_to_tensor_right_adjunction_on_id_cohom_dc ) );
true
gap> UnderlyingMatrix( right_ev_dc ) = TransposedMatrix( UnderlyingMatrix( cohom_to_tensor_right_adjunction_on_id_cohom_cd ) );
true

gap> UnderlyingMatrix( right_ev_0a ) = TransposedMatrix( UnderlyingMatrix( cohom_to_tensor_right_adjunction_on_id_cohom_a0 ) );
true
gap> UnderlyingMatrix( right_ev_a0 ) = TransposedMatrix( UnderlyingMatrix( cohom_to_tensor_right_adjunction_on_id_cohom_0a ) );
true

# right_coev = coclcoev

gap> UnderlyingMatrix( tensor_to_hom_right_adjunction_on_id_a_tensor_b ) = TransposedMatrix( UnderlyingMatrix( tensor_to_cohom_right_adjunction_on_id_a_tensor_b ) ); # a -> Hom( b, a x b )  ==  Tr( Cohom( a x b, b) -> a )
true
gap> UnderlyingMatrix( tensor_to_hom_right_adjunction_on_id_b_tensor_a ) = TransposedMatrix( UnderlyingMatrix( tensor_to_cohom_right_adjunction_on_id_b_tensor_a ) ); # b -> Hom( a, b x a )  ==  Tr( Cohom( b x a, a) -> b )
true
gap> UnderlyingMatrix( tensor_to_hom_right_adjunction_on_id_c_tensor_d ) = TransposedMatrix( UnderlyingMatrix( tensor_to_cohom_right_adjunction_on_id_c_tensor_d ) ); # c -> Hom( d, c x d )  ==  Tr( Cohom( d x c, c) -> d )
true
gap> UnderlyingMatrix( tensor_to_hom_right_adjunction_on_id_d_tensor_c ) = TransposedMatrix( UnderlyingMatrix( tensor_to_cohom_right_adjunction_on_id_d_tensor_c ) ); # d -> Hom( c, d x c )  ==  Tr( Cohom( c x d, d) -> c )
true

gap> UnderlyingMatrix( tensor_to_hom_right_adjunction_on_id_0_tensor_a ) = TransposedMatrix( UnderlyingMatrix( tensor_to_cohom_right_adjunction_on_id_0_tensor_a ) ); # 0 -> Hom( a, 0 x a )  ==  Tr( Cohom( 0 x a, a) -> 0 )
true
gap> UnderlyingMatrix( tensor_to_hom_right_adjunction_on_id_a_tensor_0 ) = TransposedMatrix( UnderlyingMatrix( tensor_to_cohom_right_adjunction_on_id_a_tensor_0 ) ); # a -> Hom( 0, a x 0 )  ==  Tr( Cohom( a x 0, 0) -> a )
true

gap> UnderlyingMatrix( right_coev_ab ) = TransposedMatrix( UnderlyingMatrix( tensor_to_cohom_right_adjunction_on_id_a_tensor_b ) );
true
gap> UnderlyingMatrix( right_coev_ba ) = TransposedMatrix( UnderlyingMatrix( tensor_to_cohom_right_adjunction_on_id_b_tensor_a ) );
true
gap> UnderlyingMatrix( right_coev_cd ) = TransposedMatrix( UnderlyingMatrix( tensor_to_cohom_right_adjunction_on_id_c_tensor_d ) );
true
gap> UnderlyingMatrix( right_coev_dc ) = TransposedMatrix( UnderlyingMatrix( tensor_to_cohom_right_adjunction_on_id_d_tensor_c ) );
true

gap> UnderlyingMatrix( right_coev_0a ) = TransposedMatrix( UnderlyingMatrix( tensor_to_cohom_right_adjunction_on_id_0_tensor_a ) );
true
gap> UnderlyingMatrix( right_coev_a0 ) = TransposedMatrix( UnderlyingMatrix( tensor_to_cohom_right_adjunction_on_id_a_tensor_0 ) );
true

# coclev = Transposed( ev ), arguments must be reversed for evaluations

gap> UnderlyingMatrix( cohom_to_tensor_right_adjunction_on_id_cohom_ab ) = TransposedMatrix( UnderlyingMatrix( hom_to_tensor_right_adjunction_on_id_hom_ba ) ); # a -> Cohom( a, b ) x b  ==  Tr( Hom( b, a ) x b -> a )
true
gap> UnderlyingMatrix( cohom_to_tensor_right_adjunction_on_id_cohom_ba ) = TransposedMatrix( UnderlyingMatrix( hom_to_tensor_right_adjunction_on_id_hom_ab ) ); # b -> Cohom( b, a ) x a  ==  Tr( Hom( a, b ) x a -> b )
true
gap> UnderlyingMatrix( cohom_to_tensor_right_adjunction_on_id_cohom_cd ) = TransposedMatrix( UnderlyingMatrix( hom_to_tensor_right_adjunction_on_id_hom_dc ) ); # c -> Cohom( c, d ) x d  ==  Tr( Hom( d, c ) x d -> c )
true
gap> UnderlyingMatrix( cohom_to_tensor_right_adjunction_on_id_cohom_dc ) = TransposedMatrix( UnderlyingMatrix( hom_to_tensor_right_adjunction_on_id_hom_cd ) ); # d -> Cohom( d, c ) x c  ==  Tr( Hom( c, d ) x c -> d )
true

gap> UnderlyingMatrix( cohom_to_tensor_right_adjunction_on_id_cohom_0a ) = TransposedMatrix( UnderlyingMatrix( hom_to_tensor_right_adjunction_on_id_hom_a0 ) ); # 0 -> Cohom( 0, a ) x a  ==  Tr( Hom( a, 0 ) x a -> 0 )
true
gap> UnderlyingMatrix( cohom_to_tensor_right_adjunction_on_id_cohom_a0 ) = TransposedMatrix( UnderlyingMatrix( hom_to_tensor_right_adjunction_on_id_hom_0a ) ); # a -> Cohom( a, 0 ) x 0  ==  Tr( Hom( 0, a ) x 0 -> a )
true

gap> UnderlyingMatrix( right_cocl_ev_ba ) = TransposedMatrix( UnderlyingMatrix( hom_to_tensor_right_adjunction_on_id_hom_ba ) );
true
gap> UnderlyingMatrix( right_cocl_ev_ab ) = TransposedMatrix( UnderlyingMatrix( hom_to_tensor_right_adjunction_on_id_hom_ab ) );
true
gap> UnderlyingMatrix( right_cocl_ev_dc ) = TransposedMatrix( UnderlyingMatrix( hom_to_tensor_right_adjunction_on_id_hom_dc ) );
true
gap> UnderlyingMatrix( right_cocl_ev_cd ) = TransposedMatrix( UnderlyingMatrix( hom_to_tensor_right_adjunction_on_id_hom_cd ) );
true

gap> UnderlyingMatrix( right_cocl_ev_a0 ) = TransposedMatrix( UnderlyingMatrix( hom_to_tensor_right_adjunction_on_id_hom_a0 ) );
true
gap> UnderlyingMatrix( right_cocl_ev_0a ) = TransposedMatrix( UnderlyingMatrix( hom_to_tensor_right_adjunction_on_id_hom_0a ) );
true

# coclcoev = Transposed( right_coev )

gap> UnderlyingMatrix( tensor_to_cohom_right_adjunction_on_id_a_tensor_b ) = TransposedMatrix( UnderlyingMatrix( tensor_to_hom_right_adjunction_on_id_a_tensor_b ) ); # Cohom( a x b, b ) -> a  ==  Tr( a -> Hom( b, a x b ) )
true
gap> UnderlyingMatrix( tensor_to_cohom_right_adjunction_on_id_b_tensor_a ) = TransposedMatrix( UnderlyingMatrix( tensor_to_hom_right_adjunction_on_id_b_tensor_a ) ); # Cohom( b x a, a ) -> b  ==  Tr( b -> Hom( a, b x a ) )
true
gap> UnderlyingMatrix( tensor_to_cohom_right_adjunction_on_id_c_tensor_d ) = TransposedMatrix( UnderlyingMatrix( tensor_to_hom_right_adjunction_on_id_c_tensor_d ) ); # Cohom( c x d, d ) -> c  ==  Tr( c -> Hom( d, c x d ) )
true
gap> UnderlyingMatrix( tensor_to_cohom_right_adjunction_on_id_d_tensor_c ) = TransposedMatrix( UnderlyingMatrix( tensor_to_hom_right_adjunction_on_id_d_tensor_c ) ); # Cohom( d x c, c ) -> d  ==  Tr( d -> Hom( c, d x c ) )
true

gap> UnderlyingMatrix( tensor_to_cohom_right_adjunction_on_id_0_tensor_a ) = TransposedMatrix( UnderlyingMatrix( tensor_to_hom_right_adjunction_on_id_0_tensor_a ) ); # Cohom( 0 x a, a ) -> 0  ==  Tr( 0 -> Hom( a, 0 x a ) )
true
gap> UnderlyingMatrix( tensor_to_cohom_right_adjunction_on_id_a_tensor_0 ) = TransposedMatrix( UnderlyingMatrix( tensor_to_hom_right_adjunction_on_id_a_tensor_0 ) ); # Cohom( a x 0, 0 ) -> a  ==  Tr( a -> Hom( 0, a x 0 ) )
true

gap> UnderlyingMatrix( right_cocl_coev_ab ) = TransposedMatrix( UnderlyingMatrix( tensor_to_hom_right_adjunction_on_id_a_tensor_b ) );
true
gap> UnderlyingMatrix( right_cocl_coev_ba ) = TransposedMatrix( UnderlyingMatrix( tensor_to_hom_right_adjunction_on_id_b_tensor_a ) );
true
gap> UnderlyingMatrix( right_cocl_coev_cd ) = TransposedMatrix( UnderlyingMatrix( tensor_to_hom_right_adjunction_on_id_c_tensor_d ) );
true
gap> UnderlyingMatrix( right_cocl_coev_dc ) = TransposedMatrix( UnderlyingMatrix( tensor_to_hom_right_adjunction_on_id_d_tensor_c ) );
true

gap> UnderlyingMatrix( right_cocl_coev_0a ) = TransposedMatrix( UnderlyingMatrix( tensor_to_hom_right_adjunction_on_id_0_tensor_a ) );
true
gap> UnderlyingMatrix( right_cocl_coev_a0 ) = TransposedMatrix( UnderlyingMatrix( tensor_to_hom_right_adjunction_on_id_a_tensor_0 ) );
true

#####################################################
# Right adjunction maps on non-identities
#####################################################

gap> tensor_to_hom_right_adjunction_on_alpha_tensor_beta := TensorProductToInternalHomRightAdjunctMorphism( a, c, alpha_tensor_beta );;
gap> tensor_to_hom_right_adjunction_on_beta_tensor_alpha := TensorProductToInternalHomRightAdjunctMorphism( c, a, beta_tensor_alpha );;
gap> tensor_to_hom_right_adjunction_on_alpha_tensor_beta_transposed := TensorProductToInternalHomRightAdjunctMorphism( a, c, alpha_tensor_beta_transposed );;
gap> tensor_to_hom_right_adjunction_on_beta_tensor_alpha_transposed := TensorProductToInternalHomRightAdjunctMorphism( c, a, beta_tensor_alpha_transposed );;

gap> tensor_to_cohom_right_adjunction_on_alpha_tensor_beta := TensorProductToInternalCoHomRightAdjunctMorphism( a, c, alpha_tensor_beta );;
gap> tensor_to_cohom_right_adjunction_on_beta_tensor_alpha := TensorProductToInternalCoHomRightAdjunctMorphism( c, a, beta_tensor_alpha );;
gap> tensor_to_cohom_right_adjunction_on_alpha_tensor_beta_transposed := TensorProductToInternalCoHomRightAdjunctMorphism( a, c, alpha_tensor_beta_transposed );;
gap> tensor_to_cohom_right_adjunction_on_beta_tensor_alpha_transposed := TensorProductToInternalCoHomRightAdjunctMorphism( c, a, beta_tensor_alpha_transposed );;

gap> hom_to_tensor_right_adjunction_on_hom_alpha_beta := InternalHomToTensorProductRightAdjunctMorphism( a, d, hom_alpha_beta );;
gap> hom_to_tensor_right_adjunction_on_hom_beta_alpha := InternalHomToTensorProductRightAdjunctMorphism( c, b, hom_beta_alpha );;
gap> hom_to_tensor_right_adjunction_on_hom_alpha_beta_transposed := InternalHomToTensorProductRightAdjunctMorphism( b, c, hom_alpha_beta_transposed );;
gap> hom_to_tensor_right_adjunction_on_hom_beta_alpha_transposed := InternalHomToTensorProductRightAdjunctMorphism( d, a, hom_beta_alpha_transposed );;

gap> cohom_to_tensor_right_adjunction_on_cohom_alpha_beta := InternalCoHomToTensorProductRightAdjunctMorphism( a, d, cohom_alpha_beta );;
gap> cohom_to_tensor_right_adjunction_on_cohom_beta_alpha := InternalCoHomToTensorProductRightAdjunctMorphism( c, b, cohom_beta_alpha );;
gap> cohom_to_tensor_right_adjunction_on_cohom_alpha_beta_transposed := InternalCoHomToTensorProductRightAdjunctMorphism( b, c, cohom_alpha_beta_transposed );;
gap> cohom_to_tensor_right_adjunction_on_cohom_beta_alpha_transposed := InternalCoHomToTensorProductRightAdjunctMorphism( d, a, cohom_beta_alpha_transposed );;

# Correspondence on right adjunction maps on tensor products

################################################
#                                              #
# alpha: a -> b                                #
# beta:  c -> d                                #
#                                              #
# alpha_tensor_beta: a x c -> b x d            #
# beta_tensor_alpha: c x a -> d x b            #
#                                              #
# alpha_transposed: b -> a                     #
# beta_transposed:  d -> c                     #
#                                              #
# alpha_tensor_beta_transposed: b x d -> a x c #
# beta_tensor_alpha_transposed: d x b -> c x a #
#                                              #
################################################

gap> UnderlyingMatrix( tensor_to_hom_right_adjunction_on_alpha_tensor_beta ) = TransposedMatrix( UnderlyingMatrix( tensor_to_cohom_right_adjunction_on_alpha_tensor_beta_transposed ) ); # a -> Hom( c, b x d )  ==  Tr( Cohom( a x c, d ) -> b )
true

gap> UnderlyingMatrix( tensor_to_hom_right_adjunction_on_beta_tensor_alpha ) = TransposedMatrix( UnderlyingMatrix( tensor_to_cohom_right_adjunction_on_beta_tensor_alpha_transposed ) ); # c -> Hom( a, d x b )  ==  Tr( Cohom( d x b, a ) -> c )
true

gap> UnderlyingMatrix( tensor_to_cohom_right_adjunction_on_alpha_tensor_beta ) = TransposedMatrix( UnderlyingMatrix( tensor_to_hom_right_adjunction_on_alpha_tensor_beta_transposed ) ); # Cohom( a x c, d ) -> b  ==  Tr( b -> Hom( d, a x c ) )
true

gap> UnderlyingMatrix( tensor_to_cohom_right_adjunction_on_beta_tensor_alpha ) = TransposedMatrix( UnderlyingMatrix( tensor_to_hom_right_adjunction_on_beta_tensor_alpha_transposed ) ); # Cohom( c x a, b ) -> d  ==  Tr( d -> Hom( b, c x a ) )
true

# Correspondence on right adjunction maps on internal (co)homs

###############################################################
#                                                             #
# hom_alpha_beta: Hom( b, c ) -> Hom( a, d )                  #
# hom_beta_alpha: Hom( d, a ) -> Hom( c, b )                  #
#                                                             #
# hom_alpha_beta_transposed: Hom( a, d ) -> Hom( b, c )       #
# hom_beta_alpha_transposed: Hom( c, b ) -> Hom( d, a )       #
#                                                             #
###############################################################
#                                                             #
# cohom_alpha_beta: Cohom( a, d ) -> Cohom( b, c )            #
# cohom_beta_alpha: Cohom( c, b ) -> Cohom( d, a )            #
#                                                             #
# cohom_alpha_beta_transposed: Cohom( b, c ) -> Cohom( a, d ) #
# cohom_beta_alpha_transposed: Cohom( d, a ) -> Cohom( c, b ) #
#                                                             #
###############################################################

gap> UnderlyingMatrix( hom_to_tensor_right_adjunction_on_hom_alpha_beta ) = TransposedMatrix( UnderlyingMatrix( cohom_to_tensor_right_adjunction_on_cohom_beta_alpha_transposed ) ); # Hom( b, c ) x a -> d  ==  Tr( d -> Cohom( c, b ) x a )
true

gap> UnderlyingMatrix( hom_to_tensor_right_adjunction_on_hom_beta_alpha ) = TransposedMatrix( UnderlyingMatrix( cohom_to_tensor_right_adjunction_on_cohom_alpha_beta_transposed ) ); # Hom( d, a ) x c -> b  ==  Tr( b -> Cohom( a, d ) x c )
true

gap> UnderlyingMatrix( cohom_to_tensor_right_adjunction_on_cohom_alpha_beta ) = TransposedMatrix( UnderlyingMatrix( hom_to_tensor_right_adjunction_on_hom_beta_alpha_transposed ) ); # a -> Cohom( b, c ) x d  ==  Tr( Hom( c, b ) x d -> a )
true

gap> UnderlyingMatrix( cohom_to_tensor_right_adjunction_on_cohom_beta_alpha ) = TransposedMatrix( UnderlyingMatrix( hom_to_tensor_right_adjunction_on_hom_alpha_beta_transposed ) ); # c -> Cohom( d, a ) x b  ==  Tr( Hom( a, d ) x b -> c )
true

#####################################################
# Pre and post (co)composition
#####################################################

gap> precompose_abc := MonoidalPreComposeMorphism( a, b, c );;
gap> precompose_cba := MonoidalPreComposeMorphism( c, b, a );;

gap> precocompose_abc := MonoidalPreCoComposeMorphism( a, b, c );;
gap> precocompose_cba := MonoidalPreCoComposeMorphism( c, b, a );;

gap> postcompose_abc := MonoidalPostComposeMorphism( a, b, c );;
gap> postcompose_cba := MonoidalPostComposeMorphism( c, b, a );;

gap> postcocompose_abc := MonoidalPostCoComposeMorphism( a, b, c );;
gap> postcocompose_cba := MonoidalPostCoComposeMorphism( c, b, a );;

# Correspondence on compositions

gap> UnderlyingMatrix( precompose_abc ) = TransposedMatrix( UnderlyingMatrix( precocompose_cba ) );
true
gap> UnderlyingMatrix( precompose_cba ) = TransposedMatrix( UnderlyingMatrix( precocompose_abc ) );
true

gap> UnderlyingMatrix( postcocompose_abc ) = TransposedMatrix( UnderlyingMatrix( postcompose_cba ) );
true
gap> UnderlyingMatrix( postcocompose_cba ) = TransposedMatrix( UnderlyingMatrix( postcompose_abc ) );
true

#####################################################
# (Co)Duals
#####################################################

gap> a_dual := DualOnObjects( a );;
gap> b_dual := DualOnObjects( b );;

gap> a_codual := CoDualOnObjects( a );;
gap> b_codual := CoDualOnObjects( b );;

# (Co)Dual morphisms for rows

gap> dual_id_a_tensor_b := DualOnMorphisms( id_a_tensor_b );;
gap> dual_id_b_tensor_a := DualOnMorphisms( id_b_tensor_a );;

gap> dual_hom_alpha_beta := DualOnMorphisms( hom_alpha_beta );;
gap> dual_hom_beta_alpha := DualOnMorphisms( hom_beta_alpha );;

gap> dual_coev_ab := DualOnMorphisms( left_coev_ab );;
gap> dual_coev_ba := DualOnMorphisms( left_coev_ba );;

gap> codual_id_a_tensor_b := CoDualOnMorphisms( id_a_tensor_b );;
gap> codual_id_b_tensor_a := CoDualOnMorphisms( id_b_tensor_a );;

gap> codual_cohom_alpha_beta := CoDualOnMorphisms( cohom_alpha_beta );;
gap> codual_cohom_beta_alpha := CoDualOnMorphisms( cohom_beta_alpha );;

gap> codual_cocl_coev_ab := CoDualOnMorphisms( left_cocl_coev_ab );;
gap> codual_cocl_coev_ba := CoDualOnMorphisms( left_cocl_coev_ba );;

# Correspondence on duals

gap> a_dual = a_codual;
true
gap> b_dual = b_codual;
true

gap> dual_id_a_tensor_b = codual_id_a_tensor_b;
true
gap> dual_id_b_tensor_a = codual_id_b_tensor_a;
true

gap> dual_hom_alpha_beta = codual_cohom_beta_alpha;
true
gap> dual_hom_beta_alpha = codual_cohom_alpha_beta;
true

gap> UnderlyingMatrix( dual_coev_ab ) = TransposedMatrix( UnderlyingMatrix( codual_cocl_coev_ab ) );
true
gap> UnderlyingMatrix( dual_coev_ba ) = TransposedMatrix( UnderlyingMatrix( codual_cocl_coev_ba ) );
true

#####################################################
# Evaluation for (co)dual
#####################################################

gap> ev_for_dual_a := EvaluationForDual( a );;
gap> ev_for_dual_b := EvaluationForDual( b );;
gap> ev_for_dual_0 := EvaluationForDual( z );;

gap> cocl_ev_for_codual_a := CoclosedEvaluationForCoDual( a );;
gap> cocl_ev_for_codual_b := CoclosedEvaluationForCoDual( b );;
gap> cocl_ev_for_codual_0 := CoclosedEvaluationForCoDual( z );;

# Opposite correspondence

gap> UnderlyingMatrix( ev_for_dual_a ) = TransposedMatrix( UnderlyingMatrix( cocl_ev_for_codual_a ) );
true
gap> UnderlyingMatrix( ev_for_dual_b ) = TransposedMatrix( UnderlyingMatrix( cocl_ev_for_codual_b ) );
true
gap> UnderlyingMatrix( ev_for_dual_0 ) = TransposedMatrix( UnderlyingMatrix( cocl_ev_for_codual_0 ) );
true

gap> UnderlyingMatrix( ev_for_dual_a ) = TransposedMatrix( UnderlyingMatrix( cocl_ev_for_codual_b ) );
false
gap> UnderlyingMatrix( ev_for_dual_b ) = TransposedMatrix( UnderlyingMatrix( cocl_ev_for_codual_a ) );
false
gap> UnderlyingMatrix( ev_for_dual_0 ) = TransposedMatrix( UnderlyingMatrix( cocl_ev_for_codual_a ) );
false

gap> UnderlyingMatrix( cocl_ev_for_codual_a ) = TransposedMatrix( UnderlyingMatrix( ev_for_dual_b ) );
false
gap> UnderlyingMatrix( cocl_ev_for_codual_b ) = TransposedMatrix( UnderlyingMatrix( ev_for_dual_a ) );
false
gap> UnderlyingMatrix( cocl_ev_for_codual_0 ) = TransposedMatrix( UnderlyingMatrix( ev_for_dual_b ) );
false

# Check consistency with the general (coclosed) evaluation morphism

gap> ev_for_dual_a = ClosedMonoidalLeftEvaluationMorphism( a, u );
true
gap> ev_for_dual_b = ClosedMonoidalLeftEvaluationMorphism( b, u );
true
gap> ev_for_dual_0 = ClosedMonoidalLeftEvaluationMorphism( z, u );
true

gap> cocl_ev_for_codual_a = CoclosedMonoidalLeftEvaluationMorphism( a, u );
true
gap> cocl_ev_for_codual_b = CoclosedMonoidalLeftEvaluationMorphism( b, u );
true
gap> cocl_ev_for_codual_0 = CoclosedMonoidalLeftEvaluationMorphism( z, u );
true

#####################################################
# (Co)Bidual
#####################################################

gap> morphism_to_bidual_a := MorphismToBidual( a );;
gap> morphism_to_bidual_b := MorphismToBidual( b );;
gap> morphism_to_bidual_c := MorphismToBidual( c );;
gap> morphism_to_bidual_d := MorphismToBidual( d );;

gap> morphism_from_cobidual_a := MorphismFromCoBidual( a );;
gap> morphism_from_cobidual_b := MorphismFromCoBidual( b );;
gap> morphism_from_cobidual_c := MorphismFromCoBidual( c );;
gap> morphism_from_cobidual_d := MorphismFromCoBidual( d );;

# Correspondence

gap> UnderlyingMatrix( morphism_to_bidual_a ) = TransposedMatrix( UnderlyingMatrix( morphism_from_cobidual_a ) );
true
gap> UnderlyingMatrix( morphism_to_bidual_b ) = TransposedMatrix( UnderlyingMatrix( morphism_from_cobidual_b ) );
true
gap> UnderlyingMatrix( morphism_to_bidual_c ) = TransposedMatrix( UnderlyingMatrix( morphism_from_cobidual_c ) );
true
gap> UnderlyingMatrix( morphism_to_bidual_d ) = TransposedMatrix( UnderlyingMatrix( morphism_from_cobidual_d ) );
true

gap> UnderlyingMatrix( morphism_to_bidual_a ) = TransposedMatrix( UnderlyingMatrix( morphism_from_cobidual_b ) );
false
gap> UnderlyingMatrix( morphism_to_bidual_b ) = TransposedMatrix( UnderlyingMatrix( morphism_from_cobidual_a ) );
false
gap> UnderlyingMatrix( morphism_to_bidual_c ) = TransposedMatrix( UnderlyingMatrix( morphism_from_cobidual_d ) );
false
gap> UnderlyingMatrix( morphism_to_bidual_d ) = TransposedMatrix( UnderlyingMatrix( morphism_from_cobidual_c ) );
false

#############################################################
# Tensor product and internal (co)hom compatibility
#############################################################

# gap> tensor_to_hom_compatibility_abcd := TensorProductInternalHomCompatibilityMorphism( [ a, b, c, d ] );; # Hom( a, b ) x Hom( c, d ) -> Hom( a x c, b x d )
# gap> tensor_to_hom_compatibility_cadb := TensorProductInternalHomCompatibilityMorphism( [ c, a, d, b ] );; # Hom( c, a ) x Hom( d, b ) -> Hom( c x d, a x b )

# gap> cohom_to_tensor_compatibility_abcd := InternalCoHomTensorProductCompatibilityMorphism( [ a, b, c, d ] );; # Cohom( a x b, c x d ) -> Cohom( a, c ) x Cohom( b, d )
# gap> cohom_to_tensor_compatibility_bdac := InternalCoHomTensorProductCompatibilityMorphism( [ b, d, a, c ] );; # Cohom( b x d, a x c ) -> Cohom( b, a ) x Cohom( d, c )

# # Correspondence

# gap> UnderlyingMatrix( tensor_to_hom_compatibility_abcd ) = TransposedMatrix( UnderlyingMatrix( cohom_to_tensor_compatibility_bdac ) ); # Hom( a, b ) x Hom( c, d ) -> Hom( a x c, b x d )  ==  op( Cohom( b x d, a x c ) -> Cohom( b, a ) x Cohom( d, c ) )
# true
# gap> UnderlyingMatrix( tensor_to_hom_compatibility_cadb ) = TransposedMatrix( UnderlyingMatrix( cohom_to_tensor_compatibility_abcd ) ); # Hom( c, a ) x Hom( d, b ) -> Hom( c x d, a x b )  ==  op( Cohom( a x b, c x d ) -> Cohom( a, c ) x Cohom( b, d ) )
# true

# gap> UnderlyingMatrix( cohom_to_tensor_compatibility_abcd ) = TransposedMatrix( UnderlyingMatrix( tensor_to_hom_compatibility_cadb ) ); # Cohom( a x b, c x d ) -> Cohom( a, c ) x Cohom( b, d )  ==  op( Hom( c, a ) x Hom( d, b ) -> Hom( c x d, a x b ) )
# true
# gap> UnderlyingMatrix( cohom_to_tensor_compatibility_bdac ) = TransposedMatrix( UnderlyingMatrix( tensor_to_hom_compatibility_abcd ) ); # Cohom( b x d, a x c ) -> Cohom( b, a ) x Cohom( d, c )  ==  op( Hom( a, b ) x Hom( c, d ) -> Hom( a x c, b x d ) )
# true

# gap> UnderlyingMatrix( tensor_to_hom_compatibility_abcd ) = TransposedMatrix( UnderlyingMatrix( cohom_to_tensor_compatibility_abcd ) ); # Hom( a, b ) x Hom( c, d ) -> Hom( a x c, b x d )  =/=  op( Cohom( a x b, c x d ) -> Cohom( a, c ) x Cohom( b, d ) )
# false
# gap> UnderlyingMatrix( tensor_to_hom_compatibility_cadb ) = TransposedMatrix( UnderlyingMatrix( cohom_to_tensor_compatibility_bdac ) ); # Hom( c, a ) x Hom( d, b ) -> Hom( c x d, a x b )  =/=  op( Cohom( b x d, a x c ) -> Cohom( b, a ) x Cohom( d, c ) )
# false

# gap> UnderlyingMatrix( cohom_to_tensor_compatibility_abcd ) = TransposedMatrix( UnderlyingMatrix( tensor_to_hom_compatibility_abcd ) ); # Cohom( a x b, c x d ) -> Cohom( a, c ) x Cohom( b, d )  =/=  op( Hom( a, b ) x Hom( c, d ) -> Hom( a x c, b x d ) )
# false
# gap> UnderlyingMatrix( cohom_to_tensor_compatibility_bdac ) = TransposedMatrix( UnderlyingMatrix( tensor_to_hom_compatibility_cadb ) ); # Cohom( b x d, a x c ) -> Cohom( b, a ) x Cohom( d, c )  =/=  op( Hom( c, a ) x Hom( d, b ) -> Hom( c x d, a x b ) )
# false

#########################################################
# Tensor product duality compatibility
#########################################################

# (Co)Duality compatibility

gap> tensor_product_duality_compatibility_ab := TensorProductDualityCompatibilityMorphism( a, b );; # a^v x b^v -> (a x b)^v
gap> tensor_product_duality_compatibility_ba := TensorProductDualityCompatibilityMorphism( b, a );; # b^v x a^v -> (b x a)^v
gap> tensor_product_duality_compatibility_cd := TensorProductDualityCompatibilityMorphism( c, d );; # c^v x d^v -> (c x d)^v
gap> tensor_product_duality_compatibility_dc := TensorProductDualityCompatibilityMorphism( d, c );; # d^v x c^v -> (d x c)^v

gap> coduality_tensor_product_compatibility_ab := CoDualityTensorProductCompatibilityMorphism( a, b );; # (a x b)_v -> a_v x b_v
gap> coduality_tensor_product_compatibility_ba := CoDualityTensorProductCompatibilityMorphism( b, a );; # (b x a)_v -> b_v x a_v
gap> coduality_tensor_product_compatibility_cd := CoDualityTensorProductCompatibilityMorphism( c, d );; # (c x d)_v -> c_v x d_v
gap> coduality_tensor_product_compatibility_dc := CoDualityTensorProductCompatibilityMorphism( d, c );; # (d x c)_v -> d_v x c_v

# Tensor product internal (co)hom compatibility with units

gap> tensor_product_to_hom_compatibility_a1b1 := TensorProductInternalHomCompatibilityMorphism( [ a, u, b, u ] );; # Hom( a, 1 ) x Hom( b, 1 ) -> Hom( a x b, 1 x 1 )
gap> tensor_product_to_hom_compatibility_b1a1 := TensorProductInternalHomCompatibilityMorphism( [ b, u, a, u ] );; # Hom( b, 1 ) x Hom( a, 1 ) -> Hom( b x a, 1 x 1 )
gap> tensor_product_to_hom_compatibility_c1d1 := TensorProductInternalHomCompatibilityMorphism( [ c, u, d, u ] );; # Hom( c, 1 ) x Hom( d, 1 ) -> Hom( c x d, 1 x 1 )
gap> tensor_product_to_hom_compatibility_d1c1 := TensorProductInternalHomCompatibilityMorphism( [ d, u, c, u ] );; # Hom( d, 1 ) x Hom( c, 1 ) -> Hom( d x c, 1 x 1 )

gap> cohom_to_tensor_product_compatibility_1a1b := InternalCoHomTensorProductCompatibilityMorphism( [ u, a, u, b ] );; # Cohom( 1 x a, 1 x b ) -> Cohom( 1, a ) x Cohom( 1, b )
gap> cohom_to_tensor_product_compatibility_1b1a := InternalCoHomTensorProductCompatibilityMorphism( [ u, b, u, a ] );; # Cohom( 1 x b, 1 x a ) -> Cohom( 1, b ) x Cohom( 1, a )
gap> cohom_to_tensor_product_compatibility_1c1d := InternalCoHomTensorProductCompatibilityMorphism( [ u, c, u, d ] );; # Cohom( 1 x c, 1 x d ) -> Cohom( 1, c ) x Cohom( 1, d )
gap> cohom_to_tensor_product_compatibility_1d1c := InternalCoHomTensorProductCompatibilityMorphism( [ u, d, u, c ] );; # Cohom( 1 x d, 1 x c ) -> Cohom( 1, d ) x Cohom( 1, c )

# Correspondence on (co)duality compatibility

gap> UnderlyingMatrix( tensor_product_duality_compatibility_ab ) = TransposedMatrix( UnderlyingMatrix( coduality_tensor_product_compatibility_ab ) );
true
gap> UnderlyingMatrix( tensor_product_duality_compatibility_ba ) = TransposedMatrix( UnderlyingMatrix( coduality_tensor_product_compatibility_ba ) );
true
gap> UnderlyingMatrix( tensor_product_duality_compatibility_cd ) = TransposedMatrix( UnderlyingMatrix( coduality_tensor_product_compatibility_cd ) );
true
gap> UnderlyingMatrix( tensor_product_duality_compatibility_dc ) = TransposedMatrix( UnderlyingMatrix( coduality_tensor_product_compatibility_dc ) );
true

gap> UnderlyingMatrix( tensor_product_duality_compatibility_ab ) = TransposedMatrix( UnderlyingMatrix( coduality_tensor_product_compatibility_cd ) );
false
gap> UnderlyingMatrix( tensor_product_duality_compatibility_ab ) = TransposedMatrix( UnderlyingMatrix( coduality_tensor_product_compatibility_dc ) );
false
gap> UnderlyingMatrix( tensor_product_duality_compatibility_cd ) = TransposedMatrix( UnderlyingMatrix( coduality_tensor_product_compatibility_ab ) );
false
gap> UnderlyingMatrix( tensor_product_duality_compatibility_cd ) = TransposedMatrix( UnderlyingMatrix( coduality_tensor_product_compatibility_ba ) );
false

gap> UnderlyingMatrix( coduality_tensor_product_compatibility_ba ) = TransposedMatrix( UnderlyingMatrix( tensor_product_duality_compatibility_cd ) );
false
gap> UnderlyingMatrix( coduality_tensor_product_compatibility_ba ) = TransposedMatrix( UnderlyingMatrix( tensor_product_duality_compatibility_dc ) );
false
gap> UnderlyingMatrix( coduality_tensor_product_compatibility_dc ) = TransposedMatrix( UnderlyingMatrix( tensor_product_duality_compatibility_ab ) );
false
gap> UnderlyingMatrix( coduality_tensor_product_compatibility_dc ) = TransposedMatrix( UnderlyingMatrix( tensor_product_duality_compatibility_ba ) );
false

# Correspondence

gap> UnderlyingMatrix( tensor_product_duality_compatibility_ab ) = TransposedMatrix( UnderlyingMatrix( cohom_to_tensor_product_compatibility_1a1b ) );
true
gap> UnderlyingMatrix( tensor_product_duality_compatibility_ba ) = TransposedMatrix( UnderlyingMatrix( cohom_to_tensor_product_compatibility_1b1a ) );
true
gap> UnderlyingMatrix( tensor_product_duality_compatibility_cd ) = TransposedMatrix( UnderlyingMatrix( cohom_to_tensor_product_compatibility_1c1d ) );
true
gap> UnderlyingMatrix( tensor_product_duality_compatibility_dc ) = TransposedMatrix( UnderlyingMatrix( cohom_to_tensor_product_compatibility_1d1c ) );
true

gap> UnderlyingMatrix( coduality_tensor_product_compatibility_ab ) = TransposedMatrix( UnderlyingMatrix( tensor_product_to_hom_compatibility_a1b1 ) );
true
gap> UnderlyingMatrix( coduality_tensor_product_compatibility_ba ) = TransposedMatrix( UnderlyingMatrix( tensor_product_to_hom_compatibility_b1a1 ) );
true
gap> UnderlyingMatrix( coduality_tensor_product_compatibility_cd ) = TransposedMatrix( UnderlyingMatrix( tensor_product_to_hom_compatibility_c1d1 ) );
true
gap> UnderlyingMatrix( coduality_tensor_product_compatibility_dc ) = TransposedMatrix( UnderlyingMatrix( tensor_product_to_hom_compatibility_d1c1 ) );
true

gap> UnderlyingMatrix( tensor_product_duality_compatibility_ba ) = TransposedMatrix( UnderlyingMatrix( cohom_to_tensor_product_compatibility_1c1d ) );
false
gap> UnderlyingMatrix( tensor_product_duality_compatibility_ba ) = TransposedMatrix( UnderlyingMatrix( cohom_to_tensor_product_compatibility_1d1c ) );
false
gap> UnderlyingMatrix( tensor_product_duality_compatibility_dc ) = TransposedMatrix( UnderlyingMatrix( cohom_to_tensor_product_compatibility_1a1b ) );
false
gap> UnderlyingMatrix( tensor_product_duality_compatibility_dc ) = TransposedMatrix( UnderlyingMatrix( cohom_to_tensor_product_compatibility_1b1a ) );
false

gap> UnderlyingMatrix( coduality_tensor_product_compatibility_ab ) = TransposedMatrix( UnderlyingMatrix( tensor_product_to_hom_compatibility_c1d1 ) );
false
gap> UnderlyingMatrix( coduality_tensor_product_compatibility_ab ) = TransposedMatrix( UnderlyingMatrix( tensor_product_to_hom_compatibility_d1c1 ) );
false
gap> UnderlyingMatrix( coduality_tensor_product_compatibility_cd ) = TransposedMatrix( UnderlyingMatrix( tensor_product_to_hom_compatibility_a1b1 ) );
false
gap> UnderlyingMatrix( coduality_tensor_product_compatibility_cd ) = TransposedMatrix( UnderlyingMatrix( tensor_product_to_hom_compatibility_b1a1 ) );
false

# Consistency with internal (co)hom compatibility with units

gap> tensor_product_duality_compatibility_ab = tensor_product_to_hom_compatibility_a1b1;
true
gap> tensor_product_duality_compatibility_ba = tensor_product_to_hom_compatibility_b1a1;
true
gap> tensor_product_duality_compatibility_cd = tensor_product_to_hom_compatibility_c1d1;
true
gap> tensor_product_duality_compatibility_dc = tensor_product_to_hom_compatibility_d1c1;
true

gap> coduality_tensor_product_compatibility_ab = cohom_to_tensor_product_compatibility_1a1b;
true
gap> coduality_tensor_product_compatibility_ba = cohom_to_tensor_product_compatibility_1b1a;
true
gap> coduality_tensor_product_compatibility_cd = cohom_to_tensor_product_compatibility_1c1d;
true
gap> coduality_tensor_product_compatibility_dc = cohom_to_tensor_product_compatibility_1d1c;
true

#########################################################
# Morphism from tensor product to internal hom
#########################################################

# Morphism from tensor product to internal hom

gap> morphism_from_tensor_product_to_hom_ab := MorphismFromTensorProductToInternalHom( a, b );;
gap> morphism_from_tensor_product_to_hom_ba := MorphismFromTensorProductToInternalHom( b, a );;
gap> morphism_from_tensor_product_to_hom_cd := MorphismFromTensorProductToInternalHom( c, d );;
gap> morphism_from_tensor_product_to_hom_dc := MorphismFromTensorProductToInternalHom( d, c );;

gap> morphism_from_cohom_to_tensor_product_ab := MorphismFromInternalCoHomToTensorProduct( a, b );;
gap> morphism_from_cohom_to_tensor_product_ba := MorphismFromInternalCoHomToTensorProduct( b, a );;
gap> morphism_from_cohom_to_tensor_product_cd := MorphismFromInternalCoHomToTensorProduct( c, d );;
gap> morphism_from_cohom_to_tensor_product_dc := MorphismFromInternalCoHomToTensorProduct( d, c );;

# Correspondence

gap> UnderlyingMatrix( morphism_from_tensor_product_to_hom_ab ) = TransposedMatrix( UnderlyingMatrix( morphism_from_cohom_to_tensor_product_ba ) );
true
gap> UnderlyingMatrix( morphism_from_tensor_product_to_hom_ba ) = TransposedMatrix( UnderlyingMatrix( morphism_from_cohom_to_tensor_product_ab ) );
true
gap> UnderlyingMatrix( morphism_from_tensor_product_to_hom_cd ) = TransposedMatrix( UnderlyingMatrix( morphism_from_cohom_to_tensor_product_cd ) );
true
gap> UnderlyingMatrix( morphism_from_tensor_product_to_hom_dc ) = TransposedMatrix( UnderlyingMatrix( morphism_from_cohom_to_tensor_product_dc ) );
true

gap> morphism_from_tensor_product_to_hom_ba = TransposedMatrix( UnderlyingMatrix( morphism_from_tensor_product_to_hom_cd ) );
false
gap> morphism_from_tensor_product_to_hom_ba = TransposedMatrix( UnderlyingMatrix( morphism_from_tensor_product_to_hom_dc ) );
false

gap> morphism_from_tensor_product_to_hom_dc = TransposedMatrix( UnderlyingMatrix( morphism_from_tensor_product_to_hom_ab ) );
false
gap> morphism_from_tensor_product_to_hom_dc = TransposedMatrix( UnderlyingMatrix( morphism_from_tensor_product_to_hom_ba ) );
false

gap> morphism_from_cohom_to_tensor_product_ab = TransposedMatrix( UnderlyingMatrix( morphism_from_tensor_product_to_hom_cd ) );
false
gap> morphism_from_cohom_to_tensor_product_ab = TransposedMatrix( UnderlyingMatrix( morphism_from_tensor_product_to_hom_dc ) );
false

gap> morphism_from_cohom_to_tensor_product_cd = TransposedMatrix( UnderlyingMatrix( morphism_from_tensor_product_to_hom_ab ) );
false
gap> morphism_from_cohom_to_tensor_product_cd = TransposedMatrix( UnderlyingMatrix( morphism_from_tensor_product_to_hom_ba ) );
false

#########################################################
# Isomorphisms between (co)dual and internal hom
#########################################################

# Isomorphism from dual to internal hom

gap> isomorphism_from_dual_to_hom_a := IsomorphismFromDualObjectToInternalHomIntoTensorUnit( a );;
gap> isomorphism_from_dual_to_hom_b := IsomorphismFromDualObjectToInternalHomIntoTensorUnit( b );;
gap> isomorphism_from_dual_to_hom_c := IsomorphismFromDualObjectToInternalHomIntoTensorUnit( c );;
gap> isomorphism_from_dual_to_hom_d := IsomorphismFromDualObjectToInternalHomIntoTensorUnit( d );;

# Isomorphism from internal hom to dual

gap> isomorphism_from_hom_to_dual_a := IsomorphismFromInternalHomIntoTensorUnitToDualObject( a );;
gap> isomorphism_from_hom_to_dual_b := IsomorphismFromInternalHomIntoTensorUnitToDualObject( b );;
gap> isomorphism_from_hom_to_dual_c := IsomorphismFromInternalHomIntoTensorUnitToDualObject( c );;
gap> isomorphism_from_hom_to_dual_d := IsomorphismFromInternalHomIntoTensorUnitToDualObject( d );;

# Isomorphism from codual to cohom

gap> isomorphism_from_codual_to_cohom_a := IsomorphismFromCoDualObjectToInternalCoHomFromTensorUnit( a );;
gap> isomorphism_from_codual_to_cohom_b := IsomorphismFromCoDualObjectToInternalCoHomFromTensorUnit( b );;
gap> isomorphism_from_codual_to_cohom_c := IsomorphismFromCoDualObjectToInternalCoHomFromTensorUnit( c );;
gap> isomorphism_from_codual_to_cohom_d := IsomorphismFromCoDualObjectToInternalCoHomFromTensorUnit( d );;

# Isomorphism from cohom to codual

gap> isomorphism_from_cohom_to_codual_a := IsomorphismFromInternalCoHomFromTensorUnitToCoDualObject( a );;
gap> isomorphism_from_cohom_to_codual_b := IsomorphismFromInternalCoHomFromTensorUnitToCoDualObject( b );;
gap> isomorphism_from_cohom_to_codual_c := IsomorphismFromInternalCoHomFromTensorUnitToCoDualObject( c );;
gap> isomorphism_from_cohom_to_codual_d := IsomorphismFromInternalCoHomFromTensorUnitToCoDualObject( d );;

# Correspondence

gap> UnderlyingMatrix( isomorphism_from_dual_to_hom_a ) = TransposedMatrix( UnderlyingMatrix( isomorphism_from_cohom_to_codual_a ) );
true
gap> UnderlyingMatrix( isomorphism_from_dual_to_hom_b ) = TransposedMatrix( UnderlyingMatrix( isomorphism_from_cohom_to_codual_b ) );
true
gap> UnderlyingMatrix( isomorphism_from_dual_to_hom_c ) = TransposedMatrix( UnderlyingMatrix( isomorphism_from_cohom_to_codual_c ) );
true
gap> UnderlyingMatrix( isomorphism_from_dual_to_hom_d ) = TransposedMatrix( UnderlyingMatrix( isomorphism_from_cohom_to_codual_d ) );
true

gap> UnderlyingMatrix( isomorphism_from_hom_to_dual_a ) = TransposedMatrix( UnderlyingMatrix( isomorphism_from_codual_to_cohom_a ) );
true
gap> UnderlyingMatrix( isomorphism_from_hom_to_dual_b ) = TransposedMatrix( UnderlyingMatrix( isomorphism_from_codual_to_cohom_b ) );
true
gap> UnderlyingMatrix( isomorphism_from_hom_to_dual_c ) = TransposedMatrix( UnderlyingMatrix( isomorphism_from_codual_to_cohom_c ) );
true
gap> UnderlyingMatrix( isomorphism_from_hom_to_dual_d ) = TransposedMatrix( UnderlyingMatrix( isomorphism_from_codual_to_cohom_d ) );
true

gap> UnderlyingMatrix( isomorphism_from_dual_to_hom_a ) = TransposedMatrix( UnderlyingMatrix( isomorphism_from_cohom_to_codual_b ) );
false
gap> UnderlyingMatrix( isomorphism_from_dual_to_hom_a ) = TransposedMatrix( UnderlyingMatrix( isomorphism_from_cohom_to_codual_c ) );
false
gap> UnderlyingMatrix( isomorphism_from_dual_to_hom_a ) = TransposedMatrix( UnderlyingMatrix( isomorphism_from_cohom_to_codual_d ) );
false

gap> UnderlyingMatrix( isomorphism_from_hom_to_dual_b ) = TransposedMatrix( UnderlyingMatrix( isomorphism_from_codual_to_cohom_a ) );
false
gap> UnderlyingMatrix( isomorphism_from_hom_to_dual_b ) = TransposedMatrix( UnderlyingMatrix( isomorphism_from_codual_to_cohom_c ) );
false
gap> UnderlyingMatrix( isomorphism_from_hom_to_dual_b ) = TransposedMatrix( UnderlyingMatrix( isomorphism_from_codual_to_cohom_d ) );
false

gap> UnderlyingMatrix( isomorphism_from_codual_to_cohom_c ) = TransposedMatrix( UnderlyingMatrix( isomorphism_from_hom_to_dual_a ) );
false
gap> UnderlyingMatrix( isomorphism_from_codual_to_cohom_c ) = TransposedMatrix( UnderlyingMatrix( isomorphism_from_hom_to_dual_b ) );
false
gap> UnderlyingMatrix( isomorphism_from_codual_to_cohom_c ) = TransposedMatrix( UnderlyingMatrix( isomorphism_from_hom_to_dual_d ) );
false

gap> UnderlyingMatrix( isomorphism_from_cohom_to_codual_d ) = TransposedMatrix( UnderlyingMatrix( isomorphism_from_dual_to_hom_a ) );
false
gap> UnderlyingMatrix( isomorphism_from_cohom_to_codual_d ) = TransposedMatrix( UnderlyingMatrix( isomorphism_from_dual_to_hom_b ) );
false
gap> UnderlyingMatrix( isomorphism_from_cohom_to_codual_d ) = TransposedMatrix( UnderlyingMatrix( isomorphism_from_dual_to_hom_c ) );
false

#########################################################
# Universal property of dual
#########################################################

gap> ab_to_1 := VectorSpaceMorphism( a_tensor_b, HomalgMatrix( [ 2 .. 7 ], Dimension( a_tensor_b ), 1, Q ), u );;
gap> cd_to_1 := VectorSpaceMorphism( c_tensor_d, HomalgMatrix( [ 8 .. 31 ], Dimension( c_tensor_d ), 1, Q ), u );;

gap> 1_to_ab := VectorSpaceMorphism( u, HomalgMatrix( [ 2 .. 7 ], 1, Dimension( a_tensor_b ), Q ), a_tensor_b );;
gap> 1_to_cd := VectorSpaceMorphism( u, HomalgMatrix( [ 8 .. 31 ], 1, Dimension( c_tensor_d ), Q ), c_tensor_d );;

gap> universal_property_of_dual_ab_to_1 := UniversalPropertyOfDual( a, b, ab_to_1 );;
gap> universal_property_of_dual_cd_to_1 := UniversalPropertyOfDual( c, d, cd_to_1 );;

gap> universal_property_of_codual_1_to_ab := UniversalPropertyOfCoDual( a, b, 1_to_ab );;
gap> universal_property_of_codual_1_to_cd := UniversalPropertyOfCoDual( c, d, 1_to_cd );;

# Correspondence

gap> UnderlyingMatrix( universal_property_of_dual_ab_to_1 ) = TransposedMatrix( UnderlyingMatrix( universal_property_of_codual_1_to_ab ) );
true
gap> UnderlyingMatrix( universal_property_of_dual_cd_to_1 ) = TransposedMatrix( UnderlyingMatrix( universal_property_of_codual_1_to_cd ) );
true

gap> UnderlyingMatrix( universal_property_of_codual_1_to_ab ) = TransposedMatrix( UnderlyingMatrix( universal_property_of_dual_ab_to_1 ) );
true
gap> UnderlyingMatrix( universal_property_of_codual_1_to_cd ) = TransposedMatrix( UnderlyingMatrix( universal_property_of_dual_cd_to_1 ) );
true

gap> UnderlyingMatrix( universal_property_of_dual_ab_to_1 ) = TransposedMatrix( UnderlyingMatrix( universal_property_of_codual_1_to_cd ) );
false
gap> UnderlyingMatrix( universal_property_of_dual_cd_to_1 ) = TransposedMatrix( UnderlyingMatrix( universal_property_of_codual_1_to_ab ) );
false

gap> UnderlyingMatrix( universal_property_of_codual_1_to_ab ) = TransposedMatrix( UnderlyingMatrix( universal_property_of_dual_cd_to_1 ) );
false
gap> UnderlyingMatrix( universal_property_of_codual_1_to_cd ) = TransposedMatrix( UnderlyingMatrix( universal_property_of_dual_ab_to_1 ) );
false

#########################################################
# Lambdas
#########################################################

# Morphisms

gap> a_to_b := [ 2 .. 7 ];;
gap> c_to_d := [ 8 .. 31 ];;

gap> a_to_b_morphism := VectorSpaceMorphism( a, HomalgMatrix( a_to_b, 2, 3, Q ), b );;
gap> b_to_a_morphism := VectorSpaceMorphism( b, TransposedMatrix( UnderlyingMatrix( a_to_b_morphism ) ), a );;
gap> c_to_d_morphism := VectorSpaceMorphism( c, HomalgMatrix( c_to_d, 6, 4, Q ), d );;
gap> d_to_c_morphism := VectorSpaceMorphism( d, TransposedMatrix( UnderlyingMatrix( c_to_d_morphism ) ), c );;

# Lambda introduction

gap> lambda_intro_a_to_b := LambdaIntroduction( a_to_b_morphism );;
gap> lambda_intro_b_to_a := LambdaIntroduction( b_to_a_morphism );;
gap> lambda_intro_c_to_d := LambdaIntroduction( c_to_d_morphism );;
gap> lambda_intro_d_to_c := LambdaIntroduction( d_to_c_morphism );;

# Colambda introduction

gap> colambda_intro_a_to_b := CoLambdaIntroduction( a_to_b_morphism );;
gap> colambda_intro_b_to_a := CoLambdaIntroduction( b_to_a_morphism );;
gap> colambda_intro_c_to_d := CoLambdaIntroduction( c_to_d_morphism );;
gap> colambda_intro_d_to_c := CoLambdaIntroduction( d_to_c_morphism );;

# Lambda elimination

gap> lambda_elim_1_to_hom_ab := LambdaElimination( a, b, lambda_intro_a_to_b );;
gap> lambda_elim_1_to_hom_ba := LambdaElimination( b, a, lambda_intro_b_to_a );;
gap> lambda_elim_1_to_hom_cd := LambdaElimination( c, d, lambda_intro_c_to_d );;
gap> lambda_elim_1_to_hom_dc := LambdaElimination( d, c, lambda_intro_d_to_c );;

# Colambda elimination

gap> colambda_elim_cohom_ab_to_1 := CoLambdaElimination( a, b, colambda_intro_a_to_b );;
gap> colambda_elim_cohom_ba_to_1 := CoLambdaElimination( b, a, colambda_intro_b_to_a );;
gap> colambda_elim_cohom_cd_to_1 := CoLambdaElimination( c, d, colambda_intro_c_to_d );;
gap> colambda_elim_cohom_dc_to_1 := CoLambdaElimination( d, c, colambda_intro_d_to_c );;

# Correspondence

gap> UnderlyingMatrix( lambda_intro_a_to_b ) = TransposedMatrix( UnderlyingMatrix( colambda_intro_b_to_a ) );
true
gap> UnderlyingMatrix( lambda_intro_b_to_a ) = TransposedMatrix( UnderlyingMatrix( colambda_intro_a_to_b ) );
true
gap> UnderlyingMatrix( lambda_intro_c_to_d ) = TransposedMatrix( UnderlyingMatrix( colambda_intro_d_to_c ) );
true
gap> UnderlyingMatrix( lambda_intro_d_to_c ) = TransposedMatrix( UnderlyingMatrix( colambda_intro_c_to_d ) );
true

gap> UnderlyingMatrix( lambda_elim_1_to_hom_ab ) = TransposedMatrix( UnderlyingMatrix( colambda_elim_cohom_ba_to_1 ) );
true
gap> UnderlyingMatrix( lambda_elim_1_to_hom_ba ) = TransposedMatrix( UnderlyingMatrix( colambda_elim_cohom_ab_to_1 ) );
true
gap> UnderlyingMatrix( lambda_elim_1_to_hom_cd ) = TransposedMatrix( UnderlyingMatrix( colambda_elim_cohom_dc_to_1 ) );
true
gap> UnderlyingMatrix( lambda_elim_1_to_hom_dc ) = TransposedMatrix( UnderlyingMatrix( colambda_elim_cohom_cd_to_1 ) );
true

gap> UnderlyingMatrix( lambda_intro_a_to_b ) = TransposedMatrix( UnderlyingMatrix( colambda_intro_a_to_b ) );
false
gap> UnderlyingMatrix( lambda_intro_a_to_b ) = TransposedMatrix( UnderlyingMatrix( colambda_intro_c_to_d ) );
false
gap> UnderlyingMatrix( lambda_intro_a_to_b ) = TransposedMatrix( UnderlyingMatrix( colambda_intro_d_to_c ) );
false

gap> UnderlyingMatrix( lambda_elim_1_to_hom_ba ) = TransposedMatrix( UnderlyingMatrix( colambda_elim_cohom_ba_to_1 ) );
false
gap> UnderlyingMatrix( lambda_elim_1_to_hom_ba ) = TransposedMatrix( UnderlyingMatrix( colambda_elim_cohom_cd_to_1 ) );
false
gap> UnderlyingMatrix( lambda_elim_1_to_hom_ba ) = TransposedMatrix( UnderlyingMatrix( colambda_elim_cohom_dc_to_1 ) );
false

gap> UnderlyingMatrix( colambda_intro_c_to_d ) = TransposedMatrix( UnderlyingMatrix( lambda_intro_c_to_d ) );
false
gap> UnderlyingMatrix( colambda_intro_c_to_d ) = TransposedMatrix( UnderlyingMatrix( lambda_intro_a_to_b ) );
false
gap> UnderlyingMatrix( colambda_intro_c_to_d ) = TransposedMatrix( UnderlyingMatrix( lambda_intro_b_to_a ) );
false

gap> UnderlyingMatrix( colambda_elim_cohom_dc_to_1 ) = TransposedMatrix( UnderlyingMatrix( lambda_elim_1_to_hom_dc ) );
false
gap> UnderlyingMatrix( colambda_elim_cohom_dc_to_1 ) = TransposedMatrix( UnderlyingMatrix( lambda_elim_1_to_hom_ab ) );
false
gap> UnderlyingMatrix( colambda_elim_cohom_dc_to_1 ) = TransposedMatrix( UnderlyingMatrix( lambda_elim_1_to_hom_ba ) );
false

#########################################################
# Isomorphisms between object and internal hom
#########################################################

# Isomorphism from object to internal hom

gap> isomorphism_from_a_to_hom := IsomorphismFromObjectToInternalCoHom( a );;
gap> isomorphism_from_b_to_hom := IsomorphismFromObjectToInternalCoHom( b );;
gap> isomorphism_from_c_to_hom := IsomorphismFromObjectToInternalCoHom( c );;
gap> isomorphism_from_d_to_hom := IsomorphismFromObjectToInternalCoHom( d );;
gap> isomorphism_from_0_to_hom := IsomorphismFromObjectToInternalCoHom( z );;

# Isomorphism from internal hom to object

gap> isomorphism_from_hom_to_a := IsomorphismFromInternalHomToObject( a );;
gap> isomorphism_from_hom_to_b := IsomorphismFromInternalHomToObject( b );;
gap> isomorphism_from_hom_to_c := IsomorphismFromInternalHomToObject( c );;
gap> isomorphism_from_hom_to_d := IsomorphismFromInternalHomToObject( d );;
gap> isomorphism_from_hom_to_0 := IsomorphismFromInternalHomToObject( z );;

# Isomorphism from object to internal cohom

gap> isomorphism_from_a_to_cohom := IsomorphismFromObjectToInternalCoHom( a );;
gap> isomorphism_from_b_to_cohom := IsomorphismFromObjectToInternalCoHom( b );;
gap> isomorphism_from_c_to_cohom := IsomorphismFromObjectToInternalCoHom( c );;
gap> isomorphism_from_d_to_cohom := IsomorphismFromObjectToInternalCoHom( d );;
gap> isomorphism_from_0_to_cohom := IsomorphismFromObjectToInternalCoHom( z );;

# Isomorphism from internal cohom to object

gap> isomorphism_from_cohom_to_a := IsomorphismFromInternalCoHomToObject( a );;
gap> isomorphism_from_cohom_to_b := IsomorphismFromInternalCoHomToObject( b );;
gap> isomorphism_from_cohom_to_c := IsomorphismFromInternalCoHomToObject( c );;
gap> isomorphism_from_cohom_to_d := IsomorphismFromInternalCoHomToObject( d );;
gap> isomorphism_from_cohom_to_0 := IsomorphismFromInternalCoHomToObject( z );;

# Correspondence

gap> UnderlyingMatrix( isomorphism_from_a_to_hom ) = TransposedMatrix( UnderlyingMatrix( isomorphism_from_cohom_to_a ) );
true
gap> UnderlyingMatrix( isomorphism_from_b_to_hom ) = TransposedMatrix( UnderlyingMatrix( isomorphism_from_cohom_to_b ) );
true
gap> UnderlyingMatrix( isomorphism_from_c_to_hom ) = TransposedMatrix( UnderlyingMatrix( isomorphism_from_cohom_to_c ) );
true
gap> UnderlyingMatrix( isomorphism_from_d_to_hom ) = TransposedMatrix( UnderlyingMatrix( isomorphism_from_cohom_to_d ) );
true
gap> UnderlyingMatrix( isomorphism_from_0_to_hom ) = TransposedMatrix( UnderlyingMatrix( isomorphism_from_cohom_to_0 ) );
true

gap> UnderlyingMatrix( isomorphism_from_hom_to_a ) = TransposedMatrix( UnderlyingMatrix( isomorphism_from_a_to_cohom ) );
true
gap> UnderlyingMatrix( isomorphism_from_hom_to_b ) = TransposedMatrix( UnderlyingMatrix( isomorphism_from_b_to_cohom ) );
true
gap> UnderlyingMatrix( isomorphism_from_hom_to_c ) = TransposedMatrix( UnderlyingMatrix( isomorphism_from_c_to_cohom ) );
true
gap> UnderlyingMatrix( isomorphism_from_hom_to_d ) = TransposedMatrix( UnderlyingMatrix( isomorphism_from_d_to_cohom ) );
true
gap> UnderlyingMatrix( isomorphism_from_hom_to_0 ) = TransposedMatrix( UnderlyingMatrix( isomorphism_from_0_to_cohom ) );
true

gap> UnderlyingMatrix( isomorphism_from_a_to_hom ) = TransposedMatrix( UnderlyingMatrix( isomorphism_from_cohom_to_b ) );
false
gap> UnderlyingMatrix( isomorphism_from_a_to_hom ) = TransposedMatrix( UnderlyingMatrix( isomorphism_from_cohom_to_c ) );
false
gap> UnderlyingMatrix( isomorphism_from_a_to_hom ) = TransposedMatrix( UnderlyingMatrix( isomorphism_from_cohom_to_d ) );
false
gap> UnderlyingMatrix( isomorphism_from_a_to_hom ) = TransposedMatrix( UnderlyingMatrix( isomorphism_from_cohom_to_0 ) );
false

gap> UnderlyingMatrix( isomorphism_from_hom_to_b ) = TransposedMatrix( UnderlyingMatrix( isomorphism_from_a_to_cohom ) );
false
gap> UnderlyingMatrix( isomorphism_from_hom_to_b ) = TransposedMatrix( UnderlyingMatrix( isomorphism_from_c_to_cohom ) );
false
gap> UnderlyingMatrix( isomorphism_from_hom_to_b ) = TransposedMatrix( UnderlyingMatrix( isomorphism_from_d_to_cohom ) );
false
gap> UnderlyingMatrix( isomorphism_from_hom_to_b ) = TransposedMatrix( UnderlyingMatrix( isomorphism_from_0_to_cohom ) );
false

gap> UnderlyingMatrix( isomorphism_from_c_to_cohom ) = TransposedMatrix( UnderlyingMatrix( isomorphism_from_hom_to_a ) );
false
gap> UnderlyingMatrix( isomorphism_from_c_to_cohom ) = TransposedMatrix( UnderlyingMatrix( isomorphism_from_hom_to_b ) );
false
gap> UnderlyingMatrix( isomorphism_from_c_to_cohom ) = TransposedMatrix( UnderlyingMatrix( isomorphism_from_hom_to_d ) );
false
gap> UnderlyingMatrix( isomorphism_from_c_to_cohom ) = TransposedMatrix( UnderlyingMatrix( isomorphism_from_hom_to_0 ) );
false

gap> UnderlyingMatrix( isomorphism_from_cohom_to_d ) = TransposedMatrix( UnderlyingMatrix( isomorphism_from_a_to_hom ) );
false
gap> UnderlyingMatrix( isomorphism_from_cohom_to_d ) = TransposedMatrix( UnderlyingMatrix( isomorphism_from_b_to_hom ) );
false
gap> UnderlyingMatrix( isomorphism_from_cohom_to_d ) = TransposedMatrix( UnderlyingMatrix( isomorphism_from_c_to_hom ) );
false
gap> UnderlyingMatrix( isomorphism_from_cohom_to_d ) = TransposedMatrix( UnderlyingMatrix( isomorphism_from_0_to_hom ) );
false

# ------------------------------------------------------------------------ Rigid structure ----------------------------------------------------------------------

#######################################################################
# Isomorphisms between internal (co)homs and tensor products
#######################################################################

# Isomorphism from tensor product to internal hom

gap> isomorphism_from_tensor_to_hom_ab := IsomorphismFromTensorProductWithDualObjectToInternalHom( a, b );;
gap> isomorphism_from_tensor_to_hom_ba := IsomorphismFromTensorProductWithDualObjectToInternalHom( b, a );;
gap> isomorphism_from_tensor_to_hom_cd := IsomorphismFromTensorProductWithDualObjectToInternalHom( c, d );;
gap> isomorphism_from_tensor_to_hom_dc := IsomorphismFromTensorProductWithDualObjectToInternalHom( d, c );;

# isomorphism from tensor product to internal cohom

gap> isomorphism_from_tensor_to_cohom_ab := IsomorphismFromTensorProductWithCoDualObjectToInternalCoHom( a, b );;
gap> isomorphism_from_tensor_to_cohom_ba := IsomorphismFromTensorProductWithCoDualObjectToInternalCoHom( b, a );;
gap> isomorphism_from_tensor_to_cohom_cd := IsomorphismFromTensorProductWithCoDualObjectToInternalCoHom( c, d );;
gap> isomorphism_from_tensor_to_cohom_dc := IsomorphismFromTensorProductWithCoDualObjectToInternalCoHom( d, c );;

# Isomorphism from internal hom to tensor product

gap> isomorphism_from_hom_to_tensor_ab := IsomorphismFromInternalHomToTensorProductWithDualObject( a, b );;
gap> isomorphism_from_hom_to_tensor_ba := IsomorphismFromInternalHomToTensorProductWithDualObject( b, a );;
gap> isomorphism_from_hom_to_tensor_cd := IsomorphismFromInternalHomToTensorProductWithDualObject( c, d );;
gap> isomorphism_from_hom_to_tensor_dc := IsomorphismFromInternalHomToTensorProductWithDualObject( d, c );;

# Isomorphism from internal cohom to tensor product

gap> isomorphism_from_cohom_to_tensor_ab := IsomorphismFromInternalCoHomToTensorProductWithCoDualObject( a, b );;
gap> isomorphism_from_cohom_to_tensor_ba := IsomorphismFromInternalCoHomToTensorProductWithCoDualObject( b, a );;
gap> isomorphism_from_cohom_to_tensor_cd := IsomorphismFromInternalCoHomToTensorProductWithCoDualObject( c, d );;
gap> isomorphism_from_cohom_to_tensor_dc := IsomorphismFromInternalCoHomToTensorProductWithCoDualObject( d, c );;

# Correspondence

gap> UnderlyingMatrix( isomorphism_from_tensor_to_hom_ab ) = TransposedMatrix( UnderlyingMatrix( isomorphism_from_cohom_to_tensor_ba ) );
true
gap> UnderlyingMatrix( isomorphism_from_tensor_to_hom_ba ) = TransposedMatrix( UnderlyingMatrix( isomorphism_from_cohom_to_tensor_ab ) );
true
gap> UnderlyingMatrix( isomorphism_from_tensor_to_hom_cd ) = TransposedMatrix( UnderlyingMatrix( isomorphism_from_cohom_to_tensor_dc ) );
true
gap> UnderlyingMatrix( isomorphism_from_tensor_to_hom_dc ) = TransposedMatrix( UnderlyingMatrix( isomorphism_from_cohom_to_tensor_cd ) );
true

gap> UnderlyingMatrix( isomorphism_from_hom_to_tensor_ab ) = TransposedMatrix( UnderlyingMatrix( isomorphism_from_tensor_to_cohom_ab ) );
true
gap> UnderlyingMatrix( isomorphism_from_hom_to_tensor_ba ) = TransposedMatrix( UnderlyingMatrix( isomorphism_from_tensor_to_cohom_ba ) );
true
gap> UnderlyingMatrix( isomorphism_from_hom_to_tensor_cd ) = TransposedMatrix( UnderlyingMatrix( isomorphism_from_tensor_to_cohom_cd ) );
true
gap> UnderlyingMatrix( isomorphism_from_hom_to_tensor_dc ) = TransposedMatrix( UnderlyingMatrix( isomorphism_from_tensor_to_cohom_dc ) );
true

gap> UnderlyingMatrix( isomorphism_from_tensor_to_hom_dc ) = TransposedMatrix( UnderlyingMatrix( isomorphism_from_cohom_to_tensor_ab ) );
false
gap> UnderlyingMatrix( isomorphism_from_tensor_to_hom_dc ) = TransposedMatrix( UnderlyingMatrix( isomorphism_from_cohom_to_tensor_ba ) );
false

gap> UnderlyingMatrix( isomorphism_from_tensor_to_cohom_cd ) = TransposedMatrix( UnderlyingMatrix( isomorphism_from_hom_to_tensor_ab ) );
false
gap> UnderlyingMatrix( isomorphism_from_tensor_to_cohom_cd ) = TransposedMatrix( UnderlyingMatrix( isomorphism_from_hom_to_tensor_ba ) );
false

gap> UnderlyingMatrix( isomorphism_from_hom_to_tensor_ba ) = TransposedMatrix( UnderlyingMatrix( isomorphism_from_tensor_to_cohom_cd ) );
false
gap> UnderlyingMatrix( isomorphism_from_hom_to_tensor_ba ) = TransposedMatrix( UnderlyingMatrix( isomorphism_from_tensor_to_cohom_dc ) );
false

gap> UnderlyingMatrix( isomorphism_from_tensor_to_hom_ab ) = TransposedMatrix( UnderlyingMatrix( isomorphism_from_cohom_to_tensor_cd ) );
false
gap> UnderlyingMatrix( isomorphism_from_tensor_to_hom_ab ) = TransposedMatrix( UnderlyingMatrix( isomorphism_from_cohom_to_tensor_dc ) );
false

###################################################################################
# Morphism from internal hom to tensor product / tensor product to cohom
###################################################################################

gap> morphism_from_hom_to_tensor_product_ab := MorphismFromInternalHomToTensorProduct( a, b );;
gap> morphism_from_hom_to_tensor_product_ba := MorphismFromInternalHomToTensorProduct( b, a );;
gap> morphism_from_hom_to_tensor_product_cd := MorphismFromInternalHomToTensorProduct( c, d );;
gap> morphism_from_hom_to_tensor_product_dc := MorphismFromInternalHomToTensorProduct( d, c );;

gap> morphism_from_tensor_product_to_cohom_ab := MorphismFromTensorProductToInternalCoHom( a, b );;
gap> morphism_from_tensor_product_to_cohom_ba := MorphismFromTensorProductToInternalCoHom( b, a );;
gap> morphism_from_tensor_product_to_cohom_cd := MorphismFromTensorProductToInternalCoHom( c, d );;
gap> morphism_from_tensor_product_to_cohom_dc := MorphismFromTensorProductToInternalCoHom( d, c );;

# Correspondence

gap> UnderlyingMatrix( morphism_from_hom_to_tensor_product_ab ) = TransposedMatrix( UnderlyingMatrix( morphism_from_tensor_product_to_cohom_ab ) );
true
gap> UnderlyingMatrix( morphism_from_hom_to_tensor_product_ba ) = TransposedMatrix( UnderlyingMatrix( morphism_from_tensor_product_to_cohom_ba ) );
true
gap> UnderlyingMatrix( morphism_from_hom_to_tensor_product_cd ) = TransposedMatrix( UnderlyingMatrix( morphism_from_tensor_product_to_cohom_cd ) );
true
gap> UnderlyingMatrix( morphism_from_hom_to_tensor_product_dc ) = TransposedMatrix( UnderlyingMatrix( morphism_from_tensor_product_to_cohom_dc ) );
true

gap> UnderlyingMatrix( morphism_from_tensor_product_to_cohom_ab ) = TransposedMatrix( UnderlyingMatrix( morphism_from_hom_to_tensor_product_ab ) );
true
gap> UnderlyingMatrix( morphism_from_tensor_product_to_cohom_ba ) = TransposedMatrix( UnderlyingMatrix( morphism_from_hom_to_tensor_product_ba ) );
true
gap> UnderlyingMatrix( morphism_from_tensor_product_to_cohom_cd ) = TransposedMatrix( UnderlyingMatrix( morphism_from_hom_to_tensor_product_cd ) );
true
gap> UnderlyingMatrix( morphism_from_tensor_product_to_cohom_dc ) = TransposedMatrix( UnderlyingMatrix( morphism_from_hom_to_tensor_product_dc ) );
true

gap> UnderlyingMatrix( morphism_from_hom_to_tensor_product_ab ) = TransposedMatrix( UnderlyingMatrix( morphism_from_tensor_product_to_cohom_cd ) );
false
gap> UnderlyingMatrix( morphism_from_hom_to_tensor_product_ab ) = TransposedMatrix( UnderlyingMatrix( morphism_from_tensor_product_to_cohom_dc ) );
false

gap> UnderlyingMatrix( morphism_from_hom_to_tensor_product_cd ) = TransposedMatrix( UnderlyingMatrix( morphism_from_tensor_product_to_cohom_ab ) );
false
gap> UnderlyingMatrix( morphism_from_hom_to_tensor_product_cd ) = TransposedMatrix( UnderlyingMatrix( morphism_from_tensor_product_to_cohom_ba ) );
false

gap> UnderlyingMatrix( morphism_from_tensor_product_to_cohom_ba ) = TransposedMatrix( UnderlyingMatrix( morphism_from_hom_to_tensor_product_cd ) );
false
gap> UnderlyingMatrix( morphism_from_tensor_product_to_cohom_ba ) = TransposedMatrix( UnderlyingMatrix( morphism_from_hom_to_tensor_product_dc ) );
false

gap> UnderlyingMatrix( morphism_from_tensor_product_to_cohom_dc ) = TransposedMatrix( UnderlyingMatrix( morphism_from_hom_to_tensor_product_ab ) );
false
gap> UnderlyingMatrix( morphism_from_tensor_product_to_cohom_dc ) = TransposedMatrix( UnderlyingMatrix( morphism_from_hom_to_tensor_product_ba ) );
false

######################################################################
# Inverse tensor product and internal (co)hom compatibility
######################################################################

# gap> tensor_to_hom_compatibility_inverse_abcd := TensorProductInternalHomCompatibilityMorphismInverse( [ a, b, c, d ] );; # Hom( a x c, b x d ) -> Hom( a, b ) x Hom( c, d )
# gap> tensor_to_hom_compatibility_inverse_cadb := TensorProductInternalHomCompatibilityMorphismInverse( [ c, a, d, b ] );; # Hom( c x d, a x b ) -> Hom( c, a ) x Hom( d, b )

# gap> cohom_to_tensor_compatibility_inverse_abcd := InternalCoHomTensorProductCompatibilityMorphismInverse( [ a, b, c, d ] );; # Cohom( a, c ) x Cohom( b, d ) -> Cohom( a x b, c x d )
# gap> cohom_to_tensor_compatibility_inverse_bdac := InternalCoHomTensorProductCompatibilityMorphismInverse( [ b, d, a, c ] );; # Cohom( b, a ) x Cohom( d, c ) -> Cohom( b x d, a x c )

# # Correspondence

# gap> UnderlyingMatrix( tensor_to_hom_compatibility_inverse_abcd ) = TransposedMatrix( UnderlyingMatrix( cohom_to_tensor_compatibility_inverse_bdac ) ); # Hom( a x c, b x d ) -> Hom( a, b ) x Hom( c, d )  ==  Tranpose( Cohom( b, a ) x Cohom( d, c ) -> Cohom( b x d, a x c ) )
# true

# gap> UnderlyingMatrix( tensor_to_hom_compatibility_inverse_cadb ) = TransposedMatrix( UnderlyingMatrix( cohom_to_tensor_compatibility_inverse_abcd ) ); # Hom( c x d, a x b ) -> Hom( c, a ) x Hom( d, b )  ==  Tranpose( Cohom( a, c ) x Cohom( b, d ) -> Cohom( a x b, c x d ) )
# true

# gap> UnderlyingMatrix( cohom_to_tensor_compatibility_inverse_abcd ) = TransposedMatrix( UnderlyingMatrix( tensor_to_hom_compatibility_inverse_cadb ) ); # Cohom( a, c ) x Cohom( b, d ) -> Cohom( a x b, c x d )  ==  Tranpose( Hom( c x d, a x b ) -> Hom( c, a ) x Hom( d, b ) )
# true

# gap> UnderlyingMatrix( cohom_to_tensor_compatibility_inverse_bdac ) = TransposedMatrix( UnderlyingMatrix( tensor_to_hom_compatibility_inverse_abcd ) ); # Cohom( b, a ) x Cohom( d, c ) -> Cohom( b x d, a x c )  ==  Tranpose( Hom( a x c, b x d ) -> Hom( a, b ) x Hom( c, d ) )
# true

# gap> UnderlyingMatrix( tensor_to_hom_compatibility_inverse_abcd ) = TransposedMatrix( UnderlyingMatrix( cohom_to_tensor_compatibility_inverse_abcd ) ); # Hom( a x c, b x d ) -> Hom( a, b ) x Hom( c, d )  =/=  Tranpose( Cohom( a, c ) x Cohom( b, d ) -> Cohom( a x b, c x d ) )
# false

# gap> UnderlyingMatrix( tensor_to_hom_compatibility_inverse_cadb ) = TransposedMatrix( UnderlyingMatrix( cohom_to_tensor_compatibility_inverse_bdac ) ); # Hom( c x d, a x b ) -> Hom( c, a ) x Hom( d, b )  =/=  Tranpose( Cohom( b, a ) x Cohom( d, c ) -> Cohom( b x d, a x c ) )
# false

# gap> UnderlyingMatrix( cohom_to_tensor_compatibility_inverse_abcd ) = TransposedMatrix( UnderlyingMatrix( tensor_to_hom_compatibility_inverse_abcd ) ); # Cohom( a, c ) x Cohom( b, d ) -> Cohom( a x b, c x d )  =/=  Tranpose( Hom( a x c, b x d ) -> Hom( a, b ) x Hom( c, d ) )
# false

# gap> UnderlyingMatrix( cohom_to_tensor_compatibility_inverse_bdac ) = TransposedMatrix( UnderlyingMatrix( tensor_to_hom_compatibility_inverse_cadb ) ); # Cohom( b, a ) x Cohom( d, c ) -> Cohom( b x d, a x c )  =/=  Tranpose( Hom( c x d, a x b ) -> Hom( c, a ) x Hom( d, b ) )
# false

#######################################################################
# Coevaluation for (co)dual
#######################################################################

gap> coev_for_dual_a := CoevaluationForDual( a );;
gap> coev_for_dual_b := CoevaluationForDual( b );;
gap> coev_for_dual_0 := CoevaluationForDual( z );;

gap> cocl_coev_for_codual_a := CoclosedCoevaluationForCoDual( a );;
gap> cocl_coev_for_codual_b := CoclosedCoevaluationForCoDual( b );;
gap> cocl_coev_for_codual_0 := CoclosedCoevaluationForCoDual( z );;

# Correspondence

gap> UnderlyingMatrix( coev_for_dual_a ) = TransposedMatrix( UnderlyingMatrix( cocl_coev_for_codual_a ) );
true
gap> UnderlyingMatrix( coev_for_dual_b ) = TransposedMatrix( UnderlyingMatrix( cocl_coev_for_codual_b ) );
true
gap> UnderlyingMatrix( coev_for_dual_0 ) = TransposedMatrix( UnderlyingMatrix( cocl_coev_for_codual_0 ) );
true

gap> UnderlyingMatrix( coev_for_dual_a ) = TransposedMatrix( UnderlyingMatrix( cocl_coev_for_codual_b ) );
false
gap> UnderlyingMatrix( coev_for_dual_b ) = TransposedMatrix( UnderlyingMatrix( cocl_coev_for_codual_a ) );
false
gap> UnderlyingMatrix( coev_for_dual_0 ) = TransposedMatrix( UnderlyingMatrix( cocl_coev_for_codual_a ) );
false

gap> UnderlyingMatrix( cocl_coev_for_codual_a ) = TransposedMatrix( UnderlyingMatrix( coev_for_dual_b ) );
false
gap> UnderlyingMatrix( cocl_coev_for_codual_b ) = TransposedMatrix( UnderlyingMatrix( coev_for_dual_a ) );
false
gap> UnderlyingMatrix( cocl_coev_for_codual_0 ) = TransposedMatrix( UnderlyingMatrix( coev_for_dual_a ) );
false

#######################################################################
# (Co)Trace
#######################################################################

# Trace

gap> trace_id_0_tensor_a := TraceMap( id_0_tensor_a );;
gap> trace_id_a_tensor_0 := TraceMap( id_a_tensor_0 );;

gap> trace_id_a_tensor_b := TraceMap( id_a_tensor_b );;
gap> trace_id_b_tensor_a := TraceMap( id_b_tensor_a );;
gap> trace_id_c_tensor_d := TraceMap( id_c_tensor_d );;
gap> trace_id_d_tensor_c := TraceMap( id_d_tensor_c );;

gap> trace_id_hom_0a := TraceMap( id_hom_0a );;
gap> trace_id_hom_a0 := TraceMap( id_hom_a0 );;

gap> trace_id_hom_ab := TraceMap( id_hom_ab );;
gap> trace_id_hom_ba := TraceMap( id_hom_ba );;
gap> trace_id_hom_cd := TraceMap( id_hom_cd );;
gap> trace_id_hom_dc := TraceMap( id_hom_dc );;

# Cotrace

gap> cotrace_id_0_tensor_a := CoTraceMap( id_0_tensor_a );;
gap> cotrace_id_a_tensor_0 := CoTraceMap( id_a_tensor_0 );;

gap> cotrace_id_a_tensor_b := CoTraceMap( id_a_tensor_b );;
gap> cotrace_id_b_tensor_a := CoTraceMap( id_b_tensor_a );;
gap> cotrace_id_c_tensor_d := CoTraceMap( id_c_tensor_d );;
gap> cotrace_id_d_tensor_c := CoTraceMap( id_d_tensor_c );;

gap> cotrace_id_hom_0a := CoTraceMap( id_hom_0a );;
gap> cotrace_id_hom_a0 := CoTraceMap( id_hom_a0 );;

gap> cotrace_id_hom_ab := CoTraceMap( id_hom_ab );;
gap> cotrace_id_hom_ba := CoTraceMap( id_hom_ba );;
gap> cotrace_id_hom_cd := CoTraceMap( id_hom_cd );;
gap> cotrace_id_hom_dc := CoTraceMap( id_hom_dc );;

# Opposite correspondence

gap> UnderlyingMatrix( trace_id_0_tensor_a ) = TransposedMatrix( UnderlyingMatrix( cotrace_id_0_tensor_a ) );
true
gap> UnderlyingMatrix( trace_id_a_tensor_0 ) = TransposedMatrix( UnderlyingMatrix( cotrace_id_a_tensor_0 ) );
true

gap> UnderlyingMatrix( trace_id_a_tensor_b ) = TransposedMatrix( UnderlyingMatrix( cotrace_id_a_tensor_b ) );
true
gap> UnderlyingMatrix( trace_id_b_tensor_a ) = TransposedMatrix( UnderlyingMatrix( cotrace_id_b_tensor_a ) );
true
gap> UnderlyingMatrix( trace_id_c_tensor_d ) = TransposedMatrix( UnderlyingMatrix( cotrace_id_c_tensor_d ) );
true
gap> UnderlyingMatrix( trace_id_d_tensor_c ) = TransposedMatrix( UnderlyingMatrix( cotrace_id_d_tensor_c ) );
true

gap> UnderlyingMatrix( trace_id_hom_0a ) = TransposedMatrix( UnderlyingMatrix( cotrace_id_hom_0a ) );
true
gap> UnderlyingMatrix( trace_id_hom_a0 ) = TransposedMatrix( UnderlyingMatrix( cotrace_id_hom_a0 ) );
true

gap> UnderlyingMatrix( trace_id_hom_ab ) = TransposedMatrix( UnderlyingMatrix( cotrace_id_hom_ab ) );
true
gap> UnderlyingMatrix( trace_id_hom_ba ) = TransposedMatrix( UnderlyingMatrix( cotrace_id_hom_ba ) );
true
gap> UnderlyingMatrix( trace_id_hom_cd ) = TransposedMatrix( UnderlyingMatrix( cotrace_id_hom_cd ) );
true
gap> UnderlyingMatrix( trace_id_hom_dc ) = TransposedMatrix( UnderlyingMatrix( cotrace_id_hom_dc ) );
true

gap> UnderlyingMatrix( trace_id_a_tensor_b ) = TransposedMatrix( UnderlyingMatrix( cotrace_id_c_tensor_d ) );
false
gap> UnderlyingMatrix( trace_id_c_tensor_d ) = TransposedMatrix( UnderlyingMatrix( cotrace_id_a_tensor_b ) );
false

gap> UnderlyingMatrix( trace_id_hom_ab ) = TransposedMatrix( UnderlyingMatrix( cotrace_id_hom_cd ) );
false
gap> UnderlyingMatrix( trace_id_hom_dc ) = TransposedMatrix( UnderlyingMatrix( cotrace_id_hom_ba ) );
false

gap> UnderlyingMatrix( cotrace_id_b_tensor_a ) = TransposedMatrix( UnderlyingMatrix( trace_id_d_tensor_c ) );
false
gap> UnderlyingMatrix( cotrace_id_d_tensor_c ) = TransposedMatrix( UnderlyingMatrix( trace_id_b_tensor_a ) );
false

gap> UnderlyingMatrix( cotrace_id_hom_ba ) = TransposedMatrix( UnderlyingMatrix( trace_id_hom_dc ) );
false
gap> UnderlyingMatrix( cotrace_id_hom_dc ) = TransposedMatrix( UnderlyingMatrix( trace_id_hom_ba ) );
false

#######################################################################
# (Co)RankMorphism
#######################################################################

# Rank morphism

gap> rank_morphism_a := RankMorphism( a );;
gap> rank_morphism_b := RankMorphism( b );;
gap> rank_morphism_c := RankMorphism( c );;
gap> rank_morphism_d := RankMorphism( d );;

gap> rank_morphism_a_tensor_b := RankMorphism( a_tensor_b );;
gap> rank_morphism_b_tensor_a := RankMorphism( b_tensor_a );;
gap> rank_morphism_c_tensor_d := RankMorphism( c_tensor_d );;
gap> rank_morphism_d_tensor_c := RankMorphism( d_tensor_c );;

gap> rank_morphism_a_tensor_0 := RankMorphism( a_tensor_0 );;
gap> rank_morphism_0_tensor_a := RankMorphism( 0_tensor_a );;

gap> rank_morphism_hom_ab := RankMorphism( hom_ab );;
gap> rank_morphism_hom_ba := RankMorphism( hom_ba );;
gap> rank_morphism_hom_cd := RankMorphism( hom_cd );;
gap> rank_morphism_hom_dc := RankMorphism( hom_dc );;

# Corank morphism

gap> corank_morphism_a := CoRankMorphism( a );;
gap> corank_morphism_b := CoRankMorphism( b );;
gap> corank_morphism_c := CoRankMorphism( c );;
gap> corank_morphism_d := CoRankMorphism( d );;

gap> corank_morphism_a_tensor_b := CoRankMorphism( a_tensor_b );;
gap> corank_morphism_b_tensor_a := CoRankMorphism( b_tensor_a );;
gap> corank_morphism_c_tensor_d := CoRankMorphism( c_tensor_d );;
gap> corank_morphism_d_tensor_c := CoRankMorphism( d_tensor_c );;

gap> corank_morphism_a_tensor_0 := CoRankMorphism( a_tensor_0 );;
gap> corank_morphism_0_tensor_a := CoRankMorphism( 0_tensor_a );;

gap> corank_morphism_cohom_ab := CoRankMorphism( cohom_ab );;
gap> corank_morphism_cohom_ba := CoRankMorphism( cohom_ba );;
gap> corank_morphism_cohom_cd := CoRankMorphism( cohom_cd );;
gap> corank_morphism_cohom_dc := CoRankMorphism( cohom_dc );;

# Correspondence

gap> UnderlyingMatrix( rank_morphism_a ) = TransposedMatrix( UnderlyingMatrix( corank_morphism_a ) );
true
gap> UnderlyingMatrix( rank_morphism_b ) = TransposedMatrix( UnderlyingMatrix( corank_morphism_b ) );
true
gap> UnderlyingMatrix( rank_morphism_c ) = TransposedMatrix( UnderlyingMatrix( corank_morphism_c ) );
true
gap> UnderlyingMatrix( rank_morphism_d ) = TransposedMatrix( UnderlyingMatrix( corank_morphism_d ) );
true

gap> UnderlyingMatrix( rank_morphism_a_tensor_b ) = TransposedMatrix( UnderlyingMatrix( corank_morphism_a_tensor_b ) );
true
gap> UnderlyingMatrix( rank_morphism_b_tensor_a ) = TransposedMatrix( UnderlyingMatrix( corank_morphism_b_tensor_a ) );
true
gap> UnderlyingMatrix( rank_morphism_c_tensor_d ) = TransposedMatrix( UnderlyingMatrix( corank_morphism_c_tensor_d ) );
true
gap> UnderlyingMatrix( rank_morphism_d_tensor_c ) = TransposedMatrix( UnderlyingMatrix( corank_morphism_d_tensor_c ) );
true

gap> UnderlyingMatrix( rank_morphism_a_tensor_0 ) = TransposedMatrix( UnderlyingMatrix( corank_morphism_a_tensor_0 ) );
true
gap> UnderlyingMatrix( rank_morphism_0_tensor_a ) = TransposedMatrix( UnderlyingMatrix( corank_morphism_0_tensor_a ) );
true

gap> UnderlyingMatrix( rank_morphism_hom_ab ) = TransposedMatrix( UnderlyingMatrix( corank_morphism_cohom_ab ) );
true
gap> UnderlyingMatrix( rank_morphism_hom_ba ) = TransposedMatrix( UnderlyingMatrix( corank_morphism_cohom_ba ) );
true
gap> UnderlyingMatrix( rank_morphism_hom_cd ) = TransposedMatrix( UnderlyingMatrix( corank_morphism_cohom_cd ) );
true
gap> UnderlyingMatrix( rank_morphism_hom_dc ) = TransposedMatrix( UnderlyingMatrix( corank_morphism_cohom_dc ) );
true

gap> UnderlyingMatrix( rank_morphism_a ) = TransposedMatrix( UnderlyingMatrix( corank_morphism_b ) );
false
gap> UnderlyingMatrix( rank_morphism_b ) = TransposedMatrix( UnderlyingMatrix( corank_morphism_a ) );
false
gap> UnderlyingMatrix( rank_morphism_c ) = TransposedMatrix( UnderlyingMatrix( corank_morphism_d ) );
false
gap> UnderlyingMatrix( rank_morphism_d ) = TransposedMatrix( UnderlyingMatrix( corank_morphism_c ) );
false

gap> UnderlyingMatrix( rank_morphism_a_tensor_0 ) = TransposedMatrix( UnderlyingMatrix( corank_morphism_a_tensor_b ) );
false
gap> UnderlyingMatrix( rank_morphism_0_tensor_a ) = TransposedMatrix( UnderlyingMatrix( corank_morphism_c_tensor_d ) );
false

gap> UnderlyingMatrix( corank_morphism_a ) = TransposedMatrix( UnderlyingMatrix( rank_morphism_d ) );
false
gap> UnderlyingMatrix( corank_morphism_b ) = TransposedMatrix( UnderlyingMatrix( rank_morphism_c ) );
false
gap> UnderlyingMatrix( corank_morphism_c ) = TransposedMatrix( UnderlyingMatrix( rank_morphism_b ) );
false
gap> UnderlyingMatrix( corank_morphism_d ) = TransposedMatrix( UnderlyingMatrix( rank_morphism_a ) );
false

gap> UnderlyingMatrix( corank_morphism_a_tensor_0 ) = TransposedMatrix( UnderlyingMatrix( rank_morphism_a_tensor_b ) );
false
gap> UnderlyingMatrix( corank_morphism_0_tensor_a ) = TransposedMatrix( UnderlyingMatrix( rank_morphism_c_tensor_d ) );
false

gap> UnderlyingMatrix( corank_morphism_cohom_ab ) = TransposedMatrix( UnderlyingMatrix( rank_morphism_hom_cd ) );
false
gap> UnderlyingMatrix( corank_morphism_cohom_cd ) = TransposedMatrix( UnderlyingMatrix( rank_morphism_hom_ab ) );
false

#######################################################################
# Morphism from bidual / to cobidual
#######################################################################

gap> morphism_from_bidual_a := MorphismFromBidual( a );;
gap> morphism_from_bidual_b := MorphismFromBidual( b );;
gap> morphism_from_bidual_c := MorphismFromBidual( c );;
gap> morphism_from_bidual_d := MorphismFromBidual( d );;

gap> morphism_to_cobidual_a := MorphismToCoBidual( a );;
gap> morphism_to_cobidual_b := MorphismToCoBidual( b );;
gap> morphism_to_cobidual_c := MorphismToCoBidual( c );;
gap> morphism_to_cobidual_d := MorphismToCoBidual( d );;

# Correspondence

gap> UnderlyingMatrix( morphism_from_bidual_a ) = TransposedMatrix( UnderlyingMatrix( morphism_to_cobidual_a ) );
true
gap> UnderlyingMatrix( morphism_from_bidual_b ) = TransposedMatrix( UnderlyingMatrix( morphism_to_cobidual_b ) );
true
gap> UnderlyingMatrix( morphism_from_bidual_c ) = TransposedMatrix( UnderlyingMatrix( morphism_to_cobidual_c ) );
true
gap> UnderlyingMatrix( morphism_from_bidual_d ) = TransposedMatrix( UnderlyingMatrix( morphism_to_cobidual_d ) );
true

gap> UnderlyingMatrix( morphism_to_bidual_a ) = TransposedMatrix( UnderlyingMatrix( morphism_from_bidual_a ) );
true
gap> UnderlyingMatrix( morphism_to_bidual_b ) = TransposedMatrix( UnderlyingMatrix( morphism_from_bidual_b ) );
true
gap> UnderlyingMatrix( morphism_to_bidual_c ) = TransposedMatrix( UnderlyingMatrix( morphism_from_bidual_c ) );
true
gap> UnderlyingMatrix( morphism_to_bidual_d ) = TransposedMatrix( UnderlyingMatrix( morphism_from_bidual_d ) );
true

gap> UnderlyingMatrix( morphism_from_cobidual_a ) = TransposedMatrix( UnderlyingMatrix( morphism_to_cobidual_a ) );
true
gap> UnderlyingMatrix( morphism_from_cobidual_b ) = TransposedMatrix( UnderlyingMatrix( morphism_to_cobidual_b ) );
true
gap> UnderlyingMatrix( morphism_from_cobidual_c ) = TransposedMatrix( UnderlyingMatrix( morphism_to_cobidual_c ) );
true
gap> UnderlyingMatrix( morphism_from_cobidual_d ) = TransposedMatrix( UnderlyingMatrix( morphism_to_cobidual_d ) );
true

gap> UnderlyingMatrix( morphism_from_bidual_a ) = TransposedMatrix( UnderlyingMatrix( morphism_to_cobidual_b ) );
false
gap> UnderlyingMatrix( morphism_from_bidual_a ) = TransposedMatrix( UnderlyingMatrix( morphism_to_cobidual_c ) );
false
gap> UnderlyingMatrix( morphism_from_bidual_a ) = TransposedMatrix( UnderlyingMatrix( morphism_to_cobidual_d ) );
false

gap> UnderlyingMatrix( morphism_to_cobidual_c ) = TransposedMatrix( UnderlyingMatrix( morphism_from_bidual_a ) );
false
gap> UnderlyingMatrix( morphism_to_cobidual_c ) = TransposedMatrix( UnderlyingMatrix( morphism_from_bidual_b ) );
false
gap> UnderlyingMatrix( morphism_to_cobidual_c ) = TransposedMatrix( UnderlyingMatrix( morphism_from_bidual_d ) );
false

gap> STOP_TEST("ClosedAndCoclosedInMatrixCategory.tst", 1);
