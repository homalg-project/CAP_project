#############################################################################
##
##                                               CategoriesForHomalg package
##
##  Copyright 2013, Sebastian Gutsche, TU Kaiserslautern
##                  Sebastian Posur,   RWTH Aachen
##
#############################################################################

##
InstallValue( CATEGORIES_FOR_HOMALG,
              rec(
                   name_counter := 0
              )
);

##
InstallGlobalFunction( CATEGORIES_FOR_HOMALG_NAME_COUNTER,
                       
  function( )
    local counter;
    
    counter := CATEGORIES_FOR_HOMALG.name_counter + 1;
    
    CATEGORIES_FOR_HOMALG.name_counter := counter;
    
    return counter;
    
end );

##
InstallGlobalFunction( DECIDE_INSTALL_FUNCTION,
                       
  function( category, method, number_parameters )
    local caching_info, cache;
    
    if IsBound( category!.caches.( method ) ) then
        
        PushOptions( rec( Cache := category!.caches.( method ) ) );
        
        return;
        
    fi;
    
    if not IsBound( category!.caching_info.( method ) ) then
        
        category!.caching_info.( method ) := "weak";
        
    fi;
    
    caching_info := category!.caching_info.( method );
    
    if caching_info = "weak" then
        
        cache := CachingObject( category, method, number_parameters );
        
        category!.caches.( method ) := cache;
        
        PushOptions( rec( Cache := cache ) );
        
        return;
        
    elif caching_info = "crisp" then
        
        cache := CachingObject( category, method, number_parameters, true );
        
        category!.caches.( method ) := cache;
        
        PushOptions( rec( Cache := cache ) );
        
        return;
        
    elif caching_info = "none" then
        
        PushOptions( rec( Cache := false ) );
        
        return;
        
    else
        
        Error( "wrong type of install function" );
        
    fi;
    
end );

######################################
##
## Reps, types, stuff.
##
######################################

DeclareRepresentation( "IsHomalgCategoryRep",
                       IsAttributeStoringRep and IsHomalgCategory,
                       [ ] );

BindGlobal( "TheFamilyOfHomalgCategories",
        NewFamily( "TheFamilyOfHomalgCategories" ) );

BindGlobal( "TheTypeOfHomalgCategories",
        NewType( TheFamilyOfHomalgCategories,
                 IsHomalgCategoryRep ) );


#####################################
##
## Global functions
##
#####################################

##
InstallGlobalFunction( CREATE_HOMALG_CATEGORY_FILTERS,
                       
  function( category )
    local name, filter_name, filter;
    
    name := Name( category );
    
    filter_name := Concatenation( name, "ObjectFilter" );
    
    SetObjectFilter( category, NewFilter( filter_name ) );
    
    filter_name := Concatenation( name, "MorphismFilter" );
    
    SetMorphismFilter( category, NewFilter( filter_name ) );
    
end );

##
InstallGlobalFunction( "CREATE_HOMALG_CATEGORY_OBJECT",
                       
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
    
    flatted_attribute_list := Concatenation( [ obj_rec, TheTypeOfHomalgCategories ], flatted_attribute_list );
    
    CallFuncList( ObjectifyWithAttributes, flatted_attribute_list );
    
    obj_rec!.caches := rec( );
    
    return obj_rec;
    
end );

#####################################
##
## Category stored object functions
##
#####################################

##
InstallMethodWithToDoForIsWellDefined( ZeroObject,
                                       [ IsHomalgCategory ],
                                       
  function( category )
    local zero_obj;
    
    if not IsBound( category!.zero_object_constructor ) then
        
        Error( "no possibility to construct zero object" );
        
    fi;
    
    zero_obj := category!.zero_object_constructor();
    
    Add( category, zero_obj );
    
    SetIsZero( zero_obj, true );
    
    return zero_obj;
    
end );

######################################################
##
## Add functions
##
######################################################

#######################################
##
## IdentityMorphism
##
#######################################

##
InstallMethod( AddIdentityMorphism,
               [ IsHomalgCategory, IsFunction ],
               
  function( category, func )
    
    SetIdentityMorphismFunction( category, func );
    
    SetCanComputeIdentityMorphism( category, true );
    
      InstallMethodWithToDoForIsWellDefined( IdentityMorphism,
                                             [ IsHomalgCategoryObject and ObjectFilter( category ) ],
                                             
      function( object )
        local ret_val;
        
        ret_val := func( object );
        
        Add( category, ret_val );
        
        SetIsOne( ret_val, true );
        
        SetInverse( ret_val, ret_val );
        
        return ret_val;
        
      end );
    
end );

