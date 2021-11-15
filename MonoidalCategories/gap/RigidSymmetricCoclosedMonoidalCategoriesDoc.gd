####################################
##
#! @Chapter Monoidal Categories
##
#! @Section Rigid Symmetric Coclosed Monoidal Categories
##
####################################

#! A symmetric coclosed monoidal category $\mathbf{C}$ satisfying
#! * the natural morphism
#!  $\mathrm{\underline{coHom}}(a_1 \otimes a_2, b_1 \otimes b_2) \rightarrow \mathrm{\underline{coHom}}(a_1, b_1) \otimes \mathrm{\underline{coHom}}(a_2, b_2)$
#!  is an isomorphism,
#! * the natural morphism
#!  $\mathrm{\underline{coHom}}(1, \mathrm{\underline{coHom}}(1, a)) \rightarrow a$
#!  is an isomorphism
#! is called a <Emph>rigid symmetric coclosed monoidal category</Emph>.

AddCategoricalProperty( [ "IsRigidSymmetricCoclosedMonoidalCategory", fail ] );

CAP_INTERNAL_CONSTRUCTIVE_CATEGORIES_RECORD.IsRigidSymmetricCoclosedMonoidalCategory  := Concatenation( [ 
"InternalCoHomTensorProductCompatibilityMorphismInverseWithGivenObjects",
"MorphismToCoBidualWithGivenCoBidual"
], CAP_INTERNAL_CONSTRUCTIVE_CATEGORIES_RECORD.IsSymmetricCoclosedMonoidalCategory );

InstallTrueMethod( IsSymmetricCoclosedMonoidalCategory, IsRigidSymmetricCoclosedMonoidalCategory );
