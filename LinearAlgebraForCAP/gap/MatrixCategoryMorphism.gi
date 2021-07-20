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
    
    field := UnderlyingFieldForHomalg( source );
    
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
    
    return MorphismConstructor( cat, source, homalg_matrix, range );
    
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


####################################
##
## Convenience
##
####################################

##
InstallMethod( \/,
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
