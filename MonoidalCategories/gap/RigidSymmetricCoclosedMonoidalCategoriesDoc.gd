# SPDX-License-Identifier: GPL-2.0-or-later
# MonoidalCategories: Monoidal and monoidal (co)closed categories
#
# Declarations
#

####################################
##
#! @Chapter Monoidal Categories
##
#! @Section Rigid Symmetric Coclosed Monoidal Categories
##
####################################

#! A symmetric coclosed monoidal category $\mathbf{C}$ satisfying
#! * the natural morphism
#!  $\mathrm{\underline{coHom}}(a \otimes a', b \otimes b') \rightarrow \mathrm{\underline{coHom}}(a, b) \otimes \mathrm{\underline{coHom}}(a', b')$
#!  is an isomorphism,
#! * the natural morphism
#!  $\mathrm{\underline{coHom}}(1, \mathrm{\underline{coHom}}(1, a)) \rightarrow a$
#!  is an isomorphism
#! is called a <Emph>rigid symmetric coclosed monoidal category</Emph>.

CAP_INTERNAL_CONSTRUCTIVE_CATEGORIES_RECORD.IsRigidSymmetricCoclosedMonoidalCategory  := Concatenation( [ 
"InternalCoHomTensorProductCompatibilityMorphismInverseWithGivenObjects",
"MorphismToCoBidualWithGivenCoBidual"
], CAP_INTERNAL_CONSTRUCTIVE_CATEGORIES_RECORD.IsSymmetricCoclosedMonoidalCategory );

InstallTrueMethod( IsSymmetricCoclosedMonoidalCategory, IsRigidSymmetricCoclosedMonoidalCategory );
