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

##
DeclareRepresentation( "IsSemigroupGeneratorListRep",
                       IsSemigroupGeneratorList and IsAttributeStoringRep,
                       [ ] );

BindGlobal( "TheFamilyOfSemigroupGeneratorLists",
        NewFamily( "TheFamilyOfSemigroupGeneratorLists" ) );

BindGlobal( "TheTypeOfSemigroupGeneratorLists",
        NewType( TheFamilyOfSemigroupGeneratorLists,
                IsSemigroupGeneratorListRep ) );

##
DeclareRepresentation( "IsConeHPresentationListRep",
                       IsConeHPresentationList and IsAttributeStoringRep,
                       [ ] );

BindGlobal( "TheFamilyOfConeHPresentationLists",
        NewFamily( "TheFamilyOfConeHPresentationLists" ) );

BindGlobal( "TheTypeOfConeHPresentationLists",
        NewType( TheFamilyOfConeHPresentationLists,
                IsConeHPresentationListRep ) );

##
DeclareRepresentation( "IsConeVPresentationListRep",
                       IsConeVPresentationList and IsAttributeStoringRep,
                       [ ] );

BindGlobal( "TheFamilyOfConeVPresentationLists",
        NewFamily( "TheFamilyOfConeVPresentationLists" ) );

BindGlobal( "TheTypeOfConeVPresentationLists",
        NewType( TheFamilyOfConeVPresentationLists,
                IsConeVPresentationListRep ) );

##
DeclareRepresentation( "IsAffineSemigroupRep",
                       IsAffineSemigroup and IsAttributeStoringRep,
                       [ ] );

BindGlobal( "TheFamilyOfAffineSemigroups",
        NewFamily( "TheFamilyOfAffineSemigroups" ) );

BindGlobal( "TheTypeOfAffineSemigroups",
        NewType( TheFamilyOfAffineSemigroups,
                IsAffineSemigroupRep ) );

##
DeclareRepresentation( "IsAffineConeSemigroupRep",
                       IsAffineConeSemigroup and IsAttributeStoringRep,
                       [ ] );

BindGlobal( "TheFamilyOfAffineConeSemigroups",
        NewFamily( "TheFamilyOfAffineConeSemigroups" ) );

BindGlobal( "TheTypeOfAffineConeSemigroups",
        NewType( TheFamilyOfAffineConeSemigroups,
                IsAffineConeSemigroupRep ) );



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
                             UnderlyingList, DuplicateFreeList( list_of_generators ),
                             EmbeddingDimension, Length( list_of_generators[ 1 ] )
                            );

    # and return this object
    return sg_generator_list;

end );

InstallMethod( ConeHPresentationList,
               [ IsList ],
  function( list_of_hconstraints )
    local helper_list, i, j, cone_hpresentation_list;

    # we expect at least one h-constraint
    if Length( list_of_hconstraints ) = 0 then
      Error( "no h-constraint given" );
      return;
    fi;

    # we have to check that 
    # (1) all entries of the list_of_hconstraints are of the same length
    # (2) all entries are integers

    # @ (1)
    helper_list := DuplicateFreeList( 
                           List( [ 1 .. Length( list_of_hconstraints ) ], i -> Length( list_of_hconstraints[ i ] ) ) );
    if Length( helper_list ) > 1 then
      Error( "all h-constraints have to be of the same length");
      return;
    elif helper_list[ 1 ] = 0 then
      Error( "the h-constraints must be of length 1 or longer" );
      return;
    fi;

    # @ (2)
    for i in [ 1 .. Length( list_of_hconstraints ) ] do

      for j in [ 1 .. Length( list_of_hconstraints[ i ] ) ] do

        if not IsInt( list_of_hconstraints[ i ][ j ] ) then
          Error( "the entries of all h-constraints must be integers" );
          return;
        fi;

      od;

    od;

    # all checks passed, so create the ConeHPresentationList
    cone_hpresentation_list := rec();
    ObjectifyWithAttributes( cone_hpresentation_list, TheTypeOfConeHPresentationLists,
                             UnderlyingList, DuplicateFreeList( list_of_hconstraints ),
                             EmbeddingDimension, Length( list_of_hconstraints[ 1 ] )
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
                             UnderlyingList, underlying_list,
                             EmbeddingDimension, NmzEmbeddingDimension( cone )
                            );

    # and return this object
    return cone_hpresentation_list;

end );

