#############################################################################
##
##                  CAPCategoryOfProjectiveGradedModules package
##
##  Copyright 2015, Sebastian Gutsche, TU Kaiserslautern
##                  Sebastian Posur,   RWTH Aachen
##                  Martin Bies,       ITP Heidelberg
##
#! @Chapter Objects
##
#############################################################################

####################################
##
#! @Section GAP Categories
##
####################################

#! @Description
#! The GAP category of objects in the CAP category of projective graded left or right modules
#! over a graded ring $R$.
#! @Arguments object
DeclareCategory( "IsCAPCategoryOfProjectiveGradedLeftOrRightModulesObject",
                 IsCapCategoryObject );

#! @Description
#! The GAP category of objects in the CAP category of projective graded left modules
#! over a graded ring $R$.
#! @Arguments object
DeclareCategory( "IsCAPCategoryOfProjectiveGradedLeftModulesObject",
                 IsCAPCategoryOfProjectiveGradedLeftOrRightModulesObject );

#! @Description
#! The GAP category of objects in the CAP category of projective graded right modules
#! over a graded ring $R$.
#! @Arguments object
DeclareCategory( "IsCAPCategoryOfProjectiveGradedRightModulesObject",
                 IsCAPCategoryOfProjectiveGradedLeftOrRightModulesObject );

####################################
##
#! @Section Constructors
##
####################################

DeclareGlobalFunction( "CAPCategoryOfProjectiveGradedLeftOrRightModulesObject" );

#! @Description
#! The arguments are a list of degrees and a homalg graded ring $R$. 
#! The list of degrees must be of the form [ [ $d_1$, $n_1$ ], [ $d_2$, $n_2$ ], ... ] where $d_i$
#! are degrees, i.e. elements in the degree group of $R$ and the $n_i$ are non-negative integers.
#! Currently there are two formats that are supported to enter the degrees. Either one can enter
#! them as lists of integers, say $d_1 = [ 1,1,0,2 ]$, or they can be entered as Homalg_Module_Elements
#! of the degree group of $R$. In either case, the result is the projective and graded left module
#! associated to the degrees $d_i$ and their multiplicities $n_i$.
#! @Returns an object
#! @Arguments degree_list, R
DeclareOperation( "CAPCategoryOfProjectiveGradedLeftModulesObject",
                  [ IsList, IsHomalgGradedRing ] );

#! @Description
#! The arguments are a list of degrees and a homalg graded ring $R$. 
#! The list of degrees must be of the form [ [ $d_1$, $n_1$ ], [ $d_2$, $n_2$ ], ... ] where $d_i$
#! are degrees, i.e. elements in the degree group of $R$ and the $n_i$ are non-negative integers.
#! Currently there are two formats that are supported to enter the degrees. Either one can enter
#! them as lists of integers, say $d_1 = [ 1,1,0,2 ]$, or they can be entered as Homalg_Module_Elements
#! of the degree group of $R$. In either case, the result is the projective and graded right module
#! associated to the degrees $d_i$ and their multiplicities $n_i$.
#! @Returns an object
#! @Arguments degree_list, R
DeclareOperation( "CAPCategoryOfProjectiveGradedRightModulesObject",
                  [ IsList, IsHomalgGradedRing ] );

####################################
##
#! @Section Attributes
##
####################################

#! @Description
#! The argument is an object $A$ in the category of projective graded left or right modules
#! over a homalg graded ring $R$. The output is then the graded ring $R$.
#! @Returns a homalg graded ring
#! @Arguments A
DeclareAttribute( "UnderlyingHomalgGradedRing",
                  IsCAPCategoryOfProjectiveGradedLeftOrRightModulesObject );

#! @Description
#! The argument is an object $A$ in the category of projective graded left or right modules
#! over a homalg graded ring $R$. The output is the degree_list of this object.
#! To handle degree_lists most easily, degree_lists are redcued whenever an object is added
#! to the category. E.g. the input degree_list [ [ $d_1$, 1 ], [ $d_1$, 1 ] ] will be turned into
#! [ [ $d_1$, 2 ] ].
#! @Returns a list
#! @Arguments A
DeclareAttribute( "DegreeList",
                  IsCAPCategoryOfProjectiveGradedLeftOrRightModulesObject );

#! @Description
#! The argument is an object $A$ in the category of projective graded left or right modules
#! over a homalg graded ring $R$. The output is the rank of this module.
#! @Returns an integer
#! @Arguments A                  
DeclareAttribute( "RankOfObject",
                  IsCAPCategoryOfProjectiveGradedLeftOrRightModulesObject );
                  
##############################################################################
##
## Operation to simplify degree_lists when we construct the associated objects
##
##############################################################################

DeclareOperation( "CAP_CATEGORY_OF_PROJECTIVE_GRADED_MODULES_INTERNAL_SIMPLIFY_DATA_STRUCTURE",
                  [ IsList ] );