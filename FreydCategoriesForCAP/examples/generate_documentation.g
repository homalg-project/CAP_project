#! @Chapter Examples and Tests

#! @Section Tests

#! @Example

LoadPackage( "FreydCategoriesForCAP", false );
#! true

QQ := HomalgFieldOfRationalsInSingular( );;
QQxy := QQ * "x,y";;
EQQxy := KoszulDualRing( QQxy );;
R := KoszulDualRing( HomalgRingOfIntegersInSingular( ) * "x,y" );;

CAP_INTERNAL_GENERATE_DOCUMENTATION_FOR_CATEGORY_INSTANCES(
    [
        [ CategoryOfRows( R ), "CategoryOfRows of an arbitrary ring" ],
        [ CategoryOfRows( EQQxy ), "CategoryOfRows of an exterior algebra over a field" ],
        [ CategoryOfRows( QQxy ), "CategoryOfRows of a commutative ring" ],
        [ CategoryOfRows( QQ ), "CategoryOfRows of a field" ],
    ],
    "FreydCategoriesForCAP",
    "CategoryOfRows.autogen.gd",
    "Category of rows",
    "Supported CAP operations"
);

#! @EndExample
