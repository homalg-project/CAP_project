#############################################################################
##
##     FreydCategoriesForCAP: Freyd categories - Formal (co)kernels for additive categories
##
##  Copyright 2018, Sebastian Posur, University of Siegen
##
#! @Chapter Additive closure
#!
#############################################################################

####################################
##
#! @Section GAP Categories
##
####################################

DeclareCategory( "IsAdditiveClosureObject",
                 IsCapCategoryObject );

DeclareCategory( "IsAdditiveClosureMorphism",
                 IsCapCategoryMorphism );

DeclareGlobalFunction( "INSTALL_FUNCTIONS_FOR_ADDITIVE_CLOSURE" );

DeclareCategory( "IsAdditiveClosureCategory",
                 IsCapCategory );

####################################
##
#! @Section Constructors
##
####################################

DeclareAttribute( "AdditiveClosure",
                  IsCapCategory );


DeclareOperation( "AdditiveClosureObject",
                  [ IsList, IsAdditiveClosureCategory ] );

DeclareAttribute( "AsAdditiveClosureObject",
                  IsCapCategoryObject );

DeclareOperation( "AdditiveClosureMorphism",
                  [ IsAdditiveClosureObject, IsList, IsAdditiveClosureObject ] );

DeclareAttribute( "AsAdditiveClosureMorphism",
                  IsCapCategoryMorphism );

####################################
##
#! @Section Attributes
##
####################################

DeclareAttribute( "UnderlyingCategory",
                  IsAdditiveClosureCategory );

DeclareAttribute( "ObjectList",
                  IsAdditiveClosureObject );

DeclareAttribute( "MorphismMatrix",
                  IsAdditiveClosureMorphism );

DeclareAttribute( "NrRows",
                  IsAdditiveClosureMorphism );

DeclareAttribute( "NrColumns",
                  IsAdditiveClosureMorphism );

####################################
##
#! @Section Operators
##
####################################

DeclareOperation( "\[\]",
                  [ IsAdditiveClosureMorphism, IsInt ] );
