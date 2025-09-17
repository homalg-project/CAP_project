# SPDX-License-Identifier: GPL-2.0-or-later
# CAP: Categories, Algorithms, Programming
#
# Implementations
#
# backwards compatibility
BindGlobal( "IsCapCategoryAsCatObjectRep", IsCapCategoryAsCatObject );

# backwards compatibility
BindGlobal( "IsCapFunctorRep", IsCapFunctor );

# backwards compatibility
BindGlobal( "IsCapNaturalTransformationRep", IsCapNaturalTransformation );

##
BindGlobal( "CAP_INTERNAL_CREATE_Cat",
               
  function(  )
    local cat;
    
    cat := CreateCapCategoryWithDataTypes(
        "Cat", IsCapCategory,
        IsCapCategoryAsCatObject, IsCapFunctor, IsCapNaturalTransformation,
        fail, fail, fail
        : is_computable := false
    );
    
    INSTALL_CAP_CAT_FUNCTIONS( cat );
    
    return cat;
    
end );

##
InstallMethod( AsCatObject,
               [ IsCapCategory ],
  
  function( category )
    local cat_obj;
    
    cat_obj := CreateCapCategoryObjectWithAttributes( CapCat,
                                                      AsCapCategory, category );
    
    SetIsWellDefined( cat_obj, true );
    
    return cat_obj;
    
end );

BindGlobal( "CAP_INTERNAL_NICE_FUNCTOR_INPUT_LIST",
  
  function( list )
    
    return List( [ 1 .. Length( list ) ], function ( i )
        
        if IsCapCategory( list[ i ] ) then
            return [ list[ i ], false ]; ##true means opposite
        elif IsCapCategoryAsCatObject( list[ i ] ) then
            return [ AsCapCategory( list[ i ] ), false ];
        elif IsList( list[ i ] ) and Length( list[ i ] ) = 2 and IsCapCategory( list[ i ][ 1 ] ) and ( not IsBool( list[i][2] ) ) then
            return [ list[ i ][1], true ];
        elif IsList( list[ i ] ) and Length( list[ i ] ) = 2 and IsCapCategoryAsCatObject( list[ i ][ 1 ] ) and ( not IsBool( list[i][2] ) ) then
            return [ AsCapCategory( list[ i ][ 1 ] ), true ];
        else
            return list[i];
        fi;
        
    end );
    
end );

BindGlobal( "CAP_INTERNAL_CREATE_FUNCTOR_SOURCE",
  
  function( list )
    local source_list, i;
    
    source_list := [ ];
    
    for i in list do
        
        if i[ 2 ] = false then
            Add( source_list, i[ 1 ] );
        else
            Add( source_list, Opposite( i[ 1 ] ) );
        fi;
        
    od;
    
    return ProductCategory( source_list );
    
end );

##
InstallMethod( CapFunctor,
               [ IsString, IsList, IsCapCategory ],
               
  function( name, source_list, range )
    local source, objectified_functor;
    
    source_list := CAP_INTERNAL_NICE_FUNCTOR_INPUT_LIST( source_list );
    
    source := CAP_INTERNAL_CREATE_FUNCTOR_SOURCE( source_list );
    
    objectified_functor := CreateCapCategoryMorphismWithAttributes( CapCat,
                                                                    AsCatObject( source ),
                                                                    AsCatObject( range ),
                                                                    Name, name,
                                                                    InputSignature, source_list );
    
    objectified_functor!.input_source_list := source_list;
    
    objectified_functor!.number_arguments := Length( source_list );
    
    return objectified_functor;
    
end );

##
InstallMethod( CapFunctor,
               [ IsString, IsList, IsCapCategoryAsCatObject ],
               
  function( name, source_list, range )
    
    return CapFunctor( name, source_list, AsCapCategory( range ) );
    
end );

##
InstallMethod( CapFunctor,
               [ IsString, IsCapCategory, IsCapCategory ],
               
  function( name, source, range )
    local source_list, objectified_functor;
    
    source_list := CAP_INTERNAL_NICE_FUNCTOR_INPUT_LIST( [ source ] );
    
    objectified_functor := CreateCapCategoryMorphismWithAttributes( CapCat,
                                                                    AsCatObject( source ),
                                                                    AsCatObject( range ),
                                                                    Name, name,
                                                                    InputSignature, source_list );
    
    objectified_functor!.input_source_list := source_list;
    
    objectified_functor!.number_arguments := Length( source_list );
    
    return objectified_functor;
    
end );

