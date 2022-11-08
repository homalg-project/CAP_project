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
InstallMethod( CategoryOfColumnsAsOppositeOfCategoryOfRows,
               [ IsHomalgRing ],
               
  function( homalg_ring )
    local rows, op, object_constructor, modeling_tower_object_constructor, object_datum, modeling_tower_object_datum, morphism_constructor, modeling_tower_morphism_datum, morphism_datum, modeling_tower_morphism_constructor, category_object_filter, wrapper;
    
    rows := CategoryOfRows( homalg_ring : FinalizeCategory := true );
    
    op := Opposite( rows : only_primitive_operations := true, FinalizeCategory := true );
    
    ##
    object_constructor := function( cat, rank )
        
        return ObjectifyObjectForCAPWithAttributes( rec( ), cat,
                                                    RankOfObject, rank );
        
    end;
    
    modeling_tower_object_constructor := function( cat, rank )
      local op, rows;
        
        op := ModelingCategory( cat );
        
        rows := Opposite( op );
        
        return ObjectConstructor( op, CategoryOfRowsObject( rows, rank ) );
        
    end;
    
    ##
    object_datum := function( cat, obj )
        
        return RankOfObject( obj );
        
    end;
    
    modeling_tower_object_datum := function( cat, obj )
        
        return RankOfObject( Opposite( obj ) );
        
    end;
    
    ##
    morphism_constructor := function( cat, source, underlying_matrix, range )
        
        return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec( ), cat,
                source,
                range,
                UnderlyingMatrix, underlying_matrix );
        
    end;
    
    modeling_tower_morphism_constructor := function( cat, source, underlying_matrix, range )
      local op, rows, rows_morphism;
        
        op := ModelingCategory( cat );
        
        rows := Opposite( op );
        
        rows_morphism := CategoryOfRowsMorphism(
            rows,
            Opposite( range ),
            underlying_matrix,
            Opposite( source )
        );
        
        return MorphismConstructor(
            op,
            source,
            rows_morphism,
            range
        );
        
    end;
    
    ##
    morphism_datum := function( cat, mor )
        
        return UnderlyingMatrix( mor );
        
    end;
    
    modeling_tower_morphism_datum := function( cat, mor )
        
        return UnderlyingMatrix( Opposite( mor ) );
        
    end;
    
    if HasIsFieldForHomalg( homalg_ring ) and IsFieldForHomalg( homalg_ring ) then
        
        category_object_filter := IsCategoryOfColumnsObject and HasIsProjective and IsProjective;
        
    else
        
        category_object_filter := IsCategoryOfColumnsObject;
        
    fi;
    
    wrapper := WrapperCategory( op, rec(
        name := Concatenation( "Columns( ", RingName( homalg_ring )," )" ),
        category_filter := IsCategoryOfColumns,
        category_object_filter := category_object_filter,
        category_morphism_filter := IsCategoryOfColumnsMorphism and HasUnderlyingMatrix,
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
    
    SetUnderlyingRing( wrapper, homalg_ring );
    
    wrapper!.compiler_hints.category_attribute_names := [
        "UnderlyingRing"
    ];
    
    wrapper!.compiler_hints.source_and_range_attributes_from_morphism_attribute := rec(
        object_attribute_name := "RankOfObject",
        morphism_attribute_name := "UnderlyingMatrix",
        source_attribute_getter_name := "NumberColumns",
        range_attribute_getter_name := "NumberRows",
    );
    
    if HasIsExteriorRing( homalg_ring ) and IsExteriorRing( homalg_ring ) and IsField( BaseRing( homalg_ring ) ) then
        
        SetGeneratingSystemOfRingAsModuleInRangeCategoryOfHomomorphismStructure( wrapper, GeneratingSystemOfRingAsModuleInRangeCategoryOfHomomorphismStructure( rows ) );
        SetColumnVectorOfGeneratingSystemOfRingAsModuleInRangeCategoryOfHomomorphismStructure( wrapper, ColumnVectorOfGeneratingSystemOfRingAsModuleInRangeCategoryOfHomomorphismStructure( rows ) );
        SetRingInclusionForHomomorphismStructure( wrapper, RingInclusionForHomomorphismStructure( rows ) );
        
        Add( wrapper!.compiler_hints.category_attribute_names, "GeneratingSystemOfRingAsModuleInRangeCategoryOfHomomorphismStructure" );
        Add( wrapper!.compiler_hints.category_attribute_names, "ColumnVectorOfGeneratingSystemOfRingAsModuleInRangeCategoryOfHomomorphismStructure" );
        Add( wrapper!.compiler_hints.category_attribute_names, "RingInclusionForHomomorphismStructure" );
        
    fi;
    
    INSTALL_FUNCTIONS_FOR_CATEGORY_OF_COLUMNS_AS_OPPOSITE_OF_CATEGORY_OF_ROWS( wrapper );
    
    Finalize( wrapper );
    
    return wrapper;
    
end );

####################################
##
## Basic operations
##
####################################


InstallGlobalFunction( INSTALL_FUNCTIONS_FOR_CATEGORY_OF_COLUMNS_AS_OPPOSITE_OF_CATEGORY_OF_ROWS,
  
  function( category )
    
    ##
    AddSomeReductionBySplitEpiSummand( category,
      function( cat, alpha )
        
        return AsCategoryOfColumnsMorphism( cat, CATEGORY_OF_COLUMNS_ReductionBySplitEpiSummandTuple( alpha )[1] );
        
    end );
    
    ##
    AddSomeReductionBySplitEpiSummand_MorphismFromInputRange( category,
      function( cat, alpha )
        
        return AsCategoryOfColumnsMorphism( cat, CATEGORY_OF_COLUMNS_ReductionBySplitEpiSummandTuple( alpha )[2] );
        
    end );
    
    ##
    AddSomeReductionBySplitEpiSummand_MorphismToInputRange( category,
      function( cat, alpha )
        
        return AsCategoryOfColumnsMorphism( cat, CATEGORY_OF_COLUMNS_ReductionBySplitEpiSummandTuple( alpha )[3] );
        
    end );
    
end );