InstallMethod( ConeVPresentationList,
               [ IsList ],
  function( list_of_generators )
    local helper_list, i, j, cone_vpresentation_list;

    # we expect at least one h-constraint
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

    # all checks passed, so create the ConeHPresentationList
    cone_vpresentation_list := rec();
    ObjectifyWithAttributes( cone_vpresentation_list, TheTypeOfConeVPresentationLists,
                             UnderlyingList, DuplicateFreeList( list_of_generators ),
                             EmbeddingDimension, Length( list_of_generators[ 1 ] )
                            );

    # and return this object
    return cone_vpresentation_list;

end );

InstallMethod( ConeVPresentationList,
               [ IsNormalizCone ],
  function( cone )
    local underlying_list, cone_vpresentation_list;

    # check if the cone is full-dimensional, so that normaliz can compute an H-presentation
    NmzCompute( cone );
    if not NmzHasConeProperty( cone,"HilbertBasis" ) then

      Error( "Normaliz could not compute a Hilbert basis of the semigroup of the given cone" );
      return;

    fi;

    # if normaliz can provide a Hilbert basis, we use it
    underlying_list := NmzHilbertBasis( cone );
    cone_vpresentation_list := rec();
    ObjectifyWithAttributes( cone_vpresentation_list, TheTypeOfConeVPresentationLists,
                             UnderlyingList, underlying_list,
                             EmbeddingDimension, NmzEmbeddingDimension( cone )
                            );

    # and return this object
    return cone_vpresentation_list;

end );

InstallMethod( AffineConeSemigroup,
               [ IsNormalizCone, IsList ],
  function( cone, offset_point )
    local i, affine_cone_semigroup;

    # now check that the offset_point lies in the same lattice as the semigroup of the cone
    NmzCompute( cone );
    if not Length( offset_point ) = NmzEmbeddingDimension( cone ) then
      Error( "The offset_point and the semigroup of the cone are not embedded into isomorphic lattices" );
      return;
    fi;
    for i in [ 1 .. Length( offset_point ) ] do
      if not IsInt( offset_point[ i ] ) then
        Error( "The offset_point must be given as a list of integers" );
        return;
      fi;
    od;

    # we have found that the input is valid, so collect the information that we need about the cone
    affine_cone_semigroup := rec();
    if NmzHasConeProperty( cone, "HilbertBasis" ) and NmzRank( cone ) = NmzEmbeddingDimension( cone ) then

      ObjectifyWithAttributes( affine_cone_semigroup, TheTypeOfAffineConeSemigroups,
                               UnderlyingCone, cone,
                               Offset, offset_point,
                               UnderlyingConeVPresentationList, ConeVPresentationList( NmzHilbertBasis( cone ) ),
                               UnderlyingConeHPresentationList, ConeHPresentationList( NmzSupportHyperplanes( cone ) ),
                               EmbeddingDimension, Length( offset_point )
                            );

    elif NmzHasConeProperty( cone, "HilbertBasis" ) and NmzRank( cone ) <> NmzEmbeddingDimension( cone ) then

      ObjectifyWithAttributes( affine_cone_semigroup, TheTypeOfAffineConeSemigroups,
                               UnderlyingCone, cone,
                               Offset, offset_point,
                               UnderlyingConeVPresentationList, ConeVPresentationList( NmzHilbertBasis( cone ) ),
                               EmbeddingDimension, Length( offset_point )
                            );

    fi;

    # and return this object
    return affine_cone_semigroup;

end );

