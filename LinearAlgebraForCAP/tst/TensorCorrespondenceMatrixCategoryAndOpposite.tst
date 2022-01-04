#######################################################################################################
# Test the correspondences of the tensor stuructures between the category of matrices and its opposite
#######################################################################################################

gap> START_TEST("TensorCorrespondenceMatrixCategoryAndOpposite.tst");

gap> LoadPackage( "LinearAlgebraForCAP", false );
true

gap> Q := HomalgFieldOfRationals();;
gap> mc := MatrixCategory( Q );;
gap> mcop := Opposite( mc );;

##############################################################
# Tensor, Hom and Cohom on objects
##############################################################

# Tensor objects and internal (co)homs for matrix category 

gap> a_mc := VectorSpaceObject( 2, Q );;
gap> b_mc := VectorSpaceObject( 3, Q );;
gap> c_mc := VectorSpaceObject( 6, Q );;
gap> d_mc := VectorSpaceObject( 4, Q );;

gap> 0_mc := ZeroObject( mc );;
gap> 1_mc := TensorUnit( mc );;

gap> a_tensor_b_mc := TensorProductOnObjects( a_mc, b_mc );;
gap> b_tensor_a_mc := TensorProductOnObjects( b_mc, a_mc );;
gap> c_tensor_d_mc := TensorProductOnObjects( c_mc, d_mc );;
gap> d_tensor_c_mc := TensorProductOnObjects( d_mc, c_mc );;

gap> 0_tensor_a_mc := TensorProductOnObjects( 0_mc, a_mc );;
gap> a_tensor_0_mc := TensorProductOnObjects( a_mc, 0_mc );;

gap> hom_ab_mc := InternalHomOnObjects( a_mc, b_mc );;
gap> hom_ba_mc := InternalHomOnObjects( b_mc, a_mc );;
gap> hom_cd_mc := InternalHomOnObjects( c_mc, d_mc );;
gap> hom_dc_mc := InternalHomOnObjects( d_mc, c_mc );;

gap> hom_0a_mc := InternalHomOnObjects( 0_mc, a_mc );;
gap> hom_a0_mc := InternalHomOnObjects( a_mc, 0_mc );;

gap> cohom_ab_mc := InternalCoHomOnObjects( a_mc, b_mc );;
gap> cohom_ba_mc := InternalCoHomOnObjects( b_mc, a_mc );;
gap> cohom_cd_mc := InternalCoHomOnObjects( c_mc, d_mc );;
gap> cohom_dc_mc := InternalCoHomOnObjects( d_mc, c_mc );;

gap> cohom_0a_mc := InternalCoHomOnObjects( 0_mc, a_mc );;
gap> cohom_a0_mc := InternalCoHomOnObjects( a_mc, 0_mc );;

# Tensor objects and internal (co)homs for opposite 

gap> a_mcop := Opposite( a_mc );;
gap> b_mcop := Opposite( b_mc );;
gap> c_mcop := Opposite( c_mc );;
gap> d_mcop := Opposite( d_mc );;

gap> 0_mcop := ZeroObject( mcop );;
gap> 1_mcop := TensorUnit( mcop );;

gap> a_tensor_b_mcop := TensorProductOnObjects( a_mcop, b_mcop );;
gap> b_tensor_a_mcop := TensorProductOnObjects( b_mcop, a_mcop );;
gap> c_tensor_d_mcop := TensorProductOnObjects( c_mcop, d_mcop );;
gap> d_tensor_c_mcop := TensorProductOnObjects( d_mcop, c_mcop );;

gap> 0_tensor_a_mcop := TensorProductOnObjects( 0_mcop, a_mcop );;
gap> a_tensor_0_mcop := TensorProductOnObjects( a_mcop, 0_mcop );;

gap> hom_ab_mcop := InternalHomOnObjects( a_mcop, b_mcop );;
gap> hom_ba_mcop := InternalHomOnObjects( b_mcop, a_mcop );;
gap> hom_cd_mcop := InternalHomOnObjects( c_mcop, d_mcop );;
gap> hom_dc_mcop := InternalHomOnObjects( d_mcop, c_mcop );;

gap> hom_0a_mcop := InternalHomOnObjects( 0_mcop, a_mcop );;
gap> hom_a0_mcop := InternalHomOnObjects( a_mcop, 0_mcop );;

gap> cohom_ab_mcop := InternalCoHomOnObjects( a_mcop, b_mcop );;
gap> cohom_ba_mcop := InternalCoHomOnObjects( b_mcop, a_mcop );;
gap> cohom_cd_mcop := InternalCoHomOnObjects( c_mcop, d_mcop );;
gap> cohom_dc_mcop := InternalCoHomOnObjects( d_mcop, c_mcop );;

gap> cohom_0a_mcop := InternalCoHomOnObjects( 0_mcop, a_mcop );;
gap> cohom_a0_mcop := InternalCoHomOnObjects( a_mcop, 0_mcop );;

# Opposite correspondence on tensor objects

gap> 0_mcop = Opposite( 0_mc );
true
gap> 1_mcop = Opposite( 1_mc );
true

gap> a_tensor_b_mcop = Opposite( a_tensor_b_mc );
true
gap> b_tensor_a_mcop = Opposite( b_tensor_a_mc );
true
gap> c_tensor_d_mcop = Opposite( c_tensor_d_mc );
true
gap> d_tensor_c_mcop = Opposite( d_tensor_c_mc );
true

gap> 0_tensor_a_mcop = Opposite( 0_tensor_a_mc );
true
gap> a_tensor_0_mcop = Opposite( a_tensor_0_mc );
true

gap> b_tensor_a_mcop = Opposite( c_tensor_d_mc );
false
gap> b_tensor_a_mcop = Opposite( d_tensor_c_mc );
false
gap> c_tensor_d_mcop = Opposite( a_tensor_b_mc );
false
gap> c_tensor_d_mcop = Opposite( b_tensor_a_mc );
false

# Opposite correspondence on internal (co)homs

gap> hom_ab_mcop = Opposite( cohom_ba_mc );
true
gap> hom_ba_mcop = Opposite( cohom_ab_mc );
true
gap> hom_cd_mcop = Opposite( cohom_dc_mc );
true
gap> hom_dc_mcop = Opposite( cohom_cd_mc );
true

gap> hom_0a_mcop = Opposite( cohom_a0_mc );
true
gap> hom_a0_mcop = Opposite( cohom_0a_mc );
true

gap> cohom_ab_mcop = Opposite( hom_ba_mc );
true
gap> cohom_ba_mcop = Opposite( hom_ab_mc );
true
gap> cohom_cd_mcop = Opposite( hom_dc_mc );
true
gap> cohom_dc_mcop = Opposite( hom_cd_mc );
true

gap> cohom_0a_mcop = Opposite( hom_a0_mc );
true
gap> cohom_a0_mcop = Opposite( hom_0a_mc );
true

gap> hom_ab_mcop = Opposite( hom_cd_mc );
false
gap> hom_ab_mcop = Opposite( hom_dc_mc );
false
gap> hom_ab_mcop = Opposite( cohom_cd_mc );
false
gap> hom_ab_mcop = Opposite( cohom_dc_mc );
false

gap> cohom_cd_mcop = Opposite( hom_ab_mc );
false
gap> cohom_cd_mcop = Opposite( hom_ba_mc );
false
gap> cohom_cd_mcop = Opposite( cohom_ab_mc );
false
gap> cohom_cd_mcop = Opposite( cohom_ba_mc );
false

# Opposite must be self-inverse

gap> hom_ab_mc = Opposite( cohom_ba_mcop );
true
gap> hom_ba_mc = Opposite( cohom_ab_mcop );
true
gap> hom_cd_mc = Opposite( cohom_dc_mcop );
true
gap> hom_dc_mc = Opposite( cohom_cd_mcop );
true

gap> cohom_ab_mc = Opposite( hom_ba_mcop );
true
gap> cohom_ba_mc = Opposite( hom_ab_mcop );
true
gap> cohom_cd_mc = Opposite( hom_dc_mcop );
true
gap> cohom_dc_mc = Opposite( hom_cd_mcop );
true

# Convenience methods in the opposite category

gap> a_tensor_b_mcop = TensorProduct( a_mcop, b_mcop );
true
gap> b_tensor_a_mcop = TensorProduct( b_mcop, a_mcop );
true
gap> c_tensor_d_mcop = TensorProduct( c_mcop, d_mcop );
true
gap> d_tensor_c_mcop = TensorProduct( d_mcop, c_mcop );
true

gap> a_mcop = TensorProductOp( [ a_mcop ], a_mcop ); # Special case in TensorProductOp
true
gap> b_mcop = TensorProductOp( [ b_mcop ], b_mcop ); # Special case in TensorProductOp
true

gap> hom_ab_mcop = InternalHom( a_mcop, b_mcop );
true
gap> hom_ba_mcop = InternalHom( b_mcop, a_mcop );
true
gap> hom_cd_mcop = InternalHom( c_mcop, d_mcop );
true
gap> hom_dc_mcop = InternalHom( d_mcop, c_mcop);
true

gap> hom_0a_mcop = InternalHom( 0_mcop, a_mcop );
true
gap> hom_a0_mcop = InternalHom( a_mcop, 0_mcop );
true

gap> cohom_ab_mcop = InternalCoHom( a_mcop, b_mcop );
true
gap> cohom_ba_mcop = InternalCoHom( b_mcop, a_mcop );
true
gap> cohom_cd_mcop = InternalCoHom( c_mcop, d_mcop );
true
gap> cohom_dc_mcop = InternalCoHom( d_mcop, c_mcop);
true

gap> cohom_0a_mcop = InternalCoHom( 0_mcop, a_mcop );
true
gap> cohom_a0_mcop = InternalCoHom( a_mcop, 0_mcop );
true

################################################################
# Tensor, Hom and CoHom on morphisms
################################################################

# Morphisms for matrix category 

gap> id_a_mc := IdentityMorphism( a_mc );;
gap> id_b_mc := IdentityMorphism( b_mc );;

gap> alpha_mc := VectorSpaceMorphism( a_mc, HomalgMatrix( [ 2 .. 7], 2, 3, Q ), b_mc );;
gap> beta_mc := VectorSpaceMorphism( c_mc, HomalgMatrix( [ 8 .. 31 ], 6, 4, Q ), d_mc );;
gap> gamma_mc := VectorSpaceMorphism( b_mc, HomalgMatrix( [ -8 .. 9 ], 3, 6, Q ), c_mc );;

gap> alpha_gamma_mc := PreCompose( alpha_mc, gamma_mc );;
gap> gamma_beta_mc := PreCompose( gamma_mc, beta_mc );;
gap> alpha_gamma_beta_mc := PreCompose( [ alpha_mc, gamma_mc, beta_mc ] );;

gap> alpha_tensor_beta_mc := TensorProductOnMorphisms( alpha_mc, beta_mc );;
gap> beta_tensor_alpha_mc := TensorProductOnMorphisms( beta_mc, alpha_mc );;

gap> hom_alpha_id_a_mc := InternalHomOnMorphisms( alpha_mc, id_a_mc );;
gap> hom_alpha_id_b_mc := InternalHomOnMorphisms( alpha_mc, id_b_mc );;
gap> hom_id_a_alpha_mc := InternalHomOnMorphisms( id_a_mc, alpha_mc );;
gap> hom_id_b_alpha_mc := InternalHomOnMorphisms( id_b_mc, alpha_mc );;

gap> hom_alpha_beta_mc := InternalHomOnMorphisms( alpha_mc, beta_mc );;
gap> hom_beta_alpha_mc := InternalHomOnMorphisms( beta_mc, alpha_mc );;

gap> cohom_alpha_id_a_mc := InternalCoHomOnMorphisms( alpha_mc, id_a_mc );;
gap> cohom_alpha_id_b_mc := InternalCoHomOnMorphisms( alpha_mc, id_b_mc );;
gap> cohom_id_a_alpha_mc := InternalCoHomOnMorphisms( id_a_mc, alpha_mc );;
gap> cohom_id_b_alpha_mc := InternalCoHomOnMorphisms( id_b_mc, alpha_mc );;

gap> cohom_alpha_beta_mc := InternalCoHomOnMorphisms( alpha_mc, beta_mc );;
gap> cohom_beta_alpha_mc := InternalCoHomOnMorphisms( beta_mc, alpha_mc );;

# Morphisms for opposite 

gap> id_a_mcop := IdentityMorphism( a_mcop );;
gap> id_b_mcop := IdentityMorphism( b_mcop );;

gap> alpha_mcop := Opposite( alpha_mc );;
gap> beta_mcop := Opposite( beta_mc );;
gap> gamma_mcop := Opposite( gamma_mc );;

gap> alpha_gamma_mcop := PostCompose( alpha_mcop, gamma_mcop );;
gap> gamma_beta_mcop := PostCompose( gamma_mcop, beta_mcop );;
gap> alpha_gamma_beta_mcop := PostCompose( [ alpha_mcop, gamma_mcop, beta_mcop ] );;

gap> alpha_tensor_beta_mcop := TensorProductOnMorphisms( alpha_mcop, beta_mcop );;
gap> beta_tensor_alpha_mcop := TensorProductOnMorphisms( beta_mcop, alpha_mcop );;

gap> hom_alpha_id_a_mcop := InternalHomOnMorphisms( alpha_mcop, id_a_mcop );;
gap> hom_alpha_id_b_mcop := InternalHomOnMorphisms( alpha_mcop, id_b_mcop );;
gap> hom_id_a_alpha_mcop := InternalHomOnMorphisms( id_a_mcop, alpha_mcop );;
gap> hom_id_b_alpha_mcop := InternalHomOnMorphisms( id_b_mcop, alpha_mcop );;

gap> hom_alpha_beta_mcop := InternalHomOnMorphisms( alpha_mcop, beta_mcop );;
gap> hom_beta_alpha_mcop := InternalHomOnMorphisms( beta_mcop, alpha_mcop );;

gap> cohom_alpha_id_a_mcop := InternalCoHomOnMorphisms( alpha_mcop, id_a_mcop );;
gap> cohom_alpha_id_b_mcop := InternalCoHomOnMorphisms( alpha_mcop, id_b_mcop );;
gap> cohom_id_a_alpha_mcop := InternalCoHomOnMorphisms( id_a_mcop, alpha_mcop );;
gap> cohom_id_b_alpha_mcop := InternalCoHomOnMorphisms( id_b_mcop, alpha_mcop );;

gap> cohom_alpha_beta_mcop := InternalCoHomOnMorphisms( alpha_mcop, beta_mcop );;
gap> cohom_beta_alpha_mcop := InternalCoHomOnMorphisms( beta_mcop, alpha_mcop );;

# Opposite correspondence on tensored morphisms

gap> alpha_tensor_beta_mcop = Opposite( alpha_tensor_beta_mc );
true
gap> beta_tensor_alpha_mcop = Opposite( beta_tensor_alpha_mc );
true

# Opposite correspondence on internal (co)homs

gap> hom_alpha_beta_mcop = Opposite( cohom_beta_alpha_mc );
true
gap> hom_beta_alpha_mcop = Opposite( cohom_alpha_beta_mc );
true
gap> cohom_alpha_beta_mcop = Opposite( hom_beta_alpha_mc );
true
gap> cohom_beta_alpha_mcop = Opposite( hom_alpha_beta_mc );
true

gap> hom_alpha_beta_mcop = Opposite( cohom_alpha_beta_mc );
false
gap> hom_alpha_beta_mcop = Opposite( hom_beta_alpha_mc );
false
gap> hom_alpha_beta_mcop = Opposite( hom_beta_alpha_mc );
false

gap> cohom_alpha_beta_mcop = Opposite( hom_alpha_beta_mc );
false
gap> cohom_alpha_beta_mcop = Opposite( cohom_beta_alpha_mc );
false
gap> cohom_alpha_beta_mcop = Opposite( cohom_beta_alpha_mc );
false

# Opposite correspondence on compositions of morphisms

gap> alpha_gamma_mcop = Opposite( alpha_gamma_mc );
true
gap> gamma_beta_mcop = Opposite( gamma_beta_mc );
true
gap> alpha_gamma_beta_mcop = Opposite( alpha_gamma_beta_mc );
true

gap> alpha_gamma_mcop = Opposite( gamma_beta_mc );
false
gap> alpha_gamma_mcop = Opposite( alpha_gamma_beta_mc );
false
gap> gamma_beta_mcop = Opposite( alpha_gamma_mc );
false
gap> gamma_beta_mcop = Opposite( alpha_gamma_beta_mc );
false
gap> alpha_gamma_beta_mcop = Opposite( alpha_gamma_mc );
false
gap> alpha_gamma_beta_mcop = Opposite( gamma_beta_mc );
false

# Opposite must be self-inverse

gap> hom_alpha_beta_mc = Opposite( cohom_beta_alpha_mcop );
true
gap> hom_beta_alpha_mc = Opposite( cohom_alpha_beta_mcop );
true
gap> cohom_alpha_beta_mc = Opposite( hom_beta_alpha_mcop );
true
gap> cohom_beta_alpha_mc = Opposite( hom_alpha_beta_mcop );
true

# Convenience methods in the opposite category

gap> alpha_tensor_beta_mcop = TensorProduct( alpha_mcop, beta_mcop );
true
gap> beta_tensor_alpha_mcop = TensorProduct( beta_mcop, alpha_mcop );
true

gap> alpha_mcop = TensorProductOp( [ alpha_mcop ], alpha_mcop ); # Special case in TensorProductOp
true
gap> beta_mcop = TensorProductOp( [ beta_mcop ], beta_mcop ); # Special case in TensorProductOp
true

gap> hom_alpha_beta_mcop = InternalHom( alpha_mcop, beta_mcop );
true
gap> hom_beta_alpha_mcop = InternalHom( beta_mcop, alpha_mcop );
true

gap> cohom_alpha_beta_mcop = InternalCoHom( alpha_mcop, beta_mcop );
true
gap> cohom_beta_alpha_mcop = InternalCoHom( beta_mcop, alpha_mcop );
true

gap> hom_alpha_id_a_mcop = InternalHom( alpha_mcop, a_mcop );
true
gap> hom_alpha_id_b_mcop = InternalHom( alpha_mcop, b_mcop );
true
gap> hom_id_a_alpha_mcop = InternalHom( a_mcop, alpha_mcop );
true
gap> hom_id_b_alpha_mcop = InternalHom( b_mcop, alpha_mcop );
true

gap> cohom_alpha_id_a_mcop = InternalCoHom( alpha_mcop, a_mcop );
true
gap> cohom_alpha_id_b_mcop = InternalCoHom( alpha_mcop, b_mcop );
true
gap> cohom_id_a_alpha_mcop = InternalCoHom( a_mcop, alpha_mcop );
true
gap> cohom_id_b_alpha_mcop = InternalCoHom( b_mcop, alpha_mcop );
true

######################################################
# Unitors
######################################################

# Unitors

gap> left_unitor_a_mc := LeftUnitor( a_mc );;
gap> left_unitor_b_mc := LeftUnitor( b_mc );;
gap> left_unitor_c_mc := LeftUnitor( c_mc );;
gap> left_unitor_d_mc := LeftUnitor( d_mc );;

gap> left_unitor_a_mcop := LeftUnitor( a_mcop );;
gap> left_unitor_b_mcop := LeftUnitor( b_mcop );;
gap> left_unitor_c_mcop := LeftUnitor( c_mcop );;
gap> left_unitor_d_mcop := LeftUnitor( d_mcop );;

gap> right_unitor_a_mc := RightUnitor( a_mc );;
gap> right_unitor_b_mc := RightUnitor( b_mc );;
gap> right_unitor_c_mc := RightUnitor( c_mc );;
gap> right_unitor_d_mc := RightUnitor( d_mc );;

gap> right_unitor_a_mcop := RightUnitor( a_mcop );;
gap> right_unitor_b_mcop := RightUnitor( b_mcop );;
gap> right_unitor_c_mcop := RightUnitor( c_mcop );;
gap> right_unitor_d_mcop := RightUnitor( d_mcop );;

# Inverse unitors

gap> left_unitor_inverse_a_mc := LeftUnitorInverse( a_mc );;
gap> left_unitor_inverse_b_mc := LeftUnitorInverse( b_mc );;
gap> left_unitor_inverse_c_mc := LeftUnitorInverse( c_mc );;
gap> left_unitor_inverse_d_mc := LeftUnitorInverse( d_mc );;

gap> left_unitor_inverse_a_mcop := LeftUnitorInverse( a_mcop );;
gap> left_unitor_inverse_b_mcop := LeftUnitorInverse( b_mcop );;
gap> left_unitor_inverse_c_mcop := LeftUnitorInverse( c_mcop );;
gap> left_unitor_inverse_d_mcop := LeftUnitorInverse( d_mcop );;

gap> right_unitor_inverse_a_mc := RightUnitorInverse( a_mc );;
gap> right_unitor_inverse_b_mc := RightUnitorInverse( b_mc );;
gap> right_unitor_inverse_c_mc := RightUnitorInverse( c_mc );;
gap> right_unitor_inverse_d_mc := RightUnitorInverse( d_mc );;

gap> right_unitor_inverse_a_mcop := RightUnitorInverse( a_mcop );;
gap> right_unitor_inverse_b_mcop := RightUnitorInverse( b_mcop );;
gap> right_unitor_inverse_c_mcop := RightUnitorInverse( c_mcop );;
gap> right_unitor_inverse_d_mcop := RightUnitorInverse( d_mcop );;

# Opposite correspondence

gap> left_unitor_a_mcop = Opposite( left_unitor_inverse_a_mc );
true
gap> left_unitor_b_mcop = Opposite( left_unitor_inverse_b_mc );
true
gap> left_unitor_c_mcop = Opposite( left_unitor_inverse_c_mc );
true
gap> left_unitor_d_mcop = Opposite( left_unitor_inverse_d_mc );
true

gap> left_unitor_inverse_a_mcop = Opposite( left_unitor_a_mc );
true
gap> left_unitor_inverse_b_mcop = Opposite( left_unitor_b_mc );
true
gap> left_unitor_inverse_c_mcop = Opposite( left_unitor_c_mc );
true
gap> left_unitor_inverse_d_mcop = Opposite( left_unitor_d_mc );
true

