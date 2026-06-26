# SPDX-License-Identifier: GPL-2.0-or-later
# FreydCategoriesForCAP: Freyd categories - Formal (co)kernels for additive categories
#
# Implementations
#

# read precompiled categories
ReadPackage( "FreydCategoriesForCAP", "gap/precompiled_categories/CoFreydCategory_as_Opposite_FreydCategory_Opposite_precompiled.gi" );

####################################
##
## Constructors
##
####################################

##
InstallGlobalFunction( CO_FREYD_CATEGORY,
  FunctionWithNamedArguments(
  [
    [ "FinalizeCategory", true ],
  ],
  function( CAP_NAMED_ARGUMENTS, underlying_category )
    local cat;
    
    cat := CoFreydCategory_as_Opposite_FreydCategory_Opposite( underlying_category : FinalizeCategory := false );
    
    if ValueOption( "no_precompiled_code" ) <> true then
        
        ADD_FUNCTIONS_FOR_CoFreydCategory_as_Opposite_FreydCategory_Opposite_precompiled( cat );
        
    fi;
    
    if CAP_NAMED_ARGUMENTS.FinalizeCategory then
        
        Finalize( cat );
        
    fi;
    
    return cat;
    
end ) );

##
InstallMethod( CoFreydCategory,
               [ IsCapCategory ],
    CO_FREYD_CATEGORY
);

##
InstallMethod( AsCoFreydCategoryObject,
               [ IsCapCategoryObject ],
               
  function( object )
    
    return AsCoFreydCategoryObject( CoFreydCategory( CapCategory( object ) ), object );
    
end );

##
InstallOtherMethodForCompilerForCAP( AsCoFreydCategoryObject,
                                     [ IsCoFreydCategory, IsCapCategoryObject ],
                                     
  function( cat, object )
    local injective_object;
    
    injective_object := CoFreydCategoryObject( cat, UniversalMorphismIntoZeroObject( UnderlyingCategory( cat ), object ) );
    
    # CompilerForCAP cannot handle side effects
    #% CAP_JIT_DROP_NEXT_STATEMENT
    SetIsInjective( injective_object, true );
    
    return injective_object;
    
end );

##
InstallMethod( CoFreydCategoryObject,
               [ IsCapCategoryMorphism ],
               
  function( co_relation_morphism )
    
    return CoFreydCategoryObject( CoFreydCategory( CapCategory( co_relation_morphism ) ), co_relation_morphism );
    
end );

##
InstallOtherMethodForCompilerForCAP( CoFreydCategoryObject,
                                     [ IsCoFreydCategory, IsCapCategoryMorphism ],
                                     
  function( cat, co_relation_morphism )
    
    return ObjectConstructor( cat, co_relation_morphism );
    
end );

##
InstallMethod( AsCoFreydCategoryMorphism,
               [ IsCapCategoryMorphism ],
               
  function( morphism )
    
    return AsCoFreydCategoryMorphism( CoFreydCategory( CapCategory( morphism ) ), morphism );
    
end );

##
InstallOtherMethodForCompilerForCAP( AsCoFreydCategoryMorphism,
                                     [ IsCoFreydCategory, IsCapCategoryMorphism ],
                                     
  function( cat, morphism )
    
    return CoFreydCategoryMorphism( cat,
             AsCoFreydCategoryObject( cat, Source( morphism ) ),
             morphism,
             AsCoFreydCategoryObject( cat, Range( morphism ) )
           );
    
end );

##
InstallMethod( CoFreydCategoryMorphism,
               [ IsCoFreydCategoryObject, IsCapCategoryMorphism, IsCoFreydCategoryObject ],
               
  function( source, morphism_datum, range )
    
    return CoFreydCategoryMorphism( CapCategory( source ), source, morphism_datum, range );
    
end );

##
InstallOtherMethodForCompilerForCAP( CoFreydCategoryMorphism,
                                     [ IsCoFreydCategory, IsCoFreydCategoryObject, IsCapCategoryMorphism, IsCoFreydCategoryObject ],
                                     
  function( cat, source, morphism_datum, range )
    
    return MorphismConstructor( cat, source, morphism_datum, range );
    
end );

####################################
##
## View
##
####################################

##
InstallMethod( DisplayString,
        [ IsCoFreydCategoryMorphism ],
        
  function( phi )
    local sep;
    
    sep := "--------------------------------\n";
    
    return Concatenation(
        "\n", sep,
        "Source:\n", sep, "\n",
        DisplayString( CoRelationMorphism( Source( phi ) ) ),
        "\n\n", sep,
        "Morphism datum:\n", sep, "\n",
        DisplayString( UnderlyingMorphism( phi ) ),
        "\n\n", sep,
        "Range:\n", sep, "\n",
        DisplayString( CoRelationMorphism( Range( phi ) ) ),
        "\n\n", sep,
        "General description:\n", sep, "\n",
        StringMutable( phi ), "\n\n" );
    
end );

##
InstallMethod( DisplayString,
        [ IsCoFreydCategoryObject ],
        
  function( a )
    local sep;
    
    sep := "--------------------------------\n";
    
    return Concatenation(
        "\n", sep,
        "CoRelation morphism:\n", sep, "\n",
        DisplayString( CoRelationMorphism( a ) ),
        "\n\n", sep,
        "General description:\n", sep, "\n",
        StringMutable( a ), "\n\n" );
    
end );
