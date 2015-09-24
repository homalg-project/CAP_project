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

DeclareCategory( "IsCAPCategoryOfProjectiveGradedLeftOrRightModulesMorphism",
                 IsCapCategoryMorphism );

DeclareCategory( "IsCAPCategoryOfProjectiveGradedLeftModulesMorphism",
                 IsCAPCategoryOfProjectiveGradedLeftOrRightModulesMorphism );

DeclareCategory( "IsCAPCategoryOfProjectiveGradedRightModulesMorphism",
                 IsCAPCategoryOfProjectiveGradedLeftOrRightModulesMorphism );
                 
####################################
##
## Constructors
##
####################################

DeclareOperation( "CAPCategoryOfProjectiveGradedLeftOrRightModulesMorphism",
               [ IsCAPCategoryOfProjectiveGradedLeftOrRightModulesObject, IsHomalgMatrix, 
                                                                    IsCAPCategoryOfProjectiveGradedLeftOrRightModulesObject ] );

####################################
##
## Attributes
##
####################################

DeclareAttribute( "UnderlyingHomalgGradedRing",
                  IsCAPCategoryOfProjectiveGradedLeftOrRightModulesMorphism );

DeclareAttribute( "UnderlyingHomalgMatrix",
                  IsCAPCategoryOfProjectiveGradedLeftOrRightModulesMorphism );