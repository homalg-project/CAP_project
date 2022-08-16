# SPDX-License-Identifier: GPL-2.0-or-later
# CAP: Categories, Algorithms, Programming
#
# Implementations
#

##
InstallMethod( UnderlyingCategory,
        "for a wrapper CAP category",
        [ IsWrapperCapCategory ],
        
  function( D )
    
    Print(
      "WARNING: UnderlyingCategory for IsWrapperCapCategory is deprecated and will not be supported after 2023.06.13. Please use ModelingCategory instead.\n"
    );
    
    return ModelingCategory( D );
    
end );

##
InstallMethodForCompilerForCAP( AsObjectInWrapperCategory,
        "for a wrapper CAP category and a CAP object",
        [ IsWrapperCapCategory, IsCapCategoryObject ],
        
  function( D, object )
    
    #% CAP_JIT_DROP_NEXT_STATEMENT
    CAP_INTERNAL_ASSERT_IS_OBJECT_OF_CATEGORY( object, ModelingCategory( D ), {} -> "the object given to AsObjectInWrapperCategory" );
    
    return ObjectifyObjectForCAPWithAttributes( rec( ), D,
            UnderlyingCell, object );
    
end );

##
InstallMethod( AsMorphismInWrapperCategory,
        "for two CAP objects in a wrapper category and a CAP morphism",
        [ IsWrapperCapCategoryObject, IsCapCategoryMorphism, IsWrapperCapCategoryObject ],
        
  function( source, morphism, range )
    
    return AsMorphismInWrapperCategory( CapCategory( source ), source, morphism, range );
    
end );

##
InstallOtherMethodForCompilerForCAP( AsMorphismInWrapperCategory,
        "for two CAP objects in a wrapper category and a CAP morphism",
        [ IsWrapperCapCategory, IsWrapperCapCategoryObject, IsCapCategoryMorphism, IsWrapperCapCategoryObject ],
        
  function( D, source, morphism, range )
    
    #% CAP_JIT_DROP_NEXT_STATEMENT
    CAP_INTERNAL_ASSERT_IS_MORPHISM_OF_CATEGORY( morphism, ModelingCategory( D ), {} -> "the morphism given to AsMorphismInWrapperCategory" );
    
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec( ), D,
            source,
            range,
            UnderlyingCell, morphism );
    
end );

##
InstallMethodWithCache( AsMorphismInWrapperCategory,
        "for a wrapper CAP category and a CAP morphism",
        [ IsWrapperCapCategory, IsCapCategoryMorphism ],
        
  function( D, morphism )
    
    return AsMorphismInWrapperCategory(
                   AsObjectInWrapperCategory( D, Source( morphism ) ),
                   morphism,
                   AsObjectInWrapperCategory( D, Range( morphism ) )
                   );
    
end );

##
InstallOtherMethod( \/,
        "for an object and a wrapper CAP category",
        [ IsObject, IsWrapperCapCategory ],
        
  function( data, C )
    
    return ( data / ModelingCategory( C ) ) / C;
    
end );

##
InstallMethod( \/,
        "for a CAP category object and a wrapper CAP category",
         [ IsCapCategoryObject, IsWrapperCapCategory ],
        
  function( object, cat )
    
    if not IsIdenticalObj( CapCategory( object ), ModelingCategory( cat ) ) then
        TryNextMethod( );
    fi;
    
    return AsObjectInWrapperCategory( cat, object );
    
end );

##
InstallMethod( \/,
        "for a CAP category morphism and a wrapper CAP category",
        [ IsCapCategoryMorphism, IsWrapperCapCategory ],
        
  function( morphism, cat )
    
    if not IsIdenticalObj( CapCategory( morphism ), ModelingCategory( cat ) ) then
        TryNextMethod( );
    fi;
    
    return AsMorphismInWrapperCategory( cat, morphism );
    
end );

