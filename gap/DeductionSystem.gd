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

DeclareCategory( "IsDeductionSystemCell",
                 IsHomalgCategoryCell );

DeclareCategory( "IsDeductionSystemObject",
                 IsDeductionSystemCell and IsHomalgCategoryObject );

DeclareCategory( "IsDeductionSystemMorphism",
                 IsDeductionSystemCell and IsHomalgCategoryMorphism );

DeclareGlobalFunction( "ADDS_FOR_DEDUCTION_SYSTEM" );

DeclareGlobalFunction( "RESOLVE_HISTORY" );

DeclareGlobalFunction( "RECURSIVE_EVAL" );

DeclareGlobalFunction( "ADD_THEOREM_TO_CATEGORY" );

DeclareGlobalFunction( "SANITIZE_RECORD" );

DeclareGlobalFunction( "INSTALL_TODO_FOR_LOGICAL_THEOREMS" );

#####################################
##
## Constructor
##
#####################################

DeclareAttribute( "DeductionSystem",
                  IsHomalgCategory );

DeclareAttribute( "AsDeductionSystemObject",
                  IsHomalgCategoryObject );

DeclareOperation( "DeductionSystemObject",
                  [ ] );

DeclareOperation( "DeductionSystemObject",
                  [ IsString, IsList ] );

DeclareAttribute( "AsDeductionSystemMorphism",
                  IsHomalgCategoryMorphism );

DeclareOperation( "DeductionSystemMorphism",
                  [ IsDeductionSystemObject, IsString, IsList, IsDeductionSystemObject ] );

#####################################
##
## Attributes
##
#####################################

DeclareAttribute( "History",
                  IsDeductionSystemCell, "mutable" );

DeclareAttribute( "Eval",
                  IsDeductionSystemCell );

#####################################
##
## Attributes for all cells
##
#####################################

DeclareAttribute( "ChecksFromLogic",
                  IsHomalgCategoryCell, "mutable" );
