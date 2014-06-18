#############################################################################
##
##                                               CategoriesForHomalg package
##
##  Copyright 2013, Sebastian Gutsche, TU Kaiserslautern
##                  Sebastian Posur,   RWTH Aachen
##
## Chapter Product category
##
#############################################################################

DeclareRepresentation( "IsHomalgProductCategoryRep",
                       IsAttributeStoringRep and IsHomalgCategoryRep,
                       [ ] );

BindGlobal( "TheTypeOfHomalgProductCategories",
        NewType( TheFamilyOfHomalgCategories,
                 IsHomalgProductCategoryRep ) );

DeclareRepresentation( "IsHomalgCategoryProductObjectRep",
                       IsAttributeStoringRep and IsHomalgCategoryObjectRep,
                       [ ] );

DeclareRepresentation( "IsHomalgCategoryProductMorphismRep",
                       IsAttributeStoringRep and IsHomalgCategoryMorphismRep,
                       [ ] );

BindGlobal( "TheTypeOfHomalgCategoryProductObjects",
        NewType( TheFamilyOfHomalgCategoryObjects,
                IsHomalgCategoryProductObjectRep ) );

BindGlobal( "TheTypeOfHomalgCategoryProductMorphisms",
        NewType( TheFamilyOfHomalgCategoryMorphisms,
                IsHomalgCategoryProductMorphismRep ) );

###################################
##
## Section Fallback methods for functors
##
###################################

##
InstallMethod( Components,
               [ IsHomalgCategory ],
               
  i -> [ i ] );

##
InstallMethod( Components,
               [ IsHomalgCategoryCell ],
               
  i -> [ i ] );

###################################
##
## Section Constructor
##
###################################

##
InstallMethodWithCache( ProductOp,
                        [ IsList, IsHomalgCategory ],
                        
  function( category_list, selector )
    local product_category, namestring;
    
    namestring := JoinStringsWithSeparator( List( category_list, Name ), ", " );
    
    namestring := Concatenation( "Product of: " , namestring );
    
    product_category := rec( caches := rec( ) );
    
    ObjectifyWithAttributes( product_category, TheTypeOfHomalgProductCategories,
                             Components, category_list,
                             Length, Length( category_list ),
                             Name, namestring
                           );
    
    CREATE_HOMALG_CATEGORY_FILTERS( product_category );
    
    return product_category;
    
end );

##
InstallMethodWithCacheFromObject( ProductOp_OnObjects,
                                  [ IsList, IsHomalgCategory ],
                        
  function( object_list, category )
    local product_object;
    
    product_object := rec( );
    
    ObjectifyWithAttributes( product_object, TheTypeOfHomalgCategoryProductObjects,
                             Components, object_list,
                             Length, Length( object_list )
                           );
    
    Add( category, product_object );
    
    return product_object;
    
end : ArgumentNumber := 2 );

##
InstallMethodWithCacheFromObject( ProductOp_OnMorphisms,
                                  [ IsList, IsHomalgCategory ],
                                  
  function( morphism_list, category )
    local product_morphism;
    
    product_morphism := rec( );
    
    ObjectifyWithAttributes( product_morphism, TheTypeOfHomalgCategoryProductMorphisms,
                             Components, morphism_list,
                             Length, Length( morphism_list )
                           );
    
    Add( category, product_morphism );
    
    return product_morphism;
    
end : ArgumentNumber := 2 );

##
InstallMethod( ProductOp,
               [ IsList, IsHomalgCategoryObject ],
               
  function( object_list, selector )
    
    return ProductOp_OnObjects( object_list, CallFuncList( Product, List( object_list, HomalgCategory ) ) );
    
end );

##
InstallMethod( ProductOp,
               [ IsList, IsHomalgCategoryMorphism ],
               
  function( morphism_list, selector )
    
    return ProductOp_OnMorphisms( morphism_list, CallFuncList( Product, List( morphism_list, HomalgCategory ) ) );
    
end );

##
InstallMethod( \[\],
               [ IsHomalgProductCategoryRep, IsInt ],
               
  function( category, index )
    
    if Length( category ) < index then
        
        Error( "index too high, cannot compute this Component" );
        
    fi;
    
    return Components( category )[ index ];
    
end );

##
InstallMethod( \[\],
               [ IsHomalgCategoryProductObjectRep, IsInt ],
               
  function( object, index )
    
    if Length( object ) < index then
        
        Error( "index too high, cannot compute this Component" );
        
    fi;
    
    return Components( object )[ index ];
    
end );

##
InstallMethod( \[\],
               [ IsHomalgCategoryProductMorphismRep, IsInt ],
               
  function( morphism, index )
    
    if Length( morphism ) < index then
        
        Error( "index too high, cannot compute this Component" );
        
    fi;
    
    return Components( morphism )[ index ];
    
end );

###################################
##
## Section Morphism function
##
###################################

##
InstallMethod( Source,
               [ IsHomalgCategoryProductMorphismRep ],
               
  function( morphism )
    
    return CallFuncList( Product, List( Components( morphism ), Source ) );
    
end );

##
InstallMethod( Range,
               [ IsHomalgCategoryProductMorphismRep ],
               
  function( morphism )
    
    return CallFuncList( Product, List( Components( morphism ), Range ) );
    
end );

##
InstallMethod( PreCompose,
               [ IsHomalgCategoryProductMorphismRep, IsHomalgCategoryProductMorphismRep ],
               
  function( mor_left, mor_right )
    
    return CallFuncList( Product, List( [ 1 .. Length( mor_left ) ], i -> PreCompose( mor_left[ i ], mor_right[ i ] ) ) );
    
end );

###################################
##
## Functors on the product category
##
###################################

InstallImmediateMethod( DirectProductFunctor,
                        IsHomalgCategory and
                        CanComputeProjectionInFirstFactor and
                        CanComputeProjectionInSecondFactor and
                        CanComputeUniversalMorphismIntoDirectProduct and
                        CanComputePreCompose,
                        0,
                        
  function( category )
    local direct_product_functor;
    
    direct_product_functor := HomalgFunctor( "direct_product", Product( category, category ), category );
    
    AddObjectFunction( direct_product_functor,
    
      function( object_pair )
        
        return DirectProductObject( object_pair[ 1 ], object_pair[ 2 ] );
        
    end );
    
    AddMorphismFunction( direct_product_functor,
    
      function( new_source, morphism_pair, new_range )
        local projection_A1, projection_A2;
        
        projection_A1 := ProjectionInFirstFactor( new_source );
        
        projection_A2 := ProjectionInSecondFactor( new_source );
        
        return UniversalMorphismIntoDirectProduct( PreCompose( projection_A1, morphism_pair[ 1 ] ), PreCompose( projection_A2, morphism_pair[ 2 ] ) );
      
   end );
   
   return direct_product_functor;
  
end );


###################################
##
## Section Some hacks
##
###################################

BindGlobal( "HOMALG_CATEGORIES_PRODUCT_SAVE", Product );

MakeReadWriteGlobal( "Product" );

## HEHE!
Product := function( arg )
  
  if ( ForAll( arg, IsHomalgCategory ) or ForAll( arg, IsHomalgCategoryObject ) or ForAll( arg, IsHomalgCategoryMorphism ) ) and Length( arg ) > 0 then
      
      return ProductOp( arg, arg[ 1 ] );
      
  fi;
  
  return CallFuncList( HOMALG_CATEGORIES_PRODUCT_SAVE, arg );
  
end;

MakeReadOnlyGlobal( "Product" );
