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

DeclareCategory( "IsDeductiveSystemTwoCell",
                 IsDeductiveSystemCell and IsHomalgCategoryTwoCell );

DeclareGlobalFunction( "INSTALL_PROPERTIES_FOR_DEDUCTIVE_SYSTEM" );

DeclareGlobalFunction( "ADDS_FOR_DEDUCTIVE_SYSTEM" );

DeclareGlobalFunction( "RESOLVE_HISTORY" );

DeclareGlobalFunction( "RECURSIVE_EVAL" );

DeclareGlobalFunction( "HistoryToString" );

DeclareGlobalFunction( "PRINT_HISTORY_RECURSIVE" );

DeclareGlobalFunction( "PrintHistoryClean" );

DeclareGlobalFunction( "PrintHistory" );

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
## Special Add
##
#####################################

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