##
InstallMethod( CapFunctor,
               [ IsString, IsCapCategoryAsCatObject, IsCapCategory ],
               
  function( name, source, range )
    
    return CapFunctor( name, [ source ], range );
    
end );

##
InstallMethod( CapFunctor,
               [ IsString, IsCapCategory, IsCapCategoryAsCatObject ],
               
  function( name, source, range )
    
    return CapFunctor( name, [ source ], AsCapCategory( range ) );
    
end );

##
InstallMethod( CapFunctor,
               [ IsString, IsCapCategoryAsCatObject, IsCapCategoryAsCatObject ],
               
  function( name, source, range )
    
    return CapFunctor( name, [ source ], AsCapCategory( range ) );
    
end );

##
InstallMethod( SourceOfFunctor,
          [ IsCapFunctor ],
  
  F -> AsCapCategory( Source( F ) )
  
);

##
InstallMethod( RangeOfFunctor,
          [ IsCapFunctor ],
  
  F -> AsCapCategory( Range( F ) )
  
);

BindGlobal( "CAP_INTERNAL_FUNCTOR_CREATE_FILTER_LIST",
  
  function( functor, type )
    local filter_list;
    
    filter_list := List( InputSignature( functor ), i -> i[ 1 ] );
    
    if type = "object" then
        
        filter_list := List( filter_list, ObjectFilter );
        
    elif type = "morphism" then
        
        filter_list := List( filter_list, MorphismFilter );
        
    elif type = "twocell" then
        
        filter_list := List( filter_list, TwoCellFilter );
        
    else
        
        ## Should never be reached
        Error( "unrecognized type" );
        
    fi;
    
    return filter_list;
    
end );

InstallMethod( FunctorObjectOperation,
               [ IsCapFunctor ],
               
  function( functor )
    local filter_list;
    
    filter_list := CAP_INTERNAL_FUNCTOR_CREATE_FILTER_LIST( functor, "object" );
    
    return NewOperation( Concatenation( "CAP_FUNCTOR_", Name( functor ), "_OBJECT_OPERATION" ), filter_list );
    
end );

InstallMethod( FunctorMorphismOperation,
               [ IsCapFunctor ],
               
  function( functor )
    local filter_list, range_cat;
    
    filter_list := CAP_INTERNAL_FUNCTOR_CREATE_FILTER_LIST( functor, "morphism" );
    
    range_cat := RangeOfFunctor( functor );
    
    filter_list := Concatenation( [ ObjectFilter( range_cat ) ], filter_list, [ ObjectFilter( range_cat ) ] );
    
    return NewOperation( Concatenation( "CAP_FUNCTOR_", Name( functor ), "_MORPHISM_OPERATION" ), filter_list );
    
end );

##
InstallMethod( AddObjectFunction,
               [ IsCapFunctor, IsFunction ],
               
  function( functor, func )
    local filter_list, operation;
    
    filter_list := CAP_INTERNAL_FUNCTOR_CREATE_FILTER_LIST( functor, "object" );
    
    if not IsBound( functor!.object_function_list ) then
        
        functor!.object_function_list := [ ];
        
    fi;
    
    Add( functor!.object_function_list, func );
    
    operation := FunctorObjectOperation( functor );
    
    InstallMethodWithCache( operation, filter_list, func : Cache := ObjectCache( functor ) );
    
end );

##
InstallMethod( AddMorphismFunction,
               [ IsCapFunctor, IsFunction ],
               
  function( functor, func )
    local filter_list, operation, range_cat;
    
    filter_list := CAP_INTERNAL_FUNCTOR_CREATE_FILTER_LIST( functor, "morphism" );
    
    range_cat := RangeOfFunctor( functor );
    
    filter_list := Concatenation( [ ObjectFilter( range_cat ) ], filter_list, [ ObjectFilter( range_cat ) ] );
    
    if not IsBound( functor!.morphism_function_list ) then
        
        functor!.morphism_function_list := [ ];
        
    fi;
    
    Add( functor!.morphism_function_list, func );
    
    operation := FunctorMorphismOperation( functor );
    
    InstallMethodWithCache( operation, filter_list, func : Cache := MorphismCache( functor ) );
    
end );