gap> right_unitor_a_mcop = Opposite( right_unitor_inverse_a_mc );
true
gap> right_unitor_b_mcop = Opposite( right_unitor_inverse_b_mc );
true
gap> right_unitor_c_mcop = Opposite( right_unitor_inverse_c_mc );
true
gap> right_unitor_d_mcop = Opposite( right_unitor_inverse_d_mc );
true

gap> right_unitor_inverse_a_mcop = Opposite( right_unitor_a_mc );
true
gap> right_unitor_inverse_b_mcop = Opposite( right_unitor_b_mc );
true
gap> right_unitor_inverse_c_mcop = Opposite( right_unitor_c_mc );
true
gap> right_unitor_inverse_d_mcop = Opposite( right_unitor_d_mc );
true

gap> left_unitor_b_mcop = Opposite( left_unitor_inverse_a_mc );
false
gap> left_unitor_b_mcop = Opposite( left_unitor_inverse_c_mc );
false
gap> left_unitor_b_mcop = Opposite( left_unitor_inverse_d_mc );
false

gap> left_unitor_inverse_c_mcop = Opposite( left_unitor_a_mc );
false
gap> left_unitor_inverse_c_mcop = Opposite( left_unitor_b_mc );
false
gap> left_unitor_inverse_c_mcop = Opposite( left_unitor_d_mc );
false

gap> right_unitor_a_mcop = Opposite( right_unitor_inverse_b_mc );
false
gap> right_unitor_a_mcop = Opposite( right_unitor_inverse_c_mc );
false
gap> right_unitor_a_mcop = Opposite( right_unitor_inverse_d_mc );
false

gap> right_unitor_inverse_d_mcop = Opposite( right_unitor_a_mc );
false
gap> right_unitor_inverse_d_mcop = Opposite( right_unitor_b_mc );
false
gap> right_unitor_inverse_d_mcop = Opposite( right_unitor_c_mc );
false

######################################################
# Associators
######################################################

gap> associator_left_to_right_abc_mc := AssociatorLeftToRight( a_mc, b_mc, c_mc );;
gap> associator_left_to_right_bcd_mc := AssociatorLeftToRight( b_mc, c_mc, d_mc );;
gap> associator_left_to_right_acd_mc := AssociatorLeftToRight( a_mc, c_mc, d_mc );;
gap> associator_left_to_right_cba_mc := AssociatorLeftToRight( c_mc, b_mc, a_mc );;
gap> associator_left_to_right_dcb_mc := AssociatorLeftToRight( d_mc, c_mc, b_mc );;

gap> associator_left_to_right_abc_mcop := AssociatorLeftToRight( a_mcop, b_mcop, c_mcop );;
gap> associator_left_to_right_bcd_mcop := AssociatorLeftToRight( b_mcop, c_mcop, d_mcop );;
gap> associator_left_to_right_acd_mcop := AssociatorLeftToRight( a_mcop, c_mcop, d_mcop );;
gap> associator_left_to_right_cba_mcop := AssociatorLeftToRight( c_mcop, b_mcop, a_mcop );;
gap> associator_left_to_right_dcb_mcop := AssociatorLeftToRight( d_mcop, c_mcop, b_mcop );;

gap> associator_right_to_left_abc_mc := AssociatorRightToLeft( a_mc, b_mc, c_mc );;
gap> associator_right_to_left_bcd_mc := AssociatorRightToLeft( b_mc, c_mc, d_mc );;
gap> associator_right_to_left_acd_mc := AssociatorRightToLeft( a_mc, c_mc, d_mc );;
gap> associator_right_to_left_cba_mc := AssociatorRightToLeft( c_mc, b_mc, a_mc );;
gap> associator_right_to_left_dcb_mc := AssociatorRightToLeft( d_mc, c_mc, b_mc );;

gap> associator_right_to_left_abc_mcop := AssociatorRightToLeft( a_mcop, b_mcop, c_mcop );;
gap> associator_right_to_left_bcd_mcop := AssociatorRightToLeft( b_mcop, c_mcop, d_mcop );;
gap> associator_right_to_left_acd_mcop := AssociatorRightToLeft( a_mcop, c_mcop, d_mcop );;
gap> associator_right_to_left_cba_mcop := AssociatorRightToLeft( c_mcop, b_mcop, a_mcop );;
gap> associator_right_to_left_dcb_mcop := AssociatorRightToLeft( d_mcop, c_mcop, b_mcop );;

# Opposite correspondence

gap> associator_left_to_right_abc_mcop = Opposite( associator_right_to_left_abc_mc );
true
gap> associator_left_to_right_bcd_mcop = Opposite( associator_right_to_left_bcd_mc );
true
gap> associator_left_to_right_acd_mcop = Opposite( associator_right_to_left_acd_mc );
true
gap> associator_left_to_right_cba_mcop = Opposite( associator_right_to_left_cba_mc );
true
gap> associator_left_to_right_dcb_mcop = Opposite( associator_right_to_left_dcb_mc );
true

gap> associator_right_to_left_abc_mcop = Opposite( associator_left_to_right_abc_mc );
true
gap> associator_right_to_left_bcd_mcop = Opposite( associator_left_to_right_bcd_mc );
true
gap> associator_right_to_left_acd_mcop = Opposite( associator_left_to_right_acd_mc );
true
gap> associator_right_to_left_cba_mcop = Opposite( associator_left_to_right_cba_mc );
true
gap> associator_right_to_left_dcb_mcop = Opposite( associator_left_to_right_dcb_mc );
true

gap> associator_left_to_right_cba_mcop = Opposite( associator_right_to_left_bcd_mc );
false
gap> associator_left_to_right_cba_mcop = Opposite( associator_right_to_left_acd_mc );
false
gap> associator_left_to_right_cba_mcop = Opposite( associator_right_to_left_dcb_mc );
false

gap> associator_right_to_left_acd_mcop = Opposite( associator_left_to_right_abc_mc );
false
gap> associator_right_to_left_acd_mcop = Opposite( associator_left_to_right_bcd_mc );
false
gap> associator_right_to_left_acd_mcop = Opposite( associator_left_to_right_cba_mc );
false

######################################################
# Braiding
######################################################

gap> braiding_a_b_mc := Braiding( a_mc, b_mc );;
gap> braiding_b_a_mc := Braiding( b_mc, a_mc );;
gap> braiding_c_d_mc := Braiding( c_mc, d_mc );;
gap> braiding_d_c_mc := Braiding( d_mc, c_mc );;

gap> braiding_0_a_mc := Braiding( 0_mc, a_mc );;
gap> braiding_a_0_mc := Braiding( a_mc, 0_mc );;

gap> braiding_a_b_mcop := Braiding( a_mcop, b_mcop );;
gap> braiding_b_a_mcop := Braiding( b_mcop, a_mcop );;
gap> braiding_c_d_mcop := Braiding( c_mcop, d_mcop );;
gap> braiding_d_c_mcop := Braiding( d_mcop, c_mcop );;

gap> braiding_0_a_mcop := Braiding( 0_mcop, a_mcop );;
gap> braiding_a_0_mcop := Braiding( a_mcop, 0_mcop );;

gap> braiding_inverse_a_b_mc := BraidingInverse( a_mc, b_mc );;
gap> braiding_inverse_b_a_mc := BraidingInverse( b_mc, a_mc );;
gap> braiding_inverse_c_d_mc := BraidingInverse( c_mc, d_mc );;
gap> braiding_inverse_d_c_mc := BraidingInverse( d_mc, c_mc );;

gap> braiding_inverse_0_a_mc := BraidingInverse( 0_mc, a_mc );;
gap> braiding_inverse_a_0_mc := BraidingInverse( a_mc, 0_mc );;

gap> braiding_inverse_a_b_mcop := BraidingInverse( a_mcop, b_mcop );;
gap> braiding_inverse_b_a_mcop := BraidingInverse( b_mcop, a_mcop );;
gap> braiding_inverse_c_d_mcop := BraidingInverse( c_mcop, d_mcop );;
gap> braiding_inverse_d_c_mcop := BraidingInverse( d_mcop, c_mcop );;

gap> braiding_inverse_0_a_mcop := BraidingInverse( 0_mcop, a_mcop );;
gap> braiding_inverse_a_0_mcop := BraidingInverse( a_mcop, 0_mcop );;

# Opposite correspondence

gap> braiding_a_b_mcop = Opposite( braiding_inverse_a_b_mc );
true
gap> braiding_b_a_mcop = Opposite( braiding_inverse_b_a_mc );
true
gap> braiding_c_d_mcop = Opposite( braiding_inverse_c_d_mc );
true
gap> braiding_d_c_mcop = Opposite( braiding_inverse_d_c_mc );
true
gap> braiding_0_a_mcop = Opposite( braiding_inverse_0_a_mc );
true
gap> braiding_a_0_mcop = Opposite( braiding_inverse_a_0_mc );
true

gap> braiding_inverse_a_b_mcop = Opposite( braiding_a_b_mc );
true
gap> braiding_inverse_b_a_mcop = Opposite( braiding_b_a_mc );
true
gap> braiding_inverse_c_d_mcop = Opposite( braiding_c_d_mc );
true
gap> braiding_inverse_d_c_mcop = Opposite( braiding_d_c_mc );
true
gap> braiding_inverse_0_a_mcop = Opposite( braiding_0_a_mc );
true
gap> braiding_inverse_a_0_mcop = Opposite( braiding_a_0_mc );
true

gap> braiding_a_b_mcop = Opposite( braiding_inverse_b_a_mc );
false
gap> braiding_a_b_mcop = Opposite( braiding_inverse_c_d_mc );
false
gap> braiding_a_b_mcop = Opposite( braiding_inverse_d_c_mc );
false

gap> braiding_c_d_mcop = Opposite( braiding_inverse_a_b_mc );
false
gap> braiding_c_d_mcop = Opposite( braiding_inverse_b_a_mc );
false
gap> braiding_c_d_mcop = Opposite( braiding_inverse_d_c_mc );
false

gap> braiding_inverse_b_a_mcop = Opposite( braiding_a_b_mc );
false
gap> braiding_inverse_b_a_mcop = Opposite( braiding_c_d_mc );
false
gap> braiding_inverse_b_a_mcop = Opposite( braiding_d_c_mc );
false

gap> braiding_inverse_d_c_mcop = Opposite( braiding_a_b_mc );
false
gap> braiding_inverse_d_c_mcop = Opposite( braiding_b_a_mc );
false
gap> braiding_inverse_d_c_mcop = Opposite( braiding_c_d_mc );
false

######################################################
# Identity morphisms
######################################################

# Identities for tensor objects

gap> id_a_tensor_b_mc := IdentityMorphism( a_tensor_b_mc );;
gap> id_b_tensor_a_mc := IdentityMorphism( b_tensor_a_mc );;
gap> id_c_tensor_d_mc := IdentityMorphism( c_tensor_d_mc );;
gap> id_d_tensor_c_mc := IdentityMorphism( d_tensor_c_mc );;

gap> id_0_tensor_a_mc := IdentityMorphism( 0_tensor_a_mc );;
gap> id_a_tensor_0_mc := IdentityMorphism( a_tensor_0_mc );;

gap> id_a_tensor_b_mcop := IdentityMorphism( a_tensor_b_mcop );;
gap> id_b_tensor_a_mcop := IdentityMorphism( b_tensor_a_mcop );;
gap> id_c_tensor_d_mcop := IdentityMorphism( c_tensor_d_mcop );;
gap> id_d_tensor_c_mcop := IdentityMorphism( d_tensor_c_mcop );;

gap> id_0_tensor_a_mcop := IdentityMorphism( 0_tensor_a_mcop );;
gap> id_a_tensor_0_mcop := IdentityMorphism( a_tensor_0_mcop );;

# Identities for internal (co)homs

gap> id_hom_ab_mc := IdentityMorphism( hom_ab_mc );;
gap> id_hom_ba_mc := IdentityMorphism (hom_ba_mc );;
gap> id_hom_cd_mc := IdentityMorphism( hom_cd_mc );;
gap> id_hom_dc_mc := IdentityMorphism( hom_dc_mc );;

gap> id_hom_0a_mc := IdentityMorphism( hom_0a_mc );;
gap> id_hom_a0_mc := IdentityMorphism( hom_a0_mc );;

gap> id_cohom_ab_mc := IdentityMorphism( cohom_ab_mc );;
gap> id_cohom_ba_mc := IdentityMorphism( cohom_ba_mc );;
gap> id_cohom_cd_mc := IdentityMorphism( cohom_cd_mc );;
gap> id_cohom_dc_mc := IdentityMorphism( cohom_dc_mc );;

gap> id_cohom_0a_mc := IdentityMorphism( cohom_0a_mc );;
gap> id_cohom_a0_mc := IdentityMorphism( cohom_a0_mc );;

gap> id_hom_ab_mcop := IdentityMorphism( hom_ab_mcop );;
gap> id_hom_ba_mcop := IdentityMorphism (hom_ba_mcop );;
gap> id_hom_cd_mcop := IdentityMorphism( hom_cd_mcop );;
gap> id_hom_dc_mcop := IdentityMorphism( hom_dc_mcop );;

gap> id_hom_0a_mcop := IdentityMorphism( hom_0a_mcop );;
gap> id_hom_a0_mcop := IdentityMorphism( hom_a0_mcop );;

gap> id_cohom_ab_mcop := IdentityMorphism( cohom_ab_mcop );;
gap> id_cohom_ba_mcop := IdentityMorphism( cohom_ba_mcop );;
gap> id_cohom_cd_mcop := IdentityMorphism( cohom_cd_mcop );;
gap> id_cohom_dc_mcop := IdentityMorphism( cohom_dc_mcop );;

gap> id_cohom_0a_mcop := IdentityMorphism( cohom_0a_mcop );;
gap> id_cohom_a0_mcop := IdentityMorphism( cohom_a0_mcop );;

# Opposite correspondence on identities of tensor objects

gap> id_a_tensor_b_mcop = Opposite( id_a_tensor_b_mc );
true
gap> id_b_tensor_a_mcop = Opposite( id_b_tensor_a_mc );
true
gap> id_c_tensor_d_mcop = Opposite( id_c_tensor_d_mc );
true
gap> id_d_tensor_c_mcop = Opposite( id_d_tensor_c_mc );
true

gap> id_0_tensor_a_mcop = Opposite( id_0_tensor_a_mc );
true
gap> id_a_tensor_0_mcop = Opposite( id_a_tensor_0_mc );
true

gap> id_a_tensor_b_mcop = Opposite( id_c_tensor_d_mc );
false
gap> id_a_tensor_b_mcop = Opposite( id_d_tensor_c_mc );
false
gap> id_c_tensor_d_mcop = Opposite( id_a_tensor_b_mc );
false
gap> id_c_tensor_d_mcop = Opposite( id_b_tensor_a_mc );
false

# Opposite correspondence on identities of internal (co)homs

gap> id_hom_ab_mcop = Opposite( id_cohom_ba_mc );
true
gap> id_hom_ba_mcop = Opposite( id_cohom_ab_mc );
true
gap> id_hom_cd_mcop = Opposite( id_cohom_dc_mc );
true
gap> id_hom_dc_mcop = Opposite( id_cohom_cd_mc );
true

gap> id_hom_0a_mcop = Opposite( id_cohom_a0_mc );
true
gap> id_hom_a0_mcop = Opposite( id_cohom_0a_mc );
true

gap> id_cohom_ab_mcop = Opposite( id_hom_ba_mc );
true
gap> id_cohom_ba_mcop = Opposite( id_hom_ab_mc );
true
gap> id_cohom_cd_mcop = Opposite( id_hom_dc_mc );
true
gap> id_cohom_dc_mcop = Opposite( id_hom_cd_mc );
true

gap> id_cohom_0a_mcop = Opposite( id_hom_a0_mc );
true
gap> id_cohom_a0_mcop = Opposite( id_hom_0a_mc );
true

gap> id_hom_cd_mcop = Opposite( id_hom_ab_mc );
false
gap> id_hom_cd_mcop = Opposite( id_hom_ba_mc );
false
gap> id_hom_cd_mcop = Opposite( id_cohom_ab_mc );
false
gap> id_hom_cd_mcop = Opposite( id_cohom_ba_mc );
false

gap> id_cohom_ab_mcop = Opposite( id_hom_cd_mc );
false
gap> id_cohom_ab_mcop = Opposite( id_hom_dc_mc );
false
gap> id_cohom_ab_mcop = Opposite( id_cohom_cd_mc );
false
gap> id_cohom_ab_mcop = Opposite( id_cohom_dc_mc );
false

#####################################################
# Units and counits
#####################################################

# Units and counits for matrix category 

gap> ev_ab_mc := EvaluationMorphism( a_mc, b_mc );;
gap> ev_ba_mc := EvaluationMorphism( b_mc, a_mc );;
gap> ev_cd_mc := EvaluationMorphism( c_mc, d_mc );;
gap> ev_dc_mc := EvaluationMorphism( d_mc, c_mc );;

gap> ev_0a_mc := EvaluationMorphism( 0_mc, a_mc );;
gap> ev_a0_mc := EvaluationMorphism( a_mc, 0_mc );;

gap> coev_ab_mc := CoevaluationMorphism( a_mc, b_mc );;
gap> coev_ba_mc := CoevaluationMorphism( b_mc, a_mc );;
gap> coev_cd_mc := CoevaluationMorphism( c_mc, d_mc );;
gap> coev_dc_mc := CoevaluationMorphism( d_mc, c_mc );;

gap> coev_0a_mc := CoevaluationMorphism( 0_mc, a_mc );;
gap> coev_a0_mc := CoevaluationMorphism( a_mc, 0_mc );;

gap> cocl_ev_ab_mc := CoclosedEvaluationMorphism( a_mc, b_mc );;
gap> cocl_ev_ba_mc := CoclosedEvaluationMorphism( b_mc, a_mc );;
gap> cocl_ev_cd_mc := CoclosedEvaluationMorphism( c_mc, d_mc );;
gap> cocl_ev_dc_mc := CoclosedEvaluationMorphism( d_mc, c_mc );;

gap> cocl_ev_0a_mc := CoclosedEvaluationMorphism( 0_mc, a_mc );;
gap> cocl_ev_a0_mc := CoclosedEvaluationMorphism( a_mc, 0_mc );;

gap> cocl_coev_ab_mc := CoclosedCoevaluationMorphism( a_mc, b_mc );;
gap> cocl_coev_ba_mc := CoclosedCoevaluationMorphism( b_mc, a_mc );;
gap> cocl_coev_cd_mc := CoclosedCoevaluationMorphism( c_mc, d_mc );;
gap> cocl_coev_dc_mc := CoclosedCoevaluationMorphism( d_mc, c_mc );;

gap> cocl_coev_0a_mc := CoclosedCoevaluationMorphism( 0_mc, a_mc );;
gap> cocl_coev_a0_mc := CoclosedCoevaluationMorphism( a_mc, 0_mc );;

# Units and counits for opposite 

gap> ev_ab_mcop := EvaluationMorphism( a_mcop, b_mcop );;
gap> ev_ba_mcop := EvaluationMorphism( b_mcop, a_mcop );;
gap> ev_cd_mcop := EvaluationMorphism( c_mcop, d_mcop );;
gap> ev_dc_mcop := EvaluationMorphism( d_mcop, c_mcop );;

gap> ev_0a_mcop := EvaluationMorphism( 0_mcop, a_mcop );;
gap> ev_a0_mcop := EvaluationMorphism( a_mcop, 0_mcop );;

gap> coev_ab_mcop := CoevaluationMorphism( a_mcop, b_mcop );;
gap> coev_ba_mcop := CoevaluationMorphism( b_mcop, a_mcop );;
gap> coev_cd_mcop := CoevaluationMorphism( c_mcop, d_mcop );;
gap> coev_dc_mcop := CoevaluationMorphism( d_mcop, c_mcop );;

gap> coev_0a_mcop := CoevaluationMorphism( 0_mcop, a_mcop );;
gap> coev_a0_mcop := CoevaluationMorphism( a_mcop, 0_mcop );;

gap> cocl_ev_ab_mcop := CoclosedEvaluationMorphism( a_mcop, b_mcop );;
gap> cocl_ev_ba_mcop := CoclosedEvaluationMorphism( b_mcop, a_mcop );;
gap> cocl_ev_cd_mcop := CoclosedEvaluationMorphism( c_mcop, d_mcop );;
gap> cocl_ev_dc_mcop := CoclosedEvaluationMorphism( d_mcop, c_mcop );;

gap> cocl_ev_0a_mcop := CoclosedEvaluationMorphism( 0_mcop, a_mcop );;
gap> cocl_ev_a0_mcop := CoclosedEvaluationMorphism( a_mcop, 0_mcop );;

gap> cocl_coev_ab_mcop := CoclosedCoevaluationMorphism( a_mcop, b_mcop );;
gap> cocl_coev_ba_mcop := CoclosedCoevaluationMorphism( b_mcop, a_mcop );;
gap> cocl_coev_cd_mcop := CoclosedCoevaluationMorphism( c_mcop, d_mcop );;
gap> cocl_coev_dc_mcop := CoclosedCoevaluationMorphism( d_mcop, c_mcop );;

gap> cocl_coev_0a_mcop := CoclosedCoevaluationMorphism( 0_mcop, a_mcop );;
gap> cocl_coev_a0_mcop := CoclosedCoevaluationMorphism( a_mcop, 0_mcop );;

# Opposite correspondence on units and counits

# Arguments must be reversed for evaluations
gap> ev_ab_mcop = Opposite( cocl_ev_ba_mc );
true
gap> ev_ba_mcop = Opposite( cocl_ev_ab_mc );
true
gap> ev_cd_mcop = Opposite( cocl_ev_dc_mc );
true
gap> ev_dc_mcop = Opposite( cocl_ev_cd_mc );
true

gap> ev_0a_mcop = Opposite( cocl_ev_a0_mc );
true
gap> ev_a0_mcop = Opposite( cocl_ev_0a_mc );
true

gap> coev_ab_mcop = Opposite( cocl_coev_ab_mc );
true
gap> coev_ba_mcop = Opposite( cocl_coev_ba_mc );
true
gap> coev_cd_mcop = Opposite( cocl_coev_cd_mc );
true
gap> coev_dc_mcop = Opposite( cocl_coev_dc_mc );
true

gap> coev_0a_mcop = Opposite( cocl_coev_0a_mc );
true
gap> coev_a0_mcop = Opposite( cocl_coev_a0_mc );
true

