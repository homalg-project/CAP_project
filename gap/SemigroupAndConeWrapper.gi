####################################################################################
##
##                  CAPCategoryOfProjectiveGradedModules package
##
##  Copyright 2015, Martin Bies,       ITP Heidelberg
##
##  Chapter Wrapper for generators of semigroups and hyperplane constraints of cones
##
####################################################################################

############################################
##
##  Section GAP Categories
##
############################################

DeclareRepresentation( "IsSemigroupGeneratorListRep",
                       IsSemigroupGeneratorList and IsAttributeStoringRep,
                       [ ] );

BindGlobal( "TheFamilyOfSemigroupGeneratorLists",
        NewFamily( "TheFamilyOfSemigroupGeneratorLists" ) );

BindGlobal( "TheTypeOfSemigroupGeneratorLists",
        NewType( TheFamilyOfSemigroupGeneratorLists,
                IsSemigroupGeneratorListRep ) );


DeclareRepresentation( "IsConeHPresentationListRep",
                       IsConeHPresentationList and IsAttributeStoringRep,
                       [ ] );

BindGlobal( "TheFamilyOfConeHPresentationLists",
        NewFamily( "TheFamilyOfConeHPresentationLists" ) );

BindGlobal( "TheTypeOfConeHPresentationLists",
        NewType( TheFamilyOfConeHPresentationLists,
                IsConeHPresentationListRep ) );



############################################
##
#! @Section Constructors
##
############################################

InstallMethod( SemigroupGeneratorList,
               [ IsList ],
  function( list_of_generators )
    local helper_list, i, j, sg_generator_list;

    # we expect at least one generator
    if Length( list_of_generators ) = 0 then
      Error( "no generator given" );
      return;
    fi;

    # we have to check that 
    # (1) all entries of the list_of_generators are of the same length
    # (2) all entries are integers

    # @ (1)
    helper_list := DuplicateFreeList( 
                           List( [ 1 .. Length( list_of_generators ) ], i -> Length( list_of_generators[ i ] ) ) );
    if Length( helper_list ) > 1 then
      Error( "all generators have to be of the same length");
      return;
    elif helper_list[ 1 ] = 0 then
      Error( "the generators must be of length 1 or longer" );
      return;
    fi;

    # @ (2)
    for i in [ 1 .. Length( list_of_generators ) ] do

      for j in [ 1 .. Length( list_of_generators[ i ] ) ] do

        if not IsInt( list_of_generators[ i ][ j ] ) then
          Error( "the entries of all generators must be integers" );
          return;
        fi;

      od;

    od;

    # all checks passed, so create the SemigroupGeneratorList
    sg_generator_list := rec();
    ObjectifyWithAttributes( sg_generator_list, TheTypeOfSemigroupGeneratorLists,
                             UnderlyingList, list_of_generators
                            );

    # and return this object
    return sg_generator_list;

end );

InstallMethod( ConeHPresentationList,
               [ IsList ],
  function( list_of_generators )
    local helper_list, i, j, cone_hpresentation_list;

    # we expect at least one h-constraint
    if Length( list_of_generators ) = 0 then
      Error( "no h-constraint given" );
      return;
    fi;

    # we have to check that 
    # (1) all entries of the list_of_generators are of the same length
    # (2) all entries are integers

    # @ (1)
    helper_list := DuplicateFreeList( 
                           List( [ 1 .. Length( list_of_generators ) ], i -> Length( list_of_generators[ i ] ) ) );
    if Length( helper_list ) > 1 then
      Error( "all h-constraints have to be of the same length");
      return;
    elif helper_list[ 1 ] = 0 then
      Error( "the h-constraints must be of length 1 or longer" );
      return;
    fi;

    # @ (2)
    for i in [ 1 .. Length( list_of_generators ) ] do

      for j in [ 1 .. Length( list_of_generators[ i ] ) ] do

        if not IsInt( list_of_generators[ i ][ j ] ) then
          Error( "the entries of all h-constraints must be integers" );
          return;
        fi;

      od;

    od;

    # all checks passed, so create the ConeHPresentationList
    cone_hpresentation_list := rec();
    ObjectifyWithAttributes( cone_hpresentation_list, TheTypeOfConeHPresentationLists,
                             UnderlyingList, list_of_generators
                            );

    # and return this object
    return cone_hpresentation_list;

end );

InstallMethod( ConeHPresentationList,
               [ IsNormalizCone ],
  function( cone )
    local underlying_list, cone_hpresentation_list;

    # check if the cone is full-dimensional, so that normaliz can compute an H-presentation
    NmzCompute( cone );
    if NmzRank( cone ) <> NmzEmbeddingDimension( cone ) then

      Error( "Normaliz cannot compute an H-presentation of cones that are not full-dimensional" );
      return;

    fi;

    # if normaliz can provide an h-presentation, we can now compute a ConeHPresentationList
    underlying_list := NmzSupportHyperplanes( cone );
    cone_hpresentation_list := rec();
    ObjectifyWithAttributes( cone_hpresentation_list, TheTypeOfConeHPresentationLists,
                             UnderlyingList, underlying_list
                            );

    # and return this object
    return cone_hpresentation_list;

end );



