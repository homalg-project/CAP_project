# SPDX-License-Identifier: GPL-2.0-or-later
# CAP: Categories, Algorithms, Programming
#
# Implementations
#

######################################
##
## Reps, types, stuff.
##
######################################

BindGlobal( "TheFamilyOfCapCategoryObjects",
        NewFamily( "TheFamilyOfCapCategoryObjects" ) );

BindGlobal( "TheFamilyOfCapCategoryMorphisms",
        NewFamily( "TheFamilyOfCapCategoryMorphisms" ) );

BindGlobal( "TheFamilyOfCapCategoryTwoCells",
        NewFamily( "TheFamilyOfCapCategoryTwoCells" ) );

######################################
##
## Properties logic
##
######################################

InstallTrueMethod( IsFinite, IsFiniteCategory );

InstallTrueMethod( IsObjectFiniteCategory, IsFiniteCategory );

InstallTrueMethod( IsEquivalentToFiniteCategory, IsFiniteCategory );

InstallTrueMethod( IsCategoryWithInitialObject, IsCategoryWithZeroObject );

InstallTrueMethod( IsCategoryWithTerminalObject, IsCategoryWithZeroObject );

InstallTrueMethod( IsCategoryWithZeroObject, IsAdditiveCategory );

InstallTrueMethod( IsEnrichedOverCommutativeRegularSemigroup, IsAbCategory );

InstallTrueMethod( IsAbCategory, IsLinearCategoryOverCommutativeRing );

InstallTrueMethod( IsLinearCategoryOverCommutativeRing, IsLinearCategoryOverCommutativeRingWithFinitelyGeneratedFreeExternalHoms );

InstallTrueMethod( IsAbCategory, IsAdditiveCategory );

#= comment for Julia
InstallTrueMethod( IsCategoryWithEqualizers, IsAdditiveCategory and IsCategoryWithKernels );

InstallTrueMethod( IsCategoryWithKernels, IsAdditiveCategory and IsCategoryWithEqualizers );

InstallTrueMethod( IsCategoryWithCoequalizers, IsAdditiveCategory and IsCategoryWithCokernels );

InstallTrueMethod( IsCategoryWithCokernels, IsAdditiveCategory and IsCategoryWithCoequalizers );

InstallTrueMethod( IsPreAbelianCategory, IsAdditiveCategory and IsCategoryWithKernels and IsCategoryWithCokernels );
# =#

InstallTrueMethod( IsAdditiveCategory, IsPreAbelianCategory );

InstallTrueMethod( IsCategoryWithKernels, IsPreAbelianCategory );

InstallTrueMethod( IsCategoryWithCokernels, IsPreAbelianCategory );

InstallTrueMethod( IsCategoryWithEqualizers, IsPreAbelianCategory );

InstallTrueMethod( IsCategoryWithCoequalizers, IsPreAbelianCategory );

InstallTrueMethod( IsPreAbelianCategory, IsAbelianCategory );

InstallTrueMethod( IsAbelianCategory, IsAbelianCategoryWithEnoughProjectives );

InstallTrueMethod( IsAbelianCategory, IsAbelianCategoryWithEnoughInjectives );

######################################
##
## Technical stuff
##
######################################

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
    
    cache := fail;
    
    #= comment for Julia
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
        Error( "unrecognized cache type ", cache_type );
    fi;
    
    category!.caches.(name) := cache;
    # =#
    
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


######################################
##
## Reps, types, stuff.
##
######################################

# backwards compatibility
BindGlobal( "IsCapCategoryRep", IsCapCategory );

BindGlobal( "TheFamilyOfCapCategories",
        NewFamily( "TheFamilyOfCapCategories" ) );

BindGlobal( "TheTypeOfCapCategories",
        NewType( TheFamilyOfCapCategories,
                 IsCapCategory ) );


#####################################
##
## Global functions
##
#####################################

