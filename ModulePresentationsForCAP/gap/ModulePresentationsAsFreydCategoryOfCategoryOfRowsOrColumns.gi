# SPDX-License-Identifier: GPL-2.0-or-later
# ModulePresentationsForCAP: Category R-pres for CAP
#
# Implementations
#

####################################
##
## Constructors
##
####################################

##
InstallMethod( LeftPresentationsAsFreydCategoryOfCategoryOfRows,
               [ IsHomalgRing ],
               
  function( ring )
    local object_constructor, object_datum, morphism_constructor, morphism_datum,
          rows, freyd,
          modeling_tower_object_constructor, modeling_tower_object_datum, modeling_tower_morphism_datum, modeling_tower_morphism_constructor,
          left_presentations;
    
    ##
    object_constructor := function( cat, matrix )
        
        return CreateCapCategoryObjectWithAttributes( cat,
                       UnderlyingMatrix, matrix );
    
    end;
    
    ##
    object_datum := function( cat, obj )
        
        return UnderlyingMatrix( obj );
        
    end;
    
    ##
    morphism_constructor := function( cat, source, matrix, range )
        
        return CreateCapCategoryMorphismWithAttributes( cat,
                       source,
                       range,
                       UnderlyingMatrix, matrix );
        
    end;
    
    ##
    morphism_datum := function( cat, mor )
        
        return UnderlyingMatrix( mor );
        
    end;

    ## building the categorical tower:
    rows := CategoryOfRows( ring : FinalizeCategory := true );
    
    freyd := FREYD_CATEGORY( rows : FinalizeCategory := true );
    
    ## from the raw object data to the object in the modeling category
    modeling_tower_object_constructor := function( cat, matrix )
        local freyd, rows;
        
        freyd := ModelingCategory( cat );
        
        rows := UnderlyingCategory( freyd );
        
        return FreydCategoryObject( freyd,
                                    AsCategoryOfRowsMorphism( rows, matrix ) );
        
    end;
    
    ## from the object in the modeling category to the raw object data
    modeling_tower_object_datum := function( cat, obj )
      
      return UnderlyingMatrix( RelationMorphism( obj ) );
        
    end;
    
    ## from the raw morphism data to the morphism in the modeling category
    modeling_tower_morphism_constructor := function( cat, source, matrix, range )
        local freyd, rows, source_rows, range_rows, rows_morphism;
        
        freyd := ModelingCategory( cat );
        
        rows := UnderlyingCategory( freyd );
        
        source_rows := Range( RelationMorphism( source ) );
        
        range_rows := Range( RelationMorphism( range ) );
        
        rows_morphism := CategoryOfRowsMorphism( rows, source_rows, matrix, range_rows );
        
        return FreydCategoryMorphism( freyd, source, rows_morphism, range );
        
    end;
    
    ## from the morphism in the modeling category to the raw morphism data
    modeling_tower_morphism_datum := function( cat, mor )
        
        return UnderlyingMatrix( UnderlyingMorphism( mor ) );
        
    end;
    
    left_presentations := ReinterpretationOfCategory( freyd, rec(
        name := Concatenation( "Category of left presentations of ", RingName( ring ) ),
        category_filter := IsCategoryOfLeftPresentations,
        category_object_filter := IsLeftPresentation,
        category_morphism_filter := IsLeftPresentationMorphism and HasUnderlyingMatrix,
        object_constructor := object_constructor,
        object_datum := object_datum,
        morphism_constructor := morphism_constructor,
        morphism_datum := morphism_datum,
        modeling_tower_object_constructor := modeling_tower_object_constructor,
        modeling_tower_object_datum := modeling_tower_object_datum,
        modeling_tower_morphism_constructor := modeling_tower_morphism_constructor,
        modeling_tower_morphism_datum := modeling_tower_morphism_datum,
        only_primitive_operations := true,
    ) : FinalizeCategory := false );
    
    left_presentations!.compiler_hints.category_attribute_names := [
        "UnderlyingRing",
    ];
    
    SetUnderlyingRing( left_presentations, ring );
    
    left_presentations!.ring_for_representation_category := ring;
    
    AddCategoryToFamily( left_presentations, "ModuleCategory" );
    
    ## TODO: avoid code duplication (see RightPresentations)
    AddTheoremFileToCategory( left_presentations,
      Filename(
        DirectoriesPackageLibrary( "ModulePresentationsForCAP", "LogicForModulePresentations" ),
        "PropositionsForGeneralModuleCategories.tex" )
    );
    
    AddPredicateImplicationFileToCategory( left_presentations,
      Filename(
        DirectoriesPackageLibrary( "ModulePresentationsForCAP", "LogicForModulePresentations" ),
        "PredicateImplicationsForGeneralModuleCategories.tex" )
     );
    
    AddEvalRuleFileToCategory( left_presentations,
      Filename(
        DirectoriesPackageLibrary( "ModulePresentationsForCAP", "LogicForModulePresentations" ),
        "RelationsForGeneralModuleCategories.tex" )
    );
    
    Finalize( left_presentations );
    
    return left_presentations;
    
end );

