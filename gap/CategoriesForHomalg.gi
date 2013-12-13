#############################################################################
##
##                                               CategoriesForHomalg package
##
##  Copyright 2013, Sebastian Gutsche, TU Kaiserslautern
##                  Sebastian Posur,   RWTH Aachen
##
#############################################################################

InstallValue( CATEGORIES_FOR_HOMALG,
              rec(
                   name_counter := 0
              )
);

InstallGlobalFunction( CATEGORIES_FOR_HOMALG_NAME_COUNTER,
                       
  function( )
    local counter;
    
    counter := CATEGORIES_FOR_HOMALG.name_counter + 1;
    
    CATEGORIES_FOR_HOMALG.name_counter := counter;
    
    return counter;
    
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

InstallGlobalFunction( CREATE_HOMALG_CATEGORY_FILTERS,
                       
  function( category )
    local name, filter_name, filter;
    
    name := Name( category );
    
    filter_name := Concatenation( name, "ObjectFilter" );
    
    SetObjectFilter( category, NewFilter( filter_name ) );
    
    filter_name := Concatenation( name, "MorphismFilter" );
    
    SetMorphismFilter( category, NewFilter( filter_name ) );
    
end );

# InstallGlobalFunction( INSTALL_ADD_FUNCTIONS_FOR_CATEGORY,
#                        
#   function( )
#     local i, j, function_list, k;
#     
#     function_list := [ [ "IdentityMorphism", [ "obj" ] ],
#                        [ "PreCompose", [ "mor", "mor" ] ] ];
#     
#     ## Declare the setters
#     
#     for i in function_list do
#         
#         DeclareOperation( Concatenation( "Add", i[ 1 ] ),
#                           [ IsHomalgCategory, IsFunction ] );
#         
#     od;
#     
#     ## Install the setters
#     
#     for i in function_list do
#         
#         k := ShallowCopy( i );
#         
#         InstallMethod( ValueGlobal( Concatenation( "Add", k[ 1 ] ) ),
#                        [ IsHomalgCategory, IsFunction ],
#                        
#           function( category, inst_meth_function )
#             local name, filter_list, j;
#             
#             name := k[ 1 ];
#             
#             filter_list := [ ];
#             
#             for j in k[ 2 ] do
#                 
#                 if j = "obj" then
#                     
#                     Add( filter_list, IsHomalgCategoryObject and ObjectFilter( category ) );
#                     
#                 elif j = "mor" then
#                     
#                     Add( filter_list, IsHomalgCategoryMorphism and MorphismFilter( category ) );
#                     
#                 fi;
#                 
#             od;
#             
#             InstallMethod( ValueGlobal( name ),
#                            filter_list,
#                            
#               function( arg )
#                 local ret_val;
#                 
#                 ret_val := CallFuncList( inst_meth_function, arg );
#                 
#                 Add( category, ret_val );
#                 
#                 return ret_val;
#                 
#               end );
#             
#             end );
#             
#     od;
#     
# end );
# 
# INSTALL_ADD_FUNCTIONS_FOR_CATEGORY( );

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

#######################################
##
## Add functions
##
#######################################

InstallMethod( AddIdentityMorphism,
               [ IsHomalgCategory, IsFunction ],
               
  function( category, func )
    
    InstallMethod( IdentityMorphism,
                   [ IsHomalgCategoryObject and ObjectFilter( category ) ],
                   
      function( object )
        local ret_val;
        
        ret_val := func( object );
        
        Add( category, ret_val );
        
        return ret_val;
        
      end );
    
end );

InstallMethod( AddPreCompose,
               [ IsHomalgCategory, IsFunction ],
               
  function( category, func )
    
    InstallMethod( PreCompose,
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

InstallMethod( AddZeroObject,
               [ IsHomalgCategory, IsFunction ],
               
  function( category, func )
    
    category!.zero_object_constructor := func;
    
    InstallMethod( ZeroObject,
                   [ IsHomalgCategoryObject and ObjectFilter( category ) ],
                   
      function( object )
        
        return ZeroObject( category );
        
      end );
    
end );

InstallMethod( AddMorphismIntoZeroObject,
               [ IsHomalgCategory, IsFunction ],
               
  function( category, func )
    
    InstallMethod( MorphismIntoZeroObject,
                   [ IsHomalgCategoryObject and ObjectFilter( category ) ],
                   
      function( object )
        local morphism;
        
        morphism := func( object );
        
        Add( category, morphism );
        
        return morphism;
        
    end );
    
end );

InstallMethod( AddMorphismFromZeroObject,
               [ IsHomalgCategory, IsFunction ],
               
  function( category, func )
    
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
## Constructors
##
#######################################

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
    
    category := CREATE_HOMALG_CATEGORY_OBJECT( rec( ), [ [ "Name", name ] ] );
    
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
