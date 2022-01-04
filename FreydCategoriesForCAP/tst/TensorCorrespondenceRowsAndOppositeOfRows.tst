###################################################################################################
# Test the correspondences of the tensor stuructures between the category of rows and its opposite
###################################################################################################

gap> START_TEST("TensorCorrespondenceRowsAndOppositeOfRows.tst");

gap> LoadPackage( "FreydCategoriesForCAP", false );
true

gap> Q := HomalgFieldOfRationals();;
gap> rows := CategoryOfRows( Q );;
gap> columns := Opposite( rows );;

##############################################################
# Tensor, Hom and Cohom on objects
##############################################################

# Tensor objects and internal (co)homs for rows

gap> a_rows := CategoryOfRowsObject( 2, rows );;
gap> b_rows := CategoryOfRowsObject( 3, rows );;
gap> c_rows := CategoryOfRowsObject( 6, rows );;
gap> d_rows := CategoryOfRowsObject( 4, rows );;

gap> 0_rows := ZeroObject( rows );;
gap> 1_rows := TensorUnit( rows );;

gap> a_tensor_b_rows := TensorProductOnObjects( a_rows, b_rows );;
gap> b_tensor_a_rows := TensorProductOnObjects( b_rows, a_rows );;
gap> c_tensor_d_rows := TensorProductOnObjects( c_rows, d_rows );;
gap> d_tensor_c_rows := TensorProductOnObjects( d_rows, c_rows );;

gap> 0_tensor_a_rows := TensorProductOnObjects( 0_rows, a_rows );;
gap> a_tensor_0_rows := TensorProductOnObjects( a_rows, 0_rows );;

gap> hom_ab_rows := InternalHomOnObjects( a_rows, b_rows );;
gap> hom_ba_rows := InternalHomOnObjects( b_rows, a_rows );;
gap> hom_cd_rows := InternalHomOnObjects( c_rows, d_rows );;
gap> hom_dc_rows := InternalHomOnObjects( d_rows, c_rows );;

gap> hom_0a_rows := InternalHomOnObjects( 0_rows, a_rows );;
gap> hom_a0_rows := InternalHomOnObjects( a_rows, 0_rows );;

gap> cohom_ab_rows := InternalCoHomOnObjects( a_rows, b_rows );;
gap> cohom_ba_rows := InternalCoHomOnObjects( b_rows, a_rows );;
gap> cohom_cd_rows := InternalCoHomOnObjects( c_rows, d_rows );;
gap> cohom_dc_rows := InternalCoHomOnObjects( d_rows, c_rows );;

gap> cohom_0a_rows := InternalCoHomOnObjects( 0_rows, a_rows );;
gap> cohom_a0_rows := InternalCoHomOnObjects( a_rows, 0_rows );;

# Tensor objects and internal (co)homs for columns

gap> a_cols := Opposite( a_rows );;
gap> b_cols := Opposite( b_rows );;
gap> c_cols := Opposite( c_rows );;
gap> d_cols := Opposite( d_rows );;

gap> 0_cols := ZeroObject( columns );;
gap> 1_cols := TensorUnit( columns );;

gap> a_tensor_b_cols := TensorProductOnObjects( a_cols, b_cols );;
gap> b_tensor_a_cols := TensorProductOnObjects( b_cols, a_cols );;
gap> c_tensor_d_cols := TensorProductOnObjects( c_cols, d_cols );;
gap> d_tensor_c_cols := TensorProductOnObjects( d_cols, c_cols );;

gap> 0_tensor_a_cols := TensorProductOnObjects( 0_cols, a_cols );;
gap> a_tensor_0_cols := TensorProductOnObjects( a_cols, 0_cols );;

gap> hom_ab_cols := InternalHomOnObjects( a_cols, b_cols );;
gap> hom_ba_cols := InternalHomOnObjects( b_cols, a_cols );;
gap> hom_cd_cols := InternalHomOnObjects( c_cols, d_cols );;
gap> hom_dc_cols := InternalHomOnObjects( d_cols, c_cols );;

gap> hom_0a_cols := InternalHomOnObjects( 0_cols, a_cols );;
gap> hom_a0_cols := InternalHomOnObjects( a_cols, 0_cols );;

gap> cohom_ab_cols := InternalCoHomOnObjects( a_cols, b_cols );;
gap> cohom_ba_cols := InternalCoHomOnObjects( b_cols, a_cols );;
gap> cohom_cd_cols := InternalCoHomOnObjects( c_cols, d_cols );;
gap> cohom_dc_cols := InternalCoHomOnObjects( d_cols, c_cols );;

gap> cohom_0a_cols := InternalCoHomOnObjects( 0_cols, a_cols );;
gap> cohom_a0_cols := InternalCoHomOnObjects( a_cols, 0_cols );;


# Opposite correspondence on tensor objects

gap> 0_cols = Opposite( 0_rows );
true
gap> 1_cols = Opposite( 1_rows );
true

gap> a_tensor_b_cols = Opposite( a_tensor_b_rows );
true
gap> b_tensor_a_cols = Opposite( b_tensor_a_rows );
true
gap> c_tensor_d_cols = Opposite( c_tensor_d_rows );
true
gap> d_tensor_c_cols = Opposite( d_tensor_c_rows );
true

gap> 0_tensor_a_cols = Opposite( 0_tensor_a_rows );
true
gap> a_tensor_0_cols = Opposite( a_tensor_0_rows );
true

gap> b_tensor_a_cols = Opposite( c_tensor_d_rows );
false
gap> b_tensor_a_cols = Opposite( d_tensor_c_rows );
false
gap> c_tensor_d_cols = Opposite( a_tensor_b_rows );
false
gap> c_tensor_d_cols = Opposite( b_tensor_a_rows );
false

# Opposite correspondence on internal (co)homs

gap> hom_ab_cols = Opposite( cohom_ba_rows );
true
gap> hom_ba_cols = Opposite( cohom_ab_rows );
true
gap> hom_cd_cols = Opposite( cohom_dc_rows );
true
gap> hom_dc_cols = Opposite( cohom_cd_rows );
true

gap> hom_0a_cols = Opposite( cohom_a0_rows );
true
gap> hom_a0_cols = Opposite( cohom_0a_rows );
true

gap> cohom_ab_cols = Opposite( hom_ba_rows );
true
gap> cohom_ba_cols = Opposite( hom_ab_rows );
true
gap> cohom_cd_cols = Opposite( hom_dc_rows );
true
gap> cohom_dc_cols = Opposite( hom_cd_rows );
true

gap> cohom_0a_cols = Opposite( hom_a0_rows );
true
gap> cohom_a0_cols = Opposite( hom_0a_rows );
true

gap> hom_ab_cols = Opposite( hom_cd_rows );
false
gap> hom_ab_cols = Opposite( hom_dc_rows );
false
gap> hom_ab_cols = Opposite( cohom_cd_rows );
false
gap> hom_ab_cols = Opposite( cohom_dc_rows );
false

gap> cohom_cd_cols = Opposite( hom_ab_rows );
false
gap> cohom_cd_cols = Opposite( hom_ba_rows );
false
gap> cohom_cd_cols = Opposite( cohom_ab_rows );
false
gap> cohom_cd_cols = Opposite( cohom_ba_rows );
false

# Opposite must be self-inverse

gap> hom_ab_rows = Opposite( cohom_ba_cols );
true
gap> hom_ba_rows = Opposite( cohom_ab_cols );
true
gap> hom_cd_rows = Opposite( cohom_dc_cols );
true
gap> hom_dc_rows = Opposite( cohom_cd_cols );
true

gap> cohom_ab_rows = Opposite( hom_ba_cols );
true
gap> cohom_ba_rows = Opposite( hom_ab_cols );
true
gap> cohom_cd_rows = Opposite( hom_dc_cols );
true
gap> cohom_dc_rows = Opposite( hom_cd_cols );
true

# Convenience methods in the opposite category

gap> a_tensor_b_cols = TensorProduct( a_cols, b_cols );
true
gap> b_tensor_a_cols = TensorProduct( b_cols, a_cols );
true
gap> c_tensor_d_cols = TensorProduct( c_cols, d_cols );
true
gap> d_tensor_c_cols = TensorProduct( d_cols, c_cols );
true

gap> a_cols = TensorProductOp( [ a_cols ], a_cols ); # Special case in TensorProductOp
true
gap> b_cols = TensorProductOp( [ b_cols ], b_cols ); # Special case in TensorProductOp
true

gap> hom_ab_cols = InternalHom( a_cols, b_cols );
true
gap> hom_ba_cols = InternalHom( b_cols, a_cols );
true
gap> hom_cd_cols = InternalHom( c_cols, d_cols );
true
gap> hom_dc_cols = InternalHom( d_cols, c_cols);
true

gap> hom_0a_cols = InternalHom( 0_cols, a_cols );
true
gap> hom_a0_cols = InternalHom( a_cols, 0_cols );
true

gap> cohom_ab_cols = InternalCoHom( a_cols, b_cols );
true
gap> cohom_ba_cols = InternalCoHom( b_cols, a_cols );
true
gap> cohom_cd_cols = InternalCoHom( c_cols, d_cols );
true
gap> cohom_dc_cols = InternalCoHom( d_cols, c_cols);
true

gap> cohom_0a_cols = InternalCoHom( 0_cols, a_cols );
true
gap> cohom_a0_cols = InternalCoHom( a_cols, 0_cols );
true

################################################################
# Tensor, Hom and CoHom on morphisms
################################################################

# Morphisms for rows

gap> id_a_rows := IdentityMorphism( a_rows );;
gap> id_b_rows := IdentityMorphism( b_rows );;

gap> alpha_rows := CategoryOfRowsMorphism( a_rows, HomalgMatrix( [ 2 .. 7], 2, 3, Q ), b_rows );;
gap> beta_rows := CategoryOfRowsMorphism( c_rows, HomalgMatrix( [ 8 .. 31 ], 6, 4, Q ), d_rows );;
gap> gamma_rows := CategoryOfRowsMorphism( b_rows, HomalgMatrix( [ -8 .. 9 ], 3, 6, Q ), c_rows );;

gap> alpha_gamma_rows := PreCompose( alpha_rows, gamma_rows );;
gap> gamma_beta_rows := PreCompose( gamma_rows, beta_rows );;
gap> alpha_gamma_beta_rows := PreCompose( [ alpha_rows, gamma_rows, beta_rows ] );;

gap> alpha_tensor_beta_rows := TensorProductOnMorphisms( alpha_rows, beta_rows );;
gap> beta_tensor_alpha_rows := TensorProductOnMorphisms( beta_rows, alpha_rows );;

gap> hom_alpha_id_a_rows := InternalHomOnMorphisms( alpha_rows, id_a_rows );;
gap> hom_alpha_id_b_rows := InternalHomOnMorphisms( alpha_rows, id_b_rows );;
gap> hom_id_a_alpha_rows := InternalHomOnMorphisms( id_a_rows, alpha_rows );;
gap> hom_id_b_alpha_rows := InternalHomOnMorphisms( id_b_rows, alpha_rows );;

gap> hom_alpha_beta_rows := InternalHomOnMorphisms( alpha_rows, beta_rows );;
gap> hom_beta_alpha_rows := InternalHomOnMorphisms( beta_rows, alpha_rows );;

gap> cohom_alpha_id_a_rows := InternalCoHomOnMorphisms( alpha_rows, id_a_rows );;
gap> cohom_alpha_id_b_rows := InternalCoHomOnMorphisms( alpha_rows, id_b_rows );;
gap> cohom_id_a_alpha_rows := InternalCoHomOnMorphisms( id_a_rows, alpha_rows );;
gap> cohom_id_b_alpha_rows := InternalCoHomOnMorphisms( id_b_rows, alpha_rows );;

gap> cohom_alpha_beta_rows := InternalCoHomOnMorphisms( alpha_rows, beta_rows );;
gap> cohom_beta_alpha_rows := InternalCoHomOnMorphisms( beta_rows, alpha_rows );;

# Morphisms for columns

gap> id_a_cols := IdentityMorphism( a_cols );;
gap> id_b_cols := IdentityMorphism( b_cols );;

gap> alpha_cols := Opposite( alpha_rows );;
gap> beta_cols := Opposite( beta_rows );;
gap> gamma_cols := Opposite( gamma_rows );;

gap> alpha_gamma_cols := PostCompose( alpha_cols, gamma_cols );;
gap> gamma_beta_cols := PostCompose( gamma_cols, beta_cols );;
gap> alpha_gamma_beta_cols := PostCompose( [ alpha_cols, gamma_cols, beta_cols ] );;

gap> alpha_tensor_beta_cols := TensorProductOnMorphisms( alpha_cols, beta_cols );;
gap> beta_tensor_alpha_cols := TensorProductOnMorphisms( beta_cols, alpha_cols );;

gap> hom_alpha_id_a_cols := InternalHomOnMorphisms( alpha_cols, id_a_cols );;
gap> hom_alpha_id_b_cols := InternalHomOnMorphisms( alpha_cols, id_b_cols );;
gap> hom_id_a_alpha_cols := InternalHomOnMorphisms( id_a_cols, alpha_cols );;
gap> hom_id_b_alpha_cols := InternalHomOnMorphisms( id_b_cols, alpha_cols );;

gap> hom_alpha_beta_cols := InternalHomOnMorphisms( alpha_cols, beta_cols );;
gap> hom_beta_alpha_cols := InternalHomOnMorphisms( beta_cols, alpha_cols );;

gap> cohom_alpha_id_a_cols := InternalCoHomOnMorphisms( alpha_cols, id_a_cols );;
gap> cohom_alpha_id_b_cols := InternalCoHomOnMorphisms( alpha_cols, id_b_cols );;
gap> cohom_id_a_alpha_cols := InternalCoHomOnMorphisms( id_a_cols, alpha_cols );;
gap> cohom_id_b_alpha_cols := InternalCoHomOnMorphisms( id_b_cols, alpha_cols );;

gap> cohom_alpha_beta_cols := InternalCoHomOnMorphisms( alpha_cols, beta_cols );;
gap> cohom_beta_alpha_cols := InternalCoHomOnMorphisms( beta_cols, alpha_cols );;

# Opposite correspondence on tensored morphisms

gap> alpha_tensor_beta_cols = Opposite( alpha_tensor_beta_rows );
true
gap> beta_tensor_alpha_cols = Opposite( beta_tensor_alpha_rows );
true

# Opposite correspondence on internal (co)homs

gap> hom_alpha_beta_cols = Opposite( cohom_beta_alpha_rows );
true
gap> hom_beta_alpha_cols = Opposite( cohom_alpha_beta_rows );
true
gap> cohom_alpha_beta_cols = Opposite( hom_beta_alpha_rows );
true
gap> cohom_beta_alpha_cols = Opposite( hom_alpha_beta_rows );
true

gap> hom_alpha_beta_cols = Opposite( cohom_alpha_beta_rows );
false
gap> hom_alpha_beta_cols = Opposite( hom_beta_alpha_rows );
false
gap> hom_alpha_beta_cols = Opposite( hom_beta_alpha_rows );
false

gap> cohom_alpha_beta_cols = Opposite( hom_alpha_beta_rows );
false
gap> cohom_alpha_beta_cols = Opposite( cohom_beta_alpha_rows );
false
gap> cohom_alpha_beta_cols = Opposite( cohom_beta_alpha_rows );
false

# Opposite correspondence on compositions of morphisms

gap> alpha_gamma_cols = Opposite( alpha_gamma_rows );
true
gap> gamma_beta_cols = Opposite( gamma_beta_rows );
true
gap> alpha_gamma_beta_cols = Opposite( alpha_gamma_beta_rows );
true

gap> alpha_gamma_cols = Opposite( gamma_beta_rows );
false
gap> alpha_gamma_cols = Opposite( alpha_gamma_beta_rows );
false
gap> gamma_beta_cols = Opposite( alpha_gamma_rows );
false
gap> gamma_beta_cols = Opposite( alpha_gamma_beta_rows );
false
gap> alpha_gamma_beta_cols = Opposite( alpha_gamma_rows );
false
gap> alpha_gamma_beta_cols = Opposite( gamma_beta_rows );
false

# Opposite must be self-inverse

gap> hom_alpha_beta_rows = Opposite( cohom_beta_alpha_cols );
true
gap> hom_beta_alpha_rows = Opposite( cohom_alpha_beta_cols );
true
gap> cohom_alpha_beta_rows = Opposite( hom_beta_alpha_cols );
true
gap> cohom_beta_alpha_rows = Opposite( hom_alpha_beta_cols );
true

# Convenience methods in the opposite category

gap> alpha_tensor_beta_cols = TensorProduct( alpha_cols, beta_cols );
true
gap> beta_tensor_alpha_cols = TensorProduct( beta_cols, alpha_cols );
true

gap> alpha_cols = TensorProductOp( [ alpha_cols ], alpha_cols ); # Special case in TensorProductOp
true
gap> beta_cols = TensorProductOp( [ beta_cols ], beta_cols ); # Special case in TensorProductOp
true

gap> hom_alpha_beta_cols = InternalHom( alpha_cols, beta_cols );
true
gap> hom_beta_alpha_cols = InternalHom( beta_cols, alpha_cols );
true

gap> cohom_alpha_beta_cols = InternalCoHom( alpha_cols, beta_cols );
true
gap> cohom_beta_alpha_cols = InternalCoHom( beta_cols, alpha_cols );
true

gap> hom_alpha_id_a_cols = InternalHom( alpha_cols, a_cols );
true
gap> hom_alpha_id_b_cols = InternalHom( alpha_cols, b_cols );
true
gap> hom_id_a_alpha_cols = InternalHom( a_cols, alpha_cols );
true
gap> hom_id_b_alpha_cols = InternalHom( b_cols, alpha_cols );
true

gap> cohom_alpha_id_a_cols = InternalCoHom( alpha_cols, a_cols );
true
gap> cohom_alpha_id_b_cols = InternalCoHom( alpha_cols, b_cols );
true
gap> cohom_id_a_alpha_cols = InternalCoHom( a_cols, alpha_cols );
true
gap> cohom_id_b_alpha_cols = InternalCoHom( b_cols, alpha_cols );
true

######################################################
# Unitors
######################################################

# Unitors

gap> left_unitor_a_rows := LeftUnitor( a_rows );;
gap> left_unitor_b_rows := LeftUnitor( b_rows );;
gap> left_unitor_c_rows := LeftUnitor( c_rows );;
gap> left_unitor_d_rows := LeftUnitor( d_rows );;

gap> left_unitor_a_cols := LeftUnitor( a_cols );;
gap> left_unitor_b_cols := LeftUnitor( b_cols );;
gap> left_unitor_c_cols := LeftUnitor( c_cols );;
gap> left_unitor_d_cols := LeftUnitor( d_cols );;

gap> right_unitor_a_rows := RightUnitor( a_rows );;
gap> right_unitor_b_rows := RightUnitor( b_rows );;
gap> right_unitor_c_rows := RightUnitor( c_rows );;
gap> right_unitor_d_rows := RightUnitor( d_rows );;

gap> right_unitor_a_cols := RightUnitor( a_cols );;
gap> right_unitor_b_cols := RightUnitor( b_cols );;
gap> right_unitor_c_cols := RightUnitor( c_cols );;
gap> right_unitor_d_cols := RightUnitor( d_cols );;

# Inverse unitors

gap> left_unitor_inverse_a_rows := LeftUnitorInverse( a_rows );;
gap> left_unitor_inverse_b_rows := LeftUnitorInverse( b_rows );;
gap> left_unitor_inverse_c_rows := LeftUnitorInverse( c_rows );;
gap> left_unitor_inverse_d_rows := LeftUnitorInverse( d_rows );;

gap> left_unitor_inverse_a_cols := LeftUnitorInverse( a_cols );;
gap> left_unitor_inverse_b_cols := LeftUnitorInverse( b_cols );;
gap> left_unitor_inverse_c_cols := LeftUnitorInverse( c_cols );;
gap> left_unitor_inverse_d_cols := LeftUnitorInverse( d_cols );;

gap> right_unitor_inverse_a_rows := RightUnitorInverse( a_rows );;
gap> right_unitor_inverse_b_rows := RightUnitorInverse( b_rows );;
gap> right_unitor_inverse_c_rows := RightUnitorInverse( c_rows );;
gap> right_unitor_inverse_d_rows := RightUnitorInverse( d_rows );;

gap> right_unitor_inverse_a_cols := RightUnitorInverse( a_cols );;
gap> right_unitor_inverse_b_cols := RightUnitorInverse( b_cols );;
gap> right_unitor_inverse_c_cols := RightUnitorInverse( c_cols );;
gap> right_unitor_inverse_d_cols := RightUnitorInverse( d_cols );;

# Opposite correspondence

gap> left_unitor_a_cols = Opposite( left_unitor_inverse_a_rows );
true
gap> left_unitor_b_cols = Opposite( left_unitor_inverse_b_rows );
true
gap> left_unitor_c_cols = Opposite( left_unitor_inverse_c_rows );
true
gap> left_unitor_d_cols = Opposite( left_unitor_inverse_d_rows );
true

gap> left_unitor_inverse_a_cols = Opposite( left_unitor_a_rows );
true
gap> left_unitor_inverse_b_cols = Opposite( left_unitor_b_rows );
true
gap> left_unitor_inverse_c_cols = Opposite( left_unitor_c_rows );
true
gap> left_unitor_inverse_d_cols = Opposite( left_unitor_d_rows );
true

gap> right_unitor_a_cols = Opposite( right_unitor_inverse_a_rows );
true
gap> right_unitor_b_cols = Opposite( right_unitor_inverse_b_rows );
true
gap> right_unitor_c_cols = Opposite( right_unitor_inverse_c_rows );
true
gap> right_unitor_d_cols = Opposite( right_unitor_inverse_d_rows );
true

