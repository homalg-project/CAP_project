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
                       
  function( category, method )
    local caching_info;
    
    if not IsBound( category!.caching_info.( method ) ) then
        
        category!.caching_info.( method ) := "weak";
        
    fi;
    
    caching_info := category!.caching_info.( method );
    
    if caching_info = "weak" then
        
        return InstallMethodWithWeakCache;
        
    elif caching_info = "crisp" then
        
        return InstallMethodWithCrispCache;
        
    elif caching_info = "none" then
        
        return InstallMethod;
        
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
    
    return obj_rec;
    
end );

#####################################
##
## Category stored object functions
##
#####################################

##
InstallMethod( ZeroObject,
               [ IsHomalgCategory ],
               
  function( category )
    local zero_obj;
    
    if not IsBound( category!.zero_object_constructor ) then
        
        Error( "no possibility to construct zero object" );
        
    fi;
    
    zero_obj := category!.zero_object_constructor();
    
    Add( category, zero_obj );
    
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
    
    InstallMethod( IdentityMorphism,
                   [ IsHomalgCategoryObject and ObjectFilter( category ) ],
                   
      function( object )
        local ret_val;
        
        ret_val := func( object );
        
        Add( category, ret_val );
        
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
    local InstallFunction;
    
    SetPreComposeFunction( category, func );
    
    InstallFunction := DECIDE_INSTALL_FUNCTION( category, "PreCompose" );
    
    InstallFunction( PreCompose,
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
        
      end );
    
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
    
    InstallMethod( ZeroObject,
                   [ IsHomalgCategoryObject and ObjectFilter( category ) ],
                   
      function( object )
        
        return ZeroObject( category );
        
      end );
    
end );

##
InstallMethod( AddMorphismIntoZeroObject,
               [ IsHomalgCategory, IsFunction ],
               
  function( category, func )
    
    SetMorphismIntoZeroObjectFunction( category, func );
    
    InstallMethod( MorphismIntoZeroObject,
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
    
    InstallMethod( MorphismFromZeroObject,
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

##
InstallMethod( AddDirectSum_OnObjects,
               [ IsHomalgCategory, IsFunction ],
               
  function( category, func )
    local InstallFunction;
    
    InstallFunction := DECIDE_INSTALL_FUNCTION( category, "DirectSum" );
    
    SetDirectSum_OnObjectsFunction( category, func );
    
    InstallFunction( DirectSumOp,
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
        
    end );
    
end );

##
InstallMethod( AddInjectionFromFirstSummand,
               [ IsHomalgCategory, IsFunction ],
               
  function( category, func )
    
    SetInjectionFromFirstSummandFunction( category, func );
    
    InstallMethod( InjectionFromFirstSummand,
                   [ IsHomalgCategoryObject and ObjectFilter( category ) and IsDirectSum ],
                   
      function( sum_obj )
        local injection1;
        
        injection1 := func( sum_obj );
        
        Add( HomalgCategory( sum_obj ), injection1 );
        
        ## TODO: This morphism is mono
        
        return injection1;
        
    end );
    
end );

##
InstallMethod( AddInjectionFromSecondSummand,
               [ IsHomalgCategory, IsFunction ],
               
  function( category, func )
    
    SetInjectionFromSecondSummandFunction( category, func );
    
    InstallMethod( InjectionFromSecondSummand,
                   [ IsHomalgCategoryObject and ObjectFilter( category ) and IsDirectSum ],
                   
      function( sum_obj )
        local injection1;
        
        injection1 := func( sum_obj );
        
        Add( HomalgCategory( sum_obj ), injection1 );
        
        ## TODO: This morphism is mono
        
        return injection1;
        
    end );
    
end );

##
InstallMethod( AddProjectionInFirstFactor,
               [ IsHomalgCategory, IsFunction ],
               
  function( category, func )
    
    SetProjectionInFirstFactorFunction( category, func );
    
    InstallMethod( ProjectionInFirstFactor,
                   [ IsHomalgCategoryObject and ObjectFilter( category ) and IsDirectSum ],
                   
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
    
    InstallMethod( ProjectionInSecondFactor,
                   [ IsHomalgCategoryObject and ObjectFilter( category ) and IsDirectSum ],
                   
      function( sum_obj )
        local surjection;
        
        surjection := func( sum_obj );
        
        Add( HomalgCategory( sum_obj ), surjection );
        
        ## TODO: This morphism is epi
        
        return surjection;
        
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

InstallMethod( CreateHomalgCategory,
               [ IsString ],
               
  function( name )
    local category;
    
    category := rec( caching_info := rec( ) );
    
    category := CREATE_HOMALG_CATEGORY_OBJECT( category, [ [ "Name", name ] ] );
    
    CREATE_HOMALG_CATEGORY_FILTERS( category );
    
    InstallImmediateMethod( HomalgCategory,
                            IsHomalgCategoryObject and ObjectFilter( category ),
                            0,
                            
      function( object )
        
        return category;
        
    end );
    
    InstallImmediateMethod( HomalgCategory,
                            IsHomalgCategoryMorphism and MorphismFilter( category ),
                            0,
                            
      function( object )
        
        return category;
        
    end );
    
    return category;
    
end );

#######################################
##
## ViewObj
##
#######################################

InstallMethod( ViewObj,
               [ IsHomalgCategory ],
               
  function( x )
    
    if HasName( x ) then
        
        Print( "<", Name( x ), ">" );
        
    else
        
        Print( "<A homalg category>" );
        
    fi;
    
end );
