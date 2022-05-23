# SPDX-License-Identifier: GPL-2.0-or-later
# CategoryConstructor: Construct categories out of given ones
#
# Implementations
#

##
InstallGlobalFunction( TerminalCategoryWithMultipleObjects,
  function(  )
    local create_func_bool, create_func_object, create_func_morphism,
          list_of_operations_to_install, r, skip, func, pos, properties, ignore, T,
          object_constructor, object_datum, morphism_constructor, morphism_datum;
    
    ## e.g., IsMonomorphism
    create_func_bool :=
        function( name, T )
            
            return """
                function( input_arguments )
                    
                    return true;
                    
                end
            """;
            
        end;
    
    ## e.g., ZeroObject, DirectSum
    create_func_object :=
        function( name, T )
            
            return """
                function( input_arguments )
                    
                    return ObjectConstructor( cat, "operation_name" );
                    
                end
            """;
            
        end;
    
    ## e.g., IdentityMorphism, PreCompose
    create_func_morphism :=
        function( name, T )
            
            return """
                function( input_arguments )
                    
                    return MorphismConstructor( cat, top_source, "operation_name", top_range );
                    
                end
            """;
            
        end;
    
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
    
    skip := [ "IsEqualForObjects",
              "IsEqualForMorphisms",
              "IsCongruentForMorphisms",
              "LeftCartesianDistributivityExpandingWithGivenObjects", ## gets derived since IsDistributiveCartesianCategory := true
              "LeftCocartesianCodistributivityFactoringWithGivenObjects", ## gets derived since IsCodistributiveCocartesianCategory := true
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
    
    properties := Set( List( CAP_INTERNAL_CATEGORICAL_PROPERTIES_LIST, a -> a[1] ) );
    
    ## prevent skeletality and strictness
    ignore := Filtered( properties, p -> IsInt( PositionSublist( p, "Strict" ) ) );
    Add( ignore, "IsSkeletalCategory" );
    properties := Difference( properties, ignore );
    
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
    
    T := CategoryConstructor( rec(
                 name := "TerminalCategoryWithMultipleObjects",
                 category_filter := IsTerminalCategory and IsTerminalCategoryWithMultipleObjects,
                 category_object_filter := IsCapTerminalCategoryObjectRep,
                 category_morphism_filter := IsCapTerminalCategoryMorphismRep,
                 commutative_ring_of_linear_category := Integers,
                 properties := properties,
                 list_of_operations_to_install := list_of_operations_to_install,
                 create_func_bool := create_func_bool,
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
    
    ##
    AddIsCongruentForMorphisms( T,
      function( T, morphism1, morphism2 )
        
        ## equality of source and target is part of the specification of the input and checked by the pre-function
        return true;
        
    end );
    
    Finalize( T );
    
    return T;
    
end );

##
InstallMethod( \/,
        [ IsString, IsTerminalCategoryWithMultipleObjects ],
        
  function( string, T )
    
    return ObjectConstructor( T, string );
    
end );

##################################
##
## View & Display
##
##################################

##
InstallMethod( Display,
        [ IsCapTerminalCategoryObjectRep ],

  function( o )
    
    Display( String( o ) );
    
end );

##
InstallMethod( Display,
        [ IsCapTerminalCategoryMorphismRep ],

  function( m )
    
    Display( Source( m ) );
    Print( "|\n| ", String( m ), "\nv\n" );
    Display( Range( m ) );
    
end );
