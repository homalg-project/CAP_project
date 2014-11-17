#############################################################################
##
##                                               CategoriesForHomalg package
##
##  Copyright 2014, Sebastian Gutsche, TU Kaiserslautern
##                  Sebastian Posur,   RWTH Aachen
##
#! @Chapter Deduction system
##
#############################################################################

DeclareGlobalVariable( "DEDUCTIVE_SYSTEM_OPTIONS" );

DeclareCategory( "IsDeductiveSystemCell",
                 IsHomalgCategoryCell );

DeclareCategory( "IsDeductiveSystemObject",
                 IsDeductiveSystemCell and IsHomalgCategoryObject );

DeclareCategory( "IsDeductiveSystemMorphism",
                 IsDeductiveSystemCell and IsHomalgCategoryMorphism );

DeclareGlobalFunction( "ADDS_FOR_DEDUCTIVE_SYSTEM" );

DeclareGlobalFunction( "RESOLVE_HISTORY" );

DeclareGlobalFunction( "RECURSIVE_EVAL" );

DeclareGlobalFunction( "HistoryToString" );

#####################################
##
## Constructor
##
#####################################

DeclareAttribute( "DeductiveSystem",
                  IsHomalgCategory );

DeclareAttribute( "InDeductiveSystem",
                  IsHomalgCategoryObject );

DeclareOperation( "DeductiveSystemObject",
                  [ IsHomalgCategory ] );

DeclareOperation( "DeductiveSystemObject",
                  [ IsString, IsList ] );

DeclareAttribute( "InDeductiveSystem",
                  IsHomalgCategoryMorphism );

DeclareOperation( "DeductiveSystemMorphism",
                  [ IsDeductiveSystemObject, IsString, IsList, IsDeductiveSystemObject ] );

DeclareOperation( "DeductiveSystemMorphism",
                  [ IsDeductiveSystemObject, IsDeductiveSystemObject ] );

#####################################
##
## Attributes
##
#####################################

DeclareAttribute( "History",
                  IsDeductiveSystemCell, "mutable" );

DeclareAttribute( "Eval",
                  IsDeductiveSystemCell );

#####################################
##
## Attributes for all cells
##
#####################################

DeclareAttribute( "ChecksFromLogic",
                  IsHomalgCategoryCell, "mutable" );
