#############################################################################
##
## GradedModulePresentationsbyFreyd
##
## Copyright 2019,  Martin Bies,       ULB Brussels
##
## Functors in the CAP category of graded module presentations for CAP by use of Freyd categories
##
#############################################################################



################################################
##
## Section Functor LessGenerators
##
################################################

# Here we make use of the function 'SimplerEquivalentMatrix' from MatricesForHomalg, Basic.gi
# This function accepts a matrix M and produces a simpler matrix M2 from it. Optionally it can compute matrices
# U, UI, V and VI such that the following holds true:
# M * V = UI * M2 and U * M = M2 * VI
# For left-modules (R -M-> G and R2 -M2-> G2) this corresponds to having the following commutative diagrams:

# R --- UI ---> R2               R <--- U ---- R2
# |             |                |             |
# M             M2               M             M2
# |             |                |             |
# v             v                v             v
# G --- V ----> G2               G <--- VI --- G2

# and for right-modules to the diagram

# R --- VI ---> R2               R <--- V ---- R2
# |             |                |             |
# M             M2               M             M2
# |             |                |             |
# v             v                v             v
# G --- U ----> G2               G <--- UI --- G2

# So if we want to describe the transformation from the origional module into a simpler module we wish to compute
# left-modules: V (and VI)
# right-modules: U ( and UI)

# This is achieved from the following code (initialise V, VI, U and UI as HomalgVoidMatrices first)
# left-modules: SimplerEquivalentMatrix( M, V, VI, "", "" );
# right-modules: SimplerEquivalentMatrix( M, U, UI, "", "", "" );
# Note the different number of empty strings in this function - this is crucial!

# That said, we have the following methods

# FIXME: WHY ARE U, UI, V, VI HOMOGENEOUS?

##
InstallMethod( LessGradedGeneratorsTransformationTripleLeft,
               [ IsHomalgMatrix ],
  function( matrix )
    local V, VI, smaller_matrix;

    # initialise the transformation matrices
    V := HomalgVoidMatrix( HomalgRing( matrix ) );
    VI := HomalgVoidMatrix( HomalgRing( matrix ) );

    # compute M' and thereby set values for T and T^{-1}
    smaller_matrix := SimplerEquivalentMatrix( matrix, V, VI, "", "" );

    # return the triple of desired information
    return [ smaller_matrix, V, VI ];

end );

##
InstallMethod( LessGradedGeneratorsTransformationTripleRight,
               [ IsHomalgMatrix ],
  function( matrix )
    local U, UI, smaller_matrix;

    # initialise the transformation matrices
    U := HomalgVoidMatrix( HomalgRing( matrix ) );
    UI := HomalgVoidMatrix( HomalgRing( matrix ) );

    # compute M' and thereby set values for T and T^{-1}
    smaller_matrix := SimplerEquivalentMatrix( matrix, U, UI, "", "", "" );

    # return the triple of desired information
    return [ smaller_matrix, U, UI ];

end );


##
InstallMethod( LessGradedGenerators,
               [ IsFpGradedLeftOrRightModulesObject ],
  function( module_presentation )
    local TI, range_prime, Mprime;

    # recall that we look at the following diagram
    # Source( object) --- MappingMatrix M ---> Range( object )
    #     |                                            |
    #     ?                                            T
    #     |                                            |
    #     v                                            v
    # Source( object' ) -- MappingMatrix M' ---> Range( object' )

    # now deduce the bottom line
    if IsFpGradedLeftModulesObject( module_presentation ) then

      TI := LessGradedGeneratorsTransformationTripleLeft(
                UnderlyingHomalgMatrix( RelationMorphism( module_presentation ) ) )[ 3 ];
      range_prime := Source( DeduceMapFromMatrixAndRangeForGradedRows(
                                 TI, Range( RelationMorphism( module_presentation ) ) ) );
      Mprime := ReducedSyzygiesOfRows( TI, UnderlyingHomalgMatrix( RelationMorphism( module_presentation ) ) );
      return FreydCategoryObject( DeduceMapFromMatrixAndRangeForGradedRows( Mprime, range_prime ) );

    else

      TI := LessGradedGeneratorsTransformationTripleRight(
                UnderlyingHomalgMatrix( RelationMorphism( module_presentation ) ) )[ 3 ];
      range_prime := Source( DeduceMapFromMatrixAndRangeForGradedCols( 
                                 TI, Range( RelationMorphism( module_presentation ) ) ) );
      Mprime := ReducedSyzygiesOfColumns( TI, UnderlyingHomalgMatrix( RelationMorphism( module_presentation ) ) );
      return FreydCategoryObject( DeduceMapFromMatrixAndRangeForGradedCols( Mprime, range_prime ) );

    fi;

end );


