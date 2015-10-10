LoadPackage( "ActionsForCAP" );
LoadPackage( "LinearAlgebraForCAP" );

## Category and Type of Objects
##
DeclareCategory( "IsObjectWithEndo",
                 IsCategoryWithAttributesObject );

DeclareRepresentation( "IsObjectWithEndoRep",
                       IsObjectWithEndo and IsAttributeStoringRep,
                       [ ] );

BindGlobal( "TheFamilyOfObjectsWithEndo",
            NewFamily( "TheFamilyOfObjectsWithEndo" ) );

BindGlobal( "TheTypeOfObjectsWithEndo",
            NewType( TheFamilyOfObjectsWithEndo,
                     IsObjectWithEndoRep ) );

## Category and Type of Morphisms
##
DeclareCategory( "IsMorphismWithEndo",
                 IsCategoryWithAttributesMorphism );

DeclareRepresentation( "IsMorphismWithEndoRep",
                       IsMorphismWithEndo and IsAttributeStoringRep,
                       [ ] );

BindGlobal( "TheFamilyOfMorphismsWithEndo",
            NewFamily( "TheFamilyOfMorphismsWithEndo" ) );

BindGlobal( "TheTypeOfMorphismsWithEndo",
            NewType( TheFamilyOfMorphismsWithEndo,
                     IsMorphismWithEndoRep ) );

##
##
Q := HomalgFieldOfRationals();
vec := MatrixCategory( Q );

category_with_endo_record := rec(
  underlying_category := vec,
  object_type := TheTypeOfObjectsWithEndo,
  morphism_type := TheTypeOfMorphismsWithEndo,
  direct_sum_attributes_function :=
    function( obj_list, direct_sum_obj )
      local attr_list;
      
      attr_list := List( obj_list, obj -> ObjectAttributesAsList( obj )[1] );
      
      return [ DirectSumFunctorial( attr_list ) ];
  end
);

endo_cat := CreateCategoryWithAttributes( category_with_endo_record );

ObjConstr := category_with_endo_record.object_constructor;

V := VectorSpaceObject( 3, Q );
endV := IdentityMorphism( V );
VwithEndo := ObjConstr( V, [ endV ] );
