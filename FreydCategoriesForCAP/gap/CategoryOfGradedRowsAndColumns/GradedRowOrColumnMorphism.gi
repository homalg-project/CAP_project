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

BindGlobal( "TheFamilyOfGradedRowMorphisms",
        NewFamily( "TheFamilyOfGradedRowMorphisms" ) );

BindGlobal( "TheTypeOfGradedRowMorphisms",
        NewType( TheFamilyOfGradedRowMorphisms, IsGradedRowMorphismRep ) );

DeclareRepresentation( "IsGradedColumnMorphismRep",
                       IsGradedColumnMorphism and IsAttributeStoringRep,
                       [ ] );

BindGlobal( "TheFamilyOfGradedColumnMorphisms",
        NewFamily( "TheFamilyOfGradedColumnMorphisms" ) );

BindGlobal( "TheTypeOfGradedColumnMorphisms",
        NewType( TheFamilyOfGradedColumnMorphisms, IsGradedColumnMorphismRep ) );


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

    # define the type
    if left then
        type := TheTypeOfGradedRowMorphisms;
    else
        type := TheTypeOfGradedColumnMorphisms;
    fi;
    
    ObjectifyWithAttributes( graded_row_or_column_morphism, type, 
                             Source, source,
                             Range, range,
                             UnderlyingHomalgGradedRing, homalg_graded_ring,
                             UnderlyingHomalgMatrix, homalg_matrix
    );

    # add the morphism to the category
    Add( category, graded_row_or_column_morphism );
    
    # and return the morphism
    return graded_row_or_column_morphism;
    
end );

##
InstallMethod( GradedRowOrColumnMorphism,
               [ IsGradedRowOrColumn, IsHomalgMatrix, IsGradedRowOrColumn, IsBool ],
  function( source, homalg_matrix, range, checks_wished )
    local graded_row_or_column_morphism, homalg_graded_ring, category, left, type;
    
    # if checks are wished, hand the input to the method above
    if checks_wished then
      return GradedRowOrColumnMorphism( source, homalg_matrix, range );
    fi;
    
    # checks not wished, so continue here and collect necessary data
    category := CapCategory( source );
    homalg_graded_ring := HomalgRing( homalg_matrix );
    left := IsGradedRows( source );
    
    # define the type
    if left then
        type := TheTypeOfGradedRowMorphisms;
    else
        type := TheTypeOfGradedColumnMorphisms;
    fi;

    # construct the morphism
    graded_row_or_column_morphism := rec( );
    ObjectifyWithAttributes( graded_row_or_column_morphism, type, 
                             Source, source,
                             Range, range,
                             UnderlyingHomalgGradedRing, homalg_graded_ring,
                             UnderlyingHomalgMatrix, homalg_matrix
    );

    # and add it to the category
    Add( category, graded_row_or_column_morphism );
    
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

      return Concatenation( "A morphism in the category of graded rows over ",
                            RingName( UnderlyingHomalgGradedRing( graded_row_or_column_morphism ) ) );

    else

      return Concatenation( "A morphism in the category of graded columns over ",
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
               999, # FIX ME FIX ME
  function( graded_row_or_column_morphism )

    if IsGradedRowMorphism( graded_row_or_column_morphism ) then

      Print( "A morphism in the category of graded rows over ", 
                                   RingName( UnderlyingHomalgGradedRing( graded_row_or_column_morphism ) ),
                                   " with matrix: \n" );

      Display( UnderlyingHomalgMatrix( graded_row_or_column_morphism ) );

    else

      Print( "A morphism in the category of graded columns over ", 
                                   RingName( UnderlyingHomalgGradedRing( graded_row_or_column_morphism ) ),
                                   " with matrix: \n" );

      Display( UnderlyingHomalgMatrix( graded_row_or_column_morphism ) );

    fi;

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



#######################################
##
## FullInformationMethod about morphism
##
#######################################

InstallMethod( FullInformation,
               [ IsGradedRowOrColumnMorphism ],
  function( morphism )

    Print( "\n" );
    Print( "================================================================================= \n \n" );
    
    # Display Source
    Print( "Source: \n" );
    Print( "------- \n" );
    Display( Source( morphism ) );
    Print( "\n" );
    Print( "\n" );
    Print( "--------------------------------------------------------------------------------- \n \n" );
    
    # Display the mapping matrix
    Print( "Mapping matrix: \n" );
    Print( "--------------- \n" );
    Display( UnderlyingHomalgMatrix( morphism ) );
    Print( "\n" );
    
    Print( "--------------------------------------------------------------------------------- \n \n" );
    
    # Display the range"
    Print( "Range: \n" );
    Print( "------ \n" );
    Display( Range( morphism ) );
    Print( "\n \n" );
    Print( "================================================================================= \n \n" );
    
end );
