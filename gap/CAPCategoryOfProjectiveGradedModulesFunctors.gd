#############################################################################
##
##                  CAPCategoryOfProjectiveGradedModules package
##
##  Copyright 2015, Sebastian Gutsche, TU Kaiserslautern
##                  Sebastian Posur,   RWTH Aachen
##                  Martin Bies,       ITP Heidelberg
##
#! @Chapter Functors for the category of projective graded left modules
##
#############################################################################


###############################################
##
#! @Section Basic functionality for truncations
##
###############################################

#! @Description
#! Consider a graded ring $R$ such that its degree group is identical to $\mathbb{Z}^n$ for
#! suitable $n \in \mathbb{N}_{\geq 0}$. Then consider a projective graded left module $M$
#! over $R$ and a cone $C$ in the degree group of $R$. We expect that $C$ is given to the
#! method as an H-presentation.
#! Under these circumstances this method truncates $M$ to the semigroup of the cone $C$.
#! @Returns an object
#! @Arguments S, C
DeclareOperation( "TruncationOfProjectiveGradedModule",
                   [ IsCAPCategoryOfProjectiveGradedLeftOrRightModulesObject, IsList ] );

#! @Description
#! Consider a graded ring $R$ such that its degree group is identical to $\mathbb{Z}^n$ for
#! suitable $n \in \mathbb{N}_{\geq 0}$. Then consider a projective graded left module $M$
#! over $R$ and a cone $C$ in the degree group of $R$. We expect that $C$ is given to the
#! method as an H-presentation.
#! Under these circumstances this method computes the embedding of the truncation of $M$ 
#! into $M$.
#! @Returns a morphism
#! @Arguments S, C
DeclareOperation( "EmbeddingOfTruncationOfProjectiveGradedModule",
                   [ IsCAPCategoryOfProjectiveGradedLeftOrRightModulesObject, IsList ] );


###############################################
##
#! @Section The truncation functor
##
###############################################

# a function that computes the truncation functor for both projective left and right modules
DeclareGlobalFunction( "TruncationFunctor" );

#! @Description
#! The argument is a homalg graded ring $R$ and a cone $C$ (given by a H-presentation) in the
#! degree group of the ring $R$. The output is the functor which truncates projective graded 
#! left-modules and right-module morphisms to the cone $C$. 
#! @Returns a functor
#! @Arguments R, C
DeclareOperation( "TruncationFunctorLeft",
                  [ IsHomalgGradedRing, IsList ] );
                  
#! @Description
#! The argument is a homalg graded ring $R$ and a cone $C$ (given by a H-presentation) in the
#! degree group of the ring $R$. The output is the functor which truncates projective graded 
#! right-modules and right-module morphisms to the cone $C$. 
#! @Returns a functor
#! @Arguments R, C
DeclareOperation( "TruncationFunctorRight",
                  [ IsHomalgGradedRing, IsList ] );