####################################
##
## String
##
####################################

InstallMethod( String,
              [ IsSemigroupGeneratorList ],
  function( semigroup_generator_list )

    return Concatenation( "A list of generators of a semigroup of Z^",
                          String( Length( UnderlyingList( semigroup_generator_list )[ 1 ] ) ) );

end );

InstallMethod( String,
              [ IsConeHPresentationList ],
  function( cone_hpresentation_list )

    return Concatenation( "A list of hyperplane constraints of a cone in Z^",
                          String( Length( UnderlyingList( cone_hpresentation_list )[ 1 ] ) ) );

end );

####################################
##
## Display
##
####################################

InstallMethod( Display,
               [ IsSemigroupGeneratorList ],
  function( semigroup_generator_list )

    Print( Concatenation( String( semigroup_generator_list ), " - generators are as follows: \n" ) );
    Display( UnderlyingList( semigroup_generator_list ) );

end );

InstallMethod( Display,
               [ IsConeHPresentationList ],
  function( cone_hpresentation_list )

    Print( Concatenation( String( cone_hpresentation_list ), " - h-constraints are as follows: \n" ) );
    Display( UnderlyingList( cone_hpresentation_list ) );

end );

####################################
##
## ViewObj
##
####################################

InstallMethod( ViewObj,
               [ IsSemigroupGeneratorList ],
  function( semigroup_generator_list )

    Print( Concatenation( "<", String( semigroup_generator_list ), ">" ) );

end );

InstallMethod( ViewObj,
               [ IsConeHPresentationList ],
  function( cone_hpresentation_list )

    Print( Concatenation( "<", String( cone_hpresentation_list ), ">" ) );

end );



############################################
##
##  Section Property
##
############################################

InstallMethod( IsConeSemigroup,
               "for semigroup_generator_lists",
               [ IsSemigroupGeneratorList ],
  function( semigroup_generator_list )
    local list_of_generators, cone, hilbert_basis, i, pos;

    # extract the necessary data
    list_of_generators := UnderlyingList( semigroup_generator_list );
    cone := NmzCone( [ "integral_closure", list_of_generators ] );
    NmzCompute( cone );

    # check if Normaliz could compute a Hilbert basis
    if not NmzHasConeProperty( cone, "HilbertBasis" ) then

      Error( "Normaliz could not compute a Hilbert basis " );
      return;

    fi;

    # then extract the Hilbet basis
    hilbert_basis := NmzHilbertBasis( cone );

    # now compare list_of_generators and hilbert_basis modulo potential permutations
    if Length( hilbert_basis ) <> Length( list_of_generators ) then
      return false;
    fi;

    # find matches of the elements in the list_of_generators in hilbert_basis and then delete those elements from
    # the hilbert_basis
    for i in [ 1 .. Length( list_of_generators ) ] do

      pos := 1;
      while not list_of_generators[ i ] = hilbert_basis[ pos ] do
        pos := pos + 1;

        if pos > Length( hilbert_basis ) then
          return false;
        fi;

      od;

      # found match at position "pos" in hilbert_basis, so delete this entry from hilbert_basis
      Remove( hilbert_basis, pos );

    od;

    # and give the final answer
    return Length( hilbert_basis ) = 0;

end );



#################################################
##
##  Section Conversion into ConeHPresentationList
##
#################################################

InstallMethod( TurnIntoConeHPresentationList,
               "for semigroup_generator_lists",
               [ IsSemigroupGeneratorList ],
  function( semigroup_generator_list )
    local cone, underlying_list, cone_hpresentation_list;

    # first check if the conversion can work in the first place
    if not IsConeSemigroup( semigroup_generator_list ) then

      return fail;

    fi;

    # now try to return the ConeHPresentation list associated to the cone generated by the semigroup_generator_list
    cone := NmzCone( [ "integral_closure", UnderlyingList( semigroup_generator_list ) ] );

    # check if the cone is full-dimensional, so that normaliz can compute an H-presentation
    NmzCompute( cone );
    if NmzRank( cone ) <> NmzEmbeddingDimension( cone ) then

      return fail;

    fi;

    # if normaliz can provide an h-presentation, we can now compute a ConeHPresentationList
    underlying_list := NmzSupportHyperplanes( cone );
    cone_hpresentation_list := rec();
    ObjectifyWithAttributes( cone_hpresentation_list, TheTypeOfConeHPresentationLists,
                             UnderlyingList, underlying_list
                            );

    # and return this object
    return cone_hpresentation_list;

end );