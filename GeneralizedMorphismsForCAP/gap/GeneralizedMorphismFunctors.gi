#############################################################################
##
##                  GeneralizedMorphismsForCAP package
##
##  Copyright 2015, Sebastian Gutsche, TU Kaiserslautern
##                  Sebastian Posur,   RWTH Aachen
##
## @Chapter Conversion functors for generalized morphisms
##
#############################################################################

InstallMethod( FunctorFromCospansToThreeArrows,
               [ IsCapCategory ],
               
  function( category )
    local source_cat, range_cat, functor;
    
    source_cat := GeneralizedMorphismCategoryByCospans( category );
    
    range_cat := GeneralizedMorphismCategoryByThreeArrows( category );
    
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
    
    source_cat := GeneralizedMorphismCategoryByCospans( category );
    
    range_cat := GeneralizedMorphismCategoryBySpans( category );
    
    functor := CapFunctor( Concatenation( "Functor from cospans to spans on ", Name( category ) ), source_cat, range_cat );
    
    AddObjectFunction( functor, i -> GeneralizedMorphismBySpansObject( UnderlyingHonestObject( i ) ) );
    
    AddMorphismFunction( functor,
      function( new_source, morphism, new_range )
        
        return GeneralizedMorphismBySpansWithRangeAid( Arrow( morphism ), ReversedArrow( morphism ) );
        
    end );
    
    return functor;
    
end );

InstallMethod( FunctorFromSpansToThreeArrows,
               [ IsCapCategory ],
               
  function( category )
    local source_cat, range_cat, functor;
    
    source_cat := GeneralizedMorphismCategoryBySpans( category );
    
    range_cat := GeneralizedMorphismCategoryByThreeArrows( category );
    
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
    
    source_cat := GeneralizedMorphismCategoryBySpans( category );
    
    range_cat := GeneralizedMorphismCategoryByCospans( category );
    
    functor := CapFunctor( Concatenation( "Functor from spans to cospans on ", Name( category ) ), source_cat, range_cat );
    
    AddObjectFunction( functor, i -> GeneralizedMorphismByCospansObject( UnderlyingHonestObject( i ) ) );
    
    AddMorphismFunction( functor,
      function( new_source, morphism, new_range )
        
        return GeneralizedMorphismByCospansWithSourceAid( ReversedArrow( morphism ), Arrow( morphism ) );
        
    end );
    
    return functor;
    
end );

InstallMethod( FunctorFromThreeArrowsToCospans,
               [ IsCapCategory ],
               
  function( category )
    local source_cat, range_cat, functor;
    
    source_cat := GeneralizedMorphismCategoryByThreeArrows( category );
    
    range_cat := GeneralizedMorphismCategoryByCospans( category );
    
    functor := CapFunctor( Concatenation( "Functor from three arrows to cospans on ", Name( category ) ), source_cat, range_cat );
    
    AddObjectFunction( functor, i -> GeneralizedMorphismByCospansObject( UnderlyingHonestObject( i ) ) );
    
    AddMorphismFunction( functor,
      function( new_source, morphism, new_range )
        
        return GeneralizedMorphismByCospans( SourceAid( morphism ), MorphismAid( morphism ), RangeAid( morphism ) );
        
    end );
    
    return functor;
    
end );

InstallMethod( FunctorFromThreeArrowsToSpans,
               [ IsCapCategory ],
               
  function( category )
    local source_cat, range_cat, functor;
    
    source_cat := GeneralizedMorphismCategoryByThreeArrows( category );
    
    range_cat := GeneralizedMorphismCategoryBySpans( category );
    
    functor := CapFunctor( Concatenation( "Functor from three arrows to cospans on ", Name( category ) ), source_cat, range_cat );
    
    AddObjectFunction( functor, i -> GeneralizedMorphismBySpanObject( UnderlyingHonestObject( i ) ) );
    
    AddMorphismFunction( functor,
      function( new_source, morphism, new_range )
        
        return GeneralizedMorphismBySpan( SourceAid( morphism ), MorphismAid( morphism ), RangeAid( morphism ) );
        
    end );
    
    return functor;
    
end );