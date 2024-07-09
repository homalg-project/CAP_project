# SPDX-License-Identifier: GPL-2.0-or-later
# CompilerForCAP: Speed up and verify categorical algorithms
#
# Implementations
#

CapJitAddTypeSignature( "VertexIndex", [ IsQuiverVertex ], IsInt );
CapJitAddTypeSignature( "Paths", [ IsQuiverAlgebraElement ], CapJitDataTypeOfListOf( IsPath ) );
CapJitAddTypeSignature( "AlgebraOfElement", [ IsQuiverAlgebraElement ], input_types -> CapJitDataTypeOfRing( input_types[1].ring ) );
CapJitAddTypeSignature( "ZeroImmutable", [ IsQuiverAlgebra ], input_types -> CapJitDataTypeOfElementOfRing( input_types[1].ring ) );
CapJitAddTypeSignature( "PathAsAlgebraElement", [ IsQuiverAlgebra, IsPath ], input_types -> CapJitDataTypeOfElementOfRing( input_types[1].ring ) );
CapJitAddTypeSignature( "QuiverAlgebraElement", [ IsQuiverAlgebra, IsList, IsList ], input_types -> CapJitDataTypeOfElementOfRing( input_types[1].ring ) );
CapJitAddTypeSignature( "IsZero", [ IsQuiverAlgebraElement ], IsBool );
CapJitAddTypeSignature( "+", [ IsQuiverAlgebraElement, IsQuiverAlgebraElement ], function ( input_types )
    
    Assert( 0, input_types[1] = input_types[2] );
    
    return input_types[1];
    
end );
CapJitAddTypeSignature( "AdditiveInverseSameMutability", [ IsQuiverAlgebraElement ], input_types -> input_types[1] );
CapJitAddTypeSignature( "*", [ IsQuiverAlgebraElement, IsQuiverAlgebraElement ], function ( input_types )
    
    Assert( 0, input_types[1] = input_types[2] );
    
    return input_types[1];
    
end );
CapJitAddTypeSignature( "*", [ IsRat, IsQuiverAlgebraElement ], input_types -> input_types[2] );
CapJitAddTypeSignature( "QuiverOfPath", [ IsPath ], IsQuiver );
CapJitAddTypeSignature( "Source", [ IsPath ], IsQuiverVertex );
CapJitAddTypeSignature( "Target", [ IsPath ], IsQuiverVertex );
