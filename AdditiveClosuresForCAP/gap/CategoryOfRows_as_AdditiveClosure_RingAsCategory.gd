# SPDX-License-Identifier: GPL-2.0-or-later
# AdditiveClosuresForCAP: Additive closures for pre-abelian categories
#
# Declarations
#
#! @Chapter Category of rows

####################################
##
#! @Section Constructors
##
####################################

DeclareOperation( "CategoryOfRows_as_AdditiveClosure_RingAsCategory",
                  [ IsHomalgRing ] );

# helper for compilation
DeclareGlobalFunction( "COMPILATION_HELPER_HomalgMatrixFromRingElement" );

CapJitAddTypeSignature( "COMPILATION_HELPER_HomalgMatrixFromRingElement", [ IsHomalgRingElement, IsHomalgRing ], function ( input_types )
  local ring;
    
    ring := input_types[2].ring;
    
    Assert( 0, IsHomalgRing( ring ) );
    Assert( 0, input_types[1].ring = ring );
    
    return rec( filter := IsHomalgMatrix, ring := ring );
    
end );