##
InstallMethod( WrapperCategory,
        "for a CAP category and a record of options",
        [ IsCapCategory, IsRecord ],
        
  function( C, options )
    local known_options_with_filters, filter, combined_options, category_constructor_options, copy_value_or_default, list_of_operations_to_install, D, modeling_tower_object_constructor, modeling_tower_object_datum, modeling_tower_morphism_constructor, modeling_tower_morphism_datum, HC, option_name;
    
    ## check given options
    known_options_with_filters := rec(
        name := IsString,
        category_filter := IsFilter,
        category_object_filter := IsFilter,
        category_morphism_filter := IsFilter,
        object_constructor := IsFunction,
        object_datum := IsFunction,
        morphism_constructor := IsFunction,
        morphism_datum := IsFunction,
        modeling_tower_object_constructor := IsFunction,
        modeling_tower_object_datum := IsFunction,
        modeling_tower_morphism_constructor := IsFunction,
        modeling_tower_morphism_datum := IsFunction,
        only_primitive_operations := IsBool,
        wrap_range_of_hom_structure := IsBool,
    );
    
    for option_name in RecNames( options ) do
        
        if IsBound( known_options_with_filters.(option_name) ) then
            
            filter := known_options_with_filters.(option_name);
            
            if not filter( options.(option_name) ) then
                
                # COVERAGE_IGNORE_NEXT_LINE
                Error( "The value of the option `", option_name, "` must lie in the filter ", filter );
                
            fi;
            
        else
            
            # COVERAGE_IGNORE_NEXT_LINE
            Error( "The following option is not known to `WrapperCategory`: ", option_name );
            
        fi;
        
    od;
    
    # options which should either all or none be set for consistency
    combined_options := [
        "category_filter",
        "category_object_filter",
        "category_morphism_filter",
        "object_constructor",
        "object_datum",
        "morphism_constructor",
        "morphism_datum",
        "modeling_tower_object_constructor",
        "modeling_tower_object_datum",
        "modeling_tower_morphism_constructor",
        "modeling_tower_morphism_datum",
    ];
    
    # If the given filters imply the default filters, using the default options does not cause inconsistencies -> avoid a warning in this case.
    if IsBound( options.category_filter ) and IsSpecializationOfFilter( IsWrapperCapCategory, options.category_filter ) then
        
        Remove( combined_options, Position( combined_options, "category_filter" ) );
        
    fi;
    
    if IsBound( options.category_object_filter ) and IsSpecializationOfFilter( IsWrapperCapCategoryObject, options.category_object_filter ) then
        
        Remove( combined_options, Position( combined_options, "category_object_filter" ) );
        
    fi;
    
    if IsBound( options.category_morphism_filter ) and IsSpecializationOfFilter( IsWrapperCapCategoryMorphism, options.category_morphism_filter ) then
        
        Remove( combined_options, Position( combined_options, "category_morphism_filter" ) );
        
    fi;
    
    if Length( Set( List( combined_options, name -> IsBound( options.(name) ) ) ) ) > 1 then
        
        Display( "WARNING: To avoid inconsistencies, either all or none of the following options should be set in a call to `WrapperCategory`. This is not the case." );
        Display( combined_options );
        
    fi;
    
    # the methods for ModelingObject et al. will be installed later once we have a category filter
    category_constructor_options := rec(
        underlying_category_getter_string := "ModelingCategory",
        underlying_object_getter_string := "ModelingObject",
        underlying_morphism_getter_string := "ModelingMorphism",
        top_object_getter_string := "ModeledObject",
        top_morphism_getter_string := "ModeledMorphism",
        generic_output_source_getter_string := "ModeledObject( cat, Source( underlying_result ) )",
        generic_output_range_getter_string := "ModeledObject( cat, Range( underlying_result ) )",
        create_func_bool := "default",
        create_func_object := "default",
        create_func_object_or_fail := "default",
        create_func_morphism := "default",
        create_func_morphism_or_fail := "default",
    );
    
    if IsBound( options.name ) then
        
        category_constructor_options.name := options.name;
        
    elif HasName( C ) then
        
        category_constructor_options.name := Concatenation( "WrapperCategory( ", Name( C ), " )" );
        
    fi;
    
    # helper function
    copy_value_or_default := function ( source_record, target_record, name, default_value )
        
        if IsBound( source_record.(name) ) then
            
            target_record.(name) := source_record.(name);
            
        else
            
            target_record.(name) := default_value;
            
        fi;
        
    end;
    
    copy_value_or_default( options, category_constructor_options, "category_object_filter", IsWrapperCapCategoryObject );
    copy_value_or_default( options, category_constructor_options, "category_morphism_filter", IsWrapperCapCategoryMorphism );
    copy_value_or_default( options, category_constructor_options, "object_constructor", AsObjectInWrapperCategory );
    copy_value_or_default( options, category_constructor_options, "object_datum", { D, o } -> UnderlyingCell( o ) );
    copy_value_or_default( options, category_constructor_options, "morphism_constructor", AsMorphismInWrapperCategory );
    copy_value_or_default( options, category_constructor_options, "morphism_datum", { D, m } -> UnderlyingCell( m ) );
    
    if IsBound( options.category_filter ) then
        
        category_constructor_options.category_filter := WasCreatedAsWrapperCapCategory and options.category_filter;
        
    else
        
        category_constructor_options.category_filter := IsWrapperCapCategory; # IsWrapperCapCategory already implies WasCreatedAsWrapperCapCategory
        
    fi;
    
    if HasCommutativeRingOfLinearCategory( C ) then
        
        category_constructor_options.commutative_ring_of_linear_category := CommutativeRingOfLinearCategory( C );
        
    fi;
    
    category_constructor_options.properties := ListKnownCategoricalProperties( C );
    
    if IsBound( options.only_primitive_operations ) and options.only_primitive_operations then
        
        list_of_operations_to_install := ListPrimitivelyInstalledOperationsOfCategory( C );
        
    else
        
        list_of_operations_to_install := ListInstalledOperationsOfCategory( C );
        
    fi;
    
    category_constructor_options.list_of_operations_to_install := list_of_operations_to_install;
    
    D := CategoryConstructor( category_constructor_options );
    
    if IsBound( C!.supports_empty_limits ) then
        
        D!.supports_empty_limits := C!.supports_empty_limits;
        
    fi;
    
    D!.compiler_hints.category_attribute_names := [
        "ModelingCategory",
    ];
    
    SetModelingCategory( D, C );
    
    # install methods
    if IsBound( options.modeling_tower_object_constructor ) then
        
        modeling_tower_object_constructor := options.modeling_tower_object_constructor;
        
    else
        
        modeling_tower_object_constructor := { cat, obj } -> obj;
        
    fi;
    
    if IsBound( options.modeling_tower_object_datum ) then
        
        modeling_tower_object_datum := options.modeling_tower_object_datum;
        
    else
        
        modeling_tower_object_datum := { cat, obj } -> obj;
        
    fi;
    
    if IsBound( options.modeling_tower_morphism_constructor ) then
        
        modeling_tower_morphism_constructor := options.modeling_tower_morphism_constructor;
        
    else
        
        modeling_tower_morphism_constructor := { cat, source, mor, range } -> mor;
        
    fi;
    
    if IsBound( options.modeling_tower_morphism_datum ) then
        
        modeling_tower_morphism_datum := options.modeling_tower_morphism_datum;
        
    else
        
        modeling_tower_morphism_datum := { cat, mor } -> mor;
        
    fi;
    
    InstallMethodForCompilerForCAP( ModelingTowerObjectConstructor,
        [ WasCreatedAsWrapperCapCategory and CategoryFilter( D ), IsObject ],
        modeling_tower_object_constructor
    );
    
    InstallMethodForCompilerForCAP( ModelingTowerObjectDatum,
        [ WasCreatedAsWrapperCapCategory and CategoryFilter( D ), IsCapCategoryObject and ObjectFilter( C ) ],
        modeling_tower_object_datum
    );
    
    InstallMethodForCompilerForCAP( ModelingTowerMorphismConstructor,
        [ WasCreatedAsWrapperCapCategory and CategoryFilter( D ), IsCapCategoryObject and ObjectFilter( C ), IsObject, IsCapCategoryObject and ObjectFilter( C ) ],
        modeling_tower_morphism_constructor
    );
    
    InstallMethodForCompilerForCAP( ModelingTowerMorphismDatum,
        [ WasCreatedAsWrapperCapCategory and CategoryFilter( D ), IsCapCategoryMorphism and MorphismFilter( C ) ],
        modeling_tower_morphism_datum
    );
    
    
    InstallMethodForCompilerForCAP( ModelingObject,
        [ WasCreatedAsWrapperCapCategory and CategoryFilter( D ), IsCapCategoryObject and ObjectFilter( D ) ],
        
      function ( cat, obj )
        
        return ModelingTowerObjectConstructor( cat, ObjectDatum( cat, obj ) );
        
    end );
    
    InstallMethodForCompilerForCAP( ModeledObject,
        [ WasCreatedAsWrapperCapCategory and CategoryFilter( D ), IsCapCategoryObject and ObjectFilter( C ) ],
        
      function ( cat, obj )
        
        return ObjectConstructor( cat, ModelingTowerObjectDatum( cat, obj ) );
        
    end );
    
    InstallMethodForCompilerForCAP( ModelingMorphism,
        [ WasCreatedAsWrapperCapCategory and CategoryFilter( D ), IsCapCategoryMorphism and MorphismFilter( D ) ],
        
      function ( cat, mor )
        
        return ModelingTowerMorphismConstructor( cat, ModelingObject( cat, Source( mor ) ), MorphismDatum( cat, mor ), ModelingObject( cat, Range( mor ) ) );
        
    end );
    
    InstallMethodForCompilerForCAP( ModeledMorphism,
        [ WasCreatedAsWrapperCapCategory and CategoryFilter( D ), IsCapCategoryObject and ObjectFilter( D ), IsCapCategoryMorphism and MorphismFilter( C ), IsCapCategoryObject and ObjectFilter( D ) ],
        
      function ( cat, source, mor, range )
        
        return MorphismConstructor( cat, source, ModelingTowerMorphismDatum( cat, mor ), range );
        
    end );
    
    if "BasisOfExternalHom" in list_of_operations_to_install then
        
        AddBasisOfExternalHom( D,
          function( cat, a, b )
            
            return List( BasisOfExternalHom( ModelingCategory( cat ), ModelingObject( cat, a ), ModelingObject( cat, b ) ),
                         mor -> ModeledMorphism( cat, a, mor, b ) );
            
        end );
        
    fi;
    
    if "CoefficientsOfMorphismWithGivenBasisOfExternalHom" in list_of_operations_to_install then
        
        AddCoefficientsOfMorphismWithGivenBasisOfExternalHom( D,
          function( cat, alpha, L )
            
            return CoefficientsOfMorphismWithGivenBasisOfExternalHom( ModelingCategory( cat ),
                           ModelingMorphism( cat, alpha ),
                           List( L, l -> ModelingMorphism( cat, l ) ) );
            
        end );
        
    fi;
    
    if HasRangeCategoryOfHomomorphismStructure( C ) then
        
        HC := RangeCategoryOfHomomorphismStructure( C );
        
        if IsBound( options.wrap_range_of_hom_structure ) and options.wrap_range_of_hom_structure and not WasCreatedAsWrapperCapCategory( HC ) then
            
            if IsIdenticalObj( C, HC ) then
                
                # The range of the homomorphism structure of C is C itself,
                # so the range of the homomorphism structure of D should be D itself.
                # This prevents infinite recursions.
                HC := D;
                
            else
                
                HC := WrapperCategory( HC, rec( ) );
                
            fi;
            
            SetRangeCategoryOfHomomorphismStructure( D, HC );
            
            if "DistinguishedObjectOfHomomorphismStructure" in list_of_operations_to_install then
                AddDistinguishedObjectOfHomomorphismStructure( D,
                  function( cat )
                    
                    return ModeledObject( HC, DistinguishedObjectOfHomomorphismStructure( ModelingCategory( cat ) ) );
                    
                end );
            fi;
            
            if "HomomorphismStructureOnObjects" in list_of_operations_to_install then
                AddHomomorphismStructureOnObjects( D,
                  function( cat, a, b )
                    
                    return ModeledObject( HC, HomomorphismStructureOnObjects( ModelingCategory( cat ), ModelingObject( cat, a ), ModelingObject( cat, b ) ) );
                    
                end );
            fi;
            
            if "HomomorphismStructureOnMorphismsWithGivenObjects" in list_of_operations_to_install then
                AddHomomorphismStructureOnMorphismsWithGivenObjects( D,
                  function( cat, s, alpha, beta, r )
                    
                    return ModeledMorphism( HC, s, HomomorphismStructureOnMorphismsWithGivenObjects( ModelingCategory( cat ), ModelingObject( HC, s ), ModelingMorphism( cat, alpha ), ModelingMorphism( cat, beta ), ModelingObject( HC, r ) ), r );
                    
                end );
            fi;
            
            if "InterpretMorphismAsMorphismFromDistinguishedObjectToHomomorphismStructureWithGivenObjects" in list_of_operations_to_install then
                AddInterpretMorphismAsMorphismFromDistinguishedObjectToHomomorphismStructureWithGivenObjects( D,
                  function( cat, s, alpha, r )
                    
                    return ModeledMorphism( HC, s, InterpretMorphismAsMorphismFromDistinguishedObjectToHomomorphismStructureWithGivenObjects( ModelingCategory( cat ), ModelingObject( HC, s ), ModelingMorphism( cat, alpha ), ModelingObject( HC, r ) ), r );
                    
                end );
            fi;
            
            if "InterpretMorphismFromDistinguishedObjectToHomomorphismStructureAsMorphism" in list_of_operations_to_install then
                AddInterpretMorphismFromDistinguishedObjectToHomomorphismStructureAsMorphism( D,
                  function( cat, a, b, iota )
                    
                    return ModeledMorphism( cat, a, InterpretMorphismFromDistinguishedObjectToHomomorphismStructureAsMorphism( ModelingCategory( cat ), ModelingObject( cat, a ), ModelingObject( cat, b ), ModelingMorphism( HC, iota ) ), b );
                    
                end );
            fi;
            
        else
            
            SetRangeCategoryOfHomomorphismStructure( D, HC );
            
            if "DistinguishedObjectOfHomomorphismStructure" in list_of_operations_to_install then
                AddDistinguishedObjectOfHomomorphismStructure( D,
                  function( cat )
                    
                    return DistinguishedObjectOfHomomorphismStructure( ModelingCategory( cat ) );
                    
                end );
            fi;
            
            if "HomomorphismStructureOnObjects" in list_of_operations_to_install then
                AddHomomorphismStructureOnObjects( D,
                  function( cat, a, b )
                    
                    return HomomorphismStructureOnObjects( ModelingCategory( cat ), ModelingObject( cat, a ), ModelingObject( cat, b ) );
                    
                end );
            fi;
            
            if "HomomorphismStructureOnMorphismsWithGivenObjects" in list_of_operations_to_install then
                AddHomomorphismStructureOnMorphismsWithGivenObjects( D,
                  function( cat, s, alpha, beta, r )
                    
                    return HomomorphismStructureOnMorphismsWithGivenObjects( ModelingCategory( cat ), s, ModelingMorphism( cat, alpha ), ModelingMorphism( cat, beta ), r );
                    
                end );
            fi;
            
            if "InterpretMorphismAsMorphismFromDistinguishedObjectToHomomorphismStructure" in list_of_operations_to_install then
                AddInterpretMorphismAsMorphismFromDistinguishedObjectToHomomorphismStructure( D,
                  function( cat, alpha )
                    
                    return InterpretMorphismAsMorphismFromDistinguishedObjectToHomomorphismStructure( ModelingCategory( cat ), ModelingMorphism( cat, alpha ) );
                    
                end );
            fi;
            
            if "InterpretMorphismAsMorphismFromDistinguishedObjectToHomomorphismStructureWithGivenObjects" in list_of_operations_to_install then
                AddInterpretMorphismAsMorphismFromDistinguishedObjectToHomomorphismStructureWithGivenObjects( D,
                  function( cat, s, alpha, r )
                    
                    return InterpretMorphismAsMorphismFromDistinguishedObjectToHomomorphismStructureWithGivenObjects( ModelingCategory( cat ), s, ModelingMorphism( cat, alpha ), r );
                    
                end );
            fi;
            
            if "InterpretMorphismFromDistinguishedObjectToHomomorphismStructureAsMorphism" in list_of_operations_to_install then
                AddInterpretMorphismFromDistinguishedObjectToHomomorphismStructureAsMorphism( D,
                  function( cat, a, b, iota )
                    
                    return ModeledMorphism( cat, a, InterpretMorphismFromDistinguishedObjectToHomomorphismStructureAsMorphism( ModelingCategory( cat ), ModelingObject( cat, a ), ModelingObject( cat, b ), iota ), b );
                    
                end );
            fi;
            
        fi;
        
    fi;
    
    Finalize( D );
    
    return D;
    
end );

