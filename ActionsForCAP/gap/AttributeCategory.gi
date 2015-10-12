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
      operation_name := "DirectSum",
      installation_name := "CategoryWithAttributesDirectSumAttributesOperation",
      filter_list := [ "list", "object_filter_of_underlying_category" ] ),
      
  ZeroObject := rec(
      function_name := "zero_object_attributes_function",
      operation_name := "ZeroObject",
      installation_name := "CategoryWithAttributesZeroObjectAttributesOperation",
      filter_list := [ "object_filter_of_underlying_category" ] ),
      
  Lift := rec(
      function_name := "lift_attributes_function",
      operation_name := "Lift",
      installation_name := "CategoryWithAttributesLiftAttributesOperation",
      filter_list := [ "morphism_filter_of_underlying_category", "object_filter" ] ),
      
  Colift := rec(
      function_name := "colift_attributes_function",
      operation_name := "Colift",
      installation_name := "CategoryWithAttributesColiftAttributesOperation",
      filter_list := [ "morphism_filter_of_underlying_category", "object_filter" ] ),
      
  KernelObject := rec(
      function_name := "kernel_object_attributes_function",
      operation_name := "KernelObject",
      installation_name := "CategoryWithAttributesKernelObjectAttributesOperation",
      filter_list := [ "morphism_filter", "object_filter_of_underlying_category" ] ),
      
  ImageObject := rec(
      function_name := "image_object_attributes_function",
      operation_name := "ImageObject",
      installation_name := "CategoryWithAttributesImageObjectAttributesOperation",
      filter_list := [ "morphism_filter", "object_filter_of_underlying_category" ] ),
      
  FiberProduct := rec(
      function_name := "fiber_product_attributes_function",
      operation_name := "FiberProduct",
      installation_name := "CategoryWithAttributesFiberProductAttributesOperation",
      filter_list := [ "list", "object_filter_of_underlying_category" ] ),
      
  CokernelObject := rec(
      function_name := "cokernel_object_attributes_function",
      operation_name := "CokernelObject",
      installation_name := "CategoryWithAttributesCokernelObjectAttributesOperation",
      filter_list := [ "morphism_filter", "object_filter_of_underlying_category" ] ),
      
  CoimageObject := rec(
      function_name := "coimage_object_attributes_function",
      operation_name := "Coimage",
      installation_name := "CategoryWithAttributesCoimageObjectAttributesOperation",
      filter_list := [ "morphism_filter", "object_filter_of_underlying_category" ] ),
      
  Pushout := rec(
      function_name := "pushout_attributes_function",
      operation_name := "Pushout",
      installation_name := "CategoryWithAttributesPushoutAttributesOperation",
      filter_list := [ "list", "object_filter_of_underlying_category" ] ),
      
  TensorProductOnObjects := rec(
      function_name := "tensor_product_attributes_function",
      operation_name := "TensorProductOnObjects",
      installation_name := "CategoryWithAttributesTensorProductAttributesOperation",
      filter_list := [ "object_filter", "object_filter", "object_filter_of_underlying_category" ] ),
      
  TensorUnit := rec(
      function_name := "tensor_unit_attributes_function",
      operation_name := "TensorUnit",
      installation_name := "CategoryWithAttributesTensorUnitAttributesOperation",
      filter_list := [ "object_filter_of_underlying_category" ] ),
  )
);

##
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
InstallMethod( UnderlyingCell,
               [ IsList ],
               
  function( list )
      
      return List( list, elem -> UnderlyingCell( elem ) );
      
end );

##
InstallMethod( UnderlyingCell, [ IsBool ], x -> x );

##
InstallMethod( UnderlyingCell, [ IsInt ], x -> x );

