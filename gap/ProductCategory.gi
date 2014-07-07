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

InstallMethod( DirectProductFunctor,
               [ IsHomalgCategory, IsInt ],
               
  function( category, number_of_arguments )
    local direct_product_functor;
    
    direct_product_functor := HomalgFunctor( 
      Concatenation( "direct_product_on_", Name( category ), "_for_", String( number_of_arguments ), "_arguments" ),
      CallFuncList( Product, List( [ 1 .. number_of_arguments ], c -> category ) ), 
      category 
    );
    
    AddObjectFunction( direct_product_functor,
    
      function( object )
        
        return CallFuncList( DirectProduct, Components( object ) );
        
    end );
    
    AddMorphismFunction( direct_product_functor,
    
      function( new_source, morphism_list, new_range )
        local sink;
        
        sink := List( [ 1 .. number_of_arguments ], i -> PreCompose( ProjectionInFactor( new_source, i ), morphism_list[i] ) );
        
        return CallFuncList( UniversalMorphismIntoDirectProduct, sink );
        
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
