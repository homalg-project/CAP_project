LoadPackage( "RingsForHomalg" );
F5 := HomalgRingOfIntegersInSingular( 5 );
R := F5 * "x,y,z,v,w";;
A := HomalgMatrix( 
"[y^4*v*w^20-y^3*v*w^21-y^7*v^2*w+y^6*v^2*w^2-y+w, x*y^3*v*w^20-y^3*z*v*w^20-x*y^6*v^2*w+y^6*z*v^2*w-x+z]",
2,1, R );
B := HomalgMatrix(
"[y^7*v^2*w^2-y^4*v*w^3+y*w, x*y^6*v^2*w^2-x*y^3*v*w^3+x*w, y^7*z*v^2*w-y^4*z*v*w^2+y*z, x*y^6*z*v^2*w-x*y^3*z*v*w^2+x*z, x*y^4*z^4*v^2*w-z^5*v^2*w^5+x^3*y*z^2*v^2-v^2]",
5,1, R );

# this triggers a hard computation
SyzygiesOfRows( A, B );
