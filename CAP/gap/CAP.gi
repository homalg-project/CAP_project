#############################################################################
##
##                                               CAP package
##
##  Copyright 2013, Sebastian Gutsche, TU Kaiserslautern
##                  Sebastian Posur,   RWTH Aachen
##
#############################################################################

######################################
##
## Properties logic
##
######################################

InstallTrueMethod( IsEnrichedOverCommutativeRegularSemigroup, IsAbCategory );

InstallTrueMethod( IsAbCategory, IsAdditiveCategory );

InstallTrueMethod( IsAdditiveCategory, IsPreAbelianCategory );

InstallTrueMethod( IsPreAbelianCategory, IsAbelianCategory );


## for monoidal categories
InstallTrueMethod( IsMonoidalCategory, IsBraidedMonoidalCategory );

InstallTrueMethod( IsBraidedMonoidalCategory, IsSymmetricMonoidalCategory );

InstallTrueMethod( IsSymmetricMonoidalCategory, IsSymmetricClosedMonoidalCategory );

InstallTrueMethod( IsSymmetricClosedMonoidalCategory, IsRigidSymmetricClosedMonoidalCategory );

######################################
##
## Technical stuff
##
######################################

##
InstallValue( CAP_INTERNAL,
              rec(
                   name_counter := 0
              )
);

##
InstallGlobalFunction( CAP_INTERNAL_NAME_COUNTER,
                       
  function( )
    local counter;
    
    counter := CAP_INTERNAL.name_counter + 1;
    
    CAP_INTERNAL.name_counter := counter;
    
    return counter;
    
end );

##
InstallGlobalFunction( GET_METHOD_CACHE,
                       
  function( category, name, number )
    local cache, cache_type;
    
    if IsBound( category!.caches.( name ) ) and IsCachingObject( category!.caches.( name ) ) then
        
        return category!.caches.( name );
        
    fi;
    
    if IsBound( category!.caches.( name ) ) and IsString( category!.caches.( name ) ) then
        
        cache_type := category!.caches.( name );
        
    else
        
        cache_type := category!.default_cache_type;
        
    fi;
    
    if cache_type = "weak" then
        cache := CreateWeakCachingObject( number );
    elif cache_type = "crisp" then
        cache := CreateCrispCachingObject( number );
    elif cache_type = "none" or cache_type = "never" then
        cache := CreateCrispCachingObject( number );
        DeactivateCachingObject( cache );
    else
        Error( "unrecognized cache type" );
    fi;
    
    category!.caches.(name) := cache;
    
    return cache;
    
end );

##
InstallGlobalFunction( SET_VALUE_OF_CATEGORY_CACHE,
                       
  function( category, name, number, key, value )
    local cache;
    
    cache := GET_METHOD_CACHE( category, name, number );
    
    SetCacheValue( cache, key, value );
    
end );

##
InstallGlobalFunction( HAS_VALUE_OF_CATEGORY_CACHE,
                       
  function( category, name, number, key, value )
    local cache;
    
    cache := GET_METHOD_CACHE( category, name, number );
    
    return CacheValue( cache, key, value ) <> [ ];
    
end );

InstallValue( CAP_INTERNAL_DERIVATION_GRAPH,
    
    MakeDerivationGraph( [ ] ) );


######################################
##
## Reps, types, stuff.
##
######################################

DeclareRepresentation( "IsCapCategoryRep",
                       IsAttributeStoringRep and IsCapCategory,
                       [ ] );

BindGlobal( "TheFamilyOfCapCategories",
        NewFamily( "TheFamilyOfCapCategories" ) );

BindGlobal( "TheTypeOfCapCategories",
        NewType( TheFamilyOfCapCategories,
                 IsCapCategoryRep ) );


#####################################
##
## Global functions
##
#####################################

##
InstallGlobalFunction( CREATE_CAP_CATEGORY_FILTERS,
                       
  function( category )
    local name, cell_filter, filter_name, filter;
    
    name := Name( category );
    
    filter_name := NewFilter( Concatenation( name, "InternalCategoryFilter" ) );
    
    SetCategoryFilter( category, filter_name );
    
    SetFilterObj( category, filter_name );
    
    filter_name := Concatenation( name, "CellFilter" );
    
    cell_filter := NewFilter( filter_name );
    
    SetCellFilter( category, cell_filter );
    
    filter_name := NewFilter( Concatenation( name, "ObjectFilter" ) );
    
    InstallTrueMethod( cell_filter, filter_name );
    
    SetObjectFilter( category, filter_name );
    
    filter_name := NewFilter( Concatenation( name, "MorphismFilter" ) );
    
    InstallTrueMethod( cell_filter, filter_name );
    
    SetMorphismFilter( category, filter_name );
    
    filter_name := NewFilter( Concatenation( name, "TwoCellFilter" ) );
    
    InstallTrueMethod( cell_filter, filter_name );
    
    SetTwoCellFilter( category, filter_name );
    
end );

