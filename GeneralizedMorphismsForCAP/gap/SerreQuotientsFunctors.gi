# SPDX-License-Identifier: GPL-2.0-or-later
# GeneralizedMorphismsForCAP: Implementations of generalized morphisms for the CAP project
#
# Implementations
#

## @Chapter Serre Quotients Functors

InstallMethod( SerreQuotientConversionFunctor,
               [ IsCapCategory and WasCreatedAsSerreQuotientCategoryByCospans,
                 IsCapCategory and WasCreatedAsSerreQuotientCategoryByThreeArrows ],
                 
  function( source_cat, range_cat )
    local functor, generalized_morphism_functor;
    
    if not IsIdenticalObj( UnderlyingHonestCategory( source_cat ), UnderlyingHonestCategory( range_cat ) ) then
        Error( "underlying honest categories are not identical" );
    fi;
    
    generalized_morphism_functor := FunctorFromCospansToThreeArrows( UnderlyingHonestCategory( source_cat ) );
    
    functor := CapFunctor( Concatenation( "Conversion functor between ", Name( source_cat ), " and ", Name( range_cat ) ),
                           source_cat,
                           range_cat );
    
    AddObjectFunction( functor, i -> AsSerreQuotientCategoryByThreeArrowsObject( range_cat, UnderlyingHonestObject( i ) ) );
    
    AddMorphismFunction( functor,
      
      function( new_source, morphism, new_range )
        local new_generalized;
        
        new_generalized := ApplyFunctor( generalized_morphism_functor, UnderlyingGeneralizedMorphism( morphism ) );
        
        return SerreQuotientCategoryByThreeArrowsMorphism( range_cat, new_generalized );
        
    end );
    
    return functor;
    
end );

InstallMethod( SerreQuotientConversionFunctor,
               [ IsCapCategory and WasCreatedAsSerreQuotientCategoryByCospans,
                 IsCapCategory and WasCreatedAsSerreQuotientCategoryBySpans ],
                 
  function( source_cat, range_cat )
    local functor, generalized_morphism_functor;
    
    if not IsIdenticalObj( UnderlyingHonestCategory( source_cat ), UnderlyingHonestCategory( range_cat ) ) then
        Error( "underlying honest categories are not identical" );
    fi;
    
    generalized_morphism_functor := FunctorFromCospansToSpans( UnderlyingHonestCategory( source_cat ) );
    
    functor := CapFunctor( Concatenation( "Conversion functor between ", Name( source_cat ), " and ", Name( range_cat ) ),
                           source_cat,
                           range_cat );
    
    AddObjectFunction( functor, i -> AsSerreQuotientCategoryBySpansObject( range_cat, UnderlyingHonestObject( i ) ) );
    
    AddMorphismFunction( functor,
      
      function( new_source, morphism, new_range )
        local new_generalized;
        
        new_generalized := ApplyFunctor( generalized_morphism_functor, UnderlyingGeneralizedMorphism( morphism ) );
        
        return SerreQuotientCategoryBySpansMorphism( range_cat, new_generalized );
        
    end );
    
    return functor;
    
end );

InstallMethod( SerreQuotientConversionFunctor,
               [ IsCapCategory and WasCreatedAsSerreQuotientCategoryBySpans,
                 IsCapCategory and WasCreatedAsSerreQuotientCategoryByThreeArrows ],
                 
  function( source_cat, range_cat )
    local functor, generalized_morphism_functor;
    
    if not IsIdenticalObj( UnderlyingHonestCategory( source_cat ), UnderlyingHonestCategory( range_cat ) ) then
        Error( "underlying honest categories are not identical" );
    fi;
    
    generalized_morphism_functor := FunctorFromSpansToThreeArrows( UnderlyingHonestCategory( source_cat ) );
    
    functor := CapFunctor( Concatenation( "Conversion functor between ", Name( source_cat ), " and ", Name( range_cat ) ),
                           source_cat,
                           range_cat );
    
    AddObjectFunction( functor, i -> AsSerreQuotientCategoryByThreeArrowsObject( range_cat, UnderlyingHonestObject( i ) ) );
    
    AddMorphismFunction( functor,
      
      function( new_source, morphism, new_range )
        local new_generalized;
        
        new_generalized := ApplyFunctor( generalized_morphism_functor, UnderlyingGeneralizedMorphism( morphism ) );
        
        return SerreQuotientCategoryByThreeArrowsMorphism( range_cat, new_generalized );
        
    end );
    
    return functor;
    
end );

