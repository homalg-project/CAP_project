# SPDX-License-Identifier: GPL-2.0-or-later
# CAP: Categories, Algorithms, Programming
#
# Implementations
#
#! @Chapter Universal Objects

####################################
##
## Coproduct and Pushout
##
####################################

####################################
##
## Coproduct
##
####################################

####################################
## Convenience methods
####################################

##
InstallMethod( Coproduct,
               [ IsCapCategoryObject, IsCapCategoryObject ],
               
  function( object_1, object_2 )
    
    return Coproduct( CapCategory( object_1 ), [ object_1, object_2 ] );
    
end );

##
InstallMethod( Coproduct,
               [ IsCapCategoryObject, IsCapCategoryObject, IsCapCategoryObject ],
               
  function( object_1, object_2, object_3 )
    
    return Coproduct( CapCategory( object_1 ), [ object_1, object_2, object_3 ] );
    
end );

####################################
##
## Direct Product and FiberProduct
##
####################################

####################################
## Convenience methods
####################################


####################################
##
## Direct Product
##
####################################

####################################
## Convenience methods
####################################

##
# compatibility with GAP's DirectProduct function
InstallMethod( DirectProductOp,
               [ IsList, IsCapCategoryObject ],
               
  function( diagram, object )
    
    return DirectProductOp( CapCategory( object ), diagram );
    
end );

##
# compatibility with GAP's DirectProduct function
InstallMethod( DirectProductOp,
               [ IsList, IsCapCategory ],
               
  function( category_and_diagram, category )
    local diagram;
    
    diagram := category_and_diagram[2];
    
    return DirectProductOp( category, diagram );
    
end );

####################################
##
## Direct sum
##
####################################

####################################
## Technical methods
####################################

####################################
## Convenience methods
####################################

##
# compatibility with GAP's DirectSum function
InstallMethod( DirectSumOp,
               [ IsList, IsCapCategoryObject ],
               
  function( diagram, object )
    
    return DirectSumOp( CapCategory( object ), diagram );
    
end );

##
# compatibility with GAP's DirectSum function
InstallMethod( DirectSumOp,
               [ IsList, IsCapCategory ],
               
  function( category_and_diagram, category )
    local diagram;
    
    diagram := category_and_diagram[2];
    
    if not ( IsBound( category!.supports_empty_limits ) and category!.supports_empty_limits = true ) and diagram = [ ] then
        return ZeroObject( category );
    fi;
    
    return DirectSumOp( category, diagram );
    
end );

# usually the type signatures should be part of the gd file, but `CapJitAddTypeSignature` is not available there
CapJitAddTypeSignature( "DirectSumFunctorial", [ IsCapCategory, IsList ], function ( input_types )
    
    return CapJitDataTypeOfMorphismOfCategory( input_types[1].category );
    
end );

####################################
## Add methods
####################################


####################################
## Categorical methods
####################################

# convenience
##
InstallMethod( MorphismBetweenDirectSums,
               [ IsList ],
               
  function( morphism_matrix )
    local nr_rows, nr_cols;
    
    nr_rows := Length( morphism_matrix );
    
    if nr_rows = 0 then
        
        Error( "The given matrix must not be empty" );
        
    fi;
    
    nr_cols := Length( morphism_matrix[1] );
    
    if nr_cols = 0 then
        
        Error( "The given matrix must not be empty" );
        
    fi;
    
    return MorphismBetweenDirectSums( CapCategory( morphism_matrix[1][1] ),
             List( morphism_matrix, row -> Source( row[1] ) ),
             morphism_matrix,
             List( morphism_matrix[1], col -> Range( col ) )
           );
end );

##
InstallOtherMethod( MorphismBetweenDirectSums,
                    [ IsCapCategory, IsList ],
               
  function( cat, morphism_matrix )
    local nr_rows, nr_cols;
    
    nr_rows := Length( morphism_matrix );
    
    if nr_rows = 0 then
        
        Error( "The given matrix must not be empty" );
        
    fi;
    
    nr_cols := Length( morphism_matrix[1] );
    
    if nr_cols = 0 then
        
        Error( "The given matrix must not be empty" );
        
    fi;
    
    return MorphismBetweenDirectSums( cat,
             List( morphism_matrix, row -> Source( row[1] ) ),
             morphism_matrix,
             List( morphism_matrix[1], col -> Range( col ) )
           );
end );

