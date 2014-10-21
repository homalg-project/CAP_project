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

#####################################
##
## Constructor
##
#####################################

DeclareAttribute( "DeductionSystem",
                  IsHomalgCategory );

DeclareOperation( "DeductionSystemObject",
                  [ IsHomalgCategoryObject ] );

DeclareOperation( "DeductionSystemObject",
                  [ ] );

DeclareOperation( "DeductionSystemObject",
                  [ IsFunction, IsList ] );

DeclareOperation( "DeductionSystemMorphism",
                  [ IsHomalgCategoryMorphism ] );

DeclareOperation( "DeductionSystemMorphism",
                  [ IsDeductionSystemObject, IsFunction, IsList, IsDeductionSystemObject ] );

#####################################
##
## Attributes
##
#####################################

DeclareAttribute( "History",
                  IsDeductionSystemCell, "mutable" );

DeclareAttribute( "Eval",
                  IsDeductionSystemCell );
