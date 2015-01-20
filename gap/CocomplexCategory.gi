#############################################################################
##
##                                               CategoriesForHomalg package
##
##  Copyright 2014, Sebastian Gutsche, TU Kaiserslautern
##                  Sebastian Posur,   RWTH Aachen
##
##
#############################################################################

DeclareRepresentation( "IsCocomplexRep",
                       IsHomalgCategoryObjectRep and IsCocomplex,
                       [ ] );

DeclareRepresentation( "IsCochainMapRep",
                       IsHomalgCategoryMorphismRep and IsCochainMap,
                       [ ] );

BindGlobal( "TheTypeOfCocomplexes",
        NewType( TheFamilyOfHomalgCategoryObjects,
                IsCocomplexRep ) );

BindGlobal( "TheTypeOfCochainMaps",
        NewType( TheFamilyOfHomalgCategoryMorphisms,
                IsCochainMapRep ) );

#############################
##
## Attributes
##
#############################

##
InstallMethod( CocomplexCategory,
               [ IsHomalgCategory ],
               
  function( category )
    local name, cocomplex_category;
    
    if not IsAbelianCategory( category ) then
        
      Error( "the category must be abelian" );
      
    fi;
    
    name := Name( category );
    
    name := Concatenation( "Cocomplex category of ", name );
    
    cocomplex_category := CreateHomalgCategory( name );
    
    SetUnderlyingHonestCategory( cocomplex_category, category );
    
    INSTALL_TODO_LIST_ENTRIES_FOR_COCOMPLEX_CATEGORY( category );
    
    return cocomplex_category;
    
end );

#############################
##
## Add methods
##
#############################

BindGlobal( "ADD_PRECOMPOSE_IN_COCOMPLEX_CATEGORY",
  
  function( category )
    
    AddPreCompose( CocomplexCategory( category ),
          
      function( mor_left, mor_right )
        
        return AsCochainMap( PreCompose( UnderlyingZFunctorCell( mor_left ), UnderlyingZFunctorCell( mor_right ) ) );
        
    end );
    
end );

##
InstallGlobalFunction( INSTALL_TODO_LIST_ENTRIES_FOR_COCOMPLEX_CATEGORY,
            
  function( category )
   local z_functor_category, todo_list_entries, entry, new_entry;
    
    z_functor_category := ZFunctorCategory( category );
    
    todo_list_entries := [
    
        [ [ "CanComputePreCompose" ], function( ) ADD_PRECOMPOSE_IN_COCOMPLEX_CATEGORY( category ); end ],
        
    ];
    
    for entry in todo_list_entries do
        
        new_entry := ToDoListEntry(
          Concatenation( List( entry[1], can_compute -> [ z_functor_category, can_compute ] ), [ [ category, "CocomplexCategory" ] ] ),
          entry[2]
        );
        
        AddToToDoList( new_entry );
        
    od;
    
end );

#############################
##
## Getter
##
############################
##
## No setter are installed:
## For an explanation see ZFunctor category.

##
InstallMethod( \[\],
               [ IsCocomplexCell, IsInt ],
               
  function( cocomplex_cell, index )
      
      return UnderlyingZFunctorCell( cocomplex_cell )[ index ];
      
end );

##
InstallMethod( Differential,
               [ IsCocomplex, IsInt ],
               
  function( cocomplex, index )
      
      return Differential( UnderlyingZFunctorCell( cocomplex ), index );
      
end );

#################################################
##
## Constructors
##
#################################################

##
InstallMethod( AsCocomplex,
               [ IsZFunctorObject ],
               
  function( z_functor_object )
    local category, object;
    
    category := UnderlyingHonestCategory( HomalgCategory( z_functor_object ) );
    
    object := rec( );
    
    ObjectifyWithAttributes( object, TheTypeOfCocomplexes,
                             UnderlyingZFunctorCell, z_functor_object );
    
    Add( CocomplexCategory( category ), object );
    
    return object;
    
end );

##
InstallMethod( AsCochainMap,
               [ IsZFunctorMorphism ],
               
  function( z_functor_morphism )
    local category, source, range, morphism;
    
    category := UnderlyingHonestCategory( HomalgCategory( z_functor_morphism ) );
    
    source := AsCocomplex( Source( z_functor_morphism ) );
    
    range := AsCocomplex( Range( z_functor_morphism ) );
    
    morphism := rec( );
    
    ObjectifyWithAttributes( morphism, TheTypeOfCochainMaps,
                             UnderlyingZFunctorCell, z_functor_morphism,
                             Source, source,
                             Range, range );
    
    Add( CocomplexCategory( category ), morphism );
    
    return morphism;
    
end );

##
InstallMethod( AsPointedCocomplexOp,
               [ IsHomalgCategoryObject, IsInt ],
               
  function( object, index )
      
      return AsCocomplex( AsZFunctorObject( object, index ) );
      
end );

##
InstallMethod( AsPointedCochainMapOp,
               [ IsHomalgCategoryMorphism, IsInt ],
               
  function( morphism, index )
      
      return AsCochainMap( AsZFunctorMorphism( morphism, index ) );
      
end );