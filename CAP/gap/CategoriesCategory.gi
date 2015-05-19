#############################################################################
##
##                                               CAP package
##
##  Copyright 2013, Sebastian Gutsche, TU Kaiserslautern
##                  Sebastian Posur,   RWTH Aachen
##
##
#############################################################################

DeclareRepresentation( "IsCapCategoryAsCatObjectRep",
                       IsCapCategoryObjectRep and IsCapCategoryAsCatObject,
                       [ ] );

BindGlobal( "TheTypeOfHomalgCategoriesAsCatObjects",
        NewType( TheFamilyOfCapCategoryObjects,
                IsCapCategoryAsCatObjectRep ) );

DeclareRepresentation( "IsCapFunctorRep",
                       IsCapCategoryMorphismRep and IsCapFunctor,
                       [ ] );

BindGlobal( "TheTypeOfCapFunctors",
        NewType( TheFamilyOfCapCategoryMorphisms,
                IsCapFunctorRep ) );

DeclareRepresentation( "IsHomalgNaturalTransformationRep",
                       IsCapCategoryTwoCellRep and IsHomalgNaturalTransformation,
                       [ ] );

BindGlobal( "TheTypeOfHomalgNaturalTransformations",
        NewType( TheFamilyOfCapCategoryTwoCells,
                IsHomalgNaturalTransformationRep ) );

##
InstallGlobalFunction( CAP_INTERNAL_CREATE_Cat,
               
  function(  )
    
    InstallValue( CapCat, rec( caching_info := rec( ) ) );
    
    CREATE_CAP_CATEGORY_OBJECT( CapCat, [ [ "Name", "Cat" ] ] );
    
    CREATE_CAP_CATEGORY_FILTERS( CapCat );
    
    return CapCat;
    
end );

CAP_INTERNAL_CREATE_Cat( );

##
InstallMethod( AsCatObject,
               [ IsCapCategory ],
  
  function( category )
    local cat_obj;
    
    cat_obj := rec( );
    
    ObjectifyWithAttributes( cat_obj, TheTypeOfHomalgCategoriesAsCatObjects,
                             AsCapCategory, category );
    
    Add( CapCat, cat_obj );
    
    SetIsWellDefined( cat_obj, true );
    
    return cat_obj;
    
end );

BindGlobal( "CAP_INTERNAL_NICE_FUNCTOR_INPUT_LIST",
  
  function( list )
    local i;
    
    for i in [ 1 .. Length( list ) ] do
        
        if IsCapCategory( list[ i ] ) then
            list[ i ] := [ list[ i ], false ]; ##true means opposite
        elif IsCapCategoryAsCatObject( list[ i ] ) then
            list[ i ] := [ AsCapCategory( list[ i ] ), false ];
        elif IsList( list[ i ] ) and Length( list[ i ] ) = 2 and IsCapCategory( list[ i ][ 1 ] ) then
            list[ i ][ 2 ] := true;
        elif IsList( list[ i ] ) and Length( list[ i ] ) = 2 and IsCapCategoryAsCatObject( list[ i ][ 1 ] ) then
            list[ i ] := [ AsCapCategory( list[ i ][ 1 ] ), true ];
        fi;
        
    od;
    
    return list;
    
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
    
    return CallFuncList( Product, source_list );
    
end );

##
InstallMethod( CapFunctor,
               [ IsString, IsList, IsCapCategory ],
               
  function( name, source_list, range )
    local source, functor;
    
    functor := rec( );
    
    source_list := CAP_INTERNAL_NICE_FUNCTOR_INPUT_LIST( source_list );
    
    functor.input_source_list := source_list;
    
    source := CAP_INTERNAL_CREATE_FUNCTOR_SOURCE( source_list );
    
    ObjectifyWithAttributes( functor, TheTypeOfCapFunctors,
                             Name, name,
                             Source, AsCatObject( source ),
                             Range, AsCatObject( range ) );
    
    Add( CapCat, functor );
    
    return functor;
    
end );