gap> right_unitor_inverse_a_cols = Opposite( right_unitor_a_rows );
true
gap> right_unitor_inverse_b_cols = Opposite( right_unitor_b_rows );
true
gap> right_unitor_inverse_c_cols = Opposite( right_unitor_c_rows );
true
gap> right_unitor_inverse_d_cols = Opposite( right_unitor_d_rows );
true

gap> left_unitor_b_cols = Opposite( left_unitor_inverse_a_rows );
false
gap> left_unitor_b_cols = Opposite( left_unitor_inverse_c_rows );
false
gap> left_unitor_b_cols = Opposite( left_unitor_inverse_d_rows );
false

gap> left_unitor_inverse_c_cols = Opposite( left_unitor_a_rows );
false
gap> left_unitor_inverse_c_cols = Opposite( left_unitor_b_rows );
false
gap> left_unitor_inverse_c_cols = Opposite( left_unitor_d_rows );
false

gap> right_unitor_a_cols = Opposite( right_unitor_inverse_b_rows );
false
gap> right_unitor_a_cols = Opposite( right_unitor_inverse_c_rows );
false
gap> right_unitor_a_cols = Opposite( right_unitor_inverse_d_rows );
false

gap> right_unitor_inverse_d_cols = Opposite( right_unitor_a_rows );
false
gap> right_unitor_inverse_d_cols = Opposite( right_unitor_b_rows );
false
gap> right_unitor_inverse_d_cols = Opposite( right_unitor_c_rows );
false

######################################################
# Associators
######################################################

gap> associator_left_to_right_abc_rows := AssociatorLeftToRight( a_rows, b_rows, c_rows );;
gap> associator_left_to_right_bcd_rows := AssociatorLeftToRight( b_rows, c_rows, d_rows );;
gap> associator_left_to_right_acd_rows := AssociatorLeftToRight( a_rows, c_rows, d_rows );;
gap> associator_left_to_right_cba_rows := AssociatorLeftToRight( c_rows, b_rows, a_rows );;
gap> associator_left_to_right_dcb_rows := AssociatorLeftToRight( d_rows, c_rows, b_rows );;

gap> associator_left_to_right_abc_cols := AssociatorLeftToRight( a_cols, b_cols, c_cols );;
gap> associator_left_to_right_bcd_cols := AssociatorLeftToRight( b_cols, c_cols, d_cols );;
gap> associator_left_to_right_acd_cols := AssociatorLeftToRight( a_cols, c_cols, d_cols );;
gap> associator_left_to_right_cba_cols := AssociatorLeftToRight( c_cols, b_cols, a_cols );;
gap> associator_left_to_right_dcb_cols := AssociatorLeftToRight( d_cols, c_cols, b_cols );;

gap> associator_right_to_left_abc_rows := AssociatorRightToLeft( a_rows, b_rows, c_rows );;
gap> associator_right_to_left_bcd_rows := AssociatorRightToLeft( b_rows, c_rows, d_rows );;
gap> associator_right_to_left_acd_rows := AssociatorRightToLeft( a_rows, c_rows, d_rows );;
gap> associator_right_to_left_cba_rows := AssociatorRightToLeft( c_rows, b_rows, a_rows );;
gap> associator_right_to_left_dcb_rows := AssociatorRightToLeft( d_rows, c_rows, b_rows );;

gap> associator_right_to_left_abc_cols := AssociatorRightToLeft( a_cols, b_cols, c_cols );;
gap> associator_right_to_left_bcd_cols := AssociatorRightToLeft( b_cols, c_cols, d_cols );;
gap> associator_right_to_left_acd_cols := AssociatorRightToLeft( a_cols, c_cols, d_cols );;
gap> associator_right_to_left_cba_cols := AssociatorRightToLeft( c_cols, b_cols, a_cols );;
gap> associator_right_to_left_dcb_cols := AssociatorRightToLeft( d_cols, c_cols, b_cols );;

# Opposite correspondence

gap> associator_left_to_right_abc_cols = Opposite( associator_right_to_left_abc_rows );
true
gap> associator_left_to_right_bcd_cols = Opposite( associator_right_to_left_bcd_rows );
true
gap> associator_left_to_right_acd_cols = Opposite( associator_right_to_left_acd_rows );
true
gap> associator_left_to_right_cba_cols = Opposite( associator_right_to_left_cba_rows );
true
gap> associator_left_to_right_dcb_cols = Opposite( associator_right_to_left_dcb_rows );
true

gap> associator_right_to_left_abc_cols = Opposite( associator_left_to_right_abc_rows );
true
gap> associator_right_to_left_bcd_cols = Opposite( associator_left_to_right_bcd_rows );
true
gap> associator_right_to_left_acd_cols = Opposite( associator_left_to_right_acd_rows );
true
gap> associator_right_to_left_cba_cols = Opposite( associator_left_to_right_cba_rows );
true
gap> associator_right_to_left_dcb_cols = Opposite( associator_left_to_right_dcb_rows );
true

gap> associator_left_to_right_cba_cols = Opposite( associator_right_to_left_bcd_rows );
false
gap> associator_left_to_right_cba_cols = Opposite( associator_right_to_left_acd_rows );
false
gap> associator_left_to_right_cba_cols = Opposite( associator_right_to_left_dcb_rows );
false

gap> associator_right_to_left_acd_cols = Opposite( associator_left_to_right_abc_rows );
false
gap> associator_right_to_left_acd_cols = Opposite( associator_left_to_right_bcd_rows );
false
gap> associator_right_to_left_acd_cols = Opposite( associator_left_to_right_cba_rows );
false

######################################################
# Braiding
######################################################

gap> braiding_a_b_rows := Braiding( a_rows, b_rows );;
gap> braiding_b_a_rows := Braiding( b_rows, a_rows );;
gap> braiding_c_d_rows := Braiding( c_rows, d_rows );;
gap> braiding_d_c_rows := Braiding( d_rows, c_rows );;

gap> braiding_0_a_rows := Braiding( 0_rows, a_rows );;
gap> braiding_a_0_rows := Braiding( a_rows, 0_rows );;

gap> braiding_a_b_cols := Braiding( a_cols, b_cols );;
gap> braiding_b_a_cols := Braiding( b_cols, a_cols );;
gap> braiding_c_d_cols := Braiding( c_cols, d_cols );;
gap> braiding_d_c_cols := Braiding( d_cols, c_cols );;

gap> braiding_0_a_cols := Braiding( 0_cols, a_cols );;
gap> braiding_a_0_cols := Braiding( a_cols, 0_cols );;

gap> braiding_inverse_a_b_rows := BraidingInverse( a_rows, b_rows );;
gap> braiding_inverse_b_a_rows := BraidingInverse( b_rows, a_rows );;
gap> braiding_inverse_c_d_rows := BraidingInverse( c_rows, d_rows );;
gap> braiding_inverse_d_c_rows := BraidingInverse( d_rows, c_rows );;

gap> braiding_inverse_0_a_rows := BraidingInverse( 0_rows, a_rows );;
gap> braiding_inverse_a_0_rows := BraidingInverse( a_rows, 0_rows );;

gap> braiding_inverse_a_b_cols := BraidingInverse( a_cols, b_cols );;
gap> braiding_inverse_b_a_cols := BraidingInverse( b_cols, a_cols );;
gap> braiding_inverse_c_d_cols := BraidingInverse( c_cols, d_cols );;
gap> braiding_inverse_d_c_cols := BraidingInverse( d_cols, c_cols );;

gap> braiding_inverse_0_a_cols := BraidingInverse( 0_cols, a_cols );;
gap> braiding_inverse_a_0_cols := BraidingInverse( a_cols, 0_cols );;

# Opposite correspondence

gap> braiding_a_b_cols = Opposite( braiding_inverse_a_b_rows );
true
gap> braiding_b_a_cols = Opposite( braiding_inverse_b_a_rows );
true
gap> braiding_c_d_cols = Opposite( braiding_inverse_c_d_rows );
true
gap> braiding_d_c_cols = Opposite( braiding_inverse_d_c_rows );
true
gap> braiding_0_a_cols = Opposite( braiding_inverse_0_a_rows );
true
gap> braiding_a_0_cols = Opposite( braiding_inverse_a_0_rows );
true

gap> braiding_inverse_a_b_cols = Opposite( braiding_a_b_rows );
true
gap> braiding_inverse_b_a_cols = Opposite( braiding_b_a_rows );
true
gap> braiding_inverse_c_d_cols = Opposite( braiding_c_d_rows );
true
gap> braiding_inverse_d_c_cols = Opposite( braiding_d_c_rows );
true
gap> braiding_inverse_0_a_cols = Opposite( braiding_0_a_rows );
true
gap> braiding_inverse_a_0_cols = Opposite( braiding_a_0_rows );
true

gap> braiding_a_b_cols = Opposite( braiding_inverse_b_a_rows );
false
gap> braiding_a_b_cols = Opposite( braiding_inverse_c_d_rows );
false
gap> braiding_a_b_cols = Opposite( braiding_inverse_d_c_rows );
false

gap> braiding_c_d_cols = Opposite( braiding_inverse_a_b_rows );
false
gap> braiding_c_d_cols = Opposite( braiding_inverse_b_a_rows );
false
gap> braiding_c_d_cols = Opposite( braiding_inverse_d_c_rows );
false

gap> braiding_inverse_b_a_cols = Opposite( braiding_a_b_rows );
false
gap> braiding_inverse_b_a_cols = Opposite( braiding_c_d_rows );
false
gap> braiding_inverse_b_a_cols = Opposite( braiding_d_c_rows );
false

gap> braiding_inverse_d_c_cols = Opposite( braiding_a_b_rows );
false
gap> braiding_inverse_d_c_cols = Opposite( braiding_b_a_rows );
false
gap> braiding_inverse_d_c_cols = Opposite( braiding_c_d_rows );
false

######################################################
# Identity morphisms
######################################################

# Identities for tensor objects

gap> id_a_tensor_b_rows := IdentityMorphism( a_tensor_b_rows );;
gap> id_b_tensor_a_rows := IdentityMorphism( b_tensor_a_rows );;
gap> id_c_tensor_d_rows := IdentityMorphism( c_tensor_d_rows );;
gap> id_d_tensor_c_rows := IdentityMorphism( d_tensor_c_rows );;

gap> id_0_tensor_a_rows := IdentityMorphism( 0_tensor_a_rows );;
gap> id_a_tensor_0_rows := IdentityMorphism( a_tensor_0_rows );;

gap> id_a_tensor_b_cols := IdentityMorphism( a_tensor_b_cols );;
gap> id_b_tensor_a_cols := IdentityMorphism( b_tensor_a_cols );;
gap> id_c_tensor_d_cols := IdentityMorphism( c_tensor_d_cols );;
gap> id_d_tensor_c_cols := IdentityMorphism( d_tensor_c_cols );;

gap> id_0_tensor_a_cols := IdentityMorphism( 0_tensor_a_cols );;
gap> id_a_tensor_0_cols := IdentityMorphism( a_tensor_0_cols );;

# Identities for internal (co)homs

gap> id_hom_ab_rows := IdentityMorphism( hom_ab_rows );;
gap> id_hom_ba_rows := IdentityMorphism (hom_ba_rows );;
gap> id_hom_cd_rows := IdentityMorphism( hom_cd_rows );;
gap> id_hom_dc_rows := IdentityMorphism( hom_dc_rows );;

gap> id_hom_0a_rows := IdentityMorphism( hom_0a_rows );;
gap> id_hom_a0_rows := IdentityMorphism( hom_a0_rows );;

gap> id_cohom_ab_rows := IdentityMorphism( cohom_ab_rows );;
gap> id_cohom_ba_rows := IdentityMorphism( cohom_ba_rows );;
gap> id_cohom_cd_rows := IdentityMorphism( cohom_cd_rows );;
gap> id_cohom_dc_rows := IdentityMorphism( cohom_dc_rows );;

gap> id_cohom_0a_rows := IdentityMorphism( cohom_0a_rows );;
gap> id_cohom_a0_rows := IdentityMorphism( cohom_a0_rows );;

gap> id_hom_ab_cols := IdentityMorphism( hom_ab_cols );;
gap> id_hom_ba_cols := IdentityMorphism (hom_ba_cols );;
gap> id_hom_cd_cols := IdentityMorphism( hom_cd_cols );;
gap> id_hom_dc_cols := IdentityMorphism( hom_dc_cols );;

gap> id_hom_0a_cols := IdentityMorphism( hom_0a_cols );;
gap> id_hom_a0_cols := IdentityMorphism( hom_a0_cols );;

gap> id_cohom_ab_cols := IdentityMorphism( cohom_ab_cols );;
gap> id_cohom_ba_cols := IdentityMorphism( cohom_ba_cols );;
gap> id_cohom_cd_cols := IdentityMorphism( cohom_cd_cols );;
gap> id_cohom_dc_cols := IdentityMorphism( cohom_dc_cols );;

gap> id_cohom_0a_cols := IdentityMorphism( cohom_0a_cols );;
gap> id_cohom_a0_cols := IdentityMorphism( cohom_a0_cols );;

# Opposite correspondence on identities of tensor objects

gap> id_a_tensor_b_cols = Opposite( id_a_tensor_b_rows );
true
gap> id_b_tensor_a_cols = Opposite( id_b_tensor_a_rows );
true
gap> id_c_tensor_d_cols = Opposite( id_c_tensor_d_rows );
true
gap> id_d_tensor_c_cols = Opposite( id_d_tensor_c_rows );
true

gap> id_0_tensor_a_cols = Opposite( id_0_tensor_a_rows );
true
gap> id_a_tensor_0_cols = Opposite( id_a_tensor_0_rows );
true

gap> id_a_tensor_b_cols = Opposite( id_c_tensor_d_rows );
false
gap> id_a_tensor_b_cols = Opposite( id_d_tensor_c_rows );
false
gap> id_c_tensor_d_cols = Opposite( id_a_tensor_b_rows );
false
gap> id_c_tensor_d_cols = Opposite( id_b_tensor_a_rows );
false

# Opposite correspondence on identities of internal (co)homs

gap> id_hom_ab_cols = Opposite( id_cohom_ba_rows );
true
gap> id_hom_ba_cols = Opposite( id_cohom_ab_rows );
true
gap> id_hom_cd_cols = Opposite( id_cohom_dc_rows );
true
gap> id_hom_dc_cols = Opposite( id_cohom_cd_rows );
true

gap> id_hom_0a_cols = Opposite( id_cohom_a0_rows );
true
gap> id_hom_a0_cols = Opposite( id_cohom_0a_rows );
true

gap> id_cohom_ab_cols = Opposite( id_hom_ba_rows );
true
gap> id_cohom_ba_cols = Opposite( id_hom_ab_rows );
true
gap> id_cohom_cd_cols = Opposite( id_hom_dc_rows );
true
gap> id_cohom_dc_cols = Opposite( id_hom_cd_rows );
true

gap> id_cohom_0a_cols = Opposite( id_hom_a0_rows );
true
gap> id_cohom_a0_cols = Opposite( id_hom_0a_rows );
true

gap> id_hom_cd_cols = Opposite( id_hom_ab_rows );
false
gap> id_hom_cd_cols = Opposite( id_hom_ba_rows );
false
gap> id_hom_cd_cols = Opposite( id_cohom_ab_rows );
false
gap> id_hom_cd_cols = Opposite( id_cohom_ba_rows );
false

gap> id_cohom_ab_cols = Opposite( id_hom_cd_rows );
false
gap> id_cohom_ab_cols = Opposite( id_hom_dc_rows );
false
gap> id_cohom_ab_cols = Opposite( id_cohom_cd_rows );
false
gap> id_cohom_ab_cols = Opposite( id_cohom_dc_rows );
false

#####################################################
# Units and counits
#####################################################

# Units and counits for rows

gap> ev_ab_rows := EvaluationMorphism( a_rows, b_rows );;
gap> ev_ba_rows := EvaluationMorphism( b_rows, a_rows );;
gap> ev_cd_rows := EvaluationMorphism( c_rows, d_rows );;
gap> ev_dc_rows := EvaluationMorphism( d_rows, c_rows );;

gap> ev_0a_rows := EvaluationMorphism( 0_rows, a_rows );;
gap> ev_a0_rows := EvaluationMorphism( a_rows, 0_rows );;

gap> coev_ab_rows := CoevaluationMorphism( a_rows, b_rows );;
gap> coev_ba_rows := CoevaluationMorphism( b_rows, a_rows );;
gap> coev_cd_rows := CoevaluationMorphism( c_rows, d_rows );;
gap> coev_dc_rows := CoevaluationMorphism( d_rows, c_rows );;

gap> coev_0a_rows := CoevaluationMorphism( 0_rows, a_rows );;
gap> coev_a0_rows := CoevaluationMorphism( a_rows, 0_rows );;

gap> cocl_ev_ab_rows := CoclosedEvaluationMorphism( a_rows, b_rows );;
gap> cocl_ev_ba_rows := CoclosedEvaluationMorphism( b_rows, a_rows );;
gap> cocl_ev_cd_rows := CoclosedEvaluationMorphism( c_rows, d_rows );;
gap> cocl_ev_dc_rows := CoclosedEvaluationMorphism( d_rows, c_rows );;

gap> cocl_ev_0a_rows := CoclosedEvaluationMorphism( 0_rows, a_rows );;
gap> cocl_ev_a0_rows := CoclosedEvaluationMorphism( a_rows, 0_rows );;

gap> cocl_coev_ab_rows := CoclosedCoevaluationMorphism( a_rows, b_rows );;
gap> cocl_coev_ba_rows := CoclosedCoevaluationMorphism( b_rows, a_rows );;
gap> cocl_coev_cd_rows := CoclosedCoevaluationMorphism( c_rows, d_rows );;
gap> cocl_coev_dc_rows := CoclosedCoevaluationMorphism( d_rows, c_rows );;

gap> cocl_coev_0a_rows := CoclosedCoevaluationMorphism( 0_rows, a_rows );;
gap> cocl_coev_a0_rows := CoclosedCoevaluationMorphism( a_rows, 0_rows );;

# Units and counits for columns

gap> ev_ab_cols := EvaluationMorphism( a_cols, b_cols );;
gap> ev_ba_cols := EvaluationMorphism( b_cols, a_cols );;
gap> ev_cd_cols := EvaluationMorphism( c_cols, d_cols );;
gap> ev_dc_cols := EvaluationMorphism( d_cols, c_cols );;

gap> ev_0a_cols := EvaluationMorphism( 0_cols, a_cols );;
gap> ev_a0_cols := EvaluationMorphism( a_cols, 0_cols );;

gap> coev_ab_cols := CoevaluationMorphism( a_cols, b_cols );;
gap> coev_ba_cols := CoevaluationMorphism( b_cols, a_cols );;
gap> coev_cd_cols := CoevaluationMorphism( c_cols, d_cols );;
gap> coev_dc_cols := CoevaluationMorphism( d_cols, c_cols );;

gap> coev_0a_cols := CoevaluationMorphism( 0_cols, a_cols );;
gap> coev_a0_cols := CoevaluationMorphism( a_cols, 0_cols );;

gap> cocl_ev_ab_cols := CoclosedEvaluationMorphism( a_cols, b_cols );;
gap> cocl_ev_ba_cols := CoclosedEvaluationMorphism( b_cols, a_cols );;
gap> cocl_ev_cd_cols := CoclosedEvaluationMorphism( c_cols, d_cols );;
gap> cocl_ev_dc_cols := CoclosedEvaluationMorphism( d_cols, c_cols );;

gap> cocl_ev_0a_cols := CoclosedEvaluationMorphism( 0_cols, a_cols );;
gap> cocl_ev_a0_cols := CoclosedEvaluationMorphism( a_cols, 0_cols );;

gap> cocl_coev_ab_cols := CoclosedCoevaluationMorphism( a_cols, b_cols );;
gap> cocl_coev_ba_cols := CoclosedCoevaluationMorphism( b_cols, a_cols );;
gap> cocl_coev_cd_cols := CoclosedCoevaluationMorphism( c_cols, d_cols );;
gap> cocl_coev_dc_cols := CoclosedCoevaluationMorphism( d_cols, c_cols );;

gap> cocl_coev_0a_cols := CoclosedCoevaluationMorphism( 0_cols, a_cols );;
gap> cocl_coev_a0_cols := CoclosedCoevaluationMorphism( a_cols, 0_cols );;

# Opposite correspondence on units and counits

# Arguments must be reversed for evaluations
gap> ev_ab_cols = Opposite( cocl_ev_ba_rows );
true
gap> ev_ba_cols = Opposite( cocl_ev_ab_rows );
true
gap> ev_cd_cols = Opposite( cocl_ev_dc_rows );
true
gap> ev_dc_cols = Opposite( cocl_ev_cd_rows );
true

gap> ev_0a_cols = Opposite( cocl_ev_a0_rows );
true
gap> ev_a0_cols = Opposite( cocl_ev_0a_rows );
true

gap> coev_ab_cols = Opposite( cocl_coev_ab_rows );
true
gap> coev_ba_cols = Opposite( cocl_coev_ba_rows );
true
gap> coev_cd_cols = Opposite( cocl_coev_cd_rows );
true
gap> coev_dc_cols = Opposite( cocl_coev_dc_rows );
true

gap> coev_0a_cols = Opposite( cocl_coev_0a_rows );
true
gap> coev_a0_cols = Opposite( cocl_coev_a0_rows );
true

# Arguments must be reversed for evaluations
gap> cocl_ev_ab_cols= Opposite( ev_ba_rows );
true
gap> cocl_ev_ba_cols= Opposite( ev_ab_rows );
true
gap> cocl_ev_cd_cols= Opposite( ev_dc_rows );
true
gap> cocl_ev_dc_cols= Opposite( ev_cd_rows );
true

