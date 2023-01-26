#! @Chapter Examples and tests

#! @Section Tests

#! @Example

## As an example for the usage of the attribute category,
## we install the category of pairs ( A, alpha: A -> A )
## consisting of an object equipped with an endomorphism.

LoadPackage( "AttributeCategoryForCAP", false );
#! true
LoadPackage( "LinearAlgebraForCAP", false );
#! true

#################################

## Note: This filter implies IsCategoryWithAttributesObject
DeclareCategory( "IsObjectWithEndomorphism",
                 IsCategoryWithAttributesObject );;

DeclareRepresentation( "IsObjectWithEndomorphismRep",
                       IsObjectWithEndomorphism and IsAttributeStoringRep,
                       [ ] );;

BindGlobal( "TheFamilyOfObjectsWithEndomorphism",
        NewFamily( "TheFamilyOfObjectsWithEndomorphism" ) );;

BindGlobal( "TheTypeOfObjectsWithEndomorphism",
        NewType( TheFamilyOfObjectsWithEndomorphism,
                IsObjectWithEndomorphismRep ) );;

## Note: This filter implies IsCategoryWithAttributesMorphism
DeclareCategory( "IsMorphismOfObjectsWithEndomorphism",
                 IsCategoryWithAttributesMorphism );;

DeclareRepresentation( "IsMorphismOfObjectsWithEndomorphismRep",
                       IsMorphismOfObjectsWithEndomorphism and IsAttributeStoringRep,
                       [ ] );;

BindGlobal( "TheFamilyOfMorphismsOfObjectsWithEndomorphism",
        NewFamily( "TheFamilyOfMorphismsOfObjectsWithEndomorphism" ) );;

BindGlobal( "TheTypeOfMorphismsOfObjectsWithEndomorphism",
        NewType( TheFamilyOfMorphismsOfObjectsWithEndomorphism,
                IsMorphismOfObjectsWithEndomorphismRep ) );;

#################################

Q := HomalgFieldOfRationals();;

underlying_category := MatrixCategory( Q );;

## We create a "void" CapCategory here and set its properties (abelian, monoidal) in the beginning
category_of_objects_with_endomorphism := CreateCapCategory( "Category of objects with endomorphisms" );;

category_of_objects_with_endomorphism!.category_as_first_argument := false;;

SetIsAbelianCategory( category_of_objects_with_endomorphism, true );;

SetIsRigidSymmetricClosedMonoidalCategory( category_of_objects_with_endomorphism, true );;

SetIsStrictMonoidalCategory( category_of_objects_with_endomorphism, true );;

## This record will be the input of the function that enhances underlying_category with attributes
structure_record := rec(
      underlying_category := underlying_category,
      category_with_attributes := category_of_objects_with_endomorphism
    );;

## We can give the types of objects and morphisms to the structure_record.
## In this case, object and morphism constructors will automatically be generated.
## Alternatively, you can provide your own constructors via
## structure_record.ObjectConstructor and structure_record.MorphismConstructor.
## Note: If you provide your own object constructor,
## you have to set the attributes UnderlyingCell, ObjectAttributesAsList, and UnderlyingCategory.
## If you write your own morphism constructor,
## you have to set the attributes UnderlyingCell, and UnderlyingCategory
structure_record.object_type := TheTypeOfObjectsWithEndomorphism;;

structure_record.morphism_type := TheTypeOfMorphismsOfObjectsWithEndomorphism;;

## This is the mathematical core: provide the functions that enhance objects with attributes
structure_record.ZeroObject :=
  function( underlying_zero_object )
      
      return [ ZeroMorphism( underlying_zero_object, underlying_zero_object ) ]; end;;

structure_record.DirectSum :=
  function( obj_list, underlying_direct_sum )
      
      return [ DirectSumFunctorial( List( obj_list, obj -> ObjectAttributesAsList( obj )[1] ) ) ]; end;;

structure_record.Lift :=
  function( mono, range )
      
      return [ LiftAlongMonomorphism( mono, PreCompose( mono, ObjectAttributesAsList( range )[1] ) ) ]; end;;

structure_record.Colift :=
  function( epi, source )
      
      return [ ColiftAlongEpimorphism( epi, PreCompose( ObjectAttributesAsList( source )[1], epi ) ) ]; end;;

structure_record.TensorUnit :=
  function( underlying_tensor_unit )
      
      return [ IdentityMorphism( underlying_tensor_unit ) ]; end;;

structure_record.TensorProductOnObjects :=
  function( object1, object2, underlying_tensor_product )
      
      return [ TensorProductOnMorphisms( ObjectAttributesAsList( object1 )[1], ObjectAttributesAsList( object2 )[1] ) ]; end;;

structure_record.DualOnObjects :=
  function( object, dual_object )
      
      return [ DualOnMorphisms( ObjectAttributesAsList( object )[1] ) ]; end;;

## In this particular example, this function would be not necessary since it can be 
## derived from the rigidity of the category
structure_record.InternalHomOnObjects :=
  function( object1, object2, underlying_internal_hom )
      
      return [ TensorProductOnMorphisms( DualOnMorphisms( ObjectAttributesAsList( object1 )[1] ), 
               ObjectAttributesAsList( object2 )[1] ) ]; end;;

structure_record.NoInstallList := [ "Lift", "Colift" ];;

structure_record.InstallList := [ "LiftAlongMonomorphism", "ColiftAlongEpimorphism" ];;

## This function installs all the primitive functions for the category_of_objects_with_endomorphism.
triple := EnhancementWithAttributes( structure_record );;

## EnhancementWithAttributes alters category_of_objects_with_endomorphism as a side effect:
IsIdenticalObj( category_of_objects_with_endomorphism, triple[1] );
#! true

object_constructor := triple[2];;

morphism_constructor := triple[3];;

## Install equality/ congruence functions manually since they cannot be deduced automatically
AddIsEqualForObjects( category_of_objects_with_endomorphism,
  function( object1, object2 )
    
    return IsEqualForObjects( UnderlyingCell( object1 ), UnderlyingCell( object2 ) )
           and IsCongruentForMorphisms( ObjectAttributesAsList( object1 )[1], ObjectAttributesAsList( object2 )[1] ); end );;

AddIsEqualForMorphisms( category_of_objects_with_endomorphism,
  function( morphism1, morphism2 )
    
    return IsCongruentForMorphisms( UnderlyingCell( morphism1 ), UnderlyingCell( morphism2 ) ); end );;

## Finalize the category
Finalize( category_of_objects_with_endomorphism );;

##############################

## Example computations

V := VectorSpaceObject( 2, Q );
#! <A vector space object over Q of dimension 2>

endo := VectorSpaceMorphism( V, HomalgMatrix( [ [ 0, 1 ], [ 1, 0 ] ], 2, 2, Q ), V );
#! <A morphism in Category of matrices over Q>

Vendo := object_constructor( V, [ endo ] );
#! <An object in Category of objects with endomorphisms>

IsCongruentForMorphisms( endo, ObjectAttributesAsList( Vendo )[1] );
#! true

beta := Braiding( Vendo, Vendo );
#! <A morphism in Category of objects with endomorphisms>

Fendo := FiberProduct( [ beta, IdentityMorphism( TensorProductOnObjects( Vendo, Vendo ) ) ] );
#! <An object in Category of objects with endomorphisms>

#! @EndExample
