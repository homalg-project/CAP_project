#############################################################################
##
##                                               CategoriesForHomalg package
##
##  Copyright 2013, Sebastian Gutsche, TU Kaiserslautern
##                  Sebastian Posur,   RWTH Aachen
##
#! @AutoDoc
#! @Level 1
#! @Chapter Caching objects
##
#############################################################################

DeclareCategory( "IsCachingObject",
                 IsObject );

DeclareGlobalFunction( "CATEGORIES_FOR_HOMALG_SET_ALL_CACHES_CRISP" );

DeclareGlobalFunction( "CATEGORIES_FOR_HOMALG_PREPARE_CACHING_RECORD" );

DeclareGlobalFunction( "SEARCH_WPLIST_FOR_OBJECT" );

DeclareGlobalFunction( "CACHINGOBJECT_HIT" );

DeclareGlobalFunction( "CACHINGOBJECT_MISS" );

DeclareGlobalFunction( "COMPARE_LISTS_WITH_IDENTICAL" );

DeclareGlobalFunction( "CreateWeakCachingObject" );

DeclareGlobalFunction( "CreateCrispCachingObject" );

DeclareGlobalFunction( "InstallMethodWithCache" );

## Weak cache is std.
DeclareSynonym( "InstallMethodWithWeakCache", InstallMethodWithCache );

DeclareGlobalFunction( "InstallMethodWithCrispCache" );

DeclareGlobalFunction( "InstallMethodWithCacheFromObject" );

DeclareOperation( "CachingObject",
                  [ ] );

DeclareOperation( "CachingObject",
                  [ IsObject ] );

DeclareOperation( "CachingObject",
                  [ IsObject, IsObject ] );

DeclareOperation( "CachingObject",
                  [ IsObject, IsObject, IsInt ] );

DeclareOperation( "CachingObject",
                  [ IsObject, IsObject, IsInt, IsBool ] );

DeclareOperation( "Add",
                  [ IsCachingObject, IsInt, IsObject ] );

DeclareOperation( "GetObject",
                  [ IsCachingObject, IsInt ] );

DeclareOperation( "CacheValue",
                  [ IsCachingObject, IsObject ] );

DeclareOperation( "SetCacheValue",
                  [ IsCachingObject, IsObject, IsObject ] );

DeclareOperation( "InstallHasAndSet",
                  [ IsCachingObject, IsString, IsList ] );

DeclareOperation( "InstallHasAndSet",
                  [ IsInt, IsString, IsList ] );

DeclareOperation( "InstallHasAndSet",
                  [ IsBool, IsString, IsList ] );

DeclareOperation( "DeclareOperationWithCache",
                  [ IsString, IsList ] );

