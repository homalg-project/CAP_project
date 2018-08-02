#############################################################################
##
##                                               CAP package
##
##  Copyright 2015, Sebastian Gutsche, TU Kaiserslautern
##                  Sebastian Posur,   RWTH Aachen
##
#! @Chapter Filtered objects
##
#############################################################################

## Cocomplex: Ascending
## Complex: Descending

DeclareGlobalFunction( "INSTALL_OPERATIONS_FOR_ASCENDING_FILTERED_OBJECTS_CATEGORY" );

DeclareGlobalFunction( "INSTALL_OPERATIONS_FOR_DESCENDING_FILTERED_OBJECTS_CATEGORY" );

DeclareCategory( "IsFilteredObjectCategoryCell",
                 IsCapCategoryCell );

DeclareCategory( "IsFilteredObject",
                 IsCapCategoryObject and IsFilteredObjectCategoryCell );

                 
DeclareCategory( "IsAscendingFilteredObjectCategoryCell",
                 IsFilteredObjectCategoryCell );

DeclareCategory( "IsAscendingFilteredObject",
                 IsFilteredObject and IsAscendingFilteredObjectCategoryCell );

DeclareCategory( "IsAscendingFilteredMorphism",
                 IsCapCategoryMorphism and IsAscendingFilteredObjectCategoryCell );


DeclareCategory( "IsDescendingFilteredObjectCategoryCell",
                 IsFilteredObjectCategoryCell );

DeclareCategory( "IsDescendingFilteredObject",
                 IsCapCategoryObject and IsDescendingFilteredObjectCategoryCell );

DeclareCategory( "IsDescendingFilteredMorphism",
                 IsCapCategoryMorphism and IsDescendingFilteredObjectCategoryCell );


####################################
##
## Category
##
####################################

DeclareAttribute( "CategoryOfAscendingFilteredObjects",
                  IsCapCategory );

DeclareAttribute( "CategoryOfDescendingFilteredObjects",
                  IsCapCategory );

####################################
##
## Attributes
##
####################################

DeclareAttribute( "UnderlyingZFunctorCell",
                  IsFilteredObjectCategoryCell );

####################################
##
## Getter
##
####################################

DeclareOperation( "\[\]",
                 [ IsAscendingFilteredObjectCategoryCell, IsInt ] );

DeclareOperation( "\[\]",
                 [ IsDescendingFilteredObjectCategoryCell, IsInt ] );

DeclareOperation( "Embedding",
                  [ IsDescendingFilteredObject, IsInt ] );

DeclareOperation( "Embedding",
                  [ IsAscendingFilteredObject, IsInt ] );

#################################################
##
## Constructors
##
#################################################

DeclareAttribute( "AsAscendingFilteredObject",
                  IsZFunctorObject );

DeclareAttribute( "AsDescendingFilteredObject",
                  IsZFunctorObject );

DeclareAttribute( "AsAscendingFilteredMorphism",
                  IsZFunctorMorphism );

DeclareAttribute( "AsDescendingFilteredMorphism",
                  IsZFunctorMorphism );

DeclareOperation( "AscendingFilteredMorphism",
                  [ IsAscendingFilteredObject, IsZFunctorMorphism, IsAscendingFilteredObject ] );

DeclareOperation( "AscendingFilteredMorphism",
                  [ IsAscendingFilteredObject, IsFunction, IsAscendingFilteredObject ] );

DeclareOperation( "DescendingFilteredMorphism",
                  [ IsDescendingFilteredObject, IsZFunctorMorphism, IsDescendingFilteredObject ] );

DeclareOperation( "DescendingFilteredMorphism",
                  [ IsDescendingFilteredObject, IsFunction, IsDescendingFilteredObject ] );

#################################################
##
## Functors
##
#################################################

DeclareOperationWithCache( "DescendingToAscendingFilteredObjectFunctor",
                           [ IsCapCategory ] );

DeclareOperationWithCache( "AscendingToDescendingFilteredObjectFunctor",
                           [ IsCapCategory ] );

