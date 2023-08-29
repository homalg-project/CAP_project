LoadPackage( "CAP" );

## Declaration

###################################
##
## Categories
##
###################################

DeclareCategory( "IsCategoryOfSchemes",
                 IsCapCategory );

DeclareCategory( "IsScheme",
                 IsCapCategoryObject );

DeclareCategory( "IsSchemeMorphism",
                 IsCapCategoryMorphism );

#######################################
##
## Global Functions, Variables
##
#######################################

DeclareGlobalFunction( "SCHEMES_INSTALL_TODO_LIST_FOR_MORPHISM" );

DeclareGlobalVariable( "MORPHISM_LOGIC_LIST" );

#######################################
##
## Properties of Morphisms
##
#######################################

DeclareProperty( "IsOpenImmersion",
                 IsSchemeMorphism );

DeclareProperty( "IsQuasiCompactImmersion",
                 IsSchemeMorphism );

DeclareProperty( "IsUniversalHomeomorphism",
                 IsSchemeMorphism );

DeclareProperty( "IsOfFiniteType",
                 IsSchemeMorphism );

DeclareProperty( "IsPurelyInseparable",
                 IsSchemeMorphism );

DeclareProperty( "IsFinite",
                 IsSchemeMorphism );

DeclareProperty( "IsSurjective",
                 IsSchemeMorphism );

DeclareProperty( "IsClosedImmersion",
                 IsSchemeMorphism );

DeclareProperty( "IsFaithfullyFlat",
                 IsSchemeMorphism );

DeclareProperty( "IsQuasiCompact",
                 IsSchemeMorphism );

DeclareProperty( "IsEtale",
                 IsSchemeMorphism );

DeclareProperty( "IsQuasiAffine",
                 IsSchemeMorphism );

DeclareProperty( "IsProper",
                 IsSchemeMorphism );

DeclareProperty( "IsUniversallySubmersive",
                 IsSchemeMorphism );

DeclareProperty( "IsSmooth",
                 IsSchemeMorphism );

DeclareProperty( "IsImmersion",
                 IsSchemeMorphism );

DeclareProperty( "IsIntegral",
                 IsSchemeMorphism );

DeclareProperty( "IsAffine",
                 IsSchemeMorphism );

DeclareProperty( "IsUniversallyClosed",
                 IsSchemeMorphism );

DeclareProperty( "IsQuasiFinite",
                 IsSchemeMorphism );

DeclareProperty( "IsSeparated",
                 IsSchemeMorphism );

DeclareProperty( "IsProjective",
                 IsSchemeMorphism );

DeclareProperty( "IsImmersion",
                 IsSchemeMorphism );

DeclareProperty( "IsFlat",
                 IsSchemeMorphism );

DeclareProperty( "IsLocallyOfFinitePresentation",
                 IsSchemeMorphism );

DeclareProperty( "IsQuasiProjective",
                 IsSchemeMorphism );

DeclareProperty( "IsOfFinitePresentation",
                 IsSchemeMorphism );

DeclareProperty( "IsUniversallyOpen",
                 IsSchemeMorphism );

DeclareProperty( "IsImmersion",
                 IsSchemeMorphism );

#######################################
##
## Properties of Schemes
##
#######################################

DeclareProperty( "IsNoetherian",
                 IsScheme );

DeclareProperty( "IsQuasiCompact",
                 IsScheme );

DeclareProperty( "IsQuasiSeparated",
                 IsSchemeMorphism );


#######################################
##
## Logic
##
#######################################

# InstallTrueMethod( IsOpenImmersion, IsSchemeMorphism and IsIsomorphism );

# InstallImmediateMethod( IsQuasiCompactImmersion,
#                         IsSchemeMorphism and IsOpenImmersion,
#                         0,
#                         
#   function( alpha )
#   
#     if HasIsNoetherian( Source( alpha ) ) and IsNoetherian( Source( alpha ) ) then
#       
#       return true;
#       
#     fi;
#     
#     TryNextMethod( );
#   
# end );

#######################################
##
## Constructors
##
#######################################

DeclareOperation( "Scheme",
                  [ IsCategoryOfSchemes ] );

DeclareOperation( "SchemeMorphism",
                  [ IsCategoryOfSchemes, IsScheme, IsScheme ] );

#######################################
##
## Initialisation
##
#######################################

