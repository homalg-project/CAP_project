#############################################################################
##
##                                               CategoriesForHomalg package
##
##  Copyright 2013, Sebastian Gutsche, TU Kaiserslautern
##                  Sebastian Posur,   RWTH Aachen
##
#! @AutoDoc
#! @Chapter Categories for homalg
##
#############################################################################

###################################
##
#! @Level 1
#! @Section Internal stuff
##
###################################

DeclareGlobalVariable( "CATEGORIES_FOR_HOMALG" );

DeclareGlobalFunction( "CATEGORIES_FOR_HOMALG_NAME_COUNTER" );

###################################
##
#! @ResetLevel
##
###################################

###################################
##
#! @Section Categories
##
###################################

DeclareCategory( "IsHomalgCategory",
                 IsObject );

###################################
##
#! @Section Constructor
##
###################################

DeclareGlobalFunction( "CREATE_HOMALG_CATEGORY_OBJECT" );

DeclareGlobalFunction( "CREATE_HOMALG_CATEGORY_FILTERS" );

DeclareGlobalFunction( "INSTALL_ADD_FUNCTIONS_FOR_CATEGORY" );

DeclareOperation( "CreateHomalgCategory",
                  [ ] );

DeclareOperation( "CreateHomalgCategory",
                  [ IsString ] );

###################################
##
#! @Section Internal attributes
##
###################################

DeclareAttribute( "ObjectFilter",
                  IsHomalgCategory );

DeclareAttribute( "MorphismFilter",
                  IsHomalgCategory );

DeclareAttribute( "IdentityMorphism",
                  IsHomalgCategory );

DeclareAttribute( "PreCompose",
                  IsHomalgCategory );

DeclareAttribute( "ZeroObject",
                  IsHomalgCategory );

####################################
##
#! @Section Add functions
##
####################################

DeclareOperation( "AddIdentityMorphism",
                  [ IsHomalgCategory, IsFunction ] );

DeclareOperation( "AddPreCompose",
                  [ IsHomalgCategory, IsFunction ] );

DeclareOperation( "AddZeroObject",
                  [ IsHomalgCategory, IsFunction ] );

DeclareOperation( "AddMorphismIntoZeroObject",
                  [ IsHomalgCategory, IsFunction ] );

DeclareOperation( "AddMorphismFromZeroObject",
                  [ IsHomalgCategory, IsFunction ] );

DeclareOperation( "AddDirectSum_OnObjects",
                  [ IsHomalgCategory, IsFunction ] );

DeclareOperation( "AddInjectionFromFirstSummand",
                  [ IsHomalgCategory, IsFunction ] );

####################################
##
#! @Section Caching
##
####################################

DeclareOperation( "SetCaching",
                  [ IsHomalgCategory, IsString, IsString ] );

DeclareOperation( "SetCachingToWeak",
                  [ IsHomalgCategory, IsString ] );

DeclareOperation( "SetCachingToCrisp",
                  [ IsHomalgCategory, IsString ] );

DeclareOperation( "DeactivateCaching",
                  [ IsHomalgCategory, IsString ] );