##
InstallGlobalFunction( "CREATE_CAP_CATEGORY_OBJECT",
                       
  function( obj_rec, attr_list )
    local i, flatted_attribute_list;
    
    for i in [ 1 .. Length( attr_list ) ] do
        
        if IsString( attr_list[ i ][ 1 ] ) then
            
            attr_list[ i ][ 1 ] := ValueGlobal( attr_list[ i ][ 1 ] );
            
        fi;
        
    od;
    
    flatted_attribute_list := [ ];
    
    for i in attr_list do
        
        Add( flatted_attribute_list, i[ 1 ] );
        
        Add( flatted_attribute_list, i[ 2 ] );
        
    od;
    
    flatted_attribute_list := Concatenation( [ obj_rec, TheTypeOfCapCategories ], flatted_attribute_list );
    
    
    obj_rec!.logical_implication_files := StructuralCopy( CATEGORIES_LOGIC_FILES );
    
    CallFuncList( ObjectifyWithAttributes, flatted_attribute_list );
    
    obj_rec!.derivations_weight_list := MakeOperationWeightList( obj_rec, CAP_INTERNAL_DERIVATION_GRAPH );
    
    obj_rec!.caches := rec( IsEqualForObjects := "never",
                            IsEqualForMorphisms := "never",
                            IsEqualForMorphismsOnMor := "never",
                            IsEqualForCacheForObjects := "never",
                            IsEqualForCacheForMorphisms := "never" );
    
    obj_rec!.redirects := rec( );
    
    obj_rec!.primitive_operations := rec( );
    
    obj_rec!.default_cache_type := "weak";
    
    obj_rec!.prefunction_check := true;
    
    obj_rec!.predicate_logic := true;
    
    return obj_rec;
    
end );

InstallMethod( TheoremRecord,
               [ IsCapCategory ],
               
  function( category )
    
    return rec( );
    
end );

######################################################
##
## Add functions
##
######################################################

InstallMethod( AddCategoryToFamily,
               [ IsCapCategory, IsString ],
               
  function( category, family )
    
    if not IsBound( category!.families ) then
        
        category!.families := [ ];
        
    fi;
    
    Add( category!.families, LowercaseString( family ) );
    
end );

####################################
##
## Inverse
##
####################################

##
InstallMethod( AddInverse,
               [ IsCapCategory, IsFunction ],
               AddInverseImmutable );

##
InstallMethod( AddInverse,
               [ IsCapCategory, IsFunction, IsInt ],
               AddInverseImmutable );

##
InstallMethod( AddInverse,
               [ IsCapCategory, IsList ],
               AddInverseImmutable );

##
InstallMethod( AddInverse,
               [ IsCapCategory, IsList, IsInt ],
               AddInverseImmutable );

#######################################
##
## Caching
##
#######################################

##
InstallMethod( SetCaching,
               [ IsCapCategory, IsString, IsString ],
               
  function( category, function_name, caching_info )
    local current_cache;
    
    if not caching_info in [ "weak", "crisp", "none" ] then
        
        Error( "wrong caching type" );
        
    fi;
    
    if not IsBound( category!.caches.( function_name ) ) or
        ( IsString( category!.caches.( function_name ) ) and category!.caches.( function_name ) <> "never" ) then
        
        category!.caches.( function_name ) := caching_info;
        
    elif IsCachingObject( category!.caches.( function_name ) ) then
        
        current_cache := category!.caches.( function_name );
        
        if caching_info = "weak" then
            SetCachingObjectWeak( current_cache );
        elif caching_info = "crisp" then
            SetCachingObjectCrisp( current_cache );
        elif caching_info = "none" then
            DeactivateCachingObject( current_cache );
        fi;
        
    fi;
    
end );

##
InstallMethod( SetCachingToWeak,
               [ IsCapCategory, IsString ],
               
  function( category, function_name )
    
    SetCaching( category, function_name, "weak" );
    
end );

##
InstallMethod( SetCachingToCrisp,
               [ IsCapCategory, IsString ],
               
  function( category, function_name )
    
    SetCaching( category, function_name, "crisp" );
    
end );

##
InstallMethod( DeactivateCaching,
               [ IsCapCategory, IsString ],
               
  function( category, function_name )
    
    SetCaching( category, function_name, "none" );
    
end );

##
InstallMethod( CachingObject,
               [ IsCapCategoryCell, IsString, IsInt ],
               
  function( cell, name, number )
    local category, cache;
    
    return GET_METHOD_CACHE( CapCategory( cell ), name, number );
    
end );

##
InstallMethod( CachingObject,
               [ IsCapCategory, IsString, IsInt ],
               
  function( category, name, number )
    
    return GET_METHOD_CACHE( category, name, number );
    
end );