InstallValue( MORPHISM_LOGIC_LIST,
  [ 
    
    # equivalences
    
    # IsUniversalHomeomorphism and IsOfFiniteType <=> IsPurelyInseparable and IsFinite and IsSurjective
    [ [ "IsUniversalHomeomorphism", "IsOfFiniteType" ], "IsPurelyInseparable" ],
    
    [ [ "IsUniversalHomeomorphism", "IsOfFiniteType" ], "IsFinite" ],
    
    [ [ "IsUniversalHomeomorphism", "IsOfFiniteType" ], "IsSurjective" ],
    
    [ [ "IsPurelyInseparable", "IsFinite", "IsSurjective" ], "IsUniversalHomeomorphism" ],
    
    [ [ "IsPurelyInseparable", "IsFinite", "IsSurjective" ], "IsOfFiniteType" ],
    
    # IsClosedImmersion <=> IsProper and IsMonomorphism
    
    [ [ "IsClosedImmersion" ], "IsProper" ],
    
    [ [ "IsClosedImmersion" ], "IsMonomorphism" ],
    
    [ [ "IsProper", "IsMonomorphism" ], "IsClosedImmersion" ],
    
    # Finite <=> Quasi-affine and property
    
    [ [ "IsFinite" ], "IsQuasiAffine" ],
    
    [ [ "IsFinite" ], "IsProper" ],
    
    [ [ "IsQuasiAffine", "IsProper" ], "IsFinite" ],
    
    # IsIntegral <=> IsAffine and IsUniversallyClosed
    
    [ [ "IsIntegral" ], "IsAffine" ],
    
    [ [ "IsIntegral" ], "IsUniversallyClosed" ],
    
    [ [ "IsUniversallyClosed", "IsAffine" ], "IsIntegral" ],
    
    # implications
    
    #1
    
    [ [ "IsIsomorphism" ], "IsOpenImmersion" ],
    
    [ [ "IsIsomorphism" ], "IsUniversalHomeomorphism" ],
    
    [ [ "IsIsomorphism" ], "IsOfFiniteType" ],
    
    [ [ "IsIsomorphism" ], "IsClosedImmersion" ],
        
    [ [ "IsIsomorphism" ], "IsFaithfullyFlat" ],
    
    [ [ "IsIsomorphism" ], "IsQuasiCompact" ],
    
    #2
    
    [ [ "IsOpenImmersion" ], "IsEtale" ],
    
    [ [ "IsOpenImmersion" ], "IsImmersion" ],
    
    [ [ "IsUniversalHomeomorphism", "IsOfFiniteType" ], "IsFinite" ],
    
    [ [ "IsClosedImmersion" ], "IsQuasiCompactImmersion" ],
    
    [ [ "IsClosedImmersion" ], "IsFinite" ],
    
    #3
    
    [ [ "IsFaithfullyFlat", "IsQuasiCompact" ], "IsUniversallySubmersive" ],
    
    [ [ "IsEtale" ], "IsSmooth" ],
    
    [ [ "IsUniversalHomeomorphism" ], "IsUniversallySubmersive" ],
    
    [ [ "IsUniversalHomeomorphism" ], "IsUniversallyOpen" ],
    
    [ [ "IsUniversalHomeomorphism" ], "IsPurelyInseparable" ],
    
    [ [ "IsUniversalHomeomorphism" ], "IsIntegral" ],
    
    [ [ "IsQuasiCompactImmersion" ], "IsImmersion" ],
    
    [ [ "IsQuasiCompactImmersion" ], "IsQuasiFinite" ],
    
    [ [ "IsQuasiCompactImmersion" ], "IsSeparated" ],
    
    [ [ "IsQuasiCompactImmersion" ], "IsQuasiFinite" ],
    
    [ [ "IsQuasiCompactImmersion" ], "IsSeparated" ],
    
    [ [ "IsFinite" ], "IsIntegral" ],
    
    [ [ "IsFinite" ], "IsQuasiFinite" ],
    
    [ [ "IsFinite" ], "IsSeparated" ],
    
    [ [ "IsFinite" ], "IsProjective" ],
    
    #4
    
    [ [ "IsFaithfullyFlat" ], "IsSurjective" ],
    
    [ [ "IsFaithfullyFlat" ], "IsFlat" ],
    
    [ [ "IsUniversallySubmersive" ], "IsSurjective" ],
    
    [ [ "IsSmooth" ], "IsFlat" ],
    
    [ [ "IsSmooth" ], "IsLocallyOfFinitePresentation" ],
    
    [ [ "IsImmersion" ], "IsMonomorphism" ],
    
    [ [ "IsIntegral" ], "IsAffine" ],
    
    [ [ "IsIntegral" ], "IsUniversallyClosed" ],
    
    [ [ "IsQuasiFinite", "IsSeparated" ], "IsQuasiAffine" ],
    
    [ [ "IsQuasiFinite", "IsSeparated" ], "IsOfFiniteType" ],
    
    [ [ "IsProjective" ], "IsProper" ],
    
    [ [ "IsProjective" ], "IsQuasiProjective" ],
    
    #5
    
    [ [ "IsFlat", "IsLocallyOfFinitePresentation" ], "IsUniversallyOpen" ],
    
    [ [ "IsMonomorphism" ], "IsPurelyInseparable" ],
    
    [ [ "IsAffine" ], "IsQuasiAffine" ],
    
    [ [ "IsQuasiAffine", "IsOfFiniteType" ], "IsQuasiProjective" ],
    
    #6
    
    [ [ "IsPurelyInseparable" ], "IsSeparated" ],
    
    [ [ "IsQuasiAffine" ], "IsSeparated" ],
    
    [ [ "IsQuasiAffine" ], "IsQuasiCompact" ],
    
    [ [ "IsProper" ], "IsSeparated" ],
    
    [ [ "IsProper" ], "IsQuasiCompact" ],
    
    [ [ "IsProper" ], "IsUniversallyClosed" ],
    
    [ [ "IsProper" ], "IsOfFiniteType" ],
    
    [ [ "IsQuasiProjective" ], "IsSeparated" ],
    
    [ [ "IsQuasiProjective" ], "IsQuasiCompact" ],
    
    [ [ "IsQuasiProjective" ], "IsOfFiniteType" ],
    
    [ [ "IsOfFinitePresentation" ], "IsOfFiniteType" ],
    
    [ [ "IsOfFinitePresentation" ], "IsQuasiCompact" ],
    
    [ [ "IsOfFinitePresentation" ], "IsQuasiSeparated" ],
    
    #7
    
    [ [ "IsSeparated", "IsQuasiCompact" ], "IsQuasiSeparated" ],
    
    [ [ "IsOfFiniteType" ], "IsQuasiCompact" ],
    
    #8
    
    [ [ "IsSeparated" ], "IsQuasiSeparated" ]
    
  ] );  

