#############################################################################
##
##                                               CAP package
##
##  Copyright 2014, Sebastian Gutsche, TU Kaiserslautern
##                  Sebastian Posur,   RWTH Aachen
##
#! @Chapter Category 2-cells
##
#############################################################################

## Moved to CAP.gd

DeclareGlobalFunction( "INSTALL_TODO_LIST_ENTRIES_FOR_TWOCELL" );

######################################
##
## Attributes
##
######################################

DeclareAttribute( "Source",
                  IsCapCategoryTwoCell );

DeclareAttribute( "Range",
                  IsCapCategoryTwoCell );

DeclareProperty( "IsWellDefined",
                 IsCapCategoryTwoCell );

###################################
##
## Properties
##
###################################

DeclareProperty( "IsMonomorphism",
                 IsCapCategoryTwoCell );

DeclareProperty( "IsEpimorphism",
                 IsCapCategoryTwoCell );

DeclareProperty( "IsIsomorphism",
                 IsCapCategoryTwoCell );

DeclareProperty( "IsEndomorphism",
                 IsCapCategoryTwoCell );

DeclareProperty( "IsAutomorphism",
                 IsCapCategoryTwoCell );

DeclareProperty( "IsSplitMonomorphism",
                 IsCapCategoryTwoCell );

DeclareProperty( "IsSplitEpimorphism",
                 IsCapCategoryTwoCell );

## TODO: IsIdentity
DeclareProperty( "IsOne",
                 IsCapCategoryTwoCell );

DeclareProperty( "IsIdempotent",
                 IsCapCategoryTwoCell );

#######################################
##
## Add functions
##
#######################################

DeclareOperation( "Add",
                  [ IsCapCategory, IsCapCategoryTwoCell ] );

DeclareOperation( "HorizontalPreCompose",
                  [ IsCapCategoryTwoCell, IsCapCategoryTwoCell ] );

DeclareOperation( "AddHorizontalPreCompose",
                  [ IsCapCategory, IsFunction ] );

DeclareAttribute( "HorizontalPreComposeFunction",
                  IsCapCategory );

DeclareOperation( "VerticalPreCompose",
                  [ IsCapCategoryTwoCell, IsCapCategoryTwoCell ] );

DeclareOperation( "AddVerticalPreCompose",
                  [ IsCapCategory, IsFunction ] );

DeclareAttribute( "VerticalPreComposeFunction",
                  IsCapCategory );

DeclareAttributeWithToDoForIsWellDefined( "IdentityTwoCell",
                                          IsCapCategoryMorphism );

DeclareOperation( "AddIdentityTwoCell",
                  [ IsCapCategory, IsFunction ] );

DeclareAttribute( "IdentityTwoCellFunction",
                  IsCapCategory );

###################################
##
## IsWellDefined
##
###################################

DeclareOperation( "AddIsWellDefinedForTwoCells",
                  [ IsCapCategory, IsFunction ] );

DeclareAttribute( "IsWellDefinedForTwoCellsFunction",
                  IsCapCategory );
