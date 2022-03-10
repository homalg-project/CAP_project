# SPDX-License-Identifier: GPL-2.0-or-later
# ModulesOverLocalRingsForCAP: Category of modules over a local ring modeled by Serre quotients for CAP
#
# Declarations
#

#! @Chapter Gauss

#############################
##
#! @Section Gaussian elimination
##
#############################

DeclareAttribute( "REFIndicesForMatricesOverIntegralDomain",
                  IsHomalgMatrix );

DeclareOperationWithCache( "REFIndicesForMatricesOverIntegralDomainWithGivenColumnOrdering",
                           [ IsHomalgMatrix, IsList ] );