##
InstallMethod( ObjectCache,
               [ IsCapFunctor ],
               
  function( functor )
    
    return CachingObject( functor!.number_arguments );
    
end );

##
InstallMethod( MorphismCache,
               [ IsCapFunctor ],
               
  function( functor )
    
    return CachingObject( functor!.number_arguments + 2 );
    
end );

##
InstallGlobalFunction( ApplyFunctor,
               
  function( functor, arguments... )
    local is_object, cache, cache_return, computed_value,
          source_list, source_value, range_list, range_value, i, tmp, source_category, range_category, input_signature;
    
    arguments := List( arguments ); # in Julia, `arguments` is a tuple which we cannot assign to below
    
    source_category := SourceOfFunctor( functor );
    range_category := RangeOfFunctor( functor );
    input_signature := InputSignature( functor );

    # n-ary functor and unary argument (possibly in product category)
    if Length( arguments ) = 1 and functor!.number_arguments > 1 then
        
        if source_category!.input_sanity_check_level > 0 then
            CAP_INTERNAL_ASSERT_IS_CELL_OF_CATEGORY( arguments[ 1 ], source_category, {} -> Concatenation( "the argument passed to the functor named \033[1m", Name(functor), "\033[0m" ) );
        fi;

        arguments := ShallowCopy( Components( arguments[ 1 ] ) );
        
        for i in [ 1 .. Length( arguments ) ] do
            if input_signature[ i ][ 2 ] = true then
                arguments[ i ] := Opposite( arguments[ i ] );
            fi;
        od;
        
    elif Length( arguments ) = 1 and input_signature[ 1 ][ 2 ] = true then
        if source_category!.input_sanity_check_level > 0 then
            CAP_INTERNAL_ASSERT_IS_CELL_OF_CATEGORY( arguments[ 1 ], false, {} -> Concatenation( "the argument passed to the functor named \033[1m", Name(functor), "\033[0m" ) );
        fi;

        if IsIdenticalObj( CapCategory( arguments[ 1 ] ), Opposite( input_signature[ 1 ][ 1 ] ) ) then
            arguments[ 1 ] := Opposite( arguments[ 1 ] );
        fi;
    elif Length( arguments ) = 1 then
        if source_category!.input_sanity_check_level > 0 then
            CAP_INTERNAL_ASSERT_IS_CELL_OF_CATEGORY( arguments[ 1 ], source_category, {} -> Concatenation( "the argument passed to the functor named \033[1m", Name(functor), "\033[0m" ) );
        fi;
    fi;
    
    
    if IsCapCategoryObject( arguments[ 1 ] ) then
        
        if source_category!.input_sanity_check_level > 0 then
            if not Length( input_signature ) = Length( arguments ) then
                Error( Concatenation("expected number of arguments (=", String( Length( input_signature ) ), ") does not coincide with the provided number of arguments (=", String( Length( arguments ) ), ")" ) );
            fi;

            for i in [ 1 .. Length( input_signature ) ] do
                CAP_INTERNAL_ASSERT_IS_OBJECT_OF_CATEGORY( arguments[ i ], input_signature[ i ][ 1 ], {} -> Concatenation( "the ", String(i), ". argument passed to the functor named \033[1m", Name(functor), "\033[0m" ) );
            od;
        fi;
        
        computed_value := CallFuncList( FunctorObjectOperation( functor ), arguments );

        if range_category!.output_sanity_check_level > 0 and not range_category!.add_primitive_output then
            CAP_INTERNAL_ASSERT_IS_OBJECT_OF_CATEGORY( computed_value, range_category, {} -> Concatenation( "the result of the object function of the functor named \033[1m", Name(functor), "\033[0m" ) );
        fi;
        
        if range_category!.add_primitive_output then
            
            AddObject( range_category, computed_value );
            
        fi;
        
    elif IsCapCategoryMorphism( arguments[ 1 ] ) then

        if source_category!.input_sanity_check_level > 0 then
            if not Length( input_signature ) = Length( arguments ) then
                Error( Concatenation("expected number of arguments (=", String( Length( input_signature ) ), ") does not coincide with the provided number of arguments (=", String( Length( arguments ) ), ")" ) );
            fi;

            for i in [ 1 .. Length( input_signature ) ] do
                CAP_INTERNAL_ASSERT_IS_MORPHISM_OF_CATEGORY( arguments[ i ], input_signature[ i ][ 1 ], {} -> Concatenation( "the ", String(i), ". argument passed to the functor named \033[1m", Name(functor), "\033[0m" ) );
            od;
        fi;
        
        source_list := List( arguments, Source );
        
        range_list := List( arguments, Range );
        
        for i in [ 1 .. Length( arguments ) ] do
            if InputSignature( functor )[ i ][ 2 ] = true then
                tmp := source_list[ i ];
                source_list[ i ] := range_list[ i ];
                range_list[ i ] := tmp;
            fi;
        od;
        
        source_value := CallFuncList( ApplyFunctor, Concatenation( [ functor ], source_list ) );
        
        range_value := CallFuncList( ApplyFunctor, Concatenation( [ functor ], range_list ) );
        
        computed_value := CallFuncList( FunctorMorphismOperation( functor ), Concatenation( [ source_value ], arguments, [ range_value ] ) );

        if range_category!.output_sanity_check_level > 0 and not range_category!.add_primitive_output then
            CAP_INTERNAL_ASSERT_IS_MORPHISM_OF_CATEGORY( computed_value, range_category, {} -> Concatenation( "the result of the morphism function of the functor named \033[1m", Name(functor), "\033[0m" ) );
        fi;
        
        if range_category!.add_primitive_output then
            
            AddMorphism( range_category, computed_value );
            
        fi;
        
    else
        
        Error( "Second argument of ApplyFunctor must be a category object or morphism" );
        
    fi;
    
    return computed_value;
    
end );

