#############################################################################
##
## FreydCategoriesForCAP package
##
## Copyright 2019, Martin Bies,       ULB Brussels
##
## Chapter Morphisms
##
#############################################################################

####################################
##
## GAP Category
##
####################################

DeclareRepresentation( "IsGradedRowMorphismRep",
                       IsGradedRowMorphism and IsAttributeStoringRep,
                       [ ] );

DeclareRepresentation( "IsGradedColumnMorphismRep",
                       IsGradedColumnMorphism and IsAttributeStoringRep,
                       [ ] );

####################################
##
## Constructors
##
####################################

##
InstallMethod( GradedRowOrColumnMorphism,
               [ IsGradedRowOrColumn, IsHomalgMatrix, IsGradedRowOrColumn ],
  function( source, homalg_matrix, range )
    local graded_row_or_column_morphism, homalg_graded_ring, category, left, type;
    
    # get category of source
    category := CapCategory( source );
    
    # check that source and range are objects in the same category
    if not IsIdenticalObj( category, CapCategory( range ) ) then
      
      Error( "Source and range are not defined over identical categories" );
      return;

    fi;
    
    # extract the homalg_graded_ring
    homalg_graded_ring := HomalgRing( homalg_matrix );
    
    # make a number of sanity tests (for left presentations actually!)
    if not IsIdenticalObj( homalg_graded_ring, UnderlyingHomalgGradedRing( source ) ) then
      
      Error( "The matrix is defined over a different ring than the objects" );
      return;

    fi;

    # work out if we are considering left or right presentations
    left := IsGradedRow( source );
    
    # and correspondingly check the dimensions of the matrix
    if left then
      
      if NrRows( homalg_matrix ) <> Rank( source ) then
          
          Error( "The number of rows of the given matrix is incorrect" );
          return;

      fi;
      
      if NrColumns( homalg_matrix ) <> Rank( range ) then
        
        Error( "The number of columns of the given matrix is incorrect" );
        return;
        
      fi;
      
    else
      
      if NrColumns( homalg_matrix ) <> Rank( source ) then
        
        Error( "The number of columns of the given matrix is incorrect" );
        return;
        
      fi;
      
      if NrRows( homalg_matrix ) <> Rank( range ) then
        
        Error( "The number of rows of the given matrix is incorrect" );
        return;
        
      fi;
      
    fi;
    
    # now create the morphism
    graded_row_or_column_morphism := rec( );
    
    ObjectifyMorphismForCAPWithAttributes(
      graded_row_or_column_morphism, category,
      Source, source,
      Range, range,
      UnderlyingHomalgGradedRing, homalg_graded_ring,
      UnderlyingHomalgMatrix, homalg_matrix
    );
    
    # and return the morphism
    return graded_row_or_column_morphism;
    
end );

##
InstallMethod( GradedRowOrColumnMorphism,
               [ IsGradedRowOrColumn, IsHomalgMatrix, IsGradedRowOrColumn, IsBool ],
  function( source, homalg_matrix, range, checks_wished )
    local graded_row_or_column_morphism, homalg_graded_ring, category, type;
    
    # if checks are wished, hand the input to the method above
    if checks_wished then
      return GradedRowOrColumnMorphism( source, homalg_matrix, range );
    fi;
    
    # checks not wished, so continue here and collect necessary data
    category := CapCategory( source );
    homalg_graded_ring := HomalgRing( homalg_matrix );
    
    # construct the morphism
    graded_row_or_column_morphism := rec( );
    
    ObjectifyMorphismForCAPWithAttributes( 
      graded_row_or_column_morphism, category,
      Source, source,
      Range, range,
      UnderlyingHomalgGradedRing, homalg_graded_ring,
      UnderlyingHomalgMatrix, homalg_matrix
    );
    
    # finally return the morphism
    return graded_row_or_column_morphism;

end );



####################################
##
## String
##
####################################

##
InstallMethod( String,
               [ IsGradedRowOrColumnMorphism ],
               999, # FIX ME FIX ME FIX ME!!!
  function( graded_row_or_column_morphism )

    if IsGradedRowMorphism( graded_row_or_column_morphism ) then

      return Concatenation( "A morphism in Category of graded rows over ",
                            RingName( UnderlyingHomalgGradedRing( graded_row_or_column_morphism ) ) );

    else

      return Concatenation( "A morphism in Category of graded columns over ",
                            RingName( UnderlyingHomalgGradedRing( graded_row_or_column_morphism ) ) );

    fi;

end );



####################################
##
## Display
##
####################################

InstallMethod( Display,
               [ IsGradedRowOrColumnMorphism ], 
  function( graded_row_or_column_morphism )
    
    # source
    Print( "Source: \n" );
    Display( Source( graded_row_or_column_morphism ) );
    
    # mapping matrix
    Print( Concatenation( "\n", "Matrix: \n" ) );
    Display( UnderlyingHomalgMatrix( graded_row_or_column_morphism ) );
    
    # range
    Print( Concatenation( "\n", "Range: \n" ) );
    Display( Range( graded_row_or_column_morphism ) );
    Print( "\n" );
    
    # general information on morphism
    Print( StringMutable( graded_row_or_column_morphism ) );
    
end );



####################################
##
## View
##
####################################

##
InstallMethod( ViewObj,
               [ IsGradedRowOrColumnMorphism ], 
               999, # FIX ME FIX ME FIX ME!!!
function( graded_row_or_column_morphism )

      Print( Concatenation( "<", String( graded_row_or_column_morphism ), ">" ) );

end );
