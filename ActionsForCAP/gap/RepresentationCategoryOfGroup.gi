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

##
InstallMethod( RepresentationCategory,
               [ IsGroup ],
               
  function( group )
    local group_string, name, databasekeys_filename, stream, command, database_keys,
          group_data, irr, conductor, unit_number, 
          field, membership_function, tensor_unit, associator_filename;
    
    group_string := String( group );
    
    name := Concatenation( "The representation category of ", group_string );
    
    databasekeys_filename := 
      Concatenation( PackageInfo( "ActionsForCAP" )[1].InstallationPath, "/gap/AssociatorsDatabase/DatabaseKeys.g" );
    
    stream := InputTextFile( databasekeys_filename );
    
    command := ReadAll( stream );
    
    database_keys := EvalString( command );
    
    group_data := First( database_keys, entry -> entry[1] = group_string );
    
    if group_data = fail then
        
        Error( "The associator of ", group_string, " has not been computed yet" );
        
        return;
        
    fi;
    
    irr := Irr( group );
    
    conductor := group_data[2];
    
    unit_number := group_data[3];
    
    associator_filename := group_data[4];
    
    membership_function := object -> IsGIrreducibleObject( object ) and IsIdenticalObj( UnderlyingGroup( object ), group );
    
    if conductor = 1 then
        
        field := HomalgFieldOfRationalsInDefaultCAS();
        
    else
        
        field := HomalgCyclotomicFieldInMAGMA( conductor, "eps" );
        
    fi;
    
    tensor_unit := GIrreducibleObject( irr[ unit_number ] );
    
    return SemisimpleCategory( field, membership_function, tensor_unit, associator_filename, name );
    
end );

##
InstallMethod( RepresentationCategoryObject,
               [ IsList ],
               
  function( object_list )
    local group, category;
    
    group := UnderlyingGroup( object_list[1][2] );
    
    category := RepresentationCategory( group );
    
    object_list := List( object_list, elem -> [ elem[1], GIrreducibleObject( elem[2] ) ] );
    
    return SemisimpleCategoryObject( object_list, category );
    
end );

##
InstallMethod( RepresentationCategoryObject,
               [ IsCharacter ],
               
  function( character )
    local group, category;
    
    return RepresentationCategoryObject( [ [ 1, character ] ] );
    
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