# Arguments must be reversed for evaluations
gap> cocl_ev_ab_mcop= Opposite( ev_ba_mc );
true
gap> cocl_ev_ba_mcop= Opposite( ev_ab_mc );
true
gap> cocl_ev_cd_mcop= Opposite( ev_dc_mc );
true
gap> cocl_ev_dc_mcop= Opposite( ev_cd_mc );
true

gap> cocl_ev_0a_mcop= Opposite( ev_a0_mc );
true
gap> cocl_ev_a0_mcop= Opposite( ev_0a_mc );
true

gap> cocl_coev_ab_mcop = Opposite( coev_ab_mc );
true
gap> cocl_coev_ba_mcop = Opposite( coev_ba_mc );
true
gap> cocl_coev_cd_mcop = Opposite( coev_cd_mc );
true
gap> cocl_coev_dc_mcop = Opposite( coev_dc_mc );
true

gap> cocl_coev_0a_mcop = Opposite( coev_0a_mc );
true
gap> cocl_coev_a0_mcop = Opposite( coev_a0_mc );
true

gap> ev_ba_mcop = Opposite( cocl_ev_ba_mc );
false
gap> ev_ba_mcop = Opposite( cocl_ev_cd_mc );
false
gap> ev_ba_mcop = Opposite( cocl_ev_dc_mc );
false

gap> coev_dc_mcop = Opposite( cocl_coev_cd_mc );
false
gap> coev_dc_mcop = Opposite( cocl_coev_ab_mc );
false
gap> coev_dc_mcop = Opposite( cocl_coev_ba_mc );
false

gap> cocl_ev_cd_mcop = Opposite( ev_ab_mc );
false
gap> cocl_ev_cd_mcop = Opposite( ev_ba_mc );
false
gap> cocl_ev_cd_mcop = Opposite( ev_cd_mc );
false

gap> cocl_coev_ab_mcop = Opposite( coev_ba_mc );
false
gap> cocl_coev_ab_mcop = Opposite( coev_cd_mc );
false
gap> cocl_coev_ab_mcop = Opposite( coev_dc_mc );
false

#####################################################
# Adjunction maps on identities
#####################################################

# Closed and coclosed structure for matrix category 

gap> tensor_to_hom_adjunction_on_id_a_tensor_b_mc := TensorProductToInternalHomAdjunctionMap( a_mc, b_mc, id_a_tensor_b_mc );;
gap> tensor_to_hom_adjunction_on_id_b_tensor_a_mc := TensorProductToInternalHomAdjunctionMap( b_mc, a_mc, id_b_tensor_a_mc );;
gap> tensor_to_hom_adjunction_on_id_c_tensor_d_mc := TensorProductToInternalHomAdjunctionMap( c_mc, d_mc, id_c_tensor_d_mc );;
gap> tensor_to_hom_adjunction_on_id_d_tensor_c_mc := TensorProductToInternalHomAdjunctionMap( d_mc, c_mc, id_d_tensor_c_mc );;

gap> tensor_to_hom_adjunction_on_id_0_tensor_a_mc := TensorProductToInternalHomAdjunctionMap( 0_mc, a_mc, id_0_tensor_a_mc );;
gap> tensor_to_hom_adjunction_on_id_a_tensor_0_mc := TensorProductToInternalHomAdjunctionMap( a_mc, 0_mc, id_a_tensor_0_mc );;

gap> hom_to_tensor_adjunction_on_id_hom_ab_mc := InternalHomToTensorProductAdjunctionMap( a_mc, b_mc, id_hom_ab_mc );;
gap> hom_to_tensor_adjunction_on_id_hom_ba_mc := InternalHomToTensorProductAdjunctionMap( b_mc, a_mc, id_hom_ba_mc );;
gap> hom_to_tensor_adjunction_on_id_hom_cd_mc := InternalHomToTensorProductAdjunctionMap( c_mc, d_mc, id_hom_cd_mc );;
gap> hom_to_tensor_adjunction_on_id_hom_dc_mc := InternalHomToTensorProductAdjunctionMap( d_mc, c_mc, id_hom_dc_mc );;

gap> hom_to_tensor_adjunction_on_id_hom_0a_mc := InternalHomToTensorProductAdjunctionMap( 0_mc, a_mc, id_hom_0a_mc );;
gap> hom_to_tensor_adjunction_on_id_hom_a0_mc := InternalHomToTensorProductAdjunctionMap( a_mc, 0_mc, id_hom_a0_mc );;

gap> tensor_to_cohom_adjunction_on_id_a_tensor_b_mc := TensorProductToInternalCoHomAdjunctionMap( a_mc, b_mc, id_a_tensor_b_mc );;
gap> tensor_to_cohom_adjunction_on_id_b_tensor_a_mc := TensorProductToInternalCoHomAdjunctionMap( b_mc, a_mc, id_b_tensor_a_mc );;
gap> tensor_to_cohom_adjunction_on_id_c_tensor_d_mc := TensorProductToInternalCoHomAdjunctionMap( c_mc, d_mc, id_c_tensor_d_mc );;
gap> tensor_to_cohom_adjunction_on_id_d_tensor_c_mc := TensorProductToInternalCoHomAdjunctionMap( d_mc, c_mc, id_d_tensor_c_mc );;

gap> tensor_to_cohom_adjunction_on_id_0_tensor_a_mc := TensorProductToInternalCoHomAdjunctionMap( 0_mc, a_mc, id_0_tensor_a_mc );;
gap> tensor_to_cohom_adjunction_on_id_a_tensor_0_mc := TensorProductToInternalCoHomAdjunctionMap( a_mc, 0_mc, id_a_tensor_0_mc );;

gap> cohom_to_tensor_adjunction_on_id_cohom_ab_mc := InternalCoHomToTensorProductAdjunctionMap( a_mc, b_mc, id_cohom_ab_mc );;
gap> cohom_to_tensor_adjunction_on_id_cohom_ba_mc := InternalCoHomToTensorProductAdjunctionMap( b_mc, a_mc, id_cohom_ba_mc );;
gap> cohom_to_tensor_adjunction_on_id_cohom_cd_mc := InternalCoHomToTensorProductAdjunctionMap( c_mc, d_mc, id_cohom_cd_mc );;
gap> cohom_to_tensor_adjunction_on_id_cohom_dc_mc := InternalCoHomToTensorProductAdjunctionMap( d_mc, c_mc, id_cohom_dc_mc );;

gap> cohom_to_tensor_adjunction_on_id_cohom_0a_mc := InternalCoHomToTensorProductAdjunctionMap( 0_mc, a_mc, id_cohom_0a_mc );;
gap> cohom_to_tensor_adjunction_on_id_cohom_a0_mc := InternalCoHomToTensorProductAdjunctionMap( a_mc, 0_mc, id_cohom_a0_mc );;

# Closed and coclosed structure for opposite 

gap> tensor_to_hom_adjunction_on_id_a_tensor_b_mcop := TensorProductToInternalHomAdjunctionMap( a_mcop, b_mcop, id_a_tensor_b_mcop );;
gap> tensor_to_hom_adjunction_on_id_b_tensor_a_mcop := TensorProductToInternalHomAdjunctionMap( b_mcop, a_mcop, id_b_tensor_a_mcop );;
gap> tensor_to_hom_adjunction_on_id_c_tensor_d_mcop := TensorProductToInternalHomAdjunctionMap( c_mcop, d_mcop, id_c_tensor_d_mcop );;
gap> tensor_to_hom_adjunction_on_id_d_tensor_c_mcop := TensorProductToInternalHomAdjunctionMap( d_mcop, c_mcop, id_d_tensor_c_mcop );;

gap> tensor_to_hom_adjunction_on_id_0_tensor_a_mcop := TensorProductToInternalHomAdjunctionMap( 0_mcop, a_mcop, id_0_tensor_a_mcop );;
gap> tensor_to_hom_adjunction_on_id_a_tensor_0_mcop := TensorProductToInternalHomAdjunctionMap( a_mcop, 0_mcop, id_a_tensor_0_mcop );;

gap> hom_to_tensor_adjunction_on_id_hom_ab_mcop := InternalHomToTensorProductAdjunctionMap( a_mcop, b_mcop, id_hom_ab_mcop );;
gap> hom_to_tensor_adjunction_on_id_hom_ba_mcop := InternalHomToTensorProductAdjunctionMap( b_mcop, a_mcop, id_hom_ba_mcop );;
gap> hom_to_tensor_adjunction_on_id_hom_cd_mcop := InternalHomToTensorProductAdjunctionMap( c_mcop, d_mcop, id_hom_cd_mcop );;
gap> hom_to_tensor_adjunction_on_id_hom_dc_mcop := InternalHomToTensorProductAdjunctionMap( d_mcop, c_mcop, id_hom_dc_mcop );;

gap> hom_to_tensor_adjunction_on_id_hom_0a_mcop := InternalHomToTensorProductAdjunctionMap( 0_mcop, a_mcop, id_hom_0a_mcop );;
gap> hom_to_tensor_adjunction_on_id_hom_a0_mcop := InternalHomToTensorProductAdjunctionMap( a_mcop, 0_mcop, id_hom_a0_mcop );;

gap> tensor_to_cohom_adjunction_on_id_a_tensor_b_mcop := TensorProductToInternalCoHomAdjunctionMap( a_mcop, b_mcop, id_a_tensor_b_mcop );;
gap> tensor_to_cohom_adjunction_on_id_b_tensor_a_mcop := TensorProductToInternalCoHomAdjunctionMap( b_mcop, a_mcop, id_b_tensor_a_mcop );;
gap> tensor_to_cohom_adjunction_on_id_c_tensor_d_mcop := TensorProductToInternalCoHomAdjunctionMap( c_mcop, d_mcop, id_c_tensor_d_mcop );;
gap> tensor_to_cohom_adjunction_on_id_d_tensor_c_mcop := TensorProductToInternalCoHomAdjunctionMap( d_mcop, c_mcop, id_d_tensor_c_mcop );;

gap> tensor_to_cohom_adjunction_on_id_0_tensor_a_mcop := TensorProductToInternalCoHomAdjunctionMap( 0_mcop, a_mcop, id_0_tensor_a_mcop );;
gap> tensor_to_cohom_adjunction_on_id_a_tensor_0_mcop := TensorProductToInternalCoHomAdjunctionMap( a_mcop, 0_mcop, id_a_tensor_0_mcop );;

gap> cohom_to_tensor_adjunction_on_id_cohom_ab_mcop := InternalCoHomToTensorProductAdjunctionMap( a_mcop, b_mcop, id_cohom_ab_mcop );;
gap> cohom_to_tensor_adjunction_on_id_cohom_ba_mcop := InternalCoHomToTensorProductAdjunctionMap( b_mcop, a_mcop, id_cohom_ba_mcop );;
gap> cohom_to_tensor_adjunction_on_id_cohom_cd_mcop := InternalCoHomToTensorProductAdjunctionMap( c_mcop, d_mcop, id_cohom_cd_mcop );;
gap> cohom_to_tensor_adjunction_on_id_cohom_dc_mcop := InternalCoHomToTensorProductAdjunctionMap( d_mcop, c_mcop, id_cohom_dc_mcop );;

gap> cohom_to_tensor_adjunction_on_id_cohom_0a_mcop := InternalCoHomToTensorProductAdjunctionMap( 0_mcop, a_mcop, id_cohom_0a_mcop );;
gap> cohom_to_tensor_adjunction_on_id_cohom_a0_mcop := InternalCoHomToTensorProductAdjunctionMap( a_mcop, 0_mcop, id_cohom_a0_mcop );;

# Opposite correspondence on adjunction maps

# ev = op( coclev ), arguments must be reversed for evaluations

gap> hom_to_tensor_adjunction_on_id_hom_ab_mcop = Opposite( cohom_to_tensor_adjunction_on_id_cohom_ba_mc ); # Hom( a, b ) x a -> b  ==  op( b -> Cohom( b, a ) x a )
true
gap> hom_to_tensor_adjunction_on_id_hom_ba_mcop = Opposite( cohom_to_tensor_adjunction_on_id_cohom_ab_mc ); # Hom( b, a ) x b -> a  ==  op( a -> Cohom( a, b ) x b )
true
gap> hom_to_tensor_adjunction_on_id_hom_cd_mcop = Opposite( cohom_to_tensor_adjunction_on_id_cohom_dc_mc ); # Hom( c, d ) x c -> d  ==  op( d -> Cohom( d, c ) x c )
true
gap> hom_to_tensor_adjunction_on_id_hom_dc_mcop = Opposite( cohom_to_tensor_adjunction_on_id_cohom_cd_mc ); # Hom( d, c ) x d -> c  ==  op( c -> Cohom( c, d ) x d )
true

gap> hom_to_tensor_adjunction_on_id_hom_0a_mcop = Opposite( cohom_to_tensor_adjunction_on_id_cohom_a0_mc ); # Hom( 0, a ) x 0 -> a  ==  op( a -> Cohom( a, 0 ) x 0 )
true
gap> hom_to_tensor_adjunction_on_id_hom_a0_mcop = Opposite( cohom_to_tensor_adjunction_on_id_cohom_0a_mc ); # Hom( a, 0 ) x a -> 0  ==  op( 0 -> Cohom( 0, a ) x a )
true

gap> ev_ab_mcop = Opposite( cohom_to_tensor_adjunction_on_id_cohom_ba_mc );
true
gap> ev_ba_mcop = Opposite( cohom_to_tensor_adjunction_on_id_cohom_ab_mc );
true
gap> ev_cd_mcop = Opposite( cohom_to_tensor_adjunction_on_id_cohom_dc_mc );
true
gap> ev_dc_mcop = Opposite( cohom_to_tensor_adjunction_on_id_cohom_cd_mc );
true

gap> ev_0a_mcop = Opposite( cohom_to_tensor_adjunction_on_id_cohom_a0_mc );
true
gap> ev_a0_mcop = Opposite( cohom_to_tensor_adjunction_on_id_cohom_0a_mc );
true

# coev = op( coclcoev )

gap> tensor_to_hom_adjunction_on_id_a_tensor_b_mcop = Opposite( tensor_to_cohom_adjunction_on_id_a_tensor_b_mc ); # a -> Hom( b, a x b )  ==  op( Cohom( a x b, b) -> a )
true
gap> tensor_to_hom_adjunction_on_id_b_tensor_a_mcop = Opposite( tensor_to_cohom_adjunction_on_id_b_tensor_a_mc ); # b -> Hom( a, b x a )  ==  op( Cohom( b x a, a) -> b )
true
gap> tensor_to_hom_adjunction_on_id_c_tensor_d_mcop = Opposite( tensor_to_cohom_adjunction_on_id_c_tensor_d_mc ); # c -> Hom( d, c x d )  ==  op( Cohom( d x c, c) -> d )
true
gap> tensor_to_hom_adjunction_on_id_d_tensor_c_mcop = Opposite( tensor_to_cohom_adjunction_on_id_d_tensor_c_mc ); # d -> Hom( c, d x c )  ==  op( Cohom( c x d, d) -> c )
true

gap> tensor_to_hom_adjunction_on_id_0_tensor_a_mcop = Opposite( tensor_to_cohom_adjunction_on_id_0_tensor_a_mc ); # 0 -> Hom( a, 0 x a )  ==  op( Cohom( 0 x a, a) -> 0 )
true
gap> tensor_to_hom_adjunction_on_id_a_tensor_0_mcop = Opposite( tensor_to_cohom_adjunction_on_id_a_tensor_0_mc ); # a -> Hom( 0, a x 0 )  ==  op( Cohom( a x 0, 0) -> a )
true

gap> coev_ab_mcop = Opposite( tensor_to_cohom_adjunction_on_id_a_tensor_b_mc );
true
gap> coev_ba_mcop = Opposite( tensor_to_cohom_adjunction_on_id_b_tensor_a_mc );
true
gap> coev_cd_mcop = Opposite( tensor_to_cohom_adjunction_on_id_c_tensor_d_mc );
true
gap> coev_dc_mcop = Opposite( tensor_to_cohom_adjunction_on_id_d_tensor_c_mc );
true

gap> coev_0a_mcop = Opposite( tensor_to_cohom_adjunction_on_id_0_tensor_a_mc );
true
gap> coev_a0_mcop = Opposite( tensor_to_cohom_adjunction_on_id_a_tensor_0_mc );
true

# coclev = op( ev ), arguments must be reversed for evaluations

gap> cohom_to_tensor_adjunction_on_id_cohom_ab_mcop = Opposite( hom_to_tensor_adjunction_on_id_hom_ba_mc ); # a -> Cohom( a, b ) x b  ==  op( Hom( b, a ) x b -> a )
true
gap> cohom_to_tensor_adjunction_on_id_cohom_ba_mcop = Opposite( hom_to_tensor_adjunction_on_id_hom_ab_mc ); # b -> Cohom( b, a ) x a  ==  op( Hom( a, b ) x a -> b )
true
gap> cohom_to_tensor_adjunction_on_id_cohom_cd_mcop = Opposite( hom_to_tensor_adjunction_on_id_hom_dc_mc ); # c -> Cohom( c, d ) x d  ==  op( Hom( d, c ) x d -> c )
true
gap> cohom_to_tensor_adjunction_on_id_cohom_dc_mcop = Opposite( hom_to_tensor_adjunction_on_id_hom_cd_mc ); # d -> Cohom( d, c ) x c  ==  op( Hom( c, d ) x c -> d )
true

gap> cohom_to_tensor_adjunction_on_id_cohom_0a_mcop = Opposite( hom_to_tensor_adjunction_on_id_hom_a0_mc ); # 0 -> Cohom( 0, a ) x a  ==  op( Hom( a, 0 ) x a -> 0 )
true
gap> cohom_to_tensor_adjunction_on_id_cohom_a0_mcop = Opposite( hom_to_tensor_adjunction_on_id_hom_0a_mc ); # a -> Cohom( a, 0 ) x 0  ==  op( Hom( 0, a ) x 0 -> a )
true

gap> cocl_ev_ab_mcop = Opposite( hom_to_tensor_adjunction_on_id_hom_ba_mc );
true
gap> cocl_ev_ba_mcop = Opposite( hom_to_tensor_adjunction_on_id_hom_ab_mc );
true
gap> cocl_ev_cd_mcop = Opposite( hom_to_tensor_adjunction_on_id_hom_dc_mc );
true
gap> cocl_ev_dc_mcop = Opposite( hom_to_tensor_adjunction_on_id_hom_cd_mc );
true

gap> cocl_ev_0a_mcop = Opposite( hom_to_tensor_adjunction_on_id_hom_a0_mc );
true
gap> cocl_ev_a0_mcop = Opposite( hom_to_tensor_adjunction_on_id_hom_0a_mc );
true

# coclcoev = op( coev )

gap> tensor_to_cohom_adjunction_on_id_a_tensor_b_mcop = Opposite( tensor_to_hom_adjunction_on_id_a_tensor_b_mc ); # Cohom( a x b, b ) -> a  ==  op( a -> Hom( b, a x b ) )
true
gap> tensor_to_cohom_adjunction_on_id_b_tensor_a_mcop = Opposite( tensor_to_hom_adjunction_on_id_b_tensor_a_mc ); # Cohom( b x a, a ) -> b  ==  op( b -> Hom( a, b x a ) )
true
gap> tensor_to_cohom_adjunction_on_id_c_tensor_d_mcop = Opposite( tensor_to_hom_adjunction_on_id_c_tensor_d_mc ); # Cohom( c x d, d ) -> c  ==  op( c -> Hom( d, c x d ) )
true
gap> tensor_to_cohom_adjunction_on_id_d_tensor_c_mcop = Opposite( tensor_to_hom_adjunction_on_id_d_tensor_c_mc ); # Cohom( d x c, c ) -> d  ==  op( d -> Hom( c, d x c ) )
true

gap> tensor_to_cohom_adjunction_on_id_0_tensor_a_mcop = Opposite( tensor_to_hom_adjunction_on_id_0_tensor_a_mc ); # Cohom( 0 x a, a ) -> 0  ==  op( 0 -> Hom( a, 0 x a ) )
true
gap> tensor_to_cohom_adjunction_on_id_a_tensor_0_mcop = Opposite( tensor_to_hom_adjunction_on_id_a_tensor_0_mc ); # Cohom( a x 0, 0 ) -> a  ==  op( a -> Hom( 0, a x 0 ) )
true

gap> cocl_coev_ab_mcop = Opposite( tensor_to_hom_adjunction_on_id_a_tensor_b_mc );
true
gap> cocl_coev_ba_mcop = Opposite( tensor_to_hom_adjunction_on_id_b_tensor_a_mc );
true
gap> cocl_coev_cd_mcop = Opposite( tensor_to_hom_adjunction_on_id_c_tensor_d_mc );
true
gap> cocl_coev_dc_mcop = Opposite( tensor_to_hom_adjunction_on_id_d_tensor_c_mc );
true

gap> cocl_coev_0a_mcop = Opposite( tensor_to_hom_adjunction_on_id_0_tensor_a_mc );
true
gap> cocl_coev_a0_mcop = Opposite( tensor_to_hom_adjunction_on_id_a_tensor_0_mc );
true

#####################################################
# Adjunction maps on non-identities
#####################################################

# Adjunction maps on tensored morphisms

gap> tensor_to_hom_adjunction_on_alpha_tensor_beta_mc := TensorProductToInternalHomAdjunctionMap( a_mc, c_mc, alpha_tensor_beta_mc );;
gap> tensor_to_hom_adjunction_on_beta_tensor_alpha_mc := TensorProductToInternalHomAdjunctionMap( c_mc, a_mc, beta_tensor_alpha_mc );;

gap> tensor_to_hom_adjunction_on_alpha_tensor_beta_mcop := TensorProductToInternalHomAdjunctionMap( a_mcop, c_mcop, alpha_tensor_beta_mcop );;
gap> tensor_to_hom_adjunction_on_beta_tensor_alpha_mcop := TensorProductToInternalHomAdjunctionMap( c_mcop, a_mcop, beta_tensor_alpha_mcop );;

gap> tensor_to_cohom_adjunction_on_alpha_tensor_beta_mc := TensorProductToInternalCoHomAdjunctionMap( a_mc, c_mc, alpha_tensor_beta_mc );;
gap> tensor_to_cohom_adjunction_on_beta_tensor_alpha_mc := TensorProductToInternalCoHomAdjunctionMap( c_mc, a_mc, beta_tensor_alpha_mc );;