BindGlobal( "INSTALL_CAP_CAT_FUNCTIONS", function ( category )

##
AddPreCompose( category,
               
  function( cat, left_functor, right_functor )
    local new_functor;
    
    new_functor := CapFunctor( Concatenation( "Precomposition of ", Name( left_functor ), " and ", Name( right_functor ) ),
                               SourceOfFunctor( left_functor ),
                               RangeOfFunctor( right_functor ) );
    
    AddObjectFunction( new_functor,
      
      obj -> ApplyFunctor( right_functor, ApplyFunctor( left_functor, obj ) )
      
    );
    
    AddMorphismFunction( new_functor,
      
      function( new_source, morphism, new_range )
        
        return ApplyFunctor( right_functor, ApplyFunctor( left_functor, morphism ) );
        
    end );
    
    return new_functor;
    
end );

##
AddIdentityMorphism( category,
                     
  function( cat, object )
    local new_functor;
    
    new_functor := CapFunctor( Concatenation( "Identity functor of ", Name( AsCapCategory( object ) ) ),
                                                 object, object );
    
    AddObjectFunction( new_functor,
                       
                       IdFunc );
    
    AddMorphismFunction( new_functor,
                         
      function( arg ) return arg[ 2 ]; end );
    
    return new_functor;
    
end );

##
AddTerminalObject( category,
                   
  function( cat )
    
    return AsCatObject( TerminalCategoryWithSingleObject( ) );
    
end );

##
AddUniversalMorphismIntoTerminalObjectWithGivenTerminalObject( category,
                               
  function( cat, object, terminal_cat )
    local new_functor;
    
    new_functor := CapFunctor( Concatenation( "The terminal of ", Name( AsCapCategory( object ) ) ), object, terminal_cat );
    
    AddObjectFunction( new_functor,
                       
                       function( arg ) return TerminalCategoryWithSingleObjectUniqueObject( AsCapCategory( terminal_cat ) ); end );
    
    AddMorphismFunction( new_functor,
                         
                         function( arg ) return TerminalCategoryWithSingleObjectUniqueMorphism( AsCapCategory( terminal_cat ) ); end );
    
    return new_functor;
    
end );

##
AddDirectProduct( category,
                  
  function( cat, object_product_list )
    
    return AsCatObject( ProductCategory( List( object_product_list, AsCapCategory ) ) );
    
end );

##
AddProjectionInFactorOfDirectProductWithGivenDirectProduct( category,
                            
  function( cat, object_product_list, projection_number, direct_product )
    local projection_functor;
    
    projection_functor := CapFunctor( 
      Concatenation( "Projection into ", String( projection_number ),". factor of ", Name( AsCapCategory( direct_product ) ) ),
      direct_product, 
      object_product_list[ projection_number ]
    );
    
    AddObjectFunction( projection_functor,
                       
          function( obj )
            
            return obj[ projection_number ];
            
        end );
        
    AddMorphismFunction( projection_functor,
                         
          function( new_source, morphism, new_range )
            
            return morphism[ projection_number ];
            
        end );
        
    return projection_functor;
    
end );

##
AddUniversalMorphismIntoDirectProductWithGivenDirectProduct( category,
                                       
  function( cat, diagram, test_object, sink, direct_product )
    local name_string, universal_functor;
    
    name_string := Concatenation( 
      "Product functor from ", 
      Name( SourceOfFunctor( sink[1] ) ),
      " to ", 
      Name( AsCapCategory( direct_product ) ) 
    );
    
    universal_functor := CapFunctor( name_string, Source( sink[1] ), direct_product );
    
    AddObjectFunction( universal_functor,
                       
          function( object )
            local object_list;
            
            object_list := List( sink, F -> ApplyFunctor( F, object ) );
            
            return ProductCategoryObject( object_list );
            
        end );
        
    AddMorphismFunction( universal_functor,
                         
          function( new_source, morphism, new_range )
            local morphism_list;
            
            morphism_list := List( sink, F -> ApplyFunctor( F, morphism ) );
            
            return ProductCategoryMorphism( morphism_list );
            
        end );
        
    return universal_functor;
    
end );

##
AddVerticalPreCompose( category,
               
  function( cat, above_transformation, below_transformation )
    local new_natural_transformation;
    
    new_natural_transformation := NaturalTransformation( Concatenation( "Vertical composition of ",
                                                         Name( above_transformation ),
                                                         " and ",
                                                         Name( below_transformation ) ),
                                                         Source( above_transformation ),
                                                         Range( below_transformation ) );
    
    AddNaturalTransformationFunction( new_natural_transformation,
      
      function( source_value, object, range_value )
        
        return PreCompose( ApplyNaturalTransformation( above_transformation, object ),
                           ApplyNaturalTransformation( below_transformation, object ) );
        
      end );
    
    return new_natural_transformation;
    
end );

##
AddHorizontalPreCompose( category,
  
  function( cat, left_natural_transformation, right_natural_transformation )
    local pre_compose_transfo_functor, pre_compose_functor_transfo;
    
    pre_compose_transfo_functor := 
          HorizontalPreComposeNaturalTransformationWithFunctor( left_natural_transformation, Source( right_natural_transformation ) );
          
    pre_compose_functor_transfo :=
          HorizontalPreComposeFunctorWithNaturalTransformation( Range( left_natural_transformation ), right_natural_transformation );
    
    return VerticalPreCompose( pre_compose_transfo_functor, pre_compose_functor_transfo );
    
end );

##
AddIsWellDefinedForObjects( category,

  function( cat, object )
  
    return IsCapCategoryAsCatObject( object );
  
end );

Finalize( category );

end );

