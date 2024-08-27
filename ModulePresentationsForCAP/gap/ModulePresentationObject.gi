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
InstallMethod( UnderlyingHomalgRing,
               [ IsLeftOrRightPresentation ],
               
  obj -> UnderlyingRing( CapCategory( obj ) ) );

##
InstallMethod( AsLeftPresentation,
               [ IsHomalgMatrix ],
               
  function ( matrix )
    
    return AsLeftPresentation( LeftPresentations( HomalgRing( matrix ) ), matrix );
    
end );

##
InstallOtherMethodForCompilerForCAP( AsLeftPresentation,
                                     [ IsCategoryOfLeftPresentations, IsHomalgMatrix ],
                                     
  function( cat, matrix )
    
    return CreateCapCategoryObjectWithAttributes( cat, UnderlyingMatrix, matrix );
    
end );

##
InstallMethod( AsRightPresentation,
               [ IsHomalgMatrix ],
               
  function ( matrix )
    
    return AsRightPresentation( RightPresentations( HomalgRing( matrix ) ), matrix );
    
end );

##
InstallOtherMethodForCompilerForCAP( AsRightPresentation,
                                     [ IsCategoryOfRightPresentations, IsHomalgMatrix ],
                                     
  function( cat, matrix )
    
    return CreateCapCategoryObjectWithAttributes( cat, UnderlyingMatrix, matrix );
    
end );

##
InstallMethod( FreeLeftPresentation,
               [ IsInt, IsHomalgRing ],
               
  function( rank, homalg_ring )
    
    return FreeLeftPresentation( LeftPresentations( homalg_ring ), rank );
    
end );

##
InstallOtherMethod( FreeLeftPresentation,
                    [ IsCategoryOfLeftPresentations, IsInt ],
                    
  function( cat, rank )
    local object;
    
    if rank < 0 then
      
      Error( "rank must be a non-negative integer" );
      
    fi;
    
    object := AsLeftPresentation( cat, HomalgZeroMatrix( 0, rank, UnderlyingRing( cat ) ) );
    
    SetIsProjective( object, true );
    
    return object;
    
end );

##
InstallMethod( FreeRightPresentation,
               [ IsInt, IsHomalgRing ],
               
  function( rank, homalg_ring )
    
    return FreeRightPresentation( RightPresentations( homalg_ring ), rank );
    
end );

##
InstallOtherMethod( FreeRightPresentation,
                    [ IsCategoryOfRightPresentations, IsInt ],
                    
  function( cat, rank )
    local object;
    
    if rank < 0 then
      
      Error( "rank must be a non-negative integer" );
      
    fi;
    
    object := AsRightPresentation( cat, HomalgZeroMatrix( rank, 0, UnderlyingRing( cat ) ) );
    
    SetIsProjective( object, true );
    
    return object;
    
end );

##############################################
##
## Non categorical methods
##
##############################################

##
InstallMethod( Annihilator,
               [ IsLeftPresentation ],
               
  function( module_presentation )
    local ring, number_of_generators, list_of_generators, list_of_kernel_embeddings, ideal_embedding;
    
    ring := UnderlyingHomalgRing( module_presentation );
    
    number_of_generators := NrColumns( UnderlyingMatrix( module_presentation ) );
    
    if number_of_generators = 0 then
        
        return IdentityMorphism( FreeLeftPresentation( 1, ring ) );
        
    fi;
    
    list_of_generators := List( [ 1 .. number_of_generators ], i -> StandardGeneratorMorphism( module_presentation, i ) );
    
    list_of_kernel_embeddings := List( list_of_generators, KernelEmbedding );
    
    ideal_embedding := 
      PreCompose( ProjectionInFactorOfFiberProduct( list_of_kernel_embeddings, 1 ), list_of_kernel_embeddings[1] );
    
    SetIsMonomorphism( ideal_embedding, true );
    
    return ideal_embedding;
    
end );

