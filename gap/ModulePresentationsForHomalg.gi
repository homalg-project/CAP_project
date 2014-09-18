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
    
    ADD_FUNCTIONS_FOR_LEFT_PRESENTATION( category );
    
    return category;
    
end );

##
InstallMethod( RightPresentations,
               [ IsHomalgRing ],
               
  function( ring )
    local category;
    
    category := CreateHomalgCategory( Concatenation( "Category of right presentations of ", RingName( ring ) ) );
    
    category!.ring_for_representation_category := ring;
    
    ADD_FUNCTIONS_FOR_RIGHT_PRESENTATION( category );
    
    return category;
    
end );

######################################
##
## Tech stuff
##
######################################

##############################################
##
## LEFT
##
##############################################

##
InstallGlobalFunction( ADD_FUNCTIONS_FOR_LEFT_PRESENTATION,
                       
  function( category )
    
    ADD_KERNEL_EMBEDDING_LEFT( category );
    
    ADD_PRECOMPOSE_LEFT( category );
    
    ADD_ADDITION_FOR_MORPHISMS( category );
    
    ADD_ADDITIVE_INVERSE_FOR_MORPHISMS( category );
    
    ADD_IS_ZERO_FOR_MORPHISMS( category );
    
    ADD_ZERO_MORPHISM_LEFT( category );
    
end );

##
InstallGlobalFunction( ADD_FUNCTIONS_FOR_RIGHT_PRESENTATION,
                       
  function( category )
    
    ADD_KERNEL_EMBEDDING_RIGHT( category );
    
    ADD_PRECOMPOSE_RIGHT( category );
    
    ADD_ADDITION_FOR_MORPHISMS( category );
    
    ADD_ADDITIVE_INVERSE_FOR_MORPHISMS( category );
    
    ADD_IS_ZERO_FOR_MORPHISMS( category );
    
    ADD_ZERO_MORPHISM_RIGHT( category );
    
end );

##
InstallGlobalFunction( ADD_KERNEL_EMBEDDING_LEFT,
                       
  function( category )
    
    AddKernelEmb( category,
      
      function( morphism )
        local kernel, embedding;
        
        embedding := SyzygiesOfRows( UnderlyingMatrix( morphism ), UnderlyingMatrix( Range( morphism ) ) );
        
        kernel := SyzygiesOfRows( embedding, UnderlyingMatrix( Source( morphism ) ) );
        
        kernel := AsLeftPresentation( kernel );
        
        return PresentationMorphism( kernel, embedding, Source( morphism ) );
        
    end );
    
end );

##
InstallGlobalFunction( ADD_KERNEL_EMBEDDING_RIGHT,
                       
  function( category )
    
    AddKernelEmb( category,
      
      function( morphism )
        local kernel, embedding;
        
        embedding := SyzygiesOfColumns( UnderlyingMatrix( morphism ), UnderlyingMatrix( Range( morphism ) ) );
        
        kernel := SyzygiesOfColumns( embedding, UnderlyingMatrix( Source( morphism ) ) );
        
        kernel := AsRightPresentation( kernel );
        
        return PresentationMorphism( kernel, embedding, Source( morphism ) );
        
    end );
    
end );

##
InstallGlobalFunction( ADD_PRECOMPOSE_LEFT,
                       
  function( category )
    
    AddPreCompose( category,
                   
      function( left_morphism, right_morphism )
        
        return PresentationMorphism( Source( left_morphism ), UnderlyingMatrix( left_morphism ) * UnderlyingMatrix( right_morphism ), Range( right_morphism ) );
        
    end );
    
end );

##
InstallGlobalFunction( ADD_PRECOMPOSE_RIGHT,
                       
  function( category )
    
    AddPreCompose( category,
                   
      function( left_morphism, right_morphism )
        
        return PresentationMorphism( Source( left_morphism ), UnderlyingMatrix( right_morphism ) * UnderlyingMatrix( left_morphism ), Range( right_morphism ) );
        
    end );
    
end );

##
InstallGlobalFunction( ADD_ADDITION_FOR_MORPHISMS,
                       
  function( category )
    
    AddAdditionForMorphisms( category,
                             
      function( mor1, mor2 )
        
        return PresentationMorphism( Source( mor1 ), UnderlyingMatrix( mor1 ) + UnderlyingMatrix( mor2 ), Range( mor1 ) );
        
    end );
    
end );

##
InstallGlobalFunction( ADD_ADDITIVE_INVERSE_FOR_MORPHISMS,
                       
  function( category )
    
    AddAdditiveInverseForMorphisms( category,
                                    
      function( mor1 )
        
        return PresentationMorphism( Source( mor1 ), - UnderlyingMatrix( mor1 ), Range( mor1 ) );
        
    end );
    
end );

##
InstallGlobalFunction( ADD_IS_ZERO_FOR_MORPHISMS,
                       
  function( category )
    
    AddIsZeroForMorphisms( category,
                           
      function( mor )
        
        return IsZero( UnderlyingMatrix( mor ) );
        
    end );
    
end );

##
InstallGlobalFunction( ADD_ZERO_MORPHISM_LEFT,
                       
  function( category )
    
    AddZeroMorphism( category,
                     
      function( source, range )
        local matrix;
        
        matrix := HomalgZeroMatrix( NrColumns( UnderlyingMatrix( source ) ), NrColumns( UnderlyingMatrix( range ) ), category!.ring_for_representation_category );
        
        return PresentationMorphism( source, matrix, range );
        
    end );
    
end );

##
InstallGlobalFunction( ADD_ZERO_MORPHISM_RIGHT,
                       
  function( category )
    
    AddZeroMorphism( category,
                     
      function( source, range )
        local matrix;
        
        matrix := HomalgZeroMatrix( NrRows( UnderlyingMatrix( range ) ), NrRows( UnderlyingMatrix( source ) ), category!.ring_for_representation_category );
        
        return PresentationMorphism( source, matrix, range );
        
    end );
    
end );
