# SPDX-License-Identifier: GPL-2.0-or-later
# ModulesOverLocalRingsForCAP: Category of modules over a local ring modeled by Serre quotients for CAP
#
# Declarations
#

#! @Chapter Morphisms

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
