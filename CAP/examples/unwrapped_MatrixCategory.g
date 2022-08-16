#! @Chapter Examples and Tests

#! @Section WrapperCategory

#! A priori, CAP only supports **wrapped** categories, that is, objects and morphisms in a category cannot be represented by primitive data types (like integers) but must be attribute storing GAP objects.
#! In theory, CAP could support **bare** categories, that is, categories where objects and morphisms are represented by primitive data types. However, this would not be very convenient:
#! * Type checking would be severely limited due to missing type information. For example, one could not distinguish between objects in a category of rows and objects in a category of columns if both are represented by plain integers.
#! * In particular, one would always have to call CAP operations with the category as the first argument.
#! * Morphisms could not store their source and range, so all CAP operations would have to be extended to explicitly include source and range of the morphisms in the input in addition to the primitive morphism data.
#! * In particular, users would have to explicitly compute and take care of keeping records of the correct source and range of morphisms. In some cases this might actually lead to optimizations, but in most cases users would probably develop their own data structure for storing source and range together with the morphism datum, thus inventing the data structure we wanted to avoid in the first place.
#! Despite these impracticalities in algorithms, when thinking about mathematics we often deal with categories where the objects and morphisms are of some primitive data type and the category is clear from the context.
#! In particular, in principle, we actually have to prove that our wrapping and unwrapping in CAP defines an equivalence of categories. Often this is trivial because wrapping and unwrapping just cancels.
#! So it is interesting to see how far CAP can actually be used to model bare categories:

#! @Example

LoadPackage( "LinearAlgebraForCAP", false );
#! true
LoadPackage( "CompilerForCAP", false );
#! true

#
# We start with a typical wrapped category: The matrix category over the
# rationals `vec` has wrapped integers (attribute `Dimension`) as objects
# and wrapped homalg matrices (attribute `UnderlyingMatrix`) as morphisms.
#
QQ := HomalgFieldOfRationals( );;
vec := MatrixCategory( QQ );;

#
# We now use `WrapperCategory` to change the data structure to a bare
# version.
#
# We use the integers as our objects, so `ObjectConstructor` simply returns
# the dimension.
#
object_constructor := { cat, dimension } -> dimension;;
modeling_tower_object_constructor :=
    { cat, dimension } -> MatrixCategoryObject(
        ModelingCategory( cat ), dimension
    );;
object_datum := { cat, dimension } -> dimension;;
modeling_tower_object_datum := { cat, obj } -> Dimension( obj );;

#
# For the reasons mentioned above, we still have to store the source and
# range of morphisms. So we model morphisms as triples of an integer, a matrix
# and another integer.
#
morphism_constructor :=
    { cat, source_dimension, underlying_matrix, range_dimension } ->
        Triple( source_dimension, underlying_matrix, range_dimension );;
modeling_tower_morphism_constructor :=
    { cat, source, underlying_matrix, range } ->
        VectorSpaceMorphism( ModelingCategory( cat ),
            source,
            underlying_matrix,
            range
        );;
morphism_datum := { cat, triple } -> triple[2];;
modeling_tower_morphism_datum := { cat, mor } -> UnderlyingMatrix( mor );;

#
# We create some new filters for the category and its objects and morphisms,
# although we cannot set the object and morphism filters because the integers
# and triples cannot store this information.
#
category_filter := NewFilter( "IsUnwrappedMatrixCategory", IsCapCategory );;
category_object_filter :=
    NewFilter( "IsUnwrappedMatrixCategoryObject", IsCapCategoryObject );;
category_morphism_filter :=
    NewFilter( "IsUnwrappedMatrixCategoryMorphism", IsCapCategoryMorphism );;

#
# CAP assumes that the source and range of morphisms can be accessed via
# attributes `Source` and `Range`, so we have to install suitable versions.
#
InstallOtherMethod( Source,
    [ IsList ],
  function ( list )
    if Length( list ) = 3 then
        return list[1]; else TryNextMethod( ); fi; end );

