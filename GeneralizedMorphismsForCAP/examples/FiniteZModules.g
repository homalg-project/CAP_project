LoadPackage( "ModulePresentationsForCAP" );
LoadPackage( "GeneralizedMorphismsForCAP" );

tester_function_left := function( module )
  local mat, smith_mat;
    
    mat := EntriesOfHomalgMatrixAsListList( UnderlyingMatrix( module ) );
    
    smith_mat := SmithNormalFormIntegerMat( mat );
    
    smith_mat := TransposedMat( smith_mat );
    
    return not ForAny( smith_mat, i -> ForAll( i, j -> j = 0 ) );
    
end;

tester_function_right := function( module )
  local mat, smith_mat;
    
    mat := EntriesOfHomalgMatrixAsListList( UnderlyingMatrix( module ) );
    
    smith_mat := SmithNormalFormIntegerMat( mat );
    
    return ForAny( smith_mat, i -> ForAll( i, j -> j = 0 ) );
    
end;

ZZ := HomalgRingOfIntegers( );

C1 := FreeLeftPresentation( 1, ZZ );

C2 := FreeLeftPresentation( 2, ZZ );

h1 := PresentationMorphism( C2, HomalgMatrix( [ [ 0 ], [ 4 ] ], ZZ ), C1 );

h2 := PresentationMorphism( C2, HomalgMatrix( [ [ 0 ], [ 2 ] ], ZZ ), C1 );

v1 := PresentationMorphism( C2, HomalgMatrix( [ [ 2, 0 ], [ 1, 2 ] ], ZZ ), C2 );

v2 := PresentationMorphism( C1, HomalgMatrix( [ [ 4 ] ], ZZ ), C1 );

quotient := LeftPresentations( ZZ ) / tester_function_left;

v1_serre := AsSerreQuotientCategoryMorphism( quotient, v1 );

IsIsomorphism( v1_serre );