####################################
##
## Equalizer
##
####################################

####################################
## Convenience methods
####################################

##
InstallGlobalFunction( Equalizer,
  
  function( arg )
    
    if IsCapCategory( arg[1] ) then
        
        return CallFuncList( EqualizerOp, arg );
        
    fi;
    
    if Length( arg ) = 1 and
       IsList( arg[1] ) and
       ForAll( arg[1], IsCapCategoryMorphism ) then
       
       return EqualizerOp( CapCategory( arg[1][1] ), arg[1] );
       
    fi;
    
    if Length( arg ) = 2 and
       IsCapCategoryObject( arg[1] ) and
       IsList( arg[2] ) and
       ForAll( arg[2], IsCapCategoryMorphism ) then
       
       return EqualizerOp( CapCategory( arg[1] ), arg[1], arg[2] );
       
    fi;
    
    return EqualizerOp( CapCategory( arg[1] ), arg );
    
end );

##
InstallOtherMethod( EqualizerOp,
        [ IsList ],
        
  function ( list_of_morphisms )
    
    if IsEmpty( list_of_morphisms ) then
        
        Error( "the list of morphisms must not be empty" );
        
    fi;
    
    return EqualizerOp( CapCategory( list_of_morphisms[1] ), list_of_morphisms );
    
end );

InstallOtherMethod( EqualizerOp,
        [ IsCapCategory, IsList ],
        
  function ( cat, list_of_morphisms )
    
    if IsEmpty( list_of_morphisms ) then
        
        Error( "the list of morphisms must not be empty" );
        
    fi;
    
    return EqualizerOp( cat, Source( list_of_morphisms[1] ), list_of_morphisms );
    
end );

##
InstallOtherMethod( EmbeddingOfEqualizer,
        [ IsList ],
        
  function ( list_of_morphisms )
    
    if IsEmpty( list_of_morphisms ) then
        
        Error( "the list of morphisms must not be empty" );
        
    fi;
    
    return EmbeddingOfEqualizer( CapCategory( list_of_morphisms[1] ), list_of_morphisms );
    
end );

InstallOtherMethod( EmbeddingOfEqualizer,
        [ IsCapCategory, IsList ],
        
  function ( cat, list_of_morphisms )
    
    if IsEmpty( list_of_morphisms ) then
        
        Error( "the list of morphisms must not be empty" );
        
    fi;
    
    return EmbeddingOfEqualizer( cat, Source( list_of_morphisms[1] ), list_of_morphisms );
    
end );

##
InstallOtherMethod( EmbeddingOfEqualizerWithGivenEqualizer,
        [ IsList, IsCapCategoryObject ],
        
  function ( list_of_morphisms, E )
    
    if IsEmpty( list_of_morphisms ) then
        
        Error( "the list of morphisms must not be empty" );
        
    fi;
    
    return EmbeddingOfEqualizerWithGivenEqualizer( CapCategory( list_of_morphisms[1] ), list_of_morphisms, E );
    
end );

InstallOtherMethod( EmbeddingOfEqualizerWithGivenEqualizer,
        [ IsCapCategory, IsList, IsCapCategoryObject ],
        
  function ( cat, list_of_morphisms, E )
    
    if IsEmpty( list_of_morphisms ) then
        
        Error( "the list of morphisms must not be empty" );
        
    fi;
    
    return EmbeddingOfEqualizerWithGivenEqualizer( cat, Source( list_of_morphisms[1] ), list_of_morphisms, E );
    
end );

##
InstallOtherMethod( MorphismFromEqualizerToSink,
        [ IsList ],
        
  function ( list_of_morphisms )
    
    if IsEmpty( list_of_morphisms ) then
        
        Error( "the list of morphisms must not be empty" );
        
    fi;
    
    return MorphismFromEqualizerToSink( CapCategory( list_of_morphisms[1] ), list_of_morphisms );
    
end );