####################################
##
## Functor convinience
##
####################################

InstallMethod( InstallFunctor,
               [ IsCapFunctor, IsString ],
               
  function( functor, install_name )
    local object_name, morphism_name, object_filters, object_product_filters, morphism_filters,
          morphism_product_filters, current_filters, install_list;
    
    if IsBound( functor!.is_already_installed ) then
        
        return;
        
    fi;
    
    if IsBoundGlobal( install_name ) and not IsOperation( ValueGlobal( install_name ) ) then
        
        Error( Concatenation( "cannot install functor under name ", install_name ) );
        
    fi;
    
    object_name := Concatenation( install_name, "OnObjects" );
    
    if HasObjectFunctionName( functor ) then
        
        object_name := ObjectFunctionName( functor );
        
    fi;
    
    if IsBoundGlobal( object_name ) and not IsOperation( ValueGlobal( object_name ) ) then
        
        Error( Concatenation( "cannot install functor object function under name ", object_name ) );
        
    fi;
    
    SetObjectFunctionName( functor, object_name );
    
    morphism_name := Concatenation( install_name, "OnMorphisms" );
    
    if HasMorphismFunctionName( functor ) then
        
        morphism_name := MorphismFunctionName( functor );
        
    fi;
    
    if IsBoundGlobal( morphism_name ) and not IsOperation( ValueGlobal( morphism_name ) ) then
        
        Error( Concatenation( "cannot install functor morphism function under name ", morphism_name ) );
        
    fi;
    
    SetMorphismFunctionName( functor, morphism_name );
    
    object_filters := CAP_INTERNAL_FUNCTOR_CREATE_FILTER_LIST( functor, "object" );
    morphism_filters := CAP_INTERNAL_FUNCTOR_CREATE_FILTER_LIST( functor, "morphism" );
    
    object_product_filters := [ ObjectFilter( SourceOfFunctor( functor ) ) ];
    morphism_product_filters := [ MorphismFilter( SourceOfFunctor( functor ) ) ];
    
    install_list := [
        [ install_name, object_filters ],
        [ install_name, morphism_filters ],
        [ object_name, object_filters ],
        [ morphism_name, morphism_filters ]
        ];
    
    if object_filters <> object_product_filters then
        
        Append( install_list, [ [ install_name, object_product_filters ], [ object_name, object_product_filters ] ] );
        
    fi;
    
    if morphism_filters <> morphism_product_filters then
        
        Append( install_list, [ [ install_name, morphism_product_filters ], [ morphism_name, morphism_product_filters ] ] );
        
    fi;
    
    for current_filters in install_list do
        
        DeclareOperation( current_filters[1], current_filters[2] );
        
        InstallMethod( ValueGlobal( current_filters[1] ),
                       current_filters[2],
                      
          function( arg )
            
            return CallFuncList( ApplyFunctor, Concatenation( [ functor ], arg ) );
            
        end );
        
    od;
    
    functor!.is_already_installed := true;
    
end );

