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
InstallMethod( VectorSpaceMorphism,
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
    local homalg_field, category;
    #% CAP_JIT_RESOLVE_FUNCTION
    
    category := CapCategory( source );
    
    if not IsIdenticalObj( category, CapCategory( range ) ) then
      
      Error( "source and range are not defined over identical categories" );
      
    fi;
    
    homalg_field := HomalgRing( homalg_matrix );
    
    if not IsIdenticalObj( homalg_field, UnderlyingFieldForHomalg( source ) ) then
      
      Error( "the matrix is defined over a different ring than the objects" );
      
    fi;
    
    if NrRows( homalg_matrix ) <> Dimension( source ) then
      
      Error( "the number of rows has to be equal to the dimension of the source" );
      
    fi;
    
    if NrColumns( homalg_matrix ) <> Dimension( range ) then
      
      Error( "the number of columns has to be equal to the dimension of the range" );
      
    fi;
    
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec( ), category,
                                           source,
                                           range,
                                           UnderlyingFieldForHomalg, category!.field_for_matrix_category,
                                           UnderlyingMatrix, homalg_matrix
    );
    
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
    
    return AsVectorSpaceMorphism( homalg_matrix );
    
end );
