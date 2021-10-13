# SPDX-License-Identifier: GPL-2.0-or-later
# CAP: Categories, Algorithms, Programming
#
# Declarations
#
#! @Chapter Finalize

DeclareGlobalVariable( "CAP_INTERNAL_FINAL_DERIVATION_LIST" );


DeclareGlobalFunction( "AddFinalDerivation" );


DeclareAttribute( "IsFinalized",
                  IsCapCategory,
                  "mutable" );

DeclareOperation( "Finalize",
                  [ IsCapCategory ] );

