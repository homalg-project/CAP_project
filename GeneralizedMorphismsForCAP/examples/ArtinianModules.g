LoadPackage( "ModulePresentationsForCAP" );
LoadPackage( "GeneralizedMorphismsForCAP" );
LoadPackage( "RingsForHomalg" );

is_artinian_left := function( module )
  local mat;
    
    mat := UnderlyingMatrix( module );
    
    return IsZero( HilbertPolynomial( mat ) );
    
end;

is_artinian_right := function( module )
  local mat;
    
    mat := UnderlyingMatrix( module );
    
    mat := TransposedMat( mat );
    
    return IsZero( HilbertPolynomial( mat ) );
    
end;

R := HomalgFieldOfRationalsInSingular( ) * "x,y,z";

serre_quotient := LeftPresentations( R ) / is_artinian_left;


