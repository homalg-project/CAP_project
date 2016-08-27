############################################################################
##
##                                ActionsForCAP package
##
##  Copyright 2016, Sebastian Gutsche, University of Siegen
##                  Sebastian Posur,   University of Siegen
##
#! @Chapter G-Z-Graded Irreducible Objects
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

DeclareOperationWithCache( "GZGradedIrreducibleObject", [ IsCharacter, IsInt ] );

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
                  [ IsGZGradedIrreducibleObject, IsGZGradedIrreducibleObject, IsGZGradedIrreducibleObject, IsList, IsFieldForHomalg ] );

DeclareOperation( "ExteriorPower", [ IsGZGradedIrreducibleObject, IsGZGradedIrreducibleObject ] );