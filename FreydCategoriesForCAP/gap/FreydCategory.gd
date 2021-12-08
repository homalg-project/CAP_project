# SPDX-License-Identifier: GPL-2.0-or-later
# FreydCategoriesForCAP: Freyd categories - Formal (co)kernels for additive categories
#
# Declarations
#
#! @Chapter Freyd category

####################################
##
#! @Section GAP Categories
##
####################################

DeclareCategory( "IsFreydCategoryObject",
                 IsCapCategoryObject );

DeclareCategory( "IsFreydCategoryMorphism",
                 IsCapCategoryMorphism );

DeclareCategory( "IsFreydCategory",
                 IsCapCategory );

DeclareGlobalFunction( "INSTALL_FUNCTIONS_FOR_FREYD_CATEGORY" );

####################################
##
#! @Section Constructors
##
####################################

DeclareGlobalFunction( "FREYD_CATEGORY" );

DeclareAttribute( "FreydCategory",
                  IsCapCategory );

DeclareAttribute( "FreydCategoryObject",
                  IsCapCategoryMorphism );

DeclareOperation( "FreydCategoryMorphism",
                  [ IsFreydCategoryObject, IsCapCategoryMorphism, IsFreydCategoryObject ] );

DeclareAttribute( "AsFreydCategoryObject",
                  IsCapCategoryObject );

DeclareAttribute( "AsFreydCategoryMorphism",
                  IsCapCategoryMorphism );

DeclareAttribute( "EmbeddingFunctorIntoFreydCategory",
                  IsCapCategory );

DeclareOperation( "\/",
                  [ IsCapCategoryObject, IsFreydCategory ] );

DeclareOperation( "\/",
                  [ IsCapCategoryMorphism, IsFreydCategory ] );

DeclareOperation( "\/",
                  [ IsHomalgMatrix, IsFreydCategory ] );

####################################
##
#! @Section Attributes
##
####################################

DeclareAttribute( "UnderlyingCategory",
                  IsFreydCategory );

DeclareAttribute( "RelationMorphism",
                  IsFreydCategoryObject );

DeclareAttribute( "UnderlyingMorphism",
                  IsFreydCategoryMorphism );

DeclareAttribute( "MorphismWitness",
                  IsFreydCategoryMorphism );

DeclareAttribute( "WitnessForBeingCongruentToZero",
                  IsFreydCategoryMorphism );

DeclareAttribute( "MereExistenceOfWitnessForBeingCongruentToZero",
                  IsFreydCategoryMorphism );

KeyDependentOperation( "FREYD_CATEGORIES_SimplifyObjectTuple", IsFreydCategoryObject, IsObject, ReturnTrue );

####################################################################################
##
#! @Section Determine properties of input category for Freyd category
##
####################################################################################

DeclareGlobalFunction( "IsValidInputForFreydCategory" );

##############################################
##
#! @Section Internal Hom-Embedding
##
##############################################

# Relax the conditions on a and b: they might not lie in the filter `IsFreydCategoryObject`, e.g. in the case of `LeftPresentationsAsFreydCategoryOfCategoryOfRows`
#! @Description
#! The arguments are two objects <A>a</A> and <A>b</A> of a Freyd category <A>cat</A>.
#! Assume that the relation morphism for $a$ is $\alpha \colon R_A \to A$, then we have the exact sequence
#! $0 \to \mathrm{\underline{Hom}} \left( a,b \right) \to \mathrm{\underline{Hom}}(A, b) \to \mathrm{\underline{Hom}}(R_A, b)$. The embedding of $\mathrm{\underline{Hom}}( a, b )$ 
#! into $\mathrm{\underline{Hom}}(A, b)$ is the internal Hom-embedding. This method returns this very map.
#! @Returns a (mono)morphism
#! @Arguments cat, a, b
DeclareOperationWithCache( "INTERNAL_HOM_EMBEDDING",
                           [ IsFreydCategory, IsCapCategoryObject, IsCapCategoryObject ] );


####################################################################################
##
#! @Section Convenient methods for tensor products of freyd objects and morphisms
##
####################################################################################

#!
DeclareOperation( "\*",
               [ IsFreydCategoryObject, IsFreydCategoryObject ] );

#!
DeclareOperation( "\^",
               [ IsFreydCategoryObject, IsInt ] );

#!
DeclareOperation( "\*",
               [ IsFreydCategoryMorphism, IsFreydCategoryMorphism ] );

#!
DeclareOperation( "\^",
               [ IsFreydCategoryMorphism, IsInt ] );
