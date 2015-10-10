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
InstallGlobalFunction( CAP_INTERNAL_CREATE_STRUCTURE_FUNCTIONS_OF_UNIVERSAL_OBJECTS,
  function( structure_record )
   local underlying_category, list_of_installed_operations, object_filter, morphism_filter_of_underlying_category,
         lift_operation, category_with_attributes, object_filter_of_underlying_category, morphism_filter, filter_list, operation;
   
   underlying_category := structure_record.underlying_category;
   
   category_with_attributes := structure_record.category_with_attributes;
   
   list_of_installed_operations := ListInstalledOperationsOfCategory( underlying_category );
   
   object_filter := ObjectFilter( structure_record.category_with_attributes );
   
   object_filter_of_underlying_category := ObjectFilter( underlying_category );
   
   morphism_filter_of_underlying_category := MorphismFilter( underlying_category );
   
   morphism_filter := MorphismFilter( category_with_attributes );
   
   lift_operation := structure_record.lift_attributes_cache_operation;
   
   if IsBound( lift_operation ) then
       
       if not IsBound( structure_record.kernel_object_attributes_function )
          and "KernelEmbedding" in list_of_installed_operations then
           
           filter_list := [ morphism_filter, object_filter_of_underlying_category ];
           
           operation := NewOperation( "CategoryWithAttributesKernelObjectAttributesOperation", filter_list );
           
           InstallMethodWithCache( operation, filter_list,
             function( kernel_diagram, kernel_object )
               
               return lift_operation( KernelEmbedding( UnderlyingMorphism( kernel_diagram ) ), Source( kernel_diagram ) );
               
           end );
           
           structure_record.kernel_object_cache_operation := operation;
           
       fi;
       
       if not IsBound( structure_record.image_object_attributes_function )
          and "ImageEmbedding" in list_of_installed_operations then
           
           filter_list := [ morphism_filter, object_filter_of_underlying_category ];
           
           operation := NewOperation( "CategoryWithAttributesImageObjectAttributesOperation", filter_list );
           
           InstallMethodWithCache( operation, filter_list,
             function( image_diagram, image_object )
               
               return lift_operation( ImageEmbedding( UnderlyingMorphism( image_diagram ) ), Range( image_diagram ) );
               
           end );
           
           structure_record.image_object_cache_operation := operation;
           
       fi;
       
       if  not IsBound( structure_record.fiber_product_attributes_function )
           and "FiberProductEmbeddingInDirectSum" in list_of_installed_operations then
           
           filter_list := [ IsList, object_filter_of_underlying_category ];
           
           operation := NewOperation( "CategoryWithAttributesFiberProductAttributesOperation", filter_list );
           
           InstallMethodWithCache( operation, filter_list,
             function( diagram, fiber_product )
               local underlying_diagram, direct_sum_diagram;
               
               underlying_diagram := List( diagram, UnderlyingMorphism );
               
               direct_sum_diagram := List( diagram, Source );
               
               return lift_operation( FiberProductEmbeddingInDirectSum( underlying_diagram ),
                                      DirectSum( direct_sum_diagram ) );
               
           end );
           
           structure_record.fiber_product_cache_operation := operation;
           
       fi;
   fi;
   
end );

##
InstallGlobalFunction( CAP_INTERNAL_EQUIP_STRUCTURE_FUNCTIONS_WITH_CACHE_FOR_CATEGORY_WITH_ATTRIBUTES,
  function( structure_record )
    local entry, operation;
    
    for entry in structure_record.structure_function_list do
        
        if IsBound( structure_record.(entry[1]) ) then
            
            operation := NewOperation( entry[3], entry[4] );
            
            InstallMethodWithCache( operation, entry[4], structure_record.(entry[1]) );
            
            structure_record.(entry[2]) := operation;
        fi;
        
    od;
    
end );

##
InstallGlobalFunction( CAP_INTERNAL_CREATE_STRUCTURE_FUNCTION_LIST,
  function( structure_record )
    local object_filter, morphism_filter, object_filter_of_underlying_category, morphism_filter_of_underlying_category, structure_function_list;
    
    object_filter := ObjectFilter( structure_record.category_with_attributes );
    
    object_filter_of_underlying_category := ObjectFilter( structure_record.underlying_category );
    
    morphism_filter := MorphismFilter( structure_record.category_with_attributes );
    
    morphism_filter_of_underlying_category := MorphismFilter( structure_record.underlying_category );
    
    ## TODO: convert this to a record and use it to simplify CAP_INTERNAL_CREATE_STRUCTURE_FUNCTIONS_OF_UNIVERSAL_OBJECTS
    structure_function_list :=
      [ 
        [ "direct_sum_attributes_function",
          "direct_sum_attributes_cache_operation",
          "CategoryWithAttributesDirectSumAttributesOperation",
          [ IsList, object_filter_of_underlying_category ] ],
        
        [ "zero_object_attributes_function",
          "zero_object_attributes_cache_operation",
          "CategoryWithAttributesZeroObjectAttributesOperation",
          [ object_filter_of_underlying_category ] ],
        
        [ "lift_attributes_function",
          "lift_attributes_cache_operation",
          "CategoryWithAttributesLiftAttributesOperation",
          [ morphism_filter_of_underlying_category, object_filter ] ],
        
        [ "colift_attributes_function",
          "colift_attributes_cache_operation",
          "CategoryWithAttributesColiftAttributesOperation",
          [ morphism_filter_of_underlying_category, object_filter ] ],
        
        [ "kernel_object_attributes_function",
          "kernel_object_cache_operation",
          "CategoryWithAttributesKernelObjectAttributesOperation",
          [ morphism_filter, object_filter_of_underlying_category ] ],
        
        [ "image_object_attributes_function",
          "image_object_cache_operation",
          "CategoryWithAttributesImageObjectAttributesOperation",
          [ morphism_filter, object_filter_of_underlying_category ] ],
        
        [ "fiber_product_attributes_function",
          "fiber_product_cache_operation",
          "CategoryWithAttributesFiberProductAttributesOperation",
          [ IsList, object_filter_of_underlying_category ] ],
      ];
    
    structure_record.structure_function_list := structure_function_list;
    
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
    
    CAP_INTERNAL_CREATE_STRUCTURE_FUNCTION_LIST( structure_record );
    
    ## equip given functions with cache
    CAP_INTERNAL_EQUIP_STRUCTURE_FUNCTIONS_WITH_CACHE_FOR_CATEGORY_WITH_ATTRIBUTES( structure_record );
    
    ##
    CAP_INTERNAL_CREATE_STRUCTURE_FUNCTIONS_OF_UNIVERSAL_OBJECTS( structure_record );
    
    ## install Adds
    CAP_INTERNAL_INSTALL_ADDS_FOR_CATEGORY_WITH_ATTRIBUTES( structure_record );
    
    return category_with_attributes;
    
end );