##
InstallGlobalFunction( CAP_INTERNAL_INSTALL_ADDS_FOR_CATEGORY_WITH_ATTRIBUTES,
  function( structure_record )
    local category_with_attributes, underlying_category, object_constructor, morphism_constructor,
          list_of_installed_operations,
          direct_sum_attributes_operation, create_function_primitive_type, create_function_object,
          create_function_morphism_no_new_object, create_function_morphism_new_source,
          create_function_morphism_new_range, attributes, recnames, name, func, pos, function_to_add, add_function,
          create_function_object_no_arguments, universal_object;
    
    category_with_attributes := structure_record.category_with_attributes;
    
    underlying_category := structure_record.underlying_category;
    
    object_constructor := structure_record.object_constructor;
    
    morphism_constructor := structure_record.morphism_constructor;
    
    create_function_primitive_type :=
      function( operation_name )
        local operation;
        
        operation := ValueGlobal( operation_name );
        
        return
          function( arg )
            local underlying_arg;
            
            underlying_arg := List( arg, UnderlyingCell );
            
            return CallFuncList( operation, underlying_arg );
            
          end;
          
        end;
    
    create_function_object :=
      function( operation_name, attributes_function )
        local operation;
        
        operation := ValueGlobal( operation_name );
        
        return
          function( arg )
            local underlying_arg, underlying_return, attributes;
            
            underlying_arg := List( arg, UnderlyingCell );
            
            underlying_return := CallFuncList( operation, underlying_arg );
            
            attributes := CallFuncList( attributes_function, Concatenation( arg, [ underlying_return ] ) );
            
            return CallFuncList( object_constructor, [ underlying_return, attributes ] );
          
          end;
          
        end;
    
    create_function_object_no_arguments :=
      function( operation_name, attributes_function )
        local operation;
        
        operation := ValueGlobal( operation_name );
        
        return
          function( )
            local underlying_return, attributes;
            
            underlying_return := CallFuncList( operation, [ underlying_category ] );
            
            attributes := CallFuncList( attributes_function, [ underlying_return ] );
            
            return CallFuncList( object_constructor, [ underlying_return, attributes ] );
          
          end;
          
        end;
    
    create_function_morphism_no_new_object :=
      function( operation_name )
        local operation, type;
        
        operation := ValueGlobal( operation_name );
        
        type := CAP_INTERNAL_METHOD_NAME_RECORD.(operation_name).io_type;
        
        return
          function( arg )
            local underlying_arg, underlying_return, source_range_pair, source, range;
            
            underlying_arg:= List( arg, UnderlyingCell );
            
            underlying_return := CallFuncList( operation, underlying_arg );
            
            source_range_pair := CAP_INTERNAL_GET_CORRESPONDING_OUTPUT_OBJECTS( type, arg );
            
            source := source_range_pair[1];
            
            range := source_range_pair[2];
            
            return CallFuncList( morphism_constructor, [ source, underlying_return, range ] );
            
          end;
          
      end;
    
    create_function_morphism_new_source :=
      function( operation_name, attributes_function )
        local operation, type;
        
        operation := ValueGlobal( operation_name );
        
        type := CAP_INTERNAL_METHOD_NAME_RECORD.(operation_name).io_type;
        
        return
          function( arg )
            local underlying_arg, underlying_return, source_range_pair, source, range;
            
            underlying_arg:= List( arg, UnderlyingCell );
            
            underlying_return := CallFuncList( operation, underlying_arg );
            
            source_range_pair := CAP_INTERNAL_GET_CORRESPONDING_OUTPUT_OBJECTS( type, arg );
            
            range := source_range_pair[2];
            
            attributes := CallFuncList( attributes_function, Concatenation( arg, [ Source( underlying_return ) ] ) );
            
            source := CallFuncList( object_constructor, [ Source( underlying_return ), attributes ] );
            
            return CallFuncList( morphism_constructor, [ source, underlying_return, range ] );
            
          end;
          
      end;
    
    create_function_morphism_new_range :=
      function( operation_name, attributes_function )
        local operation, type;
        
        operation := ValueGlobal( operation_name );
        
        type := CAP_INTERNAL_METHOD_NAME_RECORD.(operation_name).io_type;
        
        return
          function( arg )
            local underlying_arg, underlying_return, source_range_pair, source, range;
            
            underlying_arg:= List( arg, UnderlyingCell );
            
            underlying_return := CallFuncList( operation, underlying_arg );
            
            source_range_pair := CAP_INTERNAL_GET_CORRESPONDING_OUTPUT_OBJECTS( type, arg );
            
            source := source_range_pair[1];
            
            attributes := CallFuncList( attributes_function, Concatenation( arg, [ Range( underlying_return ) ] ) );
            
            range := CallFuncList( object_constructor, [ Range( underlying_return ), attributes ] );
            
            return CallFuncList( morphism_constructor, [ source, underlying_return, range ] );
            
          end;
          
      end;
    
    recnames := ShallowCopy( ListPrimitivelyInstalledOperationsOfCategory( UnderlyingCategory( category_with_attributes ) ) );
    
    for func in [
            "IsEqualForObjects",
            "IsEqualForMorphisms",
            "IsCongruentForMorphisms",
            "IsEqualForCacheForObjects",
            "IsEqualForCacheForMorphisms"
            ] do
        
        pos := Position( recnames, func );
        if not pos = fail then
            Remove( recnames, pos );
        fi;
        
    od;
    
    for name in recnames do
        
        entry := CAP_INTERNAL_METHOD_NAME_RECORD.(name);
        
        add_function := ValueGlobal( Concatenation( "Add", name ) );
        
        if entry.return_type = "bool" 
           and IsBound( entry.is_reflected_by_faithful_functor )
           and entry.is_reflected_by_faithful_functor then
            
            function_to_add := create_function_primitive_type( name );
            
            add_function( category_with_attributes, function_to_add );
            
        elif entry.return_type = "object"
             and IsBound( structure_record.(name) ) then
             
             if entry.filter_list = [ "category" ] then
                 
                 function_to_add := create_function_object_no_arguments( name, structure_record.(name) );
                 
             else
                 
                 function_to_add := create_function_object( name, structure_record.(name) );
                 
             fi;
             
             add_function( category_with_attributes, function_to_add );
             
        elif entry.return_type = "morphism" then
            
            if not IsBound( entry.universal_type )
               or ( IsBound( entry.universal_type ) and entry.is_with_given ) then
                
                function_to_add := create_function_morphism_no_new_object( name );
                
                add_function( category_with_attributes, function_to_add );
                
            elif IsBound( entry.universal_type ) then
                
                ## TODO: this should be directly accessible in the method record
                universal_object := CAP_INTERNAL_METHOD_NAME_RECORD.(entry.with_given_without_given_name_pair[2]).universal_object;
                
                if IsBound( structure_record.(universal_object) ) then
                    
                    if entry.universal_object_position = "Source" then
                        
                        function_to_add := create_function_morphism_new_source( name, structure_record.(universal_object) );
                        
                        add_function( category_with_attributes, function_to_add );
                        
                    elif entry.universal_object_position = "Range" then
                        
                        function_to_add := create_function_morphism_new_range( name, structure_record.(universal_object) );
                        
                        add_function( category_with_attributes, function_to_add );
                        
                    fi;
                
                fi;
            fi;
            
        fi;
        
    od;
    
    
end );

