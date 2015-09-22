#############################################################################
##
##                                ActionsForCAP package
##
##  Copyright 2015, Sebastian Gutsche, TU Kaiserslautern
##                  Sebastian Posur,   RWTH Aachen
##
##
#############################################################################

####################################
##
## GAP Category
##
####################################

DeclareCategory( "IsLeftOrRightCoactionObject",
                 IsCapCategoryObject );

DeclareCategory( "IsLeftCoactionObject",
                 IsLeftOrRightCoactionObject );

DeclareCategory( "IsRightCoactionObject",
                 IsLeftOrRightCoactionObject );

#############################
##
## Constructors
##
#############################

DeclareGlobalFunction( "LeftOrRightCoactionObject" );

DeclareOperation( "LeftCoactionObject",
                  [ IsCapCategoryMorphism, IsCapCategoryObject ] );

DeclareOperation( "RightCoactionObject",
                  [ IsCapCategoryMorphism, IsCapCategoryObject ] );

####################################
##
## Attributes
##
####################################

DeclareAttribute( "StructureMorphism",
                  IsLeftOrRightCoactionObject );

DeclareAttribute( "UnderlyingCoactingObject",
                  IsLeftOrRightCoactionObject );

DeclareAttribute( "ActionDomain",
                  IsLeftOrRightCoactionObject );

DeclareAttribute( "UnderlyingCategory",
                  IsLeftOrRightCoactionObject );