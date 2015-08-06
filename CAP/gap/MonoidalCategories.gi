#############################################################################
##
##                                               CAP package
##
##  Copyright 2015, Sebastian Gutsche, TU Kaiserslautern
##                  Sebastian Posur,   RWTH Aachen
##
#! @Chapter Monoidal Categories
#!
##
#############################################################################

InstallMethod( TensorProductOnMorphisms,
               [ IsCapCategoryMorphism, IsCapCategoryMorphism ],
               
  function( morphism_1, morphism_2 )
    
    return TensorProductOnMorphisms( TensorProductOnObjects( Source( morphism_1 ), Source( morphism_2 ) ),
                                     morphism_1, morphism_2,
                                     TensorProductOnObjects( Range( morphism_1 ), Range( morphism_2 ) )
                                   );
    
end );

