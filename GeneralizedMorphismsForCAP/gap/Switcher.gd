

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
      [ "GeneralizedMorphismCategory", "GeneralizedMorphismCategoryByThreeArrows", "GeneralizedMorphismCategoryByCospans" ],
      [ "GeneralizedMorphism", "GeneralizedMorphismByThreeArrows", "GeneralizedMorphismByCospan" ],
      [ "GeneralizedMorphismObject", "GeneralizedMorphismByThreeArrowsObject", "GeneralizedMorphismByCospansObject" ],
      [ "AsGeneralizedMorphism", "AsGeneralizedMorphismByThreeArrows", "AsGeneralizedMorphismByCospan" ],
      [ "GeneralizedInverse", "GeneralizedInverseByThreeArrows", "GeneralizedInverseByCospan" ],
      [ "GeneralizedMorphismFromFactorToSubobject", "GeneralizedMorphismFromFactorToSubobjectByThreeArrows", "GeneralizedMorphismFromFactorToSubobjectByCospan" ],
      [ "IdempotentDefinedBySubobject", "IdempotentDefinedBySubobjectByThreeArrows", "IdempotentDefinedBySubobjectByCospan" ],
      [ "IdempotentDefinedByFactorobject", "IdempotentDefinedByFactorobjectByThreeArrows", "IdempotentDefinedByFactorobjectByCospan" ],
      [ "GeneralizedMorphismWithRangeAid", "GeneralizedMorphismByThreeArrowsWithRangeAid", "GeneralizedMorphismByCospan" ],
      [ "GeneralizedMorphismWithSourceAid", "GeneralizedMorphismByThreeArrowsWithSourceAid", "GeneralizedMorphismByCospanWithSourceAid" ],
      # Serre Quotient
      [ "AsSerreQuotientObject", "AsSerreQuotientByThreeArrowsObject", "AsSerreQuotientByThreeArrowsObject" ],
      [ "SerreQuotientCategory", "SerreQuotientCategoryByThreeArrows", "AsSerreQuotientByThreeArrowsObject" ],
      [ "SerreQuotientCategoryMorphism", "SerreQuotientCategoryByThreeArrowsMorphism", "AsSerreQuotientByThreeArrowsObject" ],
      [ "AsSerreQuotientCategoryMorphism", "AsSerreQuotientCategoryByThreeArrowsMorphism", "AsSerreQuotientByThreeArrowsObject" ] ];
    
    for i in generalized_morphism_translation_list do
        
        if IsBoundGlobal( i[ 1 ] ) then
            MakeReadWriteGlobal( i[ 1 ] );
            UnbindGlobal( i[ 1 ] );
        fi;
        
        BindGlobal( i[ 1 ], ValueGlobal( i[ type ] ) );
        
    od;
    
end );

SwitchGeneralizedMorphismStandard( "threearrow" );