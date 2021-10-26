# SPDX-License-Identifier: GPL-2.0-or-later
# ActionsForCAP: Actions and Coactions for CAP
#
# Declarations
#
#! @Chapter Semisimple Categories

####################################
##
## Constructors
##
####################################

DeclareOperation( "SemisimpleCategory",
                  [ IsCapCategory, IsFunction, IsString ] );

DeclareOperation( "SemisimpleCategory",
                  [ IsCapCategory, IsFunction ] );

####################################
##
## Attributes
##
####################################

DeclareAttribute( "MembershipFunctionForSemisimpleCategory",
                  IsCapCategory );

DeclareAttribute( "UnderlyingCategoryForSemisimpleCategory",
                  IsCapCategory );

####################################
##
## Internals
##
####################################

DeclareGlobalFunction( "CAP_INTERNAL_INSTALL_OPERATIONS_FOR_SEMISIMPLE_CATEGORY" );
