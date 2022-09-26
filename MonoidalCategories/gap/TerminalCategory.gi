# SPDX-License-Identifier: GPL-2.0-or-later
# MonoidalCategories: Monoidal and monoidal (co)closed categories
#
# Implementations
#

InstallGlobalFunction( CAP_INTERNAL_CONSTRUCTOR_FOR_TERMINAL_CATEGORY,
  function( input_record )
    local completed_record, category_filter, create_func_bool,
          list_of_operations_to_install, operation_name, info, with_given_object_name,
          r, skip, func, pos, properties, excluded_properties, T;
    
    completed_record := ShallowCopy( input_record );
    
    ## e.g., IsMonomorphism
    create_func_bool :=
        function( operation_name, T )
            
            return """
                function( input_arguments... )
                    
                    return true;
                    
                end
            """;
            
        end;
    
    completed_record.create_func_bool := create_func_bool;
    
    list_of_operations_to_install :=
      Concatenation( List( RecNames( CAP_INTERNAL_CONSTRUCTIVE_CATEGORIES_RECORD ), p -> CAP_INTERNAL_CONSTRUCTIVE_CATEGORIES_RECORD.(p) ) );
    
    Append( list_of_operations_to_install,
            [ "Colift",
              "Lift",
              "IsColiftable",
              "IsLiftable",
               ] );
    
    for r in
      [ "RIGID_SYMMETRIC_CLOSED_MONOIDAL_CATEGORIES_METHOD_NAME_RECORD",
        "RIGID_SYMMETRIC_COCLOSED_MONOIDAL_CATEGORIES_METHOD_NAME_RECORD",
        "CATEGORY_CONSTRUCTOR_METHOD_NAME_RECORD",
        "FREYD_CATEGORIES_METHOD_NAME_RECORD",
        "BOOLEAN_ALGEBRA_METHOD_NAME_RECORD",
        ] do
        
        if IsBoundGlobal( r ) then
            Append( list_of_operations_to_install, RecNames( ValueGlobal( r ) ) );
        fi;
        
    od;
    
    list_of_operations_to_install := Set( list_of_operations_to_install );
    
    for operation_name in ShallowCopy( list_of_operations_to_install ) do
        info := CAP_INTERNAL_METHOD_NAME_RECORD.(operation_name);
        
        ## do not install universal morphisms but their
        ## with-given-universal-object counterpart and the universal object
        if info.return_type = "morphism" and IsList( info.with_given_without_given_name_pair ) and operation_name = info.with_given_without_given_name_pair[1] then
            if not info.with_given_without_given_name_pair[2] in list_of_operations_to_install then
                Add( list_of_operations_to_install, info.with_given_without_given_name_pair[2] );
            fi;
            if IsBound( CAP_INTERNAL_METHOD_NAME_RECORD.(info.with_given_without_given_name_pair[2]).with_given_object_name ) then
                Remove( list_of_operations_to_install, Position( list_of_operations_to_install, operation_name ) );
                with_given_object_name := CAP_INTERNAL_METHOD_NAME_RECORD.(info.with_given_without_given_name_pair[2]).with_given_object_name;
                if not with_given_object_name in list_of_operations_to_install then
                    Add( list_of_operations_to_install, with_given_object_name );
                fi;
            fi;
        fi;
        
    od;
    
    list_of_operations_to_install := Set( list_of_operations_to_install );
    
    skip := [ "IsEqualForObjects",
              "IsEqualForMorphisms",
              "IsCongruentForMorphisms",
              "LeftCartesianDistributivityExpandingWithGivenObjects", ## gets derived since IsDistributiveCategory := true
              "LeftCocartesianCodistributivityFactoringWithGivenObjects", ## gets derived since IsCodistributiveCategory := true
              "MorphismToBidual",
              "MorphismFromBidual",
              "MorphismToCoBidual",
              "MorphismFromCoBidual",
              "MorphismToBidualWithGivenBidual",
              "MorphismFromBidualWithGivenBidual",
              "MorphismToCoBidualWithGivenCoBidual",
              "MorphismFromCoBidualWithGivenCoBidual",
              ];
    
    for func in skip do
        
        pos := Position( list_of_operations_to_install, func );
        if not pos = fail then
            Remove( list_of_operations_to_install, pos );
        fi;
        
    od;
    
    completed_record.list_of_operations_to_install := list_of_operations_to_install;
    
    properties := Set( List( CAP_INTERNAL_CATEGORICAL_PROPERTIES_LIST, a -> a[1] ) );
    
    if IsBound( completed_record.excluded_properties ) then
        excluded_properties := completed_record.excluded_properties;
        Unbind( completed_record.excluded_properties );
    else
        excluded_properties := [ ];
    fi;
    
    ## We are here in the doctrine "IsCapCategory" where a terminal category is not initial.
    ## However, in the doctrine "IsCategoryWithZeroObject" or "IsAdditiveCategory"
    ## the terminal and initial categories are equivalent. Other constructors of the terminal category
    ## can still set IsInitialCategory = true manually, if the doctrine is clear from the context.
    Add( excluded_properties, "IsInitialCategory" );
    
    properties := Difference( properties, excluded_properties );
    
    completed_record.properties := properties;
    
    if not IsBound( completed_record.commutative_ring_of_linear_category ) then
        completed_record.commutative_ring_of_linear_category := Integers;
    fi;
    
    T := CategoryConstructor( completed_record );
    
    ##
    AddIsCongruentForMorphisms( T,
      function( T, morphism1, morphism2 )
        
        ## equality of source and target is part of the specification of the input and checked by the pre-function
        return true;
        
    end );
    
    return T;
    
end );