##
InstallGlobalFunction( "CreateCapCategoryWithDataTypes", FunctionWithNamedArguments(
  [
    [ "is_computable", true ],
    [ "overhead", true ],
  ],
  function( CAP_NAMED_ARGUMENTS, name, category_filter, object_filter, morphism_filter, two_cell_filter, object_datum_type, morphism_datum_type, two_cell_datum_type )
    local get_attribute_name_for_data_type, filter, obj, operation_name;
    
    get_attribute_name_for_data_type := function ( data_type )
        
        if data_type = fail then
            
            return "AsPrimitiveValue";
            
        elif data_type.filter = IsInt then
            
            return "AsInteger";
            
        elif IsBoundGlobal( "IsHomalgMatrix" ) and data_type.filter = ValueGlobal( "IsHomalgMatrix" ) then
            
            return "AsHomalgMatrix";
            
        else
            
            return "AsPrimitiveValue";
            
        fi;
        
    end;
    
    ## plausibility checks
    if not IsSpecializationOfFilter( IsCapCategory, category_filter ) then
        
        Print( "WARNING: filter ", category_filter, " does not imply `IsCapCategory`. This will probably cause errors.\n" );
        
    fi;
    
    if not IsSpecializationOfFilter( IsCapCategoryObject, object_filter ) then
        
        Print( "WARNING: filter ", object_filter, " does not imply `IsCapCategoryObject`. This will probably cause errors.\n" );
        
    fi;
    
    if not IsSpecializationOfFilter( IsCapCategoryMorphism, morphism_filter ) then
        
        Print( "WARNING: filter ", morphism_filter, " does not imply `IsCapCategoryMorphism`. This will probably cause errors.\n" );
        
    fi;
    
    if not IsSpecializationOfFilter( IsCapCategoryTwoCell, two_cell_filter ) then
        
        Print( "WARNING: filter ", two_cell_filter, " does not imply `IsCapCategoryTwoCell`. This will probably cause errors.\n" );
        
    fi;
    
    if IsFilter( object_datum_type ) then
        
        object_datum_type := rec( filter := object_datum_type );
        
    fi;
    
    if IsFilter( morphism_datum_type ) then
        
        morphism_datum_type := rec( filter := morphism_datum_type );
        
    fi;
    
    if IsFilter( two_cell_datum_type ) then
        
        two_cell_datum_type := rec( filter := two_cell_datum_type );
        
    fi;
    
    filter := NewFilter( Concatenation( name, "InstanceCategoryFilter" ), category_filter );
    
    obj := CreateGapObjectWithAttributes( NewType( TheFamilyOfCapCategories, filter ), Name, name );
    
    ## filters
    SetCategoryFilter( obj, filter );
    
    # object filter
    filter := NewCategory( Concatenation( name, "InstanceObjectFilter" ), object_filter );
    
    SetObjectFilter( obj, filter );
    SetObjectDatumType( obj, object_datum_type );
    
    obj!.object_type := NewType( TheFamilyOfCapCategoryObjects, filter );
    
    obj!.object_attribute_name := get_attribute_name_for_data_type( object_datum_type );
    obj!.object_attribute := ValueGlobal( obj!.object_attribute_name );
    
    # morphism filter
    filter := NewCategory( Concatenation( name, "InstanceMorphismFilter" ), morphism_filter );
    
    SetMorphismFilter( obj, filter );
    SetMorphismDatumType( obj, morphism_datum_type );
    
    obj!.morphism_type := NewType( TheFamilyOfCapCategoryMorphisms, filter );
    
    obj!.morphism_attribute_name := get_attribute_name_for_data_type( morphism_datum_type );
    obj!.morphism_attribute := ValueGlobal( obj!.morphism_attribute_name );
    
    # two cell filter
    filter := NewCategory( Concatenation( name, "InstanceTwoCellFilter" ), two_cell_filter );
    
    SetTwoCellFilter( obj, filter );
    SetTwoCellDatumType( obj, two_cell_datum_type );
    
    obj!.two_cell_type := NewType( TheFamilyOfCapCategoryTwoCells, filter );
    
    ## misc
    SetIsFinalized( obj, false );
    
    # this does not happen in GAP but can happen in Julia
    if CAP_NAMED_ARGUMENTS.is_computable = fail then
        
        CAP_NAMED_ARGUMENTS.is_computable := true;
        
    fi;
    
    obj!.is_computable := CAP_NAMED_ARGUMENTS.is_computable;
    
    obj!.caches := rec( );
    
    for operation_name in CAP_INTERNAL.operation_names_with_cache_disabled_by_default do
        
        obj!.caches.(operation_name) := "none";
        
    od;
    
    obj!.added_functions := rec( );
    
    obj!.operations := rec( );
    
    obj!.timing_statistics := rec( );
    obj!.timing_statistics_enabled := false;
    
    obj!.default_cache_type := CAP_INTERNAL.default_cache_type;
    
    obj!.input_sanity_check_level := 1;
    obj!.output_sanity_check_level := 1;
    
    obj!.predicate_logic_propagation_for_objects := false;
    obj!.predicate_logic_propagation_for_morphisms := false;
    
    obj!.logical_implication_files := StructuralCopy( CATEGORIES_LOGIC_FILES );
    
    obj!.overhead := CAP_NAMED_ARGUMENTS.overhead;
    
    if obj!.overhead then
        
        obj!.predicate_logic := true;
        
    else
        
        obj!.predicate_logic := false;
        
    fi;
    
    obj!.add_primitive_output := false;
    
    obj!.input_sanity_check_functions := rec( );
    
    obj!.cached_precompiled_functions := rec( );
    
    # convenience for Julia lists
    if IsPackageMarkedForLoading( "JuliaInterface", ">= 0.2" ) then
        
        if object_datum_type <> fail and object_datum_type.filter in [ IsList, IsNTuple ] then
            
            InstallOtherMethod( ObjectConstructor,
                                [ CategoryFilter( obj ), ValueGlobal( "IsJuliaObject" ) ],
                                
              function( cat, julia_list )
                
                return ObjectConstructor( cat, ValueGlobal( "ConvertJuliaToGAP" )( julia_list ) );
                
            end );
            
        fi;
        
        if morphism_datum_type <> fail and morphism_datum_type.filter in [ IsList, IsNTuple ] then
            
            InstallOtherMethod( MorphismConstructor,
                                [ ObjectFilter( obj ), ValueGlobal( "IsJuliaObject" ), ObjectFilter( obj ) ],
                                
              function( source, julia_list, range )
                
                return MorphismConstructor( source, ValueGlobal( "ConvertJuliaToGAP" )( julia_list ), range );
                
            end );
            
            InstallOtherMethod( MorphismConstructor,
                                [ CategoryFilter( obj ), ObjectFilter( obj ), ValueGlobal( "IsJuliaObject" ), ObjectFilter( obj ) ],
                                
              function( cat, source, julia_list, range )
                
                return MorphismConstructor( cat, source, ValueGlobal( "ConvertJuliaToGAP" )( julia_list ), range );
                
            end );
            
        fi;
        
    fi;
    
    return obj;
    
end ) );

