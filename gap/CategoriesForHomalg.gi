#############################################################################
##
##                                               CategoriesForHomalg package
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

InstallTrueMethod( IsAbCategory, IsPreAdditiveCategory );

InstallTrueMethod( IsPreAdditiveCategory, IsAdditiveCategory );

InstallTrueMethod( IsAdditiveCategory, IsPreAbelianCategory );

InstallTrueMethod( IsPreAbelianCategory, IsAbelianCategory );

######################################
##
## Technical stuff
##
######################################

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
InstallGlobalFunction( GET_METHOD_CACHE,
                       
  function( category, method, number_parameters )
    local caching_info, cache;
    
    if IsBound( category!.caches.( method ) ) then
        
        return category!.caches.( method );
        
    fi;
    
    if not IsBound( category!.caching_info.( method ) ) then
        
        category!.caching_info.( method ) := "weak";
        
        ## special case for morphisms
        
        if method = "AdditionForMorphisms" then
            
            category!.caching_info.( method ) := "none";
            
        fi;
        
    fi;
    
    caching_info := category!.caching_info.( method );
    
    if caching_info = "weak" then
        
        cache := CachingObject( category, method, number_parameters );
        
        category!.caches.( method ) := cache;
        
        return cache;
        
    elif caching_info = "crisp" then
        
        cache := CachingObject( category, method, number_parameters, true );
        
        category!.caches.( method ) := cache;
        
        return cache;
        
    elif caching_info = "none" then
        
        return false;
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
    local name, cell_filter, filter_name, filter;
    
    name := Name( category );
    
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
    
    obj_rec!.logical_implication_files := StructuralCopy( CATEGORIES_LOGIC_FILES );
    
    CallFuncList( ObjectifyWithAttributes, flatted_attribute_list );
    
    obj_rec!.caches := rec( );
    
    return obj_rec;
    
end );

InstallMethod( TheoremRecord,
               [ IsHomalgCategory ],
               
  function( category )
    
    return rec( );
    
end );

######################################################
##
## Add functions
##
######################################################

InstallMethod( AddCategoryToFamily,
               [ IsHomalgCategory, IsString ],
               
  function( category, family )
    
    if not IsBound( category!.families ) then
        
        category!.families := [ ];
        
    fi;
    
    Add( category!.families, LowercaseString( family ) );
    
end );

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
    
    InstallMethodWithToDoForIsWellDefined( PreCompose,
                                           [ IsHomalgCategoryMorphism and MorphismFilter( category ), IsHomalgCategoryMorphism and MorphismFilter( category ) ],
                   
      function( mor_left, mor_right )
        local ret_val;
        
        if not IsIdenticalObj( HomalgCategory( mor_left ), HomalgCategory( mor_right ) ) then
            
            Error( "morphisms must lie in the same category" );
            
        elif not IsEqualForObjects( Range( mor_left ), Source( mor_right ) ) then
            
            Error( "morphisms not composable" );
            
        fi;
        
        ret_val := func( mor_left, mor_right );
        
        Add( category, ret_val );
        
        return ret_val;
        
      end : InstallMethod := InstallMethodWithCache, Cache := GET_METHOD_CACHE( category, "PreCompose", 2 ) );
    
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
    
    InstallMethodWithToDoForIsWellDefined( MonoAsKernelLift,
                                           [ IsHomalgCategoryMorphism and MorphismFilter( category ),
                                             IsHomalgCategoryMorphism and MorphismFilter( category ) ],
                            
      function( monomorphism, test_morphism )
        local lift;
        
        lift := func( monomorphism, test_morphism );
        
        Add( HomalgCategory( monomorphism ), lift );
        
        return lift;
        
    end : InstallMethod := InstallMethodWithCache, Cache := GET_METHOD_CACHE( category, "MonoAsKernelLift", 2 ) );
    
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
    
    InstallMethodWithToDoForIsWellDefined( EpiAsCokernelColift,
                                           [ IsHomalgCategoryMorphism and MorphismFilter( category ),
                                             IsHomalgCategoryMorphism and MorphismFilter( category ) ],
                                           
      function( epimorphism, test_morphism )
        local colift;
        
        colift := func( epimorphism, test_morphism );
        
        Add( HomalgCategory( epimorphism ), colift );
        
        return colift;
        
    end : InstallMethod := InstallMethodWithCache, Cache := GET_METHOD_CACHE( category, "EpiAsCokernelColift", 2 ) );
    
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
    
    InstallMethodWithToDoForIsWellDefined( InverseOp,
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
    
    AddCategoryToFamily( category, "general" );
    
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
