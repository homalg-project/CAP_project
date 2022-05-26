#! @Chapter Examples and tests

#! @Section Tests

#! @Example

LoadPackage( "CompilerForCAP", false );
#! true

func := list -> Sum( list[1] );;
type_signature := [
    [
        rec(
            filter := IsList,
            element_type := rec(
                filter := IsList,
                element_type := rec(
                    filter := IsInt,
                ),
            ),
        ),
    ],
    fail,
];;

CapJitDisableDataTypeInference( );

Display( CapJitCompiledFunction( func, type_signature ) );
#! function ( list_1 )
#!     return Sum( list_1[1] );
#! end

CapJitEnableDataTypeInference( );

Display( CapJitCompiledFunction( func, type_signature ) );
#! function ( list_1 )
#!     return List( list_1, Sum )[1];
#! end

#! @EndExample
