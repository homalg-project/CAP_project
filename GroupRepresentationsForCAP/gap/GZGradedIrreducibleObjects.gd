#############################################################################
##
##                                GroupRepresentationsForCAP package
##
##  Copyright 2016, Sebastian Posur, University of Siegen
##
#! @Chapter Irreducible Objects
##
#############################################################################

####################################
##
#! @Section GAP Categories
##
####################################

DeclareCategory( "IsGZGradedIrreducibleObject",
                 IsObject );

####################################
##
#! @Section Constructors
##
####################################

DeclareOperationWithCache( "GZGradedIrreducibleObject", [ IsInt, IsCharacter ] );

####################################
##
#! @Section Attributes
##
####################################

DeclareAttribute( "UnderlyingCharacter", IsGZGradedIrreducibleObject );

DeclareAttribute( "UnderlyingDegree", IsGZGradedIrreducibleObject );

DeclareAttribute( "UnderlyingGroup", IsGZGradedIrreducibleObject );

DeclareAttribute( "UnderlyingCharacterTable", IsGZGradedIrreducibleObject );

DeclareAttribute( "UnderlyingIrreducibleCharacters", IsGZGradedIrreducibleObject );

DeclareAttribute( "UnderlyingCharacterNumber", IsGZGradedIrreducibleObject );

DeclareAttribute( "Dimension", IsGZGradedIrreducibleObject );

DeclareAttribute( "Dual", IsGZGradedIrreducibleObject );

####################################
##
#! @Section Properties
##
####################################

DeclareProperty( "IsOne", IsGZGradedIrreducibleObject );

####################################
##
#! @Section Operations
##
####################################

DeclareOperation( "Multiplicity", [ IsGZGradedIrreducibleObject, IsGZGradedIrreducibleObject, IsGZGradedIrreducibleObject ] );

DeclareOperation( "\<", [ IsGZGradedIrreducibleObject, IsGZGradedIrreducibleObject ] );

DeclareOperation( "\*", [ IsGZGradedIrreducibleObject, IsGZGradedIrreducibleObject ] );

DeclareOperation( "AssociatorFromData", 
                  [ IsGZGradedIrreducibleObject, IsGZGradedIrreducibleObject, IsGZGradedIrreducibleObject, IsList, IsFieldForHomalg, IsList ] );

DeclareOperation( "ExteriorPower", [ IsGZGradedIrreducibleObject ] );