##
InstallGlobalFunction( TerminalCategory,
  function(  )
    local name, category_filter, category_object_filter, category_morphism_filter,
          create_func_object, create_func_morphism,
          object_constructor, object_datum, morphism_constructor, morphism_datum,
          T;
    
    name := "TerminalCategory( )";
    
    category_filter := IsCapCategory;
    
    category_object_filter := IsCapTerminalCategoryObjectRep and HasIsZeroForObjects and IsZeroForObjects;
    
    category_morphism_filter := IsCapTerminalCategoryMorphismRep and HasIsZeroForMorphisms and IsZeroForMorphisms;
    
    ## e.g., ZeroObject, DirectSum
    create_func_object :=
        function( name, T )
            
            return """
                function( input_arguments... )
                    
                    return ObjectConstructor( cat, [ ] );
                    
                end
            """;
            
        end;
    
    ## e.g., IdentityMorphism, PreCompose
    create_func_morphism :=
        function( name, T )
            
            return """
                function( input_arguments... )
                    
                    return MorphismConstructor( cat, top_source, [ ], top_range );
                    
                end
            """;
            
        end;
    
    ##
    object_constructor := function( cat, input )
        
        return ObjectifyObjectForCAPWithAttributes(
                       rec( ), cat );
        
    end;
    
    object_datum := { cat, object } -> fail;
    
    morphism_constructor := function( cat, source, input, range )
        
        return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes(
                       rec( ), cat,
                       source,
                       range );
        
    end;
    
    morphism_datum := { cat, morphism } -> fail;
    
    T := CAP_INTERNAL_CONSTRUCTOR_FOR_TERMINAL_CATEGORY( rec(
                 name := name,
                 category_filter := category_filter,
                 category_object_filter := category_object_filter,
                 category_morphism_filter := category_morphism_filter,
                 create_func_object := create_func_object,
                 create_func_morphism := create_func_morphism,
                 create_func_morphism_or_fail := create_func_morphism,
                 object_constructor := object_constructor,
                 object_datum := object_datum,
                 morphism_constructor := morphism_constructor,
                 morphism_datum := morphism_datum
                 ) );
    
    ##
    AddIsWellDefinedForObjects( T,
      function( T, object )
        
        return true;
        
    end );
    
    ##
    AddIsWellDefinedForMorphisms( T,
      function( T, morphism )
        
        return true;
        
    end );
    
    ##
    AddIsEqualForObjects( T,
      function( T, object1, object2 )
        
        return true;
        
    end );
    
    ##
    AddIsEqualForMorphisms( T,
      function( T, morphism1, morphism2 )
        
        return true;
        
    end );
    
    Finalize( T );
    
    return T;
    
end );