#######################################
##
## PreCompose
##
#######################################

##
InstallMethod( AddPreCompose,
               [ IsHomalgCategory, IsFunction ],
               
  function( category, func )
    
    SetPreComposeFunction( category, func );
    
    SetCanComputePreCompose( category, true );
    
    DECIDE_INSTALL_FUNCTION( category, "PreCompose", 2 );
    
    InstallMethodWithToDoForIsWellDefined( PreCompose,
                                           [ IsHomalgCategoryMorphism and MorphismFilter( category ), IsHomalgCategoryMorphism and MorphismFilter( category ) ],
                   
      function( mor_left, mor_right )
        local ret_val;
        
        if not IsIdenticalObj( HomalgCategory( mor_left ), HomalgCategory( mor_right ) ) then
            
            Error( "morphisms must lie in the same category" );
            
        elif not IsIdenticalObj( Range( mor_left ), Source( mor_right ) ) then
            
            Error( "morphisms not composable" );
            
        fi;
        
        ret_val := func( mor_left, mor_right );
        
        Add( category, ret_val );
        
        return ret_val;
        
      end : InstallMethod := InstallMethodWithCache );
    
end );

#######################################
##
## Zero object
##
#######################################

InstallMethod( AddZeroObject,
               [ IsHomalgCategory, IsFunction ],
               
  function( category, func )
    
    category!.zero_object_constructor := func;
    
    SetZeroObjectFunction( category, func );
    
    SetCanComputeZeroObject( category, true );
    
end );

##
InstallMethod( ZeroObject,
               [ IsHomalgCategoryCell ],
               
  function( cell )
    
    return ZeroObject( HomalgCategory( cell ) );
    
end );



##
InstallMethod( AddMorphismIntoZeroObject,
               [ IsHomalgCategory, IsFunction ],
               
  function( category, func )
    
    SetMorphismIntoZeroObjectFunction( category, func );
    
    SetCanComputeMorphismIntoZeroObject( category, true );
    
    InstallMethodWithToDoForIsWellDefined( MorphismIntoZeroObject,
                                           [ IsHomalgCategoryObject and ObjectFilter( category ) ],
                                           
      function( object )
        local morphism;
        
        morphism := func( object );
        
        Add( category, morphism );
        
        return morphism;
        
    end );
    
end );

##
InstallMethod( AddMorphismFromZeroObject,
               [ IsHomalgCategory, IsFunction ],
               
  function( category, func )
    
    SetMorphismFromZeroObjectFunction( category, func );
    
    SetCanComputeMorphismFromZeroObject( category, true );
    
    InstallMethodWithToDoForIsWellDefined( MorphismFromZeroObject,
                                           [ IsHomalgCategoryObject and ObjectFilter( category ) ],
                                           
      function( object )
        local morphism;
        
        morphism := func( object );
        
        Add( category, morphism );
        
        return morphism;
        
    end );
    
end );

#######################################
##
## Direct sum
##
#######################################

## HERE
InstallMethod( AddDirectSum_OnObjects,
               [ IsHomalgCategory, IsFunction ],
               
  function( category, func )
    
    DECIDE_INSTALL_FUNCTION( category, "DirectSum", 2 );
    
    SetDirectSum_OnObjectsFunction( category, func );
    
    SetCanComputeDirectSum( category, true );
    
    InstallMethodWithToDoForIsWellDefined( DirectSumOp,
                                           [ IsList, IsHomalgCategoryObject and ObjectFilter( category ) ],
                   
      function( obj_list, obj1 )
        local obj2, sum_obj;
        
        if not Length( obj_list ) = 2 then
            
            Error( "there must be two objects for a direct sum" );
            
        fi;
        
        obj2 := obj_list[ 2 ];
        
        if not IsIdenticalObj( HomalgCategory( obj1 ), HomalgCategory( obj2 ) ) then
            
            Error( "Objects must lie in the same category" );
            
        fi;
        
        sum_obj := func( obj1, obj2 );
        
        SetFirstSummand( sum_obj, obj1 );
        
        SetSecondSummand( sum_obj, obj2 );
        
        Add( HomalgCategory( obj1 ), sum_obj );
        
        return sum_obj;
        
    end : InstallMethod := InstallMethodWithCache );
    
end );

