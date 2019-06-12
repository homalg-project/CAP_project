##############################################################################################
##
## GradedModulePresentationsbyFreyd
##
## Copyright 2019,  Martin Bies,       ULB Brussels
##
#! @Chapter The CAP category of graded module presentations for CAP by use of Freyd categories
##
##############################################################################################



######################################
##
#! @Section CAP categories
##
######################################

#! @Description
#! Given a graded ring <A>S</A>, one can consider the category of f.p. graded left $S$-modules, which is 
#! captured by this attribute.
#! @Returns a CapCategory
#! @Arguments S
DeclareAttribute( "FpGradedLeftModules",
                 IsHomalgGradedRing );

#! @Description
#! Given a graded ring <A>S</A>, one can consider the category of f.p. graded right $S$-modules, which is 
#! captured by this attribute.
#! @Returns a CapCategory
#! @Arguments S
DeclareAttribute( "FpGradedRightModules",
                 IsHomalgGradedRing ); 

DeclareCategory( "IsFpGradedLeftModules", IsCapCategory );

DeclareCategory( "IsFpGradedRightModules", IsCapCategory );

######################################################################
##
#! @Section The GAP categories for graded module presentations for CAP
##
######################################################################

#! @Description
#! The GAP category of graded left and right module presentations.
#! @Arguments object
DeclareCategory( "IsFpGradedLeftOrRightModulesObject",
                 IsFreydCategoryObject );

#! @Description
#! The GAP category of objects in the presentation category over the category of projective graded left modules.
#! @Arguments object
DeclareCategory( "IsFpGradedLeftModulesObject",
                 IsFpGradedLeftOrRightModulesObject );

#! @Description
#! The GAP category of objects in the presentation category over the category of projective graded right modules.
#! @Arguments object
DeclareCategory( "IsFpGradedRightModulesObject",
                 IsFpGradedLeftOrRightModulesObject );



###############################################################################
##
#! @Section The GAP categories for graded module presentation morphisms for CAP
##
###############################################################################

#! @Description
#! The GAP category of left or right module presentation morphisms
#! @Arguments object
DeclareCategory( "IsFpGradedLeftOrRightModulesMorphism",
                 IsFreydCategoryMorphism );

#! @Description
#! The GAP category of morphisms in the presentation category over the category of projective graded left modules.
#! @Arguments object
DeclareCategory( "IsFpGradedLeftModulesMorphism",
                 IsFpGradedLeftOrRightModulesMorphism );

#! @Description
#! The GAP category of morphisms in the presentation category over the category of projective graded right modules.
#! @Arguments object
DeclareCategory( "IsFpGradedRightModulesMorphism",
                 IsFpGradedLeftOrRightModulesMorphism );