##
InstallMethod( CapFunctor,
               [ IsString, IsCapCategory, IsCapCategory ],
               
  function( name, source, range )
    
    return CapFunctor( name, [ source ], range );
    
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
InstallMethod( AddObjectFunction,
               [ IsCapFunctor, IsFunction ],
               
  function( functor, func )
    
    SetObjectFunction( functor, func );
    
end );

##
InstallMethod( AddMorphismFunction,
               [ IsCapFunctor, IsFunction ],
               
  function( functor, func )
    
    SetMorphismFunction( functor, func );
    
end );

##
InstallMethod( CatFunctorPreimageList,
               [ IsCapCategoryCell ],
               
  function( obj )
    
    if not IsBound( obj!.CatFunctorPreimageList ) then
        
        obj!.CatFunctorPreimageList := rec( );
        
    fi;
    
    return obj!.CatFunctorPreimageList;
    
end );

##
InstallMethod( ObjectCache,
               [ IsCapFunctor ],
               
  function( functor )
    
    return CachingObject( );
    
end );

##
InstallMethod( MorphismCache,
               [ IsCapFunctor ],
               
  function( functor )
    
    return CachingObject( );
    
end );

##
InstallMethod( ApplyFunctor,
               [ IsCapFunctor, IsCapCategoryObject ],
               
  function( functor, obj )
    local obj_cache, cache_return, computed_value;
    
    if not IsIdenticalObj( CapCategory( obj ), AsCapCategory( Source( functor ) ) ) then
        
        Error( "wrong input object" );
        
    fi;
    
    obj_cache := ObjectCache( functor );
    
    cache_return := CacheValue( obj_cache, obj );
    
    if cache_return <> SuPeRfail then
        
        return cache_return;
        
    fi;
    
    computed_value := ObjectFunction( functor )( obj );
    
    SetCacheValue( obj_cache, [ obj ], computed_value );
    
    ## The preimages are stored because they CAN be elements of product categories.
    ## If this preimage is deleted and a new one is generated for the call of this functor
    ## a new image is created. This might cause inconsistencies.
    CatFunctorPreimageList( computed_value ).( Name( functor ) ) := obj;
    
    Add( AsCapCategory( Range( functor ) ), computed_value );
    
    return computed_value;
    
end );

##
InstallMethod( ApplyFunctor,
               [ IsCapFunctor, IsCapCategoryMorphism ],
               
  function( functor, mor )
    local mor_cache, cache_return, computed_value;
    
    if not IsIdenticalObj( CapCategory( mor ), AsCapCategory( Source( functor ) ) ) then
        
        Error( "wrong input object" );
        
    fi;
    
    mor_cache := MorphismCache( functor );
    
    cache_return := CacheValue( mor_cache, mor );
    
    if cache_return <> SuPeRfail then
        
        return cache_return;
        
    fi;
    
    computed_value := MorphismFunction( functor )( ApplyFunctor( functor, Source( mor ) ), mor, ApplyFunctor( functor, Range( mor ) ) );
    
    SetCacheValue( mor_cache, [ mor ], computed_value );
    
    CatFunctorPreimageList( computed_value ).( Name( functor ) ) := mor;
    
    Add( AsCapCategory( Range( functor ) ), computed_value );
    
    return computed_value;
    
end );

##
AddPreCompose( CapCat,
               
  function( left_functor, right_functor )
    local obj_func, mor_func, new_functor;
    
    new_functor := CapFunctor( Concatenation( "Composition of ",
                                                 Name( left_functor ),
                                                 " and ",
                                                 Name( right_functor ) ),
                                  AsCapCategory( Source( left_functor ) ),
                                  AsCapCategory( Range( right_functor ) ) );
    
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
AddIdentityMorphism( CapCat,
                     
  function( category )
    local new_functor;
    
    new_functor := CapFunctor( Concatenation( "Identity functor of ", Name( AsCapCategory( category ) ) ),
                                                 category, category );
    
    AddObjectFunction( new_functor,
                       
                       IdFunc );
    
    AddMorphismFunction( new_functor,
                         
      function( arg ) return arg[ 2 ]; end );
    
    return new_functor;
    
end );

##
AddTerminalObject( CapCat,
                   
  function( )
    
    return CAP_INTERNAL_TERMINAL_CATEGORY_AS_CAT_OBJECT;
    
end );

##
AddUniversalMorphismIntoTerminalObject( CapCat,
                               
  function( category )
    local new_functor;
    
    new_functor := CapFunctor( Concatenation( "The terminal of ", Name( AsCapCategory( category ) ) ), category, CAP_INTERNAL_TERMINAL_CATEGORY_AS_CAT_OBJECT );
    
    AddObjectFunction( new_functor,
                       
                       function( arg ) return UniqueObject( CAP_INTERNAL_TERMINAL_CATEGORY ); end );
    
    AddMorphismFunction( new_functor,
                         
                         function( arg ) return UniqueMorphism( CAP_INTERNAL_TERMINAL_CATEGORY ); end );
    
    return new_functor;
    
end );

##
AddUniversalMorphismIntoTerminalObjectWithGivenTerminalObject( CapCat,
                               
  function( category, cat_obj )
    local new_functor;
    
    new_functor := CapFunctor( Concatenation( "The terminal of ", Name( AsCapCategory( category ) ) ), category, CAP_INTERNAL_TERMINAL_CATEGORY_AS_CAT_OBJECT );
    
    AddObjectFunction( new_functor,
                       
                       function( arg ) return UniqueObject( CAP_INTERNAL_TERMINAL_CATEGORY ); end );
    
    AddMorphismFunction( new_functor,
                         
                         function( arg ) return UniqueMorphism( CAP_INTERNAL_TERMINAL_CATEGORY ); end );
    
    return new_functor;
    
end );

##
AddDirectProduct( CapCat,
                  
  function( product_of_categories )
    
    return AsCatObject( CallFuncList( Product, List( Components( product_of_categories ), AsCapCategory ) ) );
    
end );

##
AddProjectionInFactorOfDirectProductWithGivenDirectProduct( CapCat,
                            
  function( object_product_list, direct_product, projection_number )
    local projection_functor;
    
    projection_functor := CapFunctor( 
      Concatenation( "Projection into ", String( projection_number ),"-th factor of ", Name( AsCapCategory( direct_product ) ) ), 
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
AddUniversalMorphismIntoDirectProductWithGivenDirectProduct( CapCat,
                                       
  function( diagram, sink, direct_product )
    local name_string, universal_functor;
    
    name_string := Concatenation( 
      "Product functor from ", 
      Name( AsCapCategory( Source( sink[1] ) ) ), 
      " to ", 
      Name( AsCapCategory( direct_product ) ) 
    );
    
    universal_functor := CapFunctor( name_string, Source( sink[1] ), direct_product );
    
    AddObjectFunction( universal_functor,
                       
          function( object )
            local object_list;
            
            object_list := List( Components( sink ), F -> ApplyFunctor( F, object ) );
            
            return CallFuncList( Product, object_list );
            
        end );
        
    AddMorphismFunction( universal_functor,
                         
          function( new_source, morphism, new_range )
            local morphism_list;
            
            morphism_list := List( Components( sink ), F -> ApplyFunctor( F, morphism ) );
            
            return CallFuncList( Product, morphism_list );
            
        end );
        
    return universal_functor;
    
end );

####################################
##
## Functor convinience
##
####################################

##
InstallMethod( InstallFunctorOnObjects,
               [ IsCapFunctor, IsString ],
               
  function( functor, name )
    
    SetObjectFunctionName( functor, name );
    
    InstallFunctorOnObjects( functor );
    
end );

##
InstallMethod( InstallFunctorOnMorphisms,
               [ IsCapFunctor, IsString ],
               
  function( functor, name )
    
    SetMorphismFunctionName( functor, name );
    
    InstallFunctorOnMorphisms( functor );
    
end );

##
InstallMethod( InstallFunctor,
               [ IsCapFunctor, IsString, IsString ],
               
  function( functor, obj_name, mor_name )
    
    SetObjectFunctionName( functor, obj_name );
    
    SetMorphismFunctionName( functor, mor_name );
    
    InstallFunctor( functor );
    
end );

##
InstallMethod( InstallFunctor,
               [ IsCapFunctor, IsString ],
               
  function( functor, name )
    
    InstallFunctor( functor, name, name );
    
end );

##
InstallMethod( ObjectFunctionName,
               [ IsCapFunctor ],
               
  Name );

##
InstallMethod( MorphismFunctionName,
               [ IsCapFunctor ],
               
  Name );

##
InstallMethod( InstallFunctorOnObjects,
               [ IsCapFunctor ],
               
  function( functor )
    local func_name, category_list, filter_list;
    
    func_name := ObjectFunctionName( functor );
    
    category_list := Components( AsCapCategory( Source( functor ) ) );
    
    filter_list := List( category_list, ObjectFilter );
    
    filter_list := List( filter_list, i -> i and IsCapCategoryObject );
    
    DeclareOperation( func_name, filter_list );
    
    InstallMethod( ValueGlobal( func_name ),
                   filter_list,
                   
      function( arg )
        local object;
        
        if Length( arg ) > 1 then
            object := CallFuncList( Product, arg );
        else
            object := arg[ 1 ];
        fi;
        
        return ApplyFunctor( functor, object );
        
    end );
    
end );

##
InstallMethod( InstallFunctorOnMorphisms,
               [ IsCapFunctor ],
               
  function( functor )
    local func_name, category_list, filter_list;
    
    func_name := MorphismFunctionName( functor );
    
    category_list := Components( AsCapCategory( Source( functor ) ) );
    
    filter_list := List( category_list, MorphismFilter );
    
    filter_list := List( filter_list, i -> i and IsCapCategoryMorphism );
    
    DeclareOperation( func_name, filter_list );
    
    InstallMethod( ValueGlobal( func_name ),
                   filter_list,
                   
      function( arg )
        local object;
        
        if Length( arg ) > 1 then
            object := CallFuncList( Product, arg );
        else
            object := arg[ 1 ];
        fi;
        
        return ApplyFunctor( functor, object );
        
    end );
    
end );

##
InstallMethod( InstallFunctor,
               [ IsCapFunctor ],
               
  function( functor )
    
    InstallFunctorOnObjects( functor );
    
    InstallFunctorOnMorphisms( functor );
    
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
    
    return NaturalTransformation( Concatenation( "A Natural transformation from ", Name( source ), " to ", Name( range ) ), source, range );
    
end );

##
InstallMethod( NaturalTransformation,
               [ IsString, IsCapFunctor, IsCapFunctor ],
               
  function( name, source, range )
    local natural_transformation;
    
    ##formally, this has to be IsEqualForObjects (of CAT), but
    ##equality of categories is given by IsIdenticalObj.
    if not IsIdenticalObj( Source( source ), Source( range ) ) or not IsIdenticalObj( Range( source ), Range( range ) ) then
        
        Error( "a natural transformation between this functors does not exist" );
        
    fi;
    
    natural_transformation := rec( );
    
    ObjectifyWithAttributes( natural_transformation, TheTypeOfHomalgNaturalTransformations,
                             Name, name,
                             Source, source,
                             Range, range );
    
    Add( CapCategory( source ), natural_transformation );
    
    return natural_transformation;
    
end );

##
InstallMethod( NaturalTransformationCache,
               [ IsHomalgNaturalTransformation ],
               
  function( natural_trafo )
    
    return CachingObject( );
    
end );

##
InstallMethod( AddNaturalTransformationFunction,
               [ IsHomalgNaturalTransformation, IsFunction ],
               
  SetNaturalTransformationFunction );

##
InstallMethodWithToDoForIsWellDefined( ApplyNaturalTransformation,
                                       [ IsHomalgNaturalTransformation, IsCapCategoryObject ],
               
  function( trafo, object )
    local cache, return_morphism;
    
    ##formally, this has to be IsEqualForObjects (of CAT), but
    ##equality of categories is given by IsIdenticalObj.
    if not IsIdenticalObj( CapCategory( object ), AsCapCategory( Source( Source( trafo ) ) ) ) then
        
        Error( "natural transformation is not applicable" );
        
    fi;
    
    cache := NaturalTransformationCache( trafo );
    
    return_morphism := CacheValue( cache, object );
    
    if return_morphism <> SuPeRfail then
        
        return return_morphism;
        
    fi;
    
    return_morphism := NaturalTransformationFunction( trafo )( object, ApplyFunctor( Source( trafo ), object ), ApplyFunctor( Range( trafo ), object ) );
    
    SetCacheValue( cache, [ object ], return_morphism );
    
    ## FIXME: Maybe cache the preimage here.
    
    Add( AsCapCategory( Range( Source( trafo ) ) ), return_morphism );
    
    return return_morphism;
    
end );

###################################
##
## IsWellDefined
##
###################################

AddIsWellDefinedForObjects( CapCat,

  IsCapCategoryAsCatObjectRep

);
