#############################################################################
##
##                  GeneralizedMorphismsForCAP package
##
##  Copyright 2015, Sebastian Gutsche, TU Kaiserslautern
##                  Sebastian Posur,   RWTH Aachen
##
#! @Chapter Generalized Morphism Category by Cospans
##
#############################################################################

####################################
##
#! @Section GAP Categories
##
####################################

#! @Description
#! The GAP category of objects in the
#! generalized morphism category by cospans.
#! @Arguments object
DeclareCategory( "IsGeneralizedMorphismCategoryByCospansObject",
                 IsGeneralizedMorphismCategoryObject );

#! @Description
#! The GAP category of morphisms in the
#! generalized morphism category by cospans.
#! @Arguments object
DeclareCategory( "IsGeneralizedMorphismByCospan",
                 IsGeneralizedMorphism );

####################################
##
## Technical stuff
##
####################################

DeclareGlobalFunction( "INSTALL_FUNCTIONS_FOR_GENERALIZED_MORPHISM_CATEGORY_BY_COSPANS" );

DeclareFilter( "WasCreatedAsGeneralizedMorphismCategoryByCospans" );

DeclareProperty( "HasIdentityAsReversedArrow",
                 IsGeneralizedMorphismByCospan );

####################################
##
#! @Section Attributes
##
####################################

#! @Description
#! The argument is a generalized morphism $\alpha$ by 
#! a cospan $a \rightarrow b \leftarrow c$.
#! The output is its arrow $a \rightarrow b$.
#! @Returns a morphism in $\mathrm{Hom}_{\mathbf{A}}(a,c)$
#! @Arguments object
DeclareAttribute( "Arrow",
                  IsGeneralizedMorphismByCospan );

#! @Description
#! The argument is a generalized morphism $\alpha$ by 
#! a cospan $a \rightarrow b \leftarrow c$.
#! The output is its reversed arrow $b \leftarrow c$.
#! @Returns a morphism in $\mathrm{Hom}_{\mathbf{A}}(c,b)$
#! @Arguments object
DeclareAttribute( "ReversedArrow",
                  IsGeneralizedMorphismByCospan );

#! @Description
#! The argument is a generalized morphism $\alpha: a \rightarrow b$ by 
#! a cospan.
#! The output is its normalized cospan pair $(a \rightarrow d, d \leftarrow b)$.
#! @Returns a pair of morphisms in $\mathbf{A}$.
#! @Arguments object
DeclareAttribute( "NormalizedCospanTuple",
                  IsGeneralizedMorphismByCospan );

#! @Description
#! The argument is a generalized morphism $\alpha: a \rightarrow b$ by 
#! a cospan.
#! The output is its pseudo inverse $b \rightarrow a$.
#! @Returns a morphism in $\mathrm{Hom}_{\mathbf{G(A)}}(b,a)$
#! @Arguments alpha
DeclareAttribute( "PseudoInverse",
                  IsGeneralizedMorphismByCospan );

#! @Description
#! The argument is a morphism $\alpha: a \rightarrow b \in \mathbf{A}$.
#! The output is its generalized inverse $b \rightarrow a$ by cospan.
#! @Returns a morphism in $\mathrm{Hom}_{\mathbf{G(A)}}(b,a)$
#! @Arguments alpha
DeclareAttribute( "GeneralizedInverseByCospan",
                  IsCapCategoryMorphism );


DeclareAttribute( "IdempotentDefinedBySubobjectByCospan",
                  IsCapCategoryMorphism );

DeclareAttribute( "IdempotentDefinedByFactorobjectByCospan",
                  IsCapCategoryMorphism );

DeclareAttribute( "NormalizedCospan",
                  IsGeneralizedMorphismByCospan );

####################################
##
## Constructors
##
####################################

DeclareOperation( "GeneralizedMorphismFromFactorToSubobjectByCospan",
                  [ IsCapCategoryMorphism, IsCapCategoryMorphism ] );

####################################
##
## Constructors
##
####################################

DeclareOperation( "GeneralizedMorphismByCospan",
                  [ IsCapCategoryMorphism, IsCapCategoryMorphism ] );

DeclareOperation( "GeneralizedMorphismByCospan",
                  [ IsCapCategoryMorphism, IsCapCategoryMorphism, IsCapCategoryMorphism ] );

DeclareOperation( "GeneralizedMorphismByCospanWithSourceAid",
                  [ IsCapCategoryMorphism, IsCapCategoryMorphism ] );

DeclareAttribute( "AsGeneralizedMorphismByCospan",
                  IsCapCategoryMorphism );

DeclareAttribute( "GeneralizedMorphismCategoryByCospans",
                  IsCapCategory );

DeclareAttribute( "GeneralizedMorphismByCospansObject",
                  IsCapCategoryObject );


