#############################################################################
##
##                                               CategoriesForHomalg package
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

DeclareRepresentation( "IsHomalgFunctorRep",
                       IsCapCategoryMorphismRep and IsHomalgFunctor,
                       [ ] );

BindGlobal( "TheTypeOfHomalgFunctors",
        NewType( TheFamilyOfCapCategoryMorphisms,
                IsHomalgFunctorRep ) );

DeclareRepresentation( "IsHomalgNaturalTransformationRep",
                       IsCapCategoryTwoCellRep and IsHomalgNaturalTransformation,
                       [ ] );

BindGlobal( "TheTypeOfHomalgNaturalTransformations",
        NewType( TheFamilyOfCapCategoryTwoCells,
                IsHomalgNaturalTransformationRep ) );

##
InstallGlobalFunction( CATEGORIES_FOR_HOMALG_CREATE_Cat,
               
  function(  )
    
    InstallValue( CATEGORIES_FOR_HOMALG_Cat, rec( caching_info := rec( ) ) );
    
    CREATE_HOMALG_CATEGORY_OBJECT( CATEGORIES_FOR_HOMALG_Cat, [ [ "Name", "Cat" ] ] );
    
    CREATE_HOMALG_CATEGORY_FILTERS( CATEGORIES_FOR_HOMALG_Cat );
    
    return CATEGORIES_FOR_HOMALG_Cat;
    
end );

CATEGORIES_FOR_HOMALG_CREATE_Cat( );

##
InstallMethod( AsCatObject,
               [ IsCapCategory ],
  
  function( category )
    local cat_obj;
    
    cat_obj := rec( );
    
    ObjectifyWithAttributes( cat_obj, TheTypeOfHomalgCategoriesAsCatObjects,
                             AsCapCategory, category );
    
    Add( CATEGORIES_FOR_HOMALG_Cat, cat_obj );
    
    SetIsWellDefined( cat_obj, true );
    
    return cat_obj;
    
end );

##
InstallMethod( HomalgFunctor,
               [ IsString, IsCapCategory, IsCapCategory ],
               
  function( name, source, range )
    local functor;
    
    functor := rec( );
    
    ObjectifyWithAttributes( functor, TheTypeOfHomalgFunctors,
                             Name, name,
                             Source, AsCatObject( source ),
                             Range, AsCatObject( range ) );
    
    Add( CATEGORIES_FOR_HOMALG_Cat, functor );
    
    return functor;
    
end );

##
InstallMethod( HomalgFunctor,
               [ IsString, IsCapCategoryAsCatObject, IsCapCategory ],
               
  function( name, source, range )
    
    return HomalgFunctor( name, AsCapCategory( source ), range );
    
end );

##
InstallMethod( HomalgFunctor,
               [ IsString, IsCapCategory, IsCapCategoryAsCatObject ],
               
  function( name, source, range )
    
    return HomalgFunctor( name, source, AsCapCategory( range ) );
    
end );

##
InstallMethod( HomalgFunctor,
               [ IsString, IsCapCategoryAsCatObject, IsCapCategoryAsCatObject ],
               
  function( name, source, range )
    
    return HomalgFunctor( name, AsCapCategory( source ), AsCapCategory( range ) );
    
end );

##
InstallMethod( AddObjectFunction,
               [ IsHomalgFunctor, IsFunction ],
               
  function( functor, func )
    
    SetObjectFunction( functor, func );
    
end );

##
InstallMethod( AddMorphismFunction,
               [ IsHomalgFunctor, IsFunction ],
               
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
               [ IsHomalgFunctor ],
               
  function( functor )
    
    return CachingObject( );
    
end );

##
InstallMethod( MorphismCache,
               [ IsHomalgFunctor ],
               
  function( functor )
    
    return CachingObject( );
    
end );

