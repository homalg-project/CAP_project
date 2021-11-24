#! @Chapter Examples and Tests

#! @Section Tests

#! @Example

LoadPackage( "FreydCategoriesForCAP", false );
#! true

QQ := HomalgFieldOfRationalsInSingular( );;
QQxy := QQ * "x,y";;
EEE := KoszulDualRing( QQxy * "a,b" );;

CAP_INTERNAL_GENERATE_DOCUMENTATION_FOR_CATEGORY_INSTANCES(
    [
        [ CategoryOfRows( EEE ), "CategoryOfRows of an arbitrary ring" ],
        [ CategoryOfRows( QQxy ), "CategoryOfRows of a commutative ring" ],
        [ CategoryOfRows( QQ ), "CategoryOfRows of a field" ],
    ],
    "FreydCategoriesForCAP",
    "CategoryOfRows.autogen.gd",
    "Category of rows",
    "Supported CAP operations"
);

#! @EndExample
