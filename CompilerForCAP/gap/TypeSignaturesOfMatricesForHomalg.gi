# SPDX-License-Identifier: GPL-2.0-or-later
# CompilerForCAP: Speed up and verify categorical algorithms
#
# Implementations
#

CapJitAddTypeSignature( "AsHomalgMatrix", [ IsCapCategoryObject ], function ( input_types )
    
    Assert( 0, input_types[1].category!.object_attribute_name = "AsHomalgMatrix" );
    Assert( 0, ObjectDatumType( input_types[1].category ).filter = IsHomalgMatrix );
    
    return ObjectDatumType( input_types[1].category );
    
end );

CapJitAddTypeSignature( "AsHomalgMatrix", [ IsCapCategoryMorphism ], function ( input_types )
    
    Assert( 0, input_types[1].category!.morphism_attribute_name = "AsHomalgMatrix" );
    Assert( 0, MorphismDatumType( input_types[1].category ).filter = IsHomalgMatrix );
    
    return MorphismDatumType( input_types[1].category );
    
end );

CapJitAddTypeSignature( "ZeroImmutable", [ IsHomalgRing ], input_types -> CapJitDataTypeOfElementOfRing( input_types[1].ring ) );
CapJitAddTypeSignature( "OneImmutable", [ IsHomalgRing ], input_types -> CapJitDataTypeOfElementOfRing( input_types[1].ring ) );
CapJitAddTypeSignature( "MinusOne", [ IsHomalgRing ], input_types -> CapJitDataTypeOfElementOfRing( input_types[1].ring ) );

CapJitAddTypeSignature( "HomalgMatrixListList", [ IsList, IsInt, IsInt, IsHomalgRing ], function ( input_types )
  local ring;
    
    ring := input_types[4].ring;
    
    Assert( 0, input_types[1].element_type.filter = IsList );
    Assert( 0, input_types[1].element_type.element_type = CapJitDataTypeOfElementOfRing( ring ) or input_types[1].element_type.element_type.filter = IsInt ); # for example, integers appear in AddZeroMorphism in AdditiveClosuresForCAP/gap/CategoryOfRows_as_AdditiveClosure_RingAsCategory.gi
    
    return rec(
        filter := IsHomalgMatrix,
        ring := ring,
    );
    
end );

CapJitAddTypeSignature( "HomalgRowVector", [ IsList, IsInt, IsHomalgRing ], function ( input_types )
  local ring;
    
    ring := input_types[3].ring;
    
    Assert( 0, input_types[1].element_type = CapJitDataTypeOfElementOfRing( ring ) );
    
    return rec(
        filter := IsHomalgMatrix,
        ring := ring,
    );
    
end );

CapJitAddTypeSignature( "HomalgColumnVector", [ IsList, IsInt, IsHomalgRing ], function ( input_types )
  local ring;
    
    ring := input_types[3].ring;
    
    Assert( 0, input_types[1].element_type = CapJitDataTypeOfElementOfRing( ring ) );
    
    return rec(
        filter := IsHomalgMatrix,
        ring := ring,
    );
    
end );

CapJitAddTypeSignature( "HomalgIdentityMatrix", [ IsInt, IsHomalgRing ], input_types -> rec( filter := IsHomalgMatrix, ring := input_types[2].ring ) );
CapJitAddTypeSignature( "HomalgZeroMatrix", [ IsInt, IsInt, IsHomalgRing ], input_types -> rec( filter := IsHomalgMatrix, ring := input_types[3].ring ) );
CapJitAddTypeSignature( "RandomMatrix", [ IsInt, IsInt, IsHomalgRing ], input_types -> rec( filter := IsHomalgMatrix, ring := input_types[3].ring ) );
CapJitAddTypeSignature( "IsZero", [ IsHomalgMatrix ], IsBool );
CapJitAddTypeSignature( "[,]", [ IsHomalgMatrix, IsInt, IsInt ], input_types -> CapJitDataTypeOfElementOfRing( input_types[1].ring ) );
CapJitAddTypeSignature( "ConvertRowToMatrix", [ IsHomalgMatrix, IsInt, IsInt ], input_types -> input_types[1] );
CapJitAddTypeSignature( "ConvertColumnToMatrix", [ IsHomalgMatrix, IsInt, IsInt ], input_types -> input_types[1] );
CapJitAddTypeSignature( "ConvertMatrixToRow", [ IsHomalgMatrix ], input_types -> input_types[1] );
CapJitAddTypeSignature( "ConvertMatrixToColumn", [ IsHomalgMatrix ], input_types -> input_types[1] );