##
InstallMethod( ApplyFunctor,
               [ IsHomalgFunctor, IsCapCategoryObject ],
               
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
               [ IsHomalgFunctor, IsCapCategoryMorphism ],
               
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
AddPreCompose( CATEGORIES_FOR_HOMALG_Cat,
               
  function( left_functor, right_functor )
    local obj_func, mor_func, new_functor;
    
    new_functor := HomalgFunctor( Concatenation( "Composition of ",
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
AddIdentityMorphism( CATEGORIES_FOR_HOMALG_Cat,
                     
  function( category )
    local new_functor;
    
    new_functor := HomalgFunctor( Concatenation( "Identity functor of ", Name( AsCapCategory( category ) ) ),
                                                 category, category );
    
    AddObjectFunction( new_functor,
                       
                       IdFunc );
    
    AddMorphismFunction( new_functor,
                         
      function( arg ) return arg[ 2 ]; end );
    
    return new_functor;
    
end );

##
AddTerminalObject( CATEGORIES_FOR_HOMALG_Cat,
                   
  function( )
    
    return CATEGORIES_FOR_HOMALG_TERMINAL_CATEGORY_AS_CAT_OBJECT;
    
end );

##
AddUniversalMorphismIntoTerminalObject( CATEGORIES_FOR_HOMALG_Cat,
                               
  function( category )
    local new_functor;
    
    new_functor := HomalgFunctor( Concatenation( "The terminal of ", Name( AsCapCategory( category ) ) ), category, CATEGORIES_FOR_HOMALG_TERMINAL_CATEGORY_AS_CAT_OBJECT );
    
    AddObjectFunction( new_functor,
                       
                       function( arg ) return UniqueObject( CATEGORIES_FOR_HOMALG_TERMINAL_CATEGORY ); end );
    
    AddMorphismFunction( new_functor,
                         
                         function( arg ) return UniqueMorphism( CATEGORIES_FOR_HOMALG_TERMINAL_CATEGORY ); end );
    
    return new_functor;
    
end );

##
AddUniversalMorphismIntoTerminalObjectWithGivenTerminalObject( CATEGORIES_FOR_HOMALG_Cat,
                               
  function( category, cat_obj )
    local new_functor;
    
    new_functor := HomalgFunctor( Concatenation( "The terminal of ", Name( AsCapCategory( category ) ) ), category, CATEGORIES_FOR_HOMALG_TERMINAL_CATEGORY_AS_CAT_OBJECT );
    
    AddObjectFunction( new_functor,
                       
                       function( arg ) return UniqueObject( CATEGORIES_FOR_HOMALG_TERMINAL_CATEGORY ); end );
    
    AddMorphismFunction( new_functor,
                         
                         function( arg ) return UniqueMorphism( CATEGORIES_FOR_HOMALG_TERMINAL_CATEGORY ); end );
    
    return new_functor;
    
end );

##
AddDirectProduct( CATEGORIES_FOR_HOMALG_Cat,
                  
  function( product_of_categories )
    
    return AsCatObject( CallFuncList( Product, List( Components( product_of_categories ), AsCapCategory ) ) );
    
end );

##
AddProjectionInFactorOfDirectProductWithGivenDirectProduct( CATEGORIES_FOR_HOMALG_Cat,
                            
  function( object_product_list, direct_product, projection_number )
    local projection_functor;
    
    projection_functor := HomalgFunctor( 
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
AddUniversalMorphismIntoDirectProductWithGivenDirectProduct( CATEGORIES_FOR_HOMALG_Cat,
                                       
  function( diagram, sink, direct_product )
    local name_string, universal_functor;
    
    name_string := Concatenation( 
      "Product functor from ", 
      Name( AsCapCategory( Source( sink[1] ) ) ), 
      " to ", 
      Name( AsCapCategory( direct_product ) ) 
    );
    
    universal_functor := HomalgFunctor( name_string, Source( sink[1] ), direct_product );
    
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
               [ IsHomalgFunctor, IsString ],
               
  function( functor, name )
    
    SetObjectFunctionName( functor, name );
    
    InstallFunctorOnObjects( functor );
    
end );

##
InstallMethod( InstallFunctorOnMorphisms,
               [ IsHomalgFunctor, IsString ],
               
  function( functor, name )
    
    SetMorphismFunctionName( functor, name );
    
    InstallFunctorOnMorphisms( functor );
    
end );

##
InstallMethod( InstallFunctor,
               [ IsHomalgFunctor, IsString, IsString ],
               
  function( functor, obj_name, mor_name )
    
    SetObjectFunctionName( functor, obj_name );
    
    SetMorphismFunctionName( functor, mor_name );
    
    InstallFunctor( functor );
    
end );

##
InstallMethod( InstallFunctor,
               [ IsHomalgFunctor, IsString ],
               
  function( functor, name )
    
    InstallFunctor( functor, name, name );
    
end );

##
InstallMethod( ObjectFunctionName,
               [ IsHomalgFunctor ],
               
  Name );

##
InstallMethod( MorphismFunctionName,
               [ IsHomalgFunctor ],
               
  Name );

##
InstallMethod( InstallFunctorOnObjects,
               [ IsHomalgFunctor ],
               
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
               [ IsHomalgFunctor ],
               
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
               [ IsHomalgFunctor ],
               
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
               [ IsHomalgFunctor, IsHomalgFunctor ],
               
  function( source, range )
    
    return NaturalTransformation( Concatenation( "A Natural transformation from ", Name( source ), " to ", Name( range ) ), source, range );
    
end );

##
InstallMethod( NaturalTransformation,
               [ IsString, IsHomalgFunctor, IsHomalgFunctor ],
               
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

AddIsWellDefinedForObjects( CATEGORIES_FOR_HOMALG_Cat,

  IsCapCategoryAsCatObjectRep

);