gap> tensor_to_cohom_adjunction_on_alpha_tensor_beta_mcop := TensorProductToInternalCoHomAdjunctionMap( a_mcop, c_mcop, alpha_tensor_beta_mcop );;
gap> tensor_to_cohom_adjunction_on_beta_tensor_alpha_mcop := TensorProductToInternalCoHomAdjunctionMap( c_mcop, a_mcop, beta_tensor_alpha_mcop );;

# Adjunction maps on internal (co)hom morphisms

gap> hom_to_tensor_adjunction_on_hom_alpha_beta_mc := InternalHomToTensorProductAdjunctionMap( a_mc, d_mc, hom_alpha_beta_mc );;
gap> hom_to_tensor_adjunction_on_hom_beta_alpha_mc := InternalHomToTensorProductAdjunctionMap( c_mc, b_mc, hom_beta_alpha_mc );;

gap> hom_to_tensor_adjunction_on_hom_alpha_beta_mcop := InternalHomToTensorProductAdjunctionMap( b_mcop, c_mcop, hom_alpha_beta_mcop );;
gap> hom_to_tensor_adjunction_on_hom_beta_alpha_mcop := InternalHomToTensorProductAdjunctionMap( d_mcop, a_mcop, hom_beta_alpha_mcop );;

gap> cohom_to_tensor_adjunction_on_cohom_alpha_beta_mc := InternalCoHomToTensorProductAdjunctionMap( a_mc, d_mc, cohom_alpha_beta_mc );;
gap> cohom_to_tensor_adjunction_on_cohom_beta_alpha_mc := InternalCoHomToTensorProductAdjunctionMap( c_mc, b_mc, cohom_beta_alpha_mc );;

gap> cohom_to_tensor_adjunction_on_cohom_alpha_beta_mcop := InternalCoHomToTensorProductAdjunctionMap( b_mcop, c_mcop, cohom_alpha_beta_mcop );;
gap> cohom_to_tensor_adjunction_on_cohom_beta_alpha_mcop := InternalCoHomToTensorProductAdjunctionMap( d_mcop, a_mcop, cohom_beta_alpha_mcop );;

# Opposite correspondence on adjunction maps on tensor products

##########################################
#                                        #
# alpha_mc: a -> b                     #
# beta_mc:  c -> d                     #
#                                        #
# alpha_tensor_beta_mc: a x c -> b x d #
# beta_tensor_alpha_mc: c x a -> d x b #
#                                        #
##########################################
#                                        #
# alpha_mcop: b -> a                     #
# beta_mcop:  d -> c                     #
#                                        #
# alpha_tensor_beta_mcop: b x d -> a x c #
# beta_tensor_alpha_mcop: d x b -> c x a #
#                                        #
##########################################

gap> tensor_to_hom_adjunction_on_alpha_tensor_beta_mcop = Opposite( tensor_to_cohom_adjunction_on_alpha_tensor_beta_mc ); # b -> Hom( d, a x c )  ==  op( Cohom( a x c, d ) -> b )
true
gap> tensor_to_hom_adjunction_on_beta_tensor_alpha_mcop = Opposite( tensor_to_cohom_adjunction_on_beta_tensor_alpha_mc ); # d -> Hom( b, c x a )  ==  op( Cohom( c x a, b ) -> d )
true

gap> tensor_to_cohom_adjunction_on_alpha_tensor_beta_mcop = Opposite( tensor_to_hom_adjunction_on_alpha_tensor_beta_mc ); # Cohom( b x d, c ) -> a  ==  op( a -> Hom( c, b x d ) )
true
gap> tensor_to_cohom_adjunction_on_beta_tensor_alpha_mcop = Opposite( tensor_to_hom_adjunction_on_beta_tensor_alpha_mc ); # Cohom( d x b, a ) -> c  ==  op( c -> Hom( a, d x b ) )
true

# Opposite correspondence on adjunction maps on internal (co)homs

#########################################################
#                                                       #
#   hom_alpha_beta_mc: Hom( b, c ) -> Hom( a, d )     #
#   hom_beta_alpha_mc: Hom( d, a ) -> Hom( c, b )     #
#                                                       #
#   hom_alpha_beta_mcop: Hom( a, d ) -> Hom( b, c )     #
#   hom_beta_alpha_mcop: Hom( c, b ) -> Hom( d, a )     #
#                                                       #
#########################################################
#                                                       #
# cohom_alpha_beta_mc: Cohom( a, d ) -> Cohom( b, c ) #
# cohom_beta_alpha_mc: Cohom( c, b ) -> Cohom( d, a ) #
#                                                       #
# cohom_alpha_beta_mcop: Cohom( b, c ) -> Cohom( a, d ) #
# cohom_beta_alpha_mcop: Cohom( d, a ) -> Cohom( c, b ) #
#                                                       #
#########################################################

gap> hom_to_tensor_adjunction_on_hom_alpha_beta_mcop = Opposite( cohom_to_tensor_adjunction_on_cohom_beta_alpha_mc ); # Hom( a, d ) x b -> c  ==  op( c -> Cohom( d, a ) x b )
true
gap> hom_to_tensor_adjunction_on_hom_beta_alpha_mcop = Opposite( cohom_to_tensor_adjunction_on_cohom_alpha_beta_mc ); # Hom( c, b ) x d -> a  ==  op( a -> Cohom( b, c ) x d )
true

gap> cohom_to_tensor_adjunction_on_cohom_alpha_beta_mcop = Opposite( hom_to_tensor_adjunction_on_hom_beta_alpha_mc ); # b -> Cohom( a, d ) x c  ==  op( Hom( d, a ) x c -> b )
true
gap> cohom_to_tensor_adjunction_on_cohom_beta_alpha_mcop = Opposite( hom_to_tensor_adjunction_on_hom_alpha_beta_mc ); # d -> Cohom( c, b ) x a  ==  op( Hom( b, c ) x a -> d )
true

#####################################################
# Pre and post (co)composition
#####################################################

# PreCompose and PreCoCompose

gap> precompose_abc_mc := MonoidalPreComposeMorphism( a_mc, b_mc, c_mc );;
gap> precompose_cba_mc := MonoidalPreComposeMorphism( c_mc, b_mc, a_mc );;

gap> precompose_abc_mcop := MonoidalPreComposeMorphism( a_mcop, b_mcop, c_mcop );;
gap> precompose_cba_mcop := MonoidalPreComposeMorphism( c_mcop, b_mcop, a_mcop );;

gap> precocompose_abc_mc := MonoidalPreCoComposeMorphism( a_mc, b_mc, c_mc );;
gap> precocompose_cba_mc := MonoidalPreCoComposeMorphism( c_mc, b_mc, a_mc );;

gap> precocompose_abc_mcop := MonoidalPreCoComposeMorphism( a_mcop, b_mcop, c_mcop );;
gap> precocompose_cba_mcop := MonoidalPreCoComposeMorphism( c_mcop, b_mcop, a_mcop );;

# PostCompose and PostCoCompose

gap> postcompose_abc_mc := MonoidalPostComposeMorphism( a_mc, b_mc, c_mc );;
gap> postcompose_cba_mc := MonoidalPostComposeMorphism( c_mc, b_mc, a_mc );;

gap> postcompose_abc_mcop := MonoidalPostComposeMorphism( a_mcop, b_mcop, c_mcop );;
gap> postcompose_cba_mcop := MonoidalPostComposeMorphism( c_mcop, b_mcop, a_mcop );;

gap> postcocompose_abc_mc := MonoidalPostCoComposeMorphism( a_mc, b_mc, c_mc );;
gap> postcocompose_cba_mc := MonoidalPostCoComposeMorphism( c_mc, b_mc, a_mc );;

gap> postcocompose_abc_mcop := MonoidalPostCoComposeMorphism( a_mcop, b_mcop, c_mcop );;
gap> postcocompose_cba_mcop := MonoidalPostCoComposeMorphism( c_mcop, b_mcop, a_mcop );;

# Opposite correspondence on compositions

gap> precompose_abc_mcop = Opposite( precocompose_cba_mc );
true
gap> precompose_cba_mcop = Opposite( precocompose_abc_mc );
true

gap> precocompose_abc_mcop = Opposite( precompose_cba_mc );
true
gap> precocompose_cba_mcop = Opposite( precompose_abc_mc );
true

gap> postcompose_abc_mcop = Opposite( postcocompose_cba_mc );
true
gap> postcompose_cba_mcop = Opposite( postcocompose_abc_mc );
true

gap> postcocompose_abc_mcop = Opposite( postcompose_cba_mc );
true
gap> postcocompose_cba_mcop = Opposite( postcompose_abc_mc );
true

#####################################################
# (Co)Duals
#####################################################

# Dual objects

gap> a_dual_mc := DualOnObjects( a_mc );;
gap> b_dual_mc := DualOnObjects( b_mc );;

gap> a_dual_mcop := DualOnObjects( a_mcop );;
gap> b_dual_mcop := DualOnObjects( b_mcop );;

# CoDual objects

gap> a_codual_mc := CoDualOnObjects( a_mc );;
gap> b_codual_mc := CoDualOnObjects( b_mc );;

gap> a_codual_mcop := CoDualOnObjects( a_mcop );;
gap> b_codual_mcop := CoDualOnObjects( b_mcop );;

# (Co)Dual morphisms for matrix category 

gap> dual_id_a_tensor_b_mc := DualOnMorphisms( id_a_tensor_b_mc );;
gap> dual_id_b_tensor_a_mc := DualOnMorphisms( id_b_tensor_a_mc );;

gap> dual_hom_alpha_beta_mc := DualOnMorphisms( hom_alpha_beta_mc );;
gap> dual_hom_beta_alpha_mc := DualOnMorphisms( hom_beta_alpha_mc );;

gap> dual_coev_ab_mc := DualOnMorphisms( coev_ab_mc );;
gap> dual_coev_ba_mc := DualOnMorphisms( coev_ba_mc );;

gap> codual_id_a_tensor_b_mc := CoDualOnMorphisms( id_a_tensor_b_mc );;
gap> codual_id_b_tensor_a_mc := CoDualOnMorphisms( id_b_tensor_a_mc );;

gap> codual_cohom_alpha_beta_mc := CoDualOnMorphisms( cohom_alpha_beta_mc );;
gap> codual_cohom_beta_alpha_mc := CoDualOnMorphisms( cohom_beta_alpha_mc );;

gap> codual_cocl_coev_ab_mc := CoDualOnMorphisms( cocl_coev_ab_mc );;
gap> codual_cocl_coev_ba_mc := CoDualOnMorphisms( cocl_coev_ba_mc );;

# (Co)Dual morphisms for cols

gap> dual_id_a_tensor_b_mcop := DualOnMorphisms( id_a_tensor_b_mcop );;
gap> dual_id_b_tensor_a_mcop := DualOnMorphisms( id_b_tensor_a_mcop );;

gap> dual_hom_alpha_beta_mcop := DualOnMorphisms( hom_alpha_beta_mcop );;
gap> dual_hom_beta_alpha_mcop := DualOnMorphisms( hom_beta_alpha_mcop );;

gap> dual_coev_ab_mcop := DualOnMorphisms( coev_ab_mcop );;
gap> dual_coev_ba_mcop := DualOnMorphisms( coev_ba_mcop );;

gap> codual_id_a_tensor_b_mcop := CoDualOnMorphisms( id_a_tensor_b_mcop );;
gap> codual_id_b_tensor_a_mcop := CoDualOnMorphisms( id_b_tensor_a_mcop );;

gap> codual_cohom_alpha_beta_mcop := CoDualOnMorphisms( cohom_alpha_beta_mcop );;
gap> codual_cohom_beta_alpha_mcop := CoDualOnMorphisms( cohom_beta_alpha_mcop );;

gap> codual_cocl_coev_ab_mcop := CoDualOnMorphisms( cocl_coev_ab_mcop );;
gap> codual_cocl_coev_ba_mcop := CoDualOnMorphisms( cocl_coev_ba_mcop );;

# Opposite correspondence on duals

gap> a_dual_mcop = Opposite( a_codual_mc );
true
gap> b_dual_mcop = Opposite( b_codual_mc );
true

gap> dual_id_a_tensor_b_mcop = Opposite( codual_id_a_tensor_b_mc );
true
gap> dual_id_b_tensor_a_mcop = Opposite( codual_id_b_tensor_a_mc );
true

gap> dual_hom_alpha_beta_mcop = Opposite( codual_cohom_beta_alpha_mc );
true
gap> dual_hom_beta_alpha_mcop = Opposite( codual_cohom_alpha_beta_mc );
true

gap> dual_coev_ab_mcop = Opposite( codual_cocl_coev_ab_mc );
true
gap> dual_coev_ba_mcop = Opposite( codual_cocl_coev_ba_mc );
true

# Opposite correspondence on coduals

gap> a_codual_mcop = Opposite( a_dual_mc );
true
gap> b_codual_mcop = Opposite( b_dual_mc );
true

gap> codual_id_a_tensor_b_mcop = Opposite( id_a_tensor_b_mc );
true
gap> codual_id_b_tensor_a_mcop = Opposite( id_b_tensor_a_mc );
true

gap> codual_cohom_beta_alpha_mcop = Opposite( dual_hom_alpha_beta_mc );
true
gap> codual_cohom_alpha_beta_mcop = Opposite( dual_hom_beta_alpha_mc );
true

gap> codual_cocl_coev_ab_mcop = Opposite( dual_coev_ab_mc );
true
gap> codual_cocl_coev_ba_mcop = Opposite( dual_coev_ba_mc );
true

#####################################################
# Evaluation for (co)dual
#####################################################

gap> ev_for_dual_a_mc := EvaluationForDual( a_mc );;
gap> ev_for_dual_b_mc := EvaluationForDual( b_mc );;
gap> ev_for_dual_0_mc := EvaluationForDual( 0_mc );;

gap> cocl_ev_for_codual_a_mc := CoclosedEvaluationForCoDual( a_mc );;
gap> cocl_ev_for_codual_b_mc := CoclosedEvaluationForCoDual( b_mc );;
gap> cocl_ev_for_codual_0_mc := CoclosedEvaluationForCoDual( 0_mc );;

gap> ev_for_dual_a_mcop := EvaluationForDual( a_mcop );;
gap> ev_for_dual_b_mcop := EvaluationForDual( b_mcop );;
gap> ev_for_dual_0_mcop := EvaluationForDual( 0_mcop );;

gap> cocl_ev_for_codual_a_mcop := CoclosedEvaluationForCoDual( a_mcop );;
gap> cocl_ev_for_codual_b_mcop := CoclosedEvaluationForCoDual( b_mcop );;
gap> cocl_ev_for_codual_0_mcop := CoclosedEvaluationForCoDual( 0_mcop );;

# Opposite correspondence

gap> ev_for_dual_a_mcop = Opposite( cocl_ev_for_codual_a_mc );
true
gap> ev_for_dual_b_mcop = Opposite( cocl_ev_for_codual_b_mc );
true
gap> ev_for_dual_0_mcop = Opposite( cocl_ev_for_codual_0_mc );
true

gap> cocl_ev_for_codual_a_mcop = Opposite( ev_for_dual_a_mc );
true
gap> cocl_ev_for_codual_b_mcop = Opposite( ev_for_dual_b_mc );
true
gap> cocl_ev_for_codual_0_mcop = Opposite( ev_for_dual_0_mc );
true

gap> ev_for_dual_a_mcop = Opposite( cocl_ev_for_codual_b_mc );
false
gap> ev_for_dual_b_mcop = Opposite( cocl_ev_for_codual_a_mc );
false
gap> ev_for_dual_0_mcop = Opposite( cocl_ev_for_codual_a_mc );
false

gap> cocl_ev_for_codual_a_mcop = Opposite( ev_for_dual_b_mc );
false
gap> cocl_ev_for_codual_b_mcop = Opposite( ev_for_dual_a_mc );
false
gap> cocl_ev_for_codual_0_mcop = Opposite( ev_for_dual_b_mc );
false

#####################################################
# (Co)Bidual
#####################################################

# Morphism to bidual

gap> morphism_to_bidual_c_mc := MorphismToBidual( c_mc );;
gap> morphism_to_bidual_d_mc := MorphismToBidual( d_mc );;

gap> morphism_to_bidual_c_mcop := MorphismToBidual( c_mcop );;
gap> morphism_to_bidual_d_mcop := MorphismToBidual( d_mcop );;

# Morphism from cobidual

gap> morphism_from_cobidual_c_mc := MorphismFromCoBidual( c_mc );;
gap> morphism_from_cobidual_d_mc := MorphismFromCoBidual( d_mc );;

gap> morphism_from_cobidual_c_mcop := MorphismFromCoBidual( c_mcop );;
gap> morphism_from_cobidual_d_mcop := MorphismFromCoBidual( d_mcop );;

# Opposite correspondence

gap> morphism_to_bidual_c_mcop = Opposite( morphism_from_cobidual_c_mc );
true
gap> morphism_to_bidual_d_mcop = Opposite( morphism_from_cobidual_d_mc );
true

gap> morphism_from_cobidual_c_mcop = Opposite( morphism_to_bidual_c_mc );
true
gap> morphism_from_cobidual_d_mcop = Opposite( morphism_to_bidual_d_mc );
true

gap> morphism_to_bidual_c_mcop = Opposite( morphism_from_cobidual_d_mc );
false
gap> morphism_to_bidual_d_mcop = Opposite( morphism_from_cobidual_c_mc );
false

gap> morphism_from_cobidual_c_mcop = Opposite( morphism_to_bidual_d_mc );
false
gap> morphism_from_cobidual_d_mcop = Opposite( morphism_to_bidual_c_mc );
false

#############################################################
# Tensor product and internal (co)hom compatibility
#############################################################

gap> tensor_to_hom_compatibility_abcd_mc := TensorProductInternalHomCompatibilityMorphism( [ a_mc, b_mc, c_mc, d_mc ] );; # Hom( a, b ) x Hom( c, d ) -> Hom( a x c, b x d )
gap> tensor_to_hom_compatibility_cadb_mc := TensorProductInternalHomCompatibilityMorphism( [ c_mc, a_mc, d_mc, b_mc ] );; # Hom( c, a ) x Hom( d, b ) -> Hom( c x d, a x b )

gap> cohom_to_tensor_compatibility_abcd_mc := InternalCoHomTensorProductCompatibilityMorphism( [ a_mc, b_mc, c_mc, d_mc ] );; # Cohom( a x b, c x d ) -> Cohom( a, c ) x Cohom( b, d )
gap> cohom_to_tensor_compatibility_bdac_mc := InternalCoHomTensorProductCompatibilityMorphism( [ b_mc, d_mc, a_mc, c_mc ] );; # Cohom( b x d, a x c ) -> Cohom( b, a ) x Cohom( d, c )

gap> tensor_to_hom_compatibility_abcd_mcop := TensorProductInternalHomCompatibilityMorphism( [ a_mcop, b_mcop, c_mcop, d_mcop ] );; # Hom( a, b ) x Hom( c, d ) -> Hom( a x c, b x d )
gap> tensor_to_hom_compatibility_cadb_mcop := TensorProductInternalHomCompatibilityMorphism( [ c_mcop, a_mcop, d_mcop, b_mcop ] );; # Hom( c, a ) x Hom( d, b ) -> Hom( c x d, a x b )

gap> cohom_to_tensor_compatibility_abcd_mcop := InternalCoHomTensorProductCompatibilityMorphism( [ a_mcop, b_mcop, c_mcop, d_mcop ] );; # Cohom( a x b, c x d ) -> Cohom( a, c ) x Cohom( b, d )
gap> cohom_to_tensor_compatibility_bdac_mcop := InternalCoHomTensorProductCompatibilityMorphism( [ b_mcop, d_mcop, a_mcop, c_mcop ] );; # Cohom( b x d, a x c ) -> Cohom( b, a ) x Cohom( d, c )

# Opposite correspondence

gap> tensor_to_hom_compatibility_abcd_mcop = Opposite( cohom_to_tensor_compatibility_bdac_mc ); # Hom( a, b ) x Hom( c, d ) -> Hom( a x c, b x d )  ==  op( Cohom( b x d, a x c ) -> Cohom( b, a ) x Cohom( d, c ) )
true
gap> tensor_to_hom_compatibility_cadb_mcop = Opposite( cohom_to_tensor_compatibility_abcd_mc ); # Hom( c, a ) x Hom( d, b ) -> Hom( c x d, a x b )  ==  op( Cohom( a x b, c x d ) -> Cohom( a, c ) x Cohom( b, d ) )
true

gap> cohom_to_tensor_compatibility_abcd_mcop = Opposite( tensor_to_hom_compatibility_cadb_mc ); # Cohom( a x b, c x d ) -> Cohom( a, c ) x Cohom( b, d )  ==  op( Hom( c, a ) x Hom( d, b ) -> Hom( c x d, a x b ) )
true
gap> cohom_to_tensor_compatibility_bdac_mcop = Opposite( tensor_to_hom_compatibility_abcd_mc ); # Cohom( b x d, a x c ) -> Cohom( b, a ) x Cohom( d, c )  ==  op( Hom( a, b ) x Hom( c, d ) -> Hom( a x c, b x d ) )
true

gap> tensor_to_hom_compatibility_abcd_mcop = Opposite( cohom_to_tensor_compatibility_abcd_mc ); # Hom( a, b ) x Hom( c, d ) -> Hom( a x c, b x d )  =/=  op( Cohom( a x b, c x d ) -> Cohom( a, c ) x Cohom( b, d ) )
false
gap> tensor_to_hom_compatibility_cadb_mcop = Opposite( cohom_to_tensor_compatibility_bdac_mc ); # Hom( c, a ) x Hom( d, b ) -> Hom( c x d, a x b )  =/=  op( Cohom( b x d, a x c ) -> Cohom( b, a ) x Cohom( d, c ) )
false

gap> cohom_to_tensor_compatibility_abcd_mcop = Opposite( tensor_to_hom_compatibility_abcd_mc ); # Cohom( a x b, c x d ) -> Cohom( a, c ) x Cohom( b, d )  =/=  op( Hom( a, b ) x Hom( c, d ) -> Hom( a x c, b x d ) )
false
gap> cohom_to_tensor_compatibility_bdac_mcop = Opposite( tensor_to_hom_compatibility_cadb_mc ); # Cohom( b x d, a x c ) -> Cohom( b, a ) x Cohom( d, c )  =/=  op( Hom( c, a ) x Hom( d, b ) -> Hom( c x d, a x b ) )
false

