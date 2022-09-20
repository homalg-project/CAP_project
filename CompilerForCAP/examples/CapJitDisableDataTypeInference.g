#! @Chapter Examples and tests

#! @Section Tests

#! @Example

LoadPackage( "CompilerForCAP", false );
#! true

func := { list1, list2 } -> List( list1, x -> Sum( list2[x] ) );;
type_signature := [
    [
        rec(
            filter := IsList,
            element_type := rec(
                filter := IsInt,
            ),
        ),
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
#! function ( list1_1, list2_1 )
#!     return List( list1_1, function ( x_2 )
#!             return Sum( list2_1[x_2] );
#!         end );
#! end

CapJitEnableDataTypeInference( );

Display( CapJitCompiledFunction( func, type_signature ) );
#! function ( list1_1, list2_1 )
#!     local hoisted_3_1;
#!     hoisted_3_1 := List( list2_1, Sum );
#!     return List( list1_1, function ( x_2 )
#!             return hoisted_3_1[x_2];
#!         end );
#! end

#! @EndExample
