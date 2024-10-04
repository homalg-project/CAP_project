# SPDX-License-Identifier: GPL-2.0-or-later
# CAP: Categories, Algorithms, Programming
#
# Declarations
#
#! @Chapter Finalize

DeclareAttribute( "IsFinalized",
                  IsCapCategory,
                  "mutable" );

DeclareOperation( "Finalize",
                  [ IsCapCategory ] );

