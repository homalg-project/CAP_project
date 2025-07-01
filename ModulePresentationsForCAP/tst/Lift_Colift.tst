gap> START_TEST( "Lift/Colift" );

gap> LoadPackage( "ModulePresentationsForCAP", false );
true

gap> LoadPackage( "RingsForHomalg", false );
true

gap> Qx := HomalgFieldOfRationalsInSingular() * "x";;
gap> Qx_lpres := LeftPresentations( Qx );;
gap> M_mat := HomalgMatrix( "[ [ 31*x^2, 34*x^2+11*x+32, 0, 0, 42*x ], [ 0, 0, 0, 0, 0 ] ]", 2, 5, Qx );;
gap> M := AsLeftPresentation( M_mat );;
gap> N_mat := HomalgMatrix( "[ [ 0, 0, 0, 0, 128954616*x^3+941617341*x^2+907117596*x+56921403, 39256140*x^3+41218947*x^2, 72623859*x^2+69844593*x+907117596, 70661052, 37293333*x^3+25516491*x, 98140350*x^3+69688290*x^2+561548988*x ], [ 0, 39*x, 38*x^3, 18*x^3+38*x^2, 0, 0, 48*x^3+37*x, 0, 0, 8*x^2 ], [ 0, 0, 0, 0, -580852608*x^3-1254907101*x^2-827402436*x-141045009, -97272420*x^3-102136041*x^2, -179953977*x^2-447450297*x-827402436, -175090356, -92408799*x^3-63227073*x, -243181050*x^3-342536124*x^2-512201508*x ] ]", 3, 10, Qx );;
gap> N := AsLeftPresentation( N_mat );;
gap> P_mat := HomalgMatrix( "[ [ 0, 0, 714*x-3696, 0 ] ]", 1, 4, Qx );;
gap> P := AsLeftPresentation( P_mat );;
gap> f_mat := HomalgMatrix( "[ [ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 ], [ 0, 0, 0, 0, 166751424*x^5+94916052*x^4-127178772*x^3-42880992*x^2+13268892*x, 69479760*x^5+82104708*x^4+9608508*x^3, 128537556*x^4+75987072*x^3+7778316*x^2-143626644*x, 125063568*x^2+16471728*x, 66005772*x^5+8693412*x^4+45161844*x^3+5948124*x^2, 173699400*x^5+106253112*x^4+10981152*x^3-88911732*x^2 ], [ 1450*x^4+1161*x^3+162*x^2, 1400*x^3+252*x^2, 0, 0, 450*x+81, 0, 0, 500*x^4+90*x^3+800*x^2+144*x, 2350*x^3+2523*x^2+1028*x+117, 0 ], [ 0, 0, 0, 0, 71464896*x^5+40678308*x^4-54505188*x^3-18377568*x^2+5686668*x, 29777040*x^5+35187732*x^4+4117932*x^3+420*x^2+555*x+240, 55087524*x^4+32566428*x^3+3333564*x^2-61554276*x, 53598672*x^2+7059312*x, 28288188*x^5+3725748*x^4+19355076*x^3+2549196*x^2, 74442600*x^5+45537048*x^4+4706358*x^3-38105028*x^2+720*x+480 ], [ 0, 0, 0, 0, -3970272000*x^4-2259906000*x^3+3028066000*x^2+1020976000*x-315926000, -1654280000*x^4-1954874000*x^3-228774000*x^2, -3060418000*x^3-1809216000*x^2-185198000*x+3419682000, -2977704000*x-392184000, -1571566000*x^4-206986000*x^3-1075282000*x^2-141622000*x, -4135700000*x^4-2529836000*x^3-261456000*x^2+2116946000*x ] ]", 5, 10, Qx );;
gap> f := PresentationMorphism( M, f_mat, N );;
gap> g_mat := HomalgMatrix( "[ [ 29*x^3+18*x^2, 28*x^2, 0, 0, 9, 0, 0, 10*x^3+16*x, 47*x^2+42*x+13, 0 ], [ 0, 0, 0, 0, 0, 28*x^2+37*x+16, 36*x^3, 0, 0, 10*x^3+48*x+32 ], [ 0, 0, 0, 0, 1985136*x^4+1129953*x^3-1514033*x^2-510488*x+157963, 827140*x^4+977437*x^3+114387*x^2, 1530209*x^3+904608*x^2+92599*x-1709841, 1488852*x+196092, 785783*x^4+103493*x^3+537641*x^2+70811*x, 2067850*x^4+1264918*x^3+130728*x^2-1058473*x ], [ 43*x, 0, 0, 0, 5*x, 0, 0, 0, 14*x^3, 34 ] ]", 4, 10, Qx );;
gap> g := PresentationMorphism( P, g_mat, N );;
gap> l := Lift( f, g );;
gap> Assert( 0, PreCompose( l, Colift( l, f ) ) = f and PreCompose( l, g ) = f );
gap> Qx_rpres := RightPresentations( Qx );;
gap> M := AsRightPresentation( TransposedMatrix( M_mat ) );;
gap> N := AsRightPresentation( TransposedMatrix( N_mat ) );;
gap> P := AsRightPresentation( TransposedMatrix( P_mat ) );;
gap> f := PresentationMorphism( M, TransposedMatrix( f_mat ), N );;
gap> g := PresentationMorphism( P, TransposedMatrix( g_mat ), N );;
gap> l := Lift( f, g );;
gap> Assert( 0, PreCompose( l, Colift( l, f ) ) = f and PreCompose( l, g ) = f );;

gap> STOP_TEST( "Lift/Colift" );
