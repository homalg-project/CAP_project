#############################################################################
##
##                  CAPCategoryOfProjectiveGradedModules package
##
##  Copyright 2015, Sebastian Gutsche, TU Kaiserslautern
##                  Sebastian Posur,   RWTH Aachen
##                  Martin Bies,       ITP Heidelberg
##
#############################################################################

####################################
##
## GAP Category
##
####################################

DeclareCategory( "IsCAPCategoryOfProjectiveGradedModulesMorphism",
                 IsCapCategoryMorphism );

####################################
##
## Constructors
##
####################################

DeclareOperation( "CAPCategoryOfProjectiveGradedModulesMorphism",
               [ IsCAPCategoryOfProjectiveGradedModulesObject, IsHomalgMatrix, IsCAPCategoryOfProjectiveGradedModulesObject ] );

####################################
##
## Attributes
##
####################################

DeclareAttribute( "UnderlyingHomalgGradedRing",
                  IsCAPCategoryOfProjectiveGradedModulesMorphism );

DeclareAttribute( "UnderlyingHomalgMatrix",
                  IsCAPCategoryOfProjectiveGradedModulesMorphism );