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

DeclareRepresentation( "IsHomalgCategoryProductCellRep",
                       IsAttributeStoringRep and IsHomalgCategoryCell,
                       [ ] );

DeclareRepresentation( "IsHomalgCategoryProductObjectRep",
                       IsHomalgCategoryProductCellRep and IsHomalgCategoryObjectRep,
                       [ ] );

DeclareRepresentation( "IsHomalgCategoryProductMorphismRep",
                       IsHomalgCategoryProductCellRep and IsHomalgCategoryMorphismRep,
                       [ ] );

DeclareRepresentation( "IsHomalgCategoryProductTwoCellRep",
                       IsHomalgCategoryProductCellRep and IsHomalgCategoryTwoCellRep,
                       [ ] );

BindGlobal( "TheTypeOfHomalgCategoryProductObjects",
        NewType( TheFamilyOfHomalgCategoryObjects,
                IsHomalgCategoryProductObjectRep ) );

BindGlobal( "TheTypeOfHomalgCategoryProductMorphisms",
        NewType( TheFamilyOfHomalgCategoryMorphisms,
                IsHomalgCategoryProductMorphismRep ) );

BindGlobal( "TheTypeOfHomalgCategoryProductTwoCells",
        NewType( TheFamilyOfHomalgCategoryTwoCells,
                IsHomalgCategoryProductTwoCellRep ) );

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
InstallMethodWithCacheFromObject( ProductOp,
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
    
end : ArgumentNumber := 2 );

##
InstallMethodWithCacheFromObject( ProductOp_OnObjects,
                                  [ IsList, IsHomalgCategory ],
                        
  function( object_list, category )
    local product_object, entry, i;
    
    product_object := rec( );
    
    ObjectifyWithAttributes( product_object, TheTypeOfHomalgCategoryProductObjects,
                             Components, object_list,
                             Length, Length( object_list )
                           );
    
    Add( category, product_object );
    
    entry := List( object_list, i -> [ i, "IsWellDefined", true ] );
    
    entry := ToDoListEntry( entry, product_object, "IsWellDefined", true );
    
    AddToToDoList( entry );
    
    for i in object_list do
        
        AddToToDoList( ToDoListEntry( [ [ i, "IsWellDefined", false ] ], product_object, "IsWellDefined", false ) );
        
    od;
    
    return product_object;
    
end : ArgumentNumber := 2 );

##
InstallMethodWithCacheFromObject( ProductOp_OnMorphisms,
                                  [ IsList, IsHomalgCategory ],
                                  
  function( morphism_list, category )
    local product_morphism, entry, i;
    
    product_morphism := rec( );
    
    ObjectifyWithAttributes( product_morphism, TheTypeOfHomalgCategoryProductMorphisms,
                             Components, morphism_list,
                             Length, Length( morphism_list )
                           );
    
    Add( category, product_morphism );
    
    entry := List( morphism_list, i -> [ i, "IsWellDefined", true ] );
    
    entry := ToDoListEntry( entry, product_morphism, "IsWellDefined", true );
    
    AddToToDoList( entry );
    
    for i in morphism_list do
        
        AddToToDoList( ToDoListEntry( [ [ i, "IsWellDefined", false ] ], product_morphism, "IsWellDefined", false ) );
        
    od;
    
    return product_morphism;
    
end : ArgumentNumber := 2 );

##
InstallMethodWithCacheFromObject( ProductOp_OnTwoCells,
                                  [ IsList, IsHomalgCategory ],
                                  
  function( twocell_list, category )
    local product_twocell;
    
    product_twocell := rec( );
    
    ObjectifyWithAttributes( product_twocell, TheTypeOfHomalgCategoryProductTwoCells,
                             Components, twocell_list,
                             Length, Length( twocell_list )
                           );
    
    Add( category, product_twocell );
    
    return product_twocell;
    
end : ArgumentNumber := 2 );

##
InstallMethod( ProductOp,
               [ IsList, IsHomalgCategoryObject ],
               
  function( object_list, selector )
    local category_list;
    
    category_list := List( object_list, HomalgCategory );
    
    return ProductOp_OnObjects( object_list, ProductOp( category_list, category_list[ 1 ] ) );
    
end );

##
InstallMethod( ProductOp,
               [ IsList, IsHomalgCategoryMorphism ],
               
  function( morphism_list, selector )
    local category_list;
    
    category_list := List( morphism_list, HomalgCategory );
    
    return ProductOp_OnMorphisms( morphism_list, ProductOp( category_list, category_list[ 1 ] ) );
    
end );

