############################################################################
##
##                                ActionsForCAP package
##
##  Copyright 2016, Sebastian Gutsche, University of Siegen
##                  Sebastian Posur,   University of Siegen
##
##
#############################################################################

####################################
##
## GAP Category
##
####################################

DeclareRepresentation( "IsSemisimpleCategoryMorphismRep",
                       IsSemisimpleCategoryMorphism and IsAttributeStoringRep,
                       [ ] );

BindGlobal( "TheFamilyOfSemisimpleCategoryMorphisms",
        NewFamily( "TheFamilyOfSemisimpleCategoryMorphisms" ) );

BindGlobal( "TheTypeOfSemisimpleCategoryMorphisms",
        NewType( TheFamilyOfSemisimpleCategoryMorphisms,
                IsSemisimpleCategoryMorphismRep ) );

####################################
##
## Constructors
##
####################################

##
InstallMethod( SemisimpleCategoryMorphism,
               [ IsSemisimpleCategoryObject, IsList, IsSemisimpleCategoryObject ],
               
  function( source, morphism_list, range )
    local category, semisimple_category_morphism, sort_function, field;
    
    category := CapCategory( source );
    
    morphism_list := Filtered( morphism_list,
                       alpha -> NrRows( UnderlyingMatrix( alpha[1] ) ) <> 0 or NrColumns( UnderlyingMatrix( alpha[1] ) ) <> 0 );
    
    sort_function := function( a, b ) return a[2] <= b[2]; end;
    
    Sort( morphism_list, sort_function );
    
    field := UnderlyingCategoryForSemisimpleCategory( category )!.field_for_matrix_category;
    
    semisimple_category_morphism := rec( );
    
    ObjectifyWithAttributes( semisimple_category_morphism, TheTypeOfSemisimpleCategoryMorphisms,
                             Source, source,
                             Range, range,
                             SemisimpleCategoryMorphismList, morphism_list,
                             UnderlyingFieldForHomalg, field
    );

    Add( category, semisimple_category_morphism );
    
    return semisimple_category_morphism;
    
end );

####################################
##
## Attributes
##
####################################

##
InstallMethod( Support,
               [ IsSemisimpleCategoryMorphism ],
               
  function( morphism )
    
    return List( SemisimpleCategoryMorphismList( morphism ), elem -> elem[2] );
    
end );

####################################
##
## Operations
##
####################################

##
InstallMethod( Component,
               [ IsSemisimpleCategoryMorphism, IsObject ],
               
  function( morphism, irr )
    local coeff;
    
    coeff := First( SemisimpleCategoryMorphismList( morphism ), elem -> elem[2] = irr );
    
    if coeff = fail then
        
        return IdentityMorphism( ZeroObject( UnderlyingCategoryForSemisimpleCategory( CapCategory( morphism ) ) ) );
        
    else
        
        return coeff[1];
        
    fi;
    
end );

####################################
##
## View
##
####################################

##
InstallMethod( Display,
               [ IsSemisimpleCategoryMorphism ],
               
  function( morphism )
    local morphism_list, elem;
    
    morphism_list := SemisimpleCategoryMorphismList( morphism );
    
    for elem in morphism_list do
        
        Print( Concatenation( "Component: (χ_", String( elem[2] ), ")\n" ) );
        
        Print( "\n" );
        
        Display( elem[1] );
        
        Print( "\n------------------------\n" );
        
    od;
    
end );

