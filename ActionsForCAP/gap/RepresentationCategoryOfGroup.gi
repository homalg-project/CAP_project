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