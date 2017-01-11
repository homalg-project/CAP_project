#############################################################################
##
##                                GroupRepresentationsForCAP package
##
##  Copyright 2016, Sebastian Posur, University of Siegen
##
#! @Chapter Representation Category of Groups
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

##
DeclareAttribute( "HilbertSeries",
                  IsRepresentationCategoryZGradedObject );

##
KeyDependentOperation( "DegreeDecompositionSplit", IsRepresentationCategoryZGradedObject, IsInt, ReturnTrue );

##
KeyDependentOperation( "DegreePart", IsRepresentationCategoryZGradedObject, IsInt, ReturnTrue );

##
DeclareAttribute( "DegreeDescendingFiltration",
                  IsRepresentationCategoryZGradedObject );

####################################
##
#! @Section Internals
##
####################################

DeclareAttribute( "UnderlyingGroupForRepresentationCategory", IsRepresentationCategory );
