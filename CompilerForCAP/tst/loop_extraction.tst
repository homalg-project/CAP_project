gap> START_TEST( "loop_extraction" );

#
gap> LoadPackage( "CompilerForCAP", false );
true

#
gap> extract_expensive_operations_from_loops_and_display := function ( func )
> local tree, extract_expensive_operations_from_loops, compiled_func;
>   
>   tree := ENHANCED_SYNTAX_TREE( func );
>   tree := CapJitExtractedExpensiveOperationsFromLoops( tree );
>   compiled_func := ENHANCED_SYNTAX_TREE_CODE( tree );
>   Display( compiled_func );
>   
> end;;

#
gap> old_CAP_JIT_EXPENSIVE_FUNCTION_NAMES := ShallowCopy( CAP_JIT_EXPENSIVE_FUNCTION_NAMES );;
gap> MakeReadWriteGlobal( "CAP_JIT_EXPENSIVE_FUNCTION_NAMES" );

## inspired by UnionOfColumnsListList after a very expensive matrix operation
gap> VERY_EXPENSIVE_MATRIX_OPERATION := x -> x;;
gap> func := function ( outer_list, inner_list )
>   return List(
>       outer_list,
>       y -> Concatenation(
>           List(
>               inner_list,
>               x -> VERY_EXPENSIVE_MATRIX_OPERATION( x )[y]
>           )
>       )
>   );
> end;;
gap> CAP_JIT_EXPENSIVE_FUNCTION_NAMES := [ "VERY_EXPENSIVE_MATRIX_OPERATION" ];;
gap> extract_expensive_operations_from_loops_and_display( func );
function ( outer_list_1, inner_list_1 )
    local hoisted_1_1;
    hoisted_1_1 := ListWithKeys( inner_list_1, function ( key_2, x_2 )
            return VERY_EXPENSIVE_MATRIX_OPERATION( x_2 );
        end );
    return List( outer_list_1, function ( y_2 )
            return 
             Concatenation( 
               ListWithKeys( inner_list_1, function ( key_3, x_3 )
                      return hoisted_1_1[key_3][y_2];
                  end ) );
        end );
end

## inspired by UniversalMorphismIntoDirectProductWithGivenDirectProduct in SkeletalFinSets
gap> func :=  function ( cat_1, objects_1, T_1, tau_1, P_1 )
>     return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes(
>        rec( ), cat_1,
>        T_1, P_1,
>        AsList, List( [ 1 .. Length( T_1 ) ], i_2 ->
>            Sum( [ 1 .. Length( objects_1 ) ], j_3 ->
>                \*(
>                    List( tau_1, x_4 -> AsList( x_4 ) )[j_3][i_2],
>                    Product( List( objects_1, x_4 -> Length( x_4 ) ){[ 1 .. (j_3 - 1) ]} )
>                )
>            )
>        )
>    );
> end;;
gap> CAP_JIT_EXPENSIVE_FUNCTION_NAMES := [ "Product" ];;
gap> extract_expensive_operations_from_loops_and_display( func );
function ( cat_1, objects_1, T_1, tau_1, P_1 )
    local hoisted_1_1;
    hoisted_1_1 := ListWithKeys( [ 1 .. Length( objects_1 ) ], 
       function ( key_2, j_2 )
            return Product( List( objects_1, function ( x_3 )
                        return Length( x_3 );
                    end ){[ 1 .. j_2 - 1 ]} );
        end );
    return CreateCapCategoryMorphismWithAttributes( cat_1, T_1, P_1, AsList, 
       List( [ 1 .. Length( T_1 ) ], function ( i_2 )
              return SumWithKeys( [ 1 .. Length( objects_1 ) ], 
                 function ( key_3, j_3 )
                      return List( tau_1, function ( x_4 )
                                    return AsList( x_4 );
                                end )[j_3][i_2] * hoisted_1_1[key_3];
                  end );
          end ) );
end

