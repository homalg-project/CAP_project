#############################################################################
##
##     FreydCategoriesForCAP: Freyd categories - Formal (co)kernels for additive categories
##
##  Copyright 2019, Sebastian Posur, University of Siegen
##
#! @Chapter Linear closure of a category
#!
#############################################################################

####################################
##
#! @Section GAP Categories
##
####################################

##
DeclareCategory( "IsLinearClosureObject",
                 IsCapCategoryObject );

DeclareCategory( "IsLinearClosureMorphism",
                 IsCapCategoryMorphism );

DeclareCategory( "IsLinearClosure",
                 IsCapCategory );

DeclareGlobalFunction( "INSTALL_FUNCTIONS_FOR_LINEAR_CLOSURE" );

####################################
##
#! @Section Constructors
##
####################################

DeclareOperation( "LinearClosure",
                  [ IsHomalgRing, IsCapCategory, IsFunction ] );

DeclareOperation( "LinearClosureObject",
                  [ IsCapCategory, IsLinearClosure ] );

KeyDependentOperation( "LinearClosureObject",
                       IsLinearClosure, IsCapCategoryObject, ReturnTrue );

DeclareOperation( "LinearClosureMorphism",
                  [ IsLinearClosureObject, IsList, IsList, IsLinearClosureObject ] );

DeclareOperation( "LinearClosureMorphismNC",
                  [ IsLinearClosureObject, IsList, IsList, IsLinearClosureObject ] );

####################################
##
#! @Section Attributes
##
####################################


DeclareAttribute( "UnderlyingCategory",
                   IsLinearClosure );

DeclareAttribute( "UnderlyingRing",
                   IsLinearClosure );

DeclareAttribute( "UnderlyingOriginalObject",
                   IsLinearClosureObject );

DeclareAttribute( "CoefficientsList",
                  IsLinearClosureMorphism );

DeclareAttribute( "SupportMorphisms",
                  IsLinearClosureMorphism );

####################################
##
#! @Section Operations
##
####################################

DeclareOperation( "\*",
                  [ IsLinearClosureMorphism, IsLinearClosureMorphism ] );

DeclareOperation( "\/",
                  [ IsCapCategoryMorphism, IsLinearClosure ] );
