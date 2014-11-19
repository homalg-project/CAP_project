#############################################################################
##
##                                       ModulePresentationsForHomalg package
##
##  Copyright 2014, Sebastian Gutsche, TU Kaiserslautern
##                  Sebastian Posur,   RWTH Aachen
##
#############################################################################

DeclareRepresentation( "IsLeftPresentationRep",
                       IsLeftPresentation and IsAttributeStoringRep,
                       [ ] );

BindGlobal( "TheFamilyOfLeftPresentations",
            NewFamily( "TheFamilyOfLeftPresentations" ) );

BindGlobal( "TheTypeOfLeftPresentations",
            NewType( TheFamilyOfLeftPresentations,
                     IsLeftPresentationRep ) );


DeclareRepresentation( "IsRightPresentationRep",
                       IsRightPresentation and IsAttributeStoringRep,
                       [ ] );

BindGlobal( "TheFamilyOfRightPresentations",
            NewFamily( "TheFamilyOfRightPresentations" ) );

BindGlobal( "TheTypeOfRightPresentations",
            NewType( TheFamilyOfRightPresentations,
                     IsRightPresentationRep ) );

#############################
##
## Constructors
##
#############################

InstallGlobalFunction( AsLeftOrRightPresentation,
               
  function( matrix, left )
    local module, ring, type, presentation_category;
    
    module := rec( );
    
    ring := HomalgRing( matrix );
    
    if left = true then
        type := TheTypeOfLeftPresentations;
        presentation_category := LeftPresentations( ring );
    else
        type := TheTypeOfRightPresentations;
        presentation_category := RightPresentations( ring );
    fi;
    
    ObjectifyWithAttributes( module, type,
                             UnderlyingMatrix, matrix,
                             UnderlyingHomalgRing, ring
                           );
    
    Add( presentation_category, module );
    
    return module;
    
end );

##
InstallMethod( AsLeftPresentation,
               [ IsHomalgMatrix ],
               
  matrix -> AsLeftOrRightPresentation( matrix, true ) );

##
InstallMethod( AsRightPresentation,
               [ IsHomalgMatrix ],
               
  matrix -> AsLeftOrRightPresentation( matrix, false ) );

##
InstallMethod( FreeLeftPresentation,
               [ IsInt, IsHomalgRing ],
               
  function( rank, homalg_ring )
    
    if rank < 0 then
      
      Error( "rank must be a non-negative integer" );
      
    fi;
    
    return AsLeftPresentation( HomalgMatrix( [ List( [ 1 .. rank ], i -> 0 ) ], homalg_ring ) );
    
end );

##
InstallMethod( FreeRightPresentation,
               [ IsInt, IsHomalgRing ],
               
  function( rank, homalg_ring )
    
    if rank < 0 then
      
      Error( "rank must be a non-negative integer" );
      
    fi;
    
    return AsRightPresentation( HomalgMatrix( [ List( [ 1 .. rank ], i -> [ 0 ] ) ], homalg_ring ) );
    
end );