InstallOtherMethod( MorphismFromEqualizerToSink,
        [ IsCapCategory, IsList ],
        
  function ( cat, list_of_morphisms )
    
    if IsEmpty( list_of_morphisms ) then
        
        Error( "the list of morphisms must not be empty" );
        
    fi;
    
    return MorphismFromEqualizerToSink( cat, Source( list_of_morphisms[1] ), list_of_morphisms );
    
end );

##
InstallOtherMethod( MorphismFromEqualizerToSinkWithGivenEqualizer,
        [ IsList, IsCapCategoryObject ],
        
  function ( list_of_morphisms, E )
    
    if IsEmpty( list_of_morphisms ) then
        
        Error( "the list of morphisms must not be empty" );
        
    fi;
    
    return MorphismFromEqualizerToSinkWithGivenEqualizer( CapCategory( list_of_morphisms[1] ), list_of_morphisms, E );
    
end );

InstallOtherMethod( MorphismFromEqualizerToSinkWithGivenEqualizer,
        [ IsCapCategory, IsList, IsCapCategoryObject ],
        
  function ( cat, list_of_morphisms, E )
    
    if IsEmpty( list_of_morphisms ) then
        
        Error( "the list of morphisms must not be empty" );
        
    fi;
    
    return MorphismFromEqualizerToSinkWithGivenEqualizer( cat, Source( list_of_morphisms[1] ), list_of_morphisms, E );
    
end );

##
InstallOtherMethod( UniversalMorphismIntoEqualizer,
        [ IsList, IsCapCategoryMorphism ],
        
  function ( list_of_morphisms, tau )
    
    if IsEmpty( list_of_morphisms ) then
        
        Error( "the list of morphisms must not be empty" );
        
    fi;
    
    return UniversalMorphismIntoEqualizer( CapCategory( list_of_morphisms[1] ), list_of_morphisms, tau );
    
end );

InstallOtherMethod( UniversalMorphismIntoEqualizer,
        [ IsCapCategory, IsList, IsCapCategoryMorphism ],
        
  function ( cat, list_of_morphisms, tau )
    
    if IsEmpty( list_of_morphisms ) then
        
        Error( "the list of morphisms must not be empty" );
        
    fi;
    
    return UniversalMorphismIntoEqualizer( cat, Source( list_of_morphisms[1] ), list_of_morphisms, tau );
    
end );

##
InstallOtherMethod( UniversalMorphismIntoEqualizerWithGivenEqualizer,
        [ IsList, IsCapCategoryMorphism, IsCapCategoryObject ],
        
  function ( list_of_morphisms, tau, E )
    
    if IsEmpty( list_of_morphisms ) then
        
        Error( "the list of morphisms must not be empty" );
        
    fi;
    
    return UniversalMorphismIntoEqualizerWithGivenEqualizer( CapCategory( list_of_morphisms[1] ), list_of_morphisms, tau, E );
    
end );

InstallOtherMethod( UniversalMorphismIntoEqualizerWithGivenEqualizer,
        [ IsCapCategory, IsList, IsCapCategoryMorphism, IsCapCategoryObject ],
        
  function ( cat, list_of_morphisms, tau, E )
    
    if IsEmpty( list_of_morphisms ) then
        
        Error( "the list of morphisms must not be empty" );
        
    fi;
    
    return UniversalMorphismIntoEqualizerWithGivenEqualizer( cat, Source( list_of_morphisms[1] ), list_of_morphisms, tau, E );
    
end );

####################################
##
## FiberProduct
##
####################################

####################################
## Convenience methods
####################################

##
InstallGlobalFunction( FiberProduct,
  
  function( arg )
    
    if IsCapCategory( arg[1] ) then
        
        return CallFuncList( FiberProductOp, arg );
        
    fi;
    
    if Length( arg ) = 1 and
       IsList( arg[1] ) and
       ForAll( arg[1], IsCapCategoryMorphism ) then
       
       return FiberProductOp( CapCategory( arg[1][1] ), arg[1] );
       
     fi;
    
    return FiberProductOp( CapCategory( arg[ 1 ] ), arg );
    
end );

