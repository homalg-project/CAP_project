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
#! @Section Constructors
##
####################################

#! @Description
#! The argument is a homalg field $F$.
#! The output is the matrix category over $F$.
#! Objects in this category are non-negative integers.
#! Morphisms from a non-negative integer $m$ to a non-negative integer $n$ are given by
#! $m \times n$ matrices.
#! @Returns a category
#! @Arguments F
DeclareAttribute( "MatrixCategory",
                  IsFieldForHomalg );

DeclareGlobalFunction( "INSTALL_FUNCTIONS_FOR_MATRIX_CATEGORY" );