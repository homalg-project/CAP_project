#############################################################################
##
##                                ActionsForCAP package
##
##  Copyright 2015, Sebastian Gutsche, TU Kaiserslautern
##                  Sebastian Posur,   RWTH Aachen
##
##
#############################################################################

##
InstallGlobalFunction( CAP_INTERNAL_INSTALL_ADDS_FOR_CATEGORY_WITH_ATTRIBUTES,
  function( structure_record )
    local category_with_attributes, object_constructor, morphism_constructor,
          direct_sum_attributes_operation;
    
    category_with_attributes := structure_record.category_with_attributes;
    
    object_constructor := structure_record.object_constructor;
    
    morphism_constructor := structure_record.morphism_constructor;
    
    
    ## DirectSum
    direct_sum_attributes_operation := structure_record.direct_sum_attributes_cache_operation;
    
    AddDirectSum( category_with_attributes,
      function( obj_list )
        local direct_sum, direct_sum_attributes;
        
        direct_sum := DirectSum( List( obj_list, ObjectWithoutAttributes ) );
        
        direct_sum_attributes := direct_sum_attributes_operation( obj_list, direct_sum );
        
        return CallFuncList( object_constructor, [ direct_sum, direct_sum_attributes ] );
        
    end );
    
end );

InstallGlobalFunction( CAP_INTERNAL_EQUIP_STRUCTURE_FUNCTIONS_WITH_CACHE_FOR_CATEGORY_WITH_ATTRIBUTES,
  function( structure_record )
    local object_filter, object_filter_of_underlying_category, direct_sum_attributes_cache_operation, filter_list;
    
    object_filter := ObjectFilter( structure_record.category_with_attributes );
    
    object_filter_of_underlying_category := ObjectFilter( structure_record.underlying_category );
    
    if IsBound( structure_record.direct_sum_attributes_function ) then
        
        filter_list := [ IsList, object_filter_of_underlying_category ];
        
        direct_sum_attributes_cache_operation := 
          NewOperation( "CategoryWithAttributesDirectSumAttributeOperation",
                        filter_list );
        
        InstallMethodWithCache( direct_sum_attributes_cache_operation, filter_list,
                                structure_record.direct_sum_attributes_function );
        
        structure_record.direct_sum_attributes_cache_operation := direct_sum_attributes_cache_operation;
    fi;
    
end );

##
InstallGlobalFunction( CAP_INTERNAL_CREATE_MORPHISM_CONSTRUCTOR_FOR_CATEGORY_WITH_ATTRIBUTES,
  function( structure_record )
    local underlying_category, category_with_attributes, object_filter,
          morphism_constructor, morphism_filter_of_underlying_category;
    
    underlying_category := structure_record.underlying_category;
    
    category_with_attributes := structure_record.category_with_attributes;
    
    object_filter := ObjectFilter( category_with_attributes );
    
    morphism_filter_of_underlying_category := MorphismFilter( underlying_category );
    
    morphism_constructor :=
      NewOperation( "CategoryWithAttributesMorphismConstructorOperation", 
                    [ object_filter, morphism_filter_of_underlying_category, object_filter ] );
    
    structure_record.morphism_constructor := morphism_constructor;
    
    ##
    InstallMethod( morphism_constructor,
                   [ object_filter, morphism_filter_of_underlying_category, object_filter ],
                   
      function( source, morphism, range )
        local attribute_morphism;
        
        attribute_morphism := rec( );
        
        ObjectifyWithAttributes( attribute_morphism,  structure_record.morphism_type,
                                 UnderlyingMorphism, morphism,
                                 Source, source,
                                 Range, range,
                                 UnderlyingCategory, underlying_category
                               );
        
        Add( category_with_attributes, attribute_morphism );
        
        return attribute_morphism;
        
    end );
end );

##
InstallGlobalFunction( CAP_INTERNAL_CREATE_OBJECT_CONSTRUCTOR_FOR_CATEGORY_WITH_ATTRIBUTES,
  function( structure_record )
    local underlying_category, category_with_attributes, object_filter_of_underlying_category,
          object_constructor;
    
    underlying_category := structure_record.underlying_category;
    
    category_with_attributes := structure_record.category_with_attributes;
    
    object_filter_of_underlying_category := ObjectFilter( underlying_category );
    
    object_constructor :=
      NewOperation( "CategoryWithAttributesObjectConstructorOperation", 
                    [ object_filter_of_underlying_category, IsList ] );
    
    structure_record.object_constructor := object_constructor;
    ##
    InstallMethod( object_constructor,
                   [ object_filter_of_underlying_category, IsList ],
                   
      function( object, attributes )
        local attribute_object;
        
        attribute_object := rec( );
        
        ObjectifyWithAttributes( attribute_object, structure_record.object_type,
                                 ObjectWithoutAttributes, object,
                                 ObjectAttributesAsList, attributes,
                                 UnderlyingCategory, underlying_category
                               );
        
        Add( category_with_attributes, attribute_object );
        
        return attribute_object;
        
    end );
    
    
    
    
end );

##
InstallGlobalFunction( CreateCategoryWithAttributes,
  function( structure_record )
    local category_with_attributes;
    
    if not IsBound( structure_record.underlying_category ) then
        
        Error( "underlying_category must be bound in the given record" );
        
    fi;
    
    if not IsCapCategory( structure_record.underlying_category ) then
        
        Error( "underlying_category must be a CAP category" );
    
    fi;
    
    ## Declare GAP category for objects, morphisms
    
    ## Declare GAP representation and type of objects
    
    ## Declare attributes for the objects
    
    ## Declare GAP representation and type of morphisms
    
    ## Declare attributes for the morphisms
    
    if not IsBound( structure_record.category_name ) then
        
        structure_record.category_name := Concatenation( "Category with attributes of ", Name( structure_record.underlying_category ) );
        
    fi;
    
    category_with_attributes := CreateCapCategory( structure_record.category_name );
    
    structure_record.category_with_attributes := category_with_attributes;
    
    ## create constructors for objects and morphisms
    if not IsBound( structure_record.object_constructor ) then
        CAP_INTERNAL_CREATE_OBJECT_CONSTRUCTOR_FOR_CATEGORY_WITH_ATTRIBUTES( structure_record );
    fi;
    
    if not IsBound( structure_record.morphism_constructor ) then
        CAP_INTERNAL_CREATE_MORPHISM_CONSTRUCTOR_FOR_CATEGORY_WITH_ATTRIBUTES( structure_record );
    fi;
    ##
    
    ## equip given functions with cache
    CAP_INTERNAL_EQUIP_STRUCTURE_FUNCTIONS_WITH_CACHE_FOR_CATEGORY_WITH_ATTRIBUTES( structure_record );
    
    ## install Adds
    CAP_INTERNAL_INSTALL_ADDS_FOR_CATEGORY_WITH_ATTRIBUTES( structure_record );
    
    return category_with_attributes;
    
end );