##
InstallMethod( IdentityFunctor,
               [ IsCapCategory ],
               
  function( category )
    
    return IdentityMorphism( AsCatObject( category ) );
    
end );

##
InstallMethod( FunctorCanonicalizeZeroObjects,
               [ IsCapCategory ],
               
  function( category )
    local CZ, zero_obj;
    
    if not CanCompute( category, "IsZeroForObjects" ) then
        Error( "the category cannot compute IsZeroForObjects\n" );
    fi;
    
    CZ := CapFunctor( "functor canonicalizing zero objects", category, category );
    
    zero_obj := ZeroObject( category );
    
    AddObjectFunction( CZ,
            function( obj )
              
              if IsZeroForObjects( obj ) then
                  return zero_obj;
              fi;
              
              return obj;
            end );
    
    AddMorphismFunction( CZ,
            function( new_source, mor, new_range )
              
              if IsZeroForObjects( Source( mor ) ) then
                  return UniversalMorphismFromZeroObjectWithGivenZeroObject( new_range, new_source );
              elif IsZeroForObjects( Range( mor ) ) then
                  return UniversalMorphismIntoZeroObjectWithGivenZeroObject( new_source, new_range );
              fi;
              
              return mor;
              
            end );
    
    return CZ;
    
end );

##
InstallMethod( NaturalIsomorphismFromIdentityToCanonicalizeZeroObjects,
               [ IsCapCategory ],
               
  function( category )
    local Id, F, iso;
    
    Id := IdentityFunctor( category );
    
    F := FunctorCanonicalizeZeroObjects( category );
    
    iso := NaturalTransformation(
                   Concatenation( "natural isomorphism from the identity functor to ", Name( F ) ),
                   Id, F );
    
    AddNaturalTransformationFunction(
            iso,
            function( source, obj, range )
              
              if IsZeroForObjects( range ) then
                  return UniversalMorphismIntoZeroObjectWithGivenZeroObject( source, range );
              fi;
              
              return IdentityMorphism( obj );
              
            end );
    
    SetIsIsomorphism( iso, true );
    
    return iso;
    
end );

##
InstallMethod( FunctorCanonicalizeZeroMorphisms,
               [ IsCapCategory ],
               
  function( category )
    local CZ;
    
    if not CanCompute( category, "IsZeroForMorphisms" ) then
        Error( "the category cannot compute IsZeroForMorphisms\n" );
    fi;
    
    CZ := CapFunctor( "functor canonicalizing zero morphisms", category, category );
    
    AddObjectFunction( CZ, IdFunc );
    
    AddMorphismFunction( CZ,
            function( new_source, mor, new_range )
              
              if IsZeroForMorphisms( mor ) then
                  return ZeroMorphism( new_source, new_range );
              fi;
              
              return mor;
              
            end );
    
    return CZ;
    
end );