InstallMethod( AffineConeSemigroup,
               [ IsConeVPresentationList, IsList ],
  function( cone_vpresentation_list, offset_point )
    local cone, i, affine_cone_semigroup;

    # compute the cone
    cone := NmzCone( [ "integral_closure", UnderlyingList( cone_vpresentation_list ) ] );
    NmzCompute( cone );

    # now check that the offset_point lies in the same lattice as the semigroup of the cone
    if not Length( offset_point ) = NmzEmbeddingDimension( cone ) then
      Error( "The offset_point and the semigroup of the cone are not embedded into isomorphic lattices" );
      return;
    fi;
    for i in [ 1 .. Length( offset_point ) ] do
      if not IsInt( offset_point[ i ] ) then
        Error( "The offset_point must be given as a list of integers" );
        return;
      fi;
    od;

    # we have found that the input is valid, so collect the information that we need about the cone
    affine_cone_semigroup := rec();
    if NmzRank( cone ) = NmzEmbeddingDimension( cone ) then

      ObjectifyWithAttributes( affine_cone_semigroup, TheTypeOfAffineConeSemigroups,
                               UnderlyingCone, cone,
                               Offset, offset_point,
                               UnderlyingConeVPresentationList, cone_vpresentation_list,
                               UnderlyingConeHPresentationList, ConeHPresentationList( NmzSupportHyperplanes( cone ) ),
                               EmbeddingDimension, Length( offset_point )
                            );

    elif NmzRank( cone ) <> NmzEmbeddingDimension( cone ) then

      ObjectifyWithAttributes( affine_cone_semigroup, TheTypeOfAffineConeSemigroups,
                               UnderlyingCone, cone,
                               Offset, offset_point,
                               UnderlyingConeVPresentationList, cone_vpresentation_list,
                               EmbeddingDimension, Length( offset_point )
                            );

    fi;

    # and return this object
    return affine_cone_semigroup;

end );

InstallMethod( AffineConeSemigroup,
               [ IsConeHPresentationList, IsList ],
  function( cone_hpresentation_list, offset_point )
    local cone, i, affine_cone_semigroup;

    # compute the cone
    cone := NmzCone( [ "inequalities", UnderlyingList( cone_hpresentation_list ) ] );
    NmzCompute( cone );

    # now check that the offset_point lies in the same lattice as the semigroup of the cone
    if not Length( offset_point ) = NmzEmbeddingDimension( cone ) then
      Error( "The offset_point and the semigroup of the cone are not embedded into isomorphic lattices" );
      return;
    fi;
    for i in [ 1 .. Length( offset_point ) ] do
      if not IsInt( offset_point[ i ] ) then
        Error( "The offset_point must be given as a list of integers" );
        return;
      fi;
    od;

    # we have found that the input is valid, so collect the information that we need about the cone
    affine_cone_semigroup := rec();
    if NmzHasConeProperty( cone, "HilbertBasis" ) then

      ObjectifyWithAttributes( affine_cone_semigroup, TheTypeOfAffineConeSemigroups,
                               UnderlyingCone, cone,
                               Offset, offset_point,
                               UnderlyingConeVPresentationList, ConeVPresentationList( NmzHilbertBasis( cone ) ),
                               UnderlyingConeHPresentationList, cone_hpresentation_list,
                               EmbeddingDimension, Length( offset_point )
                            );

    else

      ObjectifyWithAttributes( affine_cone_semigroup, TheTypeOfAffineConeSemigroups,
                               UnderlyingCone, cone,
                               Offset, offset_point,
                               UnderlyingConeHPresentationList, cone_hpresentation_list,
                               EmbeddingDimension, Length( offset_point )
                            );

    fi;

    # and return this object
    return affine_cone_semigroup;

end );

