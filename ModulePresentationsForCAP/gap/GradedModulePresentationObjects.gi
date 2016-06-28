#############################################################################
##
##                                       ModulePresentationsForCAP package
##
##  Copyright 2014, Sebastian Gutsche, TU Kaiserslautern
##                  Sebastian Posur,   RWTH Aachen
##
#############################################################################

DeclareRepresentation( "IsGradedLeftPresentationRep",
                       IsGradedLeftPresentation and IsAttributeStoringRep,
                       [ ] );

BindGlobal( "TheFamilyOfGradedLeftPresentations",
            NewFamily( "TheFamilyOfGradedLeftPresentations" ) );

BindGlobal( "TheTypeOfGradedLeftPresentations",
            NewType( TheFamilyOfGradedLeftPresentations,
                     IsGradedLeftPresentationRep ) );


DeclareRepresentation( "IsGradedRightPresentationRep",
                       IsGradedRightPresentation and IsAttributeStoringRep,
                       [ ] );

BindGlobal( "TheFamilyOfGradedRightPresentations",
            NewFamily( "TheFamilyOfGradedRightPresentations" ) );

BindGlobal( "TheTypeOfGradedRightPresentations",
            NewType( TheFamilyOfGradedRightPresentations,
                     IsGradedRightPresentationRep ) );

#############################
##
## Constructors
##
#############################

InstallGlobalFunction( AsGradedLeftOrRightPresentation,
               
  function( presentation )
    local ring, nr_of_generators, left, degree_list;
    
    ring := UnderlyingHomalgRing( Presentation );
    
    if not IsHomalgGradedRing( ring ) then
        Error( "input must be a representation or matrix over a graded ring" );
        return;
    fi;
    
    left := IsLeftPresentation( presentation );
    
    if left = true then
        nr_of_generators := NrColumns( UnderlyingMatrix( presentation ) );
    else
        nr_of_generators := NrRows( UnderlyingMatrix( presentation ) );
    fi;
    
    ##FIXME: Causes error if degree group is trivial
    degree_list := Zero( GeneratingElements( DegreeGroup( ring ) )[ 1 ] );
    degree_list := List( [ 1 .. nr_of_generators ], i -> degree_list );
    
    return AsGradedLeftOrRightPresentationWithDegrees( presentation, degree_list );
    
end );

InstallGlobalFunction( AsGradedLeftOrRightPresentationWithDegrees,
                      
  function( presentation, degrees )
    local left, module, ring, graded_category, type;
    
    left := IsLeftPresentation( presentation );
    
    module := rec();
    
    ring := UnderlyingHomalgRing( presentation );
    
    if left then
        type := TheTypeOfGradedLeftPresentations;
        graded_category := GradedLeftPresentations( ring );
    else
        type := TheTypeOfGradedRightPresentations;
        graded_category := GradedRightPresentations( ring );
    fi;
    
    ObjectifyWithAttributes( module, type,
                             UnderlyingPresentationObject, presentation,
                             UnderlyingHomalgRing, ring,
                             GeneratorDegrees, degrees,
                             UnderlyingMatrix, UnderlyingMatrix( presentation ) );
    
    Add( graded_category, module );
    
    return module;
    
end );

##
InstallMethod( AsGradedLeftPresentation,
               [ IsHomalgMatrix ],
               
  matrix -> AsGradedLeftOrRightPresentation( AsLeftPresentation( matrix ) ) );

##
InstallMethod( AsGradedLeftPresentation,
               [ IsLeftPresentation ],
               
  AsGradedLeftOrRightPresentation );

##
InstallMethod( AsGradedLeftPresentation,
               [ IsHomalgMatrix, IsList ],
  
  function( matrix, degrees )
    return AsGradedLeftOrRightPresentationWithDegrees( AsLeftPresentation( matrix ), degrees );
end );

##
InstallMethod( AsGradedLeftPresentation,
               [ IsLeftPresentation, IsList ],
  
  function( matrix, degrees )
    return AsGradedLeftOrRightPresentationWithDegrees( matrix, degrees );
end );

##
InstallMethod( AsGradedRightPresentation,
               [ IsHomalgMatrix ],
               
  matrix -> AsGradedLeftOrRightPresentation( AsRightPresentation( matrix ) ) );

##
InstallMethod( AsGradedRightPresentation,
               [ IsRightPresentation ],
               
  AsGradedLeftOrRightPresentation );