CapJitAddTypeSignature( "CertainRows", [ IsHomalgMatrix, IsList ], function ( input_types )
    
    Assert( 0, input_types[2].element_type.filter = IsInt );
    
    return input_types[1];
    
end );

CapJitAddTypeSignature( "CertainColumns", [ IsHomalgMatrix, IsList ], function ( input_types )
    
    Assert( 0, input_types[2].element_type.filter = IsInt );
    
    return input_types[1];
    
end );

CapJitAddTypeSignature( "KroneckerMat", [ IsHomalgMatrix, IsHomalgMatrix ], function ( input_types )
    
    Assert( 0, input_types[1] = input_types[2] );
    
    return input_types[1];
    
end );

CapJitAddTypeSignature( "DualKroneckerMat", [ IsHomalgMatrix, IsHomalgMatrix ], function ( input_types )
    
    Assert( 0, input_types[1] = input_types[2] );
    
    return input_types[1];
    
end );

CapJitAddTypeSignature( "SafeRightDivide", [ IsHomalgMatrix, IsHomalgMatrix ], function ( input_types )
    
    Assert( 0, input_types[1] = input_types[2] );
    
    return input_types[1];
    
end );

CapJitAddTypeSignature( "SafeLeftDivide", [ IsHomalgMatrix, IsHomalgMatrix ], function ( input_types )
    
    Assert( 0, input_types[1] = input_types[2] );
    
    return input_types[1];
    
end );

CapJitAddTypeSignature( "UniqueRightDivide", [ IsHomalgMatrix, IsHomalgMatrix ], function ( input_types )
    
    Assert( 0, input_types[1] = input_types[2] );
    
    return input_types[1];
    
end );

CapJitAddTypeSignature( "UniqueLeftDivide", [ IsHomalgMatrix, IsHomalgMatrix ], function ( input_types )
    
    Assert( 0, input_types[1] = input_types[2] );
    
    return input_types[1];
    
end );

CapJitAddTypeSignature( "BasisOfRows", [ IsHomalgMatrix ], input_types -> input_types[1] );
CapJitAddTypeSignature( "BasisOfColumns", [ IsHomalgMatrix ], input_types -> input_types[1] );
CapJitAddTypeSignature( "SyzygiesOfRows", [ IsHomalgMatrix ], input_types -> input_types[1] );
CapJitAddTypeSignature( "SyzygiesOfColumns", [ IsHomalgMatrix ], input_types -> input_types[1] );

CapJitAddTypeSignature( "SyzygiesOfRows", [ IsHomalgMatrix, IsHomalgMatrix ], function ( input_types )
    
    Assert( 0, input_types[1] = input_types[2] );
    
    return input_types[1];
    
end );

CapJitAddTypeSignature( "SyzygiesOfColumns", [ IsHomalgMatrix, IsHomalgMatrix ], function ( input_types )
    
    Assert( 0, input_types[1] = input_types[2] );
    
    return input_types[1];
    
end );

CapJitAddTypeSignature( "ReducedSyzygiesOfRows", [ IsHomalgMatrix ], input_types -> input_types[1] );
CapJitAddTypeSignature( "ReducedSyzygiesOfColumns", [ IsHomalgMatrix ], input_types -> input_types[1] );

CapJitAddTypeSignature( "ReducedSyzygiesOfRows", [ IsHomalgMatrix, IsHomalgMatrix ], function ( input_types )
    
    Assert( 0, input_types[1] = input_types[2] );
    
    return input_types[1];
    
end );

CapJitAddTypeSignature( "ReducedSyzygiesOfColumns", [ IsHomalgMatrix, IsHomalgMatrix ], function ( input_types )
    
    Assert( 0, input_types[1] = input_types[2] );
    
    return input_types[1];
    
end );

