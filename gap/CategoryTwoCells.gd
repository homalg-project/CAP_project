#############################################################################
##
##                                               CategoriesForHomalg package
##
##  Copyright 2014, Sebastian Gutsche, TU Kaiserslautern
##                  Sebastian Posur,   RWTH Aachen
##
#! @Chapter Category 2-cells
##
#############################################################################

DeclareCategory( "IsHomalgCategoryTwoCell",
                 IsHomalgCategoryCell );

DeclareGlobalFunction( "INSTALL_TODO_LIST_ENTRIES_FOR_TWOCELL" );

######################################
##
## Attributes
##
######################################

DeclareAttribute( "Source",
                  IsHomalgCategoryTwoCell );

DeclareAttribute( "Range",
                  IsHomalgCategoryTwoCell );

DeclareProperty( "IsWellDefined",
                 IsHomalgCategoryTwoCell );

###################################
##
## Properties
##
###################################

DeclareProperty( "IsMonomorphism",
                 IsHomalgCategoryTwoCell );

DeclareProperty( "IsEpimorphism",
                 IsHomalgCategoryTwoCell );

DeclareProperty( "IsIsomorphism",
                 IsHomalgCategoryTwoCell );

DeclareProperty( "IsEndomorphism",
                 IsHomalgCategoryTwoCell );

DeclareProperty( "IsAutomorphism",
                 IsHomalgCategoryTwoCell );

DeclareProperty( "IsSplitMonomorphism",
                 IsHomalgCategoryTwoCell );

DeclareProperty( "IsSplitEpimorphism",
                 IsHomalgCategoryTwoCell );

## TODO: IsIdentity
DeclareProperty( "IsOne",
                 IsHomalgCategoryTwoCell );

DeclareProperty( "IsIdempotent",
                 IsHomalgCategoryTwoCell );

#######################################
##
## Add functions
##
#######################################

DeclareOperation( "Add",
                  [ IsHomalgCategory, IsHomalgCategoryTwoCell ] );

DeclareOperation( "HorizontalPreCompose",
                  [ IsHomalgCategoryTwoCell, IsHomalgCategoryTwoCell ] );

DeclareOperation( "AddHorizontalPreCompose",
                  [ IsHomalgCategory, IsFunction ] );

DeclareAttribute( "HorizontalPreComposeFunction",
                  IsHomalgCategory );

DeclareOperation( "VerticalPreCompose",
                  [ IsHomalgCategoryTwoCell, IsHomalgCategoryTwoCell ] );

DeclareOperation( "AddVerticalPreCompose",
                  [ IsHomalgCategory, IsFunction ] );

DeclareAttribute( "VerticalPreComposeFunction",
                  IsHomalgCategory );

DeclareAttributeWithToDoForIsWellDefined( "IdentityTwoCell",
                                          IsHomalgCategoryMorphism );

DeclareOperation( "AddIdentityTwoCell",
                  [ IsHomalgCategory, IsFunction ] );

DeclareAttribute( "IdentityTwoCellFunction",
                  IsHomalgCategory );

###################################
##
## IsWellDefined
##
###################################

DeclareOperation( "AddIsWellDefinedForTwoCells",
                  [ IsHomalgCategory, IsFunction ] );

DeclareAttribute( "IsWellDefinedForTwoCellsFunction",
                  IsHomalgCategory );
