# SPDX-License-Identifier: GPL-2.0-or-later
# CAP: Categories, Algorithms, Programming
#
# Implementations
#

##
InstallMethodWithCache( AsObjectInWrapperCategory,
        "for a wrapper CAP category and a CAP object",
        [ IsWrapperCapCategory, IsCapCategoryObject ],
        
  function( D, object )
    
    CAP_INTERNAL_ASSERT_IS_OBJECT_OF_CATEGORY( object, UnderlyingCategory( D ), {} -> "the object given to AsObjectInWrapperCategory" );
    
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
    
    CAP_INTERNAL_ASSERT_IS_MORPHISM_OF_CATEGORY( morphism, UnderlyingCategory( D ), {} -> "the morphism given to AsMorphismInWrapperCategory" );
    
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
    
    return ( data / UnderlyingCategory( C ) ) / C;
    
end );

##
InstallMethod( \/,
        "for a CAP category object and a wrapper CAP category",
         [ IsCapCategoryObject, IsWrapperCapCategory ],
        
  function( object, cat )
    
    if not IsIdenticalObj( CapCategory( object ), UnderlyingCategory( cat ) ) then
        TryNextMethod( );
    fi;
    
    return AsObjectInWrapperCategory( cat, object );
    
end );

##
InstallMethod( \/,
        "for a CAP category morphism and a wrapper CAP category",
        [ IsCapCategoryMorphism, IsWrapperCapCategory ],
        
  function( morphism, cat )
    
    if not IsIdenticalObj( CapCategory( morphism ), UnderlyingCategory( cat ) ) then
        TryNextMethod( );
    fi;
    
    return AsMorphismInWrapperCategory( cat, morphism );
    
end );

