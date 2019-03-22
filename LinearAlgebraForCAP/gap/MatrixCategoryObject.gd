#############################################################################
##
##                                LinearAlgebraForCAP package
##
##  Copyright 2015, Sebastian Gutsche, TU Kaiserslautern
##                  Sebastian Posur,   RWTH Aachen
##
#! @Chapter Category of Matrices
##
#############################################################################

####################################
##
#! @Section GAP Categories
##
####################################

#! @Description
#! The GAP category of objects in the category
#! of matrices of a field $F$.
#! @Arguments object
DeclareCategory( "IsVectorSpaceObject",
                 IsCapCategoryObject and IsCellOfSkeletalCategory );

####################################
##
#! @Section Constructors
##
####################################

#! @Description
#! The arguments are a non-negative integer $d$
#! and a homalg field $F$.
#! The output is an object in the category of
#! matrices over $F$ of dimension $d$.
#! This function delegates to <C>MatrixCategoryObject</C>.
#! @Returns an object
#! @Arguments d, F
DeclareOperation( "VectorSpaceObject",
                  [ IsInt, IsFieldForHomalg ] );

#! @Description
#! The arguments are a homalg field $F$
#! and a non-negative integer $d$.
#! The output is an object in the category of
#! matrices over $F$ of dimension $d$.
#! @Returns an object
#! @Arguments F, d
KeyDependentOperation( "MatrixCategoryObject",
                       IsFieldForHomalg, IsInt, ReturnTrue );


####################################
##
#! @Section Attributes
##
####################################

#! @Description
#! The argument is an object $A$ in the matrix category over a
#! homalg field $F$.
#! The output is the field $F$.
#! @Returns a homalg field
#! @Arguments A
DeclareAttribute( "UnderlyingFieldForHomalg",
                  IsVectorSpaceObject );

#! @Description
#! The argument is an object $A$ in a matrix category.
#! The output is the dimension of $A$.
#! @Returns a non-negative integer
#! @Arguments A
DeclareAttribute( "Dimension",
                  IsVectorSpaceObject );
