#############################################################################
##
##                                GroupRepresentationsForCAP package
##
##  Copyright 2016, Sebastian Posur, University of Siegen
##
#! @Chapter Representation Category of Groups
##
#############################################################################

#! @Section Introduction
#! For a finite group $G$,
#! the following methods provide computational
#! tools for working with
#! $G$-mod, a skeletal version
#! of the monoidal category of finite dimensional complex representations of $G$,
#! and with $G-\mathbb{Z}$-mod,
#! a skeletal version
#! of the monoidal category of finite dimensional complex representations of $G$
#! equipped with a degree in $\mathbb{Z}$.

#! @Section Quickstart

#! The following commands
#! construct the category $D_8$-mod,
#! the unique object $v$ corresponding
#! to the irreducible character of degree 2,
#! and perform some computations.

#! @InsertSystem Quickstart_RepD8

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
