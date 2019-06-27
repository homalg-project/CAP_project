#############################################################################
##
##     FreydCategoriesForCAP: Freyd categories - Formal (co)kernels for additive categories
##
##  Copyright 2018, Sebastian Posur, University of Siegen
##
#! @Chapter Freyd category
#!
#############################################################################

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

DeclareGlobalFunction( "TODO_LIST_ENTRY_FOR_MORPHISM_WITNESS_FOR_FREYD_CATEGORY" );

####################################
##
#! @Section Constructors
##
####################################

DeclareGlobalFunction( "FREYD_CATEGORY" );

DeclareGlobalFunction( "FREYD_CATEGORY_OBJECT" );

DeclareGlobalFunction( "FREYD_CATEGORY_MORPHISM" );

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


####################################
##
#! @Section Attributes
##
####################################

DeclareAttribute( "UnderlyingCategory",
                  IsFreydCategory );

DeclareAttribute( "RelationMorphism",
                  IsFreydCategoryObject );

DeclareAttribute( "MorphismDatum",
                  IsFreydCategoryMorphism );

DeclareAttribute( "MorphismWitness",
                  IsFreydCategoryMorphism );

DeclareAttribute( "WitnessForBeingCongruentToZero",
                  IsFreydCategoryMorphism );

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

#! @Description
#! The arguments are two objects <A>a</A> and <A>b</A> of a Freyd category.
#! Assume that the relation morphism for $a$ is $\alpha \colon R_A \to A$, then we have the exact sequence
#! $0 \to \mathrm{\underline{Hom}} \left( a,b \right) \to \mathrm{\underline{Hom}}(A, b) \to \mathrm{\underline{Hom}}(R_A, b)$. The embedding of $\mathrm{\underline{Hom}}( a, b )$ 
#! into $\mathrm{\underline{Hom}}(A, b)$ is the internal Hom-embedding. This method returns this very map.
#! @Returns a (mono)morphism
#! @Arguments objects a, b
DeclareOperationWithCache( "INTERNAL_HOM_EMBEDDING",
                           [ IsFreydCategoryObject, IsFreydCategoryObject ] );


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
