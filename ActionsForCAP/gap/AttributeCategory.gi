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
InstallValue( CAP_INTERNAL_STRUCTURE_FUNCTION_RECORD_FOR_CATEGORY_WITH_ATTRIBUTES, rec(
  DirectSum := rec(
      function_name := "direct_sum_attributes_function",
      operation_name := "direct_sum_attributes_cache_operation",
      installation_name := "CategoryWithAttributesDirectSumAttributesOperation",
      filter_list := [ "list", "object_filter_of_underlying_category" ] ),
  
  ZeroObject := rec(
      function_name := "zero_object_attributes_function",
      operation_name := "zero_object_attributes_cache_operation",
      installation_name := "CategoryWithAttributesZeroObjectAttributesOperation",
      filter_list := [ "object_filter_of_underlying_category" ] ),
   
   Lift := rec(
      function_name := "lift_attributes_function",
      operation_name := "lift_attributes_cache_operation",
      installation_name := "CategoryWithAttributesLiftAttributesOperation",
      filter_list := [ "morphism_filter_of_underlying_category", "object_filter" ] ),
    
    Colift := rec(
      function_name := "colift_attributes_function",
      operation_name := "colift_attributes_cache_operation",
      installation_name := "CategoryWithAttributesColiftAttributesOperation",
      filter_list := [ "morphism_filter_of_underlying_category", "object_filter" ] ),
    
    KernelObject := rec(
      function_name := "kernel_object_attributes_function",
      operation_name := "kernel_object_cache_operation",
      installation_name := "CategoryWithAttributesKernelObjectAttributesOperation",
      filter_list := [ "morphism_filter", "object_filter_of_underlying_category" ] ),
    
    ImageObject := rec(
      function_name := "image_object_attributes_function",
      operation_name := "image_object_cache_operation",
      installation_name := "CategoryWithAttributesImageObjectAttributesOperation",
      filter_list := [ "morphism_filter", "object_filter_of_underlying_category" ] ),
    
    FiberProduct := rec( 
      function_name := "fiber_product_attributes_function",
      operation_name := "fiber_product_cache_operation",
      installation_name := "CategoryWithAttributesFiberProductAttributesOperation",
      filter_list := [ "list", "object_filter_of_underlying_category" ] )
  )
);

InstallGlobalFunction( CAP_INTERNAL_CREATE_FILTER_LIST_FOR_CATEGORY_WITH_ATTRIBUTES,
  function( list, category_with_attributes )
    local object_filter, object_filter_of_underlying_category,
          morphism_filter, morphism_filter_of_underlying_category, return_list, entry;
    
    object_filter := ObjectFilter( category_with_attributes );
    
    object_filter_of_underlying_category := ObjectFilter( UnderlyingCategory( category_with_attributes ) );
    
    morphism_filter := MorphismFilter( category_with_attributes );
    
    morphism_filter_of_underlying_category := MorphismFilter( UnderlyingCategory( category_with_attributes ) );
    
    return_list := [];
    
    for entry in list do
        
        if entry = "list" then
            
            Add( return_list, IsList );
            
        elif entry = "object_filter_of_underlying_category" then
            
            Add( return_list, object_filter_of_underlying_category );
            
        elif entry = "morphism_filter_of_underlying_category" then
            
            Add( return_list, morphism_filter_of_underlying_category );
            
        elif entry = "object_filter" then
            
            Add( return_list, object_filter );
            
        elif entry = "morphism_filter" then
            
            Add( return_list, morphism_filter );
            
        fi;
        
    od;
    
    return return_list;
    
end );

##
InstallGlobalFunction( CAP_INTERNAL_INSTALL_ADDS_FOR_CATEGORY_WITH_ATTRIBUTES,
  function( structure_record )
    local category_with_attributes, object_constructor, morphism_constructor,
          direct_sum_attributes_operation;
    
    category_with_attributes := structure_record.category_with_attributes;
    
    object_constructor := structure_record.object_constructor;
    
    morphism_constructor := structure_record.morphism_constructor;
    
    
    ## Example: DirectSum
    
    direct_sum_attributes_operation := structure_record.direct_sum_attributes_cache_operation;
    
    AddDirectSum( category_with_attributes,
      function( obj_list )
        local direct_sum, direct_sum_attributes;
        
        direct_sum := DirectSum( List( obj_list, ObjectWithoutAttributes ) );
        
        direct_sum_attributes := direct_sum_attributes_operation( obj_list, direct_sum );
        
        return CallFuncList( object_constructor, [ direct_sum, direct_sum_attributes ] );
        
    end );
    
end );

