#############################################################################
##
##                  CAPCategoryOfProjectiveGradedModules package
##
##  Copyright 2015, Sebastian Gutsche, TU Kaiserslautern
##                  Sebastian Posur,   RWTH Aachen
##                  Martin Bies,       ITP Heidelberg
##
#! @Chapter Morphisms
##
#############################################################################

####################################
##
#! @Section GAP Categories
##
####################################

#! @Description
#! The GAP category of morphisms of projective graded left or right modules
#! over a graded ring $R$.
#! @Arguments object
DeclareCategory( "IsCAPCategoryOfProjectiveGradedLeftOrRightModulesMorphism",
                 IsCapCategoryMorphism );

#! @Description
#! The GAP category of morphisms of projective graded left modules
#! over a graded ring $R$.
#! @Arguments object
DeclareCategory( "IsCAPCategoryOfProjectiveGradedLeftModulesMorphism",
                 IsCAPCategoryOfProjectiveGradedLeftOrRightModulesMorphism );

#! @Description
#! The GAP category of morphisms of projective graded right modules
#! over a graded ring $R$.
#! @Arguments object                 
DeclareCategory( "IsCAPCategoryOfProjectiveGradedRightModulesMorphism",
                 IsCAPCategoryOfProjectiveGradedLeftOrRightModulesMorphism );
                 
####################################
##
#! @Section Constructors
##
####################################

#! @Description
#! The arguments are an object $S$ in the category of projective graded left or right modules
#! over a homalg graded ring $R$,a homalg matrix $M$ over $R$, and another object $T$
#! in the category of projective graded left or right modules over $R$.
#! The output is the morphism $S \rightarrow T$ in the category
#! of projective graded left or right modules over $R$, whose underlying matrix is given by $M$.
#! @Returns a morphism in $\mathrm{Hom}(S,T)$
#! @Arguments S, M, T
DeclareOperation( "CAPCategoryOfProjectiveGradedLeftOrRightModulesMorphism",
               [ IsCAPCategoryOfProjectiveGradedLeftOrRightModulesObject, IsHomalgMatrix, 
                                                                 IsCAPCategoryOfProjectiveGradedLeftOrRightModulesObject ] );

####################################
##
#! @Section Attributes
##
####################################

#! @Description
#! The argument is a morphism $\alpha$ in the category of projective graded left or right modules
#! over a homalg graded ring $R$. 
#! The output is the homalg graded ring $R$.
#! @Returns a homalg graded ring
#! @Arguments alpha
DeclareAttribute( "UnderlyingHomalgGradedRing",
                  IsCAPCategoryOfProjectiveGradedLeftOrRightModulesMorphism );

#! @Description
#! The argument is a morphism $\alpha$ in the category of projective graded left or right modules
#! over a homalg graded ring $R$. 
#! The output is the underlying homalg matrix over $R$.
#! @Returns a matrix over a homalg graded ring
#! @Arguments alpha
DeclareAttribute( "UnderlyingHomalgMatrix",
                  IsCAPCategoryOfProjectiveGradedLeftOrRightModulesMorphism );

                  
#####################################################
##
#! @Section Printing all information about a morphism
##
#####################################################

#! @Description
#! The argument is a morphism $m$ in the category of projective graded modules. For such a morphisms it will 
#! take three command to print source, range and the mapping matrix. This method performs this task immediately.
#! and prints all this information.
#! @Returns detailed information about the morphism
#! @Arguments m
DeclareOperation( "FullInformation",
                 [ IsCAPCategoryOfProjectiveGradedLeftOrRightModulesMorphism ] );
