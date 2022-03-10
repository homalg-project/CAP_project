# SPDX-License-Identifier: GPL-2.0-or-later
# ModulesOverLocalRingsForCAP: Category of modules over a local ring modeled by Serre quotients for CAP
#
# Implementations
#

#############################
##
## Constructors
##
#############################

##
InstallMethod( CategoryOfLeftModulePresentationsOverLocalRing,
               [ IsHomalgRing, IsList ],
               
  function( ring, prime_ideal_generators )
    local prime_ideal_matrix, membership_function, ideal_string, category;
    
    prime_ideal_matrix :=
      HomalgMatrix( [ prime_ideal_generators ], Size( prime_ideal_generators ), 1, ring );
    
    membership_function := function( module_presentation )
        local annihilator;
        
        annihilator := Annihilator( module_presentation );
        
        return not IsZero( DecideZeroRows( UnderlyingMatrix( annihilator ), prime_ideal_matrix ) );
        
    end;
    
    ideal_string := String( prime_ideal_generators );
    
    RemoveCharacters( ideal_string, "\"" );
    
    category := SerreQuotientCategoryByCospans( LeftPresentations( ring ), membership_function,
      Concatenation( "presentations not supported in ", ideal_string ) );
    
    SetSpecializedObjectFilterForSerreQuotients( category, IsCategoryOfModulePresentationsOverLocalRingObject );
    
    SetSpecializedMorphismFilterForSerreQuotients( category, IsCategoryOfModulePresentationsOverLocalRingMorphism );
    
    SetFilterObj( category, IsCategoryOfModulePresentationsOverLocalRing );
    
    SetPrimeIdealAsHomalgMatrix( category, prime_ideal_matrix );
    
    SetUnderlyingHomalgRing( category, ring );
    
    if HasIsFreePolynomialRing( ring ) and IsFreePolynomialRing( ring ) then
        
        SetUnderlyingHomalgRingDegreeFunction( category, Degree );
        
    fi;
    
    return category;
    
end );

#############################
##
## Attributes
##
#############################

##
InstallMethod( UnderlyingHomalgRingModuloPrimeIdeal,
               [ IsCategoryOfModulePresentationsOverLocalRing ],
               
  function( category )
    
    return UnderlyingHomalgRing( category ) / PrimeIdealAsHomalgMatrix( category );
    
end );

##
InstallMethod( PrimeIdealAsModuleEmbedding,
               [ IsCategoryOfModulePresentationsOverLocalRing ],
               
  function( category )
    local ideal_embedding;
    
    ideal_embedding := AsMorphismBetweenFreeLeftPresentations( PrimeIdealAsHomalgMatrix( category ) );
    
    return ImageEmbedding( ideal_embedding );
    
end );

##
InstallMethod( PrimeIdealQuotientModuleProjection,
               [ IsCategoryOfModulePresentationsOverLocalRing ],
               
  function( category )
    local ideal_embedding;
    
    ideal_embedding := AsMorphismBetweenFreeLeftPresentations( PrimeIdealAsHomalgMatrix( category ) );
    
    return CokernelProjection( ideal_embedding );
    
end );

##
InstallMethod( EmbeddingDimension,
               [ IsCategoryOfModulePresentationsOverLocalRing ],
               
  function( category )
    
    return MinimalNumberOfGenerators( 
             AsSerreQuotientCategoryObject( category, Source( PrimeIdealAsModuleEmbedding( category ) ) ) );
    
end );

##
InstallMethod( IsRegular,
               [ IsCategoryOfModulePresentationsOverLocalRing ],
               
  function( category )
    local embedding_dimension, k, minimal_resolution;
    
    embedding_dimension := EmbeddingDimension( category );
    
    k := AsSerreQuotientCategoryObject( category, Range( PrimeIdealQuotientModuleProjection( category ) ) );
    
    minimal_resolution := MinimalFreeResolution( k );
    
    return IsZeroForObjects( minimal_resolution[ embedding_dimension + 1 ] );
    
end );
