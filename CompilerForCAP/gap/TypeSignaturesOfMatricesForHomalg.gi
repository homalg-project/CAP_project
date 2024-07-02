# SPDX-License-Identifier: GPL-2.0-or-later
# CompilerForCAP: Speed up and verify categorical algorithms
#
# Implementations
#

Add( CAP_JIT_INTERNAL_GLOBAL_VARIABLE_FILTERS, IsHomalgRing );
Add( CAP_JIT_INTERNAL_GLOBAL_VARIABLE_FILTERS, IsHomalgRingElement );
Add( CAP_JIT_INTERNAL_GLOBAL_VARIABLE_FILTERS, IsHomalgMatrix );
Add( CAP_JIT_INTERNAL_GLOBAL_VARIABLE_FILTERS, IsHomalgRingMap );

CapJitAddTypeSignature( "AsHomalgMatrix", [ IsCapCategoryObject ], function ( input_types )
    
    Assert( 0, input_types[1].category!.object_attribute_name = "AsHomalgMatrix" );
    
    return rec( filter := IsHomalgMatrix );
    
end );

CapJitAddTypeSignature( "AsHomalgMatrix", [ IsCapCategoryMorphism ], function ( input_types )
    
    Assert( 0, input_types[1].category!.morphism_attribute_name = "AsHomalgMatrix" );
    
    return rec( filter := IsHomalgMatrix );
    
end );

# These rules only hold for external homalg rings.
# For example, `Zero( HomalgRingOfIntegers( ) )` does not lie in `IsHomalgRingElement`.
CapJitAddTypeSignature( "ZeroImmutable", [ IsHomalgRing ], IsHomalgRingElement );
CapJitAddTypeSignature( "OneImmutable", [ IsHomalgRing ], IsHomalgRingElement );

