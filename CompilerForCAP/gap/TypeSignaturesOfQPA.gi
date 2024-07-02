# SPDX-License-Identifier: GPL-2.0-or-later
# CompilerForCAP: Speed up and verify categorical algorithms
#
# Implementations
#

Add( CAP_JIT_INTERNAL_GLOBAL_VARIABLE_FILTERS, IsPath );
Add( CAP_JIT_INTERNAL_GLOBAL_VARIABLE_FILTERS, IsQuiverAlgebra );

CapJitAddTypeSignature( "VertexIndex", [ IsQuiverVertex ], IsInt );
CapJitAddTypeSignature( "Paths", [ IsQuiverAlgebraElement ], CapJitDataTypeOfListOf( IsPath ) );
CapJitAddTypeSignature( "AlgebraOfElement", [ IsQuiverAlgebraElement ], IsQuiverAlgebra );
CapJitAddTypeSignature( "ZeroImmutable", [ IsQuiverAlgebra ], IsQuiverAlgebraElement );
CapJitAddTypeSignature( "PathAsAlgebraElement", [ IsQuiverAlgebra, IsPath ], IsQuiverAlgebraElement );
CapJitAddTypeSignature( "QuiverAlgebraElement", [ IsQuiverAlgebra, IsList, IsList ], IsQuiverAlgebraElement );
CapJitAddTypeSignature( "IsZero", [ IsQuiverAlgebraElement ], IsBool );
CapJitAddTypeSignature( "+", [ IsQuiverAlgebraElement, IsQuiverAlgebraElement ], IsQuiverAlgebraElement );
CapJitAddTypeSignature( "AdditiveInverseSameMutability", [ IsQuiverAlgebraElement ], IsQuiverAlgebraElement );
CapJitAddTypeSignature( "*", [ IsQuiverAlgebraElement, IsQuiverAlgebraElement ], IsQuiverAlgebraElement );
CapJitAddTypeSignature( "*", [ IsRat, IsQuiverAlgebraElement ], IsQuiverAlgebraElement );
CapJitAddTypeSignature( "QuiverOfPath", [ IsPath ], IsQuiver );
CapJitAddTypeSignature( "Source", [ IsPath ], IsQuiverVertex );
CapJitAddTypeSignature( "Target", [ IsPath ], IsQuiverVertex );
