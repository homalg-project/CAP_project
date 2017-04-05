#############################################################################
##
##                                       ModulesOverLocalRingsForCAP package
##
##  Copyright 2017, Sebastian Posur,  University of Siegen
##
#! @Chapter Morphisms
##
#############################################################################

####################################
##
#! @Section GAP Category
##
####################################

DeclareCategory( "IsCategoryOfModulePresentationsOverLocalRingMorphism",
                 IsSerreQuotientCategoryMorphism );

####################################
##
#! @Section Attributes
##
####################################

##
DeclareAttribute( "StepOfMinimalFreeResolutionOfKernel",
                  IsCategoryOfModulePresentationsOverLocalRingMorphism );