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

InstallGlobalFunction( "CREATE_HOMALG_CATEGORY_TYPES",
                       
  function( name )
    local i, cat_name, type_name, rep_name, morphism_cat_name, morphism_type_name, morphism_rep_name,
          return_record;
    
    cat_name := Concatenation( "IsHomalgCategory", name, "Object" );
    
    DeclareCategory( cat_name,
                     IsHomalgCategoryObject );
    
    type_name := Concatenation( "TheType", cat_name );
    
    rep_name := Concatenation( cat_name, "Rep" );
    
    DeclareRepresentation( rep_name,
                           IsHomalgCategoryObjectRep,
                           [ ] );
    
    BindGlobal( type_name,
                NewType( TheFamilyOfHomalgCategoryObjects,
                         ValueGlobal( rep_name ) ) );
    
    return_record := rec( object_category := ValueGlobal( cat_name )
                          object_representation := ValueGlobal( rep_name ),
                          object_type := ValueGlobal( type_name ),
    );
    
    morphism_cat_name := Concatenation( "IsHomalgCategory", name, "Morphism" );
    
    DeclareCategory( morphism_cat_name,
                     IsHomalgCategoryMorphism );
    
    morphism_type_name := Concatenation( "TheType", morphism_cat_name );
    
    morphism_rep_name := Concatenation( morphism_cat_name, "Rep" );
    
    DeclareRepresentation( morphism_rep_name,
                           IsHomalgCategoryMorphismRep,
                           [ ] );
    
    BindGlobal( morphism_type_name,
                NewType( TheFamilyOfHomalgCategoryMorphisms,
                         ValueGlobal( morphism_rep_name ) ) );
    
    return_record.morphism_category := ValueGlobal( morphism_cat_name );
    
    return_record.morphism_representation := ValueGlobal( morphism_rep_name );
    
    return_record.morphism_type := Value( morphism_type_name );
    
    return return_record;
    
end );

InstallGlobalFunction( "INSTALL_FUNCTIONS_FOR_CATEGORY",
                       
  function( category, obj_category, morphism_category )
    local i, j, function_list;
    
    function_list := [ [ "IdentityMorphism", [ "obj" ] ],
                       [ "PreComposition", [ "mor", "mor" ] ] ];
                       
    for i in [ 1 .. Length( function_list ) ] do
        
        for j in [ 1 .. Length( function_list[ i ] ) ]
    

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

#######################################
##
## Constructors
##
#######################################

InstallMethod( HomalgCategory,
               [ ],
               
  function( )
    
    return CREATE_HOMALG_CATEGORY_OBJECT( rec( ),  [ ] );
    
end );

InstallMethod( HomalgCategory,
               [ IsString ],
               
  function( name )
    local category;
    
    category := CREATE_HOMALG_CATEGORY_OBJECT( rec( ), [ [ "Name", name ] ] );
    
    category!.cats_reps_types := CREATE_HOMALG_CATEGORY_TYPES( name );
    
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