gap> cocl_ev_0a_cols= Opposite( ev_a0_rows );
true
gap> cocl_ev_a0_cols= Opposite( ev_0a_rows );
true

gap> cocl_coev_ab_cols = Opposite( coev_ab_rows );
true
gap> cocl_coev_ba_cols = Opposite( coev_ba_rows );
true
gap> cocl_coev_cd_cols = Opposite( coev_cd_rows );
true
gap> cocl_coev_dc_cols = Opposite( coev_dc_rows );
true

gap> cocl_coev_0a_cols = Opposite( coev_0a_rows );
true
gap> cocl_coev_a0_cols = Opposite( coev_a0_rows );
true

gap> ev_ba_cols = Opposite( cocl_ev_ba_rows );
false
gap> ev_ba_cols = Opposite( cocl_ev_cd_rows );
false
gap> ev_ba_cols = Opposite( cocl_ev_dc_rows );
false

gap> coev_dc_cols = Opposite( cocl_coev_cd_rows );
false
gap> coev_dc_cols = Opposite( cocl_coev_ab_rows );
false
gap> coev_dc_cols = Opposite( cocl_coev_ba_rows );
false

gap> cocl_ev_cd_cols = Opposite( ev_ab_rows );
false
gap> cocl_ev_cd_cols = Opposite( ev_ba_rows );
false
gap> cocl_ev_cd_cols = Opposite( ev_cd_rows );
false

gap> cocl_coev_ab_cols = Opposite( coev_ba_rows );
false
gap> cocl_coev_ab_cols = Opposite( coev_cd_rows );
false
gap> cocl_coev_ab_cols = Opposite( coev_dc_rows );
false

#####################################################
# Adjunction maps on identities
#####################################################

# Closed and coclosed structure for rows

gap> tensor_to_hom_adjunction_on_id_a_tensor_b_rows := TensorProductToInternalHomAdjunctionMap( a_rows, b_rows, id_a_tensor_b_rows );;
gap> tensor_to_hom_adjunction_on_id_b_tensor_a_rows := TensorProductToInternalHomAdjunctionMap( b_rows, a_rows, id_b_tensor_a_rows );;
gap> tensor_to_hom_adjunction_on_id_c_tensor_d_rows := TensorProductToInternalHomAdjunctionMap( c_rows, d_rows, id_c_tensor_d_rows );;
gap> tensor_to_hom_adjunction_on_id_d_tensor_c_rows := TensorProductToInternalHomAdjunctionMap( d_rows, c_rows, id_d_tensor_c_rows );;

gap> tensor_to_hom_adjunction_on_id_0_tensor_a_rows := TensorProductToInternalHomAdjunctionMap( 0_rows, a_rows, id_0_tensor_a_rows );;
gap> tensor_to_hom_adjunction_on_id_a_tensor_0_rows := TensorProductToInternalHomAdjunctionMap( a_rows, 0_rows, id_a_tensor_0_rows );;

gap> hom_to_tensor_adjunction_on_id_hom_ab_rows := InternalHomToTensorProductAdjunctionMap( a_rows, b_rows, id_hom_ab_rows );;
gap> hom_to_tensor_adjunction_on_id_hom_ba_rows := InternalHomToTensorProductAdjunctionMap( b_rows, a_rows, id_hom_ba_rows );;
gap> hom_to_tensor_adjunction_on_id_hom_cd_rows := InternalHomToTensorProductAdjunctionMap( c_rows, d_rows, id_hom_cd_rows );;
gap> hom_to_tensor_adjunction_on_id_hom_dc_rows := InternalHomToTensorProductAdjunctionMap( d_rows, c_rows, id_hom_dc_rows );;

gap> hom_to_tensor_adjunction_on_id_hom_0a_rows := InternalHomToTensorProductAdjunctionMap( 0_rows, a_rows, id_hom_0a_rows );;
gap> hom_to_tensor_adjunction_on_id_hom_a0_rows := InternalHomToTensorProductAdjunctionMap( a_rows, 0_rows, id_hom_a0_rows );;

gap> tensor_to_cohom_adjunction_on_id_a_tensor_b_rows := TensorProductToInternalCoHomAdjunctionMap( a_rows, b_rows, id_a_tensor_b_rows );;
gap> tensor_to_cohom_adjunction_on_id_b_tensor_a_rows := TensorProductToInternalCoHomAdjunctionMap( b_rows, a_rows, id_b_tensor_a_rows );;
gap> tensor_to_cohom_adjunction_on_id_c_tensor_d_rows := TensorProductToInternalCoHomAdjunctionMap( c_rows, d_rows, id_c_tensor_d_rows );;
gap> tensor_to_cohom_adjunction_on_id_d_tensor_c_rows := TensorProductToInternalCoHomAdjunctionMap( d_rows, c_rows, id_d_tensor_c_rows );;

gap> tensor_to_cohom_adjunction_on_id_0_tensor_a_rows := TensorProductToInternalCoHomAdjunctionMap( 0_rows, a_rows, id_0_tensor_a_rows );;
gap> tensor_to_cohom_adjunction_on_id_a_tensor_0_rows := TensorProductToInternalCoHomAdjunctionMap( a_rows, 0_rows, id_a_tensor_0_rows );;

gap> cohom_to_tensor_adjunction_on_id_cohom_ab_rows := InternalCoHomToTensorProductAdjunctionMap( a_rows, b_rows, id_cohom_ab_rows );;
gap> cohom_to_tensor_adjunction_on_id_cohom_ba_rows := InternalCoHomToTensorProductAdjunctionMap( b_rows, a_rows, id_cohom_ba_rows );;
gap> cohom_to_tensor_adjunction_on_id_cohom_cd_rows := InternalCoHomToTensorProductAdjunctionMap( c_rows, d_rows, id_cohom_cd_rows );;
gap> cohom_to_tensor_adjunction_on_id_cohom_dc_rows := InternalCoHomToTensorProductAdjunctionMap( d_rows, c_rows, id_cohom_dc_rows );;

gap> cohom_to_tensor_adjunction_on_id_cohom_0a_rows := InternalCoHomToTensorProductAdjunctionMap( 0_rows, a_rows, id_cohom_0a_rows );;
gap> cohom_to_tensor_adjunction_on_id_cohom_a0_rows := InternalCoHomToTensorProductAdjunctionMap( a_rows, 0_rows, id_cohom_a0_rows );;

# Closed and coclosed structure for columns

gap> tensor_to_hom_adjunction_on_id_a_tensor_b_cols := TensorProductToInternalHomAdjunctionMap( a_cols, b_cols, id_a_tensor_b_cols );;
gap> tensor_to_hom_adjunction_on_id_b_tensor_a_cols := TensorProductToInternalHomAdjunctionMap( b_cols, a_cols, id_b_tensor_a_cols );;
gap> tensor_to_hom_adjunction_on_id_c_tensor_d_cols := TensorProductToInternalHomAdjunctionMap( c_cols, d_cols, id_c_tensor_d_cols );;
gap> tensor_to_hom_adjunction_on_id_d_tensor_c_cols := TensorProductToInternalHomAdjunctionMap( d_cols, c_cols, id_d_tensor_c_cols );;

gap> tensor_to_hom_adjunction_on_id_0_tensor_a_cols := TensorProductToInternalHomAdjunctionMap( 0_cols, a_cols, id_0_tensor_a_cols );;
gap> tensor_to_hom_adjunction_on_id_a_tensor_0_cols := TensorProductToInternalHomAdjunctionMap( a_cols, 0_cols, id_a_tensor_0_cols );;

gap> hom_to_tensor_adjunction_on_id_hom_ab_cols := InternalHomToTensorProductAdjunctionMap( a_cols, b_cols, id_hom_ab_cols );;
gap> hom_to_tensor_adjunction_on_id_hom_ba_cols := InternalHomToTensorProductAdjunctionMap( b_cols, a_cols, id_hom_ba_cols );;
gap> hom_to_tensor_adjunction_on_id_hom_cd_cols := InternalHomToTensorProductAdjunctionMap( c_cols, d_cols, id_hom_cd_cols );;
gap> hom_to_tensor_adjunction_on_id_hom_dc_cols := InternalHomToTensorProductAdjunctionMap( d_cols, c_cols, id_hom_dc_cols );;

gap> hom_to_tensor_adjunction_on_id_hom_0a_cols := InternalHomToTensorProductAdjunctionMap( 0_cols, a_cols, id_hom_0a_cols );;
gap> hom_to_tensor_adjunction_on_id_hom_a0_cols := InternalHomToTensorProductAdjunctionMap( a_cols, 0_cols, id_hom_a0_cols );;

gap> tensor_to_cohom_adjunction_on_id_a_tensor_b_cols := TensorProductToInternalCoHomAdjunctionMap( a_cols, b_cols, id_a_tensor_b_cols );;
gap> tensor_to_cohom_adjunction_on_id_b_tensor_a_cols := TensorProductToInternalCoHomAdjunctionMap( b_cols, a_cols, id_b_tensor_a_cols );;
gap> tensor_to_cohom_adjunction_on_id_c_tensor_d_cols := TensorProductToInternalCoHomAdjunctionMap( c_cols, d_cols, id_c_tensor_d_cols );;
gap> tensor_to_cohom_adjunction_on_id_d_tensor_c_cols := TensorProductToInternalCoHomAdjunctionMap( d_cols, c_cols, id_d_tensor_c_cols );;

gap> tensor_to_cohom_adjunction_on_id_0_tensor_a_cols := TensorProductToInternalCoHomAdjunctionMap( 0_cols, a_cols, id_0_tensor_a_cols );;
gap> tensor_to_cohom_adjunction_on_id_a_tensor_0_cols := TensorProductToInternalCoHomAdjunctionMap( a_cols, 0_cols, id_a_tensor_0_cols );;

gap> cohom_to_tensor_adjunction_on_id_cohom_ab_cols := InternalCoHomToTensorProductAdjunctionMap( a_cols, b_cols, id_cohom_ab_cols );;
gap> cohom_to_tensor_adjunction_on_id_cohom_ba_cols := InternalCoHomToTensorProductAdjunctionMap( b_cols, a_cols, id_cohom_ba_cols );;
gap> cohom_to_tensor_adjunction_on_id_cohom_cd_cols := InternalCoHomToTensorProductAdjunctionMap( c_cols, d_cols, id_cohom_cd_cols );;
gap> cohom_to_tensor_adjunction_on_id_cohom_dc_cols := InternalCoHomToTensorProductAdjunctionMap( d_cols, c_cols, id_cohom_dc_cols );;

gap> cohom_to_tensor_adjunction_on_id_cohom_0a_cols := InternalCoHomToTensorProductAdjunctionMap( 0_cols, a_cols, id_cohom_0a_cols );;
gap> cohom_to_tensor_adjunction_on_id_cohom_a0_cols := InternalCoHomToTensorProductAdjunctionMap( a_cols, 0_cols, id_cohom_a0_cols );;

# Opposite correspondence on adjunction maps

# ev = op( coclev ), arguments must be reversed for evaluations

gap> hom_to_tensor_adjunction_on_id_hom_ab_cols = Opposite( cohom_to_tensor_adjunction_on_id_cohom_ba_rows ); # Hom( a, b ) x a -> b  ==  op( b -> Cohom( b, a ) x a )
true
gap> hom_to_tensor_adjunction_on_id_hom_ba_cols = Opposite( cohom_to_tensor_adjunction_on_id_cohom_ab_rows ); # Hom( b, a ) x b -> a  ==  op( a -> Cohom( a, b ) x b )
true
gap> hom_to_tensor_adjunction_on_id_hom_cd_cols = Opposite( cohom_to_tensor_adjunction_on_id_cohom_dc_rows ); # Hom( c, d ) x c -> d  ==  op( d -> Cohom( d, c ) x c )
true
gap> hom_to_tensor_adjunction_on_id_hom_dc_cols = Opposite( cohom_to_tensor_adjunction_on_id_cohom_cd_rows ); # Hom( d, c ) x d -> c  ==  op( c -> Cohom( c, d ) x d )
true

gap> hom_to_tensor_adjunction_on_id_hom_0a_cols = Opposite( cohom_to_tensor_adjunction_on_id_cohom_a0_rows ); # Hom( 0, a ) x 0 -> a  ==  op( a -> Cohom( a, 0 ) x 0 )
true
gap> hom_to_tensor_adjunction_on_id_hom_a0_cols = Opposite( cohom_to_tensor_adjunction_on_id_cohom_0a_rows ); # Hom( a, 0 ) x a -> 0  ==  op( 0 -> Cohom( 0, a ) x a )
true

gap> ev_ab_cols = Opposite( cohom_to_tensor_adjunction_on_id_cohom_ba_rows );
true
gap> ev_ba_cols = Opposite( cohom_to_tensor_adjunction_on_id_cohom_ab_rows );
true
gap> ev_cd_cols = Opposite( cohom_to_tensor_adjunction_on_id_cohom_dc_rows );
true
gap> ev_dc_cols = Opposite( cohom_to_tensor_adjunction_on_id_cohom_cd_rows );
true

gap> ev_0a_cols = Opposite( cohom_to_tensor_adjunction_on_id_cohom_a0_rows );
true
gap> ev_a0_cols = Opposite( cohom_to_tensor_adjunction_on_id_cohom_0a_rows );
true

# coev = op( coclcoev )

gap> tensor_to_hom_adjunction_on_id_a_tensor_b_cols = Opposite( tensor_to_cohom_adjunction_on_id_a_tensor_b_rows ); # a -> Hom( b, a x b )  ==  op( Cohom( a x b, b) -> a )
true
gap> tensor_to_hom_adjunction_on_id_b_tensor_a_cols = Opposite( tensor_to_cohom_adjunction_on_id_b_tensor_a_rows ); # b -> Hom( a, b x a )  ==  op( Cohom( b x a, a) -> b )
true
gap> tensor_to_hom_adjunction_on_id_c_tensor_d_cols = Opposite( tensor_to_cohom_adjunction_on_id_c_tensor_d_rows ); # c -> Hom( d, c x d )  ==  op( Cohom( d x c, c) -> d )
true
gap> tensor_to_hom_adjunction_on_id_d_tensor_c_cols = Opposite( tensor_to_cohom_adjunction_on_id_d_tensor_c_rows ); # d -> Hom( c, d x c )  ==  op( Cohom( c x d, d) -> c )
true

gap> tensor_to_hom_adjunction_on_id_0_tensor_a_cols = Opposite( tensor_to_cohom_adjunction_on_id_0_tensor_a_rows ); # 0 -> Hom( a, 0 x a )  ==  op( Cohom( 0 x a, a) -> 0 )
true
gap> tensor_to_hom_adjunction_on_id_a_tensor_0_cols = Opposite( tensor_to_cohom_adjunction_on_id_a_tensor_0_rows ); # a -> Hom( 0, a x 0 )  ==  op( Cohom( a x 0, 0) -> a )
true

gap> coev_ab_cols = Opposite( tensor_to_cohom_adjunction_on_id_a_tensor_b_rows );
true
gap> coev_ba_cols = Opposite( tensor_to_cohom_adjunction_on_id_b_tensor_a_rows );
true
gap> coev_cd_cols = Opposite( tensor_to_cohom_adjunction_on_id_c_tensor_d_rows );
true
gap> coev_dc_cols = Opposite( tensor_to_cohom_adjunction_on_id_d_tensor_c_rows );
true

gap> coev_0a_cols = Opposite( tensor_to_cohom_adjunction_on_id_0_tensor_a_rows );
true
gap> coev_a0_cols = Opposite( tensor_to_cohom_adjunction_on_id_a_tensor_0_rows );
true

# coclev = op( ev ), arguments must be reversed for evaluations

gap> cohom_to_tensor_adjunction_on_id_cohom_ab_cols = Opposite( hom_to_tensor_adjunction_on_id_hom_ba_rows ); # a -> Cohom( a, b ) x b  ==  op( Hom( b, a ) x b -> a )
true
gap> cohom_to_tensor_adjunction_on_id_cohom_ba_cols = Opposite( hom_to_tensor_adjunction_on_id_hom_ab_rows ); # b -> Cohom( b, a ) x a  ==  op( Hom( a, b ) x a -> b )
true
gap> cohom_to_tensor_adjunction_on_id_cohom_cd_cols = Opposite( hom_to_tensor_adjunction_on_id_hom_dc_rows ); # c -> Cohom( c, d ) x d  ==  op( Hom( d, c ) x d -> c )
true
gap> cohom_to_tensor_adjunction_on_id_cohom_dc_cols = Opposite( hom_to_tensor_adjunction_on_id_hom_cd_rows ); # d -> Cohom( d, c ) x c  ==  op( Hom( c, d ) x c -> d )
true

gap> cohom_to_tensor_adjunction_on_id_cohom_0a_cols = Opposite( hom_to_tensor_adjunction_on_id_hom_a0_rows ); # 0 -> Cohom( 0, a ) x a  ==  op( Hom( a, 0 ) x a -> 0 )
true
gap> cohom_to_tensor_adjunction_on_id_cohom_a0_cols = Opposite( hom_to_tensor_adjunction_on_id_hom_0a_rows ); # a -> Cohom( a, 0 ) x 0  ==  op( Hom( 0, a ) x 0 -> a )
true

gap> cocl_ev_ab_cols = Opposite( hom_to_tensor_adjunction_on_id_hom_ba_rows );
true
gap> cocl_ev_ba_cols = Opposite( hom_to_tensor_adjunction_on_id_hom_ab_rows );
true
gap> cocl_ev_cd_cols = Opposite( hom_to_tensor_adjunction_on_id_hom_dc_rows );
true
gap> cocl_ev_dc_cols = Opposite( hom_to_tensor_adjunction_on_id_hom_cd_rows );
true

gap> cocl_ev_0a_cols = Opposite( hom_to_tensor_adjunction_on_id_hom_a0_rows );
true
gap> cocl_ev_a0_cols = Opposite( hom_to_tensor_adjunction_on_id_hom_0a_rows );
true

# coclcoev = op( coev )

gap> tensor_to_cohom_adjunction_on_id_a_tensor_b_cols = Opposite( tensor_to_hom_adjunction_on_id_a_tensor_b_rows ); # Cohom( a x b, b ) -> a  ==  op( a -> Hom( b, a x b ) )
true
gap> tensor_to_cohom_adjunction_on_id_b_tensor_a_cols = Opposite( tensor_to_hom_adjunction_on_id_b_tensor_a_rows ); # Cohom( b x a, a ) -> b  ==  op( b -> Hom( a, b x a ) )
true
gap> tensor_to_cohom_adjunction_on_id_c_tensor_d_cols = Opposite( tensor_to_hom_adjunction_on_id_c_tensor_d_rows ); # Cohom( c x d, d ) -> c  ==  op( c -> Hom( d, c x d ) )
true
gap> tensor_to_cohom_adjunction_on_id_d_tensor_c_cols = Opposite( tensor_to_hom_adjunction_on_id_d_tensor_c_rows ); # Cohom( d x c, c ) -> d  ==  op( d -> Hom( c, d x c ) )
true

gap> tensor_to_cohom_adjunction_on_id_0_tensor_a_cols = Opposite( tensor_to_hom_adjunction_on_id_0_tensor_a_rows ); # Cohom( 0 x a, a ) -> 0  ==  op( 0 -> Hom( a, 0 x a ) )
true
gap> tensor_to_cohom_adjunction_on_id_a_tensor_0_cols = Opposite( tensor_to_hom_adjunction_on_id_a_tensor_0_rows ); # Cohom( a x 0, 0 ) -> a  ==  op( a -> Hom( 0, a x 0 ) )
true

gap> cocl_coev_ab_cols = Opposite( tensor_to_hom_adjunction_on_id_a_tensor_b_rows );
true
gap> cocl_coev_ba_cols = Opposite( tensor_to_hom_adjunction_on_id_b_tensor_a_rows );
true
gap> cocl_coev_cd_cols = Opposite( tensor_to_hom_adjunction_on_id_c_tensor_d_rows );
true
gap> cocl_coev_dc_cols = Opposite( tensor_to_hom_adjunction_on_id_d_tensor_c_rows );
true

gap> cocl_coev_0a_cols = Opposite( tensor_to_hom_adjunction_on_id_0_tensor_a_rows );
true
gap> cocl_coev_a0_cols = Opposite( tensor_to_hom_adjunction_on_id_a_tensor_0_rows );
true

#####################################################
# Adjunction maps on non-identities
#####################################################

# Adjunction maps on tensored morphisms

gap> tensor_to_hom_adjunction_on_alpha_tensor_beta_rows := TensorProductToInternalHomAdjunctionMap( a_rows, c_rows, alpha_tensor_beta_rows );;
gap> tensor_to_hom_adjunction_on_beta_tensor_alpha_rows := TensorProductToInternalHomAdjunctionMap( c_rows, a_rows, beta_tensor_alpha_rows );;

gap> tensor_to_hom_adjunction_on_alpha_tensor_beta_cols := TensorProductToInternalHomAdjunctionMap( a_cols, c_cols, alpha_tensor_beta_cols );;
gap> tensor_to_hom_adjunction_on_beta_tensor_alpha_cols := TensorProductToInternalHomAdjunctionMap( c_cols, a_cols, beta_tensor_alpha_cols );;

gap> tensor_to_cohom_adjunction_on_alpha_tensor_beta_rows := TensorProductToInternalCoHomAdjunctionMap( a_rows, c_rows, alpha_tensor_beta_rows );;
gap> tensor_to_cohom_adjunction_on_beta_tensor_alpha_rows := TensorProductToInternalCoHomAdjunctionMap( c_rows, a_rows, beta_tensor_alpha_rows );;

gap> tensor_to_cohom_adjunction_on_alpha_tensor_beta_cols := TensorProductToInternalCoHomAdjunctionMap( a_cols, c_cols, alpha_tensor_beta_cols );;
gap> tensor_to_cohom_adjunction_on_beta_tensor_alpha_cols := TensorProductToInternalCoHomAdjunctionMap( c_cols, a_cols, beta_tensor_alpha_cols );;

