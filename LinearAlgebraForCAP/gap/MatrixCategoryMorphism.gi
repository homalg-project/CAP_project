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

InstallMethodWithCache( VectorSpaceMorphism,
                        [ IsVectorSpaceObject, IsList, IsVectorSpaceObject ],
                        
  function( source, element_list, range )
    local field, homalg_matrix;
    
    field := UnderlyingFieldForHomalg( source );
    
    homalg_matrix := HomalgMatrix( element_list, Dimension( source ), Dimension( range ), field );
    
    return VectorSpaceMorphism( source, homalg_matrix, range );
    
end );


##
InstallMethod( VectorSpaceMorphism,
               [ IsVectorSpaceObject, IsHomalgMatrix, IsVectorSpaceObject ],
               
  function( source, homalg_matrix, range )
    local vector_space_morphism, homalg_field, category;
    
    category := CapCategory( source );
    
    if not IsIdenticalObj( category, CapCategory( range ) ) then
      
      return Error( "source and range are not defined over identical categories" );
      
    fi;
    
    homalg_field := HomalgRing( homalg_matrix );
    
    if not IsIdenticalObj( homalg_field, UnderlyingFieldForHomalg( source ) ) then
      
      return Error( "the matrix is defined over a different ring than the objects" );
      
    fi;
    
    if NrRows( homalg_matrix ) <> Dimension( source ) then
      
      return Error( "the number of rows has to be equal to the dimension of the source" );
      
    fi;
    
    if NrColumns( homalg_matrix ) <> Dimension( range ) then
      
      return Error( "the number of columns has to be equal to the dimension of the range" );
      
    fi;
    
    vector_space_morphism := rec( );
    
    ObjectifyMorphismForCAPWithAttributes( vector_space_morphism, category,
                                           Source, source,
                                           Range, range,
                                           UnderlyingFieldForHomalg, homalg_field,
                                           UnderlyingMatrix, homalg_matrix
    );
    
    return vector_space_morphism;
    
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