##
InstallMethod( FiberProductEmbeddingInDirectProduct,
        [ IsList ],
        
  function( diagram )
    
    return FiberProductEmbeddingInDirectProduct( CapCategory( diagram[1] ), diagram );
    
end );

##
InstallOtherMethod( FiberProductEmbeddingInDirectProduct,
        [ IsCapCategory, IsList ],
        
  function( cat, diagram )
    local sources_of_diagram, test_source;
    
    sources_of_diagram := List( diagram, Source );
    
    test_source := List( [ 1 .. Length( diagram ) ], i -> ProjectionInFactorOfFiberProduct( cat, diagram, i ) );
    
    return UniversalMorphismIntoDirectProduct( cat, sources_of_diagram, FiberProduct( cat, diagram ), test_source );
    
end );

##
InstallMethod( FiberProductEmbeddingInDirectSum,
        [ IsList ],
        
  function( diagram )
    
    return FiberProductEmbeddingInDirectSum( CapCategory( diagram[1] ), diagram );
    
end );

##
InstallOtherMethod( FiberProductEmbeddingInDirectSum,
        [ IsCapCategory, IsList ],
        
  function( cat, diagram )
    local sources_of_diagram, test_source;
    
    sources_of_diagram := List( diagram, Source );
    
    test_source := List( [ 1 .. Length( diagram ) ], i -> ProjectionInFactorOfFiberProduct( cat, diagram, i ) );
    
    return UniversalMorphismIntoDirectSum( cat, sources_of_diagram, FiberProduct( cat, diagram ), test_source );
    
end );

CAP_INTERNAL_ADD_REPLACEMENTS_FOR_METHOD_RECORD(
  rec(
    FiberProductEmbeddingInDirectSum :=
      [ [ "ProjectionInFactorOfFiberProduct", 2 ],
        [ "UniversalMorphismIntoDirectSum", 1 ],
        [ "FiberProduct", 1 ] ],
  )
);

####################################
##
## Coequalizer
##
####################################

####################################
## Convenience methods
####################################

##
InstallGlobalFunction( Coequalizer,
  
  function( arg )
    
    if IsCapCategory( arg[1] ) then
        
        return CallFuncList( CoequalizerOp, arg );
        
    fi;
    
    if Length( arg ) = 1 and
       IsList( arg[1] ) and
       ForAll( arg[1], IsCapCategoryMorphism ) then
       
       return CoequalizerOp( CapCategory( arg[1][1] ), arg[1] );
       
     fi;
    
    if Length( arg ) = 2 and
       IsCapCategoryObject( arg[1] ) and
       IsList( arg[2] ) and
       ForAll( arg[2], IsCapCategoryMorphism ) then
       
       return CoequalizerOp( CapCategory( arg[1] ), arg[1], arg[2] );
       
     fi;
    
    return CoequalizerOp( CapCategory( arg[ 1 ] ), arg );
    
end );

##
InstallOtherMethod( CoequalizerOp,
        [ IsList ],
        
  function ( list_of_morphisms )
    
    if IsEmpty( list_of_morphisms ) then
        
        Error( "the list of morphisms must not be empty" );
        
    fi;
    
    return CoequalizerOp( CapCategory( list_of_morphisms[1] ), list_of_morphisms );
    
end );

InstallOtherMethod( CoequalizerOp,
        [ IsCapCategory, IsList ],
        
  function ( cat, list_of_morphisms )
    
    if IsEmpty( list_of_morphisms ) then
        
        Error( "the list of morphisms must not be empty" );
        
    fi;
    
    return CoequalizerOp( cat, Range( list_of_morphisms[1] ), list_of_morphisms );
    
end );

##
InstallOtherMethod( ProjectionOntoCoequalizer,
        [ IsList ],
        
  function ( list_of_morphisms )
    
    if IsEmpty( list_of_morphisms ) then
        
        Error( "the list of morphisms must not be empty" );
        
    fi;
    
    return ProjectionOntoCoequalizer( CapCategory( list_of_morphisms[1] ), list_of_morphisms );
    
end );

