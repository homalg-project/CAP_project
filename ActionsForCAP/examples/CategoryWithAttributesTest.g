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
Q := HomalgFieldOfRationals();
vec := MatrixCategory( Q );

category_with_endo_record := rec(
  underlying_category := vec,
  object_type := TheTypeOfObjectsWithEndo,
  morphism_type := TheTypeOfMorphismsWithEndo,
  
  ZeroObject :=
    function( zero_object )
      
      return [ IdentityMorphism( zero_object ) ];
      
  end,
  
  DirectSum :=
    function( obj_list, underlying_direct_sum )
      local attr_list;
      
      attr_list := List( obj_list, obj -> ObjectAttributesAsList( obj )[1] );
      
      return [ DirectSumFunctorial( attr_list ) ];
  end,
  
  Lift :=
    function( mono, range )
      local range_endo, composition;
      
      range_endo := ObjectAttributesAsList( range )[1];
      
      composition := PreCompose( mono, range_endo );
      
      return [ LiftAlongMonomorphism( mono, composition ) ];
      
  end,
  
  Colift :=
    function( epi, source )
      local source_endo, composition;
      
      source_endo := ObjectAttributesAsList( source )[1];
      
      composition := PreCompose( source_endo, epi );
      
      return [ ColiftAlongEpimorphism( epi, composition ) ];
  end,
  
  TensorProductOnObjects :=
    function( obj1, obj2, underlying_tensor_product )
      local endo1, endo2;
      
      endo1 := ObjectAttributesAsList( obj1 )[1];
      
      endo2 := ObjectAttributesAsList( obj2 )[1];
      
      return [ TensorProductOnMorphisms( endo1, endo2 ) ];
      
  end,
  
  TensorUnit :=
    function( unit )
    
    return [ IdentityMorphism( unit ) ];
    
  end
);

triple := EnhancementWithAttributes( category_with_endo_record );
endo_cat := triple[1];
## not finalized yet
ObjConstr := triple[2];

V := VectorSpaceObject( 3, Q );
endV := IdentityMorphism( V );
VwithEndo := ObjConstr( V, [ endV ] );

MorConstr := triple[3];

alpha := MorConstr( VwithEndo, VectorSpaceMorphism( V, HomalgMatrix( [ [ 1, -1, 1 ], [ 1, 1, 1 ], [ 0, 0 , 0 ] ], 3, 3, Q ), V ), VwithEndo );
