

BindGlobal( "SwitchGeneralizedMorphismStandard",
  
  function( type )
    local generalized_morphism_translation_list, i;
    
    if IsString( type ) then
        if LowercaseString( type ) = "threearrow" then
            type := 2;
        elif LowercaseString( type ) = "cospan" then
            type := 3;
        elif LowercaseString( type ) = "span" then
            type := 4;
        fi;
    fi;
    
    if not IsInt( type ) or not type in [ 2, 3, 4 ] then
        Error( "input must be threearrow, cospan, or span" );
    fi;
    
    generalized_morphism_translation_list := [
      [ "GeneralizedMorphismCategory", "GeneralizedMorphismCategoryByThreeArrows", "GeneralizedMorphismCategoryByCospans", "GeneralizedMorphismCategoryBySpans" ],
      [ "GeneralizedMorphism", "GeneralizedMorphismByThreeArrows", "GeneralizedMorphismByCospan", "GeneralizedMorphismBySpan" ],
      [ "GeneralizedMorphismObject", "GeneralizedMorphismByThreeArrowsObject", "GeneralizedMorphismByCospansObject", "GeneralizedMorphismBySpansObject" ],
      [ "AsGeneralizedMorphism", "AsGeneralizedMorphismByThreeArrows", "AsGeneralizedMorphismByCospan", "AsGeneralizedMorphismBySpan" ],
      [ "GeneralizedInverse", "GeneralizedInverseByThreeArrows", "GeneralizedInverseByCospan", "GeneralizedInverseBySpan" ],
      [ "GeneralizedMorphismFromFactorToSubobject", "GeneralizedMorphismFromFactorToSubobjectByThreeArrows", "GeneralizedMorphismFromFactorToSubobjectByCospan", "GeneralizedMorphismFromFactorToSubobjectBySpan" ],
      [ "IdempotentDefinedBySubobject", "IdempotentDefinedBySubobjectByThreeArrows", "IdempotentDefinedBySubobjectByCospan", "IdempotentDefinedBySubobjectBySpan" ],
      [ "IdempotentDefinedByFactorobject", "IdempotentDefinedByFactorobjectByThreeArrows", "IdempotentDefinedByFactorobjectByCospan", "IdempotentDefinedByFactorobjectBySpan" ],
      [ "GeneralizedMorphismWithRangeAid", "GeneralizedMorphismByThreeArrowsWithRangeAid", "GeneralizedMorphismByCospan", "GeneralizedMorphismBySpanWithRangeAid" ],
      [ "GeneralizedMorphismWithSourceAid", "GeneralizedMorphismByThreeArrowsWithSourceAid", "GeneralizedMorphismByCospanWithSourceAid", "GeneralizedMorphismBySpan" ],
      # Serre Quotient
      [ "AsSerreQuotientObject", "AsSerreQuotientByThreeArrowsObject" ],
      [ "SerreQuotientCategory", "SerreQuotientCategoryByThreeArrows" ],
      [ "SerreQuotientCategoryMorphism", "SerreQuotientCategoryByThreeArrowsMorphism" ],
      [ "AsSerreQuotientCategoryMorphism", "AsSerreQuotientCategoryByThreeArrowsMorphism" ] ];
    
    for i in generalized_morphism_translation_list do
        
        if IsBoundGlobal( i[ 1 ] ) then
            MakeReadWriteGlobal( i[ 1 ] );
            UnbindGlobal( i[ 1 ] );
        fi;
        
        if IsBound( i[ type ] ) then
            BindGlobal( i[ 1 ], ValueGlobal( i[ type ] ) );
        fi;
        
    od;
    
end );

SwitchGeneralizedMorphismStandard( "threearrow" );