#! @Chapter Examples and Tests

#! @Section Tests

#! @Example

LoadPackage( "AdditiveClosuresForCAP", false );
#! true

QQ := HomalgFieldOfRationalsInSingular( );;
QQxy := QQ * "x,y";;
EQQxy := KoszulDualRing( QQxy );;
R := KoszulDualRing( HomalgRingOfIntegersInSingular( ) * "x,y" );;

CAP_INTERNAL_GENERATE_DOCUMENTATION_FOR_CATEGORY_INSTANCES(
    [
        [ CategoryOfRows( R ), "CategoryOfRows of an arbitrary ring", 0 ],
        [ CategoryOfRows( EQQxy ), "CategoryOfRows of an exterior algebra over a field", 1 ],
        [ CategoryOfRows( QQxy ), "CategoryOfRows of a commutative ring", 1 ],
        [ CategoryOfRows( QQ ), "CategoryOfRows of a field", 3 ],
    ],
    "AdditiveClosuresForCAP",
    "CategoryOfRows.autogen.gd",
    "Category of rows",
    "Supported CAP operations"
);

#! @EndExample
