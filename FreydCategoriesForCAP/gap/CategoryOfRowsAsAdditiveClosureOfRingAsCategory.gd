# SPDX-License-Identifier: GPL-2.0-or-later
# FreydCategoriesForCAP: Freyd categories - Formal (co)kernels for additive categories
#
# Declarations
#
#! @Chapter Category of rows

####################################
##
#! @Section Constructors
##
####################################

DeclareOperation( "CategoryOfRowsAsAdditiveClosureOfRingAsCategory",
                  [ IsHomalgRing ] );

# helper for compilation
DeclareGlobalFunction( "COMPILATION_HELPER_HomalgMatrixFromRingElement" );
CapJitAddTypeSignature( "COMPILATION_HELPER_HomalgMatrixFromRingElement", [ IsHomalgRingElement, IsHomalgRing ], IsHomalgMatrix );
