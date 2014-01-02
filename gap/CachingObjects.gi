#############################################################################
##
##                                               CategoriesForHomalg package
##
##  Copyright 2013, Sebastian Gutsche, TU Kaiserslautern
##                  Sebastian Posur,   RWTH Aachen
##
#! @Level 1
#! @Chapter Caching objects
##
#############################################################################

DeclareRepresentation( "IsCachingObjectRep",
                       IsAttributeStoringRep and IsCachingObject,
                       [ ] );

DeclareRepresentation( "IsWeakCachingObjectRep",
                       IsCachingObjectRep,
                       [ ] );

DeclareRepresentation( "IsCrispCachingObjectRep",
                       IsCachingObjectRep,
                       [ ] );

DeclareRepresentation( "IsMixedCachingObjectRep",
                       IsCachingObjectRep,
                       [ ] );

BindGlobal( "TheFamilyOfCachingObjects",
        NewFamily( "TheFamilyOfCachingObjects" ) );

BindGlobal( "TheTypeOfWeakCachingObject",
        NewType( TheFamilyOfCachingObjects,
                 IsWeakCachingObjectRep ) );

BindGlobal( "TheTypeOfCrispCachingObject",
        NewType( TheFamilyOfCachingObjects,
                 IsCrispCachingObjectRep ) );

## FIXME: Maybe do not search by IsIdenticalObj
InstallGlobalFunction( SEARCH_WPLIST_FOR_OBJECT,
                       
  function( wp_list, object )
    local pos;
    
    for pos in [ 1 .. LengthWPObj( wp_list ) ] do
        
        Error( "" );
        
        if IsIdenticalObj( object, ElmWPObj( wp_list, pos ) ) then
            
            return pos;
            
        fi;
        
    od;
    
    return fail;
    
end );

InstallGlobalFunction( CATEGORIES_FOR_HOMALG_PREPARE_CACHING_RECORD,
                       
  function( nr_keys )
    local cache, i;
    
    cache := rec( keys := [ ],
                nr_keys := nr_keys,
                keys_value_list := [ ],
                value_list_position := 1,
                hit_counter := 0,
                miss_counter := 0 );
    
    for i in [ 1 .. nr_keys ] do
        
        cache.keys[ i ] := WeakPointerObj( [ ] );
        
    od;
    
    return cache;
    
end );

InstallGlobalFunction( CreateWeakCachingObject,
                       
  function( nr_keys )
    local cache, i;
    
    cache := CATEGORIES_FOR_HOMALG_PREPARE_CACHING_RECORD( nr_keys );
    
    cache.value := WeakPointerObj( [ ] );
    
    ObjectifyWithAttributes( cache, TheTypeOfWeakCachingObject );
    
    return cache;
    
end );

InstallGlobalFunction( CreateCrispCachingObject,
                       
  function( nr_keys )
    local cache;
    
    cache := CATEGORIES_FOR_HOMALG_PREPARE_CACHING_RECORD( nr_keys );
    
    cache.value := [ ];
    
    ObjectifyWithAttributes( cache, TheTypeOfCrispCachingObject );
    
    return cache;
    
end );

InstallMethod( CachingObject,
               [ ],
               
  function( )
    
    return CreateWeakCachingObject( 1 );
    
end );

InstallMethod( CachingObject,
               [ IsBool ],
               
  function( is_crisp )
    
    return CachingObject( is_crisp, 1 );
    
end );

InstallMethod( CachingObject,
               [ IsBool, IsInt ],
               
  function( is_crisp, nr_keys )
    
    if is_crisp = true then
        
        return CreateCrispCachingObject( nr_keys );
        
    fi;
    
    return CreateWeakCachingObject( nr_keys );
    
end );

InstallMethod( CachingObject,
               [ IsInt, IsBool ],
               
  function( nr_keys, is_crisp )
    
    return CachingObject( is_crisp, nr_keys );
    
end );

InstallMethod( CachingObject,
               [ IsInt ],
               
  function( nr_keys )
    
    return CreateWeakCachingObject( nr_keys );
    
end );

InstallMethod( Add,
               [ IsWeakCachingObjectRep, IsInt, IsObject ],
               
  function( cache, pos, object )
    
    SetElmWPObj( cache!.value, pos, object );
    
end );

InstallMethod( Add,
               [ IsCrispCachingObjectRep, IsInt, IsObject ],
               
  function( cache, pos, object )
    
    cache!.value[ pos ] := object;
    
end );

InstallMethod( GetObject,
               [ IsWeakCachingObjectRep, IsInt ],
               
  function( cache, pos )
    local list;
    
    list := cache!.value;
    
    if IsBoundElmWPObj( list, pos ) then
        
        return ElmWPObj( list, pos );
        
    fi;
    
    return SuPeRfail;
    
end );

InstallMethod( GetObject,
               [ IsCrispCachingObjectRep, IsInt ],
               
  function( cache, pos )
    local list;
    
    list := cache!.value;
    
    if IsBound( list[ pos ] ) then
        
        return list[ pos ];
        
    fi;
    
    return SuPeRfail;
    
end );

InstallMethod( SetCacheValue,
               [ IsCachingObject, IsList, IsObject ],
               
  function( cache, key_list, value )
    local keys, length_key_list, i, position, entry_position;
    
    length_key_list := Length( key_list );
    
    if cache!.nr_keys <> length_key_list then
        
        Error( "cache supports only keys of length ", String( cache!.nr_keys ) );
        
    fi;
    
    keys := cache!.keys;
    
    for i in [ 1 .. length_key_list ] do
        
        position := SEARCH_WPLIST_FOR_OBJECT( keys[ i ], key_list[ i ] );
        
        if position = fail then
            
            position := LengthWPObj( keys[ i ] ) + 1;
            
            SetElmWPObj( keys[ i ], position, key_list[ i ] );
            
        fi;
        
        keys[ i ] := position;
        
    od;
    
    entry_position := cache!.value_list_position;
    
    cache!.keys_value_list[ entry_position ] := keys;
    
    Add( cache, entry_position, value );
    
    cache!.value_list_position := entry_position + 1;
    
end );

InstallMethod( CacheValue,
               [ IsCachingObject, IsList ],
               
  function( cache, key_list )
    local length_key_list, keys, position, i;
    
    length_key_list := Length( key_list );
    
    if cache!.nr_keys <> length_key_list then
        
        Error( "cache supports only keys of length ", String( cache!.nr_keys ) );
        
    fi;
    
    keys := cache!.keys;
    
    for i in [ 1 .. length_key_list ] do
        
        position := SEARCH_WPLIST_FOR_OBJECT( keys[ i ], key_list[ i ] );
        
        if position = fail then
            
            return SuPeRfail;
            
        fi;
        
        keys[ i ] := position;
        
    od;
    
    position := Position( cache!.keys_value_list, keys );
    
    if position = fail then
        
        return SuPeRfail;
        
    fi;
    
    return GetObject( cache, position );
    
end );