#########################################################
# Tensor product duality compatibility
#########################################################

# (Co)Duality compatibility

gap> tensor_product_duality_compatibility_ab_mc := TensorProductDualityCompatibilityMorphism( a_mc, b_mc );; # a^v x b^v -> (a x b)^v
gap> tensor_product_duality_compatibility_ba_mc := TensorProductDualityCompatibilityMorphism( b_mc, a_mc );; # b^v x a^v -> (b x a)^v
gap> tensor_product_duality_compatibility_cd_mc := TensorProductDualityCompatibilityMorphism( c_mc, d_mc );; # c^v x d^v -> (c x d)^v
gap> tensor_product_duality_compatibility_dc_mc := TensorProductDualityCompatibilityMorphism( d_mc, c_mc );; # d^v x c^v -> (d x c)^v

gap> coduality_tensor_product_compatibility_ab_mc := CoDualityTensorProductCompatibilityMorphism( a_mc, b_mc );; # (a x b)_v -> a_v x b_v
gap> coduality_tensor_product_compatibility_ba_mc := CoDualityTensorProductCompatibilityMorphism( b_mc, a_mc );; # (b x a)_v -> b_v x a_v
gap> coduality_tensor_product_compatibility_cd_mc := CoDualityTensorProductCompatibilityMorphism( c_mc, d_mc );; # (c x d)_v -> c_v x d_v
gap> coduality_tensor_product_compatibility_dc_mc := CoDualityTensorProductCompatibilityMorphism( d_mc, c_mc );; # (d x c)_v -> d_v x c_v

gap> tensor_product_duality_compatibility_ab_mcop := TensorProductDualityCompatibilityMorphism( a_mcop, b_mcop );; # a^v x b^v -> (a x b)^v
gap> tensor_product_duality_compatibility_ba_mcop := TensorProductDualityCompatibilityMorphism( b_mcop, a_mcop );; # b^v x a^v -> (b x a)^v
gap> tensor_product_duality_compatibility_cd_mcop := TensorProductDualityCompatibilityMorphism( c_mcop, d_mcop );; # c^v x d^v -> (c x d)^v
gap> tensor_product_duality_compatibility_dc_mcop := TensorProductDualityCompatibilityMorphism( d_mcop, c_mcop );; # d^v x c^v -> (d x c)^v

gap> coduality_tensor_product_compatibility_ab_mcop := CoDualityTensorProductCompatibilityMorphism( a_mcop, b_mcop );; # (a x b)_v -> a_v x b_v
gap> coduality_tensor_product_compatibility_ba_mcop := CoDualityTensorProductCompatibilityMorphism( b_mcop, a_mcop );; # (b x a)_v -> b_v x a_v
gap> coduality_tensor_product_compatibility_cd_mcop := CoDualityTensorProductCompatibilityMorphism( c_mcop, d_mcop );; # (c x d)_v -> c_v x d_v
gap> coduality_tensor_product_compatibility_dc_mcop := CoDualityTensorProductCompatibilityMorphism( d_mcop, c_mcop );; # (d x c)_v -> d_v x c_v

# Tensor product internal (co)hom compatibility with units

gap> tensor_product_to_hom_compatibility_a1b1_mc := TensorProductInternalHomCompatibilityMorphism( [ a_mc, 1_mc, b_mc, 1_mc ] );; # Hom( a, 1 ) x Hom( b, 1 ) -> Hom( a x b, 1 x 1 )
gap> tensor_product_to_hom_compatibility_b1a1_mc := TensorProductInternalHomCompatibilityMorphism( [ b_mc, 1_mc, a_mc, 1_mc ] );; # Hom( b, 1 ) x Hom( a, 1 ) -> Hom( b x a, 1 x 1 )
gap> tensor_product_to_hom_compatibility_c1d1_mc := TensorProductInternalHomCompatibilityMorphism( [ c_mc, 1_mc, d_mc, 1_mc ] );; # Hom( c, 1 ) x Hom( d, 1 ) -> Hom( c x d, 1 x 1 )
gap> tensor_product_to_hom_compatibility_d1c1_mc := TensorProductInternalHomCompatibilityMorphism( [ d_mc, 1_mc, c_mc, 1_mc ] );; # Hom( d, 1 ) x Hom( c, 1 ) -> Hom( d x c, 1 x 1 )

gap> cohom_to_tensor_product_compatibility_1a1b_mc := InternalCoHomTensorProductCompatibilityMorphism( [ 1_mc, a_mc, 1_mc, b_mc ] );; # Cohom( 1 x a, 1 x b ) -> Cohom( 1, a ) x Cohom( 1, b )
gap> cohom_to_tensor_product_compatibility_1b1a_mc := InternalCoHomTensorProductCompatibilityMorphism( [ 1_mc, b_mc, 1_mc, a_mc ] );; # Cohom( 1 x b, 1 x a ) -> Cohom( 1, b ) x Cohom( 1, a )
gap> cohom_to_tensor_product_compatibility_1c1d_mc := InternalCoHomTensorProductCompatibilityMorphism( [ 1_mc, c_mc, 1_mc, d_mc ] );; # Cohom( 1 x c, 1 x d ) -> Cohom( 1, c ) x Cohom( 1, d )
gap> cohom_to_tensor_product_compatibility_1d1c_mc := InternalCoHomTensorProductCompatibilityMorphism( [ 1_mc, d_mc, 1_mc, c_mc ] );; # Cohom( 1 x d, 1 x c ) -> Cohom( 1, d ) x Cohom( 1, c )

gap> tensor_product_to_hom_compatibility_a1b1_mcop := TensorProductInternalHomCompatibilityMorphism( [ a_mcop, 1_mcop, b_mcop, 1_mcop ] );; # Hom( a, 1 ) x Hom( b, 1 ) -> Hom( a x b, 1 x 1 )
gap> tensor_product_to_hom_compatibility_b1a1_mcop := TensorProductInternalHomCompatibilityMorphism( [ b_mcop, 1_mcop, a_mcop, 1_mcop ] );; # Hom( b, 1 ) x Hom( a, 1 ) -> Hom( b x a, 1 x 1 )
gap> tensor_product_to_hom_compatibility_c1d1_mcop := TensorProductInternalHomCompatibilityMorphism( [ c_mcop, 1_mcop, d_mcop, 1_mcop ] );; # Hom( c, 1 ) x Hom( d, 1 ) -> Hom( c x d, 1 x 1 )
gap> tensor_product_to_hom_compatibility_d1c1_mcop := TensorProductInternalHomCompatibilityMorphism( [ d_mcop, 1_mcop, c_mcop, 1_mcop ] );; # Hom( d, 1 ) x Hom( c, 1 ) -> Hom( d x c, 1 x 1 )

gap> cohom_to_tensor_product_compatibility_1a1b_mcop := InternalCoHomTensorProductCompatibilityMorphism( [ 1_mcop, a_mcop, 1_mcop, b_mcop ] );; # Cohom( 1 x a, 1 x b ) -> Cohom( 1, a ) x Cohom( 1, b )
gap> cohom_to_tensor_product_compatibility_1b1a_mcop := InternalCoHomTensorProductCompatibilityMorphism( [ 1_mcop, b_mcop, 1_mcop, a_mcop ] );; # Cohom( 1 x b, 1 x a ) -> Cohom( 1, b ) x Cohom( 1, a )
gap> cohom_to_tensor_product_compatibility_1c1d_mcop := InternalCoHomTensorProductCompatibilityMorphism( [ 1_mcop, c_mcop, 1_mcop, d_mcop ] );; # Cohom( 1 x c, 1 x d ) -> Cohom( 1, c ) x Cohom( 1, d )
gap> cohom_to_tensor_product_compatibility_1d1c_mcop := InternalCoHomTensorProductCompatibilityMorphism( [ 1_mcop, d_mcop, 1_mcop, c_mcop ] );; # Cohom( 1 x d, 1 x c ) -> Cohom( 1, d ) x Cohom( 1, c )

# Opposite correspondence on (co)duality compatibility

gap> tensor_product_duality_compatibility_ab_mcop = Opposite( coduality_tensor_product_compatibility_ab_mc );
true
gap> tensor_product_duality_compatibility_ba_mcop = Opposite( coduality_tensor_product_compatibility_ba_mc );
true
gap> tensor_product_duality_compatibility_cd_mcop = Opposite( coduality_tensor_product_compatibility_cd_mc );
true
gap> tensor_product_duality_compatibility_dc_mcop = Opposite( coduality_tensor_product_compatibility_dc_mc );
true

gap> coduality_tensor_product_compatibility_ab_mcop = Opposite( tensor_product_duality_compatibility_ab_mc );
true
gap> coduality_tensor_product_compatibility_ba_mcop = Opposite( tensor_product_duality_compatibility_ba_mc );
true
gap> coduality_tensor_product_compatibility_cd_mcop = Opposite( tensor_product_duality_compatibility_cd_mc );
true
gap> coduality_tensor_product_compatibility_dc_mcop = Opposite( tensor_product_duality_compatibility_dc_mc );
true

gap> tensor_product_duality_compatibility_ab_mcop = Opposite( coduality_tensor_product_compatibility_cd_mc );
false
gap> tensor_product_duality_compatibility_ab_mcop = Opposite( coduality_tensor_product_compatibility_dc_mc );
false
gap> tensor_product_duality_compatibility_cd_mcop = Opposite( coduality_tensor_product_compatibility_ab_mc );
false
gap> tensor_product_duality_compatibility_cd_mcop = Opposite( coduality_tensor_product_compatibility_ba_mc );
false

gap> coduality_tensor_product_compatibility_ba_mcop = Opposite( tensor_product_duality_compatibility_cd_mc );
false
gap> coduality_tensor_product_compatibility_ba_mcop = Opposite( tensor_product_duality_compatibility_dc_mc );
false
gap> coduality_tensor_product_compatibility_dc_mcop = Opposite( tensor_product_duality_compatibility_ab_mc );
false
gap> coduality_tensor_product_compatibility_dc_mcop = Opposite( tensor_product_duality_compatibility_ba_mc );
false

# Opposite correspondence and consistency with internal (co)hom compatibility with units

gap> tensor_product_duality_compatibility_ab_mcop = Opposite( cohom_to_tensor_product_compatibility_1a1b_mc );
true
gap> tensor_product_duality_compatibility_ba_mcop = Opposite( cohom_to_tensor_product_compatibility_1b1a_mc );
true
gap> tensor_product_duality_compatibility_cd_mcop = Opposite( cohom_to_tensor_product_compatibility_1c1d_mc );
true
gap> tensor_product_duality_compatibility_dc_mcop = Opposite( cohom_to_tensor_product_compatibility_1d1c_mc );
true

gap> coduality_tensor_product_compatibility_ab_mcop = Opposite( tensor_product_to_hom_compatibility_a1b1_mc );
true
gap> coduality_tensor_product_compatibility_ba_mcop = Opposite( tensor_product_to_hom_compatibility_b1a1_mc );
true
gap> coduality_tensor_product_compatibility_cd_mcop = Opposite( tensor_product_to_hom_compatibility_c1d1_mc );
true
gap> coduality_tensor_product_compatibility_dc_mcop = Opposite( tensor_product_to_hom_compatibility_d1c1_mc );
true

gap> tensor_product_duality_compatibility_ba_mcop = Opposite( cohom_to_tensor_product_compatibility_1c1d_mc );
false
gap> tensor_product_duality_compatibility_ba_mcop = Opposite( cohom_to_tensor_product_compatibility_1d1c_mc );
false
gap> tensor_product_duality_compatibility_dc_mcop = Opposite( cohom_to_tensor_product_compatibility_1a1b_mc );
false
gap> tensor_product_duality_compatibility_dc_mcop = Opposite( cohom_to_tensor_product_compatibility_1b1a_mc );
false

gap> coduality_tensor_product_compatibility_ab_mcop = Opposite( tensor_product_to_hom_compatibility_c1d1_mc );
false
gap> coduality_tensor_product_compatibility_ab_mcop = Opposite( tensor_product_to_hom_compatibility_d1c1_mc );
false
gap> coduality_tensor_product_compatibility_cd_mcop = Opposite( tensor_product_to_hom_compatibility_a1b1_mc );
false
gap> coduality_tensor_product_compatibility_cd_mcop = Opposite( tensor_product_to_hom_compatibility_b1a1_mc );
false

#########################################################
# Morphism from tensor product to internal hom
#########################################################

# Morphism from tensor product to internal hom

gap> morphism_from_tensor_product_to_hom_ab_mc := MorphismFromTensorProductToInternalHom( a_mc, b_mc );;
gap> morphism_from_tensor_product_to_hom_ba_mc := MorphismFromTensorProductToInternalHom( b_mc, a_mc );;
gap> morphism_from_tensor_product_to_hom_cd_mc := MorphismFromTensorProductToInternalHom( c_mc, d_mc );;
gap> morphism_from_tensor_product_to_hom_dc_mc := MorphismFromTensorProductToInternalHom( d_mc, c_mc );;

gap> morphism_from_tensor_product_to_hom_ab_mcop := MorphismFromTensorProductToInternalHom( a_mcop, b_mcop );;
gap> morphism_from_tensor_product_to_hom_ba_mcop := MorphismFromTensorProductToInternalHom( b_mcop, a_mcop );;
gap> morphism_from_tensor_product_to_hom_cd_mcop := MorphismFromTensorProductToInternalHom( c_mcop, d_mcop );;
gap> morphism_from_tensor_product_to_hom_dc_mcop := MorphismFromTensorProductToInternalHom( d_mcop, c_mcop );;

# Morphism from internal cohom to tensor product

gap> morphism_from_cohom_to_tensor_product_ab_mc := MorphismFromInternalCoHomToTensorProduct( a_mc, b_mc );;
gap> morphism_from_cohom_to_tensor_product_ba_mc := MorphismFromInternalCoHomToTensorProduct( b_mc, a_mc );;
gap> morphism_from_cohom_to_tensor_product_cd_mc := MorphismFromInternalCoHomToTensorProduct( c_mc, d_mc );;
gap> morphism_from_cohom_to_tensor_product_dc_mc := MorphismFromInternalCoHomToTensorProduct( d_mc, c_mc );;

gap> morphism_from_cohom_to_tensor_product_ab_mcop := MorphismFromInternalCoHomToTensorProduct( a_mcop, b_mcop );;
gap> morphism_from_cohom_to_tensor_product_ba_mcop := MorphismFromInternalCoHomToTensorProduct( b_mcop, a_mcop );;
gap> morphism_from_cohom_to_tensor_product_cd_mcop := MorphismFromInternalCoHomToTensorProduct( c_mcop, d_mcop );;
gap> morphism_from_cohom_to_tensor_product_dc_mcop := MorphismFromInternalCoHomToTensorProduct( d_mcop, c_mcop );;

# Opposite correspondence

gap> morphism_from_tensor_product_to_hom_ab_mcop = Opposite( morphism_from_cohom_to_tensor_product_ba_mc );
true
gap> morphism_from_tensor_product_to_hom_ba_mcop = Opposite( morphism_from_cohom_to_tensor_product_ab_mc );
true
gap> morphism_from_tensor_product_to_hom_cd_mcop = Opposite( morphism_from_cohom_to_tensor_product_cd_mc );
true
gap> morphism_from_tensor_product_to_hom_dc_mcop = Opposite( morphism_from_cohom_to_tensor_product_dc_mc );
true

gap> morphism_from_cohom_to_tensor_product_ab_mcop = Opposite( morphism_from_tensor_product_to_hom_ba_mc );
true
gap> morphism_from_cohom_to_tensor_product_ba_mcop = Opposite( morphism_from_tensor_product_to_hom_ab_mc );
true
gap> morphism_from_cohom_to_tensor_product_cd_mcop = Opposite( morphism_from_tensor_product_to_hom_dc_mc );
true
gap> morphism_from_cohom_to_tensor_product_dc_mcop = Opposite( morphism_from_tensor_product_to_hom_cd_mc );
true

gap> morphism_from_tensor_product_to_hom_ba_mcop = Opposite( morphism_from_tensor_product_to_hom_cd_mc );
false
gap> morphism_from_tensor_product_to_hom_ba_mcop = Opposite( morphism_from_tensor_product_to_hom_dc_mc );
false

gap> morphism_from_tensor_product_to_hom_dc_mcop = Opposite( morphism_from_tensor_product_to_hom_ab_mc );
false
gap> morphism_from_tensor_product_to_hom_dc_mcop = Opposite( morphism_from_tensor_product_to_hom_ba_mc );
false

gap> morphism_from_cohom_to_tensor_product_ab_mcop = Opposite( morphism_from_tensor_product_to_hom_cd_mc );
false
gap> morphism_from_cohom_to_tensor_product_ab_mcop = Opposite( morphism_from_tensor_product_to_hom_dc_mc );
false

gap> morphism_from_cohom_to_tensor_product_cd_mcop = Opposite( morphism_from_tensor_product_to_hom_ab_mc );
false
gap> morphism_from_cohom_to_tensor_product_cd_mcop = Opposite( morphism_from_tensor_product_to_hom_ba_mc );
false

#########################################################
# Isomorphisms between dual and internal hom
#########################################################

# Isomorphism from dual to internal hom

gap> isomorphism_from_dual_to_hom_a_mc := IsomorphismFromDualToInternalHom( a_mc );;
gap> isomorphism_from_dual_to_hom_b_mc := IsomorphismFromDualToInternalHom( b_mc );;
gap> isomorphism_from_dual_to_hom_c_mc := IsomorphismFromDualToInternalHom( c_mc );;
gap> isomorphism_from_dual_to_hom_d_mc := IsomorphismFromDualToInternalHom( d_mc );;

gap> isomorphism_from_dual_to_hom_a_mcop := IsomorphismFromDualToInternalHom( a_mcop );;
gap> isomorphism_from_dual_to_hom_b_mcop := IsomorphismFromDualToInternalHom( b_mcop );;
gap> isomorphism_from_dual_to_hom_c_mcop := IsomorphismFromDualToInternalHom( c_mcop );;
gap> isomorphism_from_dual_to_hom_d_mcop := IsomorphismFromDualToInternalHom( d_mcop );;

# Isomorphism from internal hom to dual

gap> isomorphism_from_hom_to_dual_a_mc := IsomorphismFromInternalHomToDual( a_mc );;
gap> isomorphism_from_hom_to_dual_b_mc := IsomorphismFromInternalHomToDual( b_mc );;
gap> isomorphism_from_hom_to_dual_c_mc := IsomorphismFromInternalHomToDual( c_mc );;
gap> isomorphism_from_hom_to_dual_d_mc := IsomorphismFromInternalHomToDual( d_mc );;

gap> isomorphism_from_hom_to_dual_a_mcop := IsomorphismFromInternalHomToDual( a_mcop );;
gap> isomorphism_from_hom_to_dual_b_mcop := IsomorphismFromInternalHomToDual( b_mcop );;
gap> isomorphism_from_hom_to_dual_c_mcop := IsomorphismFromInternalHomToDual( c_mcop );;
gap> isomorphism_from_hom_to_dual_d_mcop := IsomorphismFromInternalHomToDual( d_mcop );;

# Isomorphism from codual to cohom

gap> isomorphism_from_codual_to_cohom_a_mc := IsomorphismFromCoDualToInternalCoHom( a_mc );;
gap> isomorphism_from_codual_to_cohom_b_mc := IsomorphismFromCoDualToInternalCoHom( b_mc );;
gap> isomorphism_from_codual_to_cohom_c_mc := IsomorphismFromCoDualToInternalCoHom( c_mc );;
gap> isomorphism_from_codual_to_cohom_d_mc := IsomorphismFromCoDualToInternalCoHom( d_mc );;

gap> isomorphism_from_codual_to_cohom_a_mcop := IsomorphismFromCoDualToInternalCoHom( a_mcop );;
gap> isomorphism_from_codual_to_cohom_b_mcop := IsomorphismFromCoDualToInternalCoHom( b_mcop );;
gap> isomorphism_from_codual_to_cohom_c_mcop := IsomorphismFromCoDualToInternalCoHom( c_mcop );;
gap> isomorphism_from_codual_to_cohom_d_mcop := IsomorphismFromCoDualToInternalCoHom( d_mcop );;

# Isomorphism from cohom to codual

gap> isomorphism_from_cohom_to_codual_a_mc := IsomorphismFromInternalCoHomToCoDual( a_mc );;
gap> isomorphism_from_cohom_to_codual_b_mc := IsomorphismFromInternalCoHomToCoDual( b_mc );;
gap> isomorphism_from_cohom_to_codual_c_mc := IsomorphismFromInternalCoHomToCoDual( c_mc );;
gap> isomorphism_from_cohom_to_codual_d_mc := IsomorphismFromInternalCoHomToCoDual( d_mc );;

gap> isomorphism_from_cohom_to_codual_a_mcop := IsomorphismFromInternalCoHomToCoDual( a_mcop );;
gap> isomorphism_from_cohom_to_codual_b_mcop := IsomorphismFromInternalCoHomToCoDual( b_mcop );;
gap> isomorphism_from_cohom_to_codual_c_mcop := IsomorphismFromInternalCoHomToCoDual( c_mcop );;
gap> isomorphism_from_cohom_to_codual_d_mcop := IsomorphismFromInternalCoHomToCoDual( d_mcop );;

# Opposite correspondence

gap> isomorphism_from_dual_to_hom_a_mcop = Opposite( isomorphism_from_cohom_to_codual_a_mc );
true
gap> isomorphism_from_dual_to_hom_b_mcop = Opposite( isomorphism_from_cohom_to_codual_b_mc );
true
gap> isomorphism_from_dual_to_hom_c_mcop = Opposite( isomorphism_from_cohom_to_codual_c_mc );
true
gap> isomorphism_from_dual_to_hom_d_mcop = Opposite( isomorphism_from_cohom_to_codual_d_mc );
true

