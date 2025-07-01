# SPDX-License-Identifier: GPL-2.0-or-later
# LinearAlgebraForCAP: Category of Matrices over a Field for CAP
#
# Declarations
#

#! @Chapter Category of Matrices

####################################
##
#! @Section Constructors
##
####################################

#! @Description
#! The argument is a homalg field $F$.
#! The output is the matrix category over $F$,
#! constructed internally as a wrapper category of
#! the `CategoryOfRows` of $F$.
#! Only available if the package `AdditiveClosuresForCAP` is available.
#! @Returns a category
#! @Arguments F
DeclareOperation( "MatrixCategory_as_CategoryOfRows",
                  [ IsFieldForHomalg ] );
