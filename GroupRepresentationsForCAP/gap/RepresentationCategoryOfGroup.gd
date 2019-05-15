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

#! @InsertChunk Quickstart_RepD8

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
#! @Description
#! The argument is a group $G$.
#! The output is the Cap category $G$-mod.
#! This method uses $\texttt{String( G )}$ as an identifier of $G$.
#! @Returns a Cap category
#! @Arguments G
DeclareAttribute( "RepresentationCategory", IsGroup );

#! @Description
#! The arguments are 2 integers $o,n$.
#! The output is the Cap category $G$-mod,
#! where $G$ is the group of order $o$ corresponding to
#! the SmallGroupLibrary identification number $n$.
#! @Returns a Cap category
#! @Arguments o,n
DeclareOperation( "RepresentationCategory", [ IsInt, IsInt ] );

##
DeclareOperation( "RepresentationCategory", [ IsGroup, IsList ] );

#! @Description
#! There are 2 arguments.
#! The first argument is
#! a list $L = [ [ n_1, c_1 ], \dots, [ n_l, c_l ] ]$
#! consisting of non-negative integers $n_i$ and characters $c_i$ of the same group.
#! Alternatively, the first argument can simply be an irreducible
#! character c, which will be then interpreted as giving the input $[ [ 1, c ] ]$.
#! The second argument is the Cap category $C = G$-mod.
#! The output is the unique object in $G$-mod
#! having $L$ as its character decomposition.
#! @Returns an object in $G$-mod
#! @Arguments L, C
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

##
DeclareAttribute( "MultiplicityArray",
                  IsRepresentationCategoryZGradedObject );

####################################
##
#! @Section Operations
##
####################################

##
DeclareOperation( "InductionFunctorForRepresentationCategoriesOfGroups",
                  [ IsGroup, IsGroup ] );

##
DeclareOperation( "RestrictionFunctorForRepresentationCategoriesOfGroups",
                  [ IsGroup, IsGroup ] );

####################################
##
#! @Section Internals
##
####################################

DeclareAttribute( "UnderlyingGroupForRepresentationCategory", IsRepresentationCategory );
