############################################################################
##
##                                ActionsForCAP package
##
##  Copyright 2016, Sebastian Gutsche, TU Kaiserslautern
##                  Sebastian Posur,   RWTH Aachen
##
#! @Chapter Semisimple Categories
##
#############################################################################

DeclareCategory( "IsRepresentationCategory",
                 IsCapCategory );

DeclareCategory( "IsRepresentationCategoryObject",
                 IsSemisimpleCategoryObject );

DeclareCategory( "IsRepresentationCategoryMorphism",
                 IsSemisimpleCategoryMorphism );

DeclareCategory( "IsRepresentationCategoryZGradedObject",
                 IsSemisimpleCategoryObject );

DeclareCategory( "IsRepresentationCategoryZGradedMorphism",
                 IsSemisimpleCategoryMorphism );

####################################
##
#! @Section Constructors
##
####################################

##Rep(G)
##
DeclareAttribute( "RepresentationCategory", IsGroup );

##
DeclareOperation( "RepresentationCategory", [ IsInt, IsInt ] );

##
DeclareOperation( "RepresentationCategory", [ IsGroup, IsList ] );

##
DeclareOperation( "RepresentationCategoryObject", [ IsList, IsCapCategory ] );

##
DeclareOperation( "RepresentationCategoryMorphism", [ IsSemisimpleCategoryObject, IsList, IsSemisimpleCategoryObject ] );

##Rep( Z x G )
##
DeclareAttribute( "RepresentationCategoryZGraded", IsGroup );

DeclareOperation( "RepresentationCategoryZGraded", [ IsInt, IsInt ] );

DeclareOperation( "RepresentationCategoryZGraded", [ IsGroup, IsList ] );

##
DeclareOperation( "RepresentationCategoryZGradedObject", [ IsInt, IsList, IsCapCategory ] );

DeclareOperation( "RepresentationCategoryZGradedObject", [ IsList, IsCapCategory ] );

##
DeclareOperation( "RepresentationCategoryZGradedMorphism", [ IsSemisimpleCategoryObject, IsList, IsSemisimpleCategoryObject ] );

####################################
##
#! @Section Attributes
##
####################################

##
DeclareAttribute( "DegreeDecomposition",
                  IsRepresentationCategoryZGradedObject );

####################################
##
#! @Section Internals
##
####################################

DeclareAttribute( "UnderlyingGroupForRepresentationCategory", IsRepresentationCategory );