##
InstallMethod( AsGradedRightPresentation,
               [ IsHomalgMatrix, IsList ],
  
  function( matrix, degrees )
    return AsGradedLeftOrRightPresentationWithDegrees( AsRightPresentation( matrix ), degrees );
end );

##
InstallMethod( AsGradedRightPresentation,
               [ IsRightPresentation, IsList ],
  
  function( matrix, degrees )
    return AsGradedLeftOrRightPresentationWithDegrees( matrix, degrees );
end );

##
InstallMethod( GradedFreeLeftPresentation,
               [ IsInt, IsHomalgRing ],
               
  function( rank, homalg_ring )
    
    if rank < 0 then
      
      Error( "rank must be a non-negative integer" );
      
    fi;
    
    return AsGradedLeftPresentation( HomalgZeroMatrix( 0, rank, homalg_ring ) );
    
end );

##
InstallMethod( GradedFreeRightPresentation,
               [ IsInt, IsHomalgRing ],
               
  function( rank, homalg_ring )
    
    if rank < 0 then
      
      Error( "rank must be a non-negative integer" );
      
    fi;
    
    return AsGradedRightPresentation( HomalgZeroMatrix( rank, 0, homalg_ring ) );
    
end );

# ##############################################
# ##
# ## Non categorical methods
# ##
# ##############################################
# 
# ##
# InstallMethodWithCacheFromObject( INTERNAL_HOM_EMBEDDING_IN_TENSOR_PRODUCT_LEFT,
#                                   [ IsLeftOrRightPresentation, IsLeftOrRightPresentation ],
#                                   
#   function( object_1, object_2 )
#     local underlying_matrix_1, transposed_underlying_matrix_1, identity_matrix_2, differential_matrix, homalg_ring,
#           free_module_source, free_module_range, differential;
#     
#     underlying_matrix_1 := UnderlyingMatrix( object_1 );
#     
#     transposed_underlying_matrix_1 := Involution( underlying_matrix_1 );
#     
#     identity_matrix_2 := UnderlyingMatrix( IdentityMorphism( object_2 ) );
#     
#     differential_matrix := KroneckerMat( transposed_underlying_matrix_1, identity_matrix_2 );
#     
#     homalg_ring := UnderlyingHomalgRing( object_1 );
#     
#     free_module_source := FreeLeftPresentation( NrColumns( underlying_matrix_1 ), homalg_ring );
#     
#     free_module_range := FreeLeftPresentation( NrRows( underlying_matrix_1 ), homalg_ring );
#     
#     differential :=  PresentationMorphism( TensorProductOnObjects( free_module_source, object_2 ),
#                                            differential_matrix,
#                                            TensorProductOnObjects( free_module_range, object_2 )
#                                          );
#     
#     return KernelEmbedding( differential );
#     
# end );
# 
# ##
# InstallMethodWithCacheFromObject( INTERNAL_HOM_EMBEDDING_IN_TENSOR_PRODUCT_RIGHT,
#                                   [ IsLeftOrRightPresentation, IsLeftOrRightPresentation ],
#                                   
#   function( object_1, object_2 )
#     local underlying_matrix_1, transposed_underlying_matrix_1, identity_matrix_2, differential_matrix, homalg_ring,
#           free_module_source, free_module_range, differential;
#     
#     underlying_matrix_1 := UnderlyingMatrix( object_1 );
#     
#     transposed_underlying_matrix_1 := Involution( underlying_matrix_1 );
#     
#     identity_matrix_2 := UnderlyingMatrix( IdentityMorphism( object_2 ) );
#     
#     differential_matrix := KroneckerMat( transposed_underlying_matrix_1, identity_matrix_2 );
#     
#     homalg_ring := UnderlyingHomalgRing( object_1 );
#     
#     free_module_source := FreeRightPresentation( NrRows( underlying_matrix_1 ), homalg_ring );
#     
#     free_module_range := FreeRightPresentation( NrColumns( underlying_matrix_1 ), homalg_ring );
#     
#     differential :=  PresentationMorphism( TensorProductOnObjects( free_module_source, object_2 ),
#                                            differential_matrix,
#                                            TensorProductOnObjects( free_module_range, object_2 )
#                                          );
#     
#     return KernelEmbedding( differential );
#     
# end );


####################################
##
## View
##
####################################

##
InstallMethod( Display,
               [ IsGradedLeftOrRightPresentation ],
               # FIXME: Fix the rank in GenericView and delete this afterwards
               9999,
               
  function( object )
    
    Display( UnderlyingMatrix( object ) );
    
    Print( "\n" );
    
    Print( StringMutable( object ) );
    
end );
