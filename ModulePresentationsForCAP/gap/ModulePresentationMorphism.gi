#############################################################################
##
##                                       ModulePresentationsForCAP package
##
##  Copyright 2014, Sebastian Gutsche, TU Kaiserslautern
##                  Sebastian Posur,   RWTH Aachen
##
#############################################################################

DeclareRepresentation( "IsLeftPresentationMorphismRep",
                       IsLeftPresentationMorphism and IsAttributeStoringRep,
                       [ ] );

BindGlobal( "TheFamilyOfLeftPresentationMorphisms",
            NewFamily( "TheFamilyOfLeftPresentationMorphisms" ) );

BindGlobal( "TheTypeOfLeftPresentationMorphisms",
            NewType( TheFamilyOfLeftPresentationMorphisms,
                     IsLeftPresentationMorphismRep ) );


DeclareRepresentation( "IsRightPresentationMorphismRep",
                       IsRightPresentationMorphism and IsAttributeStoringRep,
                       [ ] );

BindGlobal( "TheFamilyOfRightPresentationMorphisms",
            NewFamily( "TheFamilyOfRightPresentationMorphisms" ) );

BindGlobal( "TheTypeOfRightPresentationMorphisms",
            NewType( TheFamilyOfRightPresentationMorphisms,
                     IsRightPresentationMorphismRep ) );

#############################
##
## Constructors
##
#############################

##
InstallMethod( PresentationMorphism,
               [ IsLeftOrRightPresentation, IsHomalgMatrix, IsLeftOrRightPresentation ],
               
  function( source, matrix, range )
    local category, left, morphism, type;
    
    category := CapCategory( source );
    
    left := IsLeftPresentation( source );
    
    if not IsIdenticalObj( UnderlyingHomalgRing( source ), HomalgRing( matrix ) ) then
        
        Error( "matrix can not present a morphism between these objects" );
        
    fi;
    
    morphism := rec( );
    
    if left then
        type := TheTypeOfLeftPresentationMorphisms;
    else
        type := TheTypeOfRightPresentationMorphisms;
    fi;
    
    ObjectifyWithAttributes( morphism, type,
                             Source, source,
                             Range, range,
                             UnderlyingHomalgRing, HomalgRing( matrix ),
                             UnderlyingMatrix, matrix );
    
    Add( category, morphism );
    
    return morphism;
    
end );


