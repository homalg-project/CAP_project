# SPDX-License-Identifier: GPL-2.0-or-later
# LinearAlgebraForCAP: Category of Matrices over a Field for CAP
#
# Implementations
#

####################################
##
## Constructors
##
####################################

##
InstallMethod( MatrixCategory_as_CategoryOfRows,
               [ IsFieldForHomalg ],
               
  FunctionWithNamedArguments(
  [
    [ "FinalizeCategory", true ],
  ],
  function( CAP_NAMED_ARGUMENTS, homalg_ring )
    local rows, object_constructor, modeling_tower_object_constructor, object_datum, modeling_tower_object_datum, morphism_constructor, modeling_tower_morphism_constructor, morphism_datum, modeling_tower_morphism_datum, wrapper;
    
    rows := CategoryOfRows( homalg_ring : no_precompiled_code := false ); # we do not want to recompile CategoryOfRows
    
    object_constructor := function ( cat, dimension )
        
        if not IsInt( dimension ) or dimension < 0 then
            
            Error( "the object datum must be a non-negative integer" );
            
        fi;
        
        return AsCapCategoryObject( cat, dimension );
        
    end;
    
    modeling_tower_object_constructor := function ( cat, dimension )
        
        if not IsInt( dimension ) or dimension < 0 then
            
            Error( "the object datum must be a non-negative integer" );
            
        fi;
        
        return CreateCapCategoryObjectWithAttributes( ModelingCategory( cat ), RankOfObject, dimension );
        
    end;
    
    object_datum := function ( cat, object )
        
        return AsInteger( object );
        
    end;
    
    modeling_tower_object_datum := function ( cat, object )
        
        return RankOfObject( object );
        
    end;
    
    morphism_constructor := function ( cat, source, homalg_matrix, range )
        
        if not IsHomalgMatrix( homalg_matrix ) then
            
            Error( "the morphism datum must be a homalg matrix" );
            
        fi;
        
        if not IsIdenticalObj( HomalgRing( homalg_matrix ), UnderlyingRing( cat ) ) then
            
            Error( "the matrix is defined over a different ring than the category" );
            
        fi;
        
        if NrRows( homalg_matrix ) <> ObjectDatum( cat, source ) then
            
            Error( "the number of rows has to be equal to the dimension of the source" );
            
        fi;
        
        if NrColumns( homalg_matrix ) <> ObjectDatum( cat, range ) then
            
            Error( "the number of columns has to be equal to the dimension of the range" );
            
        fi;
        
        return AsCapCategoryMorphism( cat, source, homalg_matrix, range );
        
    end;
    
    modeling_tower_morphism_constructor := function ( cat, source, homalg_matrix, range )
        
        if not IsHomalgMatrix( homalg_matrix ) then
            
            Error( "the morphism datum must be a homalg matrix" );
            
        fi;
        
        if not IsIdenticalObj( HomalgRing( homalg_matrix ), UnderlyingRing( cat ) ) then
            
            Error( "the matrix is defined over a different ring than the category" );
            
        fi;
        
        if NrRows( homalg_matrix ) <> ObjectDatum( ModelingCategory( cat ), source ) then
            
            Error( "the number of rows has to be equal to the dimension of the source" );
            
        fi;
        
        if NrColumns( homalg_matrix ) <> ObjectDatum( ModelingCategory( cat ), range ) then
            
            Error( "the number of columns has to be equal to the dimension of the range" );
            
        fi;
        
        return CreateCapCategoryMorphismWithAttributes( ModelingCategory( cat ), source, range,
                                                        UnderlyingMatrix, homalg_matrix
        );
        
    end;
    
    morphism_datum := function ( cat, morphism )
        
        return AsHomalgMatrix( morphism );
        
    end;
    
    modeling_tower_morphism_datum := function ( cat, morphism )
        
        return UnderlyingMatrix( morphism );
        
    end;
    
    wrapper := ReinterpretationOfCategory( rows, rec(
        name := Concatenation( "Category of matrices over ", RingName( homalg_ring ) ),
        category_filter := IsMatrixCategory,
        category_object_filter := IsVectorSpaceObject and HasAsInteger and HasIsProjective and IsProjective,
        category_morphism_filter := IsVectorSpaceMorphism and HasAsHomalgMatrix,
        object_datum_type := IsInt,
        morphism_datum_type := rec( filter := IsHomalgMatrix, ring := homalg_ring ),
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
        "UnderlyingRing",
    ];
    
    wrapper!.compiler_hints.source_and_range_attributes_from_morphism_attribute := rec(
        object_attribute_name := "AsInteger",
        morphism_attribute_name := "AsHomalgMatrix",
        source_attribute_getter_name := "NumberRows",
        range_attribute_getter_name := "NumberColumns",
    );
    
    if CAP_NAMED_ARGUMENTS.FinalizeCategory then
        
        Finalize( wrapper );
        
    fi;
    
    return wrapper;
    
end ) );
