############################################################################
##
##                                ActionsForCAP package
##
##  Copyright 2016, Sebastian Gutsche, University of Siegen
##                  Sebastian Posur,   University of Siegen
##
#! @Chapter G-Irreducible Objects
##
#############################################################################

####################################
##
#! @Section GAP Categories
##
####################################

DeclareCategory( "IsGIrreducibleObject",
                 IsObject );

####################################
##
#! @Section Constructors
##
####################################

DeclareAttribute( "GIrreducibleObject", IsCharacter );

####################################
##
#! @Section Attributes
##
####################################

DeclareAttribute( "UnderlyingCharacter", IsGIrreducibleObject );

DeclareAttribute( "UnderlyingGroup", IsGIrreducibleObject );

DeclareAttribute( "UnderlyingCharacterTable", IsGIrreducibleObject );

DeclareAttribute( "UnderlyingIrreducibleCharacters", IsGIrreducibleObject );

DeclareAttribute( "UnderlyingCharacterNumber", IsGIrreducibleObject );

DeclareAttribute( "SecondExteriorPower", IsGIrreducibleObject );

####################################
##
#! @Section Properties
##
####################################

DeclareProperty( "IsGIrreducibleUnitObject", IsGIrreducibleObject );

####################################
##
#! @Section Operations
##
####################################

DeclareOperation( "Multiplicity", [ IsGIrreducibleObject, IsGIrreducibleObject, IsGIrreducibleObject ] );

DeclareOperation( "\<", [ IsGIrreducibleObject, IsGIrreducibleObject ] );

DeclareOperation( "\*", [ IsGIrreducibleObject, IsGIrreducibleObject ] );

DeclareOperation( "AssociatorFromData", 
                  [ IsGIrreducibleObject, IsGIrreducibleObject, IsGIrreducibleObject, IsList, IsFieldForHomalg ] );

