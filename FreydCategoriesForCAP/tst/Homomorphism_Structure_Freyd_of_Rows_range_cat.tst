gap> START_TEST( "Homomorphism_Structure_Freyd_of_Rows_range_cat" );

#
gap> LoadPackage( "AdditiveClosuresForCAP", false );
true
gap> QQ := HomalgFieldOfRationalsInSingular( );;
gap> QQxy := QQ * "x,y";;
gap> EQQxy := KoszulDualRing( QQxy );;
gap> rows := CategoryOfRows( EQQxy );;

# make sure FreydCategory( rows ) has the same range category of hom structure as rows
# this can only be the case if FreydCategory is able to determine that the distinguished object is projective
gap> IsIdenticalObj( RangeCategoryOfHomomorphismStructure( FreydCategory( rows ) ), RangeCategoryOfHomomorphismStructure( rows ) );
true

#
gap> STOP_TEST( "Homomorphism_structure_Freyd_of_Rows_range_cat" );