gap> isomorphism_from_hom_to_dual_a_mcop = Opposite( isomorphism_from_codual_to_cohom_a_mc );
true
gap> isomorphism_from_hom_to_dual_b_mcop = Opposite( isomorphism_from_codual_to_cohom_b_mc );
true
gap> isomorphism_from_hom_to_dual_c_mcop = Opposite( isomorphism_from_codual_to_cohom_c_mc );
true
gap> isomorphism_from_hom_to_dual_d_mcop = Opposite( isomorphism_from_codual_to_cohom_d_mc );
true

gap> isomorphism_from_codual_to_cohom_a_mcop = Opposite( isomorphism_from_hom_to_dual_a_mc );
true
gap> isomorphism_from_codual_to_cohom_b_mcop = Opposite( isomorphism_from_hom_to_dual_b_mc );
true
gap> isomorphism_from_codual_to_cohom_c_mcop = Opposite( isomorphism_from_hom_to_dual_c_mc );
true
gap> isomorphism_from_codual_to_cohom_d_mcop = Opposite( isomorphism_from_hom_to_dual_d_mc );
true

gap> isomorphism_from_cohom_to_codual_a_mcop = Opposite( isomorphism_from_dual_to_hom_a_mc );
true
gap> isomorphism_from_cohom_to_codual_b_mcop = Opposite( isomorphism_from_dual_to_hom_b_mc );
true
gap> isomorphism_from_cohom_to_codual_c_mcop = Opposite( isomorphism_from_dual_to_hom_c_mc );
true
gap> isomorphism_from_cohom_to_codual_d_mcop = Opposite( isomorphism_from_dual_to_hom_d_mc );
true

gap> isomorphism_from_dual_to_hom_a_mcop = Opposite( isomorphism_from_cohom_to_codual_b_mc );
false
gap> isomorphism_from_dual_to_hom_a_mcop = Opposite( isomorphism_from_cohom_to_codual_c_mc );
false
gap> isomorphism_from_dual_to_hom_a_mcop = Opposite( isomorphism_from_cohom_to_codual_d_mc );
false

gap> isomorphism_from_hom_to_dual_b_mcop = Opposite( isomorphism_from_codual_to_cohom_a_mc );
false
gap> isomorphism_from_hom_to_dual_b_mcop = Opposite( isomorphism_from_codual_to_cohom_c_mc );
false
gap> isomorphism_from_hom_to_dual_b_mcop = Opposite( isomorphism_from_codual_to_cohom_d_mc );
false

gap> isomorphism_from_codual_to_cohom_c_mcop = Opposite( isomorphism_from_hom_to_dual_a_mc );
false
gap> isomorphism_from_codual_to_cohom_c_mcop = Opposite( isomorphism_from_hom_to_dual_b_mc );
false
gap> isomorphism_from_codual_to_cohom_c_mcop = Opposite( isomorphism_from_hom_to_dual_d_mc );
false

gap> isomorphism_from_cohom_to_codual_d_mcop = Opposite( isomorphism_from_dual_to_hom_a_mc );
false
gap> isomorphism_from_cohom_to_codual_d_mcop = Opposite( isomorphism_from_dual_to_hom_b_mc );
false
gap> isomorphism_from_cohom_to_codual_d_mcop = Opposite( isomorphism_from_dual_to_hom_c_mc );
false

#########################################################
# Universal property of dual
#########################################################

# Morphisms

gap> ab_to_1_mc := VectorSpaceMorphism( a_tensor_b_mc, HomalgMatrix( [ 2 .. 7], Dimension( a_tensor_b_mc ), 1, Q ), 1_mc );;
gap> cd_to_1_mc := VectorSpaceMorphism( c_tensor_d_mc, HomalgMatrix( [ 8 .. 31 ], Dimension( c_tensor_d_mc ), 1, Q ), 1_mc );;

gap> 1_to_ab_mc := VectorSpaceMorphism( 1_mc, HomalgMatrix( [ 2 .. 7], 1, Dimension( a_tensor_b_mc ), Q ), a_tensor_b_mc );;
gap> 1_to_cd_mc := VectorSpaceMorphism( 1_mc, HomalgMatrix( [ 8 .. 31 ], 1, Dimension( c_tensor_d_mc ), Q ), c_tensor_d_mc );;

gap> ab_to_1_mcop := Opposite( 1_to_ab_mc );;
gap> cd_to_1_mcop := Opposite( 1_to_cd_mc );;

gap> 1_to_ab_mcop := Opposite( ab_to_1_mc );;
gap> 1_to_cd_mcop := Opposite( cd_to_1_mc );;

# Universal property of dual

gap> universal_property_of_dual_ab_to_1_mc := UniversalPropertyOfDual( a_mc, b_mc, ab_to_1_mc );;
gap> universal_property_of_dual_cd_to_1_mc := UniversalPropertyOfDual( c_mc, d_mc, cd_to_1_mc );;

gap> universal_property_of_dual_ab_to_1_mcop := UniversalPropertyOfDual( a_mcop, b_mcop, ab_to_1_mcop );;
gap> universal_property_of_dual_cd_to_1_mcop := UniversalPropertyOfDual( c_mcop, d_mcop, cd_to_1_mcop );;

# Universal property of codual

gap> universal_property_of_codual_1_to_ab_mc := UniversalPropertyOfCoDual( a_mc, b_mc, 1_to_ab_mc );;
gap> universal_property_of_codual_1_to_cd_mc := UniversalPropertyOfCoDual( c_mc, d_mc, 1_to_cd_mc );;

gap> universal_property_of_codual_1_to_ab_mcop := UniversalPropertyOfCoDual( a_mcop, b_mcop, 1_to_ab_mcop );;
gap> universal_property_of_codual_1_to_cd_mcop := UniversalPropertyOfCoDual( c_mcop, d_mcop, 1_to_cd_mcop);;

# Opposite correspondence

gap> universal_property_of_dual_ab_to_1_mcop = Opposite( universal_property_of_codual_1_to_ab_mc );
true
gap> universal_property_of_dual_cd_to_1_mcop = Opposite( universal_property_of_codual_1_to_cd_mc );
true

gap> universal_property_of_codual_1_to_ab_mcop = Opposite( universal_property_of_dual_ab_to_1_mc );
true
gap> universal_property_of_codual_1_to_cd_mcop = Opposite( universal_property_of_dual_cd_to_1_mc );
true

gap> universal_property_of_dual_ab_to_1_mcop = Opposite( universal_property_of_codual_1_to_cd_mc );
false
gap> universal_property_of_dual_cd_to_1_mcop = Opposite( universal_property_of_codual_1_to_ab_mc );
false

gap> universal_property_of_codual_1_to_ab_mcop = Opposite( universal_property_of_dual_cd_to_1_mc );
false
gap> universal_property_of_codual_1_to_cd_mcop = Opposite( universal_property_of_dual_ab_to_1_mc );
false

#########################################################
# Lambdas
#########################################################

# Morphisms

gap> a_to_b := [ 2 .. 7 ];;
gap> c_to_d := [ 8 .. 31 ];;

gap> a_to_b_mc := VectorSpaceMorphism( a_mc, HomalgMatrix( a_to_b, 2, 3, Q ), b_mc );;
gap> b_to_a_mc := VectorSpaceMorphism( b_mc, TransposedMatrix( UnderlyingMatrix( a_to_b_mc ) ), a_mc );;
gap> c_to_d_mc := VectorSpaceMorphism( c_mc, HomalgMatrix( c_to_d, 6, 4, Q ), d_mc );;
gap> d_to_c_mc := VectorSpaceMorphism( d_mc, TransposedMatrix( UnderlyingMatrix( c_to_d_mc ) ), c_mc );;

gap> a_to_b_mcop := Opposite( b_to_a_mc );;
gap> b_to_a_mcop := Opposite( a_to_b_mc );;
gap> c_to_d_mcop := Opposite( d_to_c_mc );;
gap> d_to_c_mcop := Opposite( c_to_d_mc );;

# Lambda introduction

gap> lambda_intro_a_to_b_mc := LambdaIntroduction( a_to_b_mc );;
gap> lambda_intro_b_to_a_mc := LambdaIntroduction( b_to_a_mc );;
gap> lambda_intro_c_to_d_mc := LambdaIntroduction( c_to_d_mc );;
gap> lambda_intro_d_to_c_mc := LambdaIntroduction( d_to_c_mc );;

gap> lambda_intro_a_to_b_mcop := LambdaIntroduction( a_to_b_mcop );;
gap> lambda_intro_b_to_a_mcop := LambdaIntroduction( b_to_a_mcop );;
gap> lambda_intro_c_to_d_mcop := LambdaIntroduction( c_to_d_mcop );;
gap> lambda_intro_d_to_c_mcop := LambdaIntroduction( d_to_c_mcop );;

# Colambda introduction

gap> colambda_intro_a_to_b_mc := CoLambdaIntroduction( a_to_b_mc );;
gap> colambda_intro_b_to_a_mc := CoLambdaIntroduction( b_to_a_mc );;
gap> colambda_intro_c_to_d_mc := CoLambdaIntroduction( c_to_d_mc );;
gap> colambda_intro_d_to_c_mc := CoLambdaIntroduction( d_to_c_mc );;

gap> colambda_intro_a_to_b_mcop := CoLambdaIntroduction( a_to_b_mcop );;
gap> colambda_intro_b_to_a_mcop := CoLambdaIntroduction( b_to_a_mcop );;
gap> colambda_intro_c_to_d_mcop := CoLambdaIntroduction( c_to_d_mcop );;
gap> colambda_intro_d_to_c_mcop := CoLambdaIntroduction( d_to_c_mcop );;

# Lambda elimination

gap> lambda_elim_1_to_hom_ab_mc := LambdaElimination( a_mc, b_mc, lambda_intro_a_to_b_mc );;
gap> lambda_elim_1_to_hom_ba_mc := LambdaElimination( b_mc, a_mc, lambda_intro_b_to_a_mc );;
gap> lambda_elim_1_to_hom_cd_mc := LambdaElimination( c_mc, d_mc, lambda_intro_c_to_d_mc );;
gap> lambda_elim_1_to_hom_dc_mc := LambdaElimination( d_mc, c_mc, lambda_intro_d_to_c_mc );;

gap> lambda_elim_1_to_hom_ab_mcop := LambdaElimination( a_mcop, b_mcop, lambda_intro_a_to_b_mcop );;
gap> lambda_elim_1_to_hom_ba_mcop := LambdaElimination( b_mcop, a_mcop, lambda_intro_b_to_a_mcop );;
gap> lambda_elim_1_to_hom_cd_mcop := LambdaElimination( c_mcop, d_mcop, lambda_intro_c_to_d_mcop );;
gap> lambda_elim_1_to_hom_dc_mcop := LambdaElimination( d_mcop, c_mcop, lambda_intro_d_to_c_mcop );;

# Colambda elimination

gap> colambda_elim_cohom_ab_to_1_mc := CoLambdaElimination( a_mc, b_mc, colambda_intro_a_to_b_mc );;
gap> colambda_elim_cohom_ba_to_1_mc := CoLambdaElimination( b_mc, a_mc, colambda_intro_b_to_a_mc );;
gap> colambda_elim_cohom_cd_to_1_mc := CoLambdaElimination( c_mc, d_mc, colambda_intro_c_to_d_mc );;
gap> colambda_elim_cohom_dc_to_1_mc := CoLambdaElimination( d_mc, c_mc, colambda_intro_d_to_c_mc );;

gap> colambda_elim_cohom_ab_to_1_mcop := CoLambdaElimination( a_mcop, b_mcop, colambda_intro_a_to_b_mcop );;
gap> colambda_elim_cohom_ba_to_1_mcop := CoLambdaElimination( b_mcop, a_mcop, colambda_intro_b_to_a_mcop );;
gap> colambda_elim_cohom_cd_to_1_mcop := CoLambdaElimination( c_mcop, d_mcop, colambda_intro_c_to_d_mcop );;
gap> colambda_elim_cohom_dc_to_1_mcop := CoLambdaElimination( d_mcop, c_mcop, colambda_intro_d_to_c_mcop );;

# Opposite correspondence

gap> lambda_intro_a_to_b_mcop = Opposite( colambda_intro_b_to_a_mc );
true
gap> lambda_intro_b_to_a_mcop = Opposite( colambda_intro_a_to_b_mc );
true
gap> lambda_intro_c_to_d_mcop = Opposite( colambda_intro_d_to_c_mc );
true
gap> lambda_intro_d_to_c_mcop = Opposite( colambda_intro_c_to_d_mc );
true

gap> lambda_elim_1_to_hom_ab_mcop = Opposite( colambda_elim_cohom_ba_to_1_mc );
true
gap> lambda_elim_1_to_hom_ba_mcop = Opposite( colambda_elim_cohom_ab_to_1_mc );
true
gap> lambda_elim_1_to_hom_cd_mcop = Opposite( colambda_elim_cohom_dc_to_1_mc );
true
gap> lambda_elim_1_to_hom_dc_mcop = Opposite( colambda_elim_cohom_cd_to_1_mc );
true

gap> colambda_intro_a_to_b_mcop = Opposite( lambda_intro_b_to_a_mc );
true
gap> colambda_intro_b_to_a_mcop = Opposite( lambda_intro_a_to_b_mc );
true
gap> colambda_intro_c_to_d_mcop = Opposite( lambda_intro_d_to_c_mc );
true
gap> colambda_intro_d_to_c_mcop = Opposite( lambda_intro_c_to_d_mc );
true

gap> colambda_elim_cohom_ab_to_1_mcop = Opposite( lambda_elim_1_to_hom_ba_mc );
true
gap> colambda_elim_cohom_ba_to_1_mcop = Opposite( lambda_elim_1_to_hom_ab_mc );
true
gap> colambda_elim_cohom_cd_to_1_mcop = Opposite( lambda_elim_1_to_hom_dc_mc );
true
gap> colambda_elim_cohom_dc_to_1_mcop = Opposite( lambda_elim_1_to_hom_cd_mc );
true

gap> lambda_intro_a_to_b_mcop = Opposite( colambda_intro_a_to_b_mc );
false
gap> lambda_intro_a_to_b_mcop = Opposite( colambda_intro_c_to_d_mc );
false
gap> lambda_intro_a_to_b_mcop = Opposite( colambda_intro_d_to_c_mc );
false

gap> lambda_elim_1_to_hom_ba_mcop = Opposite( colambda_elim_cohom_ba_to_1_mc );
false
gap> lambda_elim_1_to_hom_ba_mcop = Opposite( colambda_elim_cohom_cd_to_1_mc );
false
gap> lambda_elim_1_to_hom_ba_mcop = Opposite( colambda_elim_cohom_dc_to_1_mc );
false

gap> colambda_intro_c_to_d_mcop = Opposite( lambda_intro_c_to_d_mc );
false
gap> colambda_intro_c_to_d_mcop = Opposite( lambda_intro_a_to_b_mc );
false
gap> colambda_intro_c_to_d_mcop = Opposite( lambda_intro_b_to_a_mc );
false

gap> colambda_elim_cohom_dc_to_1_mcop = Opposite( lambda_elim_1_to_hom_dc_mc );
false
gap> colambda_elim_cohom_dc_to_1_mcop = Opposite( lambda_elim_1_to_hom_ab_mc );
false
gap> colambda_elim_cohom_dc_to_1_mcop = Opposite( lambda_elim_1_to_hom_ba_mc );
false

#########################################################
# Isomorphisms between object and internal hom
#########################################################

# Isomorphism from object to internal hom

gap> isomorphism_from_a_to_hom_mc := IsomorphismFromObjectToInternalCoHom( a_mc );;
gap> isomorphism_from_b_to_hom_mc := IsomorphismFromObjectToInternalCoHom( b_mc );;
gap> isomorphism_from_c_to_hom_mc := IsomorphismFromObjectToInternalCoHom( c_mc );;
gap> isomorphism_from_d_to_hom_mc := IsomorphismFromObjectToInternalCoHom( d_mc );;
gap> isomorphism_from_0_to_hom_mc := IsomorphismFromObjectToInternalCoHom( 0_mc );;

gap> isomorphism_from_a_to_hom_mcop := IsomorphismFromObjectToInternalCoHom( a_mcop );;
gap> isomorphism_from_b_to_hom_mcop := IsomorphismFromObjectToInternalCoHom( b_mcop );;
gap> isomorphism_from_c_to_hom_mcop := IsomorphismFromObjectToInternalCoHom( c_mcop );;
gap> isomorphism_from_d_to_hom_mcop := IsomorphismFromObjectToInternalCoHom( d_mcop );;
gap> isomorphism_from_0_to_hom_mcop := IsomorphismFromObjectToInternalCoHom( 0_mcop );;

# Isomorphism from internal hom to object

gap> isomorphism_from_hom_to_a_mc := IsomorphismFromInternalHomToObject( a_mc );;
gap> isomorphism_from_hom_to_b_mc := IsomorphismFromInternalHomToObject( b_mc );;
gap> isomorphism_from_hom_to_c_mc := IsomorphismFromInternalHomToObject( c_mc );;
gap> isomorphism_from_hom_to_d_mc := IsomorphismFromInternalHomToObject( d_mc );;
gap> isomorphism_from_hom_to_0_mc := IsomorphismFromInternalHomToObject( 0_mc );;

gap> isomorphism_from_hom_to_a_mcop := IsomorphismFromInternalHomToObject( a_mcop );;
gap> isomorphism_from_hom_to_b_mcop := IsomorphismFromInternalHomToObject( b_mcop );;
gap> isomorphism_from_hom_to_c_mcop := IsomorphismFromInternalHomToObject( c_mcop );;
gap> isomorphism_from_hom_to_d_mcop := IsomorphismFromInternalHomToObject( d_mcop );;
gap> isomorphism_from_hom_to_0_mcop := IsomorphismFromInternalHomToObject( 0_mcop );;

# Isomorphism from object to internal cohom

gap> isomorphism_from_a_to_cohom_mc := IsomorphismFromObjectToInternalCoHom( a_mc );;
gap> isomorphism_from_b_to_cohom_mc := IsomorphismFromObjectToInternalCoHom( b_mc );;
gap> isomorphism_from_c_to_cohom_mc := IsomorphismFromObjectToInternalCoHom( c_mc );;
gap> isomorphism_from_d_to_cohom_mc := IsomorphismFromObjectToInternalCoHom( d_mc );;
gap> isomorphism_from_0_to_cohom_mc := IsomorphismFromObjectToInternalCoHom( 0_mc );;

gap> isomorphism_from_a_to_cohom_mcop := IsomorphismFromObjectToInternalCoHom( a_mcop );;
gap> isomorphism_from_b_to_cohom_mcop := IsomorphismFromObjectToInternalCoHom( b_mcop );;
gap> isomorphism_from_c_to_cohom_mcop := IsomorphismFromObjectToInternalCoHom( c_mcop );;
gap> isomorphism_from_d_to_cohom_mcop := IsomorphismFromObjectToInternalCoHom( d_mcop );;
gap> isomorphism_from_0_to_cohom_mcop := IsomorphismFromObjectToInternalCoHom( 0_mcop );;

# Isomorphism from internal cohom to object

gap> isomorphism_from_cohom_to_a_mc := IsomorphismFromInternalCoHomToObject( a_mc );;
gap> isomorphism_from_cohom_to_b_mc := IsomorphismFromInternalCoHomToObject( b_mc );;
gap> isomorphism_from_cohom_to_c_mc := IsomorphismFromInternalCoHomToObject( c_mc );;
gap> isomorphism_from_cohom_to_d_mc := IsomorphismFromInternalCoHomToObject( d_mc );;
gap> isomorphism_from_cohom_to_0_mc := IsomorphismFromInternalCoHomToObject( 0_mc );;

gap> isomorphism_from_cohom_to_a_mcop := IsomorphismFromInternalCoHomToObject( a_mcop );;
gap> isomorphism_from_cohom_to_b_mcop := IsomorphismFromInternalCoHomToObject( b_mcop );;
gap> isomorphism_from_cohom_to_c_mcop := IsomorphismFromInternalCoHomToObject( c_mcop) ;;
gap> isomorphism_from_cohom_to_d_mcop := IsomorphismFromInternalCoHomToObject( d_mcop );;
gap> isomorphism_from_cohom_to_0_mcop := IsomorphismFromInternalCoHomToObject( 0_mcop );;

# Opposite correspondence

gap> isomorphism_from_a_to_hom_mcop = Opposite( isomorphism_from_cohom_to_a_mc );
true
gap> isomorphism_from_b_to_hom_mcop = Opposite( isomorphism_from_cohom_to_b_mc );
true
gap> isomorphism_from_c_to_hom_mcop = Opposite( isomorphism_from_cohom_to_c_mc );
true
gap> isomorphism_from_d_to_hom_mcop = Opposite( isomorphism_from_cohom_to_d_mc );
true
gap> isomorphism_from_0_to_hom_mcop = Opposite( isomorphism_from_cohom_to_0_mc );
true

gap> isomorphism_from_hom_to_a_mcop = Opposite( isomorphism_from_a_to_cohom_mc );
true
gap> isomorphism_from_hom_to_b_mcop = Opposite( isomorphism_from_b_to_cohom_mc );
true
gap> isomorphism_from_hom_to_c_mcop = Opposite( isomorphism_from_c_to_cohom_mc );
true
gap> isomorphism_from_hom_to_d_mcop = Opposite( isomorphism_from_d_to_cohom_mc );
true
gap> isomorphism_from_hom_to_0_mcop = Opposite( isomorphism_from_0_to_cohom_mc );
true

gap> isomorphism_from_a_to_cohom_mcop = Opposite( isomorphism_from_hom_to_a_mc );
true
gap> isomorphism_from_b_to_cohom_mcop = Opposite( isomorphism_from_hom_to_b_mc );
true
gap> isomorphism_from_c_to_cohom_mcop = Opposite( isomorphism_from_hom_to_c_mc );
true
gap> isomorphism_from_d_to_cohom_mcop = Opposite( isomorphism_from_hom_to_d_mc );
true
gap> isomorphism_from_0_to_cohom_mcop = Opposite( isomorphism_from_hom_to_0_mc );
true

gap> isomorphism_from_cohom_to_a_mcop = Opposite( isomorphism_from_a_to_hom_mc );
true
gap> isomorphism_from_cohom_to_b_mcop = Opposite( isomorphism_from_b_to_hom_mc );
true
gap> isomorphism_from_cohom_to_c_mcop = Opposite( isomorphism_from_c_to_hom_mc );
true
gap> isomorphism_from_cohom_to_d_mcop = Opposite( isomorphism_from_d_to_hom_mc );
true
gap> isomorphism_from_cohom_to_0_mcop = Opposite( isomorphism_from_0_to_hom_mc );
true

