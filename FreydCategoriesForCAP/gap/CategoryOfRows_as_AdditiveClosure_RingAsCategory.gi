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
InstallMethod( CategoryOfRows_as_AdditiveClosure_RingAsCategory,
               [ IsHomalgRing ],
               
  function( homalg_ring )
    local ring_as_category, add, object_constructor, modeling_tower_object_constructor, object_datum, modeling_tower_object_datum, morphism_constructor, modeling_tower_morphism_constructor, morphism_datum, modeling_tower_morphism_datum, category_object_filter, wrapper;
    
    ring_as_category := RING_AS_CATEGORY( homalg_ring : FinalizeCategory := true );
    
    add := ADDITIVE_CLOSURE( ring_as_category : FinalizeCategory := false );
    
    # Depending on the properties `HasInvariantBasisProperty` and `IsFieldForHomalg` of `homalg_ring`,
    # the additive closure is skeletal and/or Abelian.
    # These ring properties should actually be propagated to some categorical properties of `ring_as_category`
    # which the AdditiveClosure can use generically.
    # However, such categorical properties do not (yet) exist, so we have to set the categorical properties
    # a posteriori here. Afterwards, we have to reevaluate the derivations because they might have changed
    # by setting the properties.
    if HasHasInvariantBasisProperty( homalg_ring ) and HasInvariantBasisProperty( homalg_ring ) then
        
        SetIsSkeletalCategory( add, true );
        
    fi;
    
    if HasIsFieldForHomalg( homalg_ring ) and IsFieldForHomalg( homalg_ring ) then
        
        SetIsAbelianCategory( add, true );
        
        SetIsAbelianCategoryWithEnoughProjectives( add, true );
        
        SetIsAbelianCategoryWithEnoughInjectives( add, true );
        
    fi;
    
    Reevaluate( add!.derivations_weight_list );
    
    Finalize( add : FinalizeCategory := true );
    
    
    
    object_constructor := function ( cat, rank )
        
        if not IsInt( rank ) or rank < 0 then
            
            Error( "the object datum must be a non-negative integer" );
            
        fi;
        
        return CategoryOfRowsObject( cat, rank );
        
    end;
    
    modeling_tower_object_constructor := function ( cat, rank )
      local add, ring_as_category, unique_object;
        
        if not IsInt( rank ) or rank < 0 then
            
            Error( "the object datum must be a non-negative integer" );
            
        fi;
        
        add := ModelingCategory( cat );
        ring_as_category := UnderlyingCategory( add );
        
        unique_object := RingAsCategoryUniqueObject( ring_as_category );
        
        return AdditiveClosureObject( add, ListWithIdenticalEntries( rank, unique_object ) );
        
    end;
    
    object_datum := function ( cat, object )
        
        return RankOfObject( object );
        
    end;
    
    modeling_tower_object_datum := function ( cat, object )
        
        return BigInt( Length( ObjectList( object ) ) );
        
    end;
    
    morphism_constructor := function ( cat, source, underlying_matrix, range )
        
        if not IsHomalgMatrix( underlying_matrix ) then
            
            Error( "the morphism datum must be a homalg matrix" );
            
        fi;
        
        if not IsIdenticalObj( HomalgRing( underlying_matrix ), UnderlyingRing( cat ) ) then
            
            Error( "the matrix is defined over a different ring than the category" );
            
        fi;
        
        if NrRows( underlying_matrix ) <> ObjectDatum( cat, source ) then
            
            Error( "the number of rows has to be equal to the rank of the source" );
            
        fi;
        
        if NrColumns( underlying_matrix ) <> ObjectDatum( cat, range ) then
            
            Error( "the number of columns has to be equal to the rank of the range" );
            
        fi;
        
        return CategoryOfRowsMorphism( cat, source, underlying_matrix, range );
        
    end;
    
    modeling_tower_morphism_constructor := function ( cat, source2, underlying_matrix, range2 )
      local add, ring_as_category, unique_object, nr_rows, nr_cols, source, range, matrix_entries, listlist;
        
        if not IsHomalgMatrix( underlying_matrix ) then
            
            Error( "the morphism datum must be a homalg matrix" );
            
        fi;
        
        if not IsIdenticalObj( HomalgRing( underlying_matrix ), UnderlyingRing( cat ) ) then
            
            Error( "the matrix is defined over a different ring than the category" );
            
        fi;
        
        if NrRows( underlying_matrix ) <> modeling_tower_object_datum( cat, source2 ) then
            
            Error( "the number of rows has to be equal to the rank of the source" );
            
        fi;
        
        if NrColumns( underlying_matrix ) <> modeling_tower_object_datum( cat, range2 ) then
            
            Error( "the number of columns has to be equal to the rank of the range" );
            
        fi;
        
        add := ModelingCategory( cat );
        ring_as_category := UnderlyingCategory( add );
        
        unique_object := RingAsCategoryUniqueObject( ring_as_category );
        
        nr_rows := NrRows( underlying_matrix );
        nr_cols := NrCols( underlying_matrix );
        
        # We construct source and range explicitly because otherwise the compiler is missing the information that
        # Length( ObjectList( source ) ) = NrRows( underlying_matrix ).
        source := AdditiveClosureObject( add, ListWithIdenticalEntries( nr_rows, unique_object ) );
        range := AdditiveClosureObject( add, ListWithIdenticalEntries( nr_cols, unique_object ) );
        
        #% CAP_JIT_DROP_NEXT_STATEMENT
        Assert( 0, IsEqualForObjects( source, source2 ) );
        #% CAP_JIT_DROP_NEXT_STATEMENT
        Assert( 0, IsEqualForObjects( range, range2 ) );
        
        matrix_entries := EntriesOfHomalgMatrixAsListList( underlying_matrix );
        
        #% CAP_JIT_DROP_NEXT_STATEMENT
        Assert( 0, Length( matrix_entries ) = nr_rows );
        #% CAP_JIT_DROP_NEXT_STATEMENT
        Assert( 0, ForAll( matrix_entries, row -> Length( row ) = nr_cols ) );
        
        listlist := List( matrix_entries,
            row -> List( row,
                c -> RingAsCategoryMorphism( ring_as_category, c )
            )
        );
        
        #% CAP_JIT_DROP_NEXT_STATEMENT
        Assert( 0, Length( listlist ) = Length( ObjectList( source ) ) );
        #% CAP_JIT_DROP_NEXT_STATEMENT
        Assert( 0, ForAll( listlist, row -> Length( row ) = Length( ObjectList( range ) ) ) );
        
        return AdditiveClosureMorphism( add, source, listlist, range );
        
    end;
    
    morphism_datum := function ( cat, morphism )
        
        return UnderlyingMatrix( morphism );
        
    end;
    
    modeling_tower_morphism_datum := function ( cat, morphism )
      local matrix_entries;
        
        matrix_entries := List( MorphismMatrix( morphism ),
            row -> List( row,
                c -> UnderlyingRingElement( c )
            )
        );
        
        return HomalgMatrixListList( matrix_entries, NrRows( morphism ), NrCols( morphism ), UnderlyingRing( cat ) );
        
    end;
    
    if HasIsFieldForHomalg( homalg_ring ) and IsFieldForHomalg( homalg_ring ) then
        
        category_object_filter := IsCategoryOfRowsObject and HasIsProjective and IsProjective;
        
    else
        
        category_object_filter := IsCategoryOfRowsObject;
        
    fi;
    
    wrapper := ReinterpretationOfCategory( add, rec(
        name := Concatenation( "Rows( ", RingName( homalg_ring )," )" ),
        category_filter := IsCategoryOfRows,
        category_object_filter := category_object_filter,
        category_morphism_filter := IsCategoryOfRowsMorphism and HasUnderlyingMatrix,
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
        object_attribute_name := "RankOfObject",
        morphism_attribute_name := "UnderlyingMatrix",
        source_attribute_getter_name := "NumberRows",
        range_attribute_getter_name := "NumberColumns",
    );
    
    if HasIsExteriorRing( homalg_ring ) and IsExteriorRing( homalg_ring ) and IsField( BaseRing( homalg_ring ) ) then
        
        SetBasisOfRingOverBaseFieldAsColumnVector( wrapper, BasisOverBaseFieldAsColumnVector( ring_as_category ) );
        
        Add( wrapper!.compiler_hints.category_attribute_names, "BasisOfRingOverBaseFieldAsColumnVector" );
        
    fi;
    
    # some manually precompiled functions
    
    ##
    AddZeroMorphism( wrapper,
      function( cat, source, range )
        
        return CategoryOfRowsMorphism( cat, source, HomalgMatrixListList( NullMatImmutable( RankOfObject( source ), RankOfObject( range ) ), RankOfObject( source ), RankOfObject( range ), homalg_ring ), range );
        
    end );
    
    ##
    AddIsLiftable( wrapper,
      function( cat, alpha, beta )
        
        return IsZero( DecideZeroRows( UnderlyingMatrix( alpha ), UnderlyingMatrix( beta ) ) );
        
    end );
    
    ##
    AddLift( wrapper,
      function( cat, alpha, beta )
        local right_divide;
        
        right_divide := RightDivide( UnderlyingMatrix( alpha ), UnderlyingMatrix( beta ) );
        
        return CategoryOfRowsMorphism( cat, Source( alpha ), right_divide, Source( beta ) );
        
    end );
    
    ##
    AddIsColiftable( wrapper,
      function( cat, alpha, beta )
        
        return IsZero( DecideZeroColumns( UnderlyingMatrix( beta ), UnderlyingMatrix( alpha ) ) );
        
    end );
    
    ##
    AddColift( wrapper,
      function( cat, alpha, beta )
        local left_divide;
        
        left_divide := LeftDivide( UnderlyingMatrix( alpha ), UnderlyingMatrix( beta ) );
        
        return CategoryOfRowsMorphism( cat, Range( alpha ), left_divide, Range( beta ) );
        
    end );
    
    Finalize( wrapper );
    
    return wrapper;
    
end );

InstallGlobalFunction( COMPILATION_HELPER_HomalgMatrixFromRingElement, function ( ring_element, ring )
    
    return HomalgMatrixListList( [ [ ring_element ] ], 1, 1, ring );
    
end );
