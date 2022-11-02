gap> START_TEST( "CapJitResolvedGlobalVariables" );

#
gap> LoadPackage( "CompilerForCAP", false );
true

# check that CapJitResolvedGlobalVariables is idempotent
#
gap> CapJitDisableDataTypeInference( );

#
gap> MY_GLOBAL_FUNCTION_1 := function ( x )
>     #% CAP_JIT_RESOLVE_FUNCTION
>     return x; end;;

#
gap> MY_GLOBAL_FUNCTION_2 := function ( x )
>     #% CAP_JIT_RESOLVE_FUNCTION
>     return MY_GLOBAL_FUNCTION_1( x ); end;;

#
gap> MY_CAP_CATEGORY_1 := CreateCapCategory( );;
gap> MY_CAP_CATEGORY_2 := CreateCapCategory( );;
gap> SetUnderlyingCategory( MY_CAP_CATEGORY_1, MY_CAP_CATEGORY_2 );

#
gap> DeclareAttribute( "MyAttribute", IsCapCategory );

#
gap> SetMyAttribute( MY_CAP_CATEGORY_2, MY_GLOBAL_FUNCTION_2 );

#
gap> func := function ( )
>   return MY_GLOBAL_FUNCTION_2( MyAttribute(
>         UnderlyingCategory( MY_CAP_CATEGORY_1 )
>     ) ); end;;

#
gap> tree := ENHANCED_SYNTAX_TREE( func );;

#
gap> tree := CapJitResolvedGlobalVariables( tree );;
gap> Display( ENHANCED_SYNTAX_TREE_CODE( tree ) );
function (  )
    return function ( x_2 )
            return function ( x_3 )
                    return x_3;
                end( x_2 );
        end( function ( x_2 )
            return function ( x_3 )
                    return x_3;
                end( x_2 );
        end );
end

#
gap> tree2 := CapJitResolvedGlobalVariables( tree );;
gap> Display( ENHANCED_SYNTAX_TREE_CODE( tree2 ) );
function (  )
    return function ( x_2 )
            return function ( x_3 )
                    return x_3;
                end( x_2 );
        end( function ( x_2 )
            return function ( x_3 )
                    return x_3;
                end( x_2 );
        end );
end

#
gap> tree = tree2;
true

# test category_attribute_resolving_functions
gap> MY_CAP_CATEGORY_3 := CreateCapCategory( );;
gap> SetMyAttribute( MY_CAP_CATEGORY_3, 1 );
gap> MY_CAP_CATEGORY_3!.compiler_hints := rec(
>     category_attribute_names := [
>         "MyAttribute"
>     ],
> );;

#
gap> func := cat -> MyAttribute( cat );;
gap> Display( CapJitCompiledFunction( func, MY_CAP_CATEGORY_3 ) );
function ( cat_1 )
    return MyAttribute( cat_1 );
end

#
gap> MY_CAP_CATEGORY_3!.compiler_hints.category_attribute_resolving_functions :=
>   rec(
>     MyAttribute := { } -> rec( type := "EXPR_INT", value := 1 ),
> );;

#
gap> Display( CapJitCompiledFunction( func, MY_CAP_CATEGORY_3 ) );
function ( cat_1 )
    return 1;
end

#
gap> CapJitEnableDataTypeInference( );

#
gap> STOP_TEST( "CapJitResolvedGlobalVariables" );
