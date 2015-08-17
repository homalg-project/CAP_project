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

DeclareRepresentation( "IsVectorSpaceMorphismRep",
                       IsVectorSpaceMorphism and IsAttributeStoringRep,
                       [ ] );

BindGlobal( "TheFamilyOfVectorSpaceMorphisms",
        NewFamily( "TheFamilyOfVectorSpaceMorphisms" ) );

BindGlobal( "TheTypeOfVectorSpaceMorphisms",
        NewType( TheFamilyOfVectorSpaceMorphisms,
                IsVectorSpaceMorphismRep ) );

####################################
##
## Constructors
##
####################################

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
    
    ObjectifyWithAttributes( vector_space_morphism, TheTypeOfVectorSpaceMorphisms,
                             Source, source,
                             Range, range,
                             UnderlyingFieldForHomalg, homalg_field,
                             UnderlyingHomalgMatrix, homalg_matrix
    );

    Add( category, vector_space_morphism );
    
    return vector_space_morphism;
    
end );

####################################
##
## View
##
####################################

##
InstallMethod( ViewObj,
               [ IsVectorSpaceMorphism ],

  function( vector_space_morphism )

    Print( "A vector space homomorphism over ", 
    RingName( UnderlyingFieldForHomalg( vector_space_morphism ) ),
    " with matrix: \n" );
    
    Display( UnderlyingHomalgMatrix( vector_space_morphism ) );
    
end );
