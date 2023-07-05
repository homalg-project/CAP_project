#! @Chapter Examples and Tests

#! @Section Opposite( CategoryOfRow ) as CategoryOfColumns

#! Assume that we have the constructors `CategoryOfRows` and `CategoryOfColumns` but no constructor `Opposite`.
#! Then we can still model `Opposite( CategoryOfRows )` as `CategoryOfColumns` using `ReinterpretationOfCategory`.
#! This can be achieved up to minor modifications by swapping `object_constructor` and `modeling_tower_object_constructor` and so on in `CategoryOfColumsAsOppositeOfCategoryOfRows`.
#! With this, objects and morphisms indeed have the attribute `Opposite` as desired.
#! Getting `ObjectDatum` and `MorphismDatum` to return this attribute would also be possible, but would require more effort than simply swapping `object_constructor` and `modeling_tower_object_constructor` and so.

#! @Example

LoadPackage( "FreydCategoriesForCAP", false );
#! true

QQ := HomalgFieldOfRationals( );;
cols := CategoryOfColumns( QQ );;
rows := CategoryOfRows( QQ );;
object_constructor :=
    { cat, rank } -> CreateCapCategoryObjectWithAttributes( cat,
                                                            Opposite, CategoryOfRowsObject( Opposite( cat ), rank )
    );;
modeling_tower_object_constructor :=
    { cat, rank } -> CreateCapCategoryObjectWithAttributes( ModelingCategory( cat ),
                                                            RankOfObject, rank
    );;
object_datum := { cat, obj } -> RankOfObject( Opposite( obj ) );;
modeling_tower_object_datum := { cat, obj } -> RankOfObject( obj );;
morphism_constructor :=
    { cat, source, underlying_matrix, range } ->
        ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes(
            rec( ), cat,
            source, range,
            Opposite, CategoryOfRowsMorphism(
                Opposite( cat ),
                Opposite( range ),
                underlying_matrix,
                Opposite( source )
            )
        );;
modeling_tower_morphism_constructor :=
    { cat, source, underlying_matrix, range } ->
        ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes(
            rec( ), ModelingCategory( cat ),
            source, range,
            UnderlyingMatrix, underlying_matrix
        );;
morphism_datum := { cat, mor } -> UnderlyingMatrix( Opposite( mor ) );;
modeling_tower_morphism_datum := { cat, mor } -> UnderlyingMatrix( mor );;
op := ReinterpretationOfCategory( cols, rec(
    name := Concatenation( "Opposite( ", Name( rows )," )" ),
    category_filter := WasCreatedAsOppositeCategory,
    category_object_filter := IsCapCategoryOppositeObject,
    category_morphism_filter := IsCapCategoryOppositeMorphism,
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
#! Opposite( Rows( Q ) )
SetOpposite( op, rows );
source := ObjectConstructor( op, 1 );
#! <An object in Opposite( Rows( Q ) )>
range := ObjectConstructor( op, 2 );
#! <An object in Opposite( Rows( Q ) )>
zero := ZeroMorphism( source, range );
#! <A zero morphism in Opposite( Rows( Q ) )>
sum := AdditionForMorphisms( zero, zero );
#! <A morphism in Opposite( Rows( Q ) )>
# notice that source and range are indeed swapped compared to the above
Display( Opposite( sum ) );
#! Source: 
#! A row module over Q of rank 2
#! 
#! Matrix: 
#! [ [  0 ],
#!   [  0 ] ]
#! 
#! Range: 
#! A row module over Q of rank 1
#! 
#! A morphism in Rows( Q )

#! @EndExample
