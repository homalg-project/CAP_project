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
    local rows, freyd, object_constructor, modeling_tower_object_constructor, object_datum, modeling_tower_object_datum, morphism_constructor, modeling_tower_morphism_datum, morphism_datum, modeling_tower_morphism_constructor, wrapper;
    
    rows := CategoryOfRows( ring : FinalizeCategory := true );
    
    freyd := FREYD_CATEGORY( rows : FinalizeCategory := true );
    
    ##
    object_constructor := function( cat, matrix)
        
        return ObjectifyObjectForCAPWithAttributes( rec(), cat,
                                                    UnderlyingMatrix, matrix );
    
    end;
    
    ##
    modeling_tower_object_constructor := function( cat, matrix )
        local freyd, rows;
        
        freyd := ModelingCategory( cat );
        
        rows := UnderlyingCategory( freyd );
        
        return FreydCategoryObject( freyd,
                                    AsCategoryOfRowsMorphism( rows, matrix ) );
        
    end;
    
    ##
    object_datum := function( cat, obj )
        
        return UnderlyingMatrix( obj );
        
    end;
    
    ##
    modeling_tower_object_datum := function( cat, obj )
      
      return UnderlyingMatrix( RelationMorphism( obj ) );
        
    end;
    
    ##
    morphism_constructor := function( cat, source, matrix, range )
        
        return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(), cat,
                                                                        source,
                                                                        range,
                                                                        UnderlyingMatrix, matrix );
        
    end;
    
    ##
    modeling_tower_morphism_constructor := function( cat, source, matrix, range )
        local freyd, rows, source_rows, range_rows, rows_morphism;
        
        freyd := ModelingCategory( cat );
        
        rows := UnderlyingCategory( freyd );
        
        source_rows := Range( RelationMorphism( source ) );
        
        range_rows := Range( RelationMorphism( range ) );
        
        rows_morphism := CategoryOfRowsMorphism( rows, source_rows, matrix, range_rows );
        
        return FreydCategoryMorphism( freyd, source, rows_morphism, range );
        
    end;
    
    ##
    morphism_datum := function( cat, mor )
        
        return UnderlyingMatrix( mor );
        
    end;
    
    ##
    modeling_tower_morphism_datum := function( cat, mor )
        
        return UnderlyingMatrix( UnderlyingMorphism( mor ) );
        
    end;
    
    wrapper := WrapperCategory( freyd, rec(
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
    
    wrapper!.compiler_hints.category_attribute_names := [
        "UnderlyingRing",
    ];
    
    SetUnderlyingRing( wrapper, ring );
    
    wrapper!.ring_for_representation_category := ring;
    
    AddCategoryToFamily( wrapper, "ModuleCategory" );
    
    ## TODO: avoid code duplication (see RightPresentations)
    AddTheoremFileToCategory( wrapper,
      Filename(
        DirectoriesPackageLibrary( "ModulePresentationsForCAP", "LogicForModulePresentations" ),
        "PropositionsForGeneralModuleCategories.tex" )
    );
    
    AddPredicateImplicationFileToCategory( wrapper,
      Filename(
        DirectoriesPackageLibrary( "ModulePresentationsForCAP", "LogicForModulePresentations" ),
        "PredicateImplicationsForGeneralModuleCategories.tex" )
     );
    
    AddEvalRuleFileToCategory( wrapper,
      Filename(
        DirectoriesPackageLibrary( "ModulePresentationsForCAP", "LogicForModulePresentations" ),
        "RelationsForGeneralModuleCategories.tex" )
    );
    
    Finalize( wrapper );
    
    return wrapper;
    
end );

##
InstallMethod( RightPresentationsAsFreydCategoryOfCategoryOfColumns,
               [ IsHomalgRing ],
               
  function( ring )
    local cols, freyd, object_constructor, modeling_tower_object_constructor, object_datum, modeling_tower_object_datum, morphism_constructor, modeling_tower_morphism_datum, morphism_datum, modeling_tower_morphism_constructor, wrapper;
    
    cols := CategoryOfColumns( ring : FinalizeCategory := true );
    
    freyd := FREYD_CATEGORY( cols : FinalizeCategory := true );
    
    ##
    object_constructor := function( cat, matrix)
        
        return ObjectifyObjectForCAPWithAttributes( rec(), cat,
                                                    UnderlyingMatrix, matrix );
    
    end;
    
    ##
    modeling_tower_object_constructor := function( cat, matrix )
        local freyd, cols;
        
        freyd := ModelingCategory( cat );
        
        cols := UnderlyingCategory( freyd );
        
        return FreydCategoryObject( freyd,
                                    AsCategoryOfColumnsMorphism( cols, matrix ) );
        
    end;
    
    ##
    object_datum := function( cat, obj )
        
        return UnderlyingMatrix( obj );
        
    end;
    
    ##
    modeling_tower_object_datum := function( cat, obj )
      
      return UnderlyingMatrix( RelationMorphism( obj ) );
        
    end;
    
    ##
    morphism_constructor := function( cat, source, matrix, range )
        
        return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(), cat,
                                                                        source,
                                                                        range,
                                                                        UnderlyingMatrix, matrix );
        
    end;
    
    ##
    modeling_tower_morphism_constructor := function( cat, source, matrix, range )
        local freyd, cols, source_cols, range_cols, cols_morphism;
        
        freyd := ModelingCategory( cat );
        
        cols := UnderlyingCategory( freyd );
        
        source_cols := Range( RelationMorphism( source ) );
        
        range_cols := Range( RelationMorphism( range ) );
        
        cols_morphism := CategoryOfColumnsMorphism( cols, source_cols, matrix, range_cols );
        
        return FreydCategoryMorphism( freyd, source, cols_morphism, range );
        
    end;
    
    ##
    morphism_datum := function( cat, mor )
        
        return UnderlyingMatrix( mor );
        
    end;
    
    ##
    modeling_tower_morphism_datum := function( cat, mor )
        
        return UnderlyingMatrix( UnderlyingMorphism( mor ) );
        
    end;
    
    wrapper := WrapperCategory( freyd, rec(
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
    
    wrapper!.compiler_hints.category_attribute_names := [
        "UnderlyingRing",
    ];
    
    SetUnderlyingRing( wrapper, ring );
    
    wrapper!.ring_for_representation_category := ring;
    
    AddCategoryToFamily( wrapper, "ModuleCategory" );
    
    ## TODO: avoid code duplication (see LeftPresentations)
    AddTheoremFileToCategory( wrapper,
      Filename(
        DirectoriesPackageLibrary( "ModulePresentationsForCAP", "LogicForModulePresentations" ),
        "PropositionsForGeneralModuleCategories.tex" )
    );
    
    AddPredicateImplicationFileToCategory( wrapper,
      Filename(
        DirectoriesPackageLibrary( "ModulePresentationsForCAP", "LogicForModulePresentations" ),
        "PredicateImplicationsForGeneralModuleCategories.tex" )
     );
    
    AddEvalRuleFileToCategory( wrapper,
      Filename(
        DirectoriesPackageLibrary( "ModulePresentationsForCAP", "LogicForModulePresentations" ),
        "RelationsForGeneralModuleCategories.tex" )
    );
    
    Finalize( wrapper );
    
    return wrapper;
    
end );
