#! @Chapter Examples and tests

#! @Section Tests

#! @Example

LoadPackage( "FreydCategoriesForCAP", false );
#! true

QQ := HomalgFieldOfRationalsInSingular( );;
QQxy := QQ * "x,y";;
EEE := KoszulDualRing( QQxy * "a,b" );;

precompile_CategoryOfColumns := function( homalg_ring, name )
    
    CapJitPrecompileCategoryAndCompareResult(
        homalg_ring -> CategoryOfColumnsAsOppositeOfCategoryOfRows(
            homalg_ring
        ),
        [ homalg_ring ],
        "FreydCategoriesForCAP",
        Concatenation(
            "CategoryOfColumnsAsOppositeOfCategoryOfRowsOf",
            name,
            "Precompiled"
        ) :
        operations := "primitive"
    ); end;;

precompile_CategoryOfColumns( QQ, "Field" );;
precompile_CategoryOfColumns( QQxy, "CommutativeRing" );;
precompile_CategoryOfColumns( EEE, "ArbitraryRing" );;

#! @EndExample
