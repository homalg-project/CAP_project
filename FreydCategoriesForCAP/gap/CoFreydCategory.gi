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
  function( underlying_category )
    local cat;
    
    cat := CoFreydCategory_as_Opposite_FreydCategory_Opposite( underlying_category : FinalizeCategory := false );
    
    if ValueOption( "no_precompiled_code" ) <> true then
        
        ADD_FUNCTIONS_FOR_CoFreydCategory_as_Opposite_FreydCategory_Opposite_precompiled( cat );
        
    fi;
    
    Finalize( cat );
    
    return cat;
    
end );

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
InstallMethod( Display,
               [ IsCoFreydCategoryObject ],
               
  function( co_freyd_category_object )
    
    Print( Concatenation( "\n", "--------------------------------\n" ) );
    Print( "CoRelation morphism:\n" );
    Print( "--------------------------------\n\n" );
    Display( CoRelationMorphism( co_freyd_category_object ) );
    Print( Concatenation( "\n\n", "--------------------------------", "\n" ) );
    
    Print( "General description:\n" );
    Print( "--------------------------------\n\n" );
    Print( Concatenation( StringMutable( co_freyd_category_object ), "\n\n" ) );
    
end );

##
InstallMethod( Display,
               [ IsCoFreydCategoryMorphism ],
               
  function( co_freyd_category_morphism )
    
    Print( Concatenation( "\n", "--------------------------------\n" ) );
    Print( "Source:\n" );
    Print( "--------------------------------\n\n" );
    Display( CoRelationMorphism( Source( co_freyd_category_morphism ) ) );
    Print( Concatenation( "\n\n", "--------------------------------", "\n" ) );
    
    Print( "Morphism datum:\n" );
    Print( "--------------------------------\n\n" );
    Display( UnderlyingMorphism( co_freyd_category_morphism ) );
    Print( Concatenation( "\n\n", "--------------------------------", "\n" ) );
    
    Print( "Range:\n" );
    Print( "--------------------------------\n\n" );
    Display( CoRelationMorphism( Range( co_freyd_category_morphism ) ) );
    Print( Concatenation( "\n\n", "--------------------------------", "\n" ) );
    
    Print( "General description:\n" );
    Print( "--------------------------------\n\n" );
    Print( Concatenation( StringMutable( co_freyd_category_morphism ), "\n\n" ) );
    
end );
