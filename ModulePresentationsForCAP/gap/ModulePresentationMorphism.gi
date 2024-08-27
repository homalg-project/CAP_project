# SPDX-License-Identifier: GPL-2.0-or-later
# ModulePresentationsForCAP: Category R-pres for CAP
#
# Implementations
#

#############################
##
## Constructors
##
#############################

##
InstallMethod( PresentationMorphism,
               [ IsLeftOrRightPresentation, IsHomalgMatrix, IsLeftOrRightPresentation ],
               
  function( source, matrix, range )
    
    return PresentationMorphism( CapCategory( source ), source, matrix, range );
    
end );

##
InstallOtherMethodForCompilerForCAP( PresentationMorphism,
                                     [ IsCategoryOfLeftPresentations, IsLeftPresentation, IsHomalgMatrix, IsLeftPresentation ],
                                     
  function( category, source, matrix, range )
    
    if not IsIdenticalObj( CapCategory( source ), category ) then
        
        Error( "<source> does not lie in <category>" );
        
    fi;
    
    if not IsIdenticalObj( CapCategory( range ), category ) then
        
        Error( "<range> does not lie in <category>" );
        
    fi;
    
    if not IsIdenticalObj( UnderlyingRing( category ), HomalgRing( matrix ) ) then
        
        Error( "matrix can not present a morphism between these objects" );
        
    fi;
    
    if NrRows( matrix ) <> NrColumns( UnderlyingMatrix( source ) ) then
        
        Error( "the number of rows of the given matrix is incorrect" );
        
    fi;
    
    if NrColumns( matrix ) <> NrColumns( UnderlyingMatrix( range ) ) then
        
        Error( "the number of columns of the given matrix is incorrect" );
        
    fi;
    
    return CreateCapCategoryMorphismWithAttributes( category,
                             source,
                             range,
                             UnderlyingMatrix, matrix );
    
end );

##
InstallOtherMethodForCompilerForCAP( PresentationMorphism,
                                     [ IsCategoryOfRightPresentations, IsRightPresentation, IsHomalgMatrix, IsRightPresentation ],
                                     
  function( category, source, matrix, range )
    
    if not IsIdenticalObj( CapCategory( source ), category ) then
        
        Error( "<source> does not lie in <category>" );
        
    fi;
    
    if not IsIdenticalObj( CapCategory( range ), category ) then
        
        Error( "<range> does not lie in <category>" );
        
    fi;
    
    if not IsIdenticalObj( UnderlyingRing( category ), HomalgRing( matrix ) ) then
        
        Error( "matrix can not present a morphism between these objects" );
        
    fi;
    
    if NrColumns( matrix ) <> NrRows( UnderlyingMatrix( source ) ) then
        
        Error( "the number of columns of the given matrix is incorrect" );
        
    fi;
    
    if NrRows( matrix ) <> NrRows( UnderlyingMatrix( range ) ) then
        
        Error( "the number of rows of the given matrix is incorrect" );
        
    fi;
    
    return CreateCapCategoryMorphismWithAttributes( category,
                             source,
                             range,
                             UnderlyingMatrix, matrix );
    
end );

##
InstallMethod( UnderlyingHomalgRing,
               [ IsLeftOrRightPresentationMorphism ],
               
  mor -> UnderlyingRing( CapCategory( mor ) ) );

##
InstallMethod( AsMorphismBetweenFreeLeftPresentations,
               [ IsHomalgMatrix ],
               
  function( matrix )
    local source, range, ring;
    
    ring := HomalgRing( matrix );
    
    source := FreeLeftPresentation( NrRows( matrix ), ring );
    
    range := FreeLeftPresentation( NrColumns( matrix ), ring );
    
    return PresentationMorphism( source, matrix, range );
    
end );

##
InstallMethod( AsMorphismBetweenFreeRightPresentations,
               [ IsHomalgMatrix ],
               
  function( matrix )
    local source, range, ring;
    
    ring := HomalgRing( matrix );
    
    source := FreeRightPresentation( NrColumns( matrix ), ring );
    
    range := FreeRightPresentation( NrRows( matrix ), ring );
    
    return PresentationMorphism( source, matrix, range );
    
end );

##############################################
##
## Arithmetics
##
##############################################

##
InstallMethod( \*,
               [ IsRingElement, IsLeftPresentationMorphism ],
               
  function( ring_element, left_presentation )
    
    return PresentationMorphism( Source( left_presentation ),
                                 ring_element * UnderlyingMatrix( left_presentation ),
                                 Range( left_presentation ) );
    
end );

##
InstallMethod( \*,
               [ IsRightPresentationMorphism, IsRingElement ],
               
  function( right_presentation, ring_element )
    
    return PresentationMorphism( Source( right_presentation ),
                                 UnderlyingMatrix( right_presentation ) * ring_element,
                                 Range( right_presentation ) );
    
end );


##############################################
##
## Non categorical methods
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
InstallMethod( CoverByFreeModule,
               [ IsLeftPresentation ],
               
  function( left_presentation )
    local underlying_ring, number_of_generators, free_presentation;
    
    underlying_ring := UnderlyingHomalgRing( left_presentation );
    
    number_of_generators := NrColumns( UnderlyingMatrix( left_presentation ) );
    
    free_presentation := FreeLeftPresentation( CapCategory( left_presentation ), number_of_generators );
    
    return PresentationMorphism( free_presentation, HomalgIdentityMatrix( number_of_generators, underlying_ring ), left_presentation );
    
end );

##
InstallMethod( CoverByFreeModule,
               [ IsRightPresentation ],
               
  function( right_presentation )
    local underlying_ring, number_of_generators, free_presentation;
    
    underlying_ring := UnderlyingHomalgRing( right_presentation );
    
    number_of_generators := NrRows( UnderlyingMatrix( right_presentation ) );
    
    free_presentation := FreeRightPresentation( CapCategory( right_presentation ), number_of_generators );
    
    return PresentationMorphism( free_presentation, HomalgIdentityMatrix( number_of_generators, underlying_ring ), right_presentation );
    
end );

####################################
##
## View
##
####################################

##
InstallMethod( DisplayString,
               [ IsLeftOrRightPresentationMorphism ],
               
  function( morphism )
    
    return Concatenation( StringDisplay( UnderlyingMatrix( morphism ) ), "\n", StringMutable( morphism ), "\n" );
    
end );

