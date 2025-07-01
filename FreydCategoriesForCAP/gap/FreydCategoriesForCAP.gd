# SPDX-License-Identifier: GPL-2.0-or-later
# FreydCategoriesForCAP: Freyd categories - Formal (co)kernels for additive categories
#
# Declarations
#
#! @Chapter Basic operations

DeclareGlobalVariable( "FREYD_CATEGORIES_METHOD_NAME_RECORD" );

####################################
##
#! @Section Abelian constructions
##
####################################

#! @Description
#! The argument is a morphism $\alpha$.
#! The output is the source of <C>EpimorphismFromSomeProjectiveObjectForKernelObject</C> applied to $\alpha$.
#! @Returns an object
#! @Arguments alpha
DeclareAttribute( "SomeProjectiveObjectForKernelObject",
                  IsCapCategoryMorphism );

#! @Description
#! The argument is a morphism $\alpha$.
#! The output is an epimorphism $\pi: P \rightarrow \mathrm{KernelObject}( \alpha )$
#! with $P$ a projective object.
#! @Returns a morphism in $\mathrm{Hom}(P,\mathrm{KernelObject}( \alpha ))$
#! @Arguments alpha
DeclareAttribute( "EpimorphismFromSomeProjectiveObjectForKernelObject",
                  IsCapCategoryMorphism );

#! @Description
#! The arguments are a morphism $\alpha$ and an object $P = \mathrm{SomeProjectiveObjectForKernelObject}( \alpha )$.
#! The output is an epimorphism $\pi: P \rightarrow \mathrm{KernelObject}( \alpha )$.
#! @Returns a morphism in $\mathrm{Hom}(P,\mathrm{KernelObject}( \alpha ))$
#! @Arguments alpha
DeclareOperation( "EpimorphismFromSomeProjectiveObjectForKernelObjectWithGivenSomeProjectiveObjectForKernelObject",
                  [ IsCapCategoryMorphism, IsCapCategoryObject ] );

#! @Description
#! The argument is a morphism $\alpha$.
#! The output is the range of <C>MonomorphismToSomeInjectiveObjectForCokernelObject</C> applied to $\alpha$.
#! @Returns an object
#! @Arguments alpha
DeclareAttribute( "SomeInjectiveObjectForCokernelObject",
                  IsCapCategoryMorphism );

#! @Description
#! The argument is a morphism $\alpha$.
#! The output is a monomorphism $\iota: \mathrm{CokernelObject}( \alpha ) \rightarrow I$
#! with $I$ an injective object.
#! @Returns a morphism in $\mathrm{Hom}(\mathrm{CokernelObject}( \alpha ), I)$
#! @Arguments alpha
DeclareAttribute( "MonomorphismToSomeInjectiveObjectForCokernelObject",
                  IsCapCategoryMorphism );

#! @Description
#! The arguments are a morphism $\alpha$
#! and an object $I = \mathrm{SomeInjectiveObjectForCokernelObject}( \alpha )$.
#! The output is a monomorphism $\iota: \mathrm{CokernelObject}( \alpha ) \rightarrow I$.
#! @Returns a morphism in $\mathrm{Hom}(\mathrm{CokernelObject}( \alpha ), I)$
#! @Arguments alpha
DeclareOperation( "MonomorphismToSomeInjectiveObjectForCokernelObjectWithGivenSomeInjectiveObjectForCokernelObject",
                  [ IsCapCategoryMorphism, IsCapCategoryObject ] );

####################################
##
#! @Section Free abelian category
##
####################################

##
DeclareAttribute( "AsMorphismInFreeAbelianCategory",
                  IsCapCategoryMorphism );

####################################
##
#! @Section Finitely presented functors
##
####################################

##
DeclareOperation( "CovariantExtAsFreydCategoryObject",
                  [ IsCapCategoryObject, IsInt ] );


