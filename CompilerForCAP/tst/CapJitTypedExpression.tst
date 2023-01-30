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

# CapJitTypedExpression with data_type_getter returning a filer
gap> func := { } -> CapJitTypedExpression( [ ], { } -> IsInt );;
gap> ENHANCED_SYNTAX_TREE( func ).bindings.BINDING_RETURN_VALUE.data_type;
rec( filter := <Category "IsInt"> )

# CapJitTypedExpression with data_type_getter being a global variable
gap> data_type_getter := cat -> CapJitDataTypeOfListOf( IsInt );;
gap> func := { cat } -> CapJitTypedExpression( [ ], data_type_getter );;
gap> ENHANCED_SYNTAX_TREE( func : given_arguments := [ CreateCapCategory( ) ] ).bindings.BINDING_RETURN_VALUE.data_type;
rec( element_type := rec( filter := <Category "IsInt"> ), 
  filter := <Category "IsList"> )

# ensure that empty lists of different types are not deduplicated
gap> func := { } -> Pair( CapJitTypedExpression( [ ], { } -> IsInt ), CapJitTypedExpression( [ ], { } -> IsFloat ) );;
gap> Display( CapJitCompiledFunction( func, [ [ ], fail ] ) );
function (  )
    return NTuple( 2, [  ], [  ] );
end
gap> func := { } -> Pair( CapJitTypedExpression( [ ], { } -> IsInt ), CapJitTypedExpression( [ ], { } -> IsInt ) );;
gap> Display( CapJitCompiledFunction( func, [ [ ], fail ] ) );
function (  )
    local deduped_1_1;
    deduped_1_1 := [  ];
    return NTuple( 2, deduped_1_1, deduped_1_1 );
end

#
gap> STOP_TEST( "CapJitTypedExpression" );
