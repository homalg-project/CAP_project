#############################################################################
##
##                                       ModulePresentationsForHomalg package
##
##  Copyright 2014, Sebastian Gutsche, TU Kaiserslautern
##                  Sebastian Posur,   RWTH Aachen
##
#############################################################################

##
InstallMethod( LeftPresentations,
               [ IsHomalgRing ],
               
  function( ring )
    local category;
    
    category := CreateHomalgCategory( Concatenation( "Category of left presentations of ", RingName( ring ) ) );
    
    category!.ring_for_representation_category := ring;
    
    return category;
    
end );

##
InstallMethod( RightPresentations,
               [ IsHomalgRing ],
               
  function( ring )
    local category;
    
    category := CreateHomalgCategory( Concatenation( "Category of right presentations of ", RingName( ring ) ) );
    
    category!.ring_for_representation_category := ring;
    
    return category;
    
end );
