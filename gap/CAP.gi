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

InstallValue( CAP_INTERNAL_DERIVATION_GRAPH,
    
    MakeDerivationGraph( List( CAP_INTERNAL_CAN_COMPUTE_FILTER_LIST.CanComputeForAllCategories, i -> i{[ 11 .. Length( i ) ]} ) ) );


######################################
##
## Reps, types, stuff.
##
######################################

DeclareRepresentation( "IsCapCategoryRep",
                       IsAttributeStoringRep and IsCapCategory,
                       [ ] );

BindGlobal( "TheFamilyOfHomalgCategories",
        NewFamily( "TheFamilyOfHomalgCategories" ) );

BindGlobal( "TheTypeOfHomalgCategories",
        NewType( TheFamilyOfHomalgCategories,
                 IsCapCategoryRep ) );


#####################################
##
## Global functions
##
#####################################

##
InstallGlobalFunction( INSTALL_CAN_COMPUTE_TO_DO_LISTS,
                       
  function( category )
    local i, entry_func, internal_list;
    
    entry_func := function( category, filter_name )
        
        return ToDoListEntry( [ [ category, filter_name, true ] ], function( ) InstallTrueMethod( ValueGlobal( filter_name ), CanComputeFilter( category ) ); end );
        
    end;
    
    internal_list := Concatenation( 
                       CAP_INTERNAL_CAN_COMPUTE_FILTER_LIST.CanComputeForAllCategories,
                       CAP_INTERNAL_CAN_COMPUTE_FILTER_LIST.CanComputeForSpecialCategories,
                       CAP_INTERNAL_CAN_COMPUTE_FILTER_LIST.MathematicalPropertiesOfCategories
                     );
    
    for i in internal_list do
        
        AddToToDoList( entry_func( category, i ) );
        
    od;
    
end );

