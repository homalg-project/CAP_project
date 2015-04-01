DeclareCategory( "IsDerivation", IsObject );
DeclareCategory( "IsDerivationGraph", IsObject );
DeclareCategory( "IsOperationWeightList", IsObject );

DeclareOperation( "MakeDerivation",
                  [ IsString, IsFunction, IsDenseList,
                    IsPosInt, IsDenseList, IsFunction ] );
DeclareAttribute( "DerivationName", IsDerivation );
DeclareAttribute( "DerivationWeight", IsDerivation );
DeclareAttribute( "DerivationFunctionsWithExtraFilters", IsDerivation );
DeclareAttribute( "CategoryFilter", IsDerivation );
DeclareOperation( "IsApplicableToCategory", [ IsDerivation, IsCapCategory ] );
DeclareAttribute( "TargetOperation", IsDerivation );
DeclareAttribute( "UsedOperations", IsDerivation );
DeclareAttribute( "UsedOperationMultiples", IsDerivation );
DeclareAttribute( "UsedOperationsWithMultiples", IsDerivation );
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
DeclareAttribute( "DerivationGraph", IsOperationWeightList );
DeclareAttribute( "CategoryOfOperationWeightList", IsOperationWeightList );
DeclareOperation( "CurrentOperationWeight", [ IsOperationWeightList, IsString ] );
DeclareOperation( "OperationWeightUsingDerivation",
                  [ IsOperationWeightList, IsDerivation ] );
DeclareOperation( "DerivationOfOperation", [ IsOperationWeightList, IsString ] );
DeclareOperation( "InstallDerivationsUsingOperation",
                  [ IsOperationWeightList, IsString ] );
DeclareOperation( "Reevaluate", [ IsOperationWeightList ] );
DeclareOperation( "AddPrimitiveOperation", [ IsOperationWeightList, IsString, IsInt ] );
DeclareOperation( "PrintDerivationTree",
                  [ IsOperationWeightList, IsString ] );

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

DeclareOperation( "PrintTree", [ IsObject, IsFunction, IsFunction ] );
DeclareOperation( "PrintTreeRec",
                  [ IsObject, IsFunction, IsFunction, IsInt ] );

DeclareGlobalFunction( "CAP_INTERNAL_REPLACE_STRINGS_WITH_FILTERS" );