##
InstallMethod( LessGradedGenerators,
               [ IsFpGradedLeftOrRightModulesMorphism ],
  function( morphism )
    local source_transformation_triple, range_transformation_triple, TI, range_prime, Mprime, new_source, new_range, 
         morphism_matrix, new_morphism_matrix, new_morphism;

    # compute the transformation of source and range
    if IsFpGradedLeftModulesMorphism( morphism ) then
      source_transformation_triple := LessGradedGeneratorsTransformationTripleLeft(
                                        UnderlyingHomalgMatrix( RelationMorphism( Source( morphism ) ) ) );
      range_transformation_triple := LessGradedGeneratorsTransformationTripleLeft(
                                        UnderlyingHomalgMatrix( RelationMorphism( Range( morphism ) ) ) );
    else
      source_transformation_triple := LessGradedGeneratorsTransformationTripleRight(
                                        UnderlyingHomalgMatrix( RelationMorphism( Source( morphism ) ) ) );
      range_transformation_triple := LessGradedGeneratorsTransformationTripleRight(
                                        UnderlyingHomalgMatrix( RelationMorphism( Range( morphism ) ) ) );
    fi;

    # and extract the underlying homalg matrix of the morphism
    morphism_matrix := UnderlyingHomalgMatrix( RelationMorphism( morphism ) );

    # and compute the new mapping matrix
    if IsFpGradedLeftModulesMorphism( morphism ) then

      # compute the new source
      TI := source_transformation_triple[ 3 ];
      range_prime := Source( DeduceMapFromMatrixAndRangeForGradedRows( TI, Range( RelationMorphism( Source( morphism ) ) ) ) );
      Mprime := ReducedSyzygiesOfRows( TI, UnderlyingHomalgMatrix( RelationMorphism( Source( morphism ) ) ) );
      new_source := FreydCategoryObject( DeduceMapFromMatrixAndRangeForGradedRows( Mprime, range_prime ) );

      # and the new range
      TI := range_transformation_triple[ 3 ];
      range_prime := Source( DeduceMapFromMatrixAndRangeForGradedRows( TI, Range( RelationMorphism( Range( morphism ) ) ) ) );
      Mprime := ReducedSyzygiesOfRows( TI, UnderlyingHomalgMatrix( RelationMorphism( Range( morphism ) ) ) );
      new_range := FreydCategoryObject( DeduceMapFromMatrixAndRangeForGradedRows( Mprime, range_prime ) );

      # compute the new mapping matrix
      new_morphism_matrix := source_transformation_triple[ 3 ] * morphism_matrix * range_transformation_triple[ 2 ];

    else

      # compute the new source
      TI := source_transformation_triple[ 2 ];
      range_prime := Source( DeduceMapFromMatrixAndRangeForGradedCols( TI, Range( RelationMorphism( Source( morphism ) ) ) ) );
      Mprime := ReducedSyzygiesOfColumns( TI, UnderlyingHomalgMatrix( RelationMorphism( Source( morphism ) ) ) );
      new_range := FreydCategoryObject( DeduceMapFromMatrixAndRangeForGradedCols( Mprime, range_prime ) );

      # and the new range
      TI := range_transformation_triple[ 2 ];
      range_prime := Source( DeduceMapFromMatrixAndRangeForGradedCols( TI, Range( RelationMorphism( Range( morphism ) ) ) ) );
      Mprime := ReducedSyzygiesOfColumns( TI, UnderlyingHomalgMatrix( RelationMorphism( Range( morphism ) ) ) );
      new_range := FreydCategoryObject( DeduceMapFromMatrixAndRangeForGradedCols( Mprime, range_prime ) );

      # compute the new mapping matrix
      new_morphism_matrix := range_transformation_triple[ 3 ] * morphism_matrix * source_transformation_triple[ 2 ];

    fi;

    # wrap this information to form morphism datum of the corresponding morphism in the Freyd category
    new_morphism := FreydCategoryMorphism( Range( RelationMorphism( new_source ) ),
                                           new_morphism_matrix,
                                           Range( RelationMorphism( new_range ) ) );

    # and return the Freyd morphism
    return FreydCategoryMorphism( new_source, new_morphism, new_range );

end );


##
InstallGlobalFunction( FunctorLessGradedGenerators,
  function( graded_ring, left )
    local category, functor;

    # first compute the category under consideration
    if left = true then
      category := FpGradedLeftModules( graded_ring );
    else
      category := FpGradedRightModules( graded_ring );
    fi;

    # then initialise the functor
    functor := CapFunctor( Concatenation( "Less generators for ", Name( category ) ), category, category );

    # and add the functor operation on objects
    AddObjectFunction( functor,
      function( object )

        return LessGradedGenerators( object );

    end );

    # and on morphisms
    AddMorphismFunction( functor,
      function( new_source, morphism, new_range )

        return LessGradedGenerators( morphism );

    end );

    # then return the functor
    return functor;

end );

##
InstallMethod( FunctorLessGradedGeneratorsLeft,
               [ IsHomalgGradedRing ],
  function( graded_ring )

    return FunctorLessGradedGenerators( graded_ring, true );

end );

##
InstallMethod( FunctorLessGradedGeneratorsRight,
               [ IsHomalgGradedRing ],
  function( graded_ring )

    return FunctorLessGradedGenerators( graded_ring, false );

end );