# Adjunction maps on internal (co)hom morphisms

gap> hom_to_tensor_adjunction_on_hom_alpha_beta_rows := InternalHomToTensorProductAdjunctionMap( a_rows, d_rows, hom_alpha_beta_rows );;
gap> hom_to_tensor_adjunction_on_hom_beta_alpha_rows := InternalHomToTensorProductAdjunctionMap( c_rows, b_rows, hom_beta_alpha_rows );;

gap> hom_to_tensor_adjunction_on_hom_alpha_beta_cols := InternalHomToTensorProductAdjunctionMap( b_cols, c_cols, hom_alpha_beta_cols );;
gap> hom_to_tensor_adjunction_on_hom_beta_alpha_cols := InternalHomToTensorProductAdjunctionMap( d_cols, a_cols, hom_beta_alpha_cols );;

gap> cohom_to_tensor_adjunction_on_cohom_alpha_beta_rows := InternalCoHomToTensorProductAdjunctionMap( a_rows, d_rows, cohom_alpha_beta_rows );;
gap> cohom_to_tensor_adjunction_on_cohom_beta_alpha_rows := InternalCoHomToTensorProductAdjunctionMap( c_rows, b_rows, cohom_beta_alpha_rows );;

gap> cohom_to_tensor_adjunction_on_cohom_alpha_beta_cols := InternalCoHomToTensorProductAdjunctionMap( b_cols, c_cols, cohom_alpha_beta_cols );;
gap> cohom_to_tensor_adjunction_on_cohom_beta_alpha_cols := InternalCoHomToTensorProductAdjunctionMap( d_cols, a_cols, cohom_beta_alpha_cols );;

# Opposite correspondence on adjunction maps on tensor products

##########################################
#                                        #
# alpha_rows: a -> b                     #
# beta_rows:  c -> d                     #
#                                        #
# alpha_tensor_beta_rows: a x c -> b x d #
# beta_tensor_alpha_rows: c x a -> d x b #
#                                        #
##########################################
#                                        #
# alpha_cols: b -> a                     #
# beta_cols:  d -> c                     #
#                                        #
# alpha_tensor_beta_cols: b x d -> a x c #
# beta_tensor_alpha_cols: d x b -> c x a #
#                                        #
##########################################

gap> tensor_to_hom_adjunction_on_alpha_tensor_beta_cols = Opposite( tensor_to_cohom_adjunction_on_alpha_tensor_beta_rows ); # b -> Hom( d, a x c )  ==  op( Cohom( a x c, d ) -> b )
true
gap> tensor_to_hom_adjunction_on_beta_tensor_alpha_cols = Opposite( tensor_to_cohom_adjunction_on_beta_tensor_alpha_rows ); # d -> Hom( b, c x a )  ==  op( Cohom( c x a, b ) -> d )
true

gap> tensor_to_cohom_adjunction_on_alpha_tensor_beta_cols = Opposite( tensor_to_hom_adjunction_on_alpha_tensor_beta_rows ); # Cohom( b x d, c ) -> a  ==  op( a -> Hom( c, b x d ) )
true
gap> tensor_to_cohom_adjunction_on_beta_tensor_alpha_cols = Opposite( tensor_to_hom_adjunction_on_beta_tensor_alpha_rows ); # Cohom( d x b, a ) -> c  ==  op( c -> Hom( a, d x b ) )
true

# Opposite correspondence on adjunction maps on internal (co)homs

#########################################################
#                                                       #
#   hom_alpha_beta_rows: Hom( b, c ) -> Hom( a, d )     #
#   hom_beta_alpha_rows: Hom( d, a ) -> Hom( c, b )     #
#                                                       #
#   hom_alpha_beta_cols: Hom( a, d ) -> Hom( b, c )     #
#   hom_beta_alpha_cols: Hom( c, b ) -> Hom( d, a )     #
#                                                       #
#########################################################
#                                                       #
# cohom_alpha_beta_rows: Cohom( a, d ) -> Cohom( b, c ) #
# cohom_beta_alpha_rows: Cohom( c, b ) -> Cohom( d, a ) #
#                                                       #
# cohom_alpha_beta_cols: Cohom( b, c ) -> Cohom( a, d ) #
# cohom_beta_alpha_cols: Cohom( d, a ) -> Cohom( c, b ) #
#                                                       #
#########################################################

gap> hom_to_tensor_adjunction_on_hom_alpha_beta_cols = Opposite( cohom_to_tensor_adjunction_on_cohom_beta_alpha_rows ); # Hom( a, d ) x b -> c  ==  op( c -> Cohom( d, a ) x b )
true
gap> hom_to_tensor_adjunction_on_hom_beta_alpha_cols = Opposite( cohom_to_tensor_adjunction_on_cohom_alpha_beta_rows ); # Hom( c, b ) x d -> a  ==  op( a -> Cohom( b, c ) x d )
true

gap> cohom_to_tensor_adjunction_on_cohom_alpha_beta_cols = Opposite( hom_to_tensor_adjunction_on_hom_beta_alpha_rows ); # b -> Cohom( a, d ) x c  ==  op( Hom( d, a ) x c -> b )
true
gap> cohom_to_tensor_adjunction_on_cohom_beta_alpha_cols = Opposite( hom_to_tensor_adjunction_on_hom_alpha_beta_rows ); # d -> Cohom( c, b ) x a  ==  op( Hom( b, c ) x a -> d )
true

#####################################################
# Pre and post (co)composition
#####################################################

# PreCompose and PreCoCompose

gap> precompose_abc_rows := MonoidalPreComposeMorphism( a_rows, b_rows, c_rows );;
gap> precompose_cba_rows := MonoidalPreComposeMorphism( c_rows, b_rows, a_rows );;

gap> precompose_abc_cols := MonoidalPreComposeMorphism( a_cols, b_cols, c_cols );;
gap> precompose_cba_cols := MonoidalPreComposeMorphism( c_cols, b_cols, a_cols );;

gap> precocompose_abc_rows := MonoidalPreCoComposeMorphism( a_rows, b_rows, c_rows );;
gap> precocompose_cba_rows := MonoidalPreCoComposeMorphism( c_rows, b_rows, a_rows );;

gap> precocompose_abc_cols := MonoidalPreCoComposeMorphism( a_cols, b_cols, c_cols );;
gap> precocompose_cba_cols := MonoidalPreCoComposeMorphism( c_cols, b_cols, a_cols );;

# PostCompose and PostCoCompose

gap> postcompose_abc_rows := MonoidalPostComposeMorphism( a_rows, b_rows, c_rows );;
gap> postcompose_cba_rows := MonoidalPostComposeMorphism( c_rows, b_rows, a_rows );;

gap> postcompose_abc_cols := MonoidalPostComposeMorphism( a_cols, b_cols, c_cols );;
gap> postcompose_cba_cols := MonoidalPostComposeMorphism( c_cols, b_cols, a_cols );;

gap> postcocompose_abc_rows := MonoidalPostCoComposeMorphism( a_rows, b_rows, c_rows );;
gap> postcocompose_cba_rows := MonoidalPostCoComposeMorphism( c_rows, b_rows, a_rows );;

gap> postcocompose_abc_cols := MonoidalPostCoComposeMorphism( a_cols, b_cols, c_cols );;
gap> postcocompose_cba_cols := MonoidalPostCoComposeMorphism( c_cols, b_cols, a_cols );;

# Opposite correspondence on compositions

gap> precompose_abc_cols = Opposite( precocompose_cba_rows );
true
gap> precompose_cba_cols = Opposite( precocompose_abc_rows );
true

gap> precocompose_abc_cols = Opposite( precompose_cba_rows );
true
gap> precocompose_cba_cols = Opposite( precompose_abc_rows );
true

gap> postcompose_abc_cols = Opposite( postcocompose_cba_rows );
true
gap> postcompose_cba_cols = Opposite( postcocompose_abc_rows );
true

gap> postcocompose_abc_cols = Opposite( postcompose_cba_rows );
true
gap> postcocompose_cba_cols = Opposite( postcompose_abc_rows );
true

#####################################################
# (Co)Duals
#####################################################

# Dual objects

gap> a_dual_rows := DualOnObjects( a_rows );;
gap> b_dual_rows := DualOnObjects( b_rows );;

gap> a_dual_cols := DualOnObjects( a_cols );;
gap> b_dual_cols := DualOnObjects( b_cols );;

# CoDual objects

gap> a_codual_rows := CoDualOnObjects( a_rows );;
gap> b_codual_rows := CoDualOnObjects( b_rows );;

gap> a_codual_cols := CoDualOnObjects( a_cols );;
gap> b_codual_cols := CoDualOnObjects( b_cols );;

# (Co)Dual morphisms for rows

gap> dual_id_a_tensor_b_rows := DualOnMorphisms( id_a_tensor_b_rows );;
gap> dual_id_b_tensor_a_rows := DualOnMorphisms( id_b_tensor_a_rows );;

gap> dual_hom_alpha_beta_rows := DualOnMorphisms( hom_alpha_beta_rows );;
gap> dual_hom_beta_alpha_rows := DualOnMorphisms( hom_beta_alpha_rows );;

gap> dual_coev_ab_rows := DualOnMorphisms( coev_ab_rows );;
gap> dual_coev_ba_rows := DualOnMorphisms( coev_ba_rows );;

gap> codual_id_a_tensor_b_rows := CoDualOnMorphisms( id_a_tensor_b_rows );;
gap> codual_id_b_tensor_a_rows := CoDualOnMorphisms( id_b_tensor_a_rows );;

gap> codual_cohom_alpha_beta_rows := CoDualOnMorphisms( cohom_alpha_beta_rows );;
gap> codual_cohom_beta_alpha_rows := CoDualOnMorphisms( cohom_beta_alpha_rows );;

gap> codual_cocl_coev_ab_rows := CoDualOnMorphisms( cocl_coev_ab_rows );;
gap> codual_cocl_coev_ba_rows := CoDualOnMorphisms( cocl_coev_ba_rows );;

# (Co)Dual morphisms for cols

gap> dual_id_a_tensor_b_cols := DualOnMorphisms( id_a_tensor_b_cols );;
gap> dual_id_b_tensor_a_cols := DualOnMorphisms( id_b_tensor_a_cols );;

gap> dual_hom_alpha_beta_cols := DualOnMorphisms( hom_alpha_beta_cols );;
gap> dual_hom_beta_alpha_cols := DualOnMorphisms( hom_beta_alpha_cols );;

gap> dual_coev_ab_cols := DualOnMorphisms( coev_ab_cols );;
gap> dual_coev_ba_cols := DualOnMorphisms( coev_ba_cols );;

gap> codual_id_a_tensor_b_cols := CoDualOnMorphisms( id_a_tensor_b_cols );;
gap> codual_id_b_tensor_a_cols := CoDualOnMorphisms( id_b_tensor_a_cols );;

gap> codual_cohom_alpha_beta_cols := CoDualOnMorphisms( cohom_alpha_beta_cols );;
gap> codual_cohom_beta_alpha_cols := CoDualOnMorphisms( cohom_beta_alpha_cols );;

gap> codual_cocl_coev_ab_cols := CoDualOnMorphisms( cocl_coev_ab_cols );;
gap> codual_cocl_coev_ba_cols := CoDualOnMorphisms( cocl_coev_ba_cols );;

# Opposite correspondence on duals

gap> a_dual_cols = Opposite( a_codual_rows );
true
gap> b_dual_cols = Opposite( b_codual_rows );
true

gap> dual_id_a_tensor_b_cols = Opposite( codual_id_a_tensor_b_rows );
true
gap> dual_id_b_tensor_a_cols = Opposite( codual_id_b_tensor_a_rows );
true

gap> dual_hom_alpha_beta_cols = Opposite( codual_cohom_beta_alpha_rows );
true
gap> dual_hom_beta_alpha_cols = Opposite( codual_cohom_alpha_beta_rows );
true

gap> dual_coev_ab_cols = Opposite( codual_cocl_coev_ab_rows );
true
gap> dual_coev_ba_cols = Opposite( codual_cocl_coev_ba_rows );
true

# Opposite correspondence on coduals

gap> a_codual_cols = Opposite( a_dual_rows );
true
gap> b_codual_cols = Opposite( b_dual_rows );
true

gap> codual_id_a_tensor_b_cols = Opposite( id_a_tensor_b_rows );
true
gap> codual_id_b_tensor_a_cols = Opposite( id_b_tensor_a_rows );
true

gap> codual_cohom_beta_alpha_cols = Opposite( dual_hom_alpha_beta_rows );
true
gap> codual_cohom_alpha_beta_cols = Opposite( dual_hom_beta_alpha_rows );
true

gap> codual_cocl_coev_ab_cols = Opposite( dual_coev_ab_rows );
true
gap> codual_cocl_coev_ba_cols = Opposite( dual_coev_ba_rows );
true

#####################################################
# Evaluation for (co)dual
#####################################################

gap> ev_for_dual_a_rows := EvaluationForDual( a_rows );;
gap> ev_for_dual_b_rows := EvaluationForDual( b_rows );;
gap> ev_for_dual_0_rows := EvaluationForDual( 0_rows );;

gap> cocl_ev_for_codual_a_rows := CoclosedEvaluationForCoDual( a_rows );;
gap> cocl_ev_for_codual_b_rows := CoclosedEvaluationForCoDual( b_rows );;
gap> cocl_ev_for_codual_0_rows := CoclosedEvaluationForCoDual( 0_rows );;

gap> ev_for_dual_a_cols := EvaluationForDual( a_cols );;
gap> ev_for_dual_b_cols := EvaluationForDual( b_cols );;
gap> ev_for_dual_0_cols := EvaluationForDual( 0_cols );;

gap> cocl_ev_for_codual_a_cols := CoclosedEvaluationForCoDual( a_cols );;
gap> cocl_ev_for_codual_b_cols := CoclosedEvaluationForCoDual( b_cols );;
gap> cocl_ev_for_codual_0_cols := CoclosedEvaluationForCoDual( 0_cols );;

# Opposite correspondence

gap> ev_for_dual_a_cols = Opposite( cocl_ev_for_codual_a_rows );
true
gap> ev_for_dual_b_cols = Opposite( cocl_ev_for_codual_b_rows );
true
gap> ev_for_dual_0_cols = Opposite( cocl_ev_for_codual_0_rows );
true

gap> cocl_ev_for_codual_a_cols = Opposite( ev_for_dual_a_rows );
true
gap> cocl_ev_for_codual_b_cols = Opposite( ev_for_dual_b_rows );
true
gap> cocl_ev_for_codual_0_cols = Opposite( ev_for_dual_0_rows );
true

gap> ev_for_dual_a_cols = Opposite( cocl_ev_for_codual_b_rows );
false
gap> ev_for_dual_b_cols = Opposite( cocl_ev_for_codual_a_rows );
false
gap> ev_for_dual_0_cols = Opposite( cocl_ev_for_codual_a_rows );
false

gap> cocl_ev_for_codual_a_cols = Opposite( ev_for_dual_b_rows );
false
gap> cocl_ev_for_codual_b_cols = Opposite( ev_for_dual_a_rows );
false
gap> cocl_ev_for_codual_0_cols = Opposite( ev_for_dual_b_rows );
false

#####################################################
# (Co)Bidual
#####################################################

# Morphism to bidual

gap> morphism_to_bidual_c_rows := MorphismToBidual( c_rows );;
gap> morphism_to_bidual_d_rows := MorphismToBidual( d_rows );;

gap> morphism_to_bidual_c_cols := MorphismToBidual( c_cols );;
gap> morphism_to_bidual_d_cols := MorphismToBidual( d_cols );;

# Morphism from cobidual

gap> morphism_from_cobidual_c_rows := MorphismFromCoBidual( c_rows );;
gap> morphism_from_cobidual_d_rows := MorphismFromCoBidual( d_rows );;

gap> morphism_from_cobidual_c_cols := MorphismFromCoBidual( c_cols );;
gap> morphism_from_cobidual_d_cols := MorphismFromCoBidual( d_cols );;

# Opposite correspondence

gap> morphism_to_bidual_c_cols = Opposite( morphism_from_cobidual_c_rows );
true
gap> morphism_to_bidual_d_cols = Opposite( morphism_from_cobidual_d_rows );
true

gap> morphism_from_cobidual_c_cols = Opposite( morphism_to_bidual_c_rows );
true
gap> morphism_from_cobidual_d_cols = Opposite( morphism_to_bidual_d_rows );
true

gap> morphism_to_bidual_c_cols = Opposite( morphism_from_cobidual_d_rows );
false
gap> morphism_to_bidual_d_cols = Opposite( morphism_from_cobidual_c_rows );
false

gap> morphism_from_cobidual_c_cols = Opposite( morphism_to_bidual_d_rows );
false
gap> morphism_from_cobidual_d_cols = Opposite( morphism_to_bidual_c_rows );
false

#############################################################
# Tensor product and internal (co)hom compatibility
#############################################################

gap> tensor_to_hom_compatibility_abcd_rows := TensorProductInternalHomCompatibilityMorphism( [ a_rows, b_rows, c_rows, d_rows ] );; # Hom( a, b ) x Hom( c, d ) -> Hom( a x c, b x d )
gap> tensor_to_hom_compatibility_cadb_rows := TensorProductInternalHomCompatibilityMorphism( [ c_rows, a_rows, d_rows, b_rows ] );; # Hom( c, a ) x Hom( d, b ) -> Hom( c x d, a x b )

gap> cohom_to_tensor_compatibility_abcd_rows := InternalCoHomTensorProductCompatibilityMorphism( [ a_rows, b_rows, c_rows, d_rows ] );; # Cohom( a x b, c x d ) -> Cohom( a, c ) x Cohom( b, d )
gap> cohom_to_tensor_compatibility_bdac_rows := InternalCoHomTensorProductCompatibilityMorphism( [ b_rows, d_rows, a_rows, c_rows ] );; # Cohom( b x d, a x c ) -> Cohom( b, a ) x Cohom( d, c )

gap> tensor_to_hom_compatibility_abcd_cols := TensorProductInternalHomCompatibilityMorphism( [ a_cols, b_cols, c_cols, d_cols ] );; # Hom( a, b ) x Hom( c, d ) -> Hom( a x c, b x d )
gap> tensor_to_hom_compatibility_cadb_cols := TensorProductInternalHomCompatibilityMorphism( [ c_cols, a_cols, d_cols, b_cols ] );; # Hom( c, a ) x Hom( d, b ) -> Hom( c x d, a x b )

gap> cohom_to_tensor_compatibility_abcd_cols := InternalCoHomTensorProductCompatibilityMorphism( [ a_cols, b_cols, c_cols, d_cols ] );; # Cohom( a x b, c x d ) -> Cohom( a, c ) x Cohom( b, d )
gap> cohom_to_tensor_compatibility_bdac_cols := InternalCoHomTensorProductCompatibilityMorphism( [ b_cols, d_cols, a_cols, c_cols ] );; # Cohom( b x d, a x c ) -> Cohom( b, a ) x Cohom( d, c )

# Opposite correspondence

gap> tensor_to_hom_compatibility_abcd_cols = Opposite( cohom_to_tensor_compatibility_bdac_rows ); # Hom( a, b ) x Hom( c, d ) -> Hom( a x c, b x d )  ==  op( Cohom( b x d, a x c ) -> Cohom( b, a ) x Cohom( d, c ) )
true
gap> tensor_to_hom_compatibility_cadb_cols = Opposite( cohom_to_tensor_compatibility_abcd_rows ); # Hom( c, a ) x Hom( d, b ) -> Hom( c x d, a x b )  ==  op( Cohom( a x b, c x d ) -> Cohom( a, c ) x Cohom( b, d ) )
true

gap> cohom_to_tensor_compatibility_abcd_cols = Opposite( tensor_to_hom_compatibility_cadb_rows ); # Cohom( a x b, c x d ) -> Cohom( a, c ) x Cohom( b, d )  ==  op( Hom( c, a ) x Hom( d, b ) -> Hom( c x d, a x b ) )
true
gap> cohom_to_tensor_compatibility_bdac_cols = Opposite( tensor_to_hom_compatibility_abcd_rows ); # Cohom( b x d, a x c ) -> Cohom( b, a ) x Cohom( d, c )  ==  op( Hom( a, b ) x Hom( c, d ) -> Hom( a x c, b x d ) )
true

gap> tensor_to_hom_compatibility_abcd_cols = Opposite( cohom_to_tensor_compatibility_abcd_rows ); # Hom( a, b ) x Hom( c, d ) -> Hom( a x c, b x d )  =/=  op( Cohom( a x b, c x d ) -> Cohom( a, c ) x Cohom( b, d ) )
false
gap> tensor_to_hom_compatibility_cadb_cols = Opposite( cohom_to_tensor_compatibility_bdac_rows ); # Hom( c, a ) x Hom( d, b ) -> Hom( c x d, a x b )  =/=  op( Cohom( b x d, a x c ) -> Cohom( b, a ) x Cohom( d, c ) )
false

gap> cohom_to_tensor_compatibility_abcd_cols = Opposite( tensor_to_hom_compatibility_abcd_rows ); # Cohom( a x b, c x d ) -> Cohom( a, c ) x Cohom( b, d )  =/=  op( Hom( a, b ) x Hom( c, d ) -> Hom( a x c, b x d ) )
false
gap> cohom_to_tensor_compatibility_bdac_cols = Opposite( tensor_to_hom_compatibility_cadb_rows ); # Cohom( b x d, a x c ) -> Cohom( b, a ) x Cohom( d, c )  =/=  op( Hom( c, a ) x Hom( d, b ) -> Hom( c x d, a x b ) )
false

#########################################################
# Tensor product duality compatibility
#########################################################

