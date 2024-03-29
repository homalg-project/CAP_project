gap> START_TEST( "CapJitDisableDataTypeInference" );

#
gap> LoadPackage( "CompilerForCAP", false );
true

#
gap> func := { list1, list2 } -> List( list1, x -> Sum( list2[x] ) );;
gap> type_signature := [
>     [
>         CapJitDataTypeOfListOf( IsInt ),
>         CapJitDataTypeOfListOf( CapJitDataTypeOfListOf( IsInt ) ),
>     ],
>     fail,
> ];;

#
gap> CapJitDisableDataTypeInference( );

#
gap> Display( CapJitCompiledFunction( func, type_signature ) );
function ( list1_1, list2_1 )
    return List( list1_1, function ( x_2 )
            return Sum( list2_1[x_2] );
        end );
end

#
gap> CapJitEnableDataTypeInference( );

#
gap> Display( CapJitCompiledFunction( func, type_signature ) );
function ( list1_1, list2_1 )
    local hoisted_1_1;
    hoisted_1_1 := List( list2_1, Sum );
    return List( list1_1, function ( x_2 )
            return hoisted_1_1[x_2];
        end );
end

#
gap> STOP_TEST( "CapJitDisableDataTypeInference" );