##
InstallMethod( ProductOp,
               [ IsList, IsHomalgCategoryTwoCellRep ],
               
  function( twocell_list, selector )
    local category_list;
    
    category_list := List( twocell_list, HomalgCategory );
    
    return ProductOp_OnMorphisms( twocell_list, ProductOp( category_list, category_list[ 1 ] ) );
    
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
               [ IsHomalgCategoryProductCellRep, IsInt ],
               
  function( cell, index )
    
    if Length( cell ) < index then
        
        Error( "index too high, cannot compute this Component" );
        
    fi;
    
    return Components( cell )[ index ];
    
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
InstallMethodWithToDoForIsWellDefined( PreCompose,
                                       [ IsHomalgCategoryProductMorphismRep, IsHomalgCategoryProductMorphismRep ],
                                       
  function( mor_left, mor_right )
    local left_comp, right_comp;
    
    left_comp := Components( mor_left );
    
    right_comp := Components( mor_right );
    
    return CallFuncList( Product, List( [ 1 .. Length( mor_left ) ], i -> PreCompose( left_comp[ i ], right_comp[ i ] ) ) );
    
end : InstallMethod := InstallMethodWithCacheFromObject);

##
InstallMethod( Source,
               [ IsHomalgCategoryProductTwoCellRep ],
               
  function( twocell )
    
    return CallFuncList( Product, List( Components( twocell ), Source ) );
    
end );

##
InstallMethod( Range,
               [ IsHomalgCategoryProductMorphismRep ],
               
  function( twocell )
    
    return CallFuncList( Product, List( Components( twocell ), Range ) );
    
end );

##
InstallMethodWithToDoForIsWellDefined( HorizontalPreCompose,
                                       [ IsHomalgCategoryProductTwoCellRep, IsHomalgCategoryProductTwoCellRep ],
               
  function( twocell_left, twocell_right )
    local left_comp, right_comp;
    
    left_comp := Components( twocell_left );
    
    right_comp := Components( twocell_right );
    
    return CallFuncList( Product, List( [ 1 .. Length( twocell_left ) ], i -> HorizontalPreCompose( left_comp[ i ], right_comp[ i ] ) ) );
    
end : InstallMethod := InstallMethodWithCacheFromObject);

##
InstallMethodWithToDoForIsWellDefined( VerticalPreCompose,
                                       [ IsHomalgCategoryProductTwoCellRep, IsHomalgCategoryProductTwoCellRep ],
               
  function( twocell_left, twocell_right )
    local left_comp, right_comp;
    
    left_comp := Components( twocell_left );
    
    right_comp := Components( twocell_right );
    
    return CallFuncList( Product, List( [ 1 .. Length( twocell_left ) ], i -> VerticalPreCompose( left_comp[ i ], right_comp[ i ] ) ) );
    
end : InstallMethod := InstallMethodWithCacheFromObject );


###################################
##
## Functors on the product category
##
###################################

##
InstallMethodWithCache( DirectProductFunctor,
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
        local source;
        
        source := List( [ 1 .. number_of_arguments ], i -> PreCompose( ProjectionInFactor( new_source, i ), morphism_list[i] ) );
        
        return CallFuncList( UniversalMorphismIntoDirectProduct, source );
        
   end );
   
   return direct_product_functor;
   
end );

##
InstallMethodWithCache( CoproductFunctor,
                        [ IsHomalgCategory, IsInt ],
               
  function( category, number_of_arguments )
    local coproduct_functor;
    
    coproduct_functor := HomalgFunctor( 
      Concatenation( "coproduct_on_", Name( category ), "_for_", String( number_of_arguments ), "_arguments" ),
      CallFuncList( Product, List( [ 1 .. number_of_arguments ], c -> category ) ), 
      category 
    );
    
    AddObjectFunction( coproduct_functor,
    
      function( object )
        
        return CallFuncList( Coproduct, Components( object ) );
        
    end );
    
    AddMorphismFunction( coproduct_functor,
    
      function( new_source, morphism_list, new_range )
        local sink;
        
        sink := List( [ 1 .. number_of_arguments ], i -> PreCompose( morphism_list[i], InjectionOfCofactor( new_range, i ) ) );
        
        return CallFuncList( UniversalMorphismFromCoproduct, sink );
        
   end );
   
   return coproduct_functor;
   
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

##
InstallMethod( IsEqualForCache,
               [ IsHomalgProductCategoryRep, IsHomalgProductCategoryRep ],
               
  function( category1, category2 )
    local list1, list2, length;
    
    list1 := Components( category1 );
    
    list2 := Components( category2 );
    
    length := Length( list1 );
    
    if length <> Length( list2 ) then
        
        return false;
        
    fi;
    
    return ForAll( [ 1 .. length ], i -> IsIdenticalObj( list1[ i ], list2[ i ] ) );
    
end );

##
InstallMethod( IsEqualForCache,
               [ IsHomalgCategoryProductCellRep, IsHomalgCategoryProductCellRep ],
               
  function( obj1, obj2 )
    local list1, list2, length;
    
    list1 := Components( obj1 );
    
    list2 := Components( obj2 );
    
    length := Length( list1 );
    
    if length <> Length( list2 ) then
        
        return false;
        
    fi;
    
    return ForAll( [ 1 .. length ], i -> IsIdenticalObj( list1[ i ], list2[ i ] ) );
    
end );