InstallOtherMethod( ProjectionOntoCoequalizer,
        [ IsCapCategory, IsList ],
        
  function ( cat, list_of_morphisms )
    
    if IsEmpty( list_of_morphisms ) then
        
        Error( "the list of morphisms must not be empty" );
        
    fi;
    
    return ProjectionOntoCoequalizer( cat, Range( list_of_morphisms[1] ), list_of_morphisms );
    
end );

##
InstallOtherMethod( ProjectionOntoCoequalizerWithGivenCoequalizer,
        [ IsList, IsCapCategoryObject ],
        
  function ( list_of_morphisms, E )
    
    if IsEmpty( list_of_morphisms ) then
        
        Error( "the list of morphisms must not be empty" );
        
    fi;
    
    return ProjectionOntoCoequalizerWithGivenCoequalizer( CapCategory( list_of_morphisms[1] ), list_of_morphisms, E );
    
end );

InstallOtherMethod( ProjectionOntoCoequalizerWithGivenCoequalizer,
        [ IsCapCategory, IsList, IsCapCategoryObject ],
        
  function ( cat, list_of_morphisms, E )
    
    if IsEmpty( list_of_morphisms ) then
        
        Error( "the list of morphisms must not be empty" );
        
    fi;
    
    return ProjectionOntoCoequalizerWithGivenCoequalizer( cat, Range( list_of_morphisms[1] ), list_of_morphisms, E );
    
end );

##
InstallOtherMethod( MorphismFromSourceToCoequalizer,
        [ IsList ],
        
  function ( list_of_morphisms )
    
    if IsEmpty( list_of_morphisms ) then
        
        Error( "the list of morphisms must not be empty" );
        
    fi;
    
    return MorphismFromSourceToCoequalizer( CapCategory( list_of_morphisms[1] ), list_of_morphisms );
    
end );

InstallOtherMethod( MorphismFromSourceToCoequalizer,
        [ IsCapCategory, IsList ],
        
  function ( cat, list_of_morphisms )
    
    if IsEmpty( list_of_morphisms ) then
        
        Error( "the list of morphisms must not be empty" );
        
    fi;
    
    return MorphismFromSourceToCoequalizer( cat, Range( list_of_morphisms[1] ), list_of_morphisms );
    
end );

##
InstallOtherMethod( MorphismFromSourceToCoequalizerWithGivenCoequalizer,
        [ IsList, IsCapCategoryObject ],
        
  function ( list_of_morphisms, E )
    
    if IsEmpty( list_of_morphisms ) then
        
        Error( "the list of morphisms must not be empty" );
        
    fi;
    
    return MorphismFromSourceToCoequalizerWithGivenCoequalizer( CapCategory( list_of_morphisms[1] ), list_of_morphisms, E );
    
end );

InstallOtherMethod( MorphismFromSourceToCoequalizerWithGivenCoequalizer,
        [ IsCapCategory, IsList, IsCapCategoryObject ],
        
  function ( cat, list_of_morphisms, E )
    
    if IsEmpty( list_of_morphisms ) then
        
        Error( "the list of morphisms must not be empty" );
        
    fi;
    
    return MorphismFromSourceToCoequalizerWithGivenCoequalizer( cat, Range( list_of_morphisms[1] ), list_of_morphisms, E );
    
end );

##
InstallOtherMethod( UniversalMorphismFromCoequalizer,
        [ IsList, IsCapCategoryMorphism ],
        
  function ( list_of_morphisms, tau )
    
    if IsEmpty( list_of_morphisms ) then
        
        Error( "the list of morphisms must not be empty" );
        
    fi;
    
    return UniversalMorphismFromCoequalizer( CapCategory( list_of_morphisms[1] ), list_of_morphisms, tau );
    
end );

InstallOtherMethod( UniversalMorphismFromCoequalizer,
        [ IsCapCategory, IsList, IsCapCategoryMorphism ],
        
  function ( cat, list_of_morphisms, tau )
    
    if IsEmpty( list_of_morphisms ) then
        
        Error( "the list of morphisms must not be empty" );
        
    fi;
    
    return UniversalMorphismFromCoequalizer( cat, Range( list_of_morphisms[1] ), list_of_morphisms, tau );
    
end );