CapJitAddTypeSignature( "NumberRows", [ IsHomalgMatrix ], IsInt );
CapJitAddTypeSignature( "NumberColumns", [ IsHomalgMatrix ], IsInt );
CapJitAddTypeSignature( "RowRankOfMatrix", [ IsHomalgMatrix ], IsInt );
CapJitAddTypeSignature( "ColumnRankOfMatrix", [ IsHomalgMatrix ], IsInt );

CapJitAddTypeSignature( "UnionOfRows", [ IsHomalgRing, IsInt, IsList ], function ( input_types )
    
    Assert( 0, input_types[3].element_type.filter = IsHomalgMatrix and input_types[3].element_type.ring = input_types[1].ring );
    
    return input_types[3].element_type;

end );

CapJitAddTypeSignature( "UnionOfColumns", [ IsHomalgRing, IsInt, IsList ], function ( input_types )
    
    Assert( 0, input_types[3].element_type.filter = IsHomalgMatrix and input_types[3].element_type.ring = input_types[1].ring );
    
    return input_types[3].element_type;

end );

CapJitAddTypeSignature( "UnionOfRows", [ IsHomalgMatrix, IsHomalgMatrix ], function ( input_types )
    
    Assert( 0, input_types[1] = input_types[2] );
    
    return input_types[1];
    
end );

CapJitAddTypeSignature( "UnionOfColumns", [ IsHomalgMatrix, IsHomalgMatrix ], function ( input_types )
    
    Assert( 0, input_types[1] = input_types[2] );
    
    return input_types[1];
    
end );

CapJitAddTypeSignature( "UnionOfRows", [ IsHomalgMatrix, IsHomalgMatrix, IsHomalgMatrix ], function ( input_types )
    
    Assert( 0, input_types[1] = input_types[2] );
    Assert( 0, input_types[1] = input_types[3] );
    
    return input_types[1];
    
end );

CapJitAddTypeSignature( "UnionOfColumns", [ IsHomalgMatrix, IsHomalgMatrix, IsHomalgMatrix ], function ( input_types )
    
    Assert( 0, input_types[1] = input_types[2] );
    Assert( 0, input_types[1] = input_types[3] );
    
    return input_types[1];
    
end );

CapJitAddTypeSignature( "DiagMat", [ IsHomalgRing, IsList ], function ( input_types )
    
    Assert( 0, input_types[2].element_type.filter = IsHomalgMatrix and input_types[2].element_type.ring = input_types[1].ring );
    
    return input_types[2].element_type;

end );

CapJitAddTypeSignature( "TransposedMatrix", [ IsHomalgMatrix ], input_types -> input_types[1] );

CapJitAddTypeSignature( "CoefficientsWithGivenMonomials", [ IsHomalgMatrix, IsHomalgMatrix ], function ( input_types )
    
    Assert( 0, input_types[1] = input_types[2] );
    
    return input_types[1];
    
end );

CapJitAddTypeSignature( "CoefficientsWithGivenMonomials", [ IsHomalgRingElement, IsHomalgMatrix ], function ( input_types )
    
    Assert( 0, input_types[1] = CapJitDataTypeOfElementOfRing( input_types[2].ring ) );
    
    return input_types[2];
    
end );

CapJitAddTypeSignature( "CoercedMatrix", [ IsHomalgRing, IsHomalgRing, IsHomalgMatrix ], function ( input_types )
    
    Assert( 0, input_types[3].ring = input_types[1].ring );
    
    return rec( filter := IsHomalgMatrix, ring := input_types[2].ring );
    
end );

CapJitAddTypeSignature( "CoercedMatrix", [ IsHomalgRing, IsHomalgMatrix ], input_types -> rec( filter := IsHomalgMatrix, ring := input_types[1].ring ) );
CapJitAddTypeSignature( "EntriesOfHomalgMatrix", [ IsHomalgMatrix ], input_types -> CapJitDataTypeOfListOf( CapJitDataTypeOfElementOfRing( input_types[1].ring ) ) );
CapJitAddTypeSignature( "EntriesOfHomalgMatrixAsListList", [ IsHomalgMatrix ], input_types -> CapJitDataTypeOfListOf( CapJitDataTypeOfListOf( CapJitDataTypeOfElementOfRing( input_types[1].ring ) ) ) );
CapJitAddTypeSignature( "EntriesOfHomalgRowVector", [ IsHomalgMatrix ], input_types -> CapJitDataTypeOfListOf( CapJitDataTypeOfElementOfRing( input_types[1].ring ) ) );
CapJitAddTypeSignature( "EntriesOfHomalgColumnVector", [ IsHomalgMatrix ], input_types -> CapJitDataTypeOfListOf( CapJitDataTypeOfElementOfRing( input_types[1].ring ) ) );