##
InstallMethod( AddInjectionFromFirstSummand,
               [ IsHomalgCategory, IsFunction ],
               
  function( category, func )
    
    SetInjectionFromFirstSummandFunction( category, func );
    
    SetCanComputeInjectionFromFirstSummand( category, true );
    
    InstallMethodWithToDoForIsWellDefined( InjectionFromFirstSummand,
                                           [ IsHomalgCategoryObject and ObjectFilter( category ) and WasCreatedAsDirectSum ],
                                           
      function( sum_obj )
        local injection1;
        
        injection1 := func( sum_obj );
        
        Add( HomalgCategory( sum_obj ), injection1 );
        
        return injection1;
        
    end );
    
end );

##
InstallMethod( AddInjectionFromSecondSummand,
               [ IsHomalgCategory, IsFunction ],
               
  function( category, func )
    
    SetInjectionFromSecondSummandFunction( category, func );
    
    SetCanComputeInjectionFromSecondSummand( category, true );
    
    InstallMethodWithToDoForIsWellDefined( InjectionFromSecondSummand,
                                           [ IsHomalgCategoryObject and ObjectFilter( category ) and WasCreatedAsDirectSum ],
                                           
      function( sum_obj )
        local injection1;
        
        injection1 := func( sum_obj );
        
        Add( HomalgCategory( sum_obj ), injection1 );
        
        return injection1;
        
    end );
    
end );

##
InstallMethod( AddProjectionInFirstFactor,
               [ IsHomalgCategory, IsFunction ],
               
  function( category, func )
    
    SetProjectionInFirstFactorFunction( category, func );
    
    SetCanComputeProjectionInFirstFactor( category, true );
    
    InstallMethodWithToDoForIsWellDefined( ProjectionInFirstFactor,
                                           [ IsHomalgCategoryObject and ObjectFilter( category ) and WasCreatedAsDirectSum ],
                                           
      function( sum_obj )
        local surjection;
        
        surjection := func( sum_obj );
        
        Add( HomalgCategory( sum_obj ), surjection );
        
        ## TODO: This morphism is epi
        
        return surjection;
        
    end );
    
end );

##
InstallMethod( AddProjectionInSecondFactor,
               [ IsHomalgCategory, IsFunction ],
               
  function( category, func )
    
    SetProjectionInSecondFactorFunction( category, func );
    
    SetCanComputeProjectionInSecondFactor( category, true );
    
    InstallMethodWithToDoForIsWellDefined( ProjectionInSecondFactor,
                                           [ IsHomalgCategoryObject and ObjectFilter( category ) and WasCreatedAsDirectSum ],
                                           
      function( sum_obj )
        local surjection;
        
        surjection := func( sum_obj );
        
        Add( HomalgCategory( sum_obj ), surjection );
        
        ## TODO: This morphism is epi
        
        return surjection;
        
    end );
    
end );

####################################
##
## Monomorphism as kernel lift
##
####################################

##
InstallMethod( AddMonoAsKernelLift,
               [ IsHomalgCategory, IsFunction ],
               
  function( category, func )
    
    SetMonoAsKernelLiftFunction( category, func );
    
    SetCanComputeMonoAsKernelLift( category, true );
    
    DECIDE_INSTALL_FUNCTION( category, "MonoAsKernelLift", 2 );
    
    InstallMethodWithToDoForIsWellDefined( MonoAsKernelLift,
                                           [ IsHomalgCategoryMorphism and MorphismFilter( category ),
                                             IsHomalgCategoryMorphism and MorphismFilter( category ) ],
                            
      function( monomorphism, test_morphism )
        local lift;
        
        lift := func( monomorphism, test_morphism );
        
        Add( HomalgCategory( monomorphism ), lift );
        
        return lift;
        
    end : InstallMethod := InstallMethodWithToDoForIsWellDefined );
    
end );

####################################
##
## Epimorphism as cokernel colift
##
####################################

##
InstallMethod( AddEpiAsCokernelColift,
               [ IsHomalgCategory, IsFunction ],
               
  function( category, func )
    
    SetEpiAsCokernelColiftFunction( category, func );
    
    SetCanComputeEpiAsCokernelColift( category, true );
    
    DECIDE_INSTALL_FUNCTION( category, "EpiAsCokernelColift", 2 );
    
    InstallMethodWithToDoForIsWellDefined( EpiAsCokernelColift,
                                           [ IsHomalgCategoryMorphism and MorphismFilter( category ),
                                             IsHomalgCategoryMorphism and MorphismFilter( category ) ],
                                           
      function( epimorphism, test_morphism )
        local colift;
        
        colift := func( epimorphism, test_morphism );
        
        Add( HomalgCategory( epimorphism ), colift );
        
        return colift;
        
    end : InstallMethod := InstallMethodWithToDoForIsWellDefined );
    
end );

