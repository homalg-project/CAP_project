LoadPackage( "ActionsForCAP" );
LoadPackage( "LinearAlgebraForCAP" );
Q := HomalgFieldOfRationals();
vec := MatrixCategory( Q );
semisimple_cat := SemisimpleCategory( vec, ReturnFalse, ReturnFalse );