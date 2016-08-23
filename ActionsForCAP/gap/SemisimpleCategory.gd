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

##
DeclareOperation( "SemisimpleCategory",
                  [ IsFieldForHomalg, IsFunction, IsObject, IsString, IsString ] );

##
DeclareOperation( "SemisimpleCategory",
                  [ IsFieldForHomalg, IsFunction, IsObject, IsString ] );

####################################
##
## Attributes
##
####################################

##
DeclareAttribute( "MembershipFunctionForSemisimpleCategory",
                  IsCapCategory );
##
DeclareAttribute( "UnderlyingCategoryForSemisimpleCategory",
                  IsCapCategory );

####################################
##
## Internals
##
####################################

##
DeclareGlobalFunction( "CAP_INTERNAL_INSTALL_OPERATIONS_FOR_SEMISIMPLE_CATEGORY" );
