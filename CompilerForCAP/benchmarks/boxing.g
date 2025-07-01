LoadPackage( "CompilerForCAP", false );
LoadPackage( "AdditiveClosuresForCAP", false );

DeactivateDefaultCaching( );

# overhead of boxing and unboxing
R := HomalgRingOfIntegers( );

CR := RingAsCategory( R );
CapCategorySwitchLogicOff( CR );
unique_object := RingAsCategoryUniqueObject( CR );

add := AdditiveClosure( CR );
CapCategorySwitchLogicOff( add );

# generate compiled_func as follows:
# func := function ( cat, alpha, beta, gamma )
#     
#     return AdditionForMorphisms( cat, AdditionForMorphisms( cat, alpha, beta ), gamma );
#     
# end;
# 
# compiled_func := CapJitCompiledFunction( func, add, [ "category", "morphism", "morphism", "morphism" ], "morphism" );
# 
# Display( compiled_func );

compiled_func := function ( cat_1, alpha_1, beta_1, gamma_1 )
  local hoisted_1_1, hoisted_2_1, hoisted_3_1, deduped_5_1, hoisted_6_1, deduped_7_1, deduped_8_1, deduped_9_1;
    deduped_9_1 := UnderlyingCategory(
        cat_1
    );
    deduped_8_1 := Range(
        alpha_1
    );
    deduped_7_1 := Source(
        alpha_1
    );
    hoisted_6_1 := [ 1 .. Length(
            ObjectList(
                deduped_8_1
            )
        ) ];
    deduped_5_1 := RingAsCategoryUniqueObject(
        deduped_9_1
    );
    hoisted_3_1 := List(
        MorphismMatrix(
            gamma_1
        ),
        function ( logic_new_func_list_2 )
            return (
                List(
                    logic_new_func_list_2,
                    UnderlyingRingElement
                )
            );
        end
    );
    hoisted_2_1 := List(
        MorphismMatrix(
            beta_1
        ),
        function ( logic_new_func_list_2 )
            return (
                List(
                    logic_new_func_list_2,
                    UnderlyingRingElement
                )
            );
        end
    );
    hoisted_1_1 := List(
        MorphismMatrix(
            alpha_1
        ),
        function ( logic_new_func_list_2 )
            return (
                List(
                    logic_new_func_list_2,
                    UnderlyingRingElement
                )
            );
        end
    );
    return (
        CreateCapCategoryMorphismWithAttributes(
            cat_1,
            deduped_7_1,
            deduped_8_1,
            MorphismMatrix,
            List(
                [ 1 .. Length(
                        ObjectList(
                            deduped_7_1
                        )
                    ) ],
                function ( i_2 )
                  local hoisted_1_2, hoisted_2_2, hoisted_3_2, deduped_4_2;
                    deduped_4_2 := CAP_JIT_INCOMPLETE_LOGIC(
                        i_2
                    );
                    hoisted_3_2 := hoisted_3_1[i_2];
                    hoisted_2_2 := hoisted_2_1[deduped_4_2];
                    hoisted_1_2 := hoisted_1_1[deduped_4_2];
                    return (
                        List(
                            hoisted_6_1,
                            function ( j_3 )
                              local deduped_1_3;
                                deduped_1_3 := CAP_JIT_INCOMPLETE_LOGIC(
                                    j_3
                                );
                                return (
                                    CreateCapCategoryMorphismWithAttributes(
                                        deduped_9_1,
                                        deduped_5_1,
                                        deduped_5_1,
                                        UnderlyingRingElement,
                                        CAP_JIT_INCOMPLETE_LOGIC(
                                              hoisted_1_2[deduped_1_3] + hoisted_2_2[deduped_1_3]
                                          ) + hoisted_3_2[j_3]
                                    )
                                );
                            end
                        )
                    );
                end
            )
        )
    );
end;

