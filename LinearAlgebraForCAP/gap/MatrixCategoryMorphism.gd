#############################################################################
##
##                                LinearAlgebraForCAP package
##
##  Copyright 2015, Sebastian Gutsche, TU Kaiserslautern
##                  Sebastian Posur,   RWTH Aachen
##
##
#############################################################################

####################################
##
## GAP Category
##
####################################

DeclareCategory( "IsVectorSpaceMorphism",
                 IsCapCategoryMorphism );

####################################
##
## Constructors
##
####################################

DeclareOperation( "VectorSpaceMorphism",
                  [ IsVectorSpaceObject, IsHomalgMatrix, IsVectorSpaceObject ] );

####################################
##
## Attributes
##
####################################

DeclareAttribute( "UnderlyingFieldForHomalg",
                  IsVectorSpaceMorphism );

DeclareAttribute( "UnderlyingHomalgMatrix",
                  IsVectorSpaceMorphism );
