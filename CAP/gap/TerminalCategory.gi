# SPDX-License-Identifier: GPL-2.0-or-later
# CAP: Categories, Algorithms, Programming
#
# Implementations
#

#####################################
##
## Reps for object and morphism
##
#####################################

# backwards compatibility
BindGlobal( "IsCapTerminalCategoryObjectRep", IsObjectInCapTerminalCategoryWithSingleObject );

# backwards compatibility
BindGlobal( "IsCapTerminalCategoryMorphismRep", IsMorphismInCapTerminalCategoryWithSingleObject );

####################################
#
# Constructor
#
####################################

InstallGlobalFunction( CAP_INTERNAL_CONSTRUCTOR_FOR_TERMINAL_CATEGORY,
  function( input_record )
    local completed_record, list_of_operations_to_install, skip, info, properties, excluded_properties, T, operation_name;
    
    completed_record := ShallowCopy( input_record );
    
    list_of_operations_to_install :=
      Set( Concatenation( List( RecNames( CAP_INTERNAL_CONSTRUCTIVE_CATEGORIES_RECORD ), p -> CAP_INTERNAL_CONSTRUCTIVE_CATEGORIES_RECORD.(p) ) ) );
    
    skip := [ ];
    
    for operation_name in list_of_operations_to_install do
        info := CAP_INTERNAL_METHOD_NAME_RECORD.(operation_name);
        
        ## Do not install universal morphisms but their
        ## with-given-universal-object counterpart and the universal object
        ## because in many cases CategoryConstructor cannot lift the non-WithGiven
        ## versions due to not having generic output source/range getters
        if info.return_type = "morphism" and IsList( info.with_given_without_given_name_pair ) and operation_name = info.with_given_without_given_name_pair[1] then
            if not info.with_given_without_given_name_pair[2] in list_of_operations_to_install then
                Add( list_of_operations_to_install, info.with_given_without_given_name_pair[2] );
            fi;
            if IsBound( CAP_INTERNAL_METHOD_NAME_RECORD.(info.with_given_without_given_name_pair[2]).with_given_object_name ) then
                Add( skip, operation_name );
                Add( list_of_operations_to_install, CAP_INTERNAL_METHOD_NAME_RECORD.(info.with_given_without_given_name_pair[2]).with_given_object_name );
            fi;
        fi;
        
        # Do not install boolean operations. For example `IsEndomorphism` is not always true for a morphism in a terminal category with multiple objects.
        if info.return_type = "bool" then
            Add( skip, operation_name );
        fi;
      
    od;
    
    list_of_operations_to_install := Difference( list_of_operations_to_install, skip );
    
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
    
    properties := Filtered( properties, p -> not ForAny( excluded_properties, e -> e = p or e in ListImpliedFilters( FilterByName( p ) ) ) );
    
    Add( properties, "IsTerminalCategory" );
    
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

#########################################
#
# Terminal category with a single object
#
#########################################

##
InstallGlobalFunction( TerminalCategoryWithSingleObject,
  function( )
    local name, category_filter, category_object_filter, category_morphism_filter,
          create_func_object, create_func_morphism,
          object_constructor, object_datum, morphism_constructor, morphism_datum,
          T;
    
    name := "TerminalCategoryWithSingleObject( )";
    
    category_filter := IsCapTerminalCategoryWithSingleObject;
    
    category_object_filter := IsObjectInCapTerminalCategoryWithSingleObject and HasIsZeroForObjects and IsZeroForObjects;
    
    category_morphism_filter := IsMorphismInCapTerminalCategoryWithSingleObject and HasIsZeroForMorphisms and IsZeroForMorphisms and HasIsOne and IsOne;
    
    ## e.g., ZeroObject, DirectSum
    create_func_object :=
        function( name, T )
            
            return """
                function( input_arguments... )
                    
                    return ObjectConstructor( cat, fail );
                    
                end
            """;
            
        end;
    
    ## e.g., IdentityMorphism, PreCompose
    create_func_morphism :=
        function( name, T )
            
            return """
                function( input_arguments... )
                    
                    return MorphismConstructor( cat, top_source, fail, top_range );
                    
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
InstallMethod( UniqueObject,
               [ IsCapTerminalCategoryWithSingleObject ],
               
  function( category )
    local object;
    
    object := ObjectConstructor( category, fail );
    
    return object;
    
end );

##
InstallMethod( UniqueMorphism,
               [ IsCapTerminalCategoryWithSingleObject ],
               
  function( category )
    local object, morphism;
    
    object := UniqueObject( category );
    
    morphism := MorphismConstructor( category, object, fail, object );
    
    return morphism;
    
end );

#########################################
#
# Terminal category with multiple objects
#
#########################################

##
InstallGlobalFunction( TerminalCategoryWithMultipleObjects,
  function( )
    local name, category_filter, category_object_filter, category_morphism_filter,
          create_func_object, create_func_morphism,
          object_constructor, object_datum, morphism_constructor, morphism_datum,
          properties, excluded_properties, excluded_skeletal_properties, excluded_strict_properties, T;
          
    name := "TerminalCategoryWithMultipleObjects( )";
    
    category_filter := IsCapTerminalCategoryWithMultipleObjects;
    
    category_object_filter := IsObjectInCapTerminalCategoryWithMultipleObjects and HasIsZeroForObjects and IsZeroForObjects;
    
    category_morphism_filter := IsMorphismInCapTerminalCategoryWithMultipleObjects and HasIsZeroForMorphisms and IsZeroForMorphisms;
    
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
    
    morphism_datum := { cat, morphism } -> String( morphism );
    
    ## prevent strictness
    properties := Set( List( CAP_INTERNAL_CATEGORICAL_PROPERTIES_LIST, a -> a[1] ) );
    excluded_strict_properties := Filtered( properties, p -> StartsWith( p, "IsStrict" ) );
    
    ## prevent skeletality
    excluded_skeletal_properties := [ "IsSkeletalCategory" ];
    
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

################################
##
## Functor constructors
##
################################

##
InstallMethod( FunctorFromTerminalCategory,
               [ IsCapCategoryObject ],
               
  function( object )
    local functor;
    
    functor := CapFunctor( Concatenation( "InjectionInto", Name( CapCategory( object ) ) ), AsCapCategory( TerminalObject( CapCat ) ), CapCategory( object ) );
    
    functor!.terminal_object_functor_object := object;
    
    AddObjectFunction( functor,
                       
      function( arg )
        
        return functor!.terminal_object_functor_object;
        
    end );
    
    AddMorphismFunction( functor,
                         
      function( arg )
        
        return IdentityMorphism( functor!.terminal_object_functor_object );
        
    end );
    
    return functor;
    
end );

##
#= comment for Julia
InstallOtherMethod( FunctorFromTerminalCategory,
                    [ IsCapCategoryMorphism and IsOne ],
               
  morphism -> FunctorFromTerminalCategory( Source( morphism ) )
  
);
# =#

#################################
#
# View & Display
#
#################################

##
InstallMethod( Display,
        [ IsObjectInCapTerminalCategoryWithMultipleObjects ],

  function( o )
    
    Display( String( o ) );
    
end );

##
InstallMethod( Display,
        [ IsMorphismInCapTerminalCategoryWithMultipleObjects ],

  function( m )
    
    Display( Source( m ) );
    Print( "|\n| ", String( m ), "\nv\n" );
    Display( Range( m ) );
    
end );
