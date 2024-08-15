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
    
    if not IsBound( homalg_field!.MatrixCategory ) then
        
        homalg_field!.MatrixCategory := MatrixCategory( homalg_field );
        
    fi;
    
    return MatrixCategoryObject( homalg_field!.MatrixCategory, dimension );
    
end );

##
InstallMethodForCompilerForCAP( MatrixCategoryObjectOp,
                                [ IsMatrixCategory, IsInt ],
                                
  function( cat, dimension )
    local category;
    
    if not IsInt( dimension ) or dimension < 0 then
        
        Error( "the object datum must be a non-negative integer" );
        
    fi;
    
    return AsCapCategoryObject( cat, dimension );
    
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

##
InstallMethod( Dimension,
               [ IsVectorSpaceObject ],
               
  function( object )
    
    return AsInteger( object );
    
end );

####################################
##
## View
##
####################################

##
InstallMethod( String,
              [ IsVectorSpaceObject ],
              
  function( vector_space_object )
    
    return Concatenation( "A vector space object over ",
                          RingName( UnderlyingRing( CapCategory( vector_space_object ) ) ),
                          " of dimension ", String( AsInteger( vector_space_object ) ) );
    
end );

##
InstallMethod( ViewString,
               [ IsVectorSpaceObject ],

  function( vector_space_object )

    return Concatenation( "<", String( vector_space_object ), ">" );

end );

##
InstallMethod( DisplayString,
               [ IsVectorSpaceObject ],
               
  function( vector_space_object )
    
    return Concatenation( String( vector_space_object ), "\n" );
    
end );

##
InstallMethod( LaTeXOutput,
               [ IsVectorSpaceObject ],
               
  function( vector_space_object )
    
    return Concatenation( LaTeXOutput( UnderlyingRing( CapCategory( vector_space_object ) ) ), "^{1 \\times ", String( AsInteger( vector_space_object ) ), "}" );
    
end );