compiled_func_without_canceling_boxing := function ( cat_1, alpha_1, beta_1, gamma_1 )
  local hoisted_1_1, hoisted_2_1, deduped_4_1, hoisted_5_1, hoisted_6_1, hoisted_7_1, hoisted_8_1, deduped_9_1, deduped_10_1, deduped_11_1, deduped_12_1, deduped_13_1, deduped_14_1;
    deduped_14_1 := UnderlyingCategory(
        cat_1
    );
    deduped_13_1 := Range(
        alpha_1
    );
    deduped_12_1 := Source(
        alpha_1
    );
    hoisted_5_1 := [ 1 .. Length(
            ObjectList(
                deduped_13_1
            )
        ) ];
    deduped_4_1 := RingAsCategoryUniqueObject(
        deduped_14_1
    );
    hoisted_2_1 := List(
        MorphismMatrix(
            beta_1
        ),
        function ( logic_new_func_list_2 )
            return (
                List(
                    logic_new_func_list_2,
                    UnderlyingRingElement
                )
            );
        end
    );
    hoisted_1_1 := List(
        MorphismMatrix(
            alpha_1
        ),
        function ( logic_new_func_list_2 )
            return (
                List(
                    logic_new_func_list_2,
                    UnderlyingRingElement
                )
            );
        end
    );
    deduped_11_1 := CreateCapCategoryMorphismWithAttributes(
        cat_1,
        deduped_12_1,
        deduped_13_1,
        MorphismMatrix,
        List(
            [ 1 .. Length(
                    ObjectList(
                        deduped_12_1
                    )
                ) ],
            function ( i_2 )
              local hoisted_1_2, hoisted_2_2;
                hoisted_2_2 := hoisted_2_1[i_2];
                hoisted_1_2 := hoisted_1_1[i_2];
                return (
                    List(
                        hoisted_5_1,
                        function ( j_3 )
                            return (
                                CreateCapCategoryMorphismWithAttributes(
                                    deduped_14_1,
                                    deduped_4_1,
                                    deduped_4_1,
                                    UnderlyingRingElement,
                                    hoisted_1_2[j_3] + hoisted_2_2[j_3]
                                )
                            );
                        end
                    )
                );
            end
        )
    );
    deduped_10_1 := Range(
        deduped_11_1
    );
    deduped_9_1 := Source(
        deduped_11_1
    );
    hoisted_8_1 := [ 1 .. Length(
            ObjectList(
                deduped_10_1
            )
        ) ];
    hoisted_7_1 := List(
        MorphismMatrix(
            gamma_1
        ),
        function ( logic_new_func_list_2 )
            return (
                List(
                    logic_new_func_list_2,
                    UnderlyingRingElement
                )
            );
        end
    );
    hoisted_6_1 := List(
        MorphismMatrix(
            deduped_11_1
        ),
        function ( logic_new_func_list_2 )
            return (
                List(
                    logic_new_func_list_2,
                    UnderlyingRingElement
                )
            );
        end
    );
    return (
        CreateCapCategoryMorphismWithAttributes(
            cat_1,
            deduped_9_1,
            deduped_10_1,
            MorphismMatrix,
            List(
                [ 1 .. Length(
                        ObjectList(
                            deduped_9_1
                        )
                    ) ],
                function ( i_2 )
                  local hoisted_1_2, hoisted_2_2;
                    hoisted_2_2 := hoisted_7_1[i_2];
                    hoisted_1_2 := hoisted_6_1[i_2];
                    return (
                        List(
                            hoisted_8_1,
                            function ( j_3 )
                                return (
                                    CreateCapCategoryMorphismWithAttributes(
                                        deduped_14_1,
                                        deduped_4_1,
                                        deduped_4_1,
                                        UnderlyingRingElement,
                                        hoisted_1_2[j_3] + hoisted_2_2[j_3]
                                    )
                                );
                            end
                        )
                    );
                end
            )
        )
    );
end;

# benchmark
m := 1; # 1, 125, 250, 500, 1000, 2000

obj := ObjectConstructor( add, ListWithIdenticalEntries( m, unique_object ) );
mor := IdentityMorphism( obj );

Display( "start" );

CollectGarbage( true );
StartTimer( "benchmark" );
compiled_func_without_canceling_boxing( add, mor, mor, mor ); # compiled_func_without_canceling_boxing or compiled_func
DisplayTimer( "benchmark" );