##
InstallOtherMethod( UniversalMorphismFromCoequalizerWithGivenCoequalizer,
        [ IsList, IsCapCategoryMorphism, IsCapCategoryObject ],
        
  function ( list_of_morphisms, tau, E )
    
    if IsEmpty( list_of_morphisms ) then
        
        Error( "the list of morphisms must not be empty" );
        
    fi;
    
    return UniversalMorphismFromCoequalizerWithGivenCoequalizer( CapCategory( list_of_morphisms[1] ), list_of_morphisms, tau, E );
    
end );

InstallOtherMethod( UniversalMorphismFromCoequalizerWithGivenCoequalizer,
        [ IsCapCategory, IsList, IsCapCategoryMorphism, IsCapCategoryObject ],
        
  function ( cat, list_of_morphisms, tau, E )
    
    if IsEmpty( list_of_morphisms ) then
        
        Error( "the list of morphisms must not be empty" );
        
    fi;
    
    return UniversalMorphismFromCoequalizerWithGivenCoequalizer( cat, Range( list_of_morphisms[1] ), list_of_morphisms, tau, E );
    
end );

####################################
##
## Pushout
##
####################################

####################################
## Convenience methods
####################################

##
InstallMethod( Pushout,
               [ IsCapCategoryMorphism, IsCapCategoryMorphism ],
               
  function( mor1, mor2 )
    
    return Pushout( CapCategory( mor1 ), [ mor1, mor2 ] );
    
end );

##
InstallMethod( PushoutProjectionFromCoproduct,
        [ IsList ],
                    
  function( diagram )
    
    return PushoutProjectionFromCoproduct( CapCategory( diagram[1] ), diagram );
    
end );

##
InstallOtherMethod( PushoutProjectionFromCoproduct,
        [ IsCapCategory, IsList ],
                    
  function( cat, diagram )
    local ranges_of_diagram, test_sink;
    
    ranges_of_diagram := List( diagram, Range );
    
    test_sink := List( [ 1 .. Length( diagram ) ], i -> InjectionOfCofactorOfPushout( cat, diagram, i ) );
    
    return UniversalMorphismFromCoproduct( cat, ranges_of_diagram, Pushout( cat, diagram ), test_sink );
    
end );

##
InstallMethod( PushoutProjectionFromDirectSum,
        [ IsList ],
                    
  function( diagram )
    
    return PushoutProjectionFromDirectSum( CapCategory( diagram[1] ), diagram );
    
end );

##
InstallOtherMethod( PushoutProjectionFromDirectSum,
        [ IsCapCategory, IsList ],
                    
  function( cat, diagram )
    local ranges_of_diagram, test_sink;
    
    ranges_of_diagram := List( diagram, Range );
    
    test_sink := List( [ 1 .. Length( diagram ) ], i -> InjectionOfCofactorOfPushout( cat, diagram, i ) );
    
    return UniversalMorphismFromDirectSum( cat, ranges_of_diagram, Pushout( cat, diagram ), test_sink );
    
end );

CAP_INTERNAL_ADD_REPLACEMENTS_FOR_METHOD_RECORD(
  rec(
    PushoutProjectionFromDirectSum :=
      [ [ "InjectionOfCofactorOfPushout", 2 ],
        [ "UniversalMorphismFromDirectSum", 1 ],
        [ "Pushout", 1 ] ],
  )
);

####################################
##
## Homology object
##
####################################

####################################
## Convenience methods
####################################

##
InstallMethod( HomologyObjectFunctorial,
              [ IsCapCategoryMorphism, IsCapCategoryMorphism, IsCapCategoryMorphism, IsCapCategoryMorphism, IsCapCategoryMorphism ],
              
  function( alpha, beta, epsilon, gamma, delta )
    
    return HomologyObjectFunctorialWithGivenHomologyObjects(
      HomologyObject( alpha, beta ),
      [ alpha, beta, epsilon, gamma, delta ],
      HomologyObject( gamma, delta )
    );
    
end );

####################################
##
## Scheme for Universal Object
##
####################################

####################################
## Add Operations
####################################

####################################
## Attributes
####################################

####################################
## Implied Operations
####################################

