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

InstallMethod( VectorSpaceObject,
               [ IsInt, IsFieldForHomalg ],
               
  function( dimension, homalg_field )
    local category, vector_space_object;
    
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

InstallMethod( ViewObj,
               [ IsVectorSpaceObject ],

  function( vector_space_object )

    Print( "<A vector space object over ",
           RingName( UnderlyingFieldForHomalg( vector_space_object ) ),
           " of dimension ", String( Dimension( vector_space_object ) ), ">" );

end );

