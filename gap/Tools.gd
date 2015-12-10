#############################################################################
##
##                  CAPCategoryOfProjectiveGradedModules package
##
##  Copyright 2015, Martin Bies,       ITP Heidelberg
##
#! @Chapter Tool methods
##
#############################################################################



############################################
##
#! @Section Tools to simplify code
##
############################################

#! @Description
#! The argument is a homalg_matrix <A>m</A> and a left_module <A>R</A>. We then consider the module map 
#! induced from <A>m</A> with range <A>R</A>. This operation then deduces the source of this map and returns
#! the map in the category of projective graded left-modules.
#! @Returns a morphism
#! @Arguments m, R
DeclareOperation( "DeduceMapFromMatrixAndRangeLeft",
                  [ IsHomalgMatrix, IsCAPCategoryOfProjectiveGradedLeftModulesObject ] );

#! @Description
#! The argument is a homalg_matrix <A>m</A> and a left_module <A>S</A>. We then consider the module map 
#! induced from <A>m</A> with source <A>S</A>. This operation then deduces the range of this map and returns
#! the map in the category of projective graded left-modules.
#! @Returns a morphism
#! @Arguments m, S
DeclareOperation( "DeduceMapFromMatrixAndSourceLeft",
                  [ IsHomalgMatrix, IsCAPCategoryOfProjectiveGradedLeftModulesObject ] );

#! @Description
#! The argument is a homalg_matrix <A>m</A> and a right_module <A>R</A>. We then consider the module map 
#! induced from <A>m</A> with range <A>R</A>. This operation then deduces the source of this map and returns
#! the map in the category of projective graded right-modules.
#! @Returns a morphism
#! @Arguments m, R
DeclareOperation( "DeduceMapFromMatrixAndRangeRight",
                  [ IsHomalgMatrix, IsCAPCategoryOfProjectiveGradedRightModulesObject ] );

#! @Description
#! The argument is a homalg_matrix <A>m</A> and a left_module <A>S</A>. We then consider the module map 
#! induced from <A>m</A> with source <A>S</A>. This operation then deduces the range of this map and returns
#! the map in the category of projective graded right-modules.
#! @Returns a morphism
#! @Arguments m, S
DeclareOperation( "DeduceMapFromMatrixAndSourceRight",
                  [ IsHomalgMatrix, IsCAPCategoryOfProjectiveGradedRightModulesObject ] );

DeclareOperation( "UnzipDegreeList",
                  [ IsCAPCategoryOfProjectiveGradedLeftModulesObject ] );

DeclareOperation( "UnzipDegreeList",
                  [ IsCAPCategoryOfProjectiveGradedRightModulesObject ] );



###############################################################################
##
#! @Section Check if point is contained in (affine) cone or (affine ) semigroup
##
###############################################################################

#! @Description
#! The arguments are a cone $C$ and an integral point $p$. This operation then checks if the point $p$ is contained in $C$.
#! The cone $C$ can be specified either as ConeHPresentationList, as ConeVPresentationList or a NormalizCone.
#! @Returns true or false
#! @Arguments C, p
DeclareOperation( "PointContainedInCone",
                  [ IsConeHPresentationList, IsList ] );

DeclareOperation( "PointContainedInCone",
                  [ IsConeVPresentationList, IsList ] );

DeclareOperation( "PointContainedInCone",
                  [ IsNormalizCone, IsList ] );

#! @Description
#! The argument is a subsemigroup $S$ of $\mathbb{Z}^n$ given by a list of generators and an integral point $p$.
#! This operation then verifies if the point $p$ is contained in $S$ or not.
#! @Returns true or false
#! @Arguments S, p
DeclareOperation( "PointContainedInSemigroup",
                  [ IsSemigroupGeneratorList, IsList ] );

#! @Description
#! The first argument is an affine cone semigroup $H$, i.e. $H = p + \left( C \cap \mathbb{Z}^n \right)$ for a cone $C$ and a 
#! point $p$. The second argument is a point $Q$. This method then checks if $Q$ lies in $H$.
#! @Returns true or false
#! @Arguments H, Q
DeclareOperation( "PointContainedInAffineConeSemigroup",
                  [ IsAffineConeSemigroup, IsList ] );

#! @Description
#! The first argument is an affine semigroup $H$, i.e. $H = p + S $ for a semigroup $S \subseteq \mathbb{Z}^n$ and a 
#! point $p$. The second argument is a point $Q$. This method then checks if $Q$ lies in $H$.
#! @Returns true or false
#! @Arguments H, Q
DeclareOperation( "PointContainedInAffineSemigroup",
                  [ IsAffineSemigroup, IsList ] );