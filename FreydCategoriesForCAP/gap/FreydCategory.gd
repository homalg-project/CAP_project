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

DeclareGlobalFunction( "ADD_MONOIDAL_STRUCTURE_TO_FREYD_CATEGORY" );

DeclareGlobalFunction( "TODO_LIST_ENTRY_FOR_MORPHISM_WITNESS_FOR_FREYD_CATEGORY" );

####################################
##
#! @Section Constructors
##
####################################

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

##############################################
##
#! @Section Internal Hom-Embedding
##
##############################################

#! @Description
#! The arguments are two objects <A>a</A> and <A>b</A> of a Freyd category.
#! Assume that the relation morphism for $a$ is $\alpha \colon R_A \to A$, we have the exact sequence
#! $0 \to Hom \left( a,b \right) \to A^\vee \otimes b \to R_A^\vee \otimes b$. The latter map is
#! given by $\alpha^\vee \otimes 1_b$. The kernel embedding of this map is the internal Hom-embedding.
#! This method returns this monomorphism.
#! @Returns a (mono)morphism
#! @Arguments objects a, b
DeclareOperationWithCache( "INTERNAL_HOM_EMBEDDING_IN_TENSOR_PRODUCT",
                           [ IsFreydCategoryObject, IsFreydCategoryObject ] );

#############################################################
##
#! @Section Printing all information about an object/morphism
##
#############################################################

#! @Description
#! The argument is an object $A$ in the Freyd category. For such an object, this method conveniently displays
#! all defining data, i.e. source, mapping matrix and range.
#! @Returns detailed information about the object A
#! @Arguments A
DeclareOperation( "FullInformation",
                 [ IsFreydCategoryObject ] );

#! @Description
#! The argument is a morphism $m$ in the Freyd category. For such a morphism, this method conveniently displays
#! all defining data, i.e. defining data of its source, the mapping matrix and the defining data of its range.
#! @Returns detailed information about the morphism
#! @Arguments m
DeclareOperation( "FullInformation",
                 [ IsFreydCategoryMorphism ] );

####################################################################################
##
#! @Section Determine properties of input category for Freyd category
##
####################################################################################

DeclareGlobalFunction( "IsValidInput" );

DeclareGlobalFunction( "IsMonoidalStructurePresent" );
