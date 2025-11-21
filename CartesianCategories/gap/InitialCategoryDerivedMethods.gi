# SPDX-License-Identifier: GPL-2.0-or-later
# CartesianCategories: Cartesian and cocartesian categories and various subdoctrines
#
# Implementations
#

##
AddDerivationToCAP( SetOfGeneratingMorphismsOfCategory,
        "SetOfGeneratingMorphismsOfCategory for the initial category",
        [  ],
        
  function( initial_category )
    
    return CapJitTypedExpression( [ ], cat -> CapJitDataTypeOfListOf( CapJitDataTypeOfMorphismOfCategory( initial_category ) ) );
    
end : CategoryFilter := cat -> HasIsInitialCategory( cat ) and IsInitialCategory( cat ) );
