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

# CapJitTypedExpression for groups
gap> S3 := SymmetricGroup( 3 );; StructureDescription( S3 );; S3;
S3
gap> U := Subgroup( S3, [ (1,2) ] );;
gap> type_group := CapJitDataTypeOfGroup( S3 );
rec( filter := <Filter "(IsMagmaWithInverses and IsAssociative)">, group := S3 )
gap> type_group_element := CapJitDataTypeOfElementOfGroup( S3 );
rec( filter := <Category "IsMultiplicativeElementWithInverse">, group := S3 )
gap> type_subgroup := CapJitDataTypeOfSubgroup( S3 );
rec( filter := <Filter "((IsMagmaWithInverses and IsAssociative) and HasParentAttr)">, group := S3 )
gap> CapJitCompiledFunction( g -> Inverse( g ), [ [ type_group_element ], type_group_element ] );;
gap> CapJitCompiledFunction( G -> One( G ), [ [ type_group ], type_group_element ] );;
gap> CapJitCompiledFunction( { i, g } -> i^g, [ [ rec( filter := IsInt ), rec( filter := IsPerm ) ], rec( filter := IsInt ) ] );;
gap> CapJitCompiledFunction( G -> Subgroup( G, [ One( G ) ] ), [ [ type_group ], type_subgroup ] );;
gap> CapJitCompiledFunction( G -> GeneratorsOfGroup( G ), [ [ type_group ], CapJitDataTypeOfListOf( type_group_element ) ] );;
gap> CapJitCompiledFunction( { G, U } -> Index( G, U ), [ [ type_group, type_subgroup ], rec( filter := IsInt ) ] );;
gap> CapJitCompiledFunction( { G, U } -> RightTransversal( G, U ), [ [ type_group, type_subgroup ], CapJitDataTypeOfListOf( type_group_element ) ] );;
gap> CapJitCompiledFunction( { U, g } -> ConjugateSubgroup( U, g ), [ [ type_subgroup, type_group_element ], type_subgroup ] );;
gap> CapJitCompiledFunction( { U, V } -> IsSubset( U, V ), [ [ type_subgroup, type_subgroup ], rec( filter := IsBool ) ] );;
gap> CapJitCompiledFunction( { G, U, V } -> IsConjugate( G, U, V ), [ [ type_group, type_subgroup, type_subgroup ], rec( filter := IsBool ) ] );;
gap> CapJitCompiledFunction( { G, U, V } -> RepresentativeAction( G, U, V ), [ [ type_group, type_subgroup, type_subgroup ], type_group_element ] );;
gap> CapJitCompiledFunction( { gens, list } -> OrbitsPerms( gens, list ), [ [ CapJitDataTypeOfListOf( type_group_element ), CapJitDataTypeOfListOf( IsInt ) ], CapJitDataTypeOfListOf( CapJitDataTypeOfListOf( IsInt ) ) ] );;

#
gap> STOP_TEST( "CapJitTypedExpression" );
