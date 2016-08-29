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
                  [ IsFieldForHomalg, IsFunction, IsObject, IsString, IsBool, IsString ] );

##
DeclareOperation( "SemisimpleCategory",
                  [ IsFieldForHomalg, IsFunction, IsObject, IsString, IsBool ] );

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

##
DeclareAttribute( "UnderlyingFieldForHomalgForSemisimpleCategory",
                  IsCapCategory );

####################################
##
#! @Section Internals
##
####################################

##
DeclareOperationWithCache( "CAP_INTERNAL_AssociatorOnIrreducibles", 
                           [ IsSemisimpleCategoryObject, IsSemisimpleCategoryObject, IsSemisimpleCategoryObject ] );

##
DeclareOperationWithCache( "CAP_INTERNAL_Distributivity_Expanding_For_Triples", 
                           [ IsSemisimpleCategoryObject, IsSemisimpleCategoryObject, IsList, IsBool ] );

##
DeclareOperationWithCache( "CAP_INTERNAL_Distributivity_Factoring_For_Triples", 
                           [ IsSemisimpleCategoryObject, IsSemisimpleCategoryObject, IsList, IsBool ] );

##
DeclareOperationWithCache( "CAP_INTERNAL_Braiding_On_Irreducibles", 
                           [ IsSemisimpleCategoryObject, IsSemisimpleCategoryObject ] );


##
DeclareGlobalFunction( "CAP_INTERNAL_INSTALL_OPERATIONS_FOR_SEMISIMPLE_CATEGORY" );

##
DeclareGlobalVariable( "CAP_INTERNAL_FIELD_FOR_SEMISIMPLE_CATEGORY" );