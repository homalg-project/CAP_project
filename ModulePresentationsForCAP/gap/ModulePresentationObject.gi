#############################################################################
##
##                                       ModulePresentationsForCAP package
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
    local module, ring, type, presentation_category, lazy;
    
    module := rec( );
    
    ring := HomalgRing( matrix );
    
    if left = true then
        type := TheTypeOfLeftPresentations;
        presentation_category := LeftPresentations( ring );
        if HasEvalSyzygiesOfRows( matrix ) and not HasEval( matrix ) then
            lazy := true;
            module.nr_generators := NrRows( EvalSyzygiesOfRows( matrix )[1] );
        else
            lazy := false;
            module.nr_generators := NrColumns( matrix );
        fi;
    else
        type := TheTypeOfRightPresentations;
        presentation_category := RightPresentations( ring );
        if HasEvalSyzygiesOfColumns( matrix ) and not HasEval( matrix ) then
            lazy := true;
            module.nr_generators := NrColumns( EvalSyzygiesOfColumns( matrix )[1] );
        else
            lazy := false;
            module.nr_generators := NrRows( matrix );
        fi;
    fi;
    
    if lazy then
        module.LazyUnderlyingMatrix := matrix;
        ObjectifyWithAttributes( module, type,
                UnderlyingHomalgRing, ring
                );
    else
        ObjectifyWithAttributes( module, type,
                UnderlyingMatrix, matrix,
                UnderlyingHomalgRing, ring
                );
    fi;
    
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
    
    return AsLeftPresentation( HomalgZeroMatrix( 0, rank, homalg_ring ) );
    
end );

##
InstallMethod( FreeRightPresentation,
               [ IsInt, IsHomalgRing ],
               
  function( rank, homalg_ring )
    
    if rank < 0 then
      
      Error( "rank must be a non-negative integer" );
      
    fi;
    
    return AsRightPresentation( HomalgZeroMatrix( rank, 0, homalg_ring ) );
    
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
InstallMethod( UnderlyingMatrix,
               [ IsLeftPresentation ],
               
  function( M )
    local mat;
    
    mat := M!.LazyUnderlyingMatrix;
    
    mat := EvalSyzygiesOfRows( mat );
    
    mat := SyzygiesOfRows( mat[1], mat[2] );
    
    Unbind( M!.LazyUnderlyingMatrix );
    
    return mat;
    
end );

##
InstallMethod( UnderlyingMatrix,
               [ IsRightPresentation ],
               
  function( M )
    local mat;
    
    mat := M!.LazyUnderlyingMatrix;
    
    mat := EvalSyzygiesOfColumns( mat );
    
    mat := SyzygiesOfColumns( mat[1], mat[2] );
    
    Unbind( M!.LazyUnderlyingMatrix );
    
    return mat;
    
end );

##
InstallMethodWithCacheFromObject( INTERNAL_HOM_EMBEDDING_IN_TENSOR_PRODUCT_LEFT,
                                  [ IsLeftOrRightPresentation, IsLeftOrRightPresentation ],
                                  
  function( object_1, object_2 )
    local underlying_matrix_1, transposed_underlying_matrix_1, identity_matrix_2, differential_matrix, homalg_ring,
          free_module_source, free_module_range, differential;
    
    underlying_matrix_1 := UnderlyingMatrix( object_1 );
    
    transposed_underlying_matrix_1 := Involution( underlying_matrix_1 );
    
    identity_matrix_2 := UnderlyingMatrix( IdentityMorphism( object_2 ) );
    
    differential_matrix := KroneckerMat( transposed_underlying_matrix_1, identity_matrix_2 );
    
    homalg_ring := UnderlyingHomalgRing( object_1 );
    
    free_module_source := FreeLeftPresentation( NrColumns( underlying_matrix_1 ), homalg_ring );
    
    free_module_range := FreeLeftPresentation( NrRows( underlying_matrix_1 ), homalg_ring );
    
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
    local underlying_matrix_1, transposed_underlying_matrix_1, identity_matrix_2, differential_matrix, homalg_ring,
          free_module_source, free_module_range, differential;
    
    underlying_matrix_1 := UnderlyingMatrix( object_1 );
    
    transposed_underlying_matrix_1 := Involution( underlying_matrix_1 );
    
    identity_matrix_2 := UnderlyingMatrix( IdentityMorphism( object_2 ) );
    
    differential_matrix := KroneckerMat( transposed_underlying_matrix_1, identity_matrix_2 );
    
    homalg_ring := UnderlyingHomalgRing( object_1 );
    
    free_module_source := FreeRightPresentation( NrRows( underlying_matrix_1 ), homalg_ring );
    
    free_module_range := FreeRightPresentation( NrColumns( underlying_matrix_1 ), homalg_ring );
    
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
InstallMethod( Display,
               [ IsLeftOrRightPresentation ],
               # FIXME: Fix the rank in GenericView and delete this afterwards
               9999,
               
  function( object )
    
    Display( UnderlyingMatrix( object ) );
    
    Print( "\n" );
    
    Print( StringMutable( object ) );
    
    Print( "\n" );
    
end );
