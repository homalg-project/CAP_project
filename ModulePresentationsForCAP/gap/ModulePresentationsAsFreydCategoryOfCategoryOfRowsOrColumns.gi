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
    local category_of_rows, freyd, object_constructor, object_datum, morphism_constructor, morphism_datum, wrapper;
    
    category_of_rows := CategoryOfRows( ring : FinalizeCategory := true );
    
    freyd := FREYD_CATEGORY( category_of_rows : FinalizeCategory := true );
    
    object_constructor := function( cat, object_in_freyd )
        
        return ObjectifyObjectForCAPWithAttributes( rec( ), cat,
                                                    UnderlyingMatrix, UnderlyingMatrix( RelationMorphism( object_in_freyd ) )
        );
        
    end;
    
    object_datum := function( cat, obj )
      local freyd, category_of_rows, relation_morphism;
        
        freyd := ModelingCategory( cat );
        
        category_of_rows := UnderlyingCategory( freyd );
        
        relation_morphism := CategoryOfRowsMorphism( category_of_rows,
            CategoryOfRowsObject( category_of_rows, NrRows( UnderlyingMatrix( obj ) ) ),
            UnderlyingMatrix( obj ),
            CategoryOfRowsObject( category_of_rows, NrCols( UnderlyingMatrix( obj ) ) )
        );
        
        return FreydCategoryObject( freyd, relation_morphism );
        
    end;
    
    morphism_constructor := function( cat, source, morphism_in_freyd, range )
        
        return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec( ), cat,
                source,
                range,
                UnderlyingMatrix, UnderlyingMatrix( UnderlyingMorphism( morphism_in_freyd ) ) );
        
    end;
    
    morphism_datum := function( cat, mor )
      local freyd, category_of_rows, morphism_datum;
        
        freyd := ModelingCategory( cat );
        
        category_of_rows := UnderlyingCategory( freyd );
        
        morphism_datum := CategoryOfRowsMorphism( category_of_rows,
            CategoryOfRowsObject( category_of_rows, NrRows( UnderlyingMatrix( mor ) ) ),
            UnderlyingMatrix( mor ),
            CategoryOfRowsObject( category_of_rows, NrCols( UnderlyingMatrix( mor ) ) )
        );
        
        return FreydCategoryMorphism( freyd, ObjectDatum( cat, Source( mor ) ), morphism_datum, ObjectDatum( cat, Range( mor ) ) );
        
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
        # TODO: use new system
        modeling_tower_object_constructor := { cat, obj } -> obj,
        modeling_tower_object_datum := { cat, obj } -> obj,
        modeling_tower_morphism_constructor := { cat, source, mor, range } -> mor,
        modeling_tower_morphism_datum := { cat, mor } -> mor,
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
    local category_of_columns, freyd, object_constructor, object_datum, morphism_constructor, morphism_datum, wrapper;
    
    category_of_columns := CategoryOfColumns( ring : FinalizeCategory := true );
    
    freyd := FREYD_CATEGORY( category_of_columns : FinalizeCategory := true );
    
    object_constructor := function( cat, object_in_freyd )
        
        return ObjectifyObjectForCAPWithAttributes( rec( ), cat,
                                                    UnderlyingMatrix, UnderlyingMatrix( RelationMorphism( object_in_freyd ) )
        );
        
    end;
    
    object_datum := function( cat, obj )
      local freyd, category_of_columns, relation_morphism;
        
        freyd := ModelingCategory( cat );
        
        category_of_columns := UnderlyingCategory( freyd );
        
        relation_morphism := CategoryOfColumnsMorphism( category_of_columns,
            CategoryOfColumnsObject( category_of_columns, NrCols( UnderlyingMatrix( obj ) ) ),
            UnderlyingMatrix( obj ),
            CategoryOfColumnsObject( category_of_columns, NrRows( UnderlyingMatrix( obj ) ) )
        );
        
        return FreydCategoryObject( freyd, relation_morphism );
        
    end;
    
    morphism_constructor := function( cat, source, morphism_in_freyd, range )
        
        return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec( ), cat,
                source,
                range,
                UnderlyingMatrix, UnderlyingMatrix( UnderlyingMorphism( morphism_in_freyd ) ) );
        
    end;
    
    morphism_datum := function( cat, mor )
      local freyd, category_of_columns, morphism_datum;
        
        freyd := ModelingCategory( cat );
        
        category_of_columns := UnderlyingCategory( freyd );
        
        morphism_datum := CategoryOfColumnsMorphism( category_of_columns,
            CategoryOfColumnsObject( category_of_columns, NrCols( UnderlyingMatrix( mor ) ) ),
            UnderlyingMatrix( mor ),
            CategoryOfColumnsObject( category_of_columns, NrRows( UnderlyingMatrix( mor ) ) )
        );
        
        return FreydCategoryMorphism( freyd, ObjectDatum( cat, Source( mor ) ), morphism_datum, ObjectDatum( cat, Range( mor ) ) );
        
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
        # TODO: use new system
        modeling_tower_object_constructor := { cat, obj } -> obj,
        modeling_tower_object_datum := { cat, obj } -> obj,
        modeling_tower_morphism_constructor := { cat, source, mor, range } -> mor,
        modeling_tower_morphism_datum := { cat, mor } -> mor,
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