InstallMethod( TheoremRecord,
               [ IsCapCategory ],
               
  function( category )
    
    return rec( );
    
end );

##
InstallGlobalFunction( ListOfDefiningOperations,
  function( categorical_property )
    
    return DuplicateFreeList( CAP_INTERNAL_CONSTRUCTIVE_CATEGORIES_RECORD.(categorical_property) );
    
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

#= comment for Julia
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
# =#

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
    
    return CreateCapCategory( name, IsCapCategory, IsCapCategoryObject, IsCapCategoryMorphism, IsCapCategoryTwoCell );
    
end );

##
InstallMethod( CreateCapCategory,
               [ IsString, IsFunction, IsFunction, IsFunction, IsFunction ],
  
  FunctionWithNamedArguments(
    [
      [ "is_computable", true ],
      [ "overhead", true ],
    ],
    function( CAP_NAMED_ARGUMENTS, name, category_filter, object_filter, morphism_filter, two_cell_filter )
      
      return CreateCapCategoryWithDataTypes( name, category_filter, object_filter, morphism_filter, two_cell_filter,
                  fail, fail, fail : is_computable := CAP_NAMED_ARGUMENTS.is_computable, overhead := CAP_NAMED_ARGUMENTS.overhead );
      
end ) );

##
InstallMethod( CanCompute,
               [ IsCapCategory, IsString ],
               
  function( category, string )
    local weight_list;
    
    if not IsBound( CAP_INTERNAL_METHOD_NAME_RECORD.(string) ) then
        
        Error( string, " is not the name of a CAP operation" );
        
    fi;
    
    return IsBound( category!.operations.(string) );
    
end );