# (Co)Duality compatibility

gap> tensor_product_duality_compatibility_ab_rows := TensorProductDualityCompatibilityMorphism( a_rows, b_rows );; # a^v x b^v -> (a x b)^v
gap> tensor_product_duality_compatibility_ba_rows := TensorProductDualityCompatibilityMorphism( b_rows, a_rows );; # b^v x a^v -> (b x a)^v
gap> tensor_product_duality_compatibility_cd_rows := TensorProductDualityCompatibilityMorphism( c_rows, d_rows );; # c^v x d^v -> (c x d)^v
gap> tensor_product_duality_compatibility_dc_rows := TensorProductDualityCompatibilityMorphism( d_rows, c_rows );; # d^v x c^v -> (d x c)^v

gap> coduality_tensor_product_compatibility_ab_rows := CoDualityTensorProductCompatibilityMorphism( a_rows, b_rows );; # (a x b)_v -> a_v x b_v
gap> coduality_tensor_product_compatibility_ba_rows := CoDualityTensorProductCompatibilityMorphism( b_rows, a_rows );; # (b x a)_v -> b_v x a_v
gap> coduality_tensor_product_compatibility_cd_rows := CoDualityTensorProductCompatibilityMorphism( c_rows, d_rows );; # (c x d)_v -> c_v x d_v
gap> coduality_tensor_product_compatibility_dc_rows := CoDualityTensorProductCompatibilityMorphism( d_rows, c_rows );; # (d x c)_v -> d_v x c_v

gap> tensor_product_duality_compatibility_ab_cols := TensorProductDualityCompatibilityMorphism( a_cols, b_cols );; # a^v x b^v -> (a x b)^v
gap> tensor_product_duality_compatibility_ba_cols := TensorProductDualityCompatibilityMorphism( b_cols, a_cols );; # b^v x a^v -> (b x a)^v
gap> tensor_product_duality_compatibility_cd_cols := TensorProductDualityCompatibilityMorphism( c_cols, d_cols );; # c^v x d^v -> (c x d)^v
gap> tensor_product_duality_compatibility_dc_cols := TensorProductDualityCompatibilityMorphism( d_cols, c_cols );; # d^v x c^v -> (d x c)^v

gap> coduality_tensor_product_compatibility_ab_cols := CoDualityTensorProductCompatibilityMorphism( a_cols, b_cols );; # (a x b)_v -> a_v x b_v
gap> coduality_tensor_product_compatibility_ba_cols := CoDualityTensorProductCompatibilityMorphism( b_cols, a_cols );; # (b x a)_v -> b_v x a_v
gap> coduality_tensor_product_compatibility_cd_cols := CoDualityTensorProductCompatibilityMorphism( c_cols, d_cols );; # (c x d)_v -> c_v x d_v
gap> coduality_tensor_product_compatibility_dc_cols := CoDualityTensorProductCompatibilityMorphism( d_cols, c_cols );; # (d x c)_v -> d_v x c_v

# Tensor product internal (co)hom compatibility with units

gap> tensor_product_to_hom_compatibility_a1b1_rows := TensorProductInternalHomCompatibilityMorphism( [ a_rows, 1_rows, b_rows, 1_rows ] );; # Hom( a, 1 ) x Hom( b, 1 ) -> Hom( a x b, 1 x 1 )
gap> tensor_product_to_hom_compatibility_b1a1_rows := TensorProductInternalHomCompatibilityMorphism( [ b_rows, 1_rows, a_rows, 1_rows ] );; # Hom( b, 1 ) x Hom( a, 1 ) -> Hom( b x a, 1 x 1 )
gap> tensor_product_to_hom_compatibility_c1d1_rows := TensorProductInternalHomCompatibilityMorphism( [ c_rows, 1_rows, d_rows, 1_rows ] );; # Hom( c, 1 ) x Hom( d, 1 ) -> Hom( c x d, 1 x 1 )
gap> tensor_product_to_hom_compatibility_d1c1_rows := TensorProductInternalHomCompatibilityMorphism( [ d_rows, 1_rows, c_rows, 1_rows ] );; # Hom( d, 1 ) x Hom( c, 1 ) -> Hom( d x c, 1 x 1 )

gap> cohom_to_tensor_product_compatibility_1a1b_rows := InternalCoHomTensorProductCompatibilityMorphism( [ 1_rows, a_rows, 1_rows, b_rows ] );; # Cohom( 1 x a, 1 x b ) -> Cohom( 1, a ) x Cohom( 1, b )
gap> cohom_to_tensor_product_compatibility_1b1a_rows := InternalCoHomTensorProductCompatibilityMorphism( [ 1_rows, b_rows, 1_rows, a_rows ] );; # Cohom( 1 x b, 1 x a ) -> Cohom( 1, b ) x Cohom( 1, a )
gap> cohom_to_tensor_product_compatibility_1c1d_rows := InternalCoHomTensorProductCompatibilityMorphism( [ 1_rows, c_rows, 1_rows, d_rows ] );; # Cohom( 1 x c, 1 x d ) -> Cohom( 1, c ) x Cohom( 1, d )
gap> cohom_to_tensor_product_compatibility_1d1c_rows := InternalCoHomTensorProductCompatibilityMorphism( [ 1_rows, d_rows, 1_rows, c_rows ] );; # Cohom( 1 x d, 1 x c ) -> Cohom( 1, d ) x Cohom( 1, c )

gap> tensor_product_to_hom_compatibility_a1b1_cols := TensorProductInternalHomCompatibilityMorphism( [ a_cols, 1_cols, b_cols, 1_cols ] );; # Hom( a, 1 ) x Hom( b, 1 ) -> Hom( a x b, 1 x 1 )
gap> tensor_product_to_hom_compatibility_b1a1_cols := TensorProductInternalHomCompatibilityMorphism( [ b_cols, 1_cols, a_cols, 1_cols ] );; # Hom( b, 1 ) x Hom( a, 1 ) -> Hom( b x a, 1 x 1 )
gap> tensor_product_to_hom_compatibility_c1d1_cols := TensorProductInternalHomCompatibilityMorphism( [ c_cols, 1_cols, d_cols, 1_cols ] );; # Hom( c, 1 ) x Hom( d, 1 ) -> Hom( c x d, 1 x 1 )
gap> tensor_product_to_hom_compatibility_d1c1_cols := TensorProductInternalHomCompatibilityMorphism( [ d_cols, 1_cols, c_cols, 1_cols ] );; # Hom( d, 1 ) x Hom( c, 1 ) -> Hom( d x c, 1 x 1 )

gap> cohom_to_tensor_product_compatibility_1a1b_cols := InternalCoHomTensorProductCompatibilityMorphism( [ 1_cols, a_cols, 1_cols, b_cols ] );; # Cohom( 1 x a, 1 x b ) -> Cohom( 1, a ) x Cohom( 1, b )
gap> cohom_to_tensor_product_compatibility_1b1a_cols := InternalCoHomTensorProductCompatibilityMorphism( [ 1_cols, b_cols, 1_cols, a_cols ] );; # Cohom( 1 x b, 1 x a ) -> Cohom( 1, b ) x Cohom( 1, a )
gap> cohom_to_tensor_product_compatibility_1c1d_cols := InternalCoHomTensorProductCompatibilityMorphism( [ 1_cols, c_cols, 1_cols, d_cols ] );; # Cohom( 1 x c, 1 x d ) -> Cohom( 1, c ) x Cohom( 1, d )
gap> cohom_to_tensor_product_compatibility_1d1c_cols := InternalCoHomTensorProductCompatibilityMorphism( [ 1_cols, d_cols, 1_cols, c_cols ] );; # Cohom( 1 x d, 1 x c ) -> Cohom( 1, d ) x Cohom( 1, c )

# Opposite correspondence on (co)duality compatibility

gap> tensor_product_duality_compatibility_ab_cols = Opposite( coduality_tensor_product_compatibility_ab_rows );
true
gap> tensor_product_duality_compatibility_ba_cols = Opposite( coduality_tensor_product_compatibility_ba_rows );
true
gap> tensor_product_duality_compatibility_cd_cols = Opposite( coduality_tensor_product_compatibility_cd_rows );
true
gap> tensor_product_duality_compatibility_dc_cols = Opposite( coduality_tensor_product_compatibility_dc_rows );
true

gap> coduality_tensor_product_compatibility_ab_cols = Opposite( tensor_product_duality_compatibility_ab_rows );
true
gap> coduality_tensor_product_compatibility_ba_cols = Opposite( tensor_product_duality_compatibility_ba_rows );
true
gap> coduality_tensor_product_compatibility_cd_cols = Opposite( tensor_product_duality_compatibility_cd_rows );
true
gap> coduality_tensor_product_compatibility_dc_cols = Opposite( tensor_product_duality_compatibility_dc_rows );
true

gap> tensor_product_duality_compatibility_ab_cols = Opposite( coduality_tensor_product_compatibility_cd_rows );
false
gap> tensor_product_duality_compatibility_ab_cols = Opposite( coduality_tensor_product_compatibility_dc_rows );
false
gap> tensor_product_duality_compatibility_cd_cols = Opposite( coduality_tensor_product_compatibility_ab_rows );
false
gap> tensor_product_duality_compatibility_cd_cols = Opposite( coduality_tensor_product_compatibility_ba_rows );
false

gap> coduality_tensor_product_compatibility_ba_cols = Opposite( tensor_product_duality_compatibility_cd_rows );
false
gap> coduality_tensor_product_compatibility_ba_cols = Opposite( tensor_product_duality_compatibility_dc_rows );
false
gap> coduality_tensor_product_compatibility_dc_cols = Opposite( tensor_product_duality_compatibility_ab_rows );
false
gap> coduality_tensor_product_compatibility_dc_cols = Opposite( tensor_product_duality_compatibility_ba_rows );
false

# Opposite correspondence and consistency with internal (co)hom compatibility with units

gap> tensor_product_duality_compatibility_ab_cols = Opposite( cohom_to_tensor_product_compatibility_1a1b_rows );
true
gap> tensor_product_duality_compatibility_ba_cols = Opposite( cohom_to_tensor_product_compatibility_1b1a_rows );
true
gap> tensor_product_duality_compatibility_cd_cols = Opposite( cohom_to_tensor_product_compatibility_1c1d_rows );
true
gap> tensor_product_duality_compatibility_dc_cols = Opposite( cohom_to_tensor_product_compatibility_1d1c_rows );
true

gap> coduality_tensor_product_compatibility_ab_cols = Opposite( tensor_product_to_hom_compatibility_a1b1_rows );
true
gap> coduality_tensor_product_compatibility_ba_cols = Opposite( tensor_product_to_hom_compatibility_b1a1_rows );
true
gap> coduality_tensor_product_compatibility_cd_cols = Opposite( tensor_product_to_hom_compatibility_c1d1_rows );
true
gap> coduality_tensor_product_compatibility_dc_cols = Opposite( tensor_product_to_hom_compatibility_d1c1_rows );
true

gap> tensor_product_duality_compatibility_ba_cols = Opposite( cohom_to_tensor_product_compatibility_1c1d_rows );
false
gap> tensor_product_duality_compatibility_ba_cols = Opposite( cohom_to_tensor_product_compatibility_1d1c_rows );
false
gap> tensor_product_duality_compatibility_dc_cols = Opposite( cohom_to_tensor_product_compatibility_1a1b_rows );
false
gap> tensor_product_duality_compatibility_dc_cols = Opposite( cohom_to_tensor_product_compatibility_1b1a_rows );
false

gap> coduality_tensor_product_compatibility_ab_cols = Opposite( tensor_product_to_hom_compatibility_c1d1_rows );
false
gap> coduality_tensor_product_compatibility_ab_cols = Opposite( tensor_product_to_hom_compatibility_d1c1_rows );
false
gap> coduality_tensor_product_compatibility_cd_cols = Opposite( tensor_product_to_hom_compatibility_a1b1_rows );
false
gap> coduality_tensor_product_compatibility_cd_cols = Opposite( tensor_product_to_hom_compatibility_b1a1_rows );
false

#########################################################
# Morphism from tensor product to internal hom
#########################################################

# Morphism from tensor product to internal hom

gap> morphism_from_tensor_product_to_hom_ab_rows := MorphismFromTensorProductToInternalHom( a_rows, b_rows );;
gap> morphism_from_tensor_product_to_hom_ba_rows := MorphismFromTensorProductToInternalHom( b_rows, a_rows );;
gap> morphism_from_tensor_product_to_hom_cd_rows := MorphismFromTensorProductToInternalHom( c_rows, d_rows );;
gap> morphism_from_tensor_product_to_hom_dc_rows := MorphismFromTensorProductToInternalHom( d_rows, c_rows );;

gap> morphism_from_tensor_product_to_hom_ab_cols := MorphismFromTensorProductToInternalHom( a_cols, b_cols );;
gap> morphism_from_tensor_product_to_hom_ba_cols := MorphismFromTensorProductToInternalHom( b_cols, a_cols );;
gap> morphism_from_tensor_product_to_hom_cd_cols := MorphismFromTensorProductToInternalHom( c_cols, d_cols );;
gap> morphism_from_tensor_product_to_hom_dc_cols := MorphismFromTensorProductToInternalHom( d_cols, c_cols );;

# Morphism from internal cohom to tensor product

gap> morphism_from_cohom_to_tensor_product_ab_rows := MorphismFromInternalCoHomToTensorProduct( a_rows, b_rows );;
gap> morphism_from_cohom_to_tensor_product_ba_rows := MorphismFromInternalCoHomToTensorProduct( b_rows, a_rows );;
gap> morphism_from_cohom_to_tensor_product_cd_rows := MorphismFromInternalCoHomToTensorProduct( c_rows, d_rows );;
gap> morphism_from_cohom_to_tensor_product_dc_rows := MorphismFromInternalCoHomToTensorProduct( d_rows, c_rows );;

gap> morphism_from_cohom_to_tensor_product_ab_cols := MorphismFromInternalCoHomToTensorProduct( a_cols, b_cols );;
gap> morphism_from_cohom_to_tensor_product_ba_cols := MorphismFromInternalCoHomToTensorProduct( b_cols, a_cols );;
gap> morphism_from_cohom_to_tensor_product_cd_cols := MorphismFromInternalCoHomToTensorProduct( c_cols, d_cols );;
gap> morphism_from_cohom_to_tensor_product_dc_cols := MorphismFromInternalCoHomToTensorProduct( d_cols, c_cols );;

# Opposite correspondence

gap> morphism_from_tensor_product_to_hom_ab_cols = Opposite( morphism_from_cohom_to_tensor_product_ba_rows );
true
gap> morphism_from_tensor_product_to_hom_ba_cols = Opposite( morphism_from_cohom_to_tensor_product_ab_rows );
true
gap> morphism_from_tensor_product_to_hom_cd_cols = Opposite( morphism_from_cohom_to_tensor_product_cd_rows );
true
gap> morphism_from_tensor_product_to_hom_dc_cols = Opposite( morphism_from_cohom_to_tensor_product_dc_rows );
true

gap> morphism_from_cohom_to_tensor_product_ab_cols = Opposite( morphism_from_tensor_product_to_hom_ba_rows );
true
gap> morphism_from_cohom_to_tensor_product_ba_cols = Opposite( morphism_from_tensor_product_to_hom_ab_rows );
true
gap> morphism_from_cohom_to_tensor_product_cd_cols = Opposite( morphism_from_tensor_product_to_hom_dc_rows );
true
gap> morphism_from_cohom_to_tensor_product_dc_cols = Opposite( morphism_from_tensor_product_to_hom_cd_rows );
true

gap> morphism_from_tensor_product_to_hom_ba_cols = Opposite( morphism_from_tensor_product_to_hom_cd_rows );
false
gap> morphism_from_tensor_product_to_hom_ba_cols = Opposite( morphism_from_tensor_product_to_hom_dc_rows );
false

gap> morphism_from_tensor_product_to_hom_dc_cols = Opposite( morphism_from_tensor_product_to_hom_ab_rows );
false
gap> morphism_from_tensor_product_to_hom_dc_cols = Opposite( morphism_from_tensor_product_to_hom_ba_rows );
false

gap> morphism_from_cohom_to_tensor_product_ab_cols = Opposite( morphism_from_tensor_product_to_hom_cd_rows );
false
gap> morphism_from_cohom_to_tensor_product_ab_cols = Opposite( morphism_from_tensor_product_to_hom_dc_rows );
false

gap> morphism_from_cohom_to_tensor_product_cd_cols = Opposite( morphism_from_tensor_product_to_hom_ab_rows );
false
gap> morphism_from_cohom_to_tensor_product_cd_cols = Opposite( morphism_from_tensor_product_to_hom_ba_rows );
false

#########################################################
# Isomorphisms between dual and internal hom
#########################################################

# Isomorphism from dual to internal hom

gap> isomorphism_from_dual_to_hom_a_rows := IsomorphismFromDualToInternalHom( a_rows );;
gap> isomorphism_from_dual_to_hom_b_rows := IsomorphismFromDualToInternalHom( b_rows );;
gap> isomorphism_from_dual_to_hom_c_rows := IsomorphismFromDualToInternalHom( c_rows );;
gap> isomorphism_from_dual_to_hom_d_rows := IsomorphismFromDualToInternalHom( d_rows );;

gap> isomorphism_from_dual_to_hom_a_cols := IsomorphismFromDualToInternalHom( a_cols );;
gap> isomorphism_from_dual_to_hom_b_cols := IsomorphismFromDualToInternalHom( b_cols );;
gap> isomorphism_from_dual_to_hom_c_cols := IsomorphismFromDualToInternalHom( c_cols );;
gap> isomorphism_from_dual_to_hom_d_cols := IsomorphismFromDualToInternalHom( d_cols );;

# Isomorphism from internal hom to dual

gap> isomorphism_from_hom_to_dual_a_rows := IsomorphismFromInternalHomToDual( a_rows );;
gap> isomorphism_from_hom_to_dual_b_rows := IsomorphismFromInternalHomToDual( b_rows );;
gap> isomorphism_from_hom_to_dual_c_rows := IsomorphismFromInternalHomToDual( c_rows );;
gap> isomorphism_from_hom_to_dual_d_rows := IsomorphismFromInternalHomToDual( d_rows );;

gap> isomorphism_from_hom_to_dual_a_cols := IsomorphismFromInternalHomToDual( a_cols );;
gap> isomorphism_from_hom_to_dual_b_cols := IsomorphismFromInternalHomToDual( b_cols );;
gap> isomorphism_from_hom_to_dual_c_cols := IsomorphismFromInternalHomToDual( c_cols );;
gap> isomorphism_from_hom_to_dual_d_cols := IsomorphismFromInternalHomToDual( d_cols );;

# Isomorphism from codual to cohom

gap> isomorphism_from_codual_to_cohom_a_rows := IsomorphismFromCoDualToInternalCoHom( a_rows );;
gap> isomorphism_from_codual_to_cohom_b_rows := IsomorphismFromCoDualToInternalCoHom( b_rows );;
gap> isomorphism_from_codual_to_cohom_c_rows := IsomorphismFromCoDualToInternalCoHom( c_rows );;
gap> isomorphism_from_codual_to_cohom_d_rows := IsomorphismFromCoDualToInternalCoHom( d_rows );;

gap> isomorphism_from_codual_to_cohom_a_cols := IsomorphismFromCoDualToInternalCoHom( a_cols );;
gap> isomorphism_from_codual_to_cohom_b_cols := IsomorphismFromCoDualToInternalCoHom( b_cols );;
gap> isomorphism_from_codual_to_cohom_c_cols := IsomorphismFromCoDualToInternalCoHom( c_cols );;
gap> isomorphism_from_codual_to_cohom_d_cols := IsomorphismFromCoDualToInternalCoHom( d_cols );;

# Isomorphism from cohom to codual

gap> isomorphism_from_cohom_to_codual_a_rows := IsomorphismFromInternalCoHomToCoDual( a_rows );;
gap> isomorphism_from_cohom_to_codual_b_rows := IsomorphismFromInternalCoHomToCoDual( b_rows );;
gap> isomorphism_from_cohom_to_codual_c_rows := IsomorphismFromInternalCoHomToCoDual( c_rows );;
gap> isomorphism_from_cohom_to_codual_d_rows := IsomorphismFromInternalCoHomToCoDual( d_rows );;

gap> isomorphism_from_cohom_to_codual_a_cols := IsomorphismFromInternalCoHomToCoDual( a_cols );;
gap> isomorphism_from_cohom_to_codual_b_cols := IsomorphismFromInternalCoHomToCoDual( b_cols );;
gap> isomorphism_from_cohom_to_codual_c_cols := IsomorphismFromInternalCoHomToCoDual( c_cols );;
gap> isomorphism_from_cohom_to_codual_d_cols := IsomorphismFromInternalCoHomToCoDual( d_cols );;

# Opposite correspondence

gap> isomorphism_from_dual_to_hom_a_cols = Opposite( isomorphism_from_cohom_to_codual_a_rows );
true
gap> isomorphism_from_dual_to_hom_b_cols = Opposite( isomorphism_from_cohom_to_codual_b_rows );
true
gap> isomorphism_from_dual_to_hom_c_cols = Opposite( isomorphism_from_cohom_to_codual_c_rows );
true
gap> isomorphism_from_dual_to_hom_d_cols = Opposite( isomorphism_from_cohom_to_codual_d_rows );
true

gap> isomorphism_from_hom_to_dual_a_cols = Opposite( isomorphism_from_codual_to_cohom_a_rows );
true
gap> isomorphism_from_hom_to_dual_b_cols = Opposite( isomorphism_from_codual_to_cohom_b_rows );
true
gap> isomorphism_from_hom_to_dual_c_cols = Opposite( isomorphism_from_codual_to_cohom_c_rows );
true
gap> isomorphism_from_hom_to_dual_d_cols = Opposite( isomorphism_from_codual_to_cohom_d_rows );
true

