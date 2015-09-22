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

DeclareCategory( "IsLeftOrRightActionObject",
                 IsCapCategoryObject );

DeclareCategory( "IsLeftActionObject",
                 IsLeftOrRightActionObject );

DeclareCategory( "IsRightActionObject",
                 IsLeftOrRightActionObject );

#############################
##
## Constructors
##
#############################

DeclareGlobalFunction( "LeftOrRightActionObject" );

DeclareOperation( "LeftActionObject",
                  [ IsCapCategoryMorphism, IsCapCategoryObject ] );

DeclareOperation( "RightActionObject",
                  [ IsCapCategoryMorphism, IsCapCategoryObject ] );

####################################
##
## Attributes
##
####################################

DeclareAttribute( "StructureMorphism",
                  IsLeftOrRightActionObject );

DeclareAttribute( "UnderlyingActingObject",
                  IsLeftOrRightActionObject );

DeclareAttribute( "ActionDomain",
                  IsLeftOrRightActionObject );

DeclareAttribute( "UnderlyingCategory",
                  IsLeftOrRightActionObject );