#################################################
##
## Section Functor StandardModule for S-fpgrmod
##
#################################################

##
InstallMethod( GradedStandardModule,
               [ IsFpGradedLeftOrRightModulesObject ],
  function( module_presentation )
    local matrix, new_underlying_morphism;

    # compute a new presentation matrix
    if IsFpGradedLeftModulesObject( module_presentation ) then

      matrix := ReducedBasisOfRowModule( UnderlyingHomalgMatrix( RelationMorphism( module_presentation ) ) );
      new_underlying_morphism := DeduceMapFromMatrixAndRangeForGradedRows( matrix, Range( RelationMorphism( module_presentation ) ) );

    else

      matrix := ReducedBasisOfColumnModule( UnderlyingHomalgMatrix( RelationMorphism( module_presentation ) ) );
      new_underlying_morphism := DeduceMapFromMatrixAndRangeForGradedCols( matrix, Range( RelationMorphism( module_presentation ) ) );

    fi;

    # and return the new object
    return FreydCategoryObject( new_underlying_morphism );

end );

##
InstallMethod( GradedStandardModule,
               [ IsFpGradedLeftOrRightModulesMorphism ],
  function( morphism )
    local new_source, new_range, new_underlying_morphism;

    # compute the new underlying morphism
    new_source := GradedStandardModule( Source( morphism ) );
    new_range := GradedStandardModule( Range( morphism ) );
    new_underlying_morphism := FreydCategoryMorphism(
                                                      Range( RelationMorphism( new_source ) ),
                                                      UnderlyingHomalgMatrix( RelationMorphism( morphism ) ),
                                                      Range( RelationMorphism( new_range ) )
                                                     );

    # and return the corresponding morphism
    return FreydCategoryMorphism( new_source, new_underlying_morphism, new_range );

end );

##
InstallGlobalFunction( FunctorGradedStandardModule,
  function( graded_ring, left )
    local category, functor;

    # first compute the category under consideration
    if left = true then
      category := FpGradedLeftModules( graded_ring );
    else
      category := FpGradedRightModules( graded_ring );
    fi;

    # then initialise the functor
    functor := CapFunctor( Concatenation( "Graded standard module for ", Name( category ) ), category, category );

    # now define the functor operation on the objects
    AddObjectFunction( functor,
      function( object )

        return GradedStandardModule( object );

    end );

    # now define the functor operation on the morphisms
    AddMorphismFunction( functor,
      function( new_source, morphism, new_range )
        local new_underlying_morphism;

        # compute the new underlying morphism
        new_underlying_morphism := FreydCategoryMorphism(
                                                      Range( RelationMorphism( new_source ) ),
                                                      UnderlyingHomalgMatrix( RelationMorphism( morphism ) ),
                                                      Range( RelationMorphism( new_range ) )
                                                     );

        # and return the corresponding morphism
        return FreydCategoryMorphism( new_source, new_underlying_morphism, new_range );

    end );

    # finally return the functor
    return functor;

end );

##
InstallMethod( FunctorGradedStandardModuleLeft,
               [ IsHomalgGradedRing ],
  function( graded_ring )

    return FunctorGradedStandardModule( graded_ring, true );

end );

##
InstallMethod( FunctorGradedStandardModuleRight,
               [ IsHomalgGradedRing ],
  function( graded_ring )

    return FunctorGradedStandardModule( graded_ring, false );

end );



#############################################################
##
## Section Functor ByASmallerPresentation for FpGradedModules
##
#############################################################

##
InstallMethod( ByASmallerPresentation,
               [ IsFpGradedLeftOrRightModulesObject ],
  function( module_presentation )

    return GradedStandardModule( LessGradedGenerators( module_presentation ) );

end );

##
InstallMethod( ByASmallerPresentation,
               [ IsFpGradedLeftOrRightModulesMorphism ],
  function( morphism )

    return GradedStandardModule( LessGradedGenerators( morphism ) );

end );

##
InstallGlobalFunction( FunctorByASmallerPresentation,
  function( graded_ring, left )
    local category, functor;

    # first compute the category under consideration
    if left = true then
      category := FpGradedLeftModules( graded_ring );
    else
      category := FpGradedRightModules( graded_ring );
    fi;

    # then initialise the functor
    functor := CapFunctor( Concatenation( "ByASmallerPresentation for ", Name( category ) ), category, category );

    # and add the functor operation on objects
    AddObjectFunction( functor,
      function( object )

        return ByASmallerPresentation( object );

    end );

    AddMorphismFunction( functor,
      function( new_source, morphism, new_range )

        return ByASmallerPresentation( morphism );

    end );

    # then return the functor
    return functor;

end );

##
InstallMethod( FunctorByASmallerPresentationLeft,
               [ IsHomalgGradedRing ],
  function( graded_ring )

    return FunctorByASmallerPresentation( graded_ring, true );

end );


##
InstallMethod( FunctorByASmallerPresentationRight,
               [ IsHomalgGradedRing ],
  function( graded_ring )

    return FunctorByASmallerPresentation( graded_ring, false );

end );
