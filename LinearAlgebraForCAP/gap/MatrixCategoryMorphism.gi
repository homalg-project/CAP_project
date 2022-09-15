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
InstallMethod( AsVectorSpaceMorphism,
               [ IsHomalgMatrix ],
               
  function( homalg_matrix )
    local field;
    
    field := HomalgRing( homalg_matrix );
    
    return VectorSpaceMorphism(
      VectorSpaceObject( NrRows( homalg_matrix ), field ),
      homalg_matrix,
      VectorSpaceObject( NrColumns( homalg_matrix ), field )
    );
    
end );

##
# convenience
InstallMethod( VectorSpaceMorphism,
               [ IsVectorSpaceObject, IsList, IsVectorSpaceObject ],
               
  function( source, element_list, range )
    local field, homalg_matrix;
    
    field := UnderlyingRing( CapCategory( source ) );
    
    homalg_matrix := HomalgMatrix( element_list, Dimension( source ), Dimension( range ), field );
    
    return VectorSpaceMorphism( source, homalg_matrix, range );
    
end );

##
# convenience
InstallMethod( VectorSpaceMorphism,
               [ IsVectorSpaceObject, IsHomalgMatrix, IsVectorSpaceObject ],
               
  function( source, homalg_matrix, range )
    
    return VectorSpaceMorphism( CapCategory( source ), source, homalg_matrix, range );
    
end );

##
InstallOtherMethodForCompilerForCAP( VectorSpaceMorphism,
                                     [ IsMatrixCategory, IsVectorSpaceObject, IsHomalgMatrix, IsVectorSpaceObject ],
                                     
  function( cat, source, homalg_matrix, range )
    
    if not IsHomalgMatrix( homalg_matrix ) then
        
        Error( "the morphism datum must be a homalg matrix" );
        
    fi;
    
    if not IsIdenticalObj( HomalgRing( homalg_matrix ), UnderlyingRing( cat ) ) then
        
        Error( "the matrix is defined over a different ring than the category" );
        
    fi;
    
    if NrRows( homalg_matrix ) <> Dimension( source ) then
        
        Error( "the number of rows has to be equal to the dimension of the source" );
        
    fi;
    
    if NrColumns( homalg_matrix ) <> Dimension( range ) then
        
        Error( "the number of columns has to be equal to the dimension of the range" );
        
    fi;
    
    return CreateCapCategoryMorphismWithAttributes( cat, source, range,
                                                    UnderlyingMatrix, homalg_matrix
    );
    
end );

####################################
##
## Attributes
##
####################################

##
InstallMethod( UnderlyingFieldForHomalg,
               [ IsVectorSpaceMorphism ],
               
  function( morphism )
    
    return UnderlyingRing( CapCategory( morphism ) );
    
end );

####################################
##
## View
##
####################################

##
InstallMethod( Display,
               [ IsVectorSpaceMorphism ],
               
  function( vector_space_morphism )
    
    Display( UnderlyingMatrix( vector_space_morphism ) );
    
    Print( "\n" );
    
    Print( StringMutable( vector_space_morphism ) );
    
    Print( "\n" );
    
end );

##
InstallMethod( LaTeXOutput,
          [ IsVectorSpaceMorphism ],
          
  function( vector_space_morphism )
    local matrix;
    
    matrix := LaTeXOutput( UnderlyingMatrix( vector_space_morphism ) );
    
    if ValueOption( "OnlyDatum" ) = true then
       
       return Concatenation(
        """{\color{blue}{""",
        matrix,
        """}}"""
      );
      
    else
      
      return Concatenation(
        LaTeXOutput( Source( vector_space_morphism ) ),
        """{\color{blue}{\xrightarrow{""",
        matrix,
        """}}}""",
        LaTeXOutput( Range( vector_space_morphism ) )
      );
      
    fi;
    
end );

####################################
##
## Convenience
##
####################################

##
InstallOtherMethod( \/,
               [ IsHomalgMatrix, IsMatrixCategory ],
  function( homalg_matrix, category )
    local field;
    
    field := HomalgRing( homalg_matrix );
    
    return VectorSpaceMorphism(
      MatrixCategoryObject( category, NrRows( homalg_matrix ) ),
      homalg_matrix,
      MatrixCategoryObject( category, NrColumns( homalg_matrix ) )
    );
    
end );
