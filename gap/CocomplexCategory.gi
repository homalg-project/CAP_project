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
                       IsAttributeStoringRep and IsHomalgCategoryObjectRep,
                       [ ] );

DeclareRepresentation( "IsHomalgCategoryProductMorphismRep",
                       IsAttributeStoringRep and IsHomalgCategoryMorphismRep,
                       [ ] );

BindGlobal( "TheTypeOfHomalgCategoryProductObjects",
        NewType( TheFamilyOfHomalgCategoryObjects,
                IsHomalgCategoryProductObjectRep ) );

BindGlobal( "TheTypeOfHomalgCategoryProductMorphisms",
        NewType( TheFamilyOfHomalgCategoryMorphisms,
                IsHomalgCategoryProductMorphismRep ) );