gap> isomorphism_from_a_to_hom_mcop = Opposite( isomorphism_from_cohom_to_b_mc );
false
gap> isomorphism_from_a_to_hom_mcop = Opposite( isomorphism_from_cohom_to_c_mc );
false
gap> isomorphism_from_a_to_hom_mcop = Opposite( isomorphism_from_cohom_to_d_mc );
false
gap> isomorphism_from_a_to_hom_mcop = Opposite( isomorphism_from_cohom_to_0_mc );
false

gap> isomorphism_from_hom_to_b_mcop = Opposite( isomorphism_from_a_to_cohom_mc );
false
gap> isomorphism_from_hom_to_b_mcop = Opposite( isomorphism_from_c_to_cohom_mc );
false
gap> isomorphism_from_hom_to_b_mcop = Opposite( isomorphism_from_d_to_cohom_mc );
false
gap> isomorphism_from_hom_to_b_mcop = Opposite( isomorphism_from_0_to_cohom_mc );
false

gap> isomorphism_from_c_to_cohom_mcop = Opposite( isomorphism_from_hom_to_a_mc );
false
gap> isomorphism_from_c_to_cohom_mcop = Opposite( isomorphism_from_hom_to_b_mc );
false
gap> isomorphism_from_c_to_cohom_mcop = Opposite( isomorphism_from_hom_to_d_mc );
false
gap> isomorphism_from_c_to_cohom_mcop = Opposite( isomorphism_from_hom_to_0_mc );
false

gap> isomorphism_from_cohom_to_d_mcop = Opposite( isomorphism_from_a_to_hom_mc );
false
gap> isomorphism_from_cohom_to_d_mcop = Opposite( isomorphism_from_b_to_hom_mc );
false
gap> isomorphism_from_cohom_to_d_mcop = Opposite( isomorphism_from_c_to_hom_mc );
false
gap> isomorphism_from_cohom_to_d_mcop = Opposite( isomorphism_from_0_to_hom_mc );
false

# ------------------------------------------------------------------------ Rigid structure ----------------------------------------------------------------------

#######################################################################
# Isomorphisms between internal (co)homs and tensor products
#######################################################################

# Isomorphism from tensor product to internal hom

gap> isomorphism_from_tensor_to_hom_ab_mc := IsomorphismFromTensorProductToInternalHom( a_mc, b_mc );;
gap> isomorphism_from_tensor_to_hom_ba_mc := IsomorphismFromTensorProductToInternalHom( b_mc, a_mc );;
gap> isomorphism_from_tensor_to_hom_cd_mc := IsomorphismFromTensorProductToInternalHom( c_mc, d_mc );;
gap> isomorphism_from_tensor_to_hom_dc_mc := IsomorphismFromTensorProductToInternalHom( d_mc, c_mc );;

gap> isomorphism_from_tensor_to_hom_ab_mcop := IsomorphismFromTensorProductToInternalHom( a_mcop, b_mcop );;
gap> isomorphism_from_tensor_to_hom_ba_mcop := IsomorphismFromTensorProductToInternalHom( b_mcop, a_mcop );;
gap> isomorphism_from_tensor_to_hom_cd_mcop := IsomorphismFromTensorProductToInternalHom( c_mcop, d_mcop );;
gap> isomorphism_from_tensor_to_hom_dc_mcop := IsomorphismFromTensorProductToInternalHom( d_mcop, c_mcop );;

# isomorphism from tensor product to internal cohom

gap> isomorphism_from_tensor_to_cohom_ab_mc := IsomorphismFromTensorProductToInternalCoHom( a_mc, b_mc );;
gap> isomorphism_from_tensor_to_cohom_ba_mc := IsomorphismFromTensorProductToInternalCoHom( b_mc, a_mc );;
gap> isomorphism_from_tensor_to_cohom_cd_mc := IsomorphismFromTensorProductToInternalCoHom( c_mc, d_mc );;
gap> isomorphism_from_tensor_to_cohom_dc_mc := IsomorphismFromTensorProductToInternalCoHom( d_mc, c_mc );;

gap> isomorphism_from_tensor_to_cohom_ab_mcop := IsomorphismFromTensorProductToInternalCoHom( a_mcop, b_mcop );;
gap> isomorphism_from_tensor_to_cohom_ba_mcop := IsomorphismFromTensorProductToInternalCoHom( b_mcop, a_mcop );;
gap> isomorphism_from_tensor_to_cohom_cd_mcop := IsomorphismFromTensorProductToInternalCoHom( c_mcop, d_mcop );;
gap> isomorphism_from_tensor_to_cohom_dc_mcop := IsomorphismFromTensorProductToInternalCoHom( d_mcop, c_mcop );;

# Isomorphism from internal hom to tensor product

gap> isomorphism_from_hom_to_tensor_ab_mc := IsomorphismFromInternalHomToTensorProduct( a_mc, b_mc );;
gap> isomorphism_from_hom_to_tensor_ba_mc := IsomorphismFromInternalHomToTensorProduct( b_mc, a_mc );;
gap> isomorphism_from_hom_to_tensor_cd_mc := IsomorphismFromInternalHomToTensorProduct( c_mc, d_mc );;
gap> isomorphism_from_hom_to_tensor_dc_mc := IsomorphismFromInternalHomToTensorProduct( d_mc, c_mc );;

gap> isomorphism_from_hom_to_tensor_ab_mcop := IsomorphismFromInternalHomToTensorProduct( a_mcop, b_mcop );;
gap> isomorphism_from_hom_to_tensor_ba_mcop := IsomorphismFromInternalHomToTensorProduct( b_mcop, a_mcop );;
gap> isomorphism_from_hom_to_tensor_cd_mcop := IsomorphismFromInternalHomToTensorProduct( c_mcop, d_mcop );;
gap> isomorphism_from_hom_to_tensor_dc_mcop := IsomorphismFromInternalHomToTensorProduct( d_mcop, c_mcop );;

# Isomorphism from internal cohom to tensor product

gap> isomorphism_from_cohom_to_tensor_ab_mc := IsomorphismFromInternalCoHomToTensorProduct( a_mc, b_mc );;
gap> isomorphism_from_cohom_to_tensor_ba_mc := IsomorphismFromInternalCoHomToTensorProduct( b_mc, a_mc );;
gap> isomorphism_from_cohom_to_tensor_cd_mc := IsomorphismFromInternalCoHomToTensorProduct( c_mc, d_mc );;
gap> isomorphism_from_cohom_to_tensor_dc_mc := IsomorphismFromInternalCoHomToTensorProduct( d_mc, c_mc );;

gap> isomorphism_from_cohom_to_tensor_ab_mcop := IsomorphismFromInternalCoHomToTensorProduct( a_mcop, b_mcop );;
gap> isomorphism_from_cohom_to_tensor_ba_mcop := IsomorphismFromInternalCoHomToTensorProduct( b_mcop, a_mcop );;
gap> isomorphism_from_cohom_to_tensor_cd_mcop := IsomorphismFromInternalCoHomToTensorProduct( c_mcop, d_mcop );;
gap> isomorphism_from_cohom_to_tensor_dc_mcop := IsomorphismFromInternalCoHomToTensorProduct( d_mcop, c_mcop );;

# Opposite correspondence

gap> isomorphism_from_tensor_to_hom_ab_mcop = Opposite( isomorphism_from_cohom_to_tensor_ba_mc );
true
gap> isomorphism_from_tensor_to_hom_ba_mcop = Opposite( isomorphism_from_cohom_to_tensor_ab_mc );
true
gap> isomorphism_from_tensor_to_hom_cd_mcop = Opposite( isomorphism_from_cohom_to_tensor_dc_mc );
true
gap> isomorphism_from_tensor_to_hom_dc_mcop = Opposite( isomorphism_from_cohom_to_tensor_cd_mc );
true

gap> isomorphism_from_tensor_to_cohom_ab_mcop = Opposite( isomorphism_from_hom_to_tensor_ab_mc );
true
gap> isomorphism_from_tensor_to_cohom_ba_mcop = Opposite( isomorphism_from_hom_to_tensor_ba_mc );
true
gap> isomorphism_from_tensor_to_cohom_cd_mcop = Opposite( isomorphism_from_hom_to_tensor_cd_mc );
true
gap> isomorphism_from_tensor_to_cohom_dc_mcop = Opposite( isomorphism_from_hom_to_tensor_dc_mc );
true

gap> isomorphism_from_hom_to_tensor_ab_mcop = Opposite( isomorphism_from_tensor_to_cohom_ab_mc );
true
gap> isomorphism_from_hom_to_tensor_ba_mcop = Opposite( isomorphism_from_tensor_to_cohom_ba_mc );
true
gap> isomorphism_from_hom_to_tensor_cd_mcop = Opposite( isomorphism_from_tensor_to_cohom_cd_mc );
true
gap> isomorphism_from_hom_to_tensor_dc_mcop = Opposite( isomorphism_from_tensor_to_cohom_dc_mc );
true

gap> isomorphism_from_cohom_to_tensor_ab_mcop = Opposite( isomorphism_from_tensor_to_hom_ba_mc );
true
gap> isomorphism_from_cohom_to_tensor_ba_mcop = Opposite( isomorphism_from_tensor_to_hom_ab_mc );
true
gap> isomorphism_from_cohom_to_tensor_cd_mcop = Opposite( isomorphism_from_tensor_to_hom_dc_mc );
true
gap> isomorphism_from_cohom_to_tensor_dc_mcop = Opposite( isomorphism_from_tensor_to_hom_cd_mc );
true

gap> isomorphism_from_tensor_to_hom_dc_mcop = Opposite( isomorphism_from_cohom_to_tensor_ab_mc );
false
gap> isomorphism_from_tensor_to_hom_dc_mcop = Opposite( isomorphism_from_cohom_to_tensor_ba_mc );
false

gap> isomorphism_from_tensor_to_cohom_cd_mcop = Opposite( isomorphism_from_hom_to_tensor_ab_mc );
false
gap> isomorphism_from_tensor_to_cohom_cd_mcop = Opposite( isomorphism_from_hom_to_tensor_ba_mc );
false

gap> isomorphism_from_hom_to_tensor_ba_mcop = Opposite( isomorphism_from_tensor_to_cohom_cd_mc );
false
gap> isomorphism_from_hom_to_tensor_ba_mcop = Opposite( isomorphism_from_tensor_to_cohom_dc_mc );
false

gap> isomorphism_from_tensor_to_hom_ab_mcop = Opposite( isomorphism_from_cohom_to_tensor_cd_mc );
false
gap> isomorphism_from_tensor_to_hom_ab_mcop = Opposite( isomorphism_from_cohom_to_tensor_dc_mc );
false

###################################################################################
# Morphism from internal hom to tensor product / tensor product to cohom
###################################################################################

# Morphism from internal hom to tensor product

gap> morphism_from_hom_to_tensor_product_ab_mc := MorphismFromInternalHomToTensorProduct( a_mc, b_mc );;
gap> morphism_from_hom_to_tensor_product_ba_mc := MorphismFromInternalHomToTensorProduct( b_mc, a_mc );;
gap> morphism_from_hom_to_tensor_product_cd_mc := MorphismFromInternalHomToTensorProduct( c_mc, d_mc );;
gap> morphism_from_hom_to_tensor_product_dc_mc := MorphismFromInternalHomToTensorProduct( d_mc, c_mc );;

gap> morphism_from_hom_to_tensor_product_ab_mcop := MorphismFromInternalHomToTensorProduct( a_mcop, b_mcop );;
gap> morphism_from_hom_to_tensor_product_ba_mcop := MorphismFromInternalHomToTensorProduct( b_mcop, a_mcop );;
gap> morphism_from_hom_to_tensor_product_cd_mcop := MorphismFromInternalHomToTensorProduct( c_mcop, d_mcop );;
gap> morphism_from_hom_to_tensor_product_dc_mcop := MorphismFromInternalHomToTensorProduct( d_mcop, c_mcop );;

# Morphism from tensor product to internal cohom

gap> morphism_from_tensor_product_to_cohom_ab_mc := MorphismFromTensorProductToInternalCoHom( a_mc, b_mc );;
gap> morphism_from_tensor_product_to_cohom_ba_mc := MorphismFromTensorProductToInternalCoHom( b_mc, a_mc );;
gap> morphism_from_tensor_product_to_cohom_cd_mc := MorphismFromTensorProductToInternalCoHom( c_mc, d_mc );;
gap> morphism_from_tensor_product_to_cohom_dc_mc := MorphismFromTensorProductToInternalCoHom( d_mc, c_mc );;

gap> morphism_from_tensor_product_to_cohom_ab_mcop := MorphismFromTensorProductToInternalCoHom( a_mcop, b_mcop );;
gap> morphism_from_tensor_product_to_cohom_ba_mcop := MorphismFromTensorProductToInternalCoHom( b_mcop, a_mcop );;
gap> morphism_from_tensor_product_to_cohom_cd_mcop := MorphismFromTensorProductToInternalCoHom( c_mcop, d_mcop );;
gap> morphism_from_tensor_product_to_cohom_dc_mcop := MorphismFromTensorProductToInternalCoHom( d_mcop, c_mcop );;

# Opposite correspondence

gap> morphism_from_hom_to_tensor_product_ab_mcop = Opposite( morphism_from_tensor_product_to_cohom_ab_mc );
true
gap> morphism_from_hom_to_tensor_product_ba_mcop = Opposite( morphism_from_tensor_product_to_cohom_ba_mc );
true
gap> morphism_from_hom_to_tensor_product_cd_mcop = Opposite( morphism_from_tensor_product_to_cohom_cd_mc );
true
gap> morphism_from_hom_to_tensor_product_dc_mcop = Opposite( morphism_from_tensor_product_to_cohom_dc_mc );
true

gap> morphism_from_tensor_product_to_cohom_ab_mcop = Opposite( morphism_from_hom_to_tensor_product_ab_mc );
true
gap> morphism_from_tensor_product_to_cohom_ba_mcop = Opposite( morphism_from_hom_to_tensor_product_ba_mc );
true
gap> morphism_from_tensor_product_to_cohom_cd_mcop = Opposite( morphism_from_hom_to_tensor_product_cd_mc );
true
gap> morphism_from_tensor_product_to_cohom_dc_mcop = Opposite( morphism_from_hom_to_tensor_product_dc_mc );
true

gap> morphism_from_hom_to_tensor_product_ab_mcop = Opposite( morphism_from_tensor_product_to_cohom_cd_mc );
false
gap> morphism_from_hom_to_tensor_product_ab_mcop = Opposite( morphism_from_tensor_product_to_cohom_dc_mc );
false

gap> morphism_from_hom_to_tensor_product_cd_mcop = Opposite( morphism_from_tensor_product_to_cohom_ab_mc );
false
gap> morphism_from_hom_to_tensor_product_cd_mcop = Opposite( morphism_from_tensor_product_to_cohom_ba_mc );
false

gap> morphism_from_tensor_product_to_cohom_ba_mcop = Opposite( morphism_from_hom_to_tensor_product_cd_mc );
false
gap> morphism_from_tensor_product_to_cohom_ba_mcop = Opposite( morphism_from_hom_to_tensor_product_dc_mc );
false

gap> morphism_from_tensor_product_to_cohom_dc_mcop = Opposite( morphism_from_hom_to_tensor_product_ab_mc );
false
gap> morphism_from_tensor_product_to_cohom_dc_mcop = Opposite( morphism_from_hom_to_tensor_product_ba_mc );
false

######################################################################
# Inverse tensor product and internal (co)hom compatibility
######################################################################

gap> tensor_to_hom_compatibility_inverse_abcd_mc := TensorProductInternalHomCompatibilityMorphismInverse( [ a_mc, b_mc, c_mc, d_mc ] );; # Hom( a x c, b x d ) -> Hom( a, b ) x Hom( c, d )
gap> tensor_to_hom_compatibility_inverse_cadb_mc := TensorProductInternalHomCompatibilityMorphismInverse( [ c_mc, a_mc, d_mc, b_mc ] );; # Hom( c x d, a x b ) -> Hom( c, a ) x Hom( d, b )

gap> cohom_to_tensor_compatibility_inverse_abcd_mc := InternalCoHomTensorProductCompatibilityMorphismInverse( [ a_mc, b_mc, c_mc, d_mc ] );; # Cohom( a, c ) x Cohom( b, d ) -> Cohom( a x b, c x d )
gap> cohom_to_tensor_compatibility_inverse_bdac_mc := InternalCoHomTensorProductCompatibilityMorphismInverse( [ b_mc, d_mc, a_mc, c_mc ] );; # Cohom( b, a ) x Cohom( d, c ) -> Cohom( b x d, a x c )

gap> tensor_to_hom_compatibility_inverse_abcd_mcop := TensorProductInternalHomCompatibilityMorphismInverse( [ a_mcop, b_mcop, c_mcop, d_mcop ] );; # Hom( a x c, b x d ) -> Hom( a, b ) x Hom( c, d )
gap> tensor_to_hom_compatibility_inverse_cadb_mcop := TensorProductInternalHomCompatibilityMorphismInverse( [ c_mcop, a_mcop, d_mcop, b_mcop ] );; # Hom( c x d, a x b ) -> Hom( c, a ) x Hom( d, b )

gap> cohom_to_tensor_compatibility_inverse_abcd_mcop := InternalCoHomTensorProductCompatibilityMorphismInverse( [ a_mcop, b_mcop, c_mcop, d_mcop ] );; # Cohom( a, c ) x Cohom( b, d ) -> Cohom( a x b, c x d )
gap> cohom_to_tensor_compatibility_inverse_bdac_mcop := InternalCoHomTensorProductCompatibilityMorphismInverse( [ b_mcop, d_mcop, a_mcop, c_mcop ] );; # Cohom( b, a ) x Cohom( d, c ) -> Cohom( b x d, a x c )

# Opposite correspondence

gap> tensor_to_hom_compatibility_inverse_abcd_mcop = Opposite( cohom_to_tensor_compatibility_inverse_bdac_mc ); # Hom( a x c, b x d ) -> Hom( a, b ) x Hom( c, d )  ==  op( Cohom( b, a ) x Cohom( d, c ) -> Cohom( b x d, a x c ) )
true
gap> tensor_to_hom_compatibility_inverse_cadb_mcop = Opposite( cohom_to_tensor_compatibility_inverse_abcd_mc ); # Hom( c x d, a x b ) -> Hom( c, a ) x Hom( d, b )  ==  op( Cohom( a, c ) x Cohom( b, d ) -> Cohom( a x b, c x d ) )
true

gap> cohom_to_tensor_compatibility_inverse_abcd_mcop = Opposite( tensor_to_hom_compatibility_inverse_cadb_mc ); # Cohom( a, c ) x Cohom( b, d ) -> Cohom( a x b, c x d )  ==  op( Hom( c x d, a x b ) -> Hom( c, a ) x Hom( d, b ) )
true
gap> cohom_to_tensor_compatibility_inverse_bdac_mcop = Opposite( tensor_to_hom_compatibility_inverse_abcd_mc ); # Cohom( b, a ) x Cohom( d, c ) -> Cohom( b x d, a x c )  ==  op( Hom( a x c, b x d ) -> Hom( a, b ) x Hom( c, d ) )
true

gap> tensor_to_hom_compatibility_inverse_abcd_mcop = Opposite( cohom_to_tensor_compatibility_inverse_abcd_mc ); # Hom( a x c, b x d ) -> Hom( a, b ) x Hom( c, d )  =/=  op( Cohom( a, c ) x Cohom( b, d ) -> Cohom( a x b, c x d ) )
false
gap> tensor_to_hom_compatibility_inverse_cadb_mcop = Opposite( cohom_to_tensor_compatibility_inverse_bdac_mc ); # Hom( c x d, a x b ) -> Hom( c, a ) x Hom( d, b )  =/=  op( Cohom( b, a ) x Cohom( d, c ) -> Cohom( b x d, a x c ) )
false

gap> cohom_to_tensor_compatibility_inverse_abcd_mcop = Opposite( tensor_to_hom_compatibility_inverse_abcd_mc ); # Cohom( a, c ) x Cohom( b, d ) -> Cohom( a x b, c x d )  =/=  op( Hom( a x c, b x d ) -> Hom( a, b ) x Hom( c, d ) )
false
gap> cohom_to_tensor_compatibility_inverse_bdac_mcop = Opposite( tensor_to_hom_compatibility_inverse_cadb_mc ); # Cohom( b, a ) x Cohom( d, c ) -> Cohom( b x d, a x c )  =/=  op( Hom( c x d, a x b ) -> Hom( c, a ) x Hom( d, b ) )
false

#######################################################################
# Coevaluation for (co)dual
#######################################################################

gap> coev_for_dual_a_mc := CoevaluationForDual( a_mc );;
gap> coev_for_dual_b_mc := CoevaluationForDual( b_mc );;
gap> coev_for_dual_0_mc := CoevaluationForDual( 0_mc );;

gap> cocl_coev_for_codual_a_mc := CoclosedCoevaluationForCoDual( a_mc );;
gap> cocl_coev_for_codual_b_mc := CoclosedCoevaluationForCoDual( b_mc );;
gap> cocl_coev_for_codual_0_mc := CoclosedCoevaluationForCoDual( 0_mc );;

gap> coev_for_dual_a_mcop := CoevaluationForDual( a_mcop );;
gap> coev_for_dual_b_mcop := CoevaluationForDual( b_mcop );;
gap> coev_for_dual_0_mcop := CoevaluationForDual( 0_mcop );;

gap> cocl_coev_for_codual_a_mcop := CoclosedCoevaluationForCoDual( a_mcop );;
gap> cocl_coev_for_codual_b_mcop := CoclosedCoevaluationForCoDual( b_mcop );;
gap> cocl_coev_for_codual_0_mcop := CoclosedCoevaluationForCoDual( 0_mcop );;

# Opposite correspondence

gap> coev_for_dual_a_mcop = Opposite( cocl_coev_for_codual_a_mc );
true
gap> coev_for_dual_b_mcop = Opposite( cocl_coev_for_codual_b_mc );
true
gap> coev_for_dual_0_mcop = Opposite( cocl_coev_for_codual_0_mc );
true