CapJitAddTypeSignature( "HomalgMatrixListList", [ IsList, IsInt, IsInt, IsHomalgRing ], function ( input_types )
    
    Assert( 0, input_types[1].element_type.filter = IsList );
    Assert( 0, input_types[1].element_type.element_type.filter in [ IsHomalgRingElement, IsInt, IsRat ] ); # for example, integers appear in AddZeroMorphism in FreydCategoriesForCAP/gap/CategoryOfRowsAsAdditiveClosureOfRingAsCategory.gi
    
    return rec( filter := IsHomalgMatrix );
    
end );
CapJitAddTypeSignature( "HomalgRowVector", [ IsList, IsInt, IsHomalgRing ], function ( input_types )
    
    Assert( 0, input_types[1].element_type.filter = IsHomalgRingElement );
    
    return rec( filter := IsHomalgMatrix );
    
end );
CapJitAddTypeSignature( "HomalgColumnVector", [ IsList, IsInt, IsHomalgRing ], function ( input_types )
    
    Assert( 0, input_types[1].element_type.filter = IsHomalgRingElement );
    
    return rec( filter := IsHomalgMatrix );
    
end );
CapJitAddTypeSignature( "HomalgIdentityMatrix", [ IsInt, IsHomalgRing ], IsHomalgMatrix );
CapJitAddTypeSignature( "HomalgZeroMatrix", [ IsInt, IsInt, IsHomalgRing ], IsHomalgMatrix );
CapJitAddTypeSignature( "RandomMatrix", [ IsInt, IsInt, IsHomalgRing ], IsHomalgMatrix );
CapJitAddTypeSignature( "IsZero", [ IsHomalgMatrix ], IsBool );
CapJitAddTypeSignature( "[,]", [ IsHomalgMatrix, IsInt, IsInt ], IsHomalgRingElement );
CapJitAddTypeSignature( "ConvertRowToMatrix", [ IsHomalgMatrix, IsInt, IsInt ], IsHomalgMatrix );
CapJitAddTypeSignature( "ConvertColumnToMatrix", [ IsHomalgMatrix, IsInt, IsInt ], IsHomalgMatrix );
CapJitAddTypeSignature( "ConvertMatrixToRow", [ IsHomalgMatrix ], IsHomalgMatrix );
CapJitAddTypeSignature( "ConvertMatrixToColumn", [ IsHomalgMatrix ], IsHomalgMatrix );
CapJitAddTypeSignature( "CertainRows", [ IsHomalgMatrix, IsList ], IsHomalgMatrix );
CapJitAddTypeSignature( "CertainColumns", [ IsHomalgMatrix, IsList ], IsHomalgMatrix );
CapJitAddTypeSignature( "KroneckerMat", [ IsHomalgMatrix, IsHomalgMatrix ], IsHomalgMatrix );
CapJitAddTypeSignature( "DualKroneckerMat", [ IsHomalgMatrix, IsHomalgMatrix ], IsHomalgMatrix );
CapJitAddTypeSignature( "SafeRightDivide", [ IsHomalgMatrix, IsHomalgMatrix ], IsHomalgMatrix );
CapJitAddTypeSignature( "SafeLeftDivide", [ IsHomalgMatrix, IsHomalgMatrix ], IsHomalgMatrix );
CapJitAddTypeSignature( "UniqueRightDivide", [ IsHomalgMatrix, IsHomalgMatrix ], IsHomalgMatrix );
CapJitAddTypeSignature( "UniqueLeftDivide", [ IsHomalgMatrix, IsHomalgMatrix ], IsHomalgMatrix );
CapJitAddTypeSignature( "BasisOfRows", [ IsHomalgMatrix ], IsHomalgMatrix );
CapJitAddTypeSignature( "BasisOfColumns", [ IsHomalgMatrix ], IsHomalgMatrix );
CapJitAddTypeSignature( "SyzygiesOfRows", [ IsHomalgMatrix ], IsHomalgMatrix );
CapJitAddTypeSignature( "SyzygiesOfColumns", [ IsHomalgMatrix ], IsHomalgMatrix );
CapJitAddTypeSignature( "SyzygiesOfRows", [ IsHomalgMatrix, IsHomalgMatrix ], IsHomalgMatrix );
CapJitAddTypeSignature( "SyzygiesOfColumns", [ IsHomalgMatrix, IsHomalgMatrix ], IsHomalgMatrix );
CapJitAddTypeSignature( "ReducedSyzygiesOfRows", [ IsHomalgMatrix ], IsHomalgMatrix );
CapJitAddTypeSignature( "ReducedSyzygiesOfColumns", [ IsHomalgMatrix ], IsHomalgMatrix );
CapJitAddTypeSignature( "ReducedSyzygiesOfRows", [ IsHomalgMatrix, IsHomalgMatrix ], IsHomalgMatrix );
CapJitAddTypeSignature( "ReducedSyzygiesOfColumns", [ IsHomalgMatrix, IsHomalgMatrix ], IsHomalgMatrix );
CapJitAddTypeSignature( "NumberRows", [ IsHomalgMatrix ], IsInt );
CapJitAddTypeSignature( "NumberColumns", [ IsHomalgMatrix ], IsInt );
CapJitAddTypeSignature( "RowRankOfMatrix", [ IsHomalgMatrix ], IsInt );
CapJitAddTypeSignature( "ColumnRankOfMatrix", [ IsHomalgMatrix ], IsInt );
CapJitAddTypeSignature( "UnionOfRows", [ IsHomalgRing, IsInt, IsList ], IsHomalgMatrix );
CapJitAddTypeSignature( "UnionOfColumns", [ IsHomalgRing, IsInt, IsList ], IsHomalgMatrix );
CapJitAddTypeSignature( "UnionOfRows", [ IsHomalgMatrix, IsHomalgMatrix ], IsHomalgMatrix );
CapJitAddTypeSignature( "UnionOfColumns", [ IsHomalgMatrix, IsHomalgMatrix ], IsHomalgMatrix );
CapJitAddTypeSignature( "UnionOfRows", [ IsHomalgMatrix, IsHomalgMatrix, IsHomalgMatrix ], IsHomalgMatrix );
CapJitAddTypeSignature( "UnionOfColumns", [ IsHomalgMatrix, IsHomalgMatrix, IsHomalgMatrix ], IsHomalgMatrix );
CapJitAddTypeSignature( "DiagMat", [ IsHomalgRing, IsList ], IsHomalgMatrix );
CapJitAddTypeSignature( "TransposedMatrix", [ IsHomalgMatrix ], IsHomalgMatrix );
CapJitAddTypeSignature( "CoefficientsWithGivenMonomials", [ IsHomalgMatrix, IsHomalgMatrix ], IsHomalgMatrix );
CapJitAddTypeSignature( "CoefficientsWithGivenMonomials", [ IsHomalgRingElement, IsHomalgMatrix ], IsHomalgMatrix );
CapJitAddTypeSignature( "CoercedMatrix", [ IsHomalgRing, IsHomalgRing, IsHomalgMatrix ], IsHomalgMatrix );
CapJitAddTypeSignature( "CoercedMatrix", [ IsHomalgRing, IsHomalgMatrix ], IsHomalgMatrix );
CapJitAddTypeSignature( "Pullback", [ IsHomalgRingMap, IsHomalgMatrix ], IsHomalgMatrix );
CapJitAddTypeSignature( "EntriesOfHomalgMatrix", [ IsHomalgMatrix ], CapJitDataTypeOfListOf( IsHomalgRingElement ) );
CapJitAddTypeSignature( "EntriesOfHomalgMatrixAsListList", [ IsHomalgMatrix ], CapJitDataTypeOfListOf( CapJitDataTypeOfListOf( IsHomalgRingElement ) ) );
CapJitAddTypeSignature( "EntriesOfHomalgRowVector", [ IsHomalgMatrix ], CapJitDataTypeOfListOf( IsHomalgRingElement ) );
CapJitAddTypeSignature( "EntriesOfHomalgColumnVector", [ IsHomalgMatrix ], CapJitDataTypeOfListOf( IsHomalgRingElement ) );
CapJitAddTypeSignature( "DecideZeroRows", [ IsHomalgMatrix, IsHomalgMatrix ], IsHomalgMatrix );
CapJitAddTypeSignature( "DecideZeroColumns", [ IsHomalgMatrix, IsHomalgMatrix ], IsHomalgMatrix );
CapJitAddTypeSignature( "SimplifyHomalgMatrixByLeftAndRightMultiplicationWithInvertibleMatrices", [ IsHomalgMatrix ], CapJitDataTypeOfNTupleOf( 5, IsHomalgMatrix, IsHomalgMatrix, IsHomalgMatrix, IsHomalgMatrix, IsHomalgMatrix ) );
CapJitAddTypeSignature( "SimplifyHomalgMatrixByLeftMultiplicationWithInvertibleMatrix", [ IsHomalgMatrix ], CapJitDataTypeOfNTupleOf( 3, IsHomalgMatrix, IsHomalgMatrix, IsHomalgMatrix ) );
CapJitAddTypeSignature( "SimplifyHomalgMatrixByRightMultiplicationWithInvertibleMatrix", [ IsHomalgMatrix ], CapJitDataTypeOfNTupleOf( 3, IsHomalgMatrix, IsHomalgMatrix, IsHomalgMatrix ) );

