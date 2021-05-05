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
## Constructors
##
####################################

##
InstallMethod( VectorSpaceObject,
               [ IsInt, IsFieldForHomalg ],
                
  function( dimension, homalg_field )
    
    return MatrixCategoryObject( MatrixCategory( homalg_field ), dimension );
    
end );

##
InstallMethod( MatrixCategoryObjectOp,
               [ IsMatrixCategory, IsInt ],
               
  function( cat, dimension )
    local category;
    #% CAP_JIT_RESOLVE_FUNCTION
    
    if dimension < 0 then
        
        Error( "the dimension must be a non-negative integer" );
        
    fi;
    
    return ObjectifyObjectForCAPWithAttributes( rec( ), cat,
                                                Dimension, dimension,
                                                UnderlyingFieldForHomalg, UnderlyingRing( cat ) );
    
end );

##
# backwards compatibility
InstallOtherMethod( MatrixCategoryObject,
                    [ IsFieldForHomalg, IsInt ],
                    
  function( homalg_field, dimension )
    
    return MatrixCategoryObject( MatrixCategory( homalg_field ), dimension );
    
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

####################################
##
## Convenience
##
####################################

##
InstallMethod( \/,
               [ IsInt, IsMatrixCategory ],
  function( dim, category )
    
    return VectorSpaceObject( dim, UnderlyingRing( category ) );
    
end );