InstallOtherMethod( Range,
    [ IsList ],
  function ( list )
    if Length( list ) = 3 then
        return list[3]; else TryNextMethod( ); fi; end );

#
# We can finally create the unwrapped category `uvec`.
# `is_bare` removes all the usual typing restrictions and checks.
#
uvec := WrapperCategory( vec, rec(
    name := Concatenation( "Unwrapped( ", Name( vec )," )" ),
    category_filter := category_filter,
    category_object_filter := category_object_filter,
    category_morphism_filter := category_morphism_filter,
    object_constructor := object_constructor,
    object_datum := object_datum,
    morphism_constructor := morphism_constructor,
    morphism_datum := morphism_datum,
    modeling_tower_object_constructor := modeling_tower_object_constructor,
    modeling_tower_object_datum := modeling_tower_object_datum,
    modeling_tower_morphism_constructor := modeling_tower_morphism_constructor,
    modeling_tower_morphism_datum := modeling_tower_morphism_datum,
    only_primitive_operations := true,
    is_bare := true,
) );
#! Unwrapped( Category of matrices over Q )

#
# As expected, we can now call the operations of `uvec` with integers as
# input.
#
DirectSum( uvec, [ 1, 2, 3 ] );
#! 6
id := IdentityMorphism( uvec, 5 );
#! [ 5, <An unevaluated 5 x 5 identity matrix over an internal ring>, 5 ]
IsZeroForMorphisms( uvec, id );
#! false
zero := ZeroMorphism( uvec, 2, 3 );
#! [ 2, <An unevaluated 2 x 3 zero matrix over an internal ring>, 3 ]
IsZeroForMorphisms( uvec, zero );
#! true
AdditionForMorphisms( uvec, id, id );
#! [ 5, <An unevaluated 5 x 5 matrix over an internal ring>, 5 ]
ProjectionInFactorOfFiberProduct( uvec, [ id, id ], 2 );
#! [ 5, <An unevaluated 5 x 5 matrix over an internal ring>, 5 ]

#
# Compiling some operations shows that for objects no wrapping and
# unwrapping remains. For morphisms, of course the triples still are some form
# of wrapping.
# Again, we have to disable data type inference because otherwise certain
# checks would fail.
#
CapJitDisableDataTypeInference( );
Display( CapJitCompiledFunction(
    Last( uvec!.added_functions.DirectSum )[1],
    uvec
) );
#! function ( cat_1, arg2_1 )
#!     return Sum( List( arg2_1, function ( logic_new_func_x_2 )
#!               return logic_new_func_x_2;
#!           end ) );
#! end
Display( CapJitCompiledFunction(
    Last( uvec!.added_functions.IsZeroForObjects )[1],
    uvec
) );
#! function ( cat_1, arg2_1 )
#!     return arg2_1 = 0;
#! end
Display( CapJitCompiledFunction(
    Last( uvec!.added_functions.AdditionForMorphisms )[1],
    uvec
) );
#! function ( cat_1, a_1, b_1 )
#!     return NTuple( 3, Source( a_1 ), a_1[2] + b_1[2], Range( a_1 ) );
#! end
CapJitEnableDataTypeInference( );

#
# We can now also re-wrap `uvec` to form `vec` again, supporting the statement
# that CAP categories are usually wrapped categories. For this, we essentially
# swap `object_constructor` and `modeling_tower_object_constructor` and so on:
#
object_constructor :=
    { cat, dimension } -> MatrixCategoryObject( cat, dimension );;
modeling_tower_object_constructor := { cat, dimension } -> dimension;;
object_datum := { cat, obj } -> Dimension( obj );;
modeling_tower_object_datum := { cat, dimension } -> dimension;;
morphism_constructor :=
    { cat, source, underlying_matrix, range } ->
        VectorSpaceMorphism( cat,
            source,
            underlying_matrix,
            range
        );;
