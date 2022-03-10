# SPDX-License-Identifier: GPL-2.0-or-later
# ModulesOverLocalRingsForCAP: Category of modules over a local ring modeled by Serre quotients for CAP
#
# Declarations
#

#! @Chapter Natural transformations

#######################################
##
#! @Section Constructors
##
#######################################

##
DeclareAttribute( "NaturalIsomorphismFromMinimalGeneratorsModelToIdentity",
                  IsCategoryOfModulePresentationsOverLocalRing );

##
DeclareAttribute( "NaturalIsomorphismFromMinimalRelationsModelToIdentity",
                  IsCategoryOfModulePresentationsOverLocalRing );

##
DeclareAttribute( "NaturalIsomorphismFromStandardGeneratorsModelToIdentity",
                  IsCategoryOfModulePresentationsOverLocalRing );
