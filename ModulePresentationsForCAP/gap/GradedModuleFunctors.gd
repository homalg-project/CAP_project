#############################################################################
##
##                                       ModulePresentationsForCAP package
##
##  Copyright 2016, Sebastian Gutsche, Uni Siegen
##                  Sebastian Posur,   Uni Siegen
##
#############################################################################

DeclareOperation( "ResolutionFunctor",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "HorseShoeLemma",
                  [ IsCapComplex, IsCapComplex, IsCapCategoryMorphism, IsCapCategoryMorphism ] );

DeclareOperation( "CartanEilenbergResolution",
                  [ IsCapComplex, IsCapFunctor ] );



