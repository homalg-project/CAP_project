#############################################################################
##
##                                       ModulePresentationsForCAP package
##
##  Copyright 2016, Sebastian Gutsche, Uni Siegen
##                  Sebastian Posur,   Uni Siegen
##
#############################################################################

DeclareRepresentation( "IsGradedLeftPresentationMorphismRep",
                       IsGradedLeftPresentationMorphism and IsAttributeStoringRep,
                       [ ] );

BindGlobal( "TheFamilyOfGradedLeftPresentationMorphisms",
            NewFamily( "TheFamilyOfGradedLeftPresentationMorphisms" ) );

BindGlobal( "TheTypeOfGradedLeftPresentationMorphisms",
            NewType( TheFamilyOfGradedLeftPresentationMorphisms,
                     IsGradedLeftPresentationMorphismRep ) );


DeclareRepresentation( "IsGradedRightPresentationMorphismRep",
                       IsGradedRightPresentationMorphism and IsAttributeStoringRep,
                       [ ] );

BindGlobal( "TheFamilyOfGradedRightPresentationMorphisms",
            NewFamily( "TheFamilyOfGradedRightPresentationMorphisms" ) );

BindGlobal( "TheTypeOfGradedRightPresentationMorphisms",
            NewType( TheFamilyOfGradedRightPresentationMorphisms,
                     IsGradedRightPresentationMorphismRep ) );

#############################
##
## Constructors
##
#############################

##
InstallMethod( GradedPresentationMorphism,
               [ IsGradedLeftOrRightPresentation, IsLeftOrRightPresentationMorphism, IsGradedLeftOrRightPresentation ],
               
  function( source, morphism, range )
    local graded_morphism, left, type;
    
    if not IsEqualForObjects( Source( morphism ), UnderlyingPresentationObject( source ) ) or
       not IsEqualForObjects( Range( morphism ) , UnderlyingPresentationObject( range  ) ) then
       Error( "morphism not compatible with source or range" );
    fi;
    
    left := IsGradedLeftPresentation( source );
    
    if not IsCapCategory( source ) = IsCapCategory( range ) then
      
      Error( "source and range must lie in the same category" );
      
    fi;
    
    if not IsIdenticalObj( UnderlyingHomalgRing( source ), UnderlyingHomalgRing( morphism ) ) then
        
        Error( "matrix can not present a morphism between these objects" );
        
    fi;
    
    if left then
        type := TheTypeOfGradedLeftPresentationMorphisms;
    else
        type := TheTypeOfGradedRightPresentationMorphisms;
    fi;
    
    graded_morphism := rec();
    
    ObjectifyWithAttributes( graded_morphism, type,
                             Source, source,
                             Range, range,
                             UnderlyingPresentationMorphism, morphism,
                             UnderlyingHomalgRing, UnderlyingHomalgRing( morphism ),
                             UnderlyingMatrix, UnderlyingMatrix( morphism ) );
    
    Add( CapCategory( source ), graded_morphism );
    
    return graded_morphism;
    
end );

##
InstallMethod( GradedPresentationMorphism,
               [ IsGradedLeftOrRightPresentation, IsHomalgMatrix, IsGradedLeftOrRightPresentation ],
               
  function( source, matrix, range )
    local category, left, morphism, type, underlying_morphism;
    
    category := CapCategory( source );
    
    left := IsGradedLeftPresentation( source );
    
    if not IsCapCategory( source ) = IsCapCategory( range ) then
      
      Error( "source and range must lie in the same category" );
      
    fi;
    
    if not IsIdenticalObj( UnderlyingHomalgRing( source ), HomalgRing( matrix ) ) then
        
        Error( "matrix can not present a morphism between these objects" );
        
    fi;
    
    underlying_morphism := PresentationMorphism( UnderlyingPresentationObject( source ),
                                                 matrix,
                                                 UnderlyingPresentationObject( range ) );
    
    morphism := rec( );
    
    if left then
        type := TheTypeOfGradedLeftPresentationMorphisms;
    else
        type := TheTypeOfGradedRightPresentationMorphisms;
    fi;
    
    ObjectifyWithAttributes( morphism, type,
                             Source, source,
                             Range, range,
                             UnderlyingPresentationMorphism, underlying_morphism,
                             UnderlyingHomalgRing, HomalgRing( matrix ),
                             UnderlyingMatrix, matrix );
    
    Add( category, morphism );
    
    return morphism;
    
end );

##
InstallMethod( AsGradedPresentationMorphism,
               [ IsLeftPresentationMorphism ],
               
  function( morphism )
    local category, new_morphism;
    
    category := GradedLeftPresentations( CapCategory( morphism ) );
    
    new_morphism := rec( );
    
    ObjectifyWithAttributes( new_morphism, TheTypeOfGradedLeftPresentationMorphisms,
                             Source, AsGradedLeftPresentation( Source( morphism ) ),
                             Range, AsGradedLeftPresentation( Range( morphism ) ),
                             UnderlyingPresentationMorphism, morphism,
                             UnderlyingHomalgRing, UnderlyingHomalgRing( morphism ),
                             UnderlyingMatrix, UnderlyingMatrix( morphism ) );
    
    Add( category, new_morphism );
    
    return new_morphism;
    
end );

