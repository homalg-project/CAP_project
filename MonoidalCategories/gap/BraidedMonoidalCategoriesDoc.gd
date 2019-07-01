####################################
##
#! @Chapter Monoidal Categories
##
#! @Section Braided Monoidal Categories
##
####################################

#! A monoidal category $\mathbf{C}$ equipped with a natural isomorphism
#! $B_{a,b}: a \otimes b \cong b \otimes a$
#! is called a <Emph>braided monoidal category</Emph>
#! if
#! * $\lambda_a \circ B_{a,1} = \rho_a$,
#! * $(B_{c,a} \otimes \mathrm{id}_b) \circ \alpha_{c,a,b} \circ B_{a \otimes b,c} = \alpha_{a,c,b} \circ ( \mathrm{id}_a \otimes B_{b,c}) \circ \alpha^{-1}_{a,b,c}$,
#! * $( \mathrm{id}_b \otimes B_{c,a} ) \circ \alpha^{-1}_{b,c,a} \circ B_{a,b \otimes c} = \alpha^{-1}_{b,a,c} \circ (B_{a,b} \otimes \mathrm{id}_c) \circ \alpha_{a,b,c}$.

#! The corresponding GAP property is given by
#! <C>IsBraidedMonoidalCategory</C>.

AddCategoricalProperty( [ "IsBraidedMonoidalCategory" ] );

CAP_INTERNAL_CONSTRUCTIVE_CATEGORIES_RECORD.IsBraidedMonoidalCategory  := Concatenation( [
"BraidingWithGivenTensorProducts",
"BraidingInverseWithGivenTensorProducts"
], CAP_INTERNAL_CONSTRUCTIVE_CATEGORIES_RECORD.IsMonoidalCategory );

InstallTrueMethod( IsMonoidalCategory, IsBraidedMonoidalCategory );
