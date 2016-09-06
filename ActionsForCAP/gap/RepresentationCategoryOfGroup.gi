############################################################################
##
##                                ActionsForCAP package
##
##  Copyright 2016, Sebastian Gutsche, TU Kaiserslautern
##                  Sebastian Posur,   RWTH Aachen
##
#! @Chapter Semisimple Categories
##
#############################################################################

####################################
##
## Constructors
##
####################################

InstallMethod( RepresentationCategory,
               [ IsInt, IsInt ],
               
  function( order, group_nr )
    local databasekeys_filename, stream, command, database_keys, group_string, group_data, group;
    
    databasekeys_filename := 
      Concatenation( PackageInfo( "ActionsForCAP" )[1].InstallationPath, "/gap/AssociatorsDatabase/DatabaseKeys.g" );
    
    stream := InputTextFile( databasekeys_filename );
    
    command := ReadAll( stream );
    
    database_keys := EvalString( command );
    
    group_string := Concatenation( String( order ), ", ", String( group_nr ) );
    
    group_data := First( database_keys, entry -> entry[1] = group_string );
    
    if group_data = fail then
        
        Error( "The associator of ", group_string, " has not been computed yet" );
        
        return;
        
    fi;
    
    group := SmallGroup( order, group_nr );
    
    return RepresentationCategory( group, group_data );
    
end );

InstallMethod( RepresentationCategory,
               [ IsGroup ],
               
  function( group )
    local databasekeys_filename, stream, command, database_keys, group_string, group_data;
    
    databasekeys_filename := 
      Concatenation( PackageInfo( "ActionsForCAP" )[1].InstallationPath, "/gap/AssociatorsDatabase/DatabaseKeys.g" );
    
    stream := InputTextFile( databasekeys_filename );
    
    command := ReadAll( stream );
    
    database_keys := EvalString( command );
    
    group_string := String( group );
    
    group_data := First( database_keys, entry -> entry[1] = group_string );
    
    if group_data = fail then
        
        Error( "The associator of ", group_string, " has not been computed yet" );
        
        return;
        
    fi;
    
    return RepresentationCategory( group, group_data );
    
end );

## Rep( G )
##
InstallMethod( RepresentationCategory,
               [ IsGroup, IsList ],
               
  function( group, group_data )
    local group_string, name,
          irr, conductor, unit_number, e,
          field, membership_function, tensor_unit, associator_filename, is_complete_data,
          category;
    
    group_string := String( group );
    
    name := Concatenation( "The representation category of ", group_string );
    
    irr := Irr( group );
    
    conductor := group_data[2];
    
    unit_number := group_data[3];
    
    associator_filename := group_data[4];
    
    is_complete_data := group_data[5];
    
    membership_function := object -> IsGIrreducibleObject( object ) and IsIdenticalObj( UnderlyingGroup( object ), group );
    
    if conductor = 1 then
        
        field := HomalgFieldOfRationalsInDefaultCAS();
        
    else
        
        field := HomalgCyclotomicFieldInMAGMA( conductor, "e" );
        
    fi;
    
    SetConductor( field, conductor );
    
    tensor_unit := GIrreducibleObject( irr[ unit_number ] );
    
    category := SemisimpleCategory( field, membership_function, tensor_unit, associator_filename, is_complete_data, name );
    
    SetUnderlyingGroupForRepresentationCategory( category, group );
    
    return category;
    
end );

##
InstallMethod( RepresentationCategoryObject,
               [ IsList, IsCapCategory ],
               
  function( object_list, category )
    
    object_list := List( object_list, elem -> [ elem[1], GIrreducibleObject( elem[2] ) ] );
    
    return SemisimpleCategoryObject( object_list, category );
    
end );

##
InstallMethod( RepresentationCategoryObject,
               [ IsCharacter, IsCapCategory ],
               
  function( character, category )
    
    return RepresentationCategoryObject( [ [ 1, character ] ], category );
    
end );

##
InstallMethod( RepresentationCategoryMorphism,
               [ IsSemisimpleCategoryObject, IsList, IsSemisimpleCategoryObject ],
               
  function( source, morphism_list, range )
    local field, new_morphism_list, elem, vector_space_morphism;
    
    field := UnderlyingFieldForHomalgForSemisimpleCategory( CapCategory( source ) );
    
    new_morphism_list := [ ];
    
    for elem in morphism_list do
        
        vector_space_morphism := 
          VectorSpaceMorphism( VectorSpaceObject( NrRows( elem[1] ), field ),
                               elem[1], 
                               VectorSpaceObject( NrColumns( elem[1] ), field ) );
        
        Add( new_morphism_list, [ vector_space_morphism, GIrreducibleObject( elem[2] ) ] );
        
    od;
    
    return SemisimpleCategoryMorphism( source, new_morphism_list, range );
    
end );