##
InstallMethod( AsGradedPresentationMorphism,
               [ IsRightPresentationMorphism ],
               
  function( morphism )
    local category, new_morphism;
    
    category := GradedRightPresentations( CapCategory( morphism ) );
    
    new_morphism := rec( );
    
    ObjectifyWithAttributes( new_morphism, TheTypeOfGradedRightPresentationMorphisms,
                             Source, AsGradedLeftPresentation( Source( morphism ) ),
                             Range, AsGradedLeftPresentation( Range( morphism ) ),
                             UnderlyingPresentationMorphism, morphism,
                             UnderlyingHomalgRing, UnderlyingHomalgRing( morphism ),
                             UnderlyingMatrix, UnderlyingMatrix( morphism ) );
    
    Add( category, new_morphism );
    
    return new_morphism;
    
end );

##############################################
##
## Arithmetics
##
##############################################

##
InstallMethod( \*,
               [ IsRingElement, IsGradedLeftPresentationMorphism ],
               
  function( ring_element, left_presentation )
    
    return GradedPresentationMorphism( Source( left_presentation ),
                                       ring_element * UnderlyingMatrix( left_presentation ),
                                       Range( left_presentation ) );
    
end );

##
InstallMethod( \*,
               [ IsGradedRightPresentationMorphism, IsRingElement ],
               
  function( right_presentation, ring_element )
    
    return GradedPresentationMorphism( Source( right_presentation ),
                                       UnderlyingMatrix( right_presentation ) * ring_element,
                                       Range( right_presentation ) );
    
end );


##############################################
##
## Non categorical methods TODO
##
##############################################

##
InstallMethod( StandardGeneratorMorphism,
               [ IsLeftPresentation, IsPosInt ],
               
  function( module_presentation, i_th_generator )
    local tensor_unit, homalg_ring, number_of_generators, matrix;
    
    number_of_generators := NrColumns( UnderlyingMatrix( module_presentation ) );
    
    if i_th_generator > number_of_generators then
      
      Error( Concatenation( "number of standard generators is ", 
                            String( number_of_generators ), ", which is smaller than ", String( i_th_generator ) ) );
      
    fi;
    
    tensor_unit := TensorUnit( CapCategory( module_presentation ) );
    
    homalg_ring := UnderlyingHomalgRing( tensor_unit );
    
    matrix := List( [ 1 .. number_of_generators ], i -> 0 );
    
    matrix[ i_th_generator ] := 1;
    
    matrix := HomalgMatrix( matrix, 1, number_of_generators, homalg_ring );
    
    return PresentationMorphism( tensor_unit, matrix, module_presentation );
    
end );

##
InstallMethod( StandardGeneratorMorphism,
               [ IsRightPresentation, IsPosInt ],
               
  function( module_presentation, i_th_generator )
    local tensor_unit, homalg_ring, number_of_generators, matrix;
    
    number_of_generators := NrRows( UnderlyingMatrix( module_presentation ) );
    
    if i_th_generator > number_of_generators then
      
      Error( Concatenation( "number of standard generators is ", 
                            String( number_of_generators ), ", which is smaller than ", String( i_th_generator ) ) );
      
    fi;
    
    tensor_unit := TensorUnit( CapCategory( module_presentation ) );
    
    homalg_ring := UnderlyingHomalgRing( tensor_unit );
    
    matrix := List( [ 1 .. number_of_generators ], i -> 0 );
    
    matrix[ i_th_generator ] := 1;
    
    matrix := HomalgMatrix( matrix, number_of_generators, 1, homalg_ring );
    
    return PresentationMorphism( tensor_unit, matrix, module_presentation );
    
end );

##
InstallMethod( CoverByProjective,
               [ IsGradedLeftPresentation ],
               
  function( left_presentation )
    local underlying_ring, number_of_generators, free_presentation, degrees_of_generators;
    
    underlying_ring := UnderlyingHomalgRing( left_presentation );
    
    number_of_generators := NrColumns( UnderlyingMatrix( left_presentation ) );
    
    degrees_of_generators := GeneratorDegrees( left_presentation );
    
    free_presentation := GradedFreeLeftPresentation( number_of_generators, underlying_ring, degrees_of_generators );
    
    return GradedPresentationMorphism( free_presentation, HomalgIdentityMatrix( number_of_generators, underlying_ring ), left_presentation );
    
end );

##
InstallMethod( CoverByProjective,
               [ IsGradedRightPresentation ],
               
  function( right_presentation )
    local underlying_ring, number_of_generators, free_presentation, degrees_of_generators;
    
    underlying_ring := UnderlyingHomalgRing( right_presentation );
    
    number_of_generators := NrRows( UnderlyingMatrix( right_presentation ) );
    
    degrees_of_generators := GeneratorDegrees( right_presentation );
    
    free_presentation := GradedFreeRightPresentation( number_of_generators, underlying_ring, degrees_of_generators );
    
    return GradedPresentationMorphism( free_presentation, HomalgIdentityMatrix( number_of_generators, underlying_ring ), right_presentation );
    
end );

####################################
##
## View
##
####################################

##
InstallMethod( Display,
               [ IsGradedLeftOrRightPresentationMorphism ],
               # FIXME: Fix the rank in GenericView and delete this afterwards
               9999,
               
  function( morphism )
    
    Display( UnderlyingMatrix( morphism ) );
    
    Print( "\n" );
    
    Print( String( morphism ) );
    
    Print( "\n" );
    
end );
