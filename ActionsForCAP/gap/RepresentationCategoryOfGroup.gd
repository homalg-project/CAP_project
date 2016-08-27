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

####################################
##
#! @Section Constructors
##
####################################

##Rep(G)
##
DeclareAttribute( "RepresentationCategory", IsGroup );

##
DeclareOperation( "RepresentationCategoryObject", [ IsList ] );

##
DeclareOperation( "RepresentationCategoryMorphism", [ IsSemisimpleCategoryObject, IsList, IsSemisimpleCategoryObject ] );

##Rep( Z x G )
##
DeclareAttribute( "RepresentationCategoryZGraded", IsGroup );

##
DeclareOperation( "RepresentationCategoryZGradedObject", [ IsInt, IsList ] );

DeclareOperation( "RepresentationCategoryZGradedObject", [ IsList ] );

##
DeclareOperation( "RepresentationCategoryZGradedMorphism", [ IsSemisimpleCategoryObject, IsList, IsSemisimpleCategoryObject ] );

####################################
##
#! @Section Internals
##
####################################

##
DeclareAttribute( "GeneratingRootOfUnityForFieldForHomalg", IsFieldForHomalg );

