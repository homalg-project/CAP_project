#############################################################################
##
##                  CAPCategoryOfProjectiveGradedModules package
##
##  Copyright 2015, Martin Bies,       ITP Heidelberg
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
#! over $R$ and a subsemigroup $H$ in the degree group of $R$. We expect that $H$ is given to the
#! method as a list of its generators.
#! Under these circumstances we truncate $M$ to the subsemigroup $H$.
#! @Returns an object
#! @Arguments M, H
DeclareOperation( "TruncationOfProjectiveGradedModule",
                   [ IsCAPCategoryOfProjectiveGradedLeftOrRightModulesObject, IsSemigroupGeneratorList ] );

#! @Description
#! Consider a graded ring $R$ such that its degree group is identical to $\mathbb{Z}^n$ for
#! suitable $n \in \mathbb{N}_{\geq 0}$. Then consider a projective graded left module $M$
#! over $R$ and the semigroup $H$ of a cone in the degree group of $R$, given as a ConeHPresentationList.
#! Under these circumstances we truncate $M$ to this subsemigroup $H$.
#! @Returns an object
#! @Arguments M, H
DeclareOperation( "TruncationOfProjectiveGradedModule",
                   [ IsCAPCategoryOfProjectiveGradedLeftOrRightModulesObject, IsConeHPresentationList ] );

#! @Description
#! Consider a graded ring $R$ such that its degree group is identical to $\mathbb{Z}^n$ for
#! suitable $n \in \mathbb{N}_{\geq 0}$. Then consider a projective graded left module $M$
#! over $R$ and a subsemigroup $H$ in the degree group of $R$. We expect that $H$ is given to the
#! method as a list of its generators.
#! Under these circumstances we compute the embedding of the truncation of $M$ onto the subsemigroup $H$
#! into $M$.
#! @Returns a morphism
#! @Arguments M, H
DeclareOperation( "EmbeddingOfTruncationOfProjectiveGradedModule",
                   [ IsCAPCategoryOfProjectiveGradedLeftOrRightModulesObject, IsSemigroupGeneratorList ] );

#! @Description
#! Consider a graded ring $R$ such that its degree group is identical to $\mathbb{Z}^n$ for
#! suitable $n \in \mathbb{N}_{\geq 0}$. Then consider a projective graded left module $M$
#! over $R$ and the semigroup $H$ of a cone in the degree group of $R$, given as a ConeHPresentationList.
#! Under these circumstances we compute the embedding of the truncation of $M$ onto the subsemigroup $H$
#! into $M$.
#! @Returns a morphism
#! @Arguments M, H
DeclareOperation( "EmbeddingOfTruncationOfProjectiveGradedModule",
                   [ IsCAPCategoryOfProjectiveGradedLeftOrRightModulesObject, IsConeHPresentationList ] );

#! @Description
#! Consider a graded ring $R$ such that its degree group is identical to $\mathbb{Z}^n$ for
#! suitable $n \in \mathbb{N}_{\geq 0}$. Then consider a projective graded left module $M$
#! over $R$ and a subsemigroup $H$ in the degree group of $R$. We expect that $H$ is given to the
#! method as a list of its generators.
#! Under these circumstances we compute the projection morphism of $M$ onto its truncation to the 
#! subsemigroup $H$
#! @Returns a morphism
#! @Arguments M, H
DeclareOperation( "ProjectionOntoTruncationOfProjectiveGradedModule",
                   [ IsCAPCategoryOfProjectiveGradedLeftOrRightModulesObject, IsSemigroupGeneratorList ] );

#! @Description
#! Consider a graded ring $R$ such that its degree group is identical to $\mathbb{Z}^n$ for
#! suitable $n \in \mathbb{N}_{\geq 0}$. Then consider a projective graded left module $M$
#! over $R$ and the semigroup $H$ of a cone in the degree group of $R$, given as a ConeHPresentationList.
#! Under these circumstances we compute the projection morphism of $M$ onto its truncation to the 
#! subsemigroup $H$
#! @Returns a morphism
#! @Arguments M, H
DeclareOperation( "ProjectionOntoTruncationOfProjectiveGradedModule",
                   [ IsCAPCategoryOfProjectiveGradedLeftOrRightModulesObject, IsConeHPresentationList ] );



###############################################
##
#! @Section The truncation functor
##
###############################################

# a function that computes the truncation functor to semigroups for both projective left and right modules
DeclareGlobalFunction( "TruncationFunctorForProjectiveGradedModulesToSemigroups" );

# a function that computes the truncation functor to cones for both projective left and right modules
DeclareGlobalFunction( "TruncationFunctorForProjectiveGradedModulesToCones" );

#! @Description
#! The argument is a homalg graded ring $R$ and a subsemigroup $H$ (given as a list of generators) in the
#! degree group of the ring $R$. The output is the functor which truncates projective graded 
#! left-modules and left-module-morphisms to the subsemigroup $H$. 
#! @Returns a functor
#! @Arguments R, H
DeclareOperation( "TruncationFunctorForProjectiveGradedLeftModules",
                  [ IsHomalgGradedRing, IsSemigroupGeneratorList ] );

#! @Description
#! The argument is a homalg graded ring $R$ and the subsemigroup $H$ of a cone (given as a list of h-constraints) in the
#! degree group of the ring $R$. The output is the functor which truncates projective graded 
#! left-modules and left-module-morphisms to the subsemigroup $H$. 
#! @Returns a functor
#! @Arguments R, H
DeclareOperation( "TruncationFunctorForProjectiveGradedLeftModules",
                  [ IsHomalgGradedRing, IsConeHPresentationList ] );

#! @Description
#! The argument is a homalg graded ring $R$ and a subsemigroup $H$ (given as a list of generators) in the
#! degree group of the ring $R$. The output is the functor which truncates projective graded 
#! right-modules and right-module-morphisms to the subsemigroup $H$. 
#! @Returns a functor
#! @Arguments R, H
DeclareOperation( "TruncationFunctorForProjectiveGradedRightModules",
                  [ IsHomalgGradedRing, IsSemigroupGeneratorList ] );

#! @Description
#! The argument is a homalg graded ring $R$ and a subsemigroup $H$ of a cone (given as a list of h-constraints) in the
#! degree group of the ring $R$. The output is the functor which truncates projective graded 
#! right-modules and right-module-morphisms to the subsemigroup $H$. 
#! @Returns a functor
#! @Arguments R, H
DeclareOperation( "TruncationFunctorForProjectiveGradedRightModules",
                  [ IsHomalgGradedRing, IsConeHPresentationList ] );