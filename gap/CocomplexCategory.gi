#############################################################################
##
##                                               CategoriesForHomalg package
##
##  Copyright 2014, Sebastian Gutsche, TU Kaiserslautern
##                  Sebastian Posur,   RWTH Aachen
##
##
#############################################################################

DeclareRepresentation( "IsHomalgCocomplexRep",
                       IsHomalgCocomplex and IsAttributeStoringRep and IsHomalgCategoryObjectRep,
                       [ ] );

DeclareRepresentation( "IsHomalgCochainMorphismRep",
                       IsHomalgChainMorphism and IsAttributeStoringRep and IsHomalgCategoryMorphismRep,
                       [ ] );

BindGlobal( "TheTypeOfHomalgCocomplexes",
        NewType( TheFamilyOfHomalgCategoryObjects,
                IsHomalgCocomplexRep ) );

BindGlobal( "TheTypeOfHomalgCategoryProductMorphisms",
        NewType( TheFamilyOfHomalgCategoryMorphisms,
                IsHomalgCochainMorphismRep ) );

#################################################
##
## Constructors
##
#################################################



