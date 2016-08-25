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
#! @Section Constructors
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
#! @Section Attributes
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
#! @Section Internals
##
####################################

##
DeclareGlobalFunction( "CAP_INTERNAL_INSTALL_OPERATIONS_FOR_SEMISIMPLE_CATEGORY" );

##
DeclareGlobalVariable( "CAP_INTERNAL_FIELD_FOR_SEMISIMPLE_CATEGORY" );