## deeply nested
gap> func := x_1 ->
>     List( [ 1 .. 2 ], x_2 ->
>         List( [ 1 .. 3 ], x_3 ->
>             List( [ 1 .. 4 ], x_4 ->
>                 List( [ 1 .. 5 ], x_5 ->
>                     List( [ 1 .. x_3 ], x_6 ->
>                         ((x_6 + 6) + (x_5 + 5)) + (x_4 + 4)
>                     )
>                 )
>             )
>         )
>     );;
gap> CAP_JIT_EXPENSIVE_FUNCTION_NAMES := [ "+" ];;
gap> extract_expensive_operations_from_loops_and_display( func );
function ( x_1 )
    local hoisted_1_1, hoisted_2_1, hoisted_3_1, hoisted_4_1, hoisted_5_1;
    hoisted_4_1 := ListWithKeys( [ 1 .. 4 ], function ( key_2, x_2 )
            return x_2 + 4;
        end );
    hoisted_2_1 := ListWithKeys( [ 1 .. 5 ], function ( key_2, x_2 )
            return x_2 + 5;
        end );
    hoisted_1_1 := ListWithKeys( [ 1 .. 3 ], function ( key_2, x_2 )
            return ListWithKeys( [ 1 .. x_2 ], function ( key_3, x_3 )
                    return x_3 + 6;
                end );
        end );
    hoisted_3_1 := ListWithKeys( [ 1 .. 3 ], function ( key_2, x_2 )
            return ListWithKeys( [ 1 .. 5 ], function ( key_3, x_3 )
                    return ListWithKeys( [ 1 .. x_2 ], function ( key_4, x_4 )
                            return hoisted_1_1[key_2][key_4] 
                              + hoisted_2_1[key_3];
                        end );
                end );
        end );
    hoisted_5_1 := ListWithKeys( [ 1 .. 3 ], function ( key_2, x_2 )
            return ListWithKeys( [ 1 .. 4 ], function ( key_3, x_3 )
                    return ListWithKeys( [ 1 .. 5 ], function ( key_4, x_4 )
                            return 
                             ListWithKeys( [ 1 .. x_2 ], 
                               function ( key_5, x_5 )
                                    return hoisted_3_1[key_2][key_4][key_5] 
                                      + hoisted_4_1[key_3];
                                end );
                        end );
                end );
        end );
    return List( [ 1 .. 2 ], function ( x_2 )
            return hoisted_5_1;
        end );
end

## deeply nested with local variable (this is not optimal yet)
gap> func := x_1 ->
>    List( [ 1 .. 2 ], x_2 ->
>        List( [ 1 .. 3 ], x_3 ->
>            List( [ 1 .. 4 ], x_4 ->
>                List( [ 1 .. 5 ], x_5 ->
>                    List( [ 1 .. x_3 ], function ( x_6 )
>                        local tmp_6;
>                        tmp_6 := x_6 + 6;
>                        return (tmp_6 + (x_5 + 5)) + (x_4 + 4);
>                    end )
>                )
>            )
>        )
>    );;
gap> CAP_JIT_EXPENSIVE_FUNCTION_NAMES := [ "+" ];;
gap> extract_expensive_operations_from_loops_and_display( func );
function ( x_1 )
    local hoisted_1_1, hoisted_2_1, hoisted_3_1;
    hoisted_2_1 := ListWithKeys( [ 1 .. 4 ], function ( key_2, x_2 )
            return x_2 + 4;
        end );
    hoisted_1_1 := ListWithKeys( [ 1 .. 5 ], function ( key_2, x_2 )
            return x_2 + 5;
        end );
    hoisted_3_1 := List( [ 1 .. 3 ], function ( x_2 )
            return ListWithKeys( [ 1 .. 4 ], function ( key_3, x_3 )
                    return ListWithKeys( [ 1 .. 5 ], function ( key_4, x_4 )
                            return List( [ 1 .. x_2 ], function ( x_5 )
                                    local tmp_5;
                                    tmp_5 := x_5 + 6;
                                    return tmp_5 + hoisted_1_1[key_4] 
                                      + hoisted_2_1[key_3];
                                end );
                        end );
                end );
        end );
    return List( [ 1 .. 2 ], function ( x_2 )
            return hoisted_3_1;
        end );
