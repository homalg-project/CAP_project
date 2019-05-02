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
#! The GAP category of morphisms of graded rows and columns
#! over a graded ring $R$.
#! @Arguments object
DeclareCategory( "IsGradedRowOrColumnMorphism",
                 IsCapCategoryMorphism );

#! @Description
#! The GAP category of morphisms of graded rows over a graded ring $R$.
#! @Arguments object
DeclareCategory( "IsGradedRowMorphism",
                 IsGradedRowOrColumnMorphism );

#! @Description
#! The GAP category of morphisms of graded columns over a graded ring $R$.
#! @Arguments object
DeclareCategory( "IsGradedColumnMorphism",
                 IsGradedRowOrColumnMorphism );



####################################
##
#! @Section Constructors
##
####################################

#! @Description
#! The arguments are an object $S$ in the category of graded rows or columns
#! over a homalg graded ring $R$, a homalg matrix $M$ over $R$ and another graded row or column $T$
#! over $R$. The output is the morphism $S \rightarrow T$ in the category
#! of graded rows and columns over $R$, whose underlying matrix is given by $M$.
#! @Returns a morphism in $\mathrm{Hom}(S,T)$
#! @Arguments S, M, T
DeclareOperation( "GradedRowOrColumnMorphism",
               [ IsGradedRowOrColumn, IsHomalgMatrix, IsGradedRowOrColumn ] );

#! @Description
#! As 'GradedRowOrColumnMorphism', but carries a fourth input parameter. If this boolean is set to false, then no checks on the input a performed. That option is therefore better suited for high performance applications.
#! @Returns a morphism in $\mathrm{Hom}(S,T)$
#! @Arguments S, M, T
DeclareOperation( "GradedRowOrColumnMorphism",
               [ IsGradedRowOrColumn, IsHomalgMatrix, IsGradedRowOrColumn, IsBool ] );



####################################
##
#! @Section Attributes
##
####################################

#! @Description
#! The argument is a morphism $\alpha$ in the category of graded rows or columns
#! over a homalg graded ring $R$. The output is the homalg graded ring $R$.
#! @Returns a homalg graded ring
#! @Arguments alpha
DeclareAttribute( "UnderlyingHomalgGradedRing",
                  IsGradedRowOrColumnMorphism );

#! @Description
#! The argument is a morphism $\alpha$ in the category of graded rows or columns
#! over a homalg graded ring $R$. The output is the underlying homalg matrix over $R$.
#! @Returns a matrix over a homalg graded ring
#! @Arguments alpha
DeclareAttribute( "UnderlyingHomalgMatrix",
                  IsGradedRowOrColumnMorphism );
