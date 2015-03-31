DeclareCategory( "IsDerivation", IsObject );
DeclareCategory( "IsDerivationGraph", IsObject );
DeclareCategory( "IsOperationWeightList", IsObject );

DeclareOperation( "MakeDerivation",
                  [ IsString, IsFunction, IsDenseList,
                    IsPosInt, IsFunction ] );
DeclareAttribute( "DerivationName", IsDerivation );
DeclareAttribute( "DerivationWeight", IsDerivation );
DeclareAttribute( "DerivationFunction", IsDerivation );
DeclareAttribute( "TargetOperation", IsDerivation );
DeclareAttribute( "UsedOperations", IsDerivation );
DeclareAttribute( "UsedOperationMultiples", IsDerivation );
DeclareOperation( "InstallDerivationForCategory",
                  [ IsDerivation, IsPosInt, IsCapCategory ] );
DeclareOperation( "DerivationResultWeight",
                  [ IsDerivation, IsDenseList ] );

DeclareOperation( "MakeDerivationGraph", [ IsDenseList ] );
DeclareOperation( "AddDerivation", [ IsDerivationGraph, IsDerivation ] );
DeclareAttribute( "Operations", IsDerivationGraph );
DeclareOperation( "DerivationsUsingOperation", [ IsDerivationGraph, IsString ] );
DeclareOperation( "DerivationsOfOperation", [ IsDerivationGraph, IsString ] );

DeclareOperation( "MakeOperationWeightList", [ IsCapCategory, IsDerivationGraph ] );
DeclareOperation( "CurrentOperationWeight", [ IsOperationWeightList, IsString ] );
DeclareOperation( "OperationWeightUsingDerivation",
                  [ IsOperationWeightList, IsDerivation ] );
DeclareOperation( "DerivationOfOperation", [ IsOperationWeightList, IsString ] );
DeclareOperation( "InstallDerivationsUsingOperation",
                  [ IsOperationWeightList, IsString ] );
DeclareOperation( "AddPrimitiveOperation", [ IsOperationWeightList, IsString, IsInt ] );

DeclareCategory( "IsStringMinHeap", IsObject );
DeclareGlobalFunction( "StringMinHeap" );
DeclareOperation( "HeapSize", [ IsStringMinHeap ] );
DeclareOperation( "Add", [ IsStringMinHeap, IsString, IsInt ] );
DeclareOperation( "IsEmptyHeap", [ IsStringMinHeap ] );
DeclareOperation( "ExtractMin", [ IsStringMinHeap ] );
DeclareOperation( "DecreaseKey", [ IsStringMinHeap, IsString, IsInt ] );
DeclareOperation( "Swap", [ IsStringMinHeap, IsPosInt, IsPosInt ] );
DeclareOperation( "Contains", [ IsStringMinHeap, IsString ] );
DeclareOperation( "Heapify", [ IsStringMinHeap, IsPosInt ] );
