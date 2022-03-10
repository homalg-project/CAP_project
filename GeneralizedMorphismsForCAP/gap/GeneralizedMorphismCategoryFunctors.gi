# SPDX-License-Identifier: GPL-2.0-or-later
# GeneralizedMorphismsForCAP: Implementations of generalized morphisms for the CAP project
#
# Implementations
#

## @Chapter Conversion functors for generalized morphisms

InstallMethod( FunctorFromCospansToThreeArrows,
               [ IsCapCategory ],
               
  function( category )
    local source_cat, range_cat, functor;
    
    source_cat := GeneralizedMorphismCategoryByCospans( category : FinalizeCategory := true );
    
    range_cat := GeneralizedMorphismCategoryByThreeArrows( category : FinalizeCategory := true );
    
    functor := CapFunctor( Concatenation( "Functor from cospans to three arrows on ", Name( category ) ), source_cat, range_cat );
    
    AddObjectFunction( functor, i -> GeneralizedMorphismByThreeArrowsObject( UnderlyingHonestObject( i ) ) );
    
    AddMorphismFunction( functor,
      function( new_source, morphism, new_range )
        
        return GeneralizedMorphismByThreeArrowsWithRangeAid( Arrow( morphism ), ReversedArrow( morphism ) );
        
    end );
    
    return functor;
    
end );

InstallMethod( FunctorFromCospansToSpans,
               [ IsCapCategory ],
               
  function( category )
    local source_cat, range_cat, functor;
    
    source_cat := GeneralizedMorphismCategoryByCospans( category : FinalizeCategory := true );
    
    range_cat := GeneralizedMorphismCategoryBySpans( category : FinalizeCategory := true );
    
    functor := CapFunctor( Concatenation( "Functor from cospans to spans on ", Name( category ) ), source_cat, range_cat );
    
    AddObjectFunction( functor, i -> GeneralizedMorphismBySpansObject( UnderlyingHonestObject( i ) ) );
    
    AddMorphismFunction( functor,
      function( new_source, morphism, new_range )
        
        return GeneralizedMorphismBySpanWithRangeAid( Arrow( morphism ), ReversedArrow( morphism ) );
        
    end );
    
    return functor;
    
end );

InstallMethod( FunctorFromSpansToThreeArrows,
               [ IsCapCategory ],
               
  function( category )
    local source_cat, range_cat, functor;
    
    source_cat := GeneralizedMorphismCategoryBySpans( category : FinalizeCategory := true );
    
    range_cat := GeneralizedMorphismCategoryByThreeArrows( category : FinalizeCategory := true );
    
    functor := CapFunctor( Concatenation( "Functor from spans to three arrows on ", Name( category ) ), source_cat, range_cat );
    
    AddObjectFunction( functor, i -> GeneralizedMorphismByThreeArrowsObject( UnderlyingHonestObject( i ) ) );
    
    AddMorphismFunction( functor,
      function( new_source, morphism, new_range )
        
        return GeneralizedMorphismByThreeArrowsWithSourceAid( ReversedArrow( morphism ), Arrow( morphism ) );
        
    end );
    
    return functor;
    
end );

InstallMethod( FunctorFromSpansToCospans,
               [ IsCapCategory ],
               
  function( category )
    local source_cat, range_cat, functor;
    
    source_cat := GeneralizedMorphismCategoryBySpans( category : FinalizeCategory := true );
    
    range_cat := GeneralizedMorphismCategoryByCospans( category : FinalizeCategory := true );
    
    functor := CapFunctor( Concatenation( "Functor from spans to cospans on ", Name( category ) ), source_cat, range_cat );
    
    AddObjectFunction( functor, i -> GeneralizedMorphismByCospansObject( UnderlyingHonestObject( i ) ) );
    
    AddMorphismFunction( functor,
      function( new_source, morphism, new_range )
        
        return GeneralizedMorphismByCospanWithSourceAid( ReversedArrow( morphism ), Arrow( morphism ) );
        
    end );
    
    return functor;
    
end );

InstallMethod( FunctorFromThreeArrowsToCospans,
               [ IsCapCategory ],
               
  function( category )
    local source_cat, range_cat, functor;
    
    source_cat := GeneralizedMorphismCategoryByThreeArrows( category : FinalizeCategory := true );
    
    range_cat := GeneralizedMorphismCategoryByCospans( category : FinalizeCategory := true );
    
    functor := CapFunctor( Concatenation( "Functor from three arrows to cospans on ", Name( category ) ), source_cat, range_cat );
    
    AddObjectFunction( functor, i -> GeneralizedMorphismByCospansObject( UnderlyingHonestObject( i ) ) );
    
    AddMorphismFunction( functor,
      function( new_source, morphism, new_range )
        
        return GeneralizedMorphismByCospan( SourceAid( morphism ), Arrow( morphism ), RangeAid( morphism ) );
        
    end );
    
    return functor;
    
end );

InstallMethod( FunctorFromThreeArrowsToSpans,
               [ IsCapCategory ],
               
  function( category )
    local source_cat, range_cat, functor;
    
    source_cat := GeneralizedMorphismCategoryByThreeArrows( category : FinalizeCategory := true );
    
    range_cat := GeneralizedMorphismCategoryBySpans( category : FinalizeCategory := true );
    
    functor := CapFunctor( Concatenation( "Functor from three arrows to cospans on ", Name( category ) ), source_cat, range_cat );
    
    AddObjectFunction( functor, i -> GeneralizedMorphismBySpansObject( UnderlyingHonestObject( i ) ) );
    
    AddMorphismFunction( functor,
      function( new_source, morphism, new_range )
        
        return GeneralizedMorphismBySpan( SourceAid( morphism ), Arrow( morphism ), RangeAid( morphism ) );
        
    end );
    
    return functor;
    
end );
