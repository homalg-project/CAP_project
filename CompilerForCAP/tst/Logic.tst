gap> START_TEST( "Logic" );

#
gap> LoadPackage( "CompilerForCAP", false );
true

#
gap> func := function ( )
>   return List( [ 1, 2 ], x -> x ); end;;

#
gap> tree := ENHANCED_SYNTAX_TREE( func );;
gap> tree := CapJitAppliedLogic( tree );;
gap> Display( ENHANCED_SYNTAX_TREE_CODE( tree ) );
function (  )
    return [ function ( x_2 )
                return x_2;
            end( 1 ), function ( x_2 )
                return x_2;
            end( 2 ) ];
end

#
gap> func := function ( L1, L2 )
>   return List( Concatenation( L1, L2 ), x -> x ); end;;

#
gap> tree := ENHANCED_SYNTAX_TREE( func );;
gap> tree := CapJitAppliedLogic( tree );;
gap> Display( ENHANCED_SYNTAX_TREE_CODE( tree ) );
function ( L1_1, L2_1 )
    return Concatenation( List( L1_1, function ( x_2 )
              return x_2;
          end ), List( L2_1, function ( x_2 )
              return x_2;
          end ) );
end

#
gap> func := function ( )
>   return Concatenation( [ [ 1, 2, 3, 4 ] ] ); end;;

#
gap> tree := ENHANCED_SYNTAX_TREE( func );;
gap> tree := CapJitAppliedLogic( tree );;
gap> Display( ENHANCED_SYNTAX_TREE_CODE( tree ) );
function (  )
    return [ 1, 2, 3, 4 ];
end

#
gap> func := function ( )
>   return Concatenation( [ [ 1, 2 ], [ 3, 4 ] ] ); end;;

#
gap> tree := ENHANCED_SYNTAX_TREE( func );;
gap> tree := CapJitAppliedLogic( tree );;
gap> Display( ENHANCED_SYNTAX_TREE_CODE( tree ) );
function (  )
    return [ 1, 2, 3, 4 ];
end

#
gap> func := function ( )
>   return Concatenation( [ 1, 2 ], [ 3, 4 ] ); end;;

#
gap> tree := ENHANCED_SYNTAX_TREE( func );;
gap> tree := CapJitAppliedLogic( tree );;
gap> Display( ENHANCED_SYNTAX_TREE_CODE( tree ) );
function (  )
    return [ 1, 2, 3, 4 ];
end

#
gap> func := function ( my_func )
>   return CallFuncList( my_func, [ 1, 2 ] ); end;;

#
gap> tree := ENHANCED_SYNTAX_TREE( func );;
gap> tree := CapJitAppliedLogic( tree );;
gap> Display( ENHANCED_SYNTAX_TREE_CODE( tree ) );
function ( my_func_1 )
    return my_func_1( 1, 2 );
end

#
gap> func := function ( x )
>   if 1 = 2 then return 1; elif x = x then return 2; else return 3; fi; end;;

#
gap> tree := ENHANCED_SYNTAX_TREE( func );;
gap> tree := CapJitAppliedLogic( tree );;
gap> Display( ENHANCED_SYNTAX_TREE_CODE( tree ) );
function ( x_1 )
    if false then
        return 1;
    elif true then
        return 2;
    else
        return 3;
    fi;
    return;
end

#
gap> func := function ( x )
>   return Length( [ 1, 2, 3 ] ); end;;

#
gap> tree := ENHANCED_SYNTAX_TREE( func );;
gap> tree := CapJitAppliedLogic( tree );;
gap> Display( ENHANCED_SYNTAX_TREE_CODE( tree ) );
function ( x_1 )
    return 3;
end

#
gap> func := function ( x )
>   return [ 1 .. 3 ]; end;;

#
gap> tree := ENHANCED_SYNTAX_TREE( func );;
gap> tree := CapJitAppliedLogic( tree );;
gap> Display( ENHANCED_SYNTAX_TREE_CODE( tree ) );
function ( x_1 )
    return [ 1, 2, 3 ];
end

#
gap> func := function ( x )
>   return Last( [ 3, 2, 1 ] ); end;;

#
gap> tree := ENHANCED_SYNTAX_TREE( func );;
gap> tree := CapJitAppliedLogic( tree );;
gap> Display( ENHANCED_SYNTAX_TREE_CODE( tree ) );
function ( x_1 )
    return 1;
end

#
gap> func := function ( list_of_lists )
>   return Length( Concatenation( list_of_lists ) ); end;;

#
gap> tree := ENHANCED_SYNTAX_TREE( func );;
gap> tree := CapJitAppliedLogic( tree );;
gap> Display( ENHANCED_SYNTAX_TREE_CODE( tree ) );
function ( list_of_lists_1 )
    return Sum( List( list_of_lists_1, Length ) );
end

#
gap> func := function ( list1, list2, list3 )
>   return Length( Concatenation( list1, list2, list3 ) ); end;;

#
gap> tree := ENHANCED_SYNTAX_TREE( func );;
gap> tree := CapJitAppliedLogic( tree );;
gap> Display( ENHANCED_SYNTAX_TREE_CODE( tree ) );
function ( list1_1, list2_1, list3_1 )
    return Sum( [ Length( list1_1 ), Length( list2_1 ), Length( list3_1 ) ] );
end

#
gap> func := cat -> CapCategory( CreateCapCategoryObjectWithAttributes( cat ) );;

#
gap> tree := ENHANCED_SYNTAX_TREE( func );;
gap> tree := CapJitAppliedLogic( tree );;
gap> Display( ENHANCED_SYNTAX_TREE_CODE( tree ) );
function ( cat_1 )
    return cat_1;
end

#
gap> func := { cat, obj } -> CapCategory( CreateCapCategoryMorphismWithAttributes( cat, obj, obj ) );;

#
gap> tree := ENHANCED_SYNTAX_TREE( func );;
gap> tree := CapJitAppliedLogic( tree );;
gap> Display( ENHANCED_SYNTAX_TREE_CODE( tree ) );
function ( cat_1, obj_1 )
    return cat_1;
end

#
gap> func := { x } -> AdditiveInverse( CAP_JIT_INTERNAL_EXPR_CASE( x, 1, true, 2 ) );;

#
gap> tree := ENHANCED_SYNTAX_TREE( func );;
gap> tree := CapJitAppliedLogic( tree );;
gap> Display( ENHANCED_SYNTAX_TREE_CODE( tree ) );
function ( x_1 )
    if x_1 then
        return AdditiveInverse( 1 );
    else
        return AdditiveInverse( 2 );
    fi;
    return;
end

#
gap> STOP_TEST( "Logic" );
