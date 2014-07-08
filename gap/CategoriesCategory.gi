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
    
    return CATEGORIES_FOR_HOMALG_Cat;
    
end );

CATEGORIES_FOR_HOMALG_CREATE_Cat( );

##
InstallMethod( AsCatObject,
               [ IsHomalgCategory ],
  
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
               [ IsString, IsHomalgCategoryAsCatObject, IsHomalgCategory ],
               
  function( name, source, range )
    
    return HomalgFunctor( name, AsHomalgCategory( source ), range );
    
end );

##
InstallMethod( HomalgFunctor,
               [ IsString, IsHomalgCategory, IsHomalgCategoryAsCatObject ],
               
  function( name, source, range )
    
    return HomalgFunctor( name, source, AsHomalgCategory( range ) );
    
end );

##
InstallMethod( HomalgFunctor,
               [ IsString, IsHomalgCategoryAsCatObject, IsHomalgCategoryAsCatObject ],
               
  function( name, source, range )
    
    return HomalgFunctor( name, AsHomalgCategory( source ), AsHomalgCategory( range ) );
    
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
               [ IsHomalgCategoryCell ],
               
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
    
    if not IsIdenticalObj( HomalgCategory( obj ), AsHomalgCategory( Source( functor ) ) ) then
        
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
    
    Add( AsHomalgCategory( Range( functor ) ), computed_value );
    
    return computed_value;
    
end );

##
InstallMethod( ApplyFunctor,
               [ IsHomalgFunctor, IsHomalgCategoryMorphism ],
               
  function( functor, mor )
    local mor_cache, cache_return, computed_value;
    
    if not IsIdenticalObj( HomalgCategory( mor ), AsHomalgCategory( Source( functor ) ) ) then
        
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
    
    Add( AsHomalgCategory( Range( functor ) ), computed_value );
    
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
                                  AsHomalgCategory( Source( left_functor ) ),
                                  AsHomalgCategory( Range( right_functor ) ) );
    
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
    
    new_functor := HomalgFunctor( Concatenation( "Identity functor of ", Name( AsHomalgCategory( category ) ) ),
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
    
    new_functor := HomalgFunctor( Concatenation( "The terminal of ", Name( AsHomalgCategory( category ) ) ), category, CATEGORIES_FOR_HOMALG_TERMINAL_CATEGORY_AS_CAT_OBJECT );
    
    AddObjectFunction( new_functor,
                       
                       function( arg ) return Object( CATEGORIES_FOR_HOMALG_TERMINAL_CATEGORY ); end );
    
    AddMorphismFunction( new_functor,
                         
                         function( arg ) return Morphism( CATEGORIES_FOR_HOMALG_TERMINAL_CATEGORY ); end );
    
    return new_functor;
    
end );

##
AddUniversalMorphismIntoTerminalObjectWithGivenTerminalObject( CATEGORIES_FOR_HOMALG_Cat,
                               
  function( category, cat_obj )
    local new_functor;
    
    new_functor := HomalgFunctor( Concatenation( "The terminal of ", Name( AsHomalgCategory( category ) ) ), category, CATEGORIES_FOR_HOMALG_TERMINAL_CATEGORY_AS_CAT_OBJECT );
    
    AddObjectFunction( new_functor,
                       
                       function( arg ) return Object( CATEGORIES_FOR_HOMALG_TERMINAL_CATEGORY ); end );
    
    AddMorphismFunction( new_functor,
                         
                         function( arg ) return Morphism( CATEGORIES_FOR_HOMALG_TERMINAL_CATEGORY ); end );
    
    return new_functor;
    
end );

##
AddDirectProduct( CATEGORIES_FOR_HOMALG_Cat,
                  
  function( product_of_categories )
    
    return AsCatObject( CallFuncList( Product, List( Components( product_of_categories ), AsHomalgCategory ) ) );
    
end );

##
AddProjectionInFactorWithGivenDirectProduct( CATEGORIES_FOR_HOMALG_Cat,
                            
  function( object_product_list, direct_product, projection_number )
    local projection_functor;
    
    projection_functor := HomalgFunctor( 
      Concatenation( "Projection into ", String( projection_number ),"-th factor of ", Name( AsHomalgCategory( direct_product ) ) ), 
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
                                       
  function( sink, direct_product )
    local name_string, universal_functor;
    
    name_string := Concatenation( 
      "Product functor from ", 
      Name( AsHomalgCategory( Source( sink[1] ) ) ), 
      " to ", 
      Name( AsHomalgCategory( direct_product ) ) 
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
    
    category_list := Components( AsHomalgCategory( Source( functor ) ) );
    
    filter_list := List( category_list, ObjectFilter );
    
    filter_list := List( filter_list, i -> i and IsHomalgCategoryObject );
    
    DeclareOperation( func_name, filter_list );
    
    InstallMethod( ValueGlobal( func_name ),
                   filter_list,
                   
      function( arg )
        local product_object;
        
        product_object := CallFuncList( Product, arg );
        
        return ApplyFunctor( functor, product_object );
        
    end );
    
end );

##
InstallMethod( InstallFunctorOnMorphisms,
               [ IsHomalgFunctor ],
               
  function( functor )
    local func_name, category_list, filter_list;
    
    func_name := MorphismFunctionName( functor );
    
    category_list := Components( AsHomalgCategory( Source( functor ) ) );
    
    filter_list := List( category_list, MorphismFilter );
    
    filter_list := List( filter_list, i -> i and IsHomalgCategoryMorphism );
    
    DeclareOperation( func_name, filter_list );
    
    InstallMethod( ValueGlobal( func_name ),
                   filter_list,
                   
      function( arg )
        local product_object;
        
        product_object := CallFuncList( Product, arg );
        
        return ApplyFunctor( functor, product_object );
        
    end );
    
end );

##
InstallMethod( InstallFunctor,
               [ IsHomalgFunctor ],
               
  function( functor )
    
    InstallFunctorOnObjects( functor );
    
    InstallFunctorOnMorphisms( functor );
    
end );