modeling_tower_morphism_constructor :=
    { cat, source_dimension, underlying_matrix, range_dimension } ->
        Triple( source_dimension, underlying_matrix, range_dimension );;
morphism_datum := { cat, mor } -> UnderlyingMatrix( mor );;
modeling_tower_morphism_datum := { cat, triple } -> triple[2];;
vec2 := WrapperCategory( uvec, rec(
    name := Concatenation( "Wrapped( ", Name( uvec )," )" ),
    category_filter := IsMatrixCategory,
    category_object_filter := IsVectorSpaceObject,
    category_morphism_filter := IsVectorSpaceMorphism,
    object_constructor := object_constructor,
    object_datum := object_datum,
    morphism_constructor := morphism_constructor,
    morphism_datum := morphism_datum,
    modeling_tower_object_constructor := modeling_tower_object_constructor,
    modeling_tower_object_datum := modeling_tower_object_datum,
    modeling_tower_morphism_constructor := modeling_tower_morphism_constructor,
    modeling_tower_morphism_datum := modeling_tower_morphism_datum,
    only_primitive_operations := true,
) );
#! Wrapped( Unwrapped( Category of matrices over Q ) )
SetUnderlyingRing( vec2, QQ );

#
# `vec2` now behaves exactly like `vec`:
#
DirectSum( [
    MatrixCategoryObject( vec2, 1 ),
    MatrixCategoryObject( vec2, 2 ),
    MatrixCategoryObject( vec2, 3 ),
] );
#! <A vector space object over Q of dimension 6>
id := IdentityMorphism( vec2, MatrixCategoryObject( vec2, 5 ) );
#! <An identity morphism in Wrapped( Unwrapped( Category of matrices over Q ) )>
UnderlyingMatrix( id );
#! <An unevaluated 5 x 5 identity matrix over an internal ring>
IsZeroForMorphisms( vec2, id );
#! false
zero := ZeroMorphism( vec2,
    MatrixCategoryObject( vec2, 2 ),
    MatrixCategoryObject( vec2, 3 )
);
#! <A zero morphism in Wrapped( Unwrapped( Category of matrices over Q ) )>
UnderlyingMatrix( zero );
#! <An unevaluated 2 x 3 zero matrix over an internal ring>
IsZeroForMorphisms( vec2, zero );
#! true
AdditionForMorphisms( vec2, id, id );
#! <A morphism in Wrapped( Unwrapped( Category of matrices over Q ) )>
ProjectionInFactorOfFiberProduct( vec2, [ id, id ], 2 );
#! <A monomorphism in Wrapped( Unwrapped( Category of matrices over Q ) )>

CapJitDisableDataTypeInference( );
Display( CapJitCompiledFunction(
    Last( vec2!.added_functions.DirectSum )[1],
    vec2
) );
#! function ( cat_1, arg2_1 )
#!     return ObjectifyObjectForCAPWithAttributes( rec(
#!            ), cat_1, Dimension, 
#!        Sum( List( arg2_1, function ( logic_new_func_x_2 )
#!                 return Dimension( logic_new_func_x_2 );
#!             end ) ) );
#! end
Display( CapJitCompiledFunction(
    Last( vec2!.added_functions.IsZeroForObjects )[1],
    vec2
) );
#! function ( cat_1, arg2_1 )
#!     return Dimension( arg2_1 ) = 0;
#! end
Display( CapJitCompiledFunction(
    Last( vec2!.added_functions.AdditionForMorphisms )[1],
    vec2
) );
#! function ( cat_1, a_1, b_1 )
#!     return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
#!            ), cat_1, Source( a_1 ), Range( a_1 ), UnderlyingMatrix, 
#!        UnderlyingMatrix( a_1 ) + UnderlyingMatrix( b_1 ) );
#! end
CapJitEnableDataTypeInference( );

#! @EndExample
