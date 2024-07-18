gap> START_TEST( "CapJitTypedExpression" );

#
gap> LoadPackage( "CompilerForCAP", false );
true

# CapJitTypedExpression with data_type_getter with a single argument
gap> func := { cat } -> CapJitTypedExpression( [ ], cat -> CapJitDataTypeOfListOf( IsInt ) );;
gap> ENHANCED_SYNTAX_TREE( func : given_arguments := [ CreateCapCategory( ) ] ).bindings.BINDING_RETURN_VALUE.data_type;
rec( element_type := rec( filter := <Category "IsInt"> ), 
  filter := <Category "IsList"> )

# CapJitTypedExpression with data_type_getter without arguments
gap> func := { } -> CapJitTypedExpression( [ ], { } -> CapJitDataTypeOfListOf( IsInt ) );;
gap> ENHANCED_SYNTAX_TREE( func ).bindings.BINDING_RETURN_VALUE.data_type;
rec( element_type := rec( filter := <Category "IsInt"> ), 
  filter := <Category "IsList"> )

# CapJitTypedExpression with data_type_getter returning a filter
gap> func := x -> CapJitTypedExpression( x, { } -> IsInt );;
gap> ENHANCED_SYNTAX_TREE( func ).bindings.BINDING_RETURN_VALUE.data_type;
rec( filter := <Category "IsInt"> )

# CapJitTypedExpression with data_type_getter being a global variable
gap> data_type_getter := cat -> CapJitDataTypeOfListOf( IsInt );;
gap> func := { cat } -> CapJitTypedExpression( [ ], data_type_getter );;
gap> ENHANCED_SYNTAX_TREE( func : given_arguments := [ CreateCapCategory( ) ] ).bindings.BINDING_RETURN_VALUE.data_type;
rec( element_type := rec( filter := <Category "IsInt"> ), 
  filter := <Category "IsList"> )

# ensure that empty lists of different types are not deduplicated
gap> func := { } -> Pair( CapJitTypedExpression( [ ], { } -> CapJitDataTypeOfListOf( IsInt ) ), CapJitTypedExpression( [ ], { } -> CapJitDataTypeOfListOf( IsFloat ) ) );;
gap> Display( CapJitCompiledFunction( func, [ [ ], fail ] ) );
function (  )
    return NTuple( 2, CapJitTypedExpression( [  ], function (  )
              return rec(
                  filter := IsList,
                  element_type := rec(
                      filter := IsInt ) );
          end ), CapJitTypedExpression( [  ], function (  )
              return rec(
                  filter := IsList,
                  element_type := rec(
                      filter := IsFloat ) );
          end ) );
end
gap> func := { } -> Pair( CapJitTypedExpression( [ ], { } -> CapJitDataTypeOfListOf( IsInt ) ), CapJitTypedExpression( [ ], { } -> CapJitDataTypeOfListOf( IsInt ) ) );;
gap> Display( CapJitCompiledFunction( func, [ [ ], fail ] ) );
function (  )
    local deduped_1_1;
    deduped_1_1 := CapJitTypedExpression( [  ], function (  )
            return rec(
                filter := IsList,
                element_type := rec(
                    filter := IsInt ) );
        end );
    return NTuple( 2, deduped_1_1, deduped_1_1 );
end

# re-encode the type
gap> func := { } -> CapJitTypedExpression( [ ], { } -> CapJitDataTypeOfListOf( CapJitDataTypeOfNTupleOf( 2, IsInt, IsInt ) ) );;
gap> tree := ENHANCED_SYNTAX_TREE( func );;
gap> func2 := ENHANCED_SYNTAX_TREE_CODE( tree );;
gap> Display( func2 );
function (  )
    return CapJitTypedExpression( [  ], function (  )
            return rec(
                filter := IsList,
                element_type := rec(
                    filter := IsNTuple,
                    element_types := [ rec(
                            filter := IsInt ), rec(
                            filter := IsInt ) ] ) );
        end );
end
gap> CapJitIsEqualForEnhancedSyntaxTrees( tree, ENHANCED_SYNTAX_TREE( func2 ) );
true

#
gap> STOP_TEST( "CapJitTypedExpression" );