##
InstallGlobalFunction( CAP_INTERNAL_DERIVE_STRUCTURE_FUNCTIONS_OF_UNIVERSAL_OBJECTS,
  function( structure_record )
    local list_of_installed_operations,
          lift_operation, function_record, derivation_record, rec_names, current_name, function_record_entry, filter_list, operation;
    
    list_of_installed_operations := ListInstalledOperationsOfCategory( structure_record.underlying_category );
    
    lift_operation := structure_record.lift_attributes_cache_operation;
    
    function_record := CAP_INTERNAL_STRUCTURE_FUNCTION_RECORD_FOR_CATEGORY_WITH_ATTRIBUTES;
    
    derivation_record := rec( );
    
    if IsBound( lift_operation ) then
        
        derivation_record.KernelObject := rec(
          uses := [ "KernelEmbedding" ],
          derivation := function( kernel_diagram, kernel_object )
              
              return lift_operation( KernelEmbedding( UnderlyingMorphism( kernel_diagram ) ), Source( kernel_diagram ) );
              
        end );
        
        derivation_record.ImageObject := rec(
          uses := [ "ImageEmbedding" ],
          derivation := function( image_diagram, image_object )
              
              return lift_operation( ImageEmbedding( UnderlyingMorphism( image_diagram ) ), Range( image_diagram ) );
              
        end );
        
        derivation_record.FiberProduct := rec(
          uses := [ "FiberProductEmbeddingInDirectSum", "DirectSum" ],
          derivation := function( diagram, fiber_product )
              local underlying_diagram, direct_sum_diagram;
              
              underlying_diagram := List( diagram, UnderlyingMorphism );
              
              direct_sum_diagram := List( diagram, Source );
              
              return lift_operation( FiberProductEmbeddingInDirectSum( underlying_diagram ),
                                      DirectSum( direct_sum_diagram ) );
              
        end );
        
    fi;
    
    rec_names := RecNames( derivation_record );
    
    for current_name in rec_names do
        
        function_record_entry := function_record.(current_name);
        
        if not IsBound( structure_record.(function_record_entry.function_name) )
           and ForAll( derivation_record.(current_name).uses, f -> f in list_of_installed_operations ) then
            
            filter_list := CAP_INTERNAL_CREATE_FILTER_LIST_FOR_CATEGORY_WITH_ATTRIBUTES(
                             function_record_entry.filter_list, structure_record.category_with_attributes );
            
            operation := NewOperation( function_record_entry.installation_name, filter_list );
            
            InstallMethodWithCache( operation, filter_list, derivation_record.(current_name).derivation );
            
            structure_record.(function_record_entry.operation_name) := operation;
        fi;
        
    od;
    
end );

##
InstallGlobalFunction( CAP_INTERNAL_EQUIP_STRUCTURE_FUNCTIONS_WITH_CACHE_FOR_CATEGORY_WITH_ATTRIBUTES,
  function( structure_record )
    local rec_names, current_name, entry, filter_list, operation;
    
    rec_names := RecNames( CAP_INTERNAL_STRUCTURE_FUNCTION_RECORD_FOR_CATEGORY_WITH_ATTRIBUTES );
    
    for current_name in rec_names do
        
        entry := CAP_INTERNAL_STRUCTURE_FUNCTION_RECORD_FOR_CATEGORY_WITH_ATTRIBUTES.(current_name);
        
        if IsBound( structure_record.(entry.function_name) ) then
            
            filter_list := CAP_INTERNAL_CREATE_FILTER_LIST_FOR_CATEGORY_WITH_ATTRIBUTES( 
                             entry.filter_list, structure_record.category_with_attributes );
            
            operation := NewOperation( entry.installation_name, filter_list );
            
            InstallMethodWithCache( operation, filter_list, structure_record.(entry.function_name) );
            
            structure_record.(entry.operation_name) := operation;
        fi;
        
    od;
    
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
    
    SetUnderlyingCategory( category_with_attributes, structure_record.underlying_category );
    
    structure_record.category_with_attributes := category_with_attributes;
    
    ## create constructors for objects and morphisms
    if not IsBound( structure_record.object_constructor ) then
        CAP_INTERNAL_CREATE_OBJECT_CONSTRUCTOR_FOR_CATEGORY_WITH_ATTRIBUTES( structure_record );
    fi;
    
    if not IsBound( structure_record.morphism_constructor ) then
        CAP_INTERNAL_CREATE_MORPHISM_CONSTRUCTOR_FOR_CATEGORY_WITH_ATTRIBUTES( structure_record );
    fi;
    
    ## equip given functions with cache
    CAP_INTERNAL_EQUIP_STRUCTURE_FUNCTIONS_WITH_CACHE_FOR_CATEGORY_WITH_ATTRIBUTES( structure_record );
    
    ## 
    CAP_INTERNAL_DERIVE_STRUCTURE_FUNCTIONS_OF_UNIVERSAL_OBJECTS( structure_record );
    
    ## install Adds
    CAP_INTERNAL_INSTALL_ADDS_FOR_CATEGORY_WITH_ATTRIBUTES( structure_record );
    
    return category_with_attributes;
    
end );