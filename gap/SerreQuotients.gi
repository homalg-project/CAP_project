#############################################################################
##
##                                               CategoriesForHomalg package
##
##  Copyright 2014, Sebastian Gutsche, TU Kaiserslautern
##                  Sebastian Posur,   RWTH Aachen
##
#############################################################################

DeclareRepresentation( "IsSerreQuotientCategoryObjectRep",
                       IsHomalgCategoryObjectRep and IsSerreQuotientCategoryObject,
                       [ ] );

BindGlobal( "TheTypeOfSerreQuotientCategoryObject",
        NewType( TheFamilyOfHomalgCategoryObjects,
                IsSerreQuotientCategoryObjectRep ) );

DeclareRepresentation( "IsSerreQuotientCategoryMorphismRep",
                       IsHomalgCategoryMorphismRep and IsSerreQuotientCategoryMorphism,
                       [ ] );

BindGlobal( "TheTypeOfSerreQuotientCategoryMorphism",
        NewType( TheFamilyOfHomalgCategoryMorphisms,
                 IsSerreQuotientCategoryMorphismRep ) );




