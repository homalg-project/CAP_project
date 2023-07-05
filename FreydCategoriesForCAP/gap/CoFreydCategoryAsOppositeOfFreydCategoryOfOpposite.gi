# SPDX-License-Identifier: GPL-2.0-or-later
# FreydCategoriesForCAP: Freyd categories - Formal (co)kernels for additive categories
#
# Implementations
#

####################################
##
## Constructors
##
####################################

##
InstallMethod( CoFreydCategoryAsOppositeOfFreydCategoryOfOpposite,
               [ IsCapCategory ],
               
  function ( underlying_category )
    local op1, freyd, op2, object_constructor, modeling_tower_object_constructor, object_datum, modeling_tower_object_datum, morphism_constructor, modeling_tower_morphism_constructor, morphism_datum, modeling_tower_morphism_datum, wrapper;
    
    op1 := Opposite( underlying_category : only_primitive_operations := true, FinalizeCategory := true );
    
    freyd := FreydCategory( op1 : FinalizeCategory := true );
    
    op2 := Opposite( freyd : only_primitive_operations := true, FinalizeCategory := true );
    
    ##
    object_constructor := function ( cat, co_relation_morphism )
      local underlying_cat;
        
        underlying_cat := UnderlyingCategory( cat );
        
        #% CAP_JIT_DROP_NEXT_STATEMENT
        CAP_INTERNAL_ASSERT_IS_MORPHISM_OF_CATEGORY( co_relation_morphism, underlying_cat, [ "the object datum given to the object constructor of <cat>" ] );
        
        return CreateCapCategoryObjectWithAttributes( cat,
                                                      CoRelationMorphism, co_relation_morphism );
        
    end;
    
    modeling_tower_object_constructor := function ( cat, co_relation_morphism )
      local op2, freyd, op1, underlying_cat, op1_morphism, freyd_object;
        
        op2 := ModelingCategory( cat );
        
        freyd := Opposite( op2 );
        
        op1 := UnderlyingCategory( freyd );
        
        underlying_cat := OppositeCategory( op1 );
        
        #% CAP_JIT_DROP_NEXT_STATEMENT
        CAP_INTERNAL_ASSERT_IS_MORPHISM_OF_CATEGORY( co_relation_morphism, underlying_cat, [ "the object datum given to the modeling tower object constructor of <cat>" ] );
        
        op1_morphism := MorphismConstructor( op1,
            ObjectConstructor( op1,
                Range( co_relation_morphism )
            ),
            co_relation_morphism,
            ObjectConstructor( op1,
                Source( co_relation_morphism )
            )
        );
        
        freyd_object := ObjectConstructor( freyd,
            op1_morphism
        );
        
        return ObjectConstructor( op2,
            freyd_object
        );
        
    end;
    
    ##
    object_datum := function ( cat, obj )
        
        return CoRelationMorphism( obj );
        
    end;
    
    modeling_tower_object_datum := function ( cat, obj )
        
        return Opposite( RelationMorphism( Opposite( obj ) ) );
        
    end;
    
    ##
    morphism_constructor := function ( cat, source, underlying_morphism, range )
      local underlying_cat;
        
        underlying_cat := UnderlyingCategory( cat );
        
        #% CAP_JIT_DROP_NEXT_STATEMENT
        CAP_INTERNAL_ASSERT_IS_MORPHISM_OF_CATEGORY( underlying_morphism, underlying_cat, [ "the morphism datum given to the morphism constructor of <cat>" ] );
        
        if IsEqualForObjects( underlying_cat, Source( underlying_morphism ), Source( CoRelationMorphism( source ) ) ) = false then
            
            Error( "the source of the morphism datum must be equal to the source of the co-relation morphism of the given source object" );
            
        fi;
        
        if IsEqualForObjects( underlying_cat, Range( underlying_morphism ), Source( CoRelationMorphism( range ) ) ) = false then
            
            Error( "the range of the morphism datum must be equal to the source of the co-relation morphism of the given range object" );
            
        fi;
        
        return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec( ), cat,
                source,
                range,
                UnderlyingMorphism, underlying_morphism );
        
    end;
    
    modeling_tower_morphism_constructor := function ( cat, source, underlying_morphism, range )
      local op2, freyd, op1, underlying_cat, op1_morphism, freyd_morphism;
        
        op2 := ModelingCategory( cat );
        
        freyd := Opposite( op2 );
        
        op1 := UnderlyingCategory( freyd );
        
        underlying_cat := OppositeCategory( op1 );
        
        #% CAP_JIT_DROP_NEXT_STATEMENT
        CAP_INTERNAL_ASSERT_IS_MORPHISM_OF_CATEGORY( underlying_morphism, underlying_cat, [ "the morphism datum given to the modeling tower morphism constructor of <cat>" ] );
        
        if IsEqualForObjects( underlying_cat, Source( underlying_morphism ), Source( Opposite( RelationMorphism( Opposite( source ) ) ) ) ) = false then
            
            Error( "the source of the morphism datum must be equal to the source of the co-relation morphism of the given source object" );
            
        fi;
        
        if IsEqualForObjects( underlying_cat, Range( underlying_morphism ), Source( Opposite( RelationMorphism( Opposite( range ) ) ) ) ) = false then
            
            Error( "the range of the morphism datum must be equal to the source of the co-relation morphism of the given range object" );
            
        fi;
        
        op1_morphism := MorphismConstructor( op1,
            Range( RelationMorphism( Opposite( range ) ) ),
            underlying_morphism,
            Range( RelationMorphism( Opposite( source ) ) )
        );
        
        freyd_morphism := MorphismConstructor( freyd,
            Opposite( range ),
            op1_morphism,
            Opposite( source )
        );
        
        return MorphismConstructor( op2,
            source,
            freyd_morphism,
            range
        );
        
    end;
    
    ##
    morphism_datum := function ( op2, mor )
        
        return UnderlyingMorphism( mor );
        
    end;
    
    modeling_tower_morphism_datum := function ( cat, mor )
        
        return Opposite( UnderlyingMorphism( Opposite( mor ) ) );
        
    end;
    
    wrapper := ReinterpretationOfCategory( op2, rec(
        name := Concatenation( "CoFreyd( ", Name( underlying_category )," )" ),
        category_filter := IsCoFreydCategory,
        category_object_filter := IsCoFreydCategoryObject,
        category_morphism_filter := IsCoFreydCategoryMorphism,
        object_constructor := object_constructor,
        object_datum := object_datum,
        morphism_constructor := morphism_constructor,
        morphism_datum := morphism_datum,
        modeling_tower_morphism_constructor := modeling_tower_morphism_constructor,
        modeling_tower_morphism_datum := modeling_tower_morphism_datum,
        modeling_tower_object_constructor := modeling_tower_object_constructor,
        modeling_tower_object_datum := modeling_tower_object_datum,
        only_primitive_operations := true,
    ) );
    
    SetUnderlyingCategory( wrapper, underlying_category );
    
    wrapper!.compiler_hints.category_attribute_names := [
        "UnderlyingCategory",
    ];
    
    return wrapper;
    
end );
