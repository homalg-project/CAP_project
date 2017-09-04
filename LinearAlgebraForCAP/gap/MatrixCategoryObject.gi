#############################################################################
##
##                                LinearAlgebraForCAP package
##
##  Copyright 2015, Sebastian Gutsche, TU Kaiserslautern
##                  Sebastian Posur,   RWTH Aachen
##
##
#############################################################################

####################################
##
## GAP Category
##
####################################

DeclareRepresentation( "IsVectorSpaceObjectRep",
                       IsVectorSpaceObject and IsAttributeStoringRep,
                       [ ] );

BindGlobal( "TheFamilyOfVectorSpaceObjects",
        NewFamily( "TheFamilyOfVectorSpaceObjects" ) );

BindGlobal( "TheTypeOfVectorSpaceObjects",
        NewType( TheFamilyOfVectorSpaceObjects,
                IsVectorSpaceObjectRep ) );

####################################
##
## Constructors
##
####################################

##
InstallMethodWithCache( VectorSpaceObject,
                        [ IsInt, IsFieldForHomalg ],
               
  function( dimension, homalg_field )
    local category, vector_space_object;
    
    if dimension < 0 then
      
      return Error( "first argument must be a non-negative integer" );
      
    fi;
    
    category := MatrixCategory( homalg_field );
    
    vector_space_object := rec( );
    
    ObjectifyWithAttributes( vector_space_object, TheTypeOfVectorSpaceObjects,
                             Dimension, dimension,
                             UnderlyingFieldForHomalg, homalg_field
    );

    Add( category, vector_space_object );
    
    return vector_space_object;
    
end );

####################################
##
## View
##
####################################

InstallMethod( String,
              [ IsVectorSpaceObject ],
              
  function( vector_space_object )
    
    return Concatenation( "A vector space object over ",
                          RingName( UnderlyingFieldForHomalg( vector_space_object ) ),
                          " of dimension ", String( Dimension( vector_space_object ) ) );
    
end );
##
InstallMethod( ViewObj,
               [ IsVectorSpaceObject ],

  function( vector_space_object )

    Print( Concatenation( "<", String( vector_space_object ), ">" ) );

end );

##
InstallMethod( Display,
               [ IsVectorSpaceObject ],
               
  function( vector_space_object )
    
    Print( String( vector_space_object ) );
    
end );