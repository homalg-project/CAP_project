# SPDX-License-Identifier: GPL-2.0-or-later
# GeneralizedMorphismsForCAP: Implementations of generalized morphisms for the CAP project
#
# Declarations
#

#! @Chapter Serre Quotients

#! @Section Serre quotients by cospans

DeclareCategory( "IsSerreQuotientCategoryByCospansObject",
                 IsSerreQuotientCategoryObject );

DeclareCategory( "IsSerreQuotientCategoryByCospansMorphism",
                 IsSerreQuotientCategoryMorphism );

##############################################
##
## Attributes for serre category
##
##############################################

DeclareFilter( "WasCreatedAsSerreQuotientCategoryByCospans" );

##############################################
##
## Attributes
##
##############################################

##############################################
##
## Constructor
##
##############################################

#! @BeginGroup
#! @Description
#!  Creates a Serre quotient category S with name <A>name</A> out of an Abelian category <A>A</A>.
#!  The Serre quotient category will be modeled upon the generalized morphisms by cospans category of <A>A</A>
#!  If <A>name</A> is not given, a generic name is constructed out of the name of <A>A</A>.
#!  The argument <A>func</A> must be a unary function on the objects of <A>A</A> deciding the membership in
#!  the thick subcategory C mentioned above.
#! @Arguments A,func[,name]
#! @Returns a CAP category
DeclareOperation( "SerreQuotientCategoryByCospans",
                  [ IsCapCategory, IsFunction, IsString ] );

DeclareOperation( "SerreQuotientCategoryByCospans",
                  [ IsCapCategory, IsFunction ] );
#! @EndGroup

#! @Description
#!  Given a Serre quotient category <A>A/C</A> modeled by cospans and an object <A>M</A> in <A>A</A>,
#!  this constructor returns the corresponding object in the Serre quotient category.
#! @Arguments A/C, M
#! @Returns an object
DeclareOperation( "AsSerreQuotientCategoryByCospansObject",
                  [ IsCapCategory, IsCapCategoryObject ] );

#! @Description
#!  Given a Serre quotient category <A>A/C</A> modeled by cospans and a generalized morphism <A>phi</A> in
#!  the generalized morphism category <A>A/C</A> is modeled upon,
#!  this constructor returns the corresponding morphism in the Serre quotient category.
#! @Arguments A/C, phi
#! @Returns a morphism
DeclareOperation( "SerreQuotientCategoryByCospansMorphism",
                  [ IsCapCategory, IsGeneralizedMorphismByCospan ] );

#! @Description
#!  Given a Serre quotient category <A>A/C</A> modeled by cospans and three morphisms $\iota: M' \rightarrow M$,
#!  $\phi: M' \rightarrow N'$ and $\pi: N \rightarrow N'$ this operation contructs a
#!  morphism in the Serre quotient category.
#! @Arguments A/C, iota, phi, pi
#! @Returns a morphism
DeclareOperation( "SerreQuotientCategoryByCospansMorphism",
                  [ IsCapCategory, IsCapCategoryMorphism, IsCapCategoryMorphism, IsCapCategoryMorphism ] );

#! @Description
#!  Given a Serre quotient category <A>A/C</A> modeled by cospans and two morphisms $\alpha: M \rightarrow X$
#!  and $\beta: X \rightarrow N$
#!  this operation constructs the corresponding morphism in the Serre quotient category.
#! @Arguments A/C, alpha, beta
#! @Returns a morphism
DeclareOperation( "SerreQuotientCategoryByCospansMorphismWithSourceAid",
                  [ IsCapCategory, IsCapCategoryMorphism, IsCapCategoryMorphism ] );

#! @Description
#!  Given a Serre quotient category <A>A/C</A> modeled by cospans and two morphisms $\alpha: X \rightarrow M$
#!  and $\beta: X \rightarrow N$
#!  this operation constructs the corresponding morphism in the Serre quotient category.
#! @Arguments A/C, alpha, beta
#! @Returns a morphism
DeclareOperation( "SerreQuotientCategoryByCospansMorphism",
                  [ IsCapCategory, IsCapCategoryMorphism, IsCapCategoryMorphism ] );

#! @Description
#!  Given a Serre quotient category <A>A/C</A> modeled by cospans and a morphism <A>phi</A> in <A>A</A>,
#!  this constructor returns the corresponding morphism in the Serre quotient category.
#! @Arguments A/C, phi
#! @Returns a morphism
DeclareOperation( "AsSerreQuotientCategoryByCospansMorphism",
                  [ IsCapCategory, IsCapCategoryMorphism ] );

