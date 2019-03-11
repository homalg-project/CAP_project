#############################################################################
##
## FreydCategoriesForCAP package
##
## Copyright 2019, Martin Bies,       ULB Brussels
##
#! @Chapter Category of graded rows and category of graded columns
##
#############################################################################



####################################
##
#! @Section GAP Categories
##
####################################

#! @Description
#! The GAP category of graded rows and columns over a graded ring $R$.
#! @Arguments object
DeclareCategory( "IsGradedRowOrColumn",
                 IsCapCategoryObject );

#! @Description
#! The GAP category of graded rows over a graded ring $R$.
#! @Arguments object
DeclareCategory( "IsGradedRow",
                 IsGradedRowOrColumn );

#! @Description
#! The GAP category of graded columns over a graded ring $R$.
#! @Arguments object
DeclareCategory( "IsGradedColumn",
                 IsGradedRowOrColumn );



####################################
##
#! @Section Constructors
##
####################################

DeclareGlobalFunction( "GradedRowOrColumn" );
DeclareGlobalFunction( "GradedRowOrColumnLazy" );

#! @Description
#! The arguments are a list of degrees and a homalg graded ring $R$. 
#! The list of degrees must be of the form [ [ $d_1$, $n_1$ ], [ $d_2$, $n_2$ ], ... ] where $d_i$
#! are degrees, i.e. elements in the degree group of $R$ and the $n_i$ are non-negative integers.
#! Currently there are two formats that are supported to enter the degrees. Either one can enter
#! them as lists of integers, say $d_1 = [ 1,1,0,2 ]$, or they can be entered as Homalg_Module_Elements
#! of the degree group of $R$. In either case, the result is the graded row
#! associated to the degrees $d_i$ and their multiplicities $n_i$.
#! @Returns an object
#! @Arguments degree_list, R
DeclareOperation( "GradedRow",
                  [ IsList, IsHomalgGradedRing ] );

#! @Description
#! As 'GradedRow', but the boolean (= third argument) allows to switch off 
#! checks on the input data. If this boolean is set to true, then the input checks are performed and otherwise they are not.
#! Calling this constructor with 'false' is therefore suited for high performance applications.
#! @Returns an object
#! @Arguments degree_list, R
DeclareOperation( "GradedRow",
                  [ IsList, IsHomalgGradedRing, IsBool ] );

#! @Description
#! The arguments are a list of degrees and a homalg graded ring $R$. 
#! The list of degrees must be of the form [ [ $d_1$, $n_1$ ], [ $d_2$, $n_2$ ], ... ] where $d_i$
#! are degrees, i.e. elements in the degree group of $R$ and the $n_i$ are non-negative integers.
#! Currently there are two formats that are supported to enter the degrees. Either one can enter
#! them as lists of integers, say $d_1 = [ 1,1,0,2 ]$, or they can be entered as Homalg_Module_Elements
#! of the degree group of $R$. In either case, the result is the graded column
#! associated to the degrees $d_i$ and their multiplicities $n_i$.
#! @Returns an object
#! @Arguments degree_list, R
DeclareOperation( "GradedColumn",
                  [ IsList, IsHomalgGradedRing ] );

#! @Description
#! As 'GradedColumn', but the boolean (= third argument) allows to switch off 
#! checks on the input data. If this boolean is set to true, then the input checks are performed and otherwise they are not.
#! Calling this constructor with 'false' is therefore suited for high performance applications.
#! @Returns an object
#! @Arguments degree_list, R
DeclareOperation( "GradedColumn",
                  [ IsList, IsHomalgGradedRing, IsBool ] );



####################################
##
#! @Section Attributes
##
####################################

#! @Description
#! The argument is a graded row or column $A$ over a homalg graded ring $R$. 
#! The output is then the graded ring $R$.
#! @Returns a homalg graded ring
#! @Arguments A
DeclareAttribute( "UnderlyingHomalgGradedRing",
                  IsGradedRowOrColumn );

#! @Description
#! The argument is a graded row or column $A$ over a homalg graded ring $R$. 
#! The output is the degree_list of this object.
#! To handle degree_lists most easily, degree_lists are redcued whenever an object is added
#! to the category. E.g. the input degree_list [ [ $d_1$, 1 ], [ $d_1$, 1 ] ] will be turned into
#! [ [ $d_1$, 2 ] ].
#! @Returns a list
#! @Arguments A
DeclareAttribute( "DegreeList",
                  IsGradedRowOrColumn );

#! @Description
#! The argument is a graded row or column over a homalg graded ring $R$. 
#! The output is the rank of this module.
#! @Returns an integer
#! @Arguments A
DeclareAttribute( "RankOfObject",
                  IsGradedRowOrColumn );



##############################################################################
##
## Operation to simplify degree_lists when we construct the associated objects
##
##############################################################################

DeclareOperation( "CAP_CATEGORY_OF_GRADED_ROWS_AND_COLUMNS_INTERNAL_SIMPLIFY_DATA_STRUCTURE",
                  [ IsList ] );