gap> isomorphism_from_codual_to_cohom_a_cols = Opposite( isomorphism_from_hom_to_dual_a_rows );
true
gap> isomorphism_from_codual_to_cohom_b_cols = Opposite( isomorphism_from_hom_to_dual_b_rows );
true
gap> isomorphism_from_codual_to_cohom_c_cols = Opposite( isomorphism_from_hom_to_dual_c_rows );
true
gap> isomorphism_from_codual_to_cohom_d_cols = Opposite( isomorphism_from_hom_to_dual_d_rows );
true

gap> isomorphism_from_cohom_to_codual_a_cols = Opposite( isomorphism_from_dual_to_hom_a_rows );
true
gap> isomorphism_from_cohom_to_codual_b_cols = Opposite( isomorphism_from_dual_to_hom_b_rows );
true
gap> isomorphism_from_cohom_to_codual_c_cols = Opposite( isomorphism_from_dual_to_hom_c_rows );
true
gap> isomorphism_from_cohom_to_codual_d_cols = Opposite( isomorphism_from_dual_to_hom_d_rows );
true

gap> isomorphism_from_dual_to_hom_a_cols = Opposite( isomorphism_from_cohom_to_codual_b_rows );
false
gap> isomorphism_from_dual_to_hom_a_cols = Opposite( isomorphism_from_cohom_to_codual_c_rows );
false
gap> isomorphism_from_dual_to_hom_a_cols = Opposite( isomorphism_from_cohom_to_codual_d_rows );
false

gap> isomorphism_from_hom_to_dual_b_cols = Opposite( isomorphism_from_codual_to_cohom_a_rows );
false
gap> isomorphism_from_hom_to_dual_b_cols = Opposite( isomorphism_from_codual_to_cohom_c_rows );
false
gap> isomorphism_from_hom_to_dual_b_cols = Opposite( isomorphism_from_codual_to_cohom_d_rows );
false

gap> isomorphism_from_codual_to_cohom_c_cols = Opposite( isomorphism_from_hom_to_dual_a_rows );
false
gap> isomorphism_from_codual_to_cohom_c_cols = Opposite( isomorphism_from_hom_to_dual_b_rows );
false
gap> isomorphism_from_codual_to_cohom_c_cols = Opposite( isomorphism_from_hom_to_dual_d_rows );
false

gap> isomorphism_from_cohom_to_codual_d_cols = Opposite( isomorphism_from_dual_to_hom_a_rows );
false
gap> isomorphism_from_cohom_to_codual_d_cols = Opposite( isomorphism_from_dual_to_hom_b_rows );
false
gap> isomorphism_from_cohom_to_codual_d_cols = Opposite( isomorphism_from_dual_to_hom_c_rows );
false

#########################################################
# Universal property of dual
#########################################################

# Morphisms

gap> ab_to_1_rows := CategoryOfRowsMorphism( a_tensor_b_rows, HomalgMatrix( [ 2 .. 7], RankOfObject( a_tensor_b_rows ), 1, Q ), 1_rows );;
gap> cd_to_1_rows := CategoryOfRowsMorphism( c_tensor_d_rows, HomalgMatrix( [ 8 .. 31 ], RankOfObject( c_tensor_d_rows ), 1, Q ), 1_rows );;

gap> 1_to_ab_rows := CategoryOfRowsMorphism( 1_rows, HomalgMatrix( [ 2 .. 7], 1, RankOfObject( a_tensor_b_rows ), Q ), a_tensor_b_rows );;
gap> 1_to_cd_rows := CategoryOfRowsMorphism( 1_rows, HomalgMatrix( [ 8 .. 31 ], 1, RankOfObject( c_tensor_d_rows ), Q ), c_tensor_d_rows );;

gap> ab_to_1_cols := Opposite( 1_to_ab_rows );;
gap> cd_to_1_cols := Opposite( 1_to_cd_rows );;

gap> 1_to_ab_cols := Opposite( ab_to_1_rows );;
gap> 1_to_cd_cols := Opposite( cd_to_1_rows );;

# Universal property of dual

gap> universal_property_of_dual_ab_to_1_rows := UniversalPropertyOfDual( a_rows, b_rows, ab_to_1_rows );;
gap> universal_property_of_dual_cd_to_1_rows := UniversalPropertyOfDual( c_rows, d_rows, cd_to_1_rows );;

gap> universal_property_of_dual_ab_to_1_cols := UniversalPropertyOfDual( a_cols, b_cols, ab_to_1_cols );;
gap> universal_property_of_dual_cd_to_1_cols := UniversalPropertyOfDual( c_cols, d_cols, cd_to_1_cols );;

# Universal property of codual

gap> universal_property_of_codual_1_to_ab_rows := UniversalPropertyOfCoDual( a_rows, b_rows, 1_to_ab_rows );;
gap> universal_property_of_codual_1_to_cd_rows := UniversalPropertyOfCoDual( c_rows, d_rows, 1_to_cd_rows );;

gap> universal_property_of_codual_1_to_ab_cols := UniversalPropertyOfCoDual( a_cols, b_cols, 1_to_ab_cols );;
gap> universal_property_of_codual_1_to_cd_cols := UniversalPropertyOfCoDual( c_cols, d_cols, 1_to_cd_cols);;

# Opposite correspondence

gap> universal_property_of_dual_ab_to_1_cols = Opposite( universal_property_of_codual_1_to_ab_rows );
true
gap> universal_property_of_dual_cd_to_1_cols = Opposite( universal_property_of_codual_1_to_cd_rows );
true

gap> universal_property_of_codual_1_to_ab_cols = Opposite( universal_property_of_dual_ab_to_1_rows );
true
gap> universal_property_of_codual_1_to_cd_cols = Opposite( universal_property_of_dual_cd_to_1_rows );
true

gap> universal_property_of_dual_ab_to_1_cols = Opposite( universal_property_of_codual_1_to_cd_rows );
false
gap> universal_property_of_dual_cd_to_1_cols = Opposite( universal_property_of_codual_1_to_ab_rows );
false

gap> universal_property_of_codual_1_to_ab_cols = Opposite( universal_property_of_dual_cd_to_1_rows );
false
gap> universal_property_of_codual_1_to_cd_cols = Opposite( universal_property_of_dual_ab_to_1_rows );
false

#########################################################
# Lambdas
#########################################################

# Morphisms

gap> a_to_b := [ 2 .. 7 ];;
gap> c_to_d := [ 8 .. 31 ];;

gap> a_to_b_rows := CategoryOfRowsMorphism( a_rows, HomalgMatrix( a_to_b, 2, 3, Q ), b_rows );;
gap> b_to_a_rows := CategoryOfRowsMorphism( b_rows, TransposedMatrix( UnderlyingMatrix( a_to_b_rows ) ), a_rows );;
gap> c_to_d_rows := CategoryOfRowsMorphism( c_rows, HomalgMatrix( c_to_d, 6, 4, Q ), d_rows );;
gap> d_to_c_rows := CategoryOfRowsMorphism( d_rows, TransposedMatrix( UnderlyingMatrix( c_to_d_rows ) ), c_rows );;

gap> a_to_b_cols := Opposite( b_to_a_rows );;
gap> b_to_a_cols := Opposite( a_to_b_rows );;
gap> c_to_d_cols := Opposite( d_to_c_rows );;
gap> d_to_c_cols := Opposite( c_to_d_rows );;

# Lambda introduction

gap> lambda_intro_a_to_b_rows := LambdaIntroduction( a_to_b_rows );;
gap> lambda_intro_b_to_a_rows := LambdaIntroduction( b_to_a_rows );;
gap> lambda_intro_c_to_d_rows := LambdaIntroduction( c_to_d_rows );;
gap> lambda_intro_d_to_c_rows := LambdaIntroduction( d_to_c_rows );;

gap> lambda_intro_a_to_b_cols := LambdaIntroduction( a_to_b_cols );;
gap> lambda_intro_b_to_a_cols := LambdaIntroduction( b_to_a_cols );;
gap> lambda_intro_c_to_d_cols := LambdaIntroduction( c_to_d_cols );;
gap> lambda_intro_d_to_c_cols := LambdaIntroduction( d_to_c_cols );;

# Colambda introduction

gap> colambda_intro_a_to_b_rows := CoLambdaIntroduction( a_to_b_rows );;
gap> colambda_intro_b_to_a_rows := CoLambdaIntroduction( b_to_a_rows );;
gap> colambda_intro_c_to_d_rows := CoLambdaIntroduction( c_to_d_rows );;
gap> colambda_intro_d_to_c_rows := CoLambdaIntroduction( d_to_c_rows );;

gap> colambda_intro_a_to_b_cols := CoLambdaIntroduction( a_to_b_cols );;
gap> colambda_intro_b_to_a_cols := CoLambdaIntroduction( b_to_a_cols );;
gap> colambda_intro_c_to_d_cols := CoLambdaIntroduction( c_to_d_cols );;
gap> colambda_intro_d_to_c_cols := CoLambdaIntroduction( d_to_c_cols );;

# Lambda elimination

gap> lambda_elim_1_to_hom_ab_rows := LambdaElimination( a_rows, b_rows, lambda_intro_a_to_b_rows );;
gap> lambda_elim_1_to_hom_ba_rows := LambdaElimination( b_rows, a_rows, lambda_intro_b_to_a_rows );;
gap> lambda_elim_1_to_hom_cd_rows := LambdaElimination( c_rows, d_rows, lambda_intro_c_to_d_rows );;
gap> lambda_elim_1_to_hom_dc_rows := LambdaElimination( d_rows, c_rows, lambda_intro_d_to_c_rows );;

gap> lambda_elim_1_to_hom_ab_cols := LambdaElimination( a_cols, b_cols, lambda_intro_a_to_b_cols );;
gap> lambda_elim_1_to_hom_ba_cols := LambdaElimination( b_cols, a_cols, lambda_intro_b_to_a_cols );;
gap> lambda_elim_1_to_hom_cd_cols := LambdaElimination( c_cols, d_cols, lambda_intro_c_to_d_cols );;
gap> lambda_elim_1_to_hom_dc_cols := LambdaElimination( d_cols, c_cols, lambda_intro_d_to_c_cols );;

# Colambda elimination

gap> colambda_elim_cohom_ab_to_1_rows := CoLambdaElimination( a_rows, b_rows, colambda_intro_a_to_b_rows );;
gap> colambda_elim_cohom_ba_to_1_rows := CoLambdaElimination( b_rows, a_rows, colambda_intro_b_to_a_rows );;
gap> colambda_elim_cohom_cd_to_1_rows := CoLambdaElimination( c_rows, d_rows, colambda_intro_c_to_d_rows );;
gap> colambda_elim_cohom_dc_to_1_rows := CoLambdaElimination( d_rows, c_rows, colambda_intro_d_to_c_rows );;

gap> colambda_elim_cohom_ab_to_1_cols := CoLambdaElimination( a_cols, b_cols, colambda_intro_a_to_b_cols );;
gap> colambda_elim_cohom_ba_to_1_cols := CoLambdaElimination( b_cols, a_cols, colambda_intro_b_to_a_cols );;
gap> colambda_elim_cohom_cd_to_1_cols := CoLambdaElimination( c_cols, d_cols, colambda_intro_c_to_d_cols );;
gap> colambda_elim_cohom_dc_to_1_cols := CoLambdaElimination( d_cols, c_cols, colambda_intro_d_to_c_cols );;

# Opposite correspondence

gap> lambda_intro_a_to_b_cols = Opposite( colambda_intro_b_to_a_rows );
true
gap> lambda_intro_b_to_a_cols = Opposite( colambda_intro_a_to_b_rows );
true
gap> lambda_intro_c_to_d_cols = Opposite( colambda_intro_d_to_c_rows );
true
gap> lambda_intro_d_to_c_cols = Opposite( colambda_intro_c_to_d_rows );
true

gap> lambda_elim_1_to_hom_ab_cols = Opposite( colambda_elim_cohom_ba_to_1_rows );
true
gap> lambda_elim_1_to_hom_ba_cols = Opposite( colambda_elim_cohom_ab_to_1_rows );
true
gap> lambda_elim_1_to_hom_cd_cols = Opposite( colambda_elim_cohom_dc_to_1_rows );
true
gap> lambda_elim_1_to_hom_dc_cols = Opposite( colambda_elim_cohom_cd_to_1_rows );
true

gap> colambda_intro_a_to_b_cols = Opposite( lambda_intro_b_to_a_rows );
true
gap> colambda_intro_b_to_a_cols = Opposite( lambda_intro_a_to_b_rows );
true
gap> colambda_intro_c_to_d_cols = Opposite( lambda_intro_d_to_c_rows );
true
gap> colambda_intro_d_to_c_cols = Opposite( lambda_intro_c_to_d_rows );
true

gap> colambda_elim_cohom_ab_to_1_cols = Opposite( lambda_elim_1_to_hom_ba_rows );
true
gap> colambda_elim_cohom_ba_to_1_cols = Opposite( lambda_elim_1_to_hom_ab_rows );
true
gap> colambda_elim_cohom_cd_to_1_cols = Opposite( lambda_elim_1_to_hom_dc_rows );
true
gap> colambda_elim_cohom_dc_to_1_cols = Opposite( lambda_elim_1_to_hom_cd_rows );
true

gap> lambda_intro_a_to_b_cols = Opposite( colambda_intro_a_to_b_rows );
false
gap> lambda_intro_a_to_b_cols = Opposite( colambda_intro_c_to_d_rows );
false
gap> lambda_intro_a_to_b_cols = Opposite( colambda_intro_d_to_c_rows );
false

gap> lambda_elim_1_to_hom_ba_cols = Opposite( colambda_elim_cohom_ba_to_1_rows );
false
gap> lambda_elim_1_to_hom_ba_cols = Opposite( colambda_elim_cohom_cd_to_1_rows );
false
gap> lambda_elim_1_to_hom_ba_cols = Opposite( colambda_elim_cohom_dc_to_1_rows );
false

gap> colambda_intro_c_to_d_cols = Opposite( lambda_intro_c_to_d_rows );
false
gap> colambda_intro_c_to_d_cols = Opposite( lambda_intro_a_to_b_rows );
false
gap> colambda_intro_c_to_d_cols = Opposite( lambda_intro_b_to_a_rows );
false

gap> colambda_elim_cohom_dc_to_1_cols = Opposite( lambda_elim_1_to_hom_dc_rows );
false
gap> colambda_elim_cohom_dc_to_1_cols = Opposite( lambda_elim_1_to_hom_ab_rows );
false
gap> colambda_elim_cohom_dc_to_1_cols = Opposite( lambda_elim_1_to_hom_ba_rows );
false

#########################################################
# Isomorphisms between object and internal hom
#########################################################

# Isomorphism from object to internal hom

gap> isomorphism_from_a_to_hom_rows := IsomorphismFromObjectToInternalCoHom( a_rows );;
gap> isomorphism_from_b_to_hom_rows := IsomorphismFromObjectToInternalCoHom( b_rows );;
gap> isomorphism_from_c_to_hom_rows := IsomorphismFromObjectToInternalCoHom( c_rows );;
gap> isomorphism_from_d_to_hom_rows := IsomorphismFromObjectToInternalCoHom( d_rows );;
gap> isomorphism_from_0_to_hom_rows := IsomorphismFromObjectToInternalCoHom( 0_rows );;

gap> isomorphism_from_a_to_hom_cols := IsomorphismFromObjectToInternalCoHom( a_cols );;
gap> isomorphism_from_b_to_hom_cols := IsomorphismFromObjectToInternalCoHom( b_cols );;
gap> isomorphism_from_c_to_hom_cols := IsomorphismFromObjectToInternalCoHom( c_cols );;
gap> isomorphism_from_d_to_hom_cols := IsomorphismFromObjectToInternalCoHom( d_cols );;
gap> isomorphism_from_0_to_hom_cols := IsomorphismFromObjectToInternalCoHom( 0_cols );;

# Isomorphism from internal hom to object

gap> isomorphism_from_hom_to_a_rows := IsomorphismFromInternalHomToObject( a_rows );;
gap> isomorphism_from_hom_to_b_rows := IsomorphismFromInternalHomToObject( b_rows );;
gap> isomorphism_from_hom_to_c_rows := IsomorphismFromInternalHomToObject( c_rows );;
gap> isomorphism_from_hom_to_d_rows := IsomorphismFromInternalHomToObject( d_rows );;
gap> isomorphism_from_hom_to_0_rows := IsomorphismFromInternalHomToObject( 0_rows );;

gap> isomorphism_from_hom_to_a_cols := IsomorphismFromInternalHomToObject( a_cols );;
gap> isomorphism_from_hom_to_b_cols := IsomorphismFromInternalHomToObject( b_cols );;
gap> isomorphism_from_hom_to_c_cols := IsomorphismFromInternalHomToObject( c_cols );;
gap> isomorphism_from_hom_to_d_cols := IsomorphismFromInternalHomToObject( d_cols );;
gap> isomorphism_from_hom_to_0_cols := IsomorphismFromInternalHomToObject( 0_cols );;

# Isomorphism from object to internal cohom

gap> isomorphism_from_a_to_cohom_rows := IsomorphismFromObjectToInternalCoHom( a_rows );;
gap> isomorphism_from_b_to_cohom_rows := IsomorphismFromObjectToInternalCoHom( b_rows );;
gap> isomorphism_from_c_to_cohom_rows := IsomorphismFromObjectToInternalCoHom( c_rows );;
gap> isomorphism_from_d_to_cohom_rows := IsomorphismFromObjectToInternalCoHom( d_rows );;
gap> isomorphism_from_0_to_cohom_rows := IsomorphismFromObjectToInternalCoHom( 0_rows );;

gap> isomorphism_from_a_to_cohom_cols := IsomorphismFromObjectToInternalCoHom( a_cols );;
gap> isomorphism_from_b_to_cohom_cols := IsomorphismFromObjectToInternalCoHom( b_cols );;
gap> isomorphism_from_c_to_cohom_cols := IsomorphismFromObjectToInternalCoHom( c_cols );;
gap> isomorphism_from_d_to_cohom_cols := IsomorphismFromObjectToInternalCoHom( d_cols );;
gap> isomorphism_from_0_to_cohom_cols := IsomorphismFromObjectToInternalCoHom( 0_cols );;

# Isomorphism from internal cohom to object

gap> isomorphism_from_cohom_to_a_rows := IsomorphismFromInternalCoHomToObject( a_rows );;
gap> isomorphism_from_cohom_to_b_rows := IsomorphismFromInternalCoHomToObject( b_rows );;
gap> isomorphism_from_cohom_to_c_rows := IsomorphismFromInternalCoHomToObject( c_rows );;
gap> isomorphism_from_cohom_to_d_rows := IsomorphismFromInternalCoHomToObject( d_rows );;
gap> isomorphism_from_cohom_to_0_rows := IsomorphismFromInternalCoHomToObject( 0_rows );;

gap> isomorphism_from_cohom_to_a_cols := IsomorphismFromInternalCoHomToObject( a_cols );;
gap> isomorphism_from_cohom_to_b_cols := IsomorphismFromInternalCoHomToObject( b_cols );;
gap> isomorphism_from_cohom_to_c_cols := IsomorphismFromInternalCoHomToObject( c_cols) ;;
gap> isomorphism_from_cohom_to_d_cols := IsomorphismFromInternalCoHomToObject( d_cols );;
gap> isomorphism_from_cohom_to_0_cols := IsomorphismFromInternalCoHomToObject( 0_cols );;

# Opposite correspondence

gap> isomorphism_from_a_to_hom_cols = Opposite( isomorphism_from_cohom_to_a_rows );
true
gap> isomorphism_from_b_to_hom_cols = Opposite( isomorphism_from_cohom_to_b_rows );
true
gap> isomorphism_from_c_to_hom_cols = Opposite( isomorphism_from_cohom_to_c_rows );
true
gap> isomorphism_from_d_to_hom_cols = Opposite( isomorphism_from_cohom_to_d_rows );
true
gap> isomorphism_from_0_to_hom_cols = Opposite( isomorphism_from_cohom_to_0_rows );
true

gap> isomorphism_from_hom_to_a_cols = Opposite( isomorphism_from_a_to_cohom_rows );
true
gap> isomorphism_from_hom_to_b_cols = Opposite( isomorphism_from_b_to_cohom_rows );
true
gap> isomorphism_from_hom_to_c_cols = Opposite( isomorphism_from_c_to_cohom_rows );
true
gap> isomorphism_from_hom_to_d_cols = Opposite( isomorphism_from_d_to_cohom_rows );
true
gap> isomorphism_from_hom_to_0_cols = Opposite( isomorphism_from_0_to_cohom_rows );
true

gap> isomorphism_from_a_to_cohom_cols = Opposite( isomorphism_from_hom_to_a_rows );
true
gap> isomorphism_from_b_to_cohom_cols = Opposite( isomorphism_from_hom_to_b_rows );
true
gap> isomorphism_from_c_to_cohom_cols = Opposite( isomorphism_from_hom_to_c_rows );
true
gap> isomorphism_from_d_to_cohom_cols = Opposite( isomorphism_from_hom_to_d_rows );
true
gap> isomorphism_from_0_to_cohom_cols = Opposite( isomorphism_from_hom_to_0_rows );
true

gap> isomorphism_from_cohom_to_a_cols = Opposite( isomorphism_from_a_to_hom_rows );
true
gap> isomorphism_from_cohom_to_b_cols = Opposite( isomorphism_from_b_to_hom_rows );
true
gap> isomorphism_from_cohom_to_c_cols = Opposite( isomorphism_from_c_to_hom_rows );
true
gap> isomorphism_from_cohom_to_d_cols = Opposite( isomorphism_from_d_to_hom_rows );
true
gap> isomorphism_from_cohom_to_0_cols = Opposite( isomorphism_from_0_to_hom_rows );
true

