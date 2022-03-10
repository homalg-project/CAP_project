# SPDX-License-Identifier: GPL-2.0-or-later
# GeneralizedMorphismsForCAP: Implementations of generalized morphisms for the CAP project
#
# Implementations
#

BindGlobal( "CAP_INTERNAL_FIND_CORRECT_GENERALIZED_CATEGORY_TYPE",
  
  function( category )
    
    if IsBound( category!.generalized_type ) then
        
        return category!.generalized_morphism_standard;
        
    else
        
        return CAP_INTERNAL!.generalized_morphism_standard;
        
    fi;
    
end );

InstallGlobalFunction( SwitchGeneralizedMorphismStandard,
  
  function( arg )
    local string, category;
    
    if Length( arg ) = 1 and IsString( arg[ 1 ] ) then
        
        category := CAP_INTERNAL;
        string := arg[ 1 ];
        
    elif Length( arg ) = 2 and IsString( arg[ 1 ] ) and IsCapCategory( arg[ 2 ] ) then
        
        category := arg[ 2 ];
        string := arg[ 1 ];
        
    elif Length( arg ) = 2 and IsString( arg[ 2 ] ) and IsCapCategory( arg[ 1 ] ) then
        
        category := arg[ 1 ];
        string := arg[ 2 ];
        
    else
        
        Error( "input must be a string or a category and a string" );
        return;
    fi;
    
    if not string in [ "threearrow", "cospan", "span" ] then
        
        Error( "string must be threearrow, cospan, or span" );
        return;
        
    fi;
    
    category!.generalized_morphism_standard := string;
    
end );

SwitchGeneralizedMorphismStandard( "threearrow" );

InstallValue( CAP_INTERNAL_GENERALIZED_MORPHISM_TRANSLATION_LIST, [
      [ "GeneralizedMorphismObject", "GeneralizedMorphismByThreeArrowsObject", "GeneralizedMorphismByCospansObject", "GeneralizedMorphismBySpansObject", [ IsCapCategoryObject ] ],
      [ "AsGeneralizedMorphism", "AsGeneralizedMorphismByThreeArrows", "AsGeneralizedMorphismByCospan", "AsGeneralizedMorphismBySpan", [ IsCapCategoryMorphism ] ],
      [ "GeneralizedMorphism", "GeneralizedMorphismByThreeArrows", "GeneralizedMorphismByCospan", "GeneralizedMorphismBySpan", [ IsCapCategoryMorphism, IsCapCategoryMorphism ] ],
      [ "GeneralizedMorphism", "GeneralizedMorphismByThreeArrows", "GeneralizedMorphismByCospan", "GeneralizedMorphismBySpan", [ IsCapCategoryMorphism, IsCapCategoryMorphism, IsCapCategoryMorphism ] ],
      [ "GeneralizedInverse", "GeneralizedInverseByThreeArrows", "GeneralizedInverseByCospan", "GeneralizedInverseBySpan", [ IsCapCategoryMorphism ] ],
      [ "GeneralizedMorphismFromFactorToSubobject", "GeneralizedMorphismFromFactorToSubobjectByThreeArrows", "GeneralizedMorphismFromFactorToSubobjectByCospan", "GeneralizedMorphismFromFactorToSubobjectBySpan", [ IsCapCategoryMorphism, IsCapCategoryMorphism ] ],
      [ "IdempotentDefinedBySubobject", "IdempotentDefinedBySubobjectByThreeArrows", "IdempotentDefinedBySubobjectByCospan", "IdempotentDefinedBySubobjectBySpan", [ IsCapCategoryMorphism ] ],
      [ "IdempotentDefinedByFactorobject", "IdempotentDefinedByFactorobjectByThreeArrows", "IdempotentDefinedByFactorobjectByCospan", "IdempotentDefinedByFactorobjectBySpan", [ IsCapCategoryMorphism ] ],
      [ "GeneralizedMorphismWithRangeAid", "GeneralizedMorphismByThreeArrowsWithRangeAid", "GeneralizedMorphismByCospan", "GeneralizedMorphismBySpanWithRangeAid", [ IsCapCategoryMorphism, IsCapCategoryMorphism ] ],
      [ "GeneralizedMorphismWithSourceAid", "GeneralizedMorphismByThreeArrowsWithSourceAid", "GeneralizedMorphismByCospanWithSourceAid", "GeneralizedMorphismBySpan", [ IsCapCategoryMorphism, IsCapCategoryMorphism ] ] ] );