##
InstallMethod( WrappingFunctor,
        "for a wrapper category",
        [ IsWrapperCapCategory ],
        
  function( W )
    local C, name, Id;
    
    C := ModelingCategory( W );
    
    name := Concatenation( "Wrapper functor from ", Name( C ), " to its wrapper category ", Name( W ) );
    
    Id := CapFunctor( name, C, W );
    
    AddObjectFunction( Id,
      function ( objC )
        
        return ObjectConstructor( W, objC );
        
    end );
    
    AddMorphismFunction( Id,
      function ( s, morC, r )
        
        return MorphismConstructor( W, s, morC, r );
        
    end );
    
    return Id;
    
end );

##################################
##
## View & Display
##
##################################

##
InstallMethod( Display,
        "for an object in a wrapper CAP category",
        [ IsWrapperCapCategoryObject ],
        
  function( a )
    
    Display( ObjectDatum( a ) );
    
    Print( "\nAn object in ", Name( CapCategory( a ) ), " given by the above data\n" );
    
end );

##
InstallMethod( Display,
        "for a morphism in a wrapper CAP category",
        [ IsWrapperCapCategoryMorphism ],
        
  function( phi )
    
    Display( MorphismDatum( phi ) );
    
    Print( "\nA morphism in ", Name( CapCategory( phi ) ), " given by the above data\n" );
    
end );