## Rep( Z x G )
##
InstallMethod( RepresentationCategoryZGraded,
               [ IsInt, IsInt ],
               
  function( order, group_nr )
    local databasekeys_filename, stream, command, database_keys, group_string, group_data, group;
    
    databasekeys_filename := 
      Concatenation( PackageInfo( "ActionsForCAP" )[1].InstallationPath, "/gap/AssociatorsDatabase/DatabaseKeys.g" );
    
    stream := InputTextFile( databasekeys_filename );
    
    command := ReadAll( stream );
    
    database_keys := EvalString( command );
    
    group_string := Concatenation( String( order ), ", ", String( group_nr ) );
    
    group_data := First( database_keys, entry -> entry[1] = group_string );
    
    if group_data = fail then
        
        Error( "The associator of ", group_string, " has not been computed yet" );
        
        return;
        
    fi;
    
    group := SmallGroup( order, group_nr );
    
    return RepresentationCategoryZGraded( group, group_data );
    
end );

InstallMethod( RepresentationCategoryZGraded,
               [ IsGroup ],
               
  function( group )
    local databasekeys_filename, stream, command, database_keys, group_string, group_data;
    
    databasekeys_filename := 
      Concatenation( PackageInfo( "ActionsForCAP" )[1].InstallationPath, "/gap/AssociatorsDatabase/DatabaseKeys.g" );
    
    stream := InputTextFile( databasekeys_filename );
    
    command := ReadAll( stream );
    
    database_keys := EvalString( command );
    
    group_string := String( group );
    
    group_data := First( database_keys, entry -> entry[1] = group_string );
    
    if group_data = fail then
        
        Error( "The associator of ", group_string, " has not been computed yet" );
        
        return;
        
    fi;
    
    return RepresentationCategoryZGraded( group, group_data );
    
end );

InstallMethod( RepresentationCategoryZGraded,
               [ IsGroup, IsList ],
               
  function( group, group_data )
    local group_string, name,
          irr, conductor, unit_number, e,
          field, membership_function, tensor_unit, associator_filename, is_complete_data,
          category;
    
    group_string := String( group );
    
    name := Concatenation( "The Z-graded representation category of ", group_string );
    
    irr := Irr( group );
    
    conductor := group_data[2];
    
    unit_number := group_data[3];
    
    associator_filename := group_data[4];
    
    is_complete_data := group_data[5];
    
    membership_function := object -> IsGZGradedIrreducibleObject( object ) and IsIdenticalObj( UnderlyingGroup( object ), group );
    
    if conductor = 1 then
        
        field := HomalgFieldOfRationalsInDefaultCAS();
        
    else
        
        field := HomalgCyclotomicFieldInMAGMA( conductor, "e" );
        
    fi;
    
    SetConductor( field, conductor );
    
    tensor_unit := GZGradedIrreducibleObject( 0, irr[ unit_number ] );
    
    category := SemisimpleCategory( field, membership_function, tensor_unit, associator_filename, is_complete_data, name );
    
    SetUnderlyingGroupForRepresentationCategory( category, group );
    
    return category;
    
end );

##
InstallMethod( RepresentationCategoryZGradedObject,
               [ IsList, IsCapCategory ],
               
  function( object_list, category )
    
    object_list := List( object_list, elem -> [ elem[1], GZGradedIrreducibleObject( elem[2], elem[3] ) ] );
    
    return SemisimpleCategoryObject( object_list, category );
    
end );

##
InstallMethod( RepresentationCategoryZGradedObject,
               [ IsInt, IsCharacter, IsCapCategory ],
               
  function( degree, character, category )
    
    return RepresentationCategoryZGradedObject( [ [ 1, degree, character ] ], category );
    
end );

##
InstallMethod( RepresentationCategoryZGradedObject,
               [ IsCharacter, IsCapCategory ],
               
  function( character, category )
    
    return RepresentationCategoryZGradedObject( [ [ 1, 0, character ] ], category );
    
end );


##
InstallMethod( RepresentationCategoryZGradedMorphism,
               [ IsSemisimpleCategoryObject, IsList, IsSemisimpleCategoryObject ],
               
  function( source, morphism_list, range )
    local field, new_morphism_list, elem, vector_space_morphism;
    
    field := UnderlyingFieldForHomalgForSemisimpleCategory( CapCategory( source ) );
    
    new_morphism_list := [ ];
    
    for elem in morphism_list do
        
        vector_space_morphism :=
          VectorSpaceMorphism( VectorSpaceObject( NrRows( elem[1] ), field ),
                               elem[1], 
                               VectorSpaceObject( NrColumns( elem[1] ), field ) );
        
        Add( new_morphism_list, [ vector_space_morphism, GZGradedIrreducibleObject( elem[2], elem[3] ) ] );
        
    od;
    
    return SemisimpleCategoryMorphism( source, new_morphism_list, range );
    
end );
