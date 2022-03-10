# SPDX-License-Identifier: GPL-2.0-or-later
# ModulesOverLocalRingsForCAP: Category of modules over a local ring modeled by Serre quotients for CAP
#
# Declarations
#

#! @Chapter Functors

####################################
##
#! @Section Constructors
##
####################################

##
DeclareAttribute( "FunctorMinimalGeneratorsModel",
                  IsCategoryOfModulePresentationsOverLocalRing );

##
DeclareAttribute( "FunctorMinimalRelationsModel",
                  IsCategoryOfModulePresentationsOverLocalRing );

##
DeclareAttribute( "FunctorMinimalModel",
                  IsCategoryOfModulePresentationsOverLocalRing );

##
DeclareAttribute( "FunctorStandardGeneratorsModel",
                  IsCategoryOfModulePresentationsOverLocalRing );
