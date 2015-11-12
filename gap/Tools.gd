#############################################################################
##
##                  CAPCategoryOfProjectiveGradedModules package
##
##  Copyright 2015, Sebastian Gutsche, TU Kaiserslautern
##                  Sebastian Posur,   RWTH Aachen
##                  Martin Bies,       ITP Heidelberg
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



########################################################################
##
#! @Section Check if point is contained in cone (needed for truncations)
##
########################################################################

#! @Description
#! The argument is a cone $C$ given by a list of (integral) hyperplane constraints and an integral point $p$.
#! This operation then verifies if the point $p$ satisfies all of the hyperplane constraints of not. Thereby
#! it determines if the point is contained in the cone or not.
#! @Returns true or false
#! @Arguments C, p
DeclareOperation( "PointContainedInCone",
                  [ IsList, IsList ] );

