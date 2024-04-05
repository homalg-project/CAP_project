LoadPackage( "CompilerForCAP", false );
LoadPackage( "FreydCategoriesForCAP", false );

star := RingAsCategoryUniqueObject( RingAsCategory( Integers ) );

func_tuples := function ( m, n )
    
    return Length( Concatenation( ListWithIdenticalEntries( m, star ), ListWithIdenticalEntries( n, star ) ) );
    
end;

func_integers := function ( m, n )
    
    return m + n;
    
end;

m := 1; # 1, 25, 50, 100, 200, 400, 10^(10^9)
m := m * 10^6;

CollectGarbage( true );
StartTimer( "benchmark" );
func_tuples( m, m ); # func_tuples or func_integers
DisplayTimer( "benchmark" );
