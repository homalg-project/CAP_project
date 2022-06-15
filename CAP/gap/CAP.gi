# SPDX-License-Identifier: GPL-2.0-or-later
# CAP: Categories, Algorithms, Programming
#
# Implementations
#

######################################
##
## Properties logic
##
######################################

InstallTrueMethod( IsEnrichedOverCommutativeRegularSemigroup, IsAbCategory );

InstallTrueMethod( IsAbCategory, IsAdditiveCategory );

InstallTrueMethod( IsAdditiveCategory, IsPreAbelianCategory );

InstallTrueMethod( IsPreAbelianCategory, IsAbelianCategory );

InstallTrueMethod( IsAbelianCategory, IsAbelianCategoryWithEnoughProjectives );

InstallTrueMethod( IsAbelianCategory, IsAbelianCategoryWithEnoughInjectives );

######################################
##
## Technical stuff
##
######################################

##
InstallValue( CAP_INTERNAL,
                rec(
                    name_counter := 0,
                    default_cache_type := "weak",
                    operation_names_with_cache_disabled_by_default := [
                        # the following operations are needed for comparison in caches
                        "IsEqualForObjects",
                        "IsEqualForMorphisms",
                        "IsEqualForMorphismsOnMor",
                        "IsEqualForCacheForObjects",
                        "IsEqualForCacheForMorphisms",
                        # it is unclear how `IsEqualForCacheForObjects` and `IsEqualForCacheForMorphisms`
                        # would behave on non-well-defined objects/morphisms, so exclude `IsWellDefined*`
                        "IsWellDefinedForObjects",
                        "IsWellDefinedForMorphisms",
                        "IsWellDefinedForTwoCells",
                        # do not cache operations returning random data
                        "RandomObjectByInteger",
                        "RandomMorphismByInteger",
                        "RandomMorphismWithFixedSourceByInteger",
                        "RandomMorphismWithFixedRangeByInteger",
                        "RandomMorphismWithFixedSourceAndRangeByInteger",
                        "RandomObjectByList",
                        "RandomMorphismByList",
                        "RandomMorphismWithFixedSourceByList",
                        "RandomMorphismWithFixedRangeByList",
                        "RandomMorphismWithFixedSourceAndRangeByList",
                        # by default, do not cache constructors and object/morphism data
                        # because in general these operations are cheap,
                        # so caching would not improve the performance
                        "ObjectConstructor",
                        "ObjectDatum",
                        "MorphismConstructor",
                        "MorphismDatum",
                    ],
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
        
        if category!.caches.( name )!.nr_keys <> number then
            
            Error( "you have requested a cache for \"", name, "\" with ", number,
                   " keys but the existing cache with the same name has ", category!.caches.( name )!.nr_keys, " keys" );
            
        fi;
        
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
    elif cache_type = "none" then
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
    
    filter := NewFilter( Concatenation( name, "InternalCategoryFilter" ) );
    
    SetCategoryFilter( category, filter );
    
    SetFilterObj( category, filter );
    
    filter_name := Concatenation( name, "CellFilter" );
    
    cell_filter := NewFilter( filter_name );
    
    SetCellFilter( category, cell_filter );
    
    filter := NewCategory( Concatenation( name, "ObjectFilter" ), cell_filter );
    
    SetObjectFilter( category, filter );
    
    filter := NewCategory( Concatenation( name, "MorphismFilter" ), cell_filter );
    
    SetMorphismFilter( category, filter );
    
    filter := NewCategory( Concatenation( name, "TwoCellFilter" ), cell_filter );
    
    SetTwoCellFilter( category, filter );
    
end );

##
InstallGlobalFunction( "CREATE_CAP_CATEGORY_OBJECT",
                       
  function( obj_rec, attr_list )
    local i, flatted_attribute_list, obj, operation_name;
    
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
    
    obj := CallFuncList( ObjectifyWithAttributes, flatted_attribute_list );
    
    SetIsFinalized( obj, false );
    
    obj!.derivations_weight_list := MakeOperationWeightList( obj, CAP_INTERNAL_DERIVATION_GRAPH );
    
    obj!.caches := rec( );
    
    for operation_name in CAP_INTERNAL.operation_names_with_cache_disabled_by_default do
        
        obj!.caches.(operation_name) := "none";
        
    od;
    
    obj!.redirects := rec( );
    
    obj!.primitive_operations := rec( );

    obj!.added_functions := rec( );
    
    obj!.timing_statistics := rec( );
    obj!.timing_statistics_enabled := false;
    
    obj!.default_cache_type := CAP_INTERNAL.default_cache_type;
    
    obj!.input_sanity_check_level := 1;
    obj!.output_sanity_check_level := 1;
    
    obj!.predicate_logic_propagation_for_objects := false;
    obj!.predicate_logic_propagation_for_morphisms := false;
    
    obj!.predicate_logic := true;
    
    obj!.add_primitive_output := false;
    
    return obj;
    
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
    
    if not IsBound( category!.caches.( function_name ) ) or IsString( category!.caches.( function_name ) ) then
        
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
    
    return GET_METHOD_CACHE( CapCategory( cell ), name, number );
    
end );

##
InstallMethod( CachingObject,
               [ IsCapCategory, IsString, IsInt ],
               
  GET_METHOD_CACHE );

InstallGlobalFunction( SetCachingOfCategory,
  
  function( category, type )
    local current_name;
    
    if not type in [ "weak", "crisp", "none" ] then
        Error( "wrong type for caching" );
    fi;
    
    category!.default_cache_type := type;
    
    for current_name in RecNames( category!.caches ) do
        
        if current_name in CAP_INTERNAL.operation_names_with_cache_disabled_by_default then
            continue;
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


InstallGlobalFunction( SetDefaultCaching,

  function( type )
    local current_name;

    if not type in [ "weak", "crisp", "none" ] then
        Error( "wrong type for caching" );
    fi;

    CAP_INTERNAL.default_cache_type := type;

end );

InstallGlobalFunction( SetDefaultCachingWeak,
  function( )
    SetDefaultCaching( "weak" );
end );

InstallGlobalFunction( SetDefaultCachingCrisp,
  function( )
    SetDefaultCaching( "crisp" );
end );

InstallGlobalFunction( DeactivateDefaultCaching,
  function( )
    SetDefaultCaching( "none" );
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
    local overhead, is_computable, category;
    
    overhead := CAP_INTERNAL_RETURN_OPTION_OR_DEFAULT( "overhead", true );
    
    is_computable := CAP_INTERNAL_RETURN_OPTION_OR_DEFAULT( "is_computable", true );

    category := rec( );
    
    category := CREATE_CAP_CATEGORY_OBJECT( category, [ [ "Name", name ] ] );
    
    category!.overhead := overhead;
    
    category!.is_computable := is_computable;

    CREATE_CAP_CATEGORY_FILTERS( category );
    
    if overhead then
    
      AddCategoryToFamily( category, "general" );
      
    else
      
      category!.predicate_logic := false;
      
    fi;
    
    return category;
    
end );

##
InstallMethod( CanCompute,
               [ IsCapCategory, IsString ],
               
  function( category, string )
    local weight_list;
    
    if not string in RecNames( CAP_INTERNAL_METHOD_NAME_RECORD ) then
        
        Error( string, " is not the name of a CAP operation" );
        
    fi;
    
    weight_list := category!.derivations_weight_list;
    
    return not CurrentOperationWeight( weight_list, string ) = infinity;
    
end );

##
InstallMethod( CanCompute,
               [ IsCapCategory, IsFunction ],
               
  function( category, operation )
    
    Display( "WARNING: calling `CanCompute` with a CAP operation as the second argument should only be done for debugging purposes." );
    
    return CanCompute( category, NameFunction( operation ) );
    
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
## Sanity checks
##
####################################
InstallGlobalFunction( "DisableInputSanityChecks",
  function( category )
    
    category!.input_sanity_check_level := 0;
    
end );
InstallGlobalFunction( "DisableOutputSanityChecks", 
  function( category )
    
    category!.output_sanity_check_level := 0;
    
end );
InstallGlobalFunction( "EnablePartialInputSanityChecks" ,
  function( category )
  
    category!.input_sanity_check_level := 1;
    
end );
InstallGlobalFunction( "EnablePartialOutputSanityChecks" ,
  function( category )
    
    category!.output_sanity_check_level := 1;
    
end );
InstallGlobalFunction( "EnableFullInputSanityChecks" ,
  function( category )
  
    category!.input_sanity_check_level := 2;
     
end );
InstallGlobalFunction( "EnableFullOutputSanityChecks" ,
  function( category )
    
    category!.output_sanity_check_level := 2;
    
end );

InstallGlobalFunction( "DisableSanityChecks" ,
  function( category )
    
    DisableInputSanityChecks( category );
    DisableOutputSanityChecks( category );
     
end );
InstallGlobalFunction( "EnablePartialSanityChecks" ,
  function( category )
    
    EnablePartialInputSanityChecks( category );
    EnablePartialOutputSanityChecks( category );
    
end );
InstallGlobalFunction( "EnableFullSanityChecks" ,
  function( category )
    
    EnableFullInputSanityChecks( category );
    EnableFullOutputSanityChecks( category );
    
end );

####################################
##
## Timing statistics
##
####################################

InstallGlobalFunction( "EnableTimingStatistics",
  function( category )
    
    if category!.overhead <> true then
        
        Display( "WARNING: <category> was created with `overhead := false` and thus cannot collect timing statistics." );
        
    fi;
    
    category!.timing_statistics_enabled := true;
    
end );

InstallGlobalFunction( "DisableTimingStatistics",
  function( category )
    
    if category!.overhead <> true then
        
        Display( "WARNING: <category> was created with `overhead := false` and thus cannot collect timing statistics." );
        
    fi;
    
    category!.timing_statistics_enabled := false;
    
end );

InstallGlobalFunction( "ResetTimingStatistics",
  function( category )
    local recname;
    
    if category!.overhead <> true then
        
        Display( "WARNING: <category> was created with `overhead := false` and thus cannot collect timing statistics." );
        
    fi;
    
    for recname in RecNames( category!.timing_statistics ) do
        
        category!.timing_statistics.(recname) := [ ];
        
    od;
    
end );

BindGlobal( "CAP_INTERNAL_PREPARE_TIMING_STATISTICS_FOR_DISPLAY",
  function( category )
    local header, warning, operations, total_time_global, times, execs, total_time, time_per_exec, recname;
    
    if category!.overhead <> true then
        
        Display( "WARNING: <category> was created with `overhead := false` and thus cannot collect timing statistics." );
        
    fi;
    
    header := Concatenation( "Timing statistics for the primitive operations of the category ", Name( category ), ":" );
    
    operations := [ ];
    
    total_time_global := 0;
    
    for recname in SortedList( RecNames( category!.timing_statistics ) ) do
        
        times := category!.timing_statistics.(recname);
        
        if Length( times ) > 0 then
            
            execs := Length( times );
            total_time := Sum( times );
            time_per_exec := Int( total_time / execs * 1000 );
            
            Add( operations, rec(
                name := recname,
                execs := execs,
                total_time := total_time,
                time_per_exec := time_per_exec,
            ) );
            
            total_time_global := total_time_global + total_time;
            
        fi;
        
    od;
    
    if IsEmpty( operations ) then
        
        warning := "No timing statistics recorded, use `EnableTimingStatistics( <category> )` to enable timing statistics.";
        
    elif not category!.timing_statistics_enabled then
        
        warning := "WARNING: timing statistics for this category are disabled, so the results shown may not be up to date. Use `EnableTimingStatistics( <category> )` to enable timing statistics.";
        
    else
        
        warning := fail;
        
    fi;
    
    return rec(
        header := header,
        warning := warning,
        total_time_global := total_time_global,
        operations := operations,
    );
    
end );

InstallGlobalFunction( "DisplayTimingStatistics",
  function( category )
    local info, operation;
    
    info := CAP_INTERNAL_PREPARE_TIMING_STATISTICS_FOR_DISPLAY( category );
    
    Display( "####" );
    
    if IsEmpty( info.operations ) then
        
        Display( info.warning );
        
        return;
        
    fi;
    
    Display( info.header );
    
    if info.warning <> fail then
        
        Display( info.warning );
        
    fi;
    
    Display( Concatenation( "Total time spent in primitive operations of this category: ", String( info.total_time_global ) , " ms" ) );
    
    for operation in info.operations do
        
        Print(
            operation.name,
            " was called ",
            operation.execs,
            " times with a total runtime of ",
            operation.total_time,
            " ms ( = ",
            operation.time_per_exec,
            " μs per execution)\n"
        );
        
    od;
    
end );

if IsPackageMarkedForLoading( "Browse", ">=0" ) and IsBound( NCurses ) and IsBound( NCurses.BrowseDenseList ) then
    
    InstallGlobalFunction( "BrowseTimingStatistics",
      function( category )
        local info, header, value_matrix, labelsRow, labelsCol, operation;
        
        info := CAP_INTERNAL_PREPARE_TIMING_STATISTICS_FOR_DISPLAY( category );
        
        if IsEmpty( info.operations ) then
            
            Display( info.warning );
            
            return;
            
        fi;
        
        header := [ info.header ];
        
        if info.warning <> fail then
            
            Add( header, info.warning );
            
        fi;
        
        Add( header, Concatenation( "Total time spent in primitive operations of this category: ", String( info.total_time_global ) , " ms" ) );
        Add( header, "" );
        
        value_matrix := [ ];
        labelsRow := [ ];
        labelsCol := [ [ "times called", "total time (ms)", "time per execution (μs)"  ] ];
        
        for operation in info.operations do
            
            Add( labelsRow, [ operation.name ] );
            
            Add( value_matrix, [ operation.execs, operation.total_time, operation.time_per_exec ] );
            
        od;
        
        NCurses.BrowseDenseList( value_matrix, rec( header := header, labelsCol := labelsCol, labelsRow := labelsRow ) );
        
    end );
    
else
    
    InstallGlobalFunction( "BrowseTimingStatistics",
      function( category )
        
        Display( "`BrowseTimingStatistics` needs the function `NCurses.BrowseDenseList`, which should be available in the package \"Browse\"." );
        Display( "Please load \"Browse\" before/together with \"CAP\" or use `DisplayTimingStatistics( <category> )` instead." );
        
    end );
    
fi;

#######################################
##
## Logic
##
#######################################

InstallGlobalFunction( CapCategorySwitchLogicPropagationForObjectsOn,
  
  function( category )
    
    category!.predicate_logic_propagation_for_objects := true;
    
end );

InstallGlobalFunction( CapCategorySwitchLogicPropagationForObjectsOff,
  
  function( category )
    
    category!.predicate_logic_propagation_for_objects := false;
    
end );

InstallGlobalFunction( CapCategorySwitchLogicPropagationForMorphismsOn,
  
  function( category )
    
    category!.predicate_logic_propagation_for_morphisms := true;
    
end );

InstallGlobalFunction( CapCategorySwitchLogicPropagationForMorphismsOff,
  
  function( category )
    
    category!.predicate_logic_propagation_for_morphisms := false;
    
end );

InstallGlobalFunction( CapCategorySwitchLogicPropagationOn,
  
  function( category )
    
    CapCategorySwitchLogicPropagationForObjectsOn( category );
    CapCategorySwitchLogicPropagationForMorphismsOn( category );
    
end );

InstallGlobalFunction( CapCategorySwitchLogicPropagationOff,
  
  function( category )
    
    CapCategorySwitchLogicPropagationForObjectsOff( category );
    CapCategorySwitchLogicPropagationForMorphismsOff( category );
    
end );

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
## Unpacking data structures
##
#######################################

##
InstallMethod( Down, [ IsObject ], IdFunc );

##
InstallMethod( Down, [ IsCapCategoryObject ], x -> "unknown object data" );

##
InstallMethod( Down2, [ IsObject ], x -> Down( Down( x ) ) );

##
InstallMethod( Down3, [ IsObject ], x -> Down( Down( Down( x ) ) ) );

##
InstallMethod( DownOnlyMorphismData, [ IsCapCategoryMorphism ], x -> "unknown morphism data" );

##
InstallMethod( Down,
               [ IsCapCategoryMorphism ],
  function( mor )
    
    return [ Source( mor ), DownOnlyMorphismData( mor ), Range( mor ) ];
    
end );

##
InstallMethod( Down,
               [ IsList ],
               
  function( obj )
    
    return List( obj, Down );
    
end );

##
InstallMethod( DownToBottom,
               [ IsObject ],
               
  function( obj )
    local objp, equality_func;
    
    objp := obj;
    
    equality_func := function( a, b )
      
      if IsList( a ) and IsList( b ) and Size( a ) = Size( b ) then
        
        return ForAll( [ 1 .. Size( a ) ], i -> equality_func(a[i], b[i]) );
        
      else
        
        return IsIdenticalObj( a, b );
        
      fi;
      
    end;
    
    while not equality_func( objp, Down( objp ) ) do
      
      objp := Down( objp );
      
    od;
    
    return objp;
    
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
    
    internal_list := Concatenation( CAP_INTERNAL_CATEGORICAL_PROPERTIES_LIST );
    
    for i in internal_list do
        
        AddNodeToGraph( print_graph, rec( Conditions := i,
                                          TypeOfView := 3,
                                          ComputeLevel := 5 ) );
        
    od;
    
    InstallPrintFunctionsOutOfPrintingGraph( print_graph );
    
end );

InstallMethod( String,
               [ IsCapCategory ],
    Name );

CAP_INTERNAL_INSTALL_PRINT_FUNCTION( );

InstallGlobalFunction( DisableAddForCategoricalOperations,
  
  function( category )
    
    if not IsCapCategory( category ) then
        Error( "Argument must be a category" );
    fi;
    
    category!.add_primitive_output := false;
    
end );

InstallGlobalFunction( EnableAddForCategoricalOperations,
  
  function( category )
    
    if not IsCapCategory( category ) then
        Error( "Argument must be a category" );
    fi;
    
    category!.add_primitive_output := true;
    
end );