InstallGlobalFunction( SetCachingOfCategory,
  
  function( category, type )
    local current_name;
    
    if not type in [ "weak", "crisp", "none" ] then
        Error( "wrong type for caching" );
    fi;
    
    category!.default_cache_type := type;
    
    for current_name in RecNames( category!.caches ) do
        
        if current_name in [ "IsEqualForMorphisms", "IsEqualForObjects", "IsEqualForMorphismsOnMor", "IsEqualForCacheForMorphisms", "IsEqualForCacheForObjects" ] then
            continue; ## Those are needed for comparison in caches
        fi;
        
        SetCaching( category, current_name, type );
        
    od;
    
end );

InstallGlobalFunction( SetCachingOfCategoryWeak,
  
  function( category )
    
    SetCachingOfCategory( category, "weak" );
    
end );

InstallGlobalFunction( SetCachingOfCategoryCrisp,
  
  function( category )
    
    SetCachingOfCategory( category, "crisp" );
    
end );

InstallGlobalFunction( DeactivateCachingOfCategory,
  
  function( category )
    
    SetCachingOfCategory( category, "none" );
    
end );


#######################################
##
## Constructors
##
#######################################

##
InstallMethod( CreateCapCategory,
               [ ],
               
  function( )
    local name;
    
    name := Concatenation( "AutomaticCapCategory", String( CAP_INTERNAL_NAME_COUNTER( ) ) );
    
    return CreateCapCategory( name );
    
end );

##
InstallMethod( CreateCapCategory,
               [ IsString ],
               
  function( name )
    local category;
    
    category := rec( );
    
    category := CREATE_CAP_CATEGORY_OBJECT( category, [ [ "Name", name ] ] );
    
    CREATE_CAP_CATEGORY_FILTERS( category );
    
    AddCategoryToFamily( category, "general" );
    
    INSTALL_LOGICAL_IMPLICATIONS_HELPER( category, "General" );
    
    return category;
    
end );

InstallMethod( CanCompute,
               [ IsCapCategory, IsString ],
               
  function( category, string )
    local weight_list;
    
    if not string in RecNames( CAP_INTERNAL_METHOD_NAME_RECORD ) then
        
        Error( "string is not the name of an operation" );
        
    fi;
    
    weight_list := category!.derivations_weight_list;
    
    return not CurrentOperationWeight( weight_list, string ) = infinity;
    
end );

##
InstallMethod( CheckConstructivenessOfCategory,
               [ IsCapCategory, IsString ],
               
  function( category, string )
    local category_property, result_list;
    
    if not string in RecNames( CAP_INTERNAL_CONSTRUCTIVE_CATEGORIES_RECORD ) then
      
      Error( "the given string is not a property of a category" );
    
    fi;
    
    result_list := [];
    
    for category_property in CAP_INTERNAL_CONSTRUCTIVE_CATEGORIES_RECORD.(string) do
      
      if not CanCompute( category, category_property ) then
        
        Add( result_list, category_property );
        
      fi;
      
    od;
    
    return result_list;
    
end );

####################################
##
## Type check
##
####################################

InstallGlobalFunction( DisableBasicOperationTypeCheck,
  
  function( category )
    
    category!.prefunction_check := false;
    
end );

InstallGlobalFunction( EnableBasicOperationTypeCheck,
  
  function( category )
  
    category!.prefunction_check := true;
    
end );

#######################################
##
## Logic
##
#######################################

InstallGlobalFunction( CapCategorySwitchLogicOn,
  
  function( category )
    
    category!.predicate_logic := true;
    
end );

InstallGlobalFunction( CapCategorySwitchLogicOff,
  
  function( category )
    
    category!.predicate_logic := false;
    
end );

#######################################
##
## ViewObj
##
#######################################

InstallGlobalFunction( CAP_INTERNAL_INSTALL_PRINT_FUNCTION,
               
  function( )
    local print_graph, category_function, i, internal_list;
    
    category_function := function( category )
      local string;
      
      string := "CAP category";
      
      if HasName( category ) then
          
          Append( string, " with name " );
          
          Append( string, Name( category ) );
          
      fi;
      
      return string;
      
    end;
    
    print_graph := CreatePrintingGraph( IsCapCategory, category_function );
    
    internal_list := CAP_INTERNAL_CAN_COMPUTE_FILTER_LIST.MathematicalPropertiesOfCategories;
    
    for i in internal_list do
        
        AddNodeToGraph( print_graph, rec( Conditions := i,
                                          TypeOfView := 3,
                                          ComputeLevel := 5 ) );
        
    od;
    
    InstallPrintFunctionsOutOfPrintingGraph( print_graph );
    
end );

CAP_INTERNAL_INSTALL_PRINT_FUNCTION( );