CapJitAddTypeSignature( "/", [ IsHomalgRingElement, IsHomalgRing ], IsHomalgRingElement );

CapJitAddTypeSignature( "+", [ IsHomalgRingElement, IsHomalgRingElement ], IsHomalgRingElement );
CapJitAddTypeSignature( "+", [ IsHomalgMatrix, IsHomalgMatrix ], IsHomalgMatrix );
CapJitAddTypeSignature( "AdditiveInverseSameMutability", [ IsHomalgRingElement ], IsHomalgRingElement );
CapJitAddTypeSignature( "AdditiveInverseSameMutability", [ IsHomalgMatrix ], IsHomalgMatrix );
CapJitAddTypeSignature( "-", [ IsHomalgMatrix, IsHomalgMatrix ], IsHomalgMatrix );
CapJitAddTypeSignature( "Sum", [ IsList, IsHomalgMatrix ], function ( input_types )
    
    Assert( 0, input_types[1].element_type = input_types[2] );
    
    return input_types[2];
    
end );


CapJitAddTypeSignature( "*", [ IsHomalgRingElement, IsHomalgRingElement ], IsHomalgRingElement );
CapJitAddTypeSignature( "*", [ IsRat, IsHomalgMatrix ], IsHomalgMatrix );
CapJitAddTypeSignature( "*", [ IsHomalgMatrix, IsInt ], IsHomalgMatrix );
CapJitAddTypeSignature( "*", [ IsHomalgRingElement, IsHomalgMatrix ], IsHomalgMatrix );
CapJitAddTypeSignature( "*", [ IsHomalgMatrix, IsHomalgRingElement ], IsHomalgMatrix );
CapJitAddTypeSignature( "*", [ IsHomalgMatrix, IsHomalgMatrix ], IsHomalgMatrix );
