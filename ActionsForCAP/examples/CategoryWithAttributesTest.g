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
  
  zero_object_attributes_function :=
    function( zero_object )
      
      return [ IdentityMorphism( zero_object ) ];
      
  end,
  
  direct_sum_attributes_function :=
    function( obj_list, direct_sum_obj )
      local attr_list;
      
      attr_list := List( obj_list, obj -> ObjectAttributesAsList( obj )[1] );
      
      return [ DirectSumFunctorial( attr_list ) ];
  end,
  
  lift_attributes_function :=
    function( mono, range )
      local range_endo, composition;
      
      range_endo := ObjectAttributesAsList( range )[1];
      
      composition := PreCompose( mono, range_endo );
      
      return [ LiftAlongMonomorphism( mono, composition ) ];
      
  end,
  
  colift_attributes_function :=
    function( epi, source )
      local source_endo, composition;
      
      source_endo := ObjectAttributesAsList( source )[1];
      
      composition := PreCompose( source_endo, epi );
      
      return [ ColiftAlongEpimorphism( epi, composition ) ];
  end
);

endo_cat := CreateCategoryWithAttributes( category_with_endo_record );

ObjConstr := category_with_endo_record.object_constructor;

V := VectorSpaceObject( 3, Q );
endV := IdentityMorphism( V );
VwithEndo := ObjConstr( V, [ endV ] );

MorConstr := category_with_endo_record.morphism_constructor;

alpha := MorConstr( VwithEndo, VectorSpaceMorphism( V, HomalgMatrix( [ [ 1, -1, 1 ], [ 1, 1, 1 ], [ 0, 0 , 0 ] ], 3, 3, Q ), V ), VwithEndo );