##
InstallMethod( CanCompute,
               [ IsCapCategory, IsFunction ],
               
  function( category, operation )
    
    Display( "WARNING: calling `CanCompute` with a CAP operation as the second argument should only be done for debugging purposes." );
    
    return CanCompute( category, NameFunction( operation ) );
    
end );

##
InstallMethod( OperationWeight,
               [ IsCapCategory, IsString ],
               
  function( category, op_name )
    
    return category!.operations.(op_name).weight;
    
end );

##
InstallGlobalFunction( ListInstalledOperationsOfCategory,
  
  function( arg )
    local cat, filter, names;
    
    if Length( arg ) < 1 then
        Error( "first argument needs to be <category>" );
    fi;
    
    cat := arg[ 1 ];
    
    if Length( arg ) > 1 then
        filter := arg[ 2 ];
    else
        filter := fail;
    fi;
    
    if IsCapCategoryCell( cat ) then
        cat := CapCategory( cat );
    fi;
    
    if not IsCapCategory( cat ) then
        Error( "input is not a category (cell)" );
    fi;
    
    names := RecNames( cat!.operations );
    
    if filter <> fail then
        names := Filtered( names, i -> PositionSublist( i, filter ) <> fail );
    fi;
    
    return AsSortedList( names );
    
end );

##
InstallGlobalFunction( ListPrimitivelyInstalledOperationsOfCategory,
  
  function( arg )
    local cat, names;
    
    if Length( arg ) < 1 then
        Error( "first argument needs to be <category>" );
    fi;
    
    cat := arg[ 1 ];
    
    names := CallFuncList( ListInstalledOperationsOfCategory, arg );
    
    return Filtered( names, x -> cat!.operations.(x).type = "primitive_installation" );
    
end );

##
InstallMethod( MissingOperationsForConstructivenessOfCategory,
               [ IsCapCategory, IsStringRep ],
               
  function( category, categorical_property )
    local defining_operation, result_list;
    
    if not IsBound( CAP_INTERNAL_CONSTRUCTIVE_CATEGORIES_RECORD.(categorical_property) ) then
      
      Error( "there is no valid categorical property with the name \"", categorical_property, "\", maybe it is defined in an unloaded package\n" );
    
    fi;
    
    result_list := [];
    
    for defining_operation in ListOfDefiningOperations( categorical_property ) do
      
      if not CanCompute( category, defining_operation ) then
        
        Add( result_list, defining_operation );
        
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

if IsPackageMarkedForLoading( "Browse", ">= 1.5" ) then
    
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
      
      if IsList( a ) and IsList( b ) and Length( a ) = Length( b ) then
        
        return ForAll( [ 1 .. Length( a ) ], i -> equality_func(a[i], b[i]) );
        
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
## Print
##
#######################################

InstallMethod( String,
               [ IsCapCategory ],
    Name );

InstallMethod( ViewString,
               [ IsCapCategory ],
    Name );

InstallMethod( DisplayString,
               [ IsCapCategory ],
               
  function ( category )
    
    return Concatenation( "A CAP category with name ", Name( category ), ":\n\n", InfoStringOfInstalledOperationsOfCategory( category ), "\n" );
    
end );

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

InstallMethod( CellFilter,
               [ IsCapCategory ],

  function ( category )
    
    Error( "Categories do not have an attribute `CellFilter` anymore." );
    
end );
