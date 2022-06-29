# SPDX-License-Identifier: GPL-2.0-or-later
# LinearAlgebraForCAP: Category of Matrices over a Field for CAP
#
# Implementations
#

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
InstallMethodForCompilerForCAP( MatrixCategoryObjectOp,
                                [ IsMatrixCategory, IsInt ],
                                
  function( cat, dimension )
    local category;
    
    if not IsInt( dimension ) or dimension < 0 then
        
        Error( "the object datum must be a non-negative integer" );
        
    fi;
    
    return ObjectifyObjectForCAPWithAttributes( rec( ), cat,
                                                Dimension, dimension );
    
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
## Attributes
##
####################################

##
InstallMethod( UnderlyingFieldForHomalg,
               [ IsVectorSpaceObject ],
               
  function( object )
    
    return UnderlyingRing( CapCategory( object ) );
    
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
                          RingName( UnderlyingRing( CapCategory( vector_space_object ) ) ),
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
    
    Print( String( vector_space_object ), "\n" );
    
end );

##
InstallMethod( LaTeXOutput,
               [ IsVectorSpaceObject ],
               
  function( vector_space_object )
    
    return Concatenation( LaTeXOutput( UnderlyingRing( CapCategory( vector_space_object ) ) ), "^{1 \\times ", String( Dimension( vector_space_object ) ), "}" );
    
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
    
    return MatrixCategoryObject( category, dim );
    
end );
