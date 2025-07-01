# SPDX-License-Identifier: GPL-2.0-or-later
# FreydCategoriesForCAP: Freyd categories - Formal (co)kernels for additive categories
#
# Implementations
#

##
AddDerivationToCAP( SomeProjectiveObjectForKernelObject,
                    "SomeProjectiveObjectForKernelObject as the source of EpimorphismFromSomeProjectiveObjectForKernelObject",
                    [ [ EpimorphismFromSomeProjectiveObjectForKernelObject, 1 ] ],
                    
  function( cat, morphism )
    
    return Source( EpimorphismFromSomeProjectiveObjectForKernelObject( cat, morphism ) );
    
end );

