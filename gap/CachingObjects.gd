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

DeclareGlobalFunction( "CATEGORIES_FOR_HOMALG_PREPARE_CACHING_RECORD" );

DeclareGlobalFunction( "SEARCH_WPLIST_FOR_OBJECT" );

DeclareGlobalFunction( "CreateWeakCachingObject" );

DeclareGlobalFunction( "CreateCrispCachingObject" );

DeclareOperation( "CachingObject",
                  [ ] );

DeclareOperation( "CachingObject",
                  [ IsObject ] );

DeclareOperation( "CachingObject",
                  [ IsObject, IsObject ] );

DeclareOperation( "Add",
                  [ IsCachingObject, IsInt, IsObject ] );

DeclareOperation( "GetObject",
                  [ IsCachingObject, IsInt ] );

DeclareOperation( "CacheValue",
                  [ IsCachingObject, IsList ] );

DeclareOperation( "SetCacheValue",
                  [ IsCachingObject, IsList, IsObject ] );