## Implementation

InstallGlobalFunction( SCHEMES_INSTALL_TODO_LIST_FOR_MORPHISM,

  function( scheme_morphism )
    local list_of_implications, implication, entry;
    
    list_of_implications := MORPHISM_LOGIC_LIST;
  
    for implication in list_of_implications do
    
      entry := ToDoListEntry( List( implication[1], property -> [ scheme_morphism, property , true ] ), scheme_morphism, implication[2], true );
      ## Example:
      ## entry := ToDoListEntry( [ [ scheme_morphism, "IsSeparated", true ], [ scheme_morphism, "IsQuasiCompact", true ] ], scheme_morphism, "IsQuasiSeparated", true );
      
      SetDescriptionOfImplication( entry, Concatenation( implication[1], "=>", implication[2] ) );
        
      AddToToDoList( entry );
    
    od;
    
    entry := ToDoListEntry( [ [ scheme_morphism, "IsOpenImmersion", true ], [ Source( scheme_morphism ), "IsNoetherian", true ] ], scheme_morphism, "IsQuasiCompactImmersion", true );
        
    SetDescriptionOfImplication( entry, "IsOpenImmersion and IsNoetherian( Source( mor ) ) => IsQuasiCompactImmersion" );
        
    AddToToDoList( entry );
    
end );

#######################################
##
## Constructors
##
#######################################

InstallMethod( Scheme,
               [ IsCategoryOfSchemes ],

  function( cat )
    
    return CreateCapCategoryObjectWithAttributes( cat );
    
end );

# InstallTrueMethod( IsOpenImmersion, IsSchemeMorphism and IsIsomorphism );

InstallMethod( SchemeMorphism,
               [ IsCategoryOfSchemes, IsScheme, IsScheme ],

  function( cat, source, range )
    local scheme_morphism, entry, entry2;
    
    scheme_morphism := CreateCapCategoryMorphismWithAttributes( cat,
                                                                Source, source,
                                                                Range, range );
    
    SCHEMES_INSTALL_TODO_LIST_FOR_MORPHISM( scheme_morphism );
    
    return scheme_morphism;
  
end );

#######################################
##
## Test Area
##
#######################################

category_of_schemes := CreateCapCategory( "Schemes",
                                          IsCategoryOfSchemes,
                                          IsScheme,
                                          IsSchemeMorphism,
                                          IsCapCategoryTwoCell );

A := Scheme( category_of_schemes );

B := Scheme( category_of_schemes );

alpha := SchemeMorphism( category_of_schemes, A, B );