##
InstallMethod( WrapperCategory,
        "for a CAP category and a record of options",
        [ IsCapCategory, IsRecord ],
        
  function( C, options )
    local known_options_with_filters, filter, category_constructor_options, copy_value_or_default, list_of_operations_to_install, D, HC, option_name;
    
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
    
    category_constructor_options := rec(
        underlying_category_getter_string := "UnderlyingCategory",
        underlying_object_getter_string := "ObjectDatum",
        underlying_morphism_getter_string := "MorphismDatum",
        generic_output_source_getter_string := "ObjectConstructor( cat, Source( underlying_result ) )",
        generic_output_range_getter_string := "ObjectConstructor( cat, Range( underlying_result ) )",
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
    
    copy_value_or_default( options, category_constructor_options, "category_filter", IsWrapperCapCategory );
    copy_value_or_default( options, category_constructor_options, "category_object_filter", IsWrapperCapCategoryObject );
    copy_value_or_default( options, category_constructor_options, "category_morphism_filter", IsWrapperCapCategoryMorphism );
    copy_value_or_default( options, category_constructor_options, "object_constructor", AsObjectInWrapperCategory );
    copy_value_or_default( options, category_constructor_options, "object_datum", { D, o } -> UnderlyingCell( o ) );
    copy_value_or_default( options, category_constructor_options, "morphism_constructor", AsMorphismInWrapperCategory );
    copy_value_or_default( options, category_constructor_options, "morphism_datum", { D, m } -> UnderlyingCell( m ) );
    
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
    
    D!.compiler_hints := rec(
        category_attribute_names := [
            "UnderlyingCategory",
        ],
    );
    
    SetUnderlyingCategory( D, C );
    
    if "BasisOfExternalHom" in list_of_operations_to_install then
        
        AddBasisOfExternalHom( D,
          function( cat, a, b )
            
            return List( BasisOfExternalHom( UnderlyingCategory( cat ), ObjectDatum( cat, a ), ObjectDatum( cat, b ) ),
                         mor -> MorphismConstructor( cat, a, mor, b ) );
            
        end );
        
    fi;
    
    if "CoefficientsOfMorphismWithGivenBasisOfExternalHom" in list_of_operations_to_install then
        
        AddCoefficientsOfMorphismWithGivenBasisOfExternalHom( D,
          function( cat, alpha, L )
            
            return CoefficientsOfMorphismWithGivenBasisOfExternalHom( UnderlyingCategory( cat ),
                           MorphismDatum( cat, alpha ),
                           List( L, l -> MorphismDatum( cat, l ) ) );
            
        end );
        
    fi;
    
    if HasRangeCategoryOfHomomorphismStructure( C ) then
        
        HC := RangeCategoryOfHomomorphismStructure( C );
        
        if IsBound( options.wrap_range_of_hom_structure ) and options.wrap_range_of_hom_structure and not IsWrapperCapCategory( HC ) then
            
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
                    
                    return ObjectConstructor( HC, DistinguishedObjectOfHomomorphismStructure( UnderlyingCategory( cat ) ) );
                    
                end );
            fi;
            
            if "HomomorphismStructureOnObjects" in list_of_operations_to_install then
                AddHomomorphismStructureOnObjects( D,
                  function( cat, a, b )
                    
                    return ObjectConstructor( HC, HomomorphismStructureOnObjects( UnderlyingCategory( cat ), ObjectDatum( cat, a ), ObjectDatum( cat, b ) ) );
                    
                end );
            fi;
            
            if "HomomorphismStructureOnMorphismsWithGivenObjects" in list_of_operations_to_install then
                AddHomomorphismStructureOnMorphismsWithGivenObjects( D,
                  function( cat, s, alpha, beta, r )
                    
                    return MorphismConstructor( HC, s, HomomorphismStructureOnMorphismsWithGivenObjects( UnderlyingCategory( cat ), ObjectDatum( HC, s ), MorphismDatum( cat, alpha ), MorphismDatum( cat, beta ), ObjectDatum( HC, r ) ), r );
                    
                end );
            fi;
            
            if "InterpretMorphismAsMorphismFromDistinguishedObjectToHomomorphismStructureWithGivenObjects" in list_of_operations_to_install then
                AddInterpretMorphismAsMorphismFromDistinguishedObjectToHomomorphismStructureWithGivenObjects( D,
                  function( cat, s, alpha, r )
                    
                    return MorphismConstructor( HC, s, InterpretMorphismAsMorphismFromDistinguishedObjectToHomomorphismStructureWithGivenObjects( UnderlyingCategory( cat ), ObjectDatum( HC, s ), MorphismDatum( cat, alpha ), ObjectDatum( HC, r ) ), r );
                    
                end );
            fi;
            
            if "InterpretMorphismFromDistinguishedObjectToHomomorphismStructureAsMorphism" in list_of_operations_to_install then
                AddInterpretMorphismFromDistinguishedObjectToHomomorphismStructureAsMorphism( D,
                  function( cat, a, b, iota )
                    
                    return MorphismConstructor( cat, a, InterpretMorphismFromDistinguishedObjectToHomomorphismStructureAsMorphism( UnderlyingCategory( cat ), ObjectDatum( cat, a ), ObjectDatum( cat, b ), MorphismDatum( HC, iota ) ), b );
                    
                end );
            fi;
            
        else
            
            SetRangeCategoryOfHomomorphismStructure( D, HC );
            
            if "DistinguishedObjectOfHomomorphismStructure" in list_of_operations_to_install then
                AddDistinguishedObjectOfHomomorphismStructure( D,
                  function( cat )
                    
                    return DistinguishedObjectOfHomomorphismStructure( UnderlyingCategory( cat ) );
                    
                end );
            fi;
            
            if "HomomorphismStructureOnObjects" in list_of_operations_to_install then
                AddHomomorphismStructureOnObjects( D,
                  function( cat, a, b )
                    
                    return HomomorphismStructureOnObjects( UnderlyingCategory( cat ), ObjectDatum( cat, a ), ObjectDatum( cat, b ) );
                    
                end );
            fi;
            
            if "HomomorphismStructureOnMorphismsWithGivenObjects" in list_of_operations_to_install then
                AddHomomorphismStructureOnMorphismsWithGivenObjects( D,
                  function( cat, s, alpha, beta, r )
                    
                    return HomomorphismStructureOnMorphismsWithGivenObjects( UnderlyingCategory( cat ), s, MorphismDatum( cat, alpha ), MorphismDatum( cat, beta ), r );
                    
                end );
            fi;
            
            if "InterpretMorphismAsMorphismFromDistinguishedObjectToHomomorphismStructure" in list_of_operations_to_install then
                AddInterpretMorphismAsMorphismFromDistinguishedObjectToHomomorphismStructure( D,
                  function( cat, alpha )
                    
                    return InterpretMorphismAsMorphismFromDistinguishedObjectToHomomorphismStructure( UnderlyingCategory( cat ), MorphismDatum( cat, alpha ) );
                    
                end );
            fi;
            
            if "InterpretMorphismAsMorphismFromDistinguishedObjectToHomomorphismStructureWithGivenObjects" in list_of_operations_to_install then
                AddInterpretMorphismAsMorphismFromDistinguishedObjectToHomomorphismStructureWithGivenObjects( D,
                  function( cat, s, alpha, r )
                    
                    return InterpretMorphismAsMorphismFromDistinguishedObjectToHomomorphismStructureWithGivenObjects( UnderlyingCategory( cat ), s, MorphismDatum( cat, alpha ), r );
                    
                end );
            fi;
            
            if "InterpretMorphismFromDistinguishedObjectToHomomorphismStructureAsMorphism" in list_of_operations_to_install then
                AddInterpretMorphismFromDistinguishedObjectToHomomorphismStructureAsMorphism( D,
                  function( cat, a, b, iota )
                    
                    return MorphismConstructor( cat, a, InterpretMorphismFromDistinguishedObjectToHomomorphismStructureAsMorphism( UnderlyingCategory( cat ), ObjectDatum( cat, a ), ObjectDatum( cat, b ), iota ), b );
                    
                end );
            fi;
            
        fi;
        
    fi;
    
    Finalize( D );
    
    return D;
    
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
    
    Display( "\nAn object given by the above data" );
    
end );

##
InstallMethod( Display,
        "for a morphism in a wrapper CAP category",
        [ IsWrapperCapCategoryMorphism ],
        
  function( phi )
    
    Display( MorphismDatum( phi ) );
    
    Display( "\nA morphism given by the above data" );
    
end );
