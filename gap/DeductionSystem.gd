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

# DeclareGlobalFunction( 

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
                  [ IsOperation, IsList ] );

DeclareOperation( "DeductionMorphism",
                  [ IsHomalgCategoryMorphism ] );

DeclareOperation( "DeductionMorphism",
                  [ IsList ] );

DeclareOperation( "DeductionMorphism",
                  [ IsDeductionSystemObject, IsList, IsDeductionSystemObject ] );


#####################################
##
## Attributes
##
#####################################

DeclareAttribute( "History",
                  IsDeductionSystemCell, "mutable" );

DeclareAttribute( "Eval",
                  IsDeductionSystemCell );
