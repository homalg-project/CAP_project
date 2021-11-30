# SPDX-License-Identifier: GPL-2.0-or-later
# MonoidalCategories: Monoidal and monoidal (co)closed categories
#
# Declarations
#

####################################
##
#! @Chapter Monoidal Categories
##
#! @Section Rigid Symmetric Closed Monoidal Categories
##
####################################

#! A symmetric closed monoidal category $\mathbf{C}$ satisfying
#! * the natural morphism
#!  $\mathrm{\underline{Hom}}(a, a') \otimes \mathrm{\underline{Hom}}(b, b') \rightarrow \mathrm{\underline{Hom}}(a \otimes b, a' \otimes b')$
#!  is an isomorphism,
#! * the natural morphism
#!  $a \rightarrow \mathrm{\underline{Hom}}(\mathrm{\underline{Hom}}(a, 1), 1)$
#!  is an isomorphism
#! is called a <Emph>rigid symmetric closed monoidal category</Emph>.

CAP_INTERNAL_CONSTRUCTIVE_CATEGORIES_RECORD.IsRigidSymmetricClosedMonoidalCategory  := Concatenation( [ 
"TensorProductInternalHomCompatibilityMorphismInverseWithGivenObjects",
"MorphismFromBidualWithGivenBidual"
], CAP_INTERNAL_CONSTRUCTIVE_CATEGORIES_RECORD.IsSymmetricClosedMonoidalCategory );

InstallTrueMethod( IsSymmetricClosedMonoidalCategory, IsRigidSymmetricClosedMonoidalCategory );