InstallMethod( GeneralizedMorphismCategory,
               [ IsCapCategory ],
               
  function( category )
    local generalized_type;
    
    generalized_type := CAP_INTERNAL_FIND_CORRECT_GENERALIZED_CATEGORY_TYPE( category );
    
    if generalized_type = "threearrow" then
        
        return GeneralizedMorphismCategoryByThreeArrows( category );
        
    elif generalized_type = "cospan" then
        
        return GeneralizedMorphismCategoryByCospans( category );
        
    elif generalized_type = "span" then
        
        return GeneralizedMorphismCategoryBySpans( category );
        
    else
        
        Error( "generalized morphism type unrecognized" );
        
    fi;
    
end );

InstallMethod( SerreQuotientCategory,
               [ IsCapCategory, IsFunction ],
               
  function( category, func )
    local generalized_type;
    
    generalized_type := CAP_INTERNAL_FIND_CORRECT_GENERALIZED_CATEGORY_TYPE( category );
    
    if generalized_type = "threearrow" then
        
        return SerreQuotientCategoryByThreeArrows( category, func );
        
    elif generalized_type = "cospan" then
        
        return SerreQuotientCategoryByCospans( category, func );
        
    elif generalized_type = "span" then
        
        return SerreQuotientCategoryBySpans( category, func );
        
    else
        
        Error( "generalized morphism type unrecognized" );
        
    fi;
    
end );

BindGlobal( "CAP_INTERNAL_INSTALL_METHODS_FOR_GENERALIZED_MORPHISM_SWITCHER",
    
    function( )
    local method_for_switcher, current_method;
    
    method_for_switcher := function( three_arrow, cospan, span )
        
        return function( arg )
            local generalized_type;
            
            generalized_type := CAP_INTERNAL_FIND_CORRECT_GENERALIZED_CATEGORY_TYPE( CapCategory( arg[ 1 ] ) );
            
            if generalized_type = "threearrow" then
                
                return CallFuncList( three_arrow, arg );
                
            elif generalized_type = "cospan" then
                
                return CallFuncList( cospan, arg );
                
            elif generalized_type = "span" then
                
                return CallFuncList( span, arg );
                
            else
                
                Error( "generalized morphism type unrecognized" );
                
            fi;
            
        end;
        
    end;
    
    for current_method in CAP_INTERNAL_GENERALIZED_MORPHISM_TRANSLATION_LIST do
        
        InstallMethod( ValueGlobal( current_method[ 1 ] ),
                       current_method[ 5 ],
                       method_for_switcher( ValueGlobal( current_method[ 2 ] ), ValueGlobal( current_method[ 3 ] ), ValueGlobal( current_method[ 4 ] ) ) );
                       
    od;
    
end );

CAP_INTERNAL_INSTALL_METHODS_FOR_GENERALIZED_MORPHISM_SWITCHER();

InstallGlobalFunction( "SwitchGeneralizedMorphismStandardHARDCODE",
  
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
    
    for i in CAP_INTERNAL_GENERALIZED_MORPHISM_TRANSLATION_LIST do
        
        if IsBoundGlobal( i[ 1 ] ) then
            MakeReadWriteGlobal( i[ 1 ] );
            UnbindGlobal( i[ 1 ] );
        fi;
        
        if IsBound( i[ type ] ) then
            BindGlobal( i[ 1 ], ValueGlobal( i[ type ] ) );
        fi;
        
    od;
    
end );
