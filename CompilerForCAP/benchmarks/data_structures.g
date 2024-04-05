LoadPackage( "CompilerForCAP", false );
LoadPackage( "FreydCategoriesForCAP", false );

# simplification of data structures
R := HomalgRingOfIntegers( );

rows := CategoryOfRows( R );
CapCategorySwitchLogicOff( rows );

CR := RingAsCategory( R );
CapCategorySwitchLogicOff( CR );
unique_object := RingAsCategoryUniqueObject( CR );

add := AdditiveClosure( CR );
CapCategorySwitchLogicOff( add );

func_zero_matrix := function ( nr_rows, nr_cols )
  local mat;
    
    mat := List( [ 1 .. nr_rows ], i ->
        List( [ 1 .. nr_cols ], j ->
            0
        )
    );
    
    return mat;
    
end;

func_rows := function ( nr_rows, nr_cols )
  local mat, source, target;
    
    mat := List( [ 1 .. nr_rows ], i ->
        List( [ 1 .. nr_cols ], j ->
            0
        )
    );
    
    source := CreateCapCategoryObjectWithAttributes( rows, RankOfObject, nr_rows );
    target := CreateCapCategoryObjectWithAttributes( rows, RankOfObject, nr_cols );
    
    return CreateCapCategoryMorphismWithAttributes( rows,
        source, target,
        UnderlyingMatrix, HomalgMatrix( mat, nr_rows, nr_cols, R )
    );
    
end;

func_additive_closure := function ( nr_rows, nr_cols )
  local source, target;
    
    source := CreateCapCategoryObjectWithAttributes( add, ObjectList, ListWithIdenticalEntries( nr_rows, unique_object ) );
    target := CreateCapCategoryObjectWithAttributes( add, ObjectList, ListWithIdenticalEntries( nr_cols, unique_object ) );
    
    return CreateCapCategoryMorphismWithAttributes( add,
        source, target,
        MorphismMatrix, List( [ 1 .. nr_rows ], i ->
            List( [ 1 .. nr_cols ], j ->
                CreateCapCategoryMorphismWithAttributes( CR,
                    unique_object, unique_object,
                    UnderlyingRingElement, 0
                )
            )
        )
    );
    
end;

# benchmark
m := 1; # 1, 500, 1000, 2000, 4000, 8000

Display( "start" );

CollectGarbage( true );
StartTimer( "benchmark" );
func_additive_closure( 1000, m ); # func_additive_closure, func_rows, func_zero_matrix
DisplayTimer( "benchmark" );
