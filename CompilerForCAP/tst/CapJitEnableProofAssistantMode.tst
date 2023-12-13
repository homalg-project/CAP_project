gap> START_TEST( "CapJitEnableProofAssistantMode" );

#
gap> LoadPackage( "CompilerForCAP", false );
true

# no deduplication and hoisting in proof assistant mode
gap> func := function ( L, x )
>   return List( L, l -> [ l + (x + 1), l + (x + 1) ] );
> end;;

#
gap> CapJitEnableProofAssistantMode( );
gap> Display( CapJitCompiledFunction( func ) );
function ( L_1, x_1 )
    return List( L_1, function ( l_2 )
            return [ l_2 + (x_1 + 1), l_2 + (x_1 + 1) ];
        end );
end

#
gap> CapJitDisableProofAssistantMode( );
gap> Display( CapJitCompiledFunction( func ) );
function ( L_1, x_1 )
    local hoisted_1_1;
    hoisted_1_1 := x_1 + 1;
    return List( L_1, function ( l_2 )
            local deduped_1_2;
            deduped_1_2 := l_2 + hoisted_1_1;
            return [ deduped_1_2, deduped_1_2 ];
        end );
end

# `List( L, func )[i]` triggers different logic templates in proof assistant mode than in normal mode
gap> func := function ( L, index_1, index_2 )
>   return [
>       List( L, IsZero )[index_1],
>       List( L, IsZero )[index_2],
>   ];
> end;;

#
gap> CapJitEnableProofAssistantMode( );
gap> compiled_func := CapJitCompiledFunction( func, Pair( [ CapJitDataTypeOfListOf( IsInt ), rec( filter := IsInt ), rec( filter := IsInt ) ], fail ) );;
gap> Display( compiled_func );
function ( L_1, index_1_1, index_2_1 )
    return [ IsZero( L_1[index_1_1] ), IsZero( L_1[index_2_1] ) ];
end

#
gap> CapJitDisableProofAssistantMode( );
gap> Display( CapJitCompiledFunction( compiled_func, Pair( [ CapJitDataTypeOfListOf( IsInt ), rec( filter := IsInt ), rec( filter := IsInt ) ], fail ) ) );
function ( L_1, index_1_1, index_2_1 )
    local deduped_3_1;
    deduped_3_1 := List( L_1, IsZero );
    return [ deduped_3_1[index_1_1], deduped_3_1[index_2_1] ];
end

#
gap> STOP_TEST( "CapJitEnableProofAssistantMode" );