##
InstallMethod( Annihilator,
               [ IsRightPresentation ],
               
  function( module_presentation )
    local ring, number_of_generators, list_of_generators, list_of_kernel_embeddings, ideal_embedding;
    
    ring := UnderlyingHomalgRing( module_presentation );
    
    number_of_generators := NrRows( UnderlyingMatrix( module_presentation ) );
    
    if number_of_generators = 0 then
        
        return IdentityMorphism( FreeRightPresentation( 1, ring ) );
        
    fi;
    
    list_of_generators := List( [ 1 .. number_of_generators ], i -> StandardGeneratorMorphism( module_presentation, i ) );
    
    list_of_kernel_embeddings := List( list_of_generators, KernelEmbedding );
    
    ideal_embedding := 
      PreCompose( ProjectionInFactorOfFiberProduct( list_of_kernel_embeddings, 1 ), list_of_kernel_embeddings[1] );
    
    SetIsMonomorphism( ideal_embedding, true );
    
    return ideal_embedding;
    
end );

##
InstallMethodWithCacheFromObject( INTERNAL_HOM_EMBEDDING_IN_TENSOR_PRODUCT_LEFT,
                                  [ IsLeftOrRightPresentation, IsLeftOrRightPresentation ],
                                  
  function( object_1, object_2 )
    local category, underlying_matrix_1, transposed_underlying_matrix_1, identity_matrix_2, differential_matrix, homalg_ring,
          free_module_source, free_module_range, differential;
    
    category := CapCategory( object_1 );
    
    underlying_matrix_1 := UnderlyingMatrix( object_1 );
    
    transposed_underlying_matrix_1 := TransposedMatrix( underlying_matrix_1 );
    
    identity_matrix_2 := UnderlyingMatrix( IdentityMorphism( object_2 ) );
    
    differential_matrix := KroneckerMat( transposed_underlying_matrix_1, identity_matrix_2 );
    
    homalg_ring := UnderlyingHomalgRing( object_1 );
    
    free_module_source := FreeLeftPresentation( category, NrColumns( underlying_matrix_1 ) );
    
    free_module_range := FreeLeftPresentation( category, NrRows( underlying_matrix_1 ) );
    
    differential :=  PresentationMorphism( TensorProductOnObjects( free_module_source, object_2 ),
                                           differential_matrix,
                                           TensorProductOnObjects( free_module_range, object_2 )
                                         );
    
    return KernelEmbedding( differential );
    
end );

##
InstallMethodWithCacheFromObject( INTERNAL_HOM_EMBEDDING_IN_TENSOR_PRODUCT_RIGHT,
                                  [ IsLeftOrRightPresentation, IsLeftOrRightPresentation ],
                                  
  function( object_1, object_2 )
    local category, underlying_matrix_1, transposed_underlying_matrix_1, identity_matrix_2, differential_matrix, homalg_ring,
          free_module_source, free_module_range, differential;
    
    category := CapCategory( object_1 );
    
    underlying_matrix_1 := UnderlyingMatrix( object_1 );
    
    transposed_underlying_matrix_1 := TransposedMatrix( underlying_matrix_1 );
    
    identity_matrix_2 := UnderlyingMatrix( IdentityMorphism( object_2 ) );
    
    differential_matrix := KroneckerMat( transposed_underlying_matrix_1, identity_matrix_2 );
    
    homalg_ring := UnderlyingHomalgRing( object_1 );
    
    free_module_source := FreeRightPresentation( category, NrRows( underlying_matrix_1 ) );
    
    free_module_range := FreeRightPresentation( category, NrColumns( underlying_matrix_1 ) );
    
    differential :=  PresentationMorphism( TensorProductOnObjects( free_module_source, object_2 ),
                                           differential_matrix,
                                           TensorProductOnObjects( free_module_range, object_2 )
                                         );
    
    return KernelEmbedding( differential );
    
end );


####################################
##
## View
##
####################################

##
InstallMethod( DisplayString,
               [ IsLeftOrRightPresentation ],
               
  function( object )
    
    return Concatenation( StringDisplay( UnderlyingMatrix( object ) ), "\n", StringMutable( object ), "\n" );
    
end );
