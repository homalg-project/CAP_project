#! @Chapter Examples and tests

#! @Section Tests

#! @Example

LoadPackage( "ActionsForCAP", false );
#! true
LoadPackage( "LinearAlgebraForCAP", false );
#! true

## Category and Type of Objects
##
DeclareCategory( "IsObjectWithEndo",
                 IsCategoryWithAttributesObject );;

DeclareRepresentation( "IsObjectWithEndoRep",
                       IsObjectWithEndo and IsAttributeStoringRep,
                       [ ] );;

BindGlobal( "TheFamilyOfObjectsWithEndo",
            NewFamily( "TheFamilyOfObjectsWithEndo" ) );;

BindGlobal( "TheTypeOfObjectsWithEndo",
            NewType( TheFamilyOfObjectsWithEndo,
                     IsObjectWithEndoRep ) );;

## Category and Type of Morphisms
##
DeclareCategory( "IsMorphismWithEndo",
                 IsCategoryWithAttributesMorphism );;

DeclareRepresentation( "IsMorphismWithEndoRep",
                       IsMorphismWithEndo and IsAttributeStoringRep,
                       [ ] );;

BindGlobal( "TheFamilyOfMorphismsWithEndo",
            NewFamily( "TheFamilyOfMorphismsWithEndo" ) );;

BindGlobal( "TheTypeOfMorphismsWithEndo",
            NewType( TheFamilyOfMorphismsWithEndo,
                     IsMorphismWithEndoRep ) );;


##
Q := HomalgFieldOfRationals();;
vec := MatrixCategory( Q );;

category_with_endo_record := rec( );;

category_with_endo_record.underlying_category := vec;;
category_with_endo_record.object_type := TheTypeOfObjectsWithEndo;;
category_with_endo_record.morphism_type := TheTypeOfMorphismsWithEndo;;

category_with_endo_record.ZeroObject :=
    function( zero_object )
      
      return [ IdentityMorphism( zero_object ) ]; end;;

category_with_endo_record.DirectSum :=
    function( obj_list, underlying_direct_sum )
      
      return [ DirectSumFunctorial( List( obj_list, obj -> ObjectAttributesAsList( obj )[1] ) ) ]; end;;

category_with_endo_record.Lift :=
    function( mono, range )
      
      return [ LiftAlongMonomorphism( mono,  PreCompose( mono, ObjectAttributesAsList( range )[1] ) ) ]; end;;

category_with_endo_record.Colift :=
    function( epi, source )
      
      return [ ColiftAlongEpimorphism( epi, PreCompose( ObjectAttributesAsList( source )[1], epi ) ) ]; end;;

category_with_endo_record.TensorProductOnObjects :=
    function( obj1, obj2, underlying_tensor_product )
      
      return [ TensorProductOnMorphisms( ObjectAttributesAsList( obj1 )[1], ObjectAttributesAsList( obj2 )[1] ) ]; end;;

category_with_endo_record.TensorUnit :=
    function( unit )
      
      return [ IdentityMorphism( unit ) ]; end;;

triple := EnhancementWithAttributes( category_with_endo_record );;
endo_cat := triple[1];
#! Category with attributes of Category of matrices over Q
## not finalized yet
ObjConstr := triple[2];
#! function( object, attributes ) ... end

V := VectorSpaceObject( 3, Q );
#! <A vector space object over Q of dimension 3>
endV := IdentityMorphism( V );
#! <An identity morphism in Category of matrices over Q>
VwithEndo := ObjConstr( V, [ endV ] );
#! <An object in Category with attributes of Category of matrices over Q>

MorConstr := triple[3];
#! function( source, morphism, range ) ... end

alpha := MorConstr( VwithEndo, VectorSpaceMorphism( V, HomalgMatrix( [ [ 1, -1, 1 ], [ 1, 1, 1 ], [ 0, 0 , 0 ] ], 3, 3, Q ), V ), VwithEndo );
#! <A morphism in Category with attributes of Category of matrices over Q>

#! @EndExample
