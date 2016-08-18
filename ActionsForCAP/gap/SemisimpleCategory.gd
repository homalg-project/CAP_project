############################################################################
##
##                                ActionsForCAP package
##
##  Copyright 2016, Sebastian Gutsche, TU Kaiserslautern
##                  Sebastian Posur,   RWTH Aachen
##
#! @Chapter Semisimple Categories
##
#############################################################################

####################################
##
## Constructors
##
####################################

DeclareOperation( "SemisimpleCategory",
                  [ IsCapCategory, IsFunction, IsFunction, IsString ] );

DeclareOperation( "SemisimpleCategory",
                  [ IsCapCategory, IsFunction, IsFunction ] );

####################################
##
## Attributes
##
####################################

DeclareAttribute( "MembershipFunctionForSemisimpleCategory",
                  IsCapCategory );

DeclareAttribute( "LowerEqualFunctionForSemisimpleCategory",
                  IsCapCategory );


DeclareAttribute( "UnderlyingCategoryForSemisimpleCategory",
                  IsCapCategory );

####################################
##
## Internals
##
####################################

DeclareGlobalFunction( "CAP_INTERNAL_INSTALL_OPERATIONS_FOR_SEMISIMPLE_CATEGORY" );
