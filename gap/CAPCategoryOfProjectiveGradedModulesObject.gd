#############################################################################
##
##                  CAPCategoryOfProjectiveGradedModules package
##
##  Copyright 2015, Sebastian Gutsche, TU Kaiserslautern
##                  Sebastian Posur,   RWTH Aachen
##                  Martin Bies,       ITP Heidelberg
##
##
#############################################################################

####################################
##
## GAP Category
##
####################################

DeclareCategory( "IsCAPCategoryOfProjectiveGradedModulesObject",
                 IsCapCategoryObject );

####################################
##
## Constructors
##
####################################

DeclareOperation( "CAPCategoryOfProjectiveGradedModulesObject",
                  [ IsList, IsHomalgGradedRing ] );

####################################
##
## Attributes
##
####################################

DeclareAttribute( "UnderlyingHomalgGradedRing",
                  IsCAPCategoryOfProjectiveGradedModulesObject );

DeclareAttribute( "DegreeList",
                  IsCAPCategoryOfProjectiveGradedModulesObject );
                  
DeclareAttribute( "RankOfObject",
                  IsCAPCategoryOfProjectiveGradedModulesObject );