end

## deeply nested with possibilities for deduplication
gap> func := x_1 ->
>    List( [ 1 .. 2 ], x_2 ->
>        List( [ 1 .. 3 ], x_3 ->
>            List( [ 1 .. x_3 ], x_4 ->
>                List( [ 1 .. 4 ], x_5 ->
>                    List( [ 1 .. 5 ], x_6 ->
>                        ((x_6 + 6) + (x_5 + 5)) + ((x_6 + 6) + (x_4 + 4))
>                    )
>                )
>            )
>        )
>    );;
gap> CAP_JIT_EXPENSIVE_FUNCTION_NAMES := [ "+" ];;
gap> extract_expensive_operations_from_loops_and_display( func );
function ( x_1 )
    local hoisted_1_1, hoisted_2_1, hoisted_3_1, hoisted_4_1, hoisted_5_1, 
    hoisted_6_1;
    hoisted_3_1 := ListWithKeys( [ 1 .. 3 ], function ( key_2, x_2 )
            return ListWithKeys( [ 1 .. x_2 ], function ( key_3, x_3 )
                    return x_3 + 4;
                end );
        end );
    hoisted_1_1 := ListWithKeys( [ 1 .. 5 ], function ( key_2, x_2 )
            return x_2 + 6;
        end );
    hoisted_5_1 := ListWithKeys( [ 1 .. 3 ], function ( key_2, x_2 )
            return ListWithKeys( [ 1 .. x_2 ], function ( key_3, x_3 )
                    return ListWithKeys( [ 1 .. 5 ], function ( key_4, x_4 )
                            return hoisted_1_1[key_4] 
                              + hoisted_3_1[key_2][key_3];
                        end );
                end );
        end );
    hoisted_2_1 := ListWithKeys( [ 1 .. 4 ], function ( key_2, x_2 )
            return x_2 + 5;
        end );
    hoisted_4_1 := ListWithKeys( [ 1 .. 4 ], function ( key_2, x_2 )
            return ListWithKeys( [ 1 .. 5 ], function ( key_3, x_3 )
                    return hoisted_1_1[key_3] + hoisted_2_1[key_2];
                end );
        end );
    hoisted_6_1 := ListWithKeys( [ 1 .. 3 ], function ( key_2, x_2 )
            return ListWithKeys( [ 1 .. x_2 ], function ( key_3, x_3 )
                    return ListWithKeys( [ 1 .. 4 ], function ( key_4, x_4 )
                            return 
                             ListWithKeys( [ 1 .. 5 ], function ( key_5, x_5 )
                                    return hoisted_4_1[key_4][key_5] 
                                      + hoisted_5_1[key_2][key_3][key_5];
                                end );
                        end );
                end );
        end );
    return List( [ 1 .. 2 ], function ( x_2 )
            return hoisted_6_1;
        end );
end

