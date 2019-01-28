####################################
##
#! @Chapter Monoidal Categories
##
#! @Section Rigid Symmetric Closed Monoidal Categories
##
####################################

#! A symmetric closed monoidal category $\mathbf{C}$ satisfying
#! * the natural morphism
#!  $\mathrm{\underline{Hom}}(a_1,b_1) \otimes \mathrm{\underline{Hom}}(a_2,b_2) \rightarrow \mathrm{\underline{Hom}}(a_1 \otimes a_2,b_1 \otimes b_2)$
#!  is an isomorphism,
#! * the natural morphism
#!  $a \rightarrow \mathrm{\underline{Hom}}(\mathrm{\underline{Hom}}(a, 1), 1)$
#!  is an isomorphism
#! is called a <Emph>rigid symmetric closed monoidal category</Emph>.

AddCategoricalProperty( [ "IsRigidSymmetricClosedMonoidalCategory" ] );

CAP_INTERNAL_CONSTRUCTIVE_CATEGORIES_RECORD.IsRigidSymmetricClosedMonoidalCategory  := Concatenation( [ 
"TensorProductInternalHomCompatibilityMorphismInverseWithGivenObjects",
"MorphismFromBidualWithGivenBidual"
], CAP_INTERNAL_CONSTRUCTIVE_CATEGORIES_RECORD.IsSymmetricClosedMonoidalCategory );

InstallTrueMethod( IsSymmetricClosedMonoidalCategory, IsRigidSymmetricClosedMonoidalCategory );
