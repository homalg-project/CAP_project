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
    CAP_INTERNAL_ASSERT_IS_OBJECT_OF_CATEGORY( object, ModelingCategory( D ), [ "the object given to AsObjectInWrapperCategory" ] );
    
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
    CAP_INTERNAL_ASSERT_IS_MORPHISM_OF_CATEGORY( morphism, ModelingCategory( D ), [ "the morphism given to AsMorphismInWrapperCategory" ] );
    
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
InstallOtherMethod( \/,
        "for a CAP category object and a wrapper CAP category",
         [ IsCapCategoryObject, IsWrapperCapCategory ],
        
  function( object, cat )
    
    if not IsIdenticalObj( CapCategory( object ), ModelingCategory( cat ) ) then
        TryNextMethod( );
    fi;
    
    return AsObjectInWrapperCategory( cat, object );
    
end );

##
InstallOtherMethod( \/,
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
    local combined_options, known_options_with_filters, filter, reinterpretation_options, option_name;
    
    # options which should either all or none be set for consistency and will be delegated to ReinterpretationOfCategory if set
    combined_options := [
        "object_constructor",
        "object_datum",
        "morphism_constructor",
        "morphism_datum",
        "modeling_tower_object_constructor",
        "modeling_tower_object_datum",
        "modeling_tower_morphism_constructor",
        "modeling_tower_morphism_datum",
    ];
    
    if Length( Set( List( combined_options, name -> IsBound( options.(name) ) ) ) ) > 1 then
        
        Display( "WARNING: To avoid inconsistencies, either all or none of the following options should be set in a call to `WrapperCategory`. This is not the case." );
        Display( combined_options );
        
    fi;
    
    if IsBound( options.wrap_range_of_hom_structure ) then
        
        if options.wrap_range_of_hom_structure and not IsIdenticalObj( C, RangeCategoryOfHomomorphismStructure( C ) ) then
            
            Error( "Wrapping the range of the hom structure is not supported anymore (except if the category has itself as the range of its hom structure). Please remove `wrap_range_of_hom_structure`." );
            
        fi;
        
        if not options.wrap_range_of_hom_structure and IsIdenticalObj( C, RangeCategoryOfHomomorphismStructure( C ) ) then
            
            Error( "If the category has itself as the range of its hom structure, the range of the hom structure is always wrapped. Please remove `wrap_range_of_hom_structure`." );
            
        fi;
        
        options := ShallowCopy( options );
        Unbind( options.wrap_range_of_hom_structure );
        
        Print( "WARNING: The option wrap_range_of_hom_structure is deprecated and will not be supported after 2024.05.02.\n" );
        
    fi;
    
    if IsBound( options.object_constructor ) then
        
        Print( "WARNING: Setting object_constructor etc. for WrapperCategory is deprecated and will not be supported after 2024.05.02. Use ReinterpretationOfCategory instead.\n" );
        
        return ReinterpretationOfCategory( C, options );
        
    fi;
    
    ## check given options
    known_options_with_filters := rec(
        name := IsString,
        category_filter := IsFilter,
        category_object_filter := IsFilter,
        category_morphism_filter := IsFilter,
        only_primitive_operations := IsBool,
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
    
    reinterpretation_options := rec(
        object_datum_type := CapJitDataTypeOfObjectOfCategory( C ),
        morphism_datum_type := CapJitDataTypeOfMorphismOfCategory( C ),
        object_constructor := { cat, d } -> AsObjectInWrapperCategory( cat, d ),
        object_datum := { D, o } -> UnderlyingCell( o ),
        morphism_constructor := { D, s, d, t } -> AsMorphismInWrapperCategory( D, s, d, t ),
        morphism_datum := { D, m } -> UnderlyingCell( m ),
        modeling_tower_object_constructor := { D, d } -> d,
        modeling_tower_object_datum := { D, o } -> o,
        modeling_tower_morphism_constructor := { D, s, d, t } -> d,
        modeling_tower_morphism_datum := { D, m } -> m,
    );
    
    if IsBound( options.name ) then
        
        reinterpretation_options.name := options.name;
        
    elif HasName( C ) then
        
        reinterpretation_options.name := Concatenation( "WrapperCategory( ", Name( C ), " )" );
        
    fi;
    
    if IsBound( options.category_filter ) then
        
        if not IsSpecializationOfFilter( IsWrapperCapCategory, options.category_filter ) then
            
            Error( "<options.category_filter> must imply IsWrapperCapCategory" );
            
        fi;
        
        reinterpretation_options.category_filter := options.category_filter;
        
    else
        
        reinterpretation_options.category_filter := IsWrapperCapCategory;
        
    fi;
    
    if IsBound( options.category_object_filter ) then
        
        if not IsSpecializationOfFilter( IsWrapperCapCategoryObject, options.category_object_filter ) then
            
            Error( "<options.category_object_filter> must imply IsWrapperCapCategoryObject" );
            
        fi;
        
        reinterpretation_options.category_object_filter := options.category_object_filter;
        
    else
        
        reinterpretation_options.category_object_filter := IsWrapperCapCategoryObject;
        
    fi;
    
    if IsBound( options.category_morphism_filter ) then
        
        if not IsSpecializationOfFilter( IsWrapperCapCategoryMorphism, options.category_morphism_filter ) then
            
            Error( "<options.category_morphism_filter> must imply IsWrapperCapCategoryMorphism" );
            
        fi;
        
        reinterpretation_options.category_morphism_filter := options.category_morphism_filter;
        
    else
        
        reinterpretation_options.category_morphism_filter := IsWrapperCapCategoryMorphism;
        
    fi;
    
    if IsBound( options.only_primitive_operations ) then
        
        reinterpretation_options.only_primitive_operations := options.only_primitive_operations;
        
    fi;
    
    return ReinterpretationOfCategory( C, reinterpretation_options );
    
end );

##
InstallMethod( WrappingFunctor,
        "for a wrapper category",
        [ IsWrapperCapCategory ],
        
  function( W )
    
    return ReinterpretationFunctor( W );
    
end );

##################################
##
## View & Display
##
##################################

##
InstallMethod( DisplayString,
        "for an object in a wrapper CAP category",
        [ IsWrapperCapCategoryObject ],
        
  function( a )
    
    return Concatenation( DisplayString( ObjectDatum( a ) ), "\nAn object in ", Name( CapCategory( a ) ), " given by the above data\n" );
    
end );

##
InstallMethod( DisplayString,
        "for a morphism in a wrapper CAP category",
        [ IsWrapperCapCategoryMorphism ],
        
  function( phi )
    
    return Concatenation( DisplayString( MorphismDatum( phi ) ), "\nA morphism in ", Name( CapCategory( phi ) ), " given by the above data\n" );
    
end );