CapJitAddTypeSignature( "DecideZeroRows", [ IsHomalgMatrix, IsHomalgMatrix ], function ( input_types )
    
    Assert( 0, input_types[1] = input_types[2] );
    
    return input_types[1];
    
end );

CapJitAddTypeSignature( "DecideZeroColumns", [ IsHomalgMatrix, IsHomalgMatrix ], function ( input_types )
    
    Assert( 0, input_types[1] = input_types[2] );
    
    return input_types[1];
    
end );

CapJitAddTypeSignature( "SimplifyHomalgMatrixByLeftAndRightMultiplicationWithInvertibleMatrices", [ IsHomalgMatrix ], input_types -> CapJitDataTypeOfNTupleOf( 5, input_types[1], input_types[1], input_types[1], input_types[1], input_types[1] ) );
CapJitAddTypeSignature( "SimplifyHomalgMatrixByLeftMultiplicationWithInvertibleMatrix", [ IsHomalgMatrix ], input_types -> CapJitDataTypeOfNTupleOf( 3, input_types[1], input_types[1], input_types[1] ) );
CapJitAddTypeSignature( "SimplifyHomalgMatrixByRightMultiplicationWithInvertibleMatrix", [ IsHomalgMatrix ], input_types -> CapJitDataTypeOfNTupleOf( 3, input_types[1], input_types[1], input_types[1] ) );

CapJitAddTypeSignature( "/", [ IsHomalgRingElement, IsHomalgRing ], input_types -> CapJitDataTypeOfElementOfRing( input_types[2].ring ) );

# addition
CapJitAddTypeSignature( "+", [ IsHomalgRingElement, IsHomalgRingElement ], function ( input_types )
    
    Assert( 0, input_types[1] = input_types[2] );
    
    return input_types[1];
    
end );

CapJitAddTypeSignature( "+", [ IsHomalgMatrix, IsHomalgMatrix ], function ( input_types )
    
    Assert( 0, input_types[1] = input_types[2] );
    
    return input_types[1];
    
end );

CapJitAddTypeSignature( "AdditiveInverseSameMutability", [ IsHomalgRingElement ], input_types -> input_types[1] );
CapJitAddTypeSignature( "AdditiveInverseSameMutability", [ IsHomalgMatrix ], input_types -> input_types[1] );

CapJitAddTypeSignature( "-", [ IsHomalgMatrix, IsHomalgMatrix ], function ( input_types )
    
    Assert( 0, input_types[1] = input_types[2] );
    
    return input_types[1];
    
end );

CapJitAddTypeSignature( "Sum", [ IsList, IsHomalgMatrix ], function ( input_types )
    
    Assert( 0, input_types[1].element_type = input_types[2] );
    
    return input_types[2];
    
end );

# multiplication
CapJitAddTypeSignature( "*", [ IsHomalgRingElement, IsHomalgRingElement ], function ( input_types )
    
    Assert( 0, input_types[1] = input_types[2] );
    
    return input_types[1];
    
end );

CapJitAddTypeSignature( "*", [ IsRat, IsHomalgMatrix ], input_types -> input_types[2] );
CapJitAddTypeSignature( "*", [ IsHomalgMatrix, IsInt ], input_types -> input_types[1] );

CapJitAddTypeSignature( "*", [ IsHomalgRingElement, IsHomalgMatrix ], function ( input_types )
    
    Assert( 0, input_types[1].ring = input_types[2].ring );
    
    return input_types[2];
    
end );

CapJitAddTypeSignature( "*", [ IsHomalgMatrix, IsHomalgRingElement ], function ( input_types )
    
    Assert( 0, input_types[1].ring = input_types[2].ring );
    
    return input_types[1];
    
end );

CapJitAddTypeSignature( "*", [ IsHomalgMatrix, IsHomalgMatrix ], function ( input_types )
    
    Assert( 0, input_types[1] = input_types[2] );
    
    return input_types[1];
    
end );