##
InstallMethod( NaturalIsomorphismFromIdentityToCanonicalizeZeroMorphisms,
               [ IsCapCategory ],
               
  function( category )
    local Id, F, iso;
    
    Id := IdentityFunctor( category );
    
    F := FunctorCanonicalizeZeroMorphisms( category );
    
    iso := NaturalTransformation(
                   Concatenation( "natural isomorphism from the identity functor to ", Name( F ) ),
                   Id, F );
    
    AddNaturalTransformationFunction(
            iso,
            function( source, obj, range )
              
              return IdentityMorphism( obj );
              
            end );
    
    SetIsIsomorphism( iso, true );
    
    return iso;
    
end );

###################################
##
## Natural transformations
##
###################################

##
InstallMethod( NaturalTransformation,
               [ IsCapFunctor, IsCapFunctor ],
               
  function( source, range )
    
    return NaturalTransformation( Concatenation( "A natural transformation from ", Name( source ), " to ", Name( range ) ), source, range );
    
end );

##
InstallMethod( NaturalTransformation,
               [ IsString, IsCapFunctor, IsCapFunctor ],
               
  function( name, source, range )
    local natural_transformation;
    
    ##formally, this has to be IsEqualForObjects (of CAT), but
    ##equality of categories is given by IsIdenticalObj.
    if not IsIdenticalObj( Source( source ), Source( range ) ) or not IsIdenticalObj( Range( source ), Range( range ) ) then
        
        Error( "a natural transformation between these functors does not exist" );
        
    fi;
    
    return CreateCapCategoryTwoCellWithAttributes(
        CapCategory( source ),
        source, range,
        Name, name
    );
    
end );

##
InstallMethod( NaturalTransformationCache,
               [ IsCapNaturalTransformation ],
               
  function( natural_trafo )
    
    return CachingObject( Source( natural_trafo )!.number_arguments + 2 );
    
end );

##
InstallMethod( NaturalTransformationOperation,
               [ IsCapNaturalTransformation ],
               
  function( trafo )
    local filter_list;
    
    filter_list := CAP_INTERNAL_FUNCTOR_CREATE_FILTER_LIST( Source( trafo ), "object" );
    
    filter_list := Concatenation( [ ObjectFilter( RangeOfFunctor( Source( trafo ) ) ) ], filter_list, [ ObjectFilter( RangeOfFunctor( Source( trafo ) ) ) ] );
    
    return NewOperation( Concatenation( "CAP_NATURAL_TRANSFORMATION_", Name( trafo ), "_OPERATION" ), filter_list );
    
end );

##
InstallMethod( AddNaturalTransformationFunction,
               [ IsCapNaturalTransformation, IsFunction ],
               
  function( trafo, func )
    local filter_list, operation, range_cat;
    
    filter_list := CAP_INTERNAL_FUNCTOR_CREATE_FILTER_LIST( Source( trafo ), "object" );
    
    filter_list := Concatenation( [ ObjectFilter( RangeOfFunctor( Source( trafo ) ) ) ], filter_list, [ ObjectFilter( RangeOfFunctor( Source( trafo ) ) ) ] );
    
    if not IsBound( trafo!.function_list ) then
        
        trafo!.function_list := [ ];
        
    fi;
    
    Add( trafo!.function_list, func );
    
    operation := NaturalTransformationOperation( trafo );
    
    InstallMethodWithCache( operation, filter_list, func : Cache := NaturalTransformationCache( trafo ) );
    
end );

