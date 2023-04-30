##############################################################################################
##
## GradedModulePresentationsbyFreyd
##
## Copyright 2019,  Martin Bies,       ULB Brussels
##
## The CAP category of graded module presentations for CAP by use of Freyd categories
##
##############################################################################################


######################################
##
## Section CAP categories
##
######################################

# compute the category S-fpgrmod for a toric variety
InstallMethod( FpGradedLeftModules,
                " for graded rings ",
                [ IsHomalgGradedRing ],
  function( graded_ring )
    
    return FreydCategory( CategoryOfGradedRows( graded_ring ) );
    
end );

##
InstallMethod( FreydCategory,
               [ IsCategoryOfGradedRows ],
               
  function( underlying_category )
    local graded_ring, freyd, object_constructor, modeling_tower_object_constructor, object_datum, modeling_tower_object_datum, morphism_constructor, modeling_tower_morphism_constructor, morphism_datum, modeling_tower_morphism_datum, wrapper;
    
    graded_ring := UnderlyingGradedRing( underlying_category );
    
    freyd := FREYD_CATEGORY( underlying_category );
    
    object_constructor := function ( cat, relation_morphism )
        
        return CreateCapCategoryObjectWithAttributes( cat, RelationMorphism, relation_morphism );
        
    end;
    
    modeling_tower_object_constructor := function ( cat, relation_morphism )
        
        return CreateCapCategoryObjectWithAttributes( ModelingCategory( cat ), RelationMorphism, relation_morphism );
        
    end;
    
    object_datum := function ( cat, object )
        
        return RelationMorphism( object );
        
    end;
    
    modeling_tower_object_datum := function ( cat, object )
        
        return RelationMorphism( object );
        
    end;
    
    morphism_constructor := function ( cat, source, underlying_morphism, range )
        
        return CreateCapCategoryMorphismWithAttributes( cat, source, range, UnderlyingMorphism, underlying_morphism );
        
    end;
    
    modeling_tower_morphism_constructor := function ( cat, source, underlying_morphism, range )
        
        return CreateCapCategoryMorphismWithAttributes( ModelingCategory( cat ), source, range, UnderlyingMorphism, underlying_morphism );
        
    end;
    
    morphism_datum := function ( cat, morphism )
        
        return UnderlyingMorphism( morphism );
        
    end;
    
    modeling_tower_morphism_datum := function ( cat, morphism )
        
        return UnderlyingMorphism( morphism );
        
    end;
    
    wrapper := ReinterpretationOfCategory( freyd, rec(
        name := Concatenation( "Category of f.p. graded left modules over ", RingName( graded_ring ) ),
        category_filter := IsFreydCategory and IsFpGradedLeftModules,
        category_object_filter := IsFreydCategoryObject and HasRelationMorphism and IsFpGradedLeftModulesObject,
        category_morphism_filter := IsFreydCategoryMorphism and HasUnderlyingMorphism and IsFpGradedLeftModulesMorphism,
        object_constructor := object_constructor,
        object_datum := object_datum,
        morphism_constructor := morphism_constructor,
        morphism_datum := morphism_datum,
        modeling_tower_object_constructor := modeling_tower_object_constructor,
        modeling_tower_object_datum := modeling_tower_object_datum,
        modeling_tower_morphism_constructor := modeling_tower_morphism_constructor,
        modeling_tower_morphism_datum := modeling_tower_morphism_datum,
    ) );
    
    SetUnderlyingCategory( wrapper, underlying_category );
    
    return wrapper;
    
end );

# compute the category S-fpgrmod for a toric variety
InstallMethod( FpGradedRightModules,
                " for graded rings ",
                [ IsHomalgGradedRing ],
  function( graded_ring )
    
    return FreydCategory( CategoryOfGradedColumns( graded_ring ) );
    
end );

##
InstallMethod( FreydCategory,
               [ IsCategoryOfGradedColumns ],
               
  function( underlying_category )
    local graded_ring, freyd, object_constructor, modeling_tower_object_constructor, object_datum, modeling_tower_object_datum, morphism_constructor, modeling_tower_morphism_constructor, morphism_datum, modeling_tower_morphism_datum, wrapper;
    
    graded_ring := UnderlyingGradedRing( underlying_category );
    
    freyd := FREYD_CATEGORY( underlying_category );
    
    object_constructor := function ( cat, relation_morphism )
        
        return CreateCapCategoryObjectWithAttributes( cat, RelationMorphism, relation_morphism );
        
    end;
    
    modeling_tower_object_constructor := function ( cat, relation_morphism )
        
        return CreateCapCategoryObjectWithAttributes( ModelingCategory( cat ), RelationMorphism, relation_morphism );
        
    end;
    
    object_datum := function ( cat, object )
        
        return RelationMorphism( object );
        
    end;
    
    modeling_tower_object_datum := function ( cat, object )
        
        return RelationMorphism( object );
        
    end;
    
    morphism_constructor := function ( cat, source, underlying_morphism, range )
        
        return CreateCapCategoryMorphismWithAttributes( cat, source, range, UnderlyingMorphism, underlying_morphism );
        
    end;
    
    modeling_tower_morphism_constructor := function ( cat, source, underlying_morphism, range )
        
        return CreateCapCategoryMorphismWithAttributes( ModelingCategory( cat ), source, range, UnderlyingMorphism, underlying_morphism );
        
    end;
    
    morphism_datum := function ( cat, morphism )
        
        return UnderlyingMorphism( morphism );
        
    end;
    
    modeling_tower_morphism_datum := function ( cat, morphism )
        
        return UnderlyingMorphism( morphism );
        
    end;
    
    wrapper := ReinterpretationOfCategory( freyd, rec(
        name := Concatenation( "Category of f.p. graded right modules over ", RingName( graded_ring ) ),
        category_filter := IsFreydCategory and IsFpGradedRightModules,
        category_object_filter := IsFreydCategoryObject and HasRelationMorphism and IsFpGradedRightModulesObject,
        category_morphism_filter := IsFreydCategoryMorphism and HasUnderlyingMorphism and IsFpGradedRightModulesMorphism,
        object_constructor := object_constructor,
        object_datum := object_datum,
        morphism_constructor := morphism_constructor,
        morphism_datum := morphism_datum,
        modeling_tower_object_constructor := modeling_tower_object_constructor,
        modeling_tower_object_datum := modeling_tower_object_datum,
        modeling_tower_morphism_constructor := modeling_tower_morphism_constructor,
        modeling_tower_morphism_datum := modeling_tower_morphism_datum,
    ) );
    
    SetUnderlyingCategory( wrapper, underlying_category );
    
    return wrapper;
    
end );