##
InstallGlobalFunction( TerminalCategoryWithMultipleObjects,
  function(  )
    local name, category_filter, category_object_filter, category_morphism_filter,
          create_func_object, create_func_morphism,
          object_constructor, object_datum, morphism_constructor, morphism_datum,
          properties, excluded_properties, excluded_skeletal_properties, excluded_strict_properties, T;
    
    name := "TerminalCategoryWithMultipleObjects( )";
    
    category_filter := IsTerminalCategoryWithMultipleObjects;
    
    category_object_filter := IsObjectInTerminalCategoryWithMultipleObjects and HasIsZeroForObjects and IsZeroForObjects;
    
    category_morphism_filter := IsMorphismInTerminalCategoryWithMultipleObjects and HasIsZeroForMorphisms and IsZeroForMorphisms;
    
    ## e.g., ZeroObject, DirectSum
    create_func_object :=
        function( name, T )
            
            return """
                function( input_arguments... )
                    
                    return ObjectConstructor( cat, "operation_name" );
                    
                end
            """;
            
        end;
    
    ## e.g., IdentityMorphism, PreCompose
    create_func_morphism :=
        function( name, T )
            
            return """
                function( input_arguments... )
                    
                    return MorphismConstructor( cat, top_source, "operation_name", top_range );
                    
                end
            """;
            
        end;
    
    ##
    object_constructor := function( cat, string )
        
        return ObjectifyObjectForCAPWithAttributes(
                       rec( ), cat,
                       String, string );
        
    end;
    
    object_datum := { cat, object } -> String( object );
    
    morphism_constructor := function( cat, source, string, range )
        
        return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes(
                       rec( ), cat,
                       source,
                       range,
                       String, string );
        
    end;
    
    morphism_datum := { cat, morphism } -> fail;
    
    ## prevent skeletality and strictness
    properties := Set( List( CAP_INTERNAL_CATEGORICAL_PROPERTIES_LIST, a -> a[1] ) );
    excluded_strict_properties := Filtered( properties, p -> IsInt( PositionSublist( p, "Strict" ) ) );
    excluded_skeletal_properties := Filtered( properties, p -> "IsSkeletalCategory" in ListImpliedFilters( FilterByName( p ) ) );
    Add( excluded_skeletal_properties, "IsSkeletalCategory" );
    
    excluded_properties := Concatenation( excluded_strict_properties, excluded_skeletal_properties );
    
    T := CAP_INTERNAL_CONSTRUCTOR_FOR_TERMINAL_CATEGORY( rec(
                 name := name,
                 category_filter := category_filter,
                 category_object_filter := category_object_filter,
                 category_morphism_filter := category_morphism_filter,
                 excluded_properties := excluded_properties,
                 create_func_object := create_func_object,
                 create_func_morphism := create_func_morphism,
                 create_func_morphism_or_fail := create_func_morphism,
                 object_constructor := object_constructor,
                 object_datum := object_datum,
                 morphism_constructor := morphism_constructor,
                 morphism_datum := morphism_datum
                 ) );
    
    ##
    AddIsWellDefinedForObjects( T,
      function( T, object )
        
        return IsString( String( object ) );
        
    end );
    
    ##
    AddIsWellDefinedForMorphisms( T,
      function( T, morphism )
        
        return IsString( String( morphism ) );
        
    end );
    
    ##
    AddIsEqualForObjects( T,
      function( T, object1, object2 )
        
        return String( object1 ) = String( object2 );
        
    end );
    
    ##
    AddIsEqualForMorphisms( T,
      function( T, morphism1, morphism2 )
        
        ## equality of source and target is part of the specification of the input and checked by the pre-function
        return String( morphism1 ) = String( morphism2 );
        
    end );
    
    Finalize( T );
    
    return T;
    
end );

##################################
##
## View & Display
##
##################################

##
InstallMethod( Display,
        [ IsObjectInTerminalCategoryWithMultipleObjects ],

  function( o )
    
    Display( String( o ) );
    
end );

##
InstallMethod( Display,
        [ IsMorphismInTerminalCategoryWithMultipleObjects ],

  function( m )
    
    Display( Source( m ) );
    Print( "|\n| ", String( m ), "\nv\n" );
    Display( Range( m ) );
    
end );
