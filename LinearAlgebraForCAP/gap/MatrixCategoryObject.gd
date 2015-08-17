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

DeclareCategory( "IsVectorSpaceObject",
                 IsCapCategoryObject );

####################################
##
## Constructors
##
####################################

DeclareOperation( "VectorSpaceObject",
                  [ IsInt, IsFieldForHomalg ] );

####################################
##
## Attributes
##
####################################

DeclareAttribute( "UnderlyingFieldForHomalg",
                  IsVectorSpaceObject );

DeclareAttribute( "Dimension",
                  IsVectorSpaceObject );