##
InstallGlobalFunction( CREATE_CAP_CATEGORY_FILTERS,
                       
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
    
    filter_name := NewFilter( Concatenation( name, "CanComputeFilter" ) );
    
    SetCanComputeFilter( category, filter_name );
    
    InstallTrueMethod( filter_name, cell_filter );
    
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
    
    flatted_attribute_list := Concatenation( [ obj_rec, TheTypeOfHomalgCategories ], flatted_attribute_list );
    
    
    obj_rec!.logical_implication_files := StructuralCopy( CATEGORIES_LOGIC_FILES );
    
    CallFuncList( ObjectifyWithAttributes, flatted_attribute_list );
    
    obj_rec!.derivations_weight_list := MakeOperationsWeightList( obj_rec, CAP_INTERNAL_DERIVATION_GRAPH );
    
    obj_rec!.caches := rec( );
    
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

#######################################
##
## IdentityMorphism
##
#######################################

##
InstallMethod( AddIdentityMorphism,
               [ IsCapCategory, IsFunction ],
               
  function( category, func )
    
    SetIdentityMorphismFunction( category, func );
    
    SetCanComputeIdentityMorphism( category, true );
    
      InstallMethodWithToDoForIsWellDefined( IdentityMorphism,
                                             [ IsCapCategoryObject and ObjectFilter( category ) ],
                                             
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
               [ IsCapCategory, IsFunction ],
               
  function( category, func )
    
    SetPreComposeFunction( category, func );
    
    SetCanComputePreCompose( category, true );
    
    InstallMethodWithToDoForIsWellDefined( PreCompose,
                                           [ IsCapCategoryMorphism and MorphismFilter( category ), IsCapCategoryMorphism and MorphismFilter( category ) ],
                   
      function( mor_left, mor_right )
        local ret_val;
        
        if not IsIdenticalObj( CapCategory( mor_left ), CapCategory( mor_right ) ) then
            
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
               [ IsCapCategory, IsFunction ],
               
  function( category, func )
    
    SetMonoAsKernelLiftFunction( category, func );
    
    SetCanComputeMonoAsKernelLift( category, true );
    
    InstallMethodWithToDoForIsWellDefined( MonoAsKernelLift,
                                           [ IsCapCategoryMorphism and MorphismFilter( category ),
                                             IsCapCategoryMorphism and MorphismFilter( category ) ],
                            
      function( monomorphism, test_morphism )
        local lift;
        
        lift := func( monomorphism, test_morphism );
        
        Add( CapCategory( monomorphism ), lift );
        
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
               [ IsCapCategory, IsFunction ],
               
  function( category, func )
    
    SetEpiAsCokernelColiftFunction( category, func );
    
    SetCanComputeEpiAsCokernelColift( category, true );
    
    InstallMethodWithToDoForIsWellDefined( EpiAsCokernelColift,
                                           [ IsCapCategoryMorphism and MorphismFilter( category ),
                                             IsCapCategoryMorphism and MorphismFilter( category ) ],
                                           
      function( epimorphism, test_morphism )
        local colift;
        
        colift := func( epimorphism, test_morphism );
        
        Add( CapCategory( epimorphism ), colift );
        
        return colift;
        
    end : InstallMethod := InstallMethodWithCache, Cache := GET_METHOD_CACHE( category, "EpiAsCokernelColift", 2 ) );
    
end );

## this derivation leads to circuits
##
# InstallTrueMethodAndStoreImplication( CanComputeEpiAsCokernelColift, 
#                                       CanComputeKernelEmb
#                                       and CanComputeCokernelColift
#                                       and CanComputePreCompose
#                                       and CanComputeInverse );
# 
# InstallMethodWithCacheFromObject( EpiAsCokernelColift,
#                                   [ IsCapCategoryMorphism
#                                     and CanComputeKernelEmb
#                                     and CanComputeCokernelColift
#                                     and CanComputePreCompose
#                                     and CanComputeInverse,
#                                     IsCapCategoryMorphism ],
#                                     -9999, ##FIXME
#                                     
#   function( epimorphism, test_morphism )
#     local kernel_emb, cokernel_colift_to_range_of_epimorphism, cokernel_colift_to_range_of_test_morphism, inverse;
#     
#     kernel_emb := KernelEmb( epimorphism );
#     
#     cokernel_colift_to_range_of_epimorphism :=
#       CokernelColift( kernel_emb, epimorphism );
#       
#     cokernel_colift_to_range_of_test_morphism :=
#       CokernelColift( kernel_emb, test_morphism );
#     
#     return PreCompose( Inverse( cokernel_colift_to_range_of_epimorphism ), cokernel_colift_to_range_of_test_morphism );
#     
# end );


####################################
##
## Inverse
##
####################################

##
InstallMethod( AddInverse,
               [ IsCapCategory, IsFunction ],
               
  function( category, func )
    
    SetInverseFunction( category, func );
    
    SetCanComputeInverse( category, true );
    
    InstallMethodWithToDoForIsWellDefined( InverseOp,
                                           [ IsCapCategoryMorphism and MorphismFilter( category ) and IsIsomorphism ],
                                           
      function( isomorphism )
        local inverse;
        
        inverse := func( isomorphism );
        
        Add( CapCategory( isomorphism ), inverse );
        
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
               [ IsCapCategory, IsString, IsString ],
               
  function( category, function_name, caching_info )
    
    if not caching_info in [ "weak", "crisp", "none" ] then
        
        Error( "wrong caching type" );
        
    fi;
    
    category!.caching_info.( function_name ) := caching_info;
    
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
    
    category := CapCategory( cell );
    
    if IsBound( category!.caches.(name) ) then
        
        return category!.caches.(name);
        
    fi;
    
    cache := CachingObject( number );
    
    category!.caches.(name) := cache;
    
    return cache;
    
end );

##
InstallMethod( CachingObject,
               [ IsCapCategory, IsString, IsInt ],
               
  function( arg )
    
    return CallFuncList( CachingObject, Concatenation( arg, [ false ] ) );
    
end );

##
InstallMethod( CachingObject,
               [ IsCapCategory, IsString, IsInt, IsBool ],
               
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
InstallMethod( CreateCapCategory,
               [ ],
               
  function( )
    local name;
    
    name := Concatenation( "AutomaticCapCategory", String( CAP_INTERNAL_NAME_COUNTER( ) ) );
    
    return CreateCapCategory( name );
    
end );

InstallMethodWithCache( CreateCapCategory,
                        [ IsString ],
                        
  function( name )
    local category;
    
    category := rec( caching_info := rec( ) );
    
    category := CREATE_CAP_CATEGORY_OBJECT( category, [ [ "Name", name ] ] );
    
    CREATE_CAP_CATEGORY_FILTERS( category );
    
    INSTALL_CAN_COMPUTE_TO_DO_LISTS( category );
    
    AddCategoryToFamily( category, "general" );
    
    return category;
    
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
      
      string := "homalg category";
      
      if HasName( category ) then
          
          Append( string, " with name " );
          
          Append( string, Name( category ) );
          
      fi;
      
      return string;
      
    end;
    
    print_graph := CreatePrintingGraph( IsCapCategory, category_function );
    
    internal_list := Concatenation( 
                       CAP_INTERNAL_CAN_COMPUTE_FILTER_LIST.CanComputeForAllCategories,
                       CAP_INTERNAL_CAN_COMPUTE_FILTER_LIST.CanComputeForSpecialCategories,
                       CAP_INTERNAL_CAN_COMPUTE_FILTER_LIST.MathematicalPropertiesOfCategories
                     );
    
    for i in internal_list do
        
        AddNodeToGraph( print_graph, rec( Conditions := i,
                                          TypeOfView := 3,
                                          ComputeLevel := 5 ) );
        
    od;
    
    InstallPrintFunctionsOutOfPrintingGraph( print_graph );
    
end );

CAP_INTERNAL_INSTALL_PRINT_FUNCTION( );