gap> cocl_coev_for_codual_a_mcop = Opposite( coev_for_dual_a_mc );
true
gap> cocl_coev_for_codual_b_mcop = Opposite( coev_for_dual_b_mc );
true
gap> cocl_coev_for_codual_0_mcop = Opposite( coev_for_dual_0_mc );
true

gap> coev_for_dual_a_mcop = Opposite( cocl_coev_for_codual_b_mc );
false
gap> coev_for_dual_b_mcop = Opposite( cocl_coev_for_codual_a_mc );
false
gap> coev_for_dual_0_mcop = Opposite( cocl_coev_for_codual_a_mc );
false

gap> cocl_coev_for_codual_a_mcop = Opposite( coev_for_dual_b_mc );
false
gap> cocl_coev_for_codual_b_mcop = Opposite( coev_for_dual_a_mc );
false
gap> cocl_coev_for_codual_0_mcop = Opposite( coev_for_dual_a_mc );
false

#######################################################################
# (Co)Trace
#######################################################################

# Trace on matrix category 

gap> trace_id_0_tensor_a_mc := TraceMap( id_0_tensor_a_mc );;
gap> trace_id_a_tensor_0_mc := TraceMap( id_a_tensor_0_mc );;

gap> trace_id_a_tensor_b_mc := TraceMap( id_a_tensor_b_mc );;
gap> trace_id_b_tensor_a_mc := TraceMap( id_b_tensor_a_mc );;
gap> trace_id_c_tensor_d_mc := TraceMap( id_c_tensor_d_mc );;
gap> trace_id_d_tensor_c_mc := TraceMap( id_d_tensor_c_mc );;

gap> trace_id_hom_0a_mc := TraceMap( id_hom_0a_mc );;
gap> trace_id_hom_a0_mc := TraceMap( id_hom_a0_mc );;

gap> trace_id_hom_ab_mc := TraceMap( id_hom_ab_mc );;
gap> trace_id_hom_ba_mc := TraceMap( id_hom_ba_mc );;
gap> trace_id_hom_cd_mc := TraceMap( id_hom_cd_mc );;
gap> trace_id_hom_dc_mc := TraceMap( id_hom_dc_mc );;

# Trace on opposite 

gap> trace_id_0_tensor_a_mcop := TraceMap( id_0_tensor_a_mcop );;
gap> trace_id_a_tensor_0_mcop := TraceMap( id_a_tensor_0_mcop );;

gap> trace_id_a_tensor_b_mcop := TraceMap( id_a_tensor_b_mcop );;
gap> trace_id_b_tensor_a_mcop := TraceMap( id_b_tensor_a_mcop );;
gap> trace_id_c_tensor_d_mcop := TraceMap( id_c_tensor_d_mcop );;
gap> trace_id_d_tensor_c_mcop := TraceMap( id_d_tensor_c_mcop );;

gap> trace_id_hom_0a_mcop := TraceMap( id_hom_0a_mcop );;
gap> trace_id_hom_a0_mcop := TraceMap( id_hom_a0_mcop );;

gap> trace_id_hom_ab_mcop := TraceMap( id_hom_ab_mcop );;
gap> trace_id_hom_ba_mcop := TraceMap( id_hom_ba_mcop );;
gap> trace_id_hom_cd_mcop := TraceMap( id_hom_cd_mcop );;
gap> trace_id_hom_dc_mcop := TraceMap( id_hom_dc_mcop );;

# Cotrace on matrix category 

gap> cotrace_id_0_tensor_a_mc := CoTraceMap( id_0_tensor_a_mc );;
gap> cotrace_id_a_tensor_0_mc := CoTraceMap( id_a_tensor_0_mc );;

gap> cotrace_id_a_tensor_b_mc := CoTraceMap( id_a_tensor_b_mc );;
gap> cotrace_id_b_tensor_a_mc := CoTraceMap( id_b_tensor_a_mc );;
gap> cotrace_id_c_tensor_d_mc := CoTraceMap( id_c_tensor_d_mc );;
gap> cotrace_id_d_tensor_c_mc := CoTraceMap( id_d_tensor_c_mc );;

gap> cotrace_id_hom_0a_mc := CoTraceMap( id_hom_0a_mc );;
gap> cotrace_id_hom_a0_mc := CoTraceMap( id_hom_a0_mc );;

gap> cotrace_id_hom_ab_mc := CoTraceMap( id_hom_ab_mc );;
gap> cotrace_id_hom_ba_mc := CoTraceMap( id_hom_ba_mc );;
gap> cotrace_id_hom_cd_mc := CoTraceMap( id_hom_cd_mc );;
gap> cotrace_id_hom_dc_mc := CoTraceMap( id_hom_dc_mc );;

# Cotrace on opposite 

gap> cotrace_id_0_tensor_a_mcop := CoTraceMap( id_0_tensor_a_mcop );;
gap> cotrace_id_a_tensor_0_mcop := CoTraceMap( id_a_tensor_0_mcop );;

gap> cotrace_id_a_tensor_b_mcop := CoTraceMap( id_a_tensor_b_mcop );;
gap> cotrace_id_b_tensor_a_mcop := CoTraceMap( id_b_tensor_a_mcop );;
gap> cotrace_id_c_tensor_d_mcop := CoTraceMap( id_c_tensor_d_mcop );;
gap> cotrace_id_d_tensor_c_mcop := CoTraceMap( id_d_tensor_c_mcop );;

gap> cotrace_id_hom_0a_mcop := CoTraceMap( id_hom_0a_mcop );;
gap> cotrace_id_hom_a0_mcop := CoTraceMap( id_hom_a0_mcop );;

gap> cotrace_id_hom_ab_mcop := CoTraceMap( id_hom_ab_mcop );;
gap> cotrace_id_hom_ba_mcop := CoTraceMap( id_hom_ba_mcop );;
gap> cotrace_id_hom_cd_mcop := CoTraceMap( id_hom_cd_mcop );;
gap> cotrace_id_hom_dc_mcop := CoTraceMap( id_hom_dc_mcop );;

# Opposite correspondence

gap> trace_id_0_tensor_a_mcop = Opposite( cotrace_id_0_tensor_a_mc );
true
gap> trace_id_a_tensor_0_mcop = Opposite( cotrace_id_a_tensor_0_mc );
true

gap> trace_id_a_tensor_b_mcop = Opposite( cotrace_id_a_tensor_b_mc );
true
gap> trace_id_b_tensor_a_mcop = Opposite( cotrace_id_b_tensor_a_mc );
true
gap> trace_id_c_tensor_d_mcop = Opposite( cotrace_id_c_tensor_d_mc );
true
gap> trace_id_d_tensor_c_mcop = Opposite( cotrace_id_d_tensor_c_mc );
true

gap> trace_id_hom_0a_mcop = Opposite( cotrace_id_hom_0a_mc );
true
gap> trace_id_hom_a0_mcop = Opposite( cotrace_id_hom_a0_mc );
true

gap> trace_id_hom_ab_mcop = Opposite( cotrace_id_hom_ab_mc );
true
gap> trace_id_hom_ba_mcop = Opposite( cotrace_id_hom_ba_mc );
true
gap> trace_id_hom_cd_mcop = Opposite( cotrace_id_hom_cd_mc );
true
gap> trace_id_hom_dc_mcop = Opposite( cotrace_id_hom_dc_mc );
true

gap> cotrace_id_0_tensor_a_mcop = Opposite( trace_id_0_tensor_a_mc );
true
gap> cotrace_id_a_tensor_0_mcop = Opposite( trace_id_a_tensor_0_mc );
true

gap> cotrace_id_a_tensor_b_mcop = Opposite( trace_id_a_tensor_b_mc );
true
gap> cotrace_id_b_tensor_a_mcop = Opposite( trace_id_b_tensor_a_mc );
true
gap> cotrace_id_c_tensor_d_mcop = Opposite( trace_id_c_tensor_d_mc );
true
gap> cotrace_id_d_tensor_c_mcop = Opposite( trace_id_d_tensor_c_mc );
true

gap> cotrace_id_hom_0a_mcop = Opposite( trace_id_hom_0a_mc );
true
gap> cotrace_id_hom_a0_mcop = Opposite( trace_id_hom_a0_mc );
true

gap> cotrace_id_hom_ab_mcop = Opposite( trace_id_hom_ab_mc );
true
gap> cotrace_id_hom_ba_mcop = Opposite( trace_id_hom_ba_mc );
true
gap> cotrace_id_hom_cd_mcop = Opposite( trace_id_hom_cd_mc );
true
gap> cotrace_id_hom_dc_mcop = Opposite( trace_id_hom_dc_mc );
true

gap> trace_id_a_tensor_b_mcop = Opposite( cotrace_id_c_tensor_d_mc );
false
gap> trace_id_c_tensor_d_mcop = Opposite( cotrace_id_a_tensor_b_mc );
false

gap> trace_id_hom_ab_mcop = Opposite( cotrace_id_hom_cd_mc );
false
gap> trace_id_hom_dc_mcop = Opposite( cotrace_id_hom_ba_mc );
false

gap> cotrace_id_b_tensor_a_mcop = Opposite( trace_id_d_tensor_c_mc );
false
gap> cotrace_id_d_tensor_c_mcop = Opposite( trace_id_b_tensor_a_mc );
false

gap> cotrace_id_hom_ba_mcop = Opposite( trace_id_hom_dc_mc );
false
gap> cotrace_id_hom_dc_mcop = Opposite( trace_id_hom_ba_mc );
false

#######################################################################
# (Co)RankMorphism
#######################################################################

# Rank morphism on matrix category 

gap> rank_morphism_a_mc := RankMorphism( a_mc );;
gap> rank_morphism_b_mc := RankMorphism( b_mc );;
gap> rank_morphism_c_mc := RankMorphism( c_mc );;
gap> rank_morphism_d_mc := RankMorphism( d_mc );;

gap> rank_morphism_a_tensor_b_mc := RankMorphism( a_tensor_b_mc );;
gap> rank_morphism_b_tensor_a_mc := RankMorphism( b_tensor_a_mc );;
gap> rank_morphism_c_tensor_d_mc := RankMorphism( c_tensor_d_mc );;
gap> rank_morphism_d_tensor_c_mc := RankMorphism( d_tensor_c_mc );;

gap> rank_morphism_a_tensor_0_mc := RankMorphism( a_tensor_0_mc );;
gap> rank_morphism_0_tensor_a_mc := RankMorphism( 0_tensor_a_mc );;

gap> rank_morphism_hom_ab_mc := RankMorphism( hom_ab_mc );;
gap> rank_morphism_hom_ba_mc := RankMorphism( hom_ba_mc );;
gap> rank_morphism_hom_cd_mc := RankMorphism( hom_cd_mc );;
gap> rank_morphism_hom_dc_mc := RankMorphism( hom_dc_mc );;

# Rank morphism on opposite 

gap> rank_morphism_a_mcop := RankMorphism( a_mcop );;
gap> rank_morphism_b_mcop := RankMorphism( b_mcop );;
gap> rank_morphism_c_mcop := RankMorphism( c_mcop );;
gap> rank_morphism_d_mcop := RankMorphism( d_mcop );;

gap> rank_morphism_a_tensor_b_mcop := RankMorphism( a_tensor_b_mcop );;
gap> rank_morphism_b_tensor_a_mcop := RankMorphism( b_tensor_a_mcop );;
gap> rank_morphism_c_tensor_d_mcop := RankMorphism( c_tensor_d_mcop );;
gap> rank_morphism_d_tensor_c_mcop := RankMorphism( d_tensor_c_mcop );;

gap> rank_morphism_a_tensor_0_mcop := RankMorphism( a_tensor_0_mcop );;
gap> rank_morphism_0_tensor_a_mcop := RankMorphism( 0_tensor_a_mcop );;

gap> rank_morphism_hom_ab_mcop := RankMorphism( hom_ab_mcop );;
gap> rank_morphism_hom_ba_mcop := RankMorphism( hom_ba_mcop );;
gap> rank_morphism_hom_cd_mcop := RankMorphism( hom_cd_mcop );;
gap> rank_morphism_hom_dc_mcop := RankMorphism( hom_dc_mcop );;

# Corank morphism on matrix category 

gap> corank_morphism_a_mc := CoRankMorphism( a_mc );;
gap> corank_morphism_b_mc := CoRankMorphism( b_mc );;
gap> corank_morphism_c_mc := CoRankMorphism( c_mc );;
gap> corank_morphism_d_mc := CoRankMorphism( d_mc );;

gap> corank_morphism_a_tensor_b_mc := CoRankMorphism( a_tensor_b_mc );;
gap> corank_morphism_b_tensor_a_mc := CoRankMorphism( b_tensor_a_mc );;
gap> corank_morphism_c_tensor_d_mc := CoRankMorphism( c_tensor_d_mc );;
gap> corank_morphism_d_tensor_c_mc := CoRankMorphism( d_tensor_c_mc );;

gap> corank_morphism_a_tensor_0_mc := CoRankMorphism( a_tensor_0_mc );;
gap> corank_morphism_0_tensor_a_mc := CoRankMorphism( 0_tensor_a_mc );;

gap> corank_morphism_cohom_ab_mc := CoRankMorphism( cohom_ab_mc );;
gap> corank_morphism_cohom_ba_mc := CoRankMorphism( cohom_ba_mc );;
gap> corank_morphism_cohom_cd_mc := CoRankMorphism( cohom_cd_mc );;
gap> corank_morphism_cohom_dc_mc := CoRankMorphism( cohom_dc_mc );;

# Corank morphism on opposite 

gap> corank_morphism_a_mcop := CoRankMorphism( a_mcop );;
gap> corank_morphism_b_mcop := CoRankMorphism( b_mcop );;
gap> corank_morphism_c_mcop := CoRankMorphism( c_mcop );;
gap> corank_morphism_d_mcop := CoRankMorphism( d_mcop );;

gap> corank_morphism_a_tensor_b_mcop := CoRankMorphism( a_tensor_b_mcop );;
gap> corank_morphism_b_tensor_a_mcop := CoRankMorphism( b_tensor_a_mcop );;
gap> corank_morphism_c_tensor_d_mcop := CoRankMorphism( c_tensor_d_mcop );;
gap> corank_morphism_d_tensor_c_mcop := CoRankMorphism( d_tensor_c_mcop );;

gap> corank_morphism_a_tensor_0_mcop := CoRankMorphism( a_tensor_0_mcop );;
gap> corank_morphism_0_tensor_a_mcop := CoRankMorphism( 0_tensor_a_mcop );;

gap> corank_morphism_cohom_ab_mcop := CoRankMorphism( cohom_ab_mcop );;
gap> corank_morphism_cohom_ba_mcop := CoRankMorphism( cohom_ba_mcop );;
gap> corank_morphism_cohom_cd_mcop := CoRankMorphism( cohom_cd_mcop );;
gap> corank_morphism_cohom_dc_mcop := CoRankMorphism( cohom_dc_mcop );;

# Opposite correspondence

gap> rank_morphism_a_mcop = Opposite( corank_morphism_a_mc );
true
gap> rank_morphism_b_mcop = Opposite( corank_morphism_b_mc );
true
gap> rank_morphism_c_mcop = Opposite( corank_morphism_c_mc );
true
gap> rank_morphism_d_mcop = Opposite( corank_morphism_d_mc );
true

gap> rank_morphism_a_tensor_b_mcop = Opposite( corank_morphism_a_tensor_b_mc );
true
gap> rank_morphism_b_tensor_a_mcop = Opposite( corank_morphism_b_tensor_a_mc );
true
gap> rank_morphism_c_tensor_d_mcop = Opposite( corank_morphism_c_tensor_d_mc );
true
gap> rank_morphism_d_tensor_c_mcop = Opposite( corank_morphism_d_tensor_c_mc );
true

gap> rank_morphism_a_tensor_0_mcop = Opposite( corank_morphism_a_tensor_0_mc );
true
gap> rank_morphism_0_tensor_a_mcop = Opposite( corank_morphism_0_tensor_a_mc );
true

gap> rank_morphism_hom_ab_mcop = Opposite( corank_morphism_cohom_ab_mc );
true
gap> rank_morphism_hom_ba_mcop = Opposite( corank_morphism_cohom_ba_mc );
true
gap> rank_morphism_hom_cd_mcop = Opposite( corank_morphism_cohom_cd_mc );
true
gap> rank_morphism_hom_dc_mcop = Opposite( corank_morphism_cohom_dc_mc );
true

gap> corank_morphism_a_mcop = Opposite( rank_morphism_a_mc );
true
gap> corank_morphism_b_mcop = Opposite( rank_morphism_b_mc );
true
gap> corank_morphism_c_mcop = Opposite( rank_morphism_c_mc );
true
gap> corank_morphism_d_mcop = Opposite( rank_morphism_d_mc );
true

gap> corank_morphism_a_tensor_b_mcop = Opposite( rank_morphism_a_tensor_b_mc );
true
gap> corank_morphism_b_tensor_a_mcop = Opposite( rank_morphism_b_tensor_a_mc );
true
gap> corank_morphism_c_tensor_d_mcop = Opposite( rank_morphism_c_tensor_d_mc );
true
gap> corank_morphism_d_tensor_c_mcop = Opposite( rank_morphism_d_tensor_c_mc );
true

gap> corank_morphism_a_tensor_0_mcop = Opposite( rank_morphism_a_tensor_0_mc );
true
gap> corank_morphism_0_tensor_a_mcop = Opposite( rank_morphism_0_tensor_a_mc );
true

gap> corank_morphism_cohom_ab_mcop = Opposite( rank_morphism_hom_ab_mc );
true
gap> corank_morphism_cohom_ba_mcop = Opposite( rank_morphism_hom_ba_mc );
true
gap> corank_morphism_cohom_cd_mcop = Opposite( rank_morphism_hom_cd_mc );
true
gap> corank_morphism_cohom_dc_mcop = Opposite( rank_morphism_hom_dc_mc );
true

gap> rank_morphism_a_mcop = Opposite( corank_morphism_b_mc );
false
gap> rank_morphism_b_mcop = Opposite( corank_morphism_a_mc );
false
gap> rank_morphism_c_mcop = Opposite( corank_morphism_d_mc );
false
gap> rank_morphism_d_mcop = Opposite( corank_morphism_c_mc );
false

gap> rank_morphism_a_tensor_0_mcop = Opposite( corank_morphism_a_tensor_b_mc );
false
gap> rank_morphism_0_tensor_a_mcop = Opposite( corank_morphism_c_tensor_d_mc );
false

gap> corank_morphism_a_mcop = Opposite( rank_morphism_d_mc );
false
gap> corank_morphism_b_mcop = Opposite( rank_morphism_c_mc );
false
gap> corank_morphism_c_mcop = Opposite( rank_morphism_b_mc );
false
gap> corank_morphism_d_mcop = Opposite( rank_morphism_a_mc );
false

gap> corank_morphism_a_tensor_0_mcop = Opposite( rank_morphism_a_tensor_b_mc );
false
gap> corank_morphism_0_tensor_a_mcop = Opposite( rank_morphism_c_tensor_d_mc );
false

gap> corank_morphism_cohom_ab_mcop = Opposite( rank_morphism_hom_cd_mc );
false
gap> corank_morphism_cohom_cd_mcop = Opposite( rank_morphism_hom_ab_mc );
false

#######################################################################
# Morphism from bidual / to cobidual
#######################################################################

# Matrix category

gap> morphism_from_bidual_a_mc := MorphismFromBidual( a_mc );;
gap> morphism_from_bidual_b_mc := MorphismFromBidual( b_mc );;
gap> morphism_from_bidual_c_mc := MorphismFromBidual( c_mc );;
gap> morphism_from_bidual_d_mc := MorphismFromBidual( d_mc );;

gap> morphism_to_cobidual_a_mc := MorphismToCoBidual( a_mc );;
gap> morphism_to_cobidual_b_mc := MorphismToCoBidual( b_mc );;
gap> morphism_to_cobidual_c_mc := MorphismToCoBidual( c_mc );;
gap> morphism_to_cobidual_d_mc := MorphismToCoBidual( d_mc );;

# Opposite

gap> morphism_from_bidual_a_mcop := MorphismFromBidual( a_mcop );;
gap> morphism_from_bidual_b_mcop := MorphismFromBidual( b_mcop );;
gap> morphism_from_bidual_c_mcop := MorphismFromBidual( c_mcop );;
gap> morphism_from_bidual_d_mcop := MorphismFromBidual( d_mcop );;

gap> morphism_to_cobidual_a_mcop := MorphismToCoBidual( a_mcop );;
gap> morphism_to_cobidual_b_mcop := MorphismToCoBidual( b_mcop );;
gap> morphism_to_cobidual_c_mcop := MorphismToCoBidual( c_mcop );;
gap> morphism_to_cobidual_d_mcop := MorphismToCoBidual( d_mcop );;

# Opposite correspondence

gap> morphism_from_bidual_a_mcop = Opposite( morphism_to_cobidual_a_mc );
true
gap> morphism_from_bidual_b_mcop = Opposite( morphism_to_cobidual_b_mc );
true
gap> morphism_from_bidual_c_mcop = Opposite( morphism_to_cobidual_c_mc );
true
gap> morphism_from_bidual_d_mcop = Opposite( morphism_to_cobidual_d_mc );
true

gap> morphism_to_cobidual_a_mcop = Opposite( morphism_from_bidual_a_mc );
true
gap> morphism_to_cobidual_b_mcop = Opposite( morphism_from_bidual_b_mc );
true
gap> morphism_to_cobidual_c_mcop = Opposite( morphism_from_bidual_c_mc );
true
gap> morphism_to_cobidual_d_mcop = Opposite( morphism_from_bidual_d_mc );
true

gap> morphism_from_bidual_a_mcop = Opposite( morphism_to_cobidual_b_mc );
false
gap> morphism_from_bidual_a_mcop = Opposite( morphism_to_cobidual_c_mc );
false
gap> morphism_from_bidual_a_mcop = Opposite( morphism_to_cobidual_d_mc );
false

gap> morphism_to_cobidual_c_mcop = Opposite( morphism_from_bidual_a_mc );
false
gap> morphism_to_cobidual_c_mcop = Opposite( morphism_from_bidual_b_mc );
false
gap> morphism_to_cobidual_c_mcop = Opposite( morphism_from_bidual_d_mc );
false

gap> STOP_TEST("TensorCorrespondenceMatrixCategoryAndOpposite.tst", 1);
