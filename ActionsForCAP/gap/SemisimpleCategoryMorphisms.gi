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
    local category, semisimple_category_morphism, sort_function;
    
    category := CapCategory( source );
    
    morphism_list := Filtered( morphism_list,
                       alpha -> NrRows( UnderlyingMatrix( alpha[1] ) ) <> 0 or NrColumns( UnderlyingMatrix( alpha[1] ) ) <> 0 );
    
    sort_function := function( a, b ) return a[2] <= b[2]; end;
    
    Sort( morphism_list, sort_function );
    
    semisimple_category_morphism := rec( );
    
    ObjectifyWithAttributes( semisimple_category_morphism, TheTypeOfSemisimpleCategoryMorphisms,
                             Source, source,
                             Range, range,
                             SemisimpleCategoryMorphismList, morphism_list
    );

    Add( category, semisimple_category_morphism );
    
    return semisimple_category_morphism;
    
end );

####################################
##
## Constructors
##
####################################

##
InstallMethod( Support,
               [ IsSemisimpleCategoryMorphism ],
               
  function( morphism )
    
    return List( SemisimpleCategoryMorphismList( morphism ), elem -> elem[2] );
    
end );