####################################
##
## Inverse
##
####################################

##
InstallMethod( AddInverse,
               [ IsHomalgCategory, IsFunction ],
               
  function( category, func )
    
    SetInverseFunction( category, func );
    
    SetCanComputeInverse( category, true );
    
    InstallMethodWithToDoForIsWellDefined( Inverse,
                                           [ IsHomalgCategoryMorphism and MorphismFilter( category ) and IsIsomorphism ],
                                           
      function( isomorphism )
        local inverse;
        
        inverse := func( isomorphism );
        
        Add( HomalgCategory( isomorphism ), inverse );
        
        return inverse;
        
    end );
    
end );



#######################################
##
## Caching
##
#######################################

##
InstallMethod( SetCaching,
               [ IsHomalgCategory, IsString, IsString ],
               
  function( category, function_name, caching_info )
    
    if not caching_info in [ "weak", "crisp", "none" ] then
        
        Error( "wrong caching type" );
        
    fi;
    
    category!.caching_info.( function_name ) := caching_info;
    
end );

##
InstallMethod( SetCachingToWeak,
               [ IsHomalgCategory, IsString ],
               
  function( category, function_name )
    
    SetCaching( category, function_name, "weak" );
    
end );

##
InstallMethod( SetCachingToCrisp,
               [ IsHomalgCategory, IsString ],
               
  function( category, function_name )
    
    SetCaching( category, function_name, "crisp" );
    
end );

##
InstallMethod( DeactivateCaching,
               [ IsHomalgCategory, IsString ],
               
  function( category, function_name )
    
    SetCaching( category, function_name, "none" );
    
end );

##
InstallMethod( CachingObject,
               [ IsHomalgCategoryCell, IsString, IsInt ],
               
  function( cell, name, number )
    local category, cache;
    
    category := HomalgCategory( cell );
    
    if IsBound( category!.caches.(name) ) then
        
        return category!.caches.(name);
        
    fi;
    
    cache := CachingObject( number );
    
    category!.caches.(name) := cache;
    
    return cache;
    
end );

##
InstallMethod( CachingObject,
               [ IsHomalgCategory, IsString, IsInt ],
               
  function( arg )
    
    return CallFuncList( CachingObject, Concatenation( arg, [ false ] ) );
    
end );

##
InstallMethod( CachingObject,
               [ IsHomalgCategory, IsString, IsInt, IsBool ],
               
  function( category, name, number, is_crisp )
    local cache;
    
    if IsBound( category!.caches.(name) ) then
        
        return category!.caches.(name);
        
    fi;
    
    cache := CachingObject( number, is_crisp );
    
    category!.caches.(name) := cache;
    
    return cache;
    
end );

#######################################
##
## Constructors
##
#######################################

##
InstallMethod( CreateHomalgCategory,
               [ ],
               
  function( )
    local name;
    
    name := Concatenation( "AutomaticHomalgCategory", String( CATEGORIES_FOR_HOMALG_NAME_COUNTER( ) ) );
    
    return CreateHomalgCategory( name );
    
end );

InstallMethodWithCache( CreateHomalgCategory,
                        [ IsString ],
                        
  function( name )
    local category;
    
    category := rec( caching_info := rec( ) );
    
    category := CREATE_HOMALG_CATEGORY_OBJECT( category, [ [ "Name", name ] ] );
    
    CREATE_HOMALG_CATEGORY_FILTERS( category );
    
    return category;
    
end );

#######################################
##
## ViewObj
##
#######################################

InstallGlobalFunction( CATEGORIES_FOR_HOMALG_INSTALL_PRINT_FUNCTION,
               
  function( )
    local print_graph, category_function, i;
    
    category_function := function( category )
      local string;
      
      string := "homalg category";
      
      if HasName( category ) then
          
          Append( string, " with name " );
          
          Append( string, Name( category ) );
          
      fi;
      
      return string;
      
    end;
    
    print_graph := CreatePrintingGraph( IsHomalgCategory, category_function );
    
    for i in CATEGORIES_FOR_HOMALG_CAN_COMPUTE_FILTER_LIST do
        
        AddNodeToGraph( print_graph, rec( Conditions := i,
                                          TypeOfView := 3,
                                          ComputeLevel := 5 ) );
        
    od;
    
    InstallPrintFunctionsOutOfPrintingGraph( print_graph );
    
end );

CATEGORIES_FOR_HOMALG_INSTALL_PRINT_FUNCTION( );