InstallGlobalFunction( ApplyNaturalTransformation,
               
  function( arg )
    local trafo, source_functor, range_category, arguments, source_value, range_value, computed_value, i;
    
    trafo := arg[ 1 ];
    
    source_functor := Source( trafo );
    
    range_category := RangeOfFunctor( source_functor );
    
    arguments := arg{[ 2 .. Length( arg ) ]};
    
    if Length( arguments ) = 1 and source_functor!.number_arguments > 1 then
        
        arguments := Components( arguments[ 1 ] );
        
        for i in [ 1 .. Length( arguments ) ] do
            if InputSignature( source_functor )[ i ][ 2 ] = true then
                arguments[ i ] := Opposite( arguments[ i ] );
            fi;
        od;
        
    elif Length( arguments ) = 1 and InputSignature( source_functor )[ 1 ][ 2 ] = true and
         IsIdenticalObj( CapCategory( arguments[ 1 ] ), Opposite( InputSignature( source_functor )[ 1 ][ 1 ] ) ) then
         arguments[ 1 ] := Opposite( arguments[ 1 ] );
    fi;
    
    source_value := CallFuncList( ApplyFunctor, Concatenation( [ source_functor ], arguments ) );
    
    range_value := CallFuncList( ApplyFunctor, Concatenation( [ Range( trafo ) ], arguments ) );
    
    computed_value := CallFuncList( NaturalTransformationOperation( trafo ), Concatenation( [ source_value ], arguments, [ range_value ] ) );
    
    if range_category!.add_primitive_output then
        
        AddTwoCell( range_category, computed_value );
        
    fi;
    
    ## TODO: this should be replaced by an "a => b" todo_list with more properties
    if HasIsIsomorphism( trafo ) and IsIsomorphism( trafo ) then
        SetIsIsomorphism( computed_value, true );
    fi;
    
    return computed_value;
    
end );

InstallMethod( InstallNaturalTransformation,
               [ IsCapNaturalTransformation, IsString ],
               
  function( trafo, install_name )
    local object_filters, object_product_filters, current_filters;
    
    if IsBound( trafo!.is_already_installed ) then
        
        return;
        
    fi;
    
    if IsBoundGlobal( install_name ) and not IsOperation( ValueGlobal( install_name ) ) then
        
        Error( Concatenation( "cannot install natural transformation under name ", install_name ) );
        
    fi;
    
    object_filters := CAP_INTERNAL_FUNCTOR_CREATE_FILTER_LIST( Source( trafo ), "object" );
    
    object_product_filters := [ ObjectFilter( SourceOfFunctor( Source( trafo ) ) ) ];
    
    for current_filters in [
        [ install_name, object_filters ],
        [ install_name, object_product_filters ],
        ] do
        
        CallFuncList( DeclareOperation, current_filters );
        
        InstallMethod( ValueGlobal( current_filters[ 1 ] ),
                      current_filters[ 2 ],
                      
          function( arg )
            
            return CallFuncList( ApplyNaturalTransformation, Concatenation( [ trafo ], arg ) );
            
        end );
        
    od;
    
    trafo!.is_already_installed := true;
    
end );

##
InstallMethodWithCacheFromObject( HorizontalPreComposeNaturalTransformationWithFunctor,
                                  [ IsCapNaturalTransformation, IsCapFunctor ],
                           
  function( natural_transformation, functor )
    local composition;
    
    composition := NaturalTransformation( Concatenation( "Horizontal composition of natural transformation ",
                                                         Name( natural_transformation ),
                                                         " and functor ",
                                                         Name( functor ) ),
                                                         PreCompose( Source( natural_transformation ), functor ),
                                                         PreCompose( Range( natural_transformation ), functor ) );
    
    AddNaturalTransformationFunction( composition,
      
      function( source_value, object, range_value )
        
        return ApplyFunctor( functor, ApplyNaturalTransformation( natural_transformation, object ) );
        
      end );
    
    return composition;
    
end );

##
InstallMethodWithCacheFromObject( HorizontalPreComposeFunctorWithNaturalTransformation,
                                  [ IsCapFunctor, IsCapNaturalTransformation ],
                           
  function( functor, natural_transformation )
    local composition;
    
    composition := NaturalTransformation( Concatenation( "Horizontal composition of functor ",
                                                         Name( functor ),
                                                         " and natural transformation ",
                                                         Name( natural_transformation ) ),
                                                         PreCompose( functor, Source( natural_transformation ) ),
                                                         PreCompose( functor, Range( natural_transformation ) ) );
    
    AddNaturalTransformationFunction( composition,
      
      function( source_value, object, range_value )
        
        return ApplyNaturalTransformation( natural_transformation, ApplyFunctor( functor, object ) );
        
      end );
    
    return composition;
    
end );

##
InstallMethod( ViewString,
               [ IsCapFunctor ],
               
  function ( F )
    
    return Name( F );
    
end );

InstallMethod( DisplayString,
               [ IsCapFunctor ],
               
  function ( F )
    
    return Concatenation(
              Name( F ), ":", "\n\n",
              Name( SourceOfFunctor( F ) ), "\n",
              "  |\n",
              "  V\n",
              Name( RangeOfFunctor( F ) ), "\n" );
    
end );