## expensive operations with the same domain on different levels (this is not optimal yet)
gap> EXPENSIVE_OPERATION := x -> x;;
gap> func := x_1 ->
>    List( [ 1 .. x_1 ], x_2 -> [
>        List( [ 1 .. x_2 ], x_3 -> EXPENSIVE_OPERATION( x_3 ) + x_2 ),
>        List( [ 1 .. x_2 ], x_3 ->
>            List( [ 1 .. x_2 ], x_4 -> EXPENSIVE_OPERATION( x_4 ) + x_2 )
>        )
>    ] );;
gap> CAP_JIT_EXPENSIVE_FUNCTION_NAMES := [ "EXPENSIVE_OPERATION", "+" ];;
gap> extract_expensive_operations_from_loops_and_display( func );
function ( x_1 )
    return List( [ 1 .. x_1 ], function ( x_2 )
            local hoisted_1_2, hoisted_2_2;
            hoisted_1_2 := ListWithKeys( [ 1 .. x_2 ], function ( key_3, x_3 )
                    return EXPENSIVE_OPERATION( x_3 );
                end );
            hoisted_2_2 := ListWithKeys( [ 1 .. x_2 ], function ( key_3, x_3 )
                    return hoisted_1_2[key_3] + x_2;
                end );
            return [ List( [ 1 .. x_2 ], function ( x_3 )
                        return EXPENSIVE_OPERATION( x_3 ) + x_2;
                    end ), List( [ 1 .. x_2 ], function ( x_3 )
                        return hoisted_2_2;
                    end ) ];
        end );
end

## expensive operations in both the domain and the loop body
gap> EXPENSIVE_OPERATION := x -> x;;
gap> func := x_1 ->
>    List( [ 1 .. 2 ], x_2 ->
>        List( [ 1 .. 3 ], x_3 ->
>            List( [ 1 .. EXPENSIVE_OPERATION( x_3 ) ], x_4 ->
>                List( [ 1 .. 4 ], x_5 ->
>                    List( [ 1 .. 5 ], x_6 ->
>                        ((x_6 + 6) + (x_5 + 5)) + (x_4 + 4)
>                    )
>                )
>            )
>        )
>    );;
gap> CAP_JIT_EXPENSIVE_FUNCTION_NAMES := [ "EXPENSIVE_OPERATION", "+" ];;
gap> extract_expensive_operations_from_loops_and_display( func );
function ( x_1 )
    local hoisted_1_1, hoisted_2_1, hoisted_3_1, hoisted_4_1, hoisted_5_1, 
    hoisted_6_1;
    hoisted_5_1 := ListWithKeys( [ 1 .. 3 ], function ( key_2, x_2 )
            return ListWithKeys( [ 1 .. EXPENSIVE_OPERATION( x_2 ) ], 
               function ( key_3, x_3 )
                    return x_3 + 4;
                end );
        end );
    hoisted_4_1 := ListWithKeys( [ 1 .. 3 ], function ( key_2, x_2 )
            return [ 1 .. EXPENSIVE_OPERATION( x_2 ) ];
        end );
    hoisted_2_1 := ListWithKeys( [ 1 .. 4 ], function ( key_2, x_2 )
            return x_2 + 5;
        end );
    hoisted_1_1 := ListWithKeys( [ 1 .. 5 ], function ( key_2, x_2 )
            return x_2 + 6;
        end );
    hoisted_3_1 := ListWithKeys( [ 1 .. 4 ], function ( key_2, x_2 )
            return ListWithKeys( [ 1 .. 5 ], function ( key_3, x_3 )
                    return hoisted_1_1[key_3] + hoisted_2_1[key_2];
                end );
        end );
    hoisted_6_1 := ListWithKeys( [ 1 .. 3 ], function ( key_2, x_2 )
            return ListWithKeys( hoisted_4_1[key_2], function ( key_3, x_3 )
                    return ListWithKeys( [ 1 .. 4 ], function ( key_4, x_4 )
                            return 
                             ListWithKeys( [ 1 .. 5 ], function ( key_5, x_5 )
                                    return hoisted_3_1[key_4][key_5] 
                                      + hoisted_5_1[key_2][key_3];
                                end );
                        end );
                end );
        end );
    return List( [ 1 .. 2 ], function ( x_2 )
            return hoisted_6_1;
        end );
end

#
gap> CAP_JIT_EXPENSIVE_FUNCTION_NAMES := old_CAP_JIT_EXPENSIVE_FUNCTION_NAMES;;
gap> MakeReadOnlyGlobal( "CAP_JIT_EXPENSIVE_FUNCTION_NAMES" );

#
gap> STOP_TEST( "loop_extraction" );