gap> isomorphism_from_a_to_hom_cols = Opposite( isomorphism_from_cohom_to_b_rows );
false
gap> isomorphism_from_a_to_hom_cols = Opposite( isomorphism_from_cohom_to_c_rows );
false
gap> isomorphism_from_a_to_hom_cols = Opposite( isomorphism_from_cohom_to_d_rows );
false
gap> isomorphism_from_a_to_hom_cols = Opposite( isomorphism_from_cohom_to_0_rows );
false

gap> isomorphism_from_hom_to_b_cols = Opposite( isomorphism_from_a_to_cohom_rows );
false
gap> isomorphism_from_hom_to_b_cols = Opposite( isomorphism_from_c_to_cohom_rows );
false
gap> isomorphism_from_hom_to_b_cols = Opposite( isomorphism_from_d_to_cohom_rows );
false
gap> isomorphism_from_hom_to_b_cols = Opposite( isomorphism_from_0_to_cohom_rows );
false

gap> isomorphism_from_c_to_cohom_cols = Opposite( isomorphism_from_hom_to_a_rows );
false
gap> isomorphism_from_c_to_cohom_cols = Opposite( isomorphism_from_hom_to_b_rows );
false
gap> isomorphism_from_c_to_cohom_cols = Opposite( isomorphism_from_hom_to_d_rows );
false
gap> isomorphism_from_c_to_cohom_cols = Opposite( isomorphism_from_hom_to_0_rows );
false

gap> isomorphism_from_cohom_to_d_cols = Opposite( isomorphism_from_a_to_hom_rows );
false
gap> isomorphism_from_cohom_to_d_cols = Opposite( isomorphism_from_b_to_hom_rows );
false
gap> isomorphism_from_cohom_to_d_cols = Opposite( isomorphism_from_c_to_hom_rows );
false
gap> isomorphism_from_cohom_to_d_cols = Opposite( isomorphism_from_0_to_hom_rows );
false

# ------------------------------------------------------------------------ Rigid structure ----------------------------------------------------------------------

#######################################################################
# Isomorphisms between internal (co)homs and tensor products
#######################################################################

# Isomorphism from tensor product to internal hom

gap> isomorphism_from_tensor_to_hom_ab_rows := IsomorphismFromTensorProductToInternalHom( a_rows, b_rows );;
gap> isomorphism_from_tensor_to_hom_ba_rows := IsomorphismFromTensorProductToInternalHom( b_rows, a_rows );;
gap> isomorphism_from_tensor_to_hom_cd_rows := IsomorphismFromTensorProductToInternalHom( c_rows, d_rows );;
gap> isomorphism_from_tensor_to_hom_dc_rows := IsomorphismFromTensorProductToInternalHom( d_rows, c_rows );;

gap> isomorphism_from_tensor_to_hom_ab_cols := IsomorphismFromTensorProductToInternalHom( a_cols, b_cols );;
gap> isomorphism_from_tensor_to_hom_ba_cols := IsomorphismFromTensorProductToInternalHom( b_cols, a_cols );;
gap> isomorphism_from_tensor_to_hom_cd_cols := IsomorphismFromTensorProductToInternalHom( c_cols, d_cols );;
gap> isomorphism_from_tensor_to_hom_dc_cols := IsomorphismFromTensorProductToInternalHom( d_cols, c_cols );;

# isomorphism from tensor product to internal cohom

gap> isomorphism_from_tensor_to_cohom_ab_rows := IsomorphismFromTensorProductToInternalCoHom( a_rows, b_rows );;
gap> isomorphism_from_tensor_to_cohom_ba_rows := IsomorphismFromTensorProductToInternalCoHom( b_rows, a_rows );;
gap> isomorphism_from_tensor_to_cohom_cd_rows := IsomorphismFromTensorProductToInternalCoHom( c_rows, d_rows );;
gap> isomorphism_from_tensor_to_cohom_dc_rows := IsomorphismFromTensorProductToInternalCoHom( d_rows, c_rows );;

gap> isomorphism_from_tensor_to_cohom_ab_cols := IsomorphismFromTensorProductToInternalCoHom( a_cols, b_cols );;
gap> isomorphism_from_tensor_to_cohom_ba_cols := IsomorphismFromTensorProductToInternalCoHom( b_cols, a_cols );;
gap> isomorphism_from_tensor_to_cohom_cd_cols := IsomorphismFromTensorProductToInternalCoHom( c_cols, d_cols );;
gap> isomorphism_from_tensor_to_cohom_dc_cols := IsomorphismFromTensorProductToInternalCoHom( d_cols, c_cols );;

# Isomorphism from internal hom to tensor product

gap> isomorphism_from_hom_to_tensor_ab_rows := IsomorphismFromInternalHomToTensorProduct( a_rows, b_rows );;
gap> isomorphism_from_hom_to_tensor_ba_rows := IsomorphismFromInternalHomToTensorProduct( b_rows, a_rows );;
gap> isomorphism_from_hom_to_tensor_cd_rows := IsomorphismFromInternalHomToTensorProduct( c_rows, d_rows );;
gap> isomorphism_from_hom_to_tensor_dc_rows := IsomorphismFromInternalHomToTensorProduct( d_rows, c_rows );;

gap> isomorphism_from_hom_to_tensor_ab_cols := IsomorphismFromInternalHomToTensorProduct( a_cols, b_cols );;
gap> isomorphism_from_hom_to_tensor_ba_cols := IsomorphismFromInternalHomToTensorProduct( b_cols, a_cols );;
gap> isomorphism_from_hom_to_tensor_cd_cols := IsomorphismFromInternalHomToTensorProduct( c_cols, d_cols );;
gap> isomorphism_from_hom_to_tensor_dc_cols := IsomorphismFromInternalHomToTensorProduct( d_cols, c_cols );;

# Isomorphism from internal cohom to tensor product

gap> isomorphism_from_cohom_to_tensor_ab_rows := IsomorphismFromInternalCoHomToTensorProduct( a_rows, b_rows );;
gap> isomorphism_from_cohom_to_tensor_ba_rows := IsomorphismFromInternalCoHomToTensorProduct( b_rows, a_rows );;
gap> isomorphism_from_cohom_to_tensor_cd_rows := IsomorphismFromInternalCoHomToTensorProduct( c_rows, d_rows );;
gap> isomorphism_from_cohom_to_tensor_dc_rows := IsomorphismFromInternalCoHomToTensorProduct( d_rows, c_rows );;

gap> isomorphism_from_cohom_to_tensor_ab_cols := IsomorphismFromInternalCoHomToTensorProduct( a_cols, b_cols );;
gap> isomorphism_from_cohom_to_tensor_ba_cols := IsomorphismFromInternalCoHomToTensorProduct( b_cols, a_cols );;
gap> isomorphism_from_cohom_to_tensor_cd_cols := IsomorphismFromInternalCoHomToTensorProduct( c_cols, d_cols );;
gap> isomorphism_from_cohom_to_tensor_dc_cols := IsomorphismFromInternalCoHomToTensorProduct( d_cols, c_cols );;

# Opposite correspondence

gap> isomorphism_from_tensor_to_hom_ab_cols = Opposite( isomorphism_from_cohom_to_tensor_ba_rows );
true
gap> isomorphism_from_tensor_to_hom_ba_cols = Opposite( isomorphism_from_cohom_to_tensor_ab_rows );
true
gap> isomorphism_from_tensor_to_hom_cd_cols = Opposite( isomorphism_from_cohom_to_tensor_dc_rows );
true
gap> isomorphism_from_tensor_to_hom_dc_cols = Opposite( isomorphism_from_cohom_to_tensor_cd_rows );
true

gap> isomorphism_from_tensor_to_cohom_ab_cols = Opposite( isomorphism_from_hom_to_tensor_ab_rows );
true
gap> isomorphism_from_tensor_to_cohom_ba_cols = Opposite( isomorphism_from_hom_to_tensor_ba_rows );
true
gap> isomorphism_from_tensor_to_cohom_cd_cols = Opposite( isomorphism_from_hom_to_tensor_cd_rows );
true
gap> isomorphism_from_tensor_to_cohom_dc_cols = Opposite( isomorphism_from_hom_to_tensor_dc_rows );
true

gap> isomorphism_from_hom_to_tensor_ab_cols = Opposite( isomorphism_from_tensor_to_cohom_ab_rows );
true
gap> isomorphism_from_hom_to_tensor_ba_cols = Opposite( isomorphism_from_tensor_to_cohom_ba_rows );
true
gap> isomorphism_from_hom_to_tensor_cd_cols = Opposite( isomorphism_from_tensor_to_cohom_cd_rows );
true
gap> isomorphism_from_hom_to_tensor_dc_cols = Opposite( isomorphism_from_tensor_to_cohom_dc_rows );
true

gap> isomorphism_from_cohom_to_tensor_ab_cols = Opposite( isomorphism_from_tensor_to_hom_ba_rows );
true
gap> isomorphism_from_cohom_to_tensor_ba_cols = Opposite( isomorphism_from_tensor_to_hom_ab_rows );
true
gap> isomorphism_from_cohom_to_tensor_cd_cols = Opposite( isomorphism_from_tensor_to_hom_dc_rows );
true
gap> isomorphism_from_cohom_to_tensor_dc_cols = Opposite( isomorphism_from_tensor_to_hom_cd_rows );
true

gap> isomorphism_from_tensor_to_hom_dc_cols = Opposite( isomorphism_from_cohom_to_tensor_ab_rows );
false
gap> isomorphism_from_tensor_to_hom_dc_cols = Opposite( isomorphism_from_cohom_to_tensor_ba_rows );
false

gap> isomorphism_from_tensor_to_cohom_cd_cols = Opposite( isomorphism_from_hom_to_tensor_ab_rows );
false
gap> isomorphism_from_tensor_to_cohom_cd_cols = Opposite( isomorphism_from_hom_to_tensor_ba_rows );
false

gap> isomorphism_from_hom_to_tensor_ba_cols = Opposite( isomorphism_from_tensor_to_cohom_cd_rows );
false
gap> isomorphism_from_hom_to_tensor_ba_cols = Opposite( isomorphism_from_tensor_to_cohom_dc_rows );
false

gap> isomorphism_from_tensor_to_hom_ab_cols = Opposite( isomorphism_from_cohom_to_tensor_cd_rows );
false
gap> isomorphism_from_tensor_to_hom_ab_cols = Opposite( isomorphism_from_cohom_to_tensor_dc_rows );
false

###################################################################################
# Morphism from internal hom to tensor product / tensor product to cohom
###################################################################################

# Morphism from internal hom to tensor product

gap> morphism_from_hom_to_tensor_product_ab_rows := MorphismFromInternalHomToTensorProduct( a_rows, b_rows );;
gap> morphism_from_hom_to_tensor_product_ba_rows := MorphismFromInternalHomToTensorProduct( b_rows, a_rows );;
gap> morphism_from_hom_to_tensor_product_cd_rows := MorphismFromInternalHomToTensorProduct( c_rows, d_rows );;
gap> morphism_from_hom_to_tensor_product_dc_rows := MorphismFromInternalHomToTensorProduct( d_rows, c_rows );;

gap> morphism_from_hom_to_tensor_product_ab_cols := MorphismFromInternalHomToTensorProduct( a_cols, b_cols );;
gap> morphism_from_hom_to_tensor_product_ba_cols := MorphismFromInternalHomToTensorProduct( b_cols, a_cols );;
gap> morphism_from_hom_to_tensor_product_cd_cols := MorphismFromInternalHomToTensorProduct( c_cols, d_cols );;
gap> morphism_from_hom_to_tensor_product_dc_cols := MorphismFromInternalHomToTensorProduct( d_cols, c_cols );;

# Morphism from tensor product to internal cohom

gap> morphism_from_tensor_product_to_cohom_ab_rows := MorphismFromTensorProductToInternalCoHom( a_rows, b_rows );;
gap> morphism_from_tensor_product_to_cohom_ba_rows := MorphismFromTensorProductToInternalCoHom( b_rows, a_rows );;
gap> morphism_from_tensor_product_to_cohom_cd_rows := MorphismFromTensorProductToInternalCoHom( c_rows, d_rows );;
gap> morphism_from_tensor_product_to_cohom_dc_rows := MorphismFromTensorProductToInternalCoHom( d_rows, c_rows );;

gap> morphism_from_tensor_product_to_cohom_ab_cols := MorphismFromTensorProductToInternalCoHom( a_cols, b_cols );;
gap> morphism_from_tensor_product_to_cohom_ba_cols := MorphismFromTensorProductToInternalCoHom( b_cols, a_cols );;
gap> morphism_from_tensor_product_to_cohom_cd_cols := MorphismFromTensorProductToInternalCoHom( c_cols, d_cols );;
gap> morphism_from_tensor_product_to_cohom_dc_cols := MorphismFromTensorProductToInternalCoHom( d_cols, c_cols );;

# Opposite correspondence

gap> morphism_from_hom_to_tensor_product_ab_cols = Opposite( morphism_from_tensor_product_to_cohom_ab_rows );
true
gap> morphism_from_hom_to_tensor_product_ba_cols = Opposite( morphism_from_tensor_product_to_cohom_ba_rows );
true
gap> morphism_from_hom_to_tensor_product_cd_cols = Opposite( morphism_from_tensor_product_to_cohom_cd_rows );
true
gap> morphism_from_hom_to_tensor_product_dc_cols = Opposite( morphism_from_tensor_product_to_cohom_dc_rows );
true

gap> morphism_from_tensor_product_to_cohom_ab_cols = Opposite( morphism_from_hom_to_tensor_product_ab_rows );
true
gap> morphism_from_tensor_product_to_cohom_ba_cols = Opposite( morphism_from_hom_to_tensor_product_ba_rows );
true
gap> morphism_from_tensor_product_to_cohom_cd_cols = Opposite( morphism_from_hom_to_tensor_product_cd_rows );
true
gap> morphism_from_tensor_product_to_cohom_dc_cols = Opposite( morphism_from_hom_to_tensor_product_dc_rows );
true

gap> morphism_from_hom_to_tensor_product_ab_cols = Opposite( morphism_from_tensor_product_to_cohom_cd_rows );
false
gap> morphism_from_hom_to_tensor_product_ab_cols = Opposite( morphism_from_tensor_product_to_cohom_dc_rows );
false

gap> morphism_from_hom_to_tensor_product_cd_cols = Opposite( morphism_from_tensor_product_to_cohom_ab_rows );
false
gap> morphism_from_hom_to_tensor_product_cd_cols = Opposite( morphism_from_tensor_product_to_cohom_ba_rows );
false

gap> morphism_from_tensor_product_to_cohom_ba_cols = Opposite( morphism_from_hom_to_tensor_product_cd_rows );
false
gap> morphism_from_tensor_product_to_cohom_ba_cols = Opposite( morphism_from_hom_to_tensor_product_dc_rows );
false

gap> morphism_from_tensor_product_to_cohom_dc_cols = Opposite( morphism_from_hom_to_tensor_product_ab_rows );
false
gap> morphism_from_tensor_product_to_cohom_dc_cols = Opposite( morphism_from_hom_to_tensor_product_ba_rows );
false

######################################################################
# Inverse tensor product and internal (co)hom compatibility
######################################################################

gap> tensor_to_hom_compatibility_inverse_abcd_rows := TensorProductInternalHomCompatibilityMorphismInverse( [ a_rows, b_rows, c_rows, d_rows ] );; # Hom( a x c, b x d ) -> Hom( a, b ) x Hom( c, d )
gap> tensor_to_hom_compatibility_inverse_cadb_rows := TensorProductInternalHomCompatibilityMorphismInverse( [ c_rows, a_rows, d_rows, b_rows ] );; # Hom( c x d, a x b ) -> Hom( c, a ) x Hom( d, b )

gap> cohom_to_tensor_compatibility_inverse_abcd_rows := InternalCoHomTensorProductCompatibilityMorphismInverse( [ a_rows, b_rows, c_rows, d_rows ] );; # Cohom( a, c ) x Cohom( b, d ) -> Cohom( a x b, c x d )
gap> cohom_to_tensor_compatibility_inverse_bdac_rows := InternalCoHomTensorProductCompatibilityMorphismInverse( [ b_rows, d_rows, a_rows, c_rows ] );; # Cohom( b, a ) x Cohom( d, c ) -> Cohom( b x d, a x c )

gap> tensor_to_hom_compatibility_inverse_abcd_cols := TensorProductInternalHomCompatibilityMorphismInverse( [ a_cols, b_cols, c_cols, d_cols ] );; # Hom( a x c, b x d ) -> Hom( a, b ) x Hom( c, d )
gap> tensor_to_hom_compatibility_inverse_cadb_cols := TensorProductInternalHomCompatibilityMorphismInverse( [ c_cols, a_cols, d_cols, b_cols ] );; # Hom( c x d, a x b ) -> Hom( c, a ) x Hom( d, b )

gap> cohom_to_tensor_compatibility_inverse_abcd_cols := InternalCoHomTensorProductCompatibilityMorphismInverse( [ a_cols, b_cols, c_cols, d_cols ] );; # Cohom( a, c ) x Cohom( b, d ) -> Cohom( a x b, c x d )
gap> cohom_to_tensor_compatibility_inverse_bdac_cols := InternalCoHomTensorProductCompatibilityMorphismInverse( [ b_cols, d_cols, a_cols, c_cols ] );; # Cohom( b, a ) x Cohom( d, c ) -> Cohom( b x d, a x c )

# Opposite correspondence

gap> tensor_to_hom_compatibility_inverse_abcd_cols = Opposite( cohom_to_tensor_compatibility_inverse_bdac_rows ); # Hom( a x c, b x d ) -> Hom( a, b ) x Hom( c, d )  ==  op( Cohom( b, a ) x Cohom( d, c ) -> Cohom( b x d, a x c ) )
true
gap> tensor_to_hom_compatibility_inverse_cadb_cols = Opposite( cohom_to_tensor_compatibility_inverse_abcd_rows ); # Hom( c x d, a x b ) -> Hom( c, a ) x Hom( d, b )  ==  op( Cohom( a, c ) x Cohom( b, d ) -> Cohom( a x b, c x d ) )
true

gap> cohom_to_tensor_compatibility_inverse_abcd_cols = Opposite( tensor_to_hom_compatibility_inverse_cadb_rows ); # Cohom( a, c ) x Cohom( b, d ) -> Cohom( a x b, c x d )  ==  op( Hom( c x d, a x b ) -> Hom( c, a ) x Hom( d, b ) )
true
gap> cohom_to_tensor_compatibility_inverse_bdac_cols = Opposite( tensor_to_hom_compatibility_inverse_abcd_rows ); # Cohom( b, a ) x Cohom( d, c ) -> Cohom( b x d, a x c )  ==  op( Hom( a x c, b x d ) -> Hom( a, b ) x Hom( c, d ) )
true

gap> tensor_to_hom_compatibility_inverse_abcd_cols = Opposite( cohom_to_tensor_compatibility_inverse_abcd_rows ); # Hom( a x c, b x d ) -> Hom( a, b ) x Hom( c, d )  =/=  op( Cohom( a, c ) x Cohom( b, d ) -> Cohom( a x b, c x d ) )
false
gap> tensor_to_hom_compatibility_inverse_cadb_cols = Opposite( cohom_to_tensor_compatibility_inverse_bdac_rows ); # Hom( c x d, a x b ) -> Hom( c, a ) x Hom( d, b )  =/=  op( Cohom( b, a ) x Cohom( d, c ) -> Cohom( b x d, a x c ) )
false

gap> cohom_to_tensor_compatibility_inverse_abcd_cols = Opposite( tensor_to_hom_compatibility_inverse_abcd_rows ); # Cohom( a, c ) x Cohom( b, d ) -> Cohom( a x b, c x d )  =/=  op( Hom( a x c, b x d ) -> Hom( a, b ) x Hom( c, d ) )
false
gap> cohom_to_tensor_compatibility_inverse_bdac_cols = Opposite( tensor_to_hom_compatibility_inverse_cadb_rows ); # Cohom( b, a ) x Cohom( d, c ) -> Cohom( b x d, a x c )  =/=  op( Hom( c x d, a x b ) -> Hom( c, a ) x Hom( d, b ) )
false

#######################################################################
# Coevaluation for (co)dual
#######################################################################

gap> coev_for_dual_a_rows := CoevaluationForDual( a_rows );;
gap> coev_for_dual_b_rows := CoevaluationForDual( b_rows );;
gap> coev_for_dual_0_rows := CoevaluationForDual( 0_rows );;

gap> cocl_coev_for_codual_a_rows := CoclosedCoevaluationForCoDual( a_rows );;
gap> cocl_coev_for_codual_b_rows := CoclosedCoevaluationForCoDual( b_rows );;
gap> cocl_coev_for_codual_0_rows := CoclosedCoevaluationForCoDual( 0_rows );;

gap> coev_for_dual_a_cols := CoevaluationForDual( a_cols );;
gap> coev_for_dual_b_cols := CoevaluationForDual( b_cols );;
gap> coev_for_dual_0_cols := CoevaluationForDual( 0_cols );;

gap> cocl_coev_for_codual_a_cols := CoclosedCoevaluationForCoDual( a_cols );;
gap> cocl_coev_for_codual_b_cols := CoclosedCoevaluationForCoDual( b_cols );;
gap> cocl_coev_for_codual_0_cols := CoclosedCoevaluationForCoDual( 0_cols );;

# Opposite correspondence

gap> coev_for_dual_a_cols = Opposite( cocl_coev_for_codual_a_rows );
true
gap> coev_for_dual_b_cols = Opposite( cocl_coev_for_codual_b_rows );
true
gap> coev_for_dual_0_cols = Opposite( cocl_coev_for_codual_0_rows );
true