InstallMethod( AffineSemigroup,
               [ IsSemigroupGeneratorList, IsList ],
  function( semigroup_generator_list, offset_point )
    local conversion, i, affine_semigroup;

    # first check if the givne semigroup_generator_list encodes the semigroup of a cone
    conversion := TurnIntoConeHPresentationList( semigroup_generator_list );
    if conversion <> fail then
      return AffineConeSemigroup( conversion, offset_point );
    fi;

    # now check that the offset_point lies in the same lattice as the semigroup of the cone
    if not Length( offset_point ) = Length( UnderlyingList( semigroup_generator_list )[ 1 ] ) then
      Error( "The offset_point and the semigroup are not embedded into isomorphic lattices" );
      return;
    fi;
    for i in [ 1 .. Length( offset_point ) ] do
      if not IsInt( offset_point[ i ] ) then
        Error( "The offset_point must be given as a list of integers" );
        return;
      fi;
    od;

    # we have found that the input is valid, so collect the information that we need about the cone
    affine_semigroup := rec();
    ObjectifyWithAttributes( affine_semigroup, TheTypeOfAffineSemigroups,
                               UnderlyingSemigroupGeneratorList, semigroup_generator_list,
                               Offset, offset_point,
                               EmbeddingDimension, Length( offset_point )
                            );

    # and return this object
    return affine_semigroup;

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

InstallMethod( String,
              [ IsConeVPresentationList ],
  function( cone_vpresentation_list )

    return Concatenation( "A list of vertex generators of a cone in Z^",
                          String( Length( UnderlyingList( cone_vpresentation_list )[ 1 ] ) ) );

end );

InstallMethod( String,
              [ IsAffineConeSemigroup ],
  function( affine_cone_semigroup )

    return Concatenation( "An affine cone_semigroup in Z^",
                          String( EmbeddingDimension( affine_cone_semigroup ) ) );

end );

InstallMethod( String,
              [ IsAffineSemigroup ],
  function( affine_semigroup )

    return Concatenation( "An affine semigroup in Z^",
                          String( EmbeddingDimension( affine_semigroup ) ) );

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

InstallMethod( Display,
               [ IsConeVPresentationList ],
  function( cone_vpresentation_list )

    Print( Concatenation( String( cone_vpresentation_list ), " - generators are as follows: \n" ) );
    Display( UnderlyingList( cone_vpresentation_list ) );

end );

InstallMethod( Display,
              [ IsAffineConeSemigroup ],
  function( affine_cone_semigroup )

    Print( Concatenation( "An affine cone_semigroup in Z^",
                          String( EmbeddingDimension( affine_cone_semigroup ) ),
                          "\n" ) );
    Print( Concatenation( "Offset: ", String( Offset( affine_cone_semigroup ) ), "\n" ) );
    
    if HasUnderlyingConeVPresentationList( affine_cone_semigroup ) then
      Print( Concatenation( "Cone generators: ", 
                            String( UnderlyingList( UnderlyingConeVPresentationList( affine_cone_semigroup ) ) ) ) );
    else
      Print( Concatenation( "Cone h-presentation: ",
                            String( UnderlyingList( UnderlyingConeHPresentationList( affine_cone_semigroup ) ) ) ) );
    fi;

end );

InstallMethod( Display,
              [ IsAffineSemigroup ],
  function( affine_semigroup )

    Print( Concatenation( "An affine semigroup in Z^",
                          String( EmbeddingDimension( affine_semigroup ) ),
                          "\n" ) );
    Print( Concatenation( "Offset: ", String( Offset( affine_semigroup ) ), "\n" ) );
    Print( Concatenation( "Semigroup generators: ", 
                          String( UnderlyingList( UnderlyingSemigroupGeneratorList( affine_semigroup ) ) ) 
                         ) );

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

InstallMethod( ViewObj,
               [ IsConeVPresentationList ],
  function( cone_vpresentation_list )

    Print( Concatenation( "<", String( cone_vpresentation_list ), ">" ) );

end );

InstallMethod( ViewObj,
              [ IsAffineConeSemigroup ],
  function( affine_cone_semigroup )

    Print( Concatenation( "<", String( affine_cone_semigroup ), ">" ) );

end );

InstallMethod( ViewObj,
              [ IsAffineSemigroup ],
  function( affine_semigroup )

    Print( Concatenation( "<", String( affine_semigroup ), ">" ) );

end );



#################################################
##
##  Section Attributes
##
#################################################

InstallMethod( TurnIntoConeHPresentationList,
               "for semigroup_generator_lists",
               [ IsSemigroupGeneratorList ],
  function( semigroup_generator_list )
    local cone, underlying_list, cone_hpresentation_list;

    # first check if the conversion can work in the first place
    if not IsSemigroupOfCone( semigroup_generator_list ) then

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

InstallMethod( TurnIntoConeVPresentationList,
               "for semigroup_generator_lists",
               [ IsSemigroupGeneratorList ],
  function( semigroup_generator_list )

    if not IsSemigroupOfCone( semigroup_generator_list ) then

      return fail;

    fi;

    return ConeVPresentationList( UnderlyingList( semigroup_generator_list ) );

end );

InstallMethod( TurnIntoAffineConeSemigroup,
               "for affine semigroups",
               [ IsAffineSemigroup ],
  function( affine_semigroup )

    if not IsAffineConeSemigroup( affine_semigroup ) then

      return fail;

    fi;

    return AffineConeSemigroup( TurnIntoConeHPresentationList( UnderlyingSemigroupGeneratorList( affine_semigroup ) ),
                                Offset( affine_semigroup ) );

end );



############################################
##
##  Section Property
##
############################################

InstallMethod( IsSemigroupOfCone,
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

InstallMethod( IsAffineSemigroupOfCone,
               "for semigroup_generator_lists",
               [ IsAffineSemigroup ],
  function( affine_semigroup )

    return IsSemigroupOfCone( UnderlyingSemigroupGeneratorList( affine_semigroup ) );

end );