##
InstallGlobalFunction( CAP_INTERNAL_DERIVE_STRUCTURE_FUNCTIONS_OF_UNIVERSAL_OBJECTS_FOR_CATEGORY_WITH_ATTRIBUTES,
  function( structure_record )
    local list_of_installed_operations, lift_operation, colift_operation, function_record, 
          derivation_record, rec_names, current_name, function_record_entry, filter_list, operation;
    
    list_of_installed_operations := ListInstalledOperationsOfCategory( structure_record.underlying_category );
    
    lift_operation := structure_record.Lift;
    
    colift_operation := structure_record.Colift;
    
    function_record := CAP_INTERNAL_STRUCTURE_FUNCTION_RECORD_FOR_CATEGORY_WITH_ATTRIBUTES;
    
    derivation_record := rec( );
    
    if IsBound( lift_operation ) then
        
        derivation_record.KernelObject := rec(
          uses := [ "KernelEmbedding" ],
          derivation := function( kernel_diagram, kernel_object )
              
              return lift_operation( KernelEmbedding( UnderlyingCell( kernel_diagram ) ), Source( kernel_diagram ) );
              
        end );
        
        derivation_record.ImageObject := rec(
          uses := [ "ImageEmbedding" ],
          derivation := function( image_diagram, image_object )
              
              return lift_operation( ImageEmbedding( UnderlyingCell( image_diagram ) ), Range( image_diagram ) );
              
        end );
        
        derivation_record.FiberProduct := rec(
          uses := [ "FiberProductEmbeddingInDirectSum", "DirectSum" ],
          derivation := function( diagram, fiber_product )
              local underlying_diagram, direct_sum_diagram;
              
              underlying_diagram := List( diagram, UnderlyingCell );
              
              direct_sum_diagram := List( diagram, Source );
              
              return lift_operation( FiberProductEmbeddingInDirectSum( underlying_diagram ),
                                      DirectSum( direct_sum_diagram ) );
              
        end );
        
    fi;
    
    if IsBound( colift_operation ) then
        
        derivation_record.CokernelObject := rec(
          uses := [ "CokernelProjection" ],
          derivation := function( cokernel_diagram, cokernel_object )
              
              return colift_operation( CokernelProjection( UnderlyingCell( cokernel_diagram ) ), Range( cokernel_diagram ) );
              
        end );
        
        derivation_record.CoimageObject := rec(
          uses := [ "CoimageProjection" ],
          derivation := function( coimage_diagram, coimage_object )
              
              return colift_operation( CoimageProjection( UnderlyingCell( coimage_diagram ) ), Source( coimage_diagram ) );
              
        end );
        
        derivation_record.Pushout := rec(
          uses := [ "DirectSumProjectionInPushout", "DirectSum" ],
          derivation := function( diagram, pushout )
              local underlying_diagram, direct_sum_diagram;
              
              underlying_diagram := List( diagram, UnderlyingCell );
              
              direct_sum_diagram := List( diagram, Range );
              
              return colift_operation( DirectSumProjectionInPushout( underlying_diagram ),
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
                                 UnderlyingCell, morphism,
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
                                 UnderlyingCell, object,
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
    CAP_INTERNAL_DERIVE_STRUCTURE_FUNCTIONS_OF_UNIVERSAL_OBJECTS_FOR_CATEGORY_WITH_ATTRIBUTES( structure_record );
    
    ## install Adds
    CAP_INTERNAL_INSTALL_ADDS_FOR_CATEGORY_WITH_ATTRIBUTES( structure_record );
    
    return category_with_attributes;
    
end );