gap> cocl_coev_for_codual_a_cols = Opposite( coev_for_dual_a_rows );
true
gap> cocl_coev_for_codual_b_cols = Opposite( coev_for_dual_b_rows );
true
gap> cocl_coev_for_codual_0_cols = Opposite( coev_for_dual_0_rows );
true

gap> coev_for_dual_a_cols = Opposite( cocl_coev_for_codual_b_rows );
false
gap> coev_for_dual_b_cols = Opposite( cocl_coev_for_codual_a_rows );
false
gap> coev_for_dual_0_cols = Opposite( cocl_coev_for_codual_a_rows );
false

gap> cocl_coev_for_codual_a_cols = Opposite( coev_for_dual_b_rows );
false
gap> cocl_coev_for_codual_b_cols = Opposite( coev_for_dual_a_rows );
false
gap> cocl_coev_for_codual_0_cols = Opposite( coev_for_dual_a_rows );
false

#######################################################################
# (Co)Trace
#######################################################################

# Trace on rows

gap> trace_id_0_tensor_a_rows := TraceMap( id_0_tensor_a_rows );;
gap> trace_id_a_tensor_0_rows := TraceMap( id_a_tensor_0_rows );;

gap> trace_id_a_tensor_b_rows := TraceMap( id_a_tensor_b_rows );;
gap> trace_id_b_tensor_a_rows := TraceMap( id_b_tensor_a_rows );;
gap> trace_id_c_tensor_d_rows := TraceMap( id_c_tensor_d_rows );;
gap> trace_id_d_tensor_c_rows := TraceMap( id_d_tensor_c_rows );;

gap> trace_id_hom_0a_rows := TraceMap( id_hom_0a_rows );;
gap> trace_id_hom_a0_rows := TraceMap( id_hom_a0_rows );;

gap> trace_id_hom_ab_rows := TraceMap( id_hom_ab_rows );;
gap> trace_id_hom_ba_rows := TraceMap( id_hom_ba_rows );;
gap> trace_id_hom_cd_rows := TraceMap( id_hom_cd_rows );;
gap> trace_id_hom_dc_rows := TraceMap( id_hom_dc_rows );;

# Trace on columns

gap> trace_id_0_tensor_a_cols := TraceMap( id_0_tensor_a_cols );;
gap> trace_id_a_tensor_0_cols := TraceMap( id_a_tensor_0_cols );;

gap> trace_id_a_tensor_b_cols := TraceMap( id_a_tensor_b_cols );;
gap> trace_id_b_tensor_a_cols := TraceMap( id_b_tensor_a_cols );;
gap> trace_id_c_tensor_d_cols := TraceMap( id_c_tensor_d_cols );;
gap> trace_id_d_tensor_c_cols := TraceMap( id_d_tensor_c_cols );;

gap> trace_id_hom_0a_cols := TraceMap( id_hom_0a_cols );;
gap> trace_id_hom_a0_cols := TraceMap( id_hom_a0_cols );;

gap> trace_id_hom_ab_cols := TraceMap( id_hom_ab_cols );;
gap> trace_id_hom_ba_cols := TraceMap( id_hom_ba_cols );;
gap> trace_id_hom_cd_cols := TraceMap( id_hom_cd_cols );;
gap> trace_id_hom_dc_cols := TraceMap( id_hom_dc_cols );;

# Cotrace on rows

gap> cotrace_id_0_tensor_a_rows := CoTraceMap( id_0_tensor_a_rows );;
gap> cotrace_id_a_tensor_0_rows := CoTraceMap( id_a_tensor_0_rows );;

gap> cotrace_id_a_tensor_b_rows := CoTraceMap( id_a_tensor_b_rows );;
gap> cotrace_id_b_tensor_a_rows := CoTraceMap( id_b_tensor_a_rows );;
gap> cotrace_id_c_tensor_d_rows := CoTraceMap( id_c_tensor_d_rows );;
gap> cotrace_id_d_tensor_c_rows := CoTraceMap( id_d_tensor_c_rows );;

gap> cotrace_id_hom_0a_rows := CoTraceMap( id_hom_0a_rows );;
gap> cotrace_id_hom_a0_rows := CoTraceMap( id_hom_a0_rows );;

gap> cotrace_id_hom_ab_rows := CoTraceMap( id_hom_ab_rows );;
gap> cotrace_id_hom_ba_rows := CoTraceMap( id_hom_ba_rows );;
gap> cotrace_id_hom_cd_rows := CoTraceMap( id_hom_cd_rows );;
gap> cotrace_id_hom_dc_rows := CoTraceMap( id_hom_dc_rows );;

# Cotrace on columns

gap> cotrace_id_0_tensor_a_cols := CoTraceMap( id_0_tensor_a_cols );;
gap> cotrace_id_a_tensor_0_cols := CoTraceMap( id_a_tensor_0_cols );;

gap> cotrace_id_a_tensor_b_cols := CoTraceMap( id_a_tensor_b_cols );;
gap> cotrace_id_b_tensor_a_cols := CoTraceMap( id_b_tensor_a_cols );;
gap> cotrace_id_c_tensor_d_cols := CoTraceMap( id_c_tensor_d_cols );;
gap> cotrace_id_d_tensor_c_cols := CoTraceMap( id_d_tensor_c_cols );;

gap> cotrace_id_hom_0a_cols := CoTraceMap( id_hom_0a_cols );;
gap> cotrace_id_hom_a0_cols := CoTraceMap( id_hom_a0_cols );;

gap> cotrace_id_hom_ab_cols := CoTraceMap( id_hom_ab_cols );;
gap> cotrace_id_hom_ba_cols := CoTraceMap( id_hom_ba_cols );;
gap> cotrace_id_hom_cd_cols := CoTraceMap( id_hom_cd_cols );;
gap> cotrace_id_hom_dc_cols := CoTraceMap( id_hom_dc_cols );;

# Opposite correspondence

gap> trace_id_0_tensor_a_cols = Opposite( cotrace_id_0_tensor_a_rows );
true
gap> trace_id_a_tensor_0_cols = Opposite( cotrace_id_a_tensor_0_rows );
true

gap> trace_id_a_tensor_b_cols = Opposite( cotrace_id_a_tensor_b_rows );
true
gap> trace_id_b_tensor_a_cols = Opposite( cotrace_id_b_tensor_a_rows );
true
gap> trace_id_c_tensor_d_cols = Opposite( cotrace_id_c_tensor_d_rows );
true
gap> trace_id_d_tensor_c_cols = Opposite( cotrace_id_d_tensor_c_rows );
true

gap> trace_id_hom_0a_cols = Opposite( cotrace_id_hom_0a_rows );
true
gap> trace_id_hom_a0_cols = Opposite( cotrace_id_hom_a0_rows );
true

gap> trace_id_hom_ab_cols = Opposite( cotrace_id_hom_ab_rows );
true
gap> trace_id_hom_ba_cols = Opposite( cotrace_id_hom_ba_rows );
true
gap> trace_id_hom_cd_cols = Opposite( cotrace_id_hom_cd_rows );
true
gap> trace_id_hom_dc_cols = Opposite( cotrace_id_hom_dc_rows );
true

gap> cotrace_id_0_tensor_a_cols = Opposite( trace_id_0_tensor_a_rows );
true
gap> cotrace_id_a_tensor_0_cols = Opposite( trace_id_a_tensor_0_rows );
true

gap> cotrace_id_a_tensor_b_cols = Opposite( trace_id_a_tensor_b_rows );
true
gap> cotrace_id_b_tensor_a_cols = Opposite( trace_id_b_tensor_a_rows );
true
gap> cotrace_id_c_tensor_d_cols = Opposite( trace_id_c_tensor_d_rows );
true
gap> cotrace_id_d_tensor_c_cols = Opposite( trace_id_d_tensor_c_rows );
true

gap> cotrace_id_hom_0a_cols = Opposite( trace_id_hom_0a_rows );
true
gap> cotrace_id_hom_a0_cols = Opposite( trace_id_hom_a0_rows );
true

gap> cotrace_id_hom_ab_cols = Opposite( trace_id_hom_ab_rows );
true
gap> cotrace_id_hom_ba_cols = Opposite( trace_id_hom_ba_rows );
true
gap> cotrace_id_hom_cd_cols = Opposite( trace_id_hom_cd_rows );
true
gap> cotrace_id_hom_dc_cols = Opposite( trace_id_hom_dc_rows );
true

gap> trace_id_a_tensor_b_cols = Opposite( cotrace_id_c_tensor_d_rows );
false
gap> trace_id_c_tensor_d_cols = Opposite( cotrace_id_a_tensor_b_rows );
false

gap> trace_id_hom_ab_cols = Opposite( cotrace_id_hom_cd_rows );
false
gap> trace_id_hom_dc_cols = Opposite( cotrace_id_hom_ba_rows );
false

gap> cotrace_id_b_tensor_a_cols = Opposite( trace_id_d_tensor_c_rows );
false
gap> cotrace_id_d_tensor_c_cols = Opposite( trace_id_b_tensor_a_rows );
false

gap> cotrace_id_hom_ba_cols = Opposite( trace_id_hom_dc_rows );
false
gap> cotrace_id_hom_dc_cols = Opposite( trace_id_hom_ba_rows );
false

#######################################################################
# (Co)RankMorphism
#######################################################################

# Rank morphism on rows

gap> rank_morphism_a_rows := RankMorphism( a_rows );;
gap> rank_morphism_b_rows := RankMorphism( b_rows );;
gap> rank_morphism_c_rows := RankMorphism( c_rows );;
gap> rank_morphism_d_rows := RankMorphism( d_rows );;

gap> rank_morphism_a_tensor_b_rows := RankMorphism( a_tensor_b_rows );;
gap> rank_morphism_b_tensor_a_rows := RankMorphism( b_tensor_a_rows );;
gap> rank_morphism_c_tensor_d_rows := RankMorphism( c_tensor_d_rows );;
gap> rank_morphism_d_tensor_c_rows := RankMorphism( d_tensor_c_rows );;

gap> rank_morphism_a_tensor_0_rows := RankMorphism( a_tensor_0_rows );;
gap> rank_morphism_0_tensor_a_rows := RankMorphism( 0_tensor_a_rows );;

gap> rank_morphism_hom_ab_rows := RankMorphism( hom_ab_rows );;
gap> rank_morphism_hom_ba_rows := RankMorphism( hom_ba_rows );;
gap> rank_morphism_hom_cd_rows := RankMorphism( hom_cd_rows );;
gap> rank_morphism_hom_dc_rows := RankMorphism( hom_dc_rows );;

# Rank morphism on columns

gap> rank_morphism_a_cols := RankMorphism( a_cols );;
gap> rank_morphism_b_cols := RankMorphism( b_cols );;
gap> rank_morphism_c_cols := RankMorphism( c_cols );;
gap> rank_morphism_d_cols := RankMorphism( d_cols );;

gap> rank_morphism_a_tensor_b_cols := RankMorphism( a_tensor_b_cols );;
gap> rank_morphism_b_tensor_a_cols := RankMorphism( b_tensor_a_cols );;
gap> rank_morphism_c_tensor_d_cols := RankMorphism( c_tensor_d_cols );;
gap> rank_morphism_d_tensor_c_cols := RankMorphism( d_tensor_c_cols );;

gap> rank_morphism_a_tensor_0_cols := RankMorphism( a_tensor_0_cols );;
gap> rank_morphism_0_tensor_a_cols := RankMorphism( 0_tensor_a_cols );;

gap> rank_morphism_hom_ab_cols := RankMorphism( hom_ab_cols );;
gap> rank_morphism_hom_ba_cols := RankMorphism( hom_ba_cols );;
gap> rank_morphism_hom_cd_cols := RankMorphism( hom_cd_cols );;
gap> rank_morphism_hom_dc_cols := RankMorphism( hom_dc_cols );;

# Corank morphism on rows

gap> corank_morphism_a_rows := CoRankMorphism( a_rows );;
gap> corank_morphism_b_rows := CoRankMorphism( b_rows );;
gap> corank_morphism_c_rows := CoRankMorphism( c_rows );;
gap> corank_morphism_d_rows := CoRankMorphism( d_rows );;

gap> corank_morphism_a_tensor_b_rows := CoRankMorphism( a_tensor_b_rows );;
gap> corank_morphism_b_tensor_a_rows := CoRankMorphism( b_tensor_a_rows );;
gap> corank_morphism_c_tensor_d_rows := CoRankMorphism( c_tensor_d_rows );;
gap> corank_morphism_d_tensor_c_rows := CoRankMorphism( d_tensor_c_rows );;

gap> corank_morphism_a_tensor_0_rows := CoRankMorphism( a_tensor_0_rows );;
gap> corank_morphism_0_tensor_a_rows := CoRankMorphism( 0_tensor_a_rows );;

gap> corank_morphism_cohom_ab_rows := CoRankMorphism( cohom_ab_rows );;
gap> corank_morphism_cohom_ba_rows := CoRankMorphism( cohom_ba_rows );;
gap> corank_morphism_cohom_cd_rows := CoRankMorphism( cohom_cd_rows );;
gap> corank_morphism_cohom_dc_rows := CoRankMorphism( cohom_dc_rows );;

# Corank morphism on columns

gap> corank_morphism_a_cols := CoRankMorphism( a_cols );;
gap> corank_morphism_b_cols := CoRankMorphism( b_cols );;
gap> corank_morphism_c_cols := CoRankMorphism( c_cols );;
gap> corank_morphism_d_cols := CoRankMorphism( d_cols );;

gap> corank_morphism_a_tensor_b_cols := CoRankMorphism( a_tensor_b_cols );;
gap> corank_morphism_b_tensor_a_cols := CoRankMorphism( b_tensor_a_cols );;
gap> corank_morphism_c_tensor_d_cols := CoRankMorphism( c_tensor_d_cols );;
gap> corank_morphism_d_tensor_c_cols := CoRankMorphism( d_tensor_c_cols );;

gap> corank_morphism_a_tensor_0_cols := CoRankMorphism( a_tensor_0_cols );;
gap> corank_morphism_0_tensor_a_cols := CoRankMorphism( 0_tensor_a_cols );;

gap> corank_morphism_cohom_ab_cols := CoRankMorphism( cohom_ab_cols );;
gap> corank_morphism_cohom_ba_cols := CoRankMorphism( cohom_ba_cols );;
gap> corank_morphism_cohom_cd_cols := CoRankMorphism( cohom_cd_cols );;
gap> corank_morphism_cohom_dc_cols := CoRankMorphism( cohom_dc_cols );;

# Opposite correspondence

gap> rank_morphism_a_cols = Opposite( corank_morphism_a_rows );
true
gap> rank_morphism_b_cols = Opposite( corank_morphism_b_rows );
true
gap> rank_morphism_c_cols = Opposite( corank_morphism_c_rows );
true
gap> rank_morphism_d_cols = Opposite( corank_morphism_d_rows );
true

gap> rank_morphism_a_tensor_b_cols = Opposite( corank_morphism_a_tensor_b_rows );
true
gap> rank_morphism_b_tensor_a_cols = Opposite( corank_morphism_b_tensor_a_rows );
true
gap> rank_morphism_c_tensor_d_cols = Opposite( corank_morphism_c_tensor_d_rows );
true
gap> rank_morphism_d_tensor_c_cols = Opposite( corank_morphism_d_tensor_c_rows );
true

gap> rank_morphism_a_tensor_0_cols = Opposite( corank_morphism_a_tensor_0_rows );
true
gap> rank_morphism_0_tensor_a_cols = Opposite( corank_morphism_0_tensor_a_rows );
true

gap> rank_morphism_hom_ab_cols = Opposite( corank_morphism_cohom_ab_rows );
true
gap> rank_morphism_hom_ba_cols = Opposite( corank_morphism_cohom_ba_rows );
true
gap> rank_morphism_hom_cd_cols = Opposite( corank_morphism_cohom_cd_rows );
true
gap> rank_morphism_hom_dc_cols = Opposite( corank_morphism_cohom_dc_rows );
true

gap> corank_morphism_a_cols = Opposite( rank_morphism_a_rows );
true
gap> corank_morphism_b_cols = Opposite( rank_morphism_b_rows );
true
gap> corank_morphism_c_cols = Opposite( rank_morphism_c_rows );
true
gap> corank_morphism_d_cols = Opposite( rank_morphism_d_rows );
true

gap> corank_morphism_a_tensor_b_cols = Opposite( rank_morphism_a_tensor_b_rows );
true
gap> corank_morphism_b_tensor_a_cols = Opposite( rank_morphism_b_tensor_a_rows );
true
gap> corank_morphism_c_tensor_d_cols = Opposite( rank_morphism_c_tensor_d_rows );
true
gap> corank_morphism_d_tensor_c_cols = Opposite( rank_morphism_d_tensor_c_rows );
true

gap> corank_morphism_a_tensor_0_cols = Opposite( rank_morphism_a_tensor_0_rows );
true
gap> corank_morphism_0_tensor_a_cols = Opposite( rank_morphism_0_tensor_a_rows );
true

gap> corank_morphism_cohom_ab_cols = Opposite( rank_morphism_hom_ab_rows );
true
gap> corank_morphism_cohom_ba_cols = Opposite( rank_morphism_hom_ba_rows );
true
gap> corank_morphism_cohom_cd_cols = Opposite( rank_morphism_hom_cd_rows );
true
gap> corank_morphism_cohom_dc_cols = Opposite( rank_morphism_hom_dc_rows );
true

gap> rank_morphism_a_cols = Opposite( corank_morphism_b_rows );
false
gap> rank_morphism_b_cols = Opposite( corank_morphism_a_rows );
false
gap> rank_morphism_c_cols = Opposite( corank_morphism_d_rows );
false
gap> rank_morphism_d_cols = Opposite( corank_morphism_c_rows );
false

gap> rank_morphism_a_tensor_0_cols = Opposite( corank_morphism_a_tensor_b_rows );
false
gap> rank_morphism_0_tensor_a_cols = Opposite( corank_morphism_c_tensor_d_rows );
false

gap> corank_morphism_a_cols = Opposite( rank_morphism_d_rows );
false
gap> corank_morphism_b_cols = Opposite( rank_morphism_c_rows );
false
gap> corank_morphism_c_cols = Opposite( rank_morphism_b_rows );
false
gap> corank_morphism_d_cols = Opposite( rank_morphism_a_rows );
false

gap> corank_morphism_a_tensor_0_cols = Opposite( rank_morphism_a_tensor_b_rows );
false
gap> corank_morphism_0_tensor_a_cols = Opposite( rank_morphism_c_tensor_d_rows );
false

gap> corank_morphism_cohom_ab_cols = Opposite( rank_morphism_hom_cd_rows );
false
gap> corank_morphism_cohom_cd_cols = Opposite( rank_morphism_hom_ab_rows );
false

#######################################################################
# Morphism from bidual / to cobidual
#######################################################################

# Rows

gap> morphism_from_bidual_a_rows := MorphismFromBidual( a_rows );;
gap> morphism_from_bidual_b_rows := MorphismFromBidual( b_rows );;
gap> morphism_from_bidual_c_rows := MorphismFromBidual( c_rows );;
gap> morphism_from_bidual_d_rows := MorphismFromBidual( d_rows );;

gap> morphism_to_cobidual_a_rows := MorphismToCoBidual( a_rows );;
gap> morphism_to_cobidual_b_rows := MorphismToCoBidual( b_rows );;
gap> morphism_to_cobidual_c_rows := MorphismToCoBidual( c_rows );;
gap> morphism_to_cobidual_d_rows := MorphismToCoBidual( d_rows );;

# Columns

gap> morphism_from_bidual_a_cols := MorphismFromBidual( a_cols );;
gap> morphism_from_bidual_b_cols := MorphismFromBidual( b_cols );;
gap> morphism_from_bidual_c_cols := MorphismFromBidual( c_cols );;
gap> morphism_from_bidual_d_cols := MorphismFromBidual( d_cols );;

gap> morphism_to_cobidual_a_cols := MorphismToCoBidual( a_cols );;
gap> morphism_to_cobidual_b_cols := MorphismToCoBidual( b_cols );;
gap> morphism_to_cobidual_c_cols := MorphismToCoBidual( c_cols );;
gap> morphism_to_cobidual_d_cols := MorphismToCoBidual( d_cols );;

# Opposite correspondence

gap> morphism_from_bidual_a_cols = Opposite( morphism_to_cobidual_a_rows );
true
gap> morphism_from_bidual_b_cols = Opposite( morphism_to_cobidual_b_rows );
true
gap> morphism_from_bidual_c_cols = Opposite( morphism_to_cobidual_c_rows );
true
gap> morphism_from_bidual_d_cols = Opposite( morphism_to_cobidual_d_rows );
true

gap> morphism_to_cobidual_a_cols = Opposite( morphism_from_bidual_a_rows );
true
gap> morphism_to_cobidual_b_cols = Opposite( morphism_from_bidual_b_rows );
true
gap> morphism_to_cobidual_c_cols = Opposite( morphism_from_bidual_c_rows );
true
gap> morphism_to_cobidual_d_cols = Opposite( morphism_from_bidual_d_rows );
true

gap> morphism_from_bidual_a_cols = Opposite( morphism_to_cobidual_b_rows );
false
gap> morphism_from_bidual_a_cols = Opposite( morphism_to_cobidual_c_rows );
false
gap> morphism_from_bidual_a_cols = Opposite( morphism_to_cobidual_d_rows );
false

gap> morphism_to_cobidual_c_cols = Opposite( morphism_from_bidual_a_rows );
false
gap> morphism_to_cobidual_c_cols = Opposite( morphism_from_bidual_b_rows );
false
gap> morphism_to_cobidual_c_cols = Opposite( morphism_from_bidual_d_rows );
false

gap> STOP_TEST("TensorCorrespondenceRowsAndOppositeOfRows.tst", 1);