##
InstallMethod( RightPresentationsAsFreydCategoryOfCategoryOfColumns,
               [ IsHomalgRing ],
               
  function( ring )
    local object_constructor, object_datum, morphism_constructor, morphism_datum,
          cols, freyd,
          modeling_tower_object_constructor, modeling_tower_object_datum, modeling_tower_morphism_datum, modeling_tower_morphism_constructor,
          right_presentations;
    
    ##
    object_constructor := function( cat, matrix)
        
        return CreateCapCategoryObjectWithAttributes( cat,
                       UnderlyingMatrix, matrix );
    
    end;
    
    ##
    object_datum := function( cat, obj )
        
        return UnderlyingMatrix( obj );
        
    end;
    
    ##
    morphism_constructor := function( cat, source, matrix, range )
        
        return CreateCapCategoryMorphismWithAttributes( cat,
                       source,
                       range,
                       UnderlyingMatrix, matrix );
        
    end;
    
    ##
    morphism_datum := function( cat, mor )
        
        return UnderlyingMatrix( mor );
        
    end;
    
    ## building the categorical tower:
    cols := CategoryOfColumns( ring : FinalizeCategory := true );
    
    freyd := FREYD_CATEGORY( cols : FinalizeCategory := true );
    
    ## from the raw object data to the object in the modeling category
    modeling_tower_object_constructor := function( cat, matrix )
        local freyd, cols;
        
        freyd := ModelingCategory( cat );
        
        cols := UnderlyingCategory( freyd );
        
        return FreydCategoryObject( freyd,
                                    AsCategoryOfColumnsMorphism( cols, matrix ) );
        
    end;
    
    ## from the object in the modeling category to the raw object data
    modeling_tower_object_datum := function( cat, obj )
      
      return UnderlyingMatrix( RelationMorphism( obj ) );
        
    end;
    
    ## from the raw morphism data to the morphism in the modeling category
    modeling_tower_morphism_constructor := function( cat, source, matrix, range )
        local freyd, cols, source_cols, range_cols, cols_morphism;
        
        freyd := ModelingCategory( cat );
        
        cols := UnderlyingCategory( freyd );
        
        source_cols := Range( RelationMorphism( source ) );
        
        range_cols := Range( RelationMorphism( range ) );
        
        cols_morphism := CategoryOfColumnsMorphism( cols, source_cols, matrix, range_cols );
        
        return FreydCategoryMorphism( freyd, source, cols_morphism, range );
        
    end;
    
    ## from the morphism in the modeling category to the raw morphism data
    modeling_tower_morphism_datum := function( cat, mor )
        
        return UnderlyingMatrix( UnderlyingMorphism( mor ) );
        
    end;
    
    right_presentations := ReinterpretationOfCategory( freyd, rec(
        name := Concatenation( "Category of right presentations of ", RingName( ring ) ),
        category_filter := IsCategoryOfRightPresentations,
        category_object_filter := IsRightPresentation,
        category_morphism_filter := IsRightPresentationMorphism and HasUnderlyingMatrix,
        object_constructor := object_constructor,
        object_datum := object_datum,
        morphism_constructor := morphism_constructor,
        morphism_datum := morphism_datum,
        modeling_tower_object_constructor := modeling_tower_object_constructor,
        modeling_tower_object_datum := modeling_tower_object_datum,
        modeling_tower_morphism_constructor := modeling_tower_morphism_constructor,
        modeling_tower_morphism_datum := modeling_tower_morphism_datum,
        only_primitive_operations := true,
    ) : FinalizeCategory := false );
    
    right_presentations!.compiler_hints.category_attribute_names := [
        "UnderlyingRing",
    ];
    
    SetUnderlyingRing( right_presentations, ring );
    
    right_presentations!.ring_for_representation_category := ring;
    
    AddCategoryToFamily( right_presentations, "ModuleCategory" );
    
    ## TODO: avoid code duplication (see LeftPresentations)
    AddTheoremFileToCategory( right_presentations,
      Filename(
        DirectoriesPackageLibrary( "ModulePresentationsForCAP", "LogicForModulePresentations" ),
        "PropositionsForGeneralModuleCategories.tex" )
    );
    
    AddPredicateImplicationFileToCategory( right_presentations,
      Filename(
        DirectoriesPackageLibrary( "ModulePresentationsForCAP", "LogicForModulePresentations" ),
        "PredicateImplicationsForGeneralModuleCategories.tex" )
     );
    
    AddEvalRuleFileToCategory( right_presentations,
      Filename(
        DirectoriesPackageLibrary( "ModulePresentationsForCAP", "LogicForModulePresentations" ),
        "RelationsForGeneralModuleCategories.tex" )
    );
    
    Finalize( right_presentations );
    
    return right_presentations;
    
end );