InstallMethod( SerreQuotientConversionFunctor,
               [ IsCapCategory and WasCreatedAsSerreQuotientCategoryByThreeArrows,
                 IsCapCategory and WasCreatedAsSerreQuotientCategoryBySpans ],
                 
  function( source_cat, range_cat )
    local functor, generalized_morphism_functor;
    
    if not IsIdenticalObj( UnderlyingHonestCategory( source_cat ), UnderlyingHonestCategory( range_cat ) ) then
        Error( "underlying honest categories are not identical" );
    fi;
    
    generalized_morphism_functor := FunctorFromThreeArrowsToSpans( UnderlyingHonestCategory( source_cat ) );
    
    functor := CapFunctor( Concatenation( "Conversion functor between ", Name( source_cat ), " and ", Name( range_cat ) ),
                           source_cat,
                           range_cat );
    
    AddObjectFunction( functor, i -> AsSerreQuotientCategoryBySpansObject( range_cat, UnderlyingHonestObject( i ) ) );
    
    AddMorphismFunction( functor,
      
      function( new_source, morphism, new_range )
        local new_generalized;
        
        new_generalized := ApplyFunctor( generalized_morphism_functor, UnderlyingGeneralizedMorphism( morphism ) );
        
        return SerreQuotientCategoryBySpansMorphism( range_cat, new_generalized );
        
    end );
    
    return functor;
    
end );

InstallMethod( SerreQuotientConversionFunctor,
               [ IsCapCategory and WasCreatedAsSerreQuotientCategoryByThreeArrows,
                 IsCapCategory and WasCreatedAsSerreQuotientCategoryByCospans ],
                 
  function( source_cat, range_cat )
    local functor, generalized_morphism_functor;
    
    if not IsIdenticalObj( UnderlyingHonestCategory( source_cat ), UnderlyingHonestCategory( range_cat ) ) then
        Error( "underlying honest categories are not identical" );
    fi;
    
    generalized_morphism_functor := FunctorFromThreeArrowsToCospans( UnderlyingHonestCategory( source_cat ) );
    
    functor := CapFunctor( Concatenation( "Conversion functor between ", Name( source_cat ), " and ", Name( range_cat ) ),
                           source_cat,
                           range_cat );
    
    AddObjectFunction( functor, i -> AsSerreQuotientCategoryByCospansObject( range_cat, UnderlyingHonestObject( i ) ) );
    
    AddMorphismFunction( functor,
      
      function( new_source, morphism, new_range )
        local new_generalized;
        
        new_generalized := ApplyFunctor( generalized_morphism_functor, UnderlyingGeneralizedMorphism( morphism ) );
        
        return SerreQuotientCategoryByCospansMorphism( range_cat, new_generalized );
        
    end );
    
    return functor;
    
end );

InstallMethod( SerreQuotientConversionFunctor,
               [ IsCapCategory and WasCreatedAsSerreQuotientCategoryBySpans,
                 IsCapCategory and WasCreatedAsSerreQuotientCategoryByCospans ],
                 
  function( source_cat, range_cat )
    local functor, generalized_morphism_functor;
    
    if not IsIdenticalObj( UnderlyingHonestCategory( source_cat ), UnderlyingHonestCategory( range_cat ) ) then
        Error( "underlying honest categories are not identical" );
    fi;
    
    generalized_morphism_functor := FunctorFromSpansToCospans( UnderlyingHonestCategory( source_cat ) );
    
    functor := CapFunctor( Concatenation( "Conversion functor between ", Name( source_cat ), " and ", Name( range_cat ) ),
                           source_cat,
                           range_cat );
    
    AddObjectFunction( functor, i -> AsSerreQuotientCategoryByCospansObject( range_cat, UnderlyingHonestObject( i ) ) );
    
    AddMorphismFunction( functor,
      
      function( new_source, morphism, new_range )
        local new_generalized;
        
        new_generalized := ApplyFunctor( generalized_morphism_functor, UnderlyingGeneralizedMorphism( morphism ) );
        
        return SerreQuotientCategoryByCospansMorphism( range_cat, new_generalized );
        
    end );
    
    return functor;
    
end );
