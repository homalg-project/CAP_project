#############################################################################
##
##                                               CategoriesForHomalg package
##
##  Copyright 2013, Sebastian Gutsche, TU Kaiserslautern
##                  Sebastian Posur,   RWTH Aachen
##
##
#############################################################################

DeclareRepresentation( "IsHomalgCategoryAsCatObjectRep",
                       IsHomalgCategoryObjectRep and IsHomalgCategoryAsCatObject,
                       [ ] );

BindGlobal( "TheTypeOfHomalgCategoriesAsCatObjects",
        NewType( TheFamilyOfHomalgCategoryObjects,
                IsHomalgCategoryAsCatObjectRep ) );

DeclareRepresentation( "IsHomalgFunctorRep",
                       IsHomalgCategoryMorphismRep and IsHomalgFunctor,
                       [ ] );

BindGlobal( "TheTypeOfHomalgFunctors",
        NewType( TheFamilyOfHomalgCategoryMorphisms,
                IsHomalgFunctorRep ) );

##
InstallGlobalFunction( CATEGORIES_FOR_HOMALG_CREATE_Cat,
               
  function(  )
    
    InstallValue( CATEGORIES_FOR_HOMALG_Cat, rec( caching_info := rec( ) ) );
    
    CREATE_HOMALG_CATEGORY_OBJECT( CATEGORIES_FOR_HOMALG_Cat, [ [ "Name", "Cat" ] ] );
    
    CREATE_HOMALG_CATEGORY_FILTERS( CATEGORIES_FOR_HOMALG_Cat );
    
    InstallImmediateMethod( HomalgCategory,
                            IsHomalgCategoryObject and ObjectFilter( CATEGORIES_FOR_HOMALG_Cat ),
                            0,
                            
      function( object )
        
        return CATEGORIES_FOR_HOMALG_Cat;
        
    end );
    
    InstallImmediateMethod( HomalgCategory,
                            IsHomalgCategoryMorphism and MorphismFilter( CATEGORIES_FOR_HOMALG_Cat ),
                            0,
                            
      function( object )
        
        return CATEGORIES_FOR_HOMALG_Cat;
        
    end );
    
    return CATEGORIES_FOR_HOMALG_Cat;
    
end );

CATEGORIES_FOR_HOMALG_CREATE_Cat( );

##
InstallImmediateMethod( AsCatObject,
                        IsHomalgCategory,
                        0,
                        
  function( category )
    local cat_obj;
    
    cat_obj := rec( );
    
    ObjectifyWithAttributes( cat_obj, TheTypeOfHomalgCategoriesAsCatObjects,
                             AsHomalgCategory, category );
    
    Add( CATEGORIES_FOR_HOMALG_Cat, cat_obj );
    
    return cat_obj;
    
end );

##
InstallMethod( HomalgFunctor,
               [ IsString, IsHomalgCategory, IsHomalgCategory ],
               
  function( name, source, range )
    local func;
    
    func := rec( );
    
    ObjectifyWithAttributes( func, TheTypeOfHomalgFunctors,
                             Name, name,
                             Source, source,
                             Range, range );
    
    return func;
    
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
               [ IsHomalgCategoryObject ],
               
  function( obj )
    
    if not IsBound( obj!.CatFunctorPreimageList ) then
        
        obj!.CatFunctorPreimageList := rec( );
        
    fi;
    
    return obj!.CatFunctorPreimageList;
    
end );

##
InstallMethod( CatFunctorPreimageList,
               [ IsHomalgCategoryMorphism ],
               
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
               [ IsHomalgFunctor, IsHomalgCategoryObject ],
               
  function( functor, obj )
    local obj_cache, cache_return, computed_value;
    
    if not IsIdenticalObj( HomalgCategory( obj ), Source( functor ) ) then
        
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
    
    Add( Range( functor ), computed_value );
    
    return computed_value;
    
end );

##
InstallMethod( ApplyFunctor,
               [ IsHomalgFunctor, IsHomalgCategoryMorphism ],
               
  function( functor, mor )
    local mor_cache, cache_return, computed_value;
    
    if not IsIdenticalObj( HomalgCategory( mor ), Source( functor ) ) then
        
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
    
    Add( Range( functor ), computed_value );
    
    return computed_value;
    
end );
