

BindGlobal( "SwitchGeneralizedMorphismStandard",
  
  function( type )
    local generalized_morphism_translation_list;
    
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
      [ "GeneralizedMorphismObject", "GeneralizedMorphismByThreeArrowsObject", "GeneralizedMorphismByCospanObject" ],
      [ "GeneralizedInverse", "GeneralizedInverseByThreeArrows", "GeneralizedInverseByCospan" ],
      [ "MorphismFromFactorToSubobject", "MorphismFromFactorToSubobjectByThreeArrows", "MorphismFromFactorToSubobjectByCospan" ],
      [ "IdempotentDefinedBySubobject", "IdempotentDefinedBySubobjectByThreeArrows", "IdempotentDefinedBySubobjectByCospan" ] ];
    
    for i in generalized_morphism_translation_list do
        
        if IsBoundGlobal( i[ 1 ] ) then
            UnbindGlobal( i[ 1 ] );
        fi;
        
        BindGlobal( i[ 1 ], ValueGlobal( i[ type ] ) );
        
    od;
    
end );

SwitchGeneralizedMorphismStandard( "cospan" );