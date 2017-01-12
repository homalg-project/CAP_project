#############################################################################
##
##                                GroupRepresentationsForCAP package
##
##  Copyright 2016, Sebastian Posur, University of Siegen
##
#! @Chapter Semisimple Categories
##
#############################################################################

####################################
##
#! @Section GAP Categories
##
####################################

#! @Description
#! The GAP category of objects in a semisimple category.
#! @Arguments object
DeclareCategory( "IsSemisimpleCategoryObject",
                 IsCapCategoryObject );

####################################
##
#! @Section Constructors
##
####################################

#! @Description
#! The arguments are 
#! a list $L$
#! and a semisimple category $C = \bigoplus_{i \in I} k\mathrm{-vec}$.
#! The list $L$ contains pairs $L = [ [ a_1, i_1 ], \dots, [ a_l, i_l ] ]$
#! of non-negative integers $a_j$ and
#! objects $i_j \in I$.
#! The output is the object in $C$
#! given by $\oplus_{j=1}^l a_j \chi^{i_j}$.
#! @Returns an object
#! @Arguments L
DeclareOperation( "SemisimpleCategoryObject", [ IsList, IsCapCategory ] );

DeclareOperationWithCache( "SemisimpleCategoryObjectConstructorWithFlatList", [ IsList, IsCapCategory ] );


####################################
##
#! @Section Attributes
##
####################################

##
DeclareAttribute( "SemisimpleCategoryObjectList",
                  IsSemisimpleCategoryObject );

##
DeclareAttribute( "SemisimpleCategoryObjectListWithActualObjects",
                  IsSemisimpleCategoryObject );

#! @Description
#! The argument is an object $A$ in a semisimple category.
#! @Returns a list
#! @Arguments A
DeclareAttribute( "Support",
                  IsSemisimpleCategoryObject );

##
DeclareAttribute( "UnderlyingFieldForHomalg",
                  IsSemisimpleCategoryObject );

##
DeclareAttribute( "Dimension",
                  IsSemisimpleCategoryObject );


####################################
##
#! @Section Operations
##
####################################

##
DeclareOperation( "NormalizeSemisimpleCategoryObjectList", [ IsList, IsCapCategory ] );

##
DeclareOperation( "Multiplicity", [ IsSemisimpleCategoryObject, IsObject ] );

##
DeclareOperation( "Component", [ IsSemisimpleCategoryObject, IsObject ] );

##
DeclareOperation( "TestPentagonIdentity",
              [ IsSemisimpleCategoryObject, IsSemisimpleCategoryObject, IsSemisimpleCategoryObject, IsSemisimpleCategoryObject ] );

##
DeclareOperation( "TestPentagonIdentityForAllQuadruplesInList", [ IsList ] );

##
DeclareOperation( "TestBraidingCompatability",
              [ IsSemisimpleCategoryObject, IsSemisimpleCategoryObject, IsSemisimpleCategoryObject ] );
##
DeclareOperation( "TestBraidingCompatabilityForAllTriplesInList", [ IsList ] );

##
DeclareOperation( "TestZigZagIdentitiesForDual", [ IsSemisimpleCategoryObject ] );

##
DeclareOperation( "TestZigZagIdentitiesForDualForAllTriplesInList", [ IsList ] );