#############################################################################
##
## GradedModulePresentationsbyFreyd
##
## Copyright 2019,  Martin Bies,       ULB Brussels
##
#! @Chapter Tools for the category of graded module presentations by use of Freyd categories
##
#############################################################################


###############################################
##
#! @Section The Frobenius-power
##
###############################################

# Frobenius power of matrix
DeclareGlobalFunction( "FROBENIUS_POEWR_OF_MATRIX" );

#! @Description
#! The arguments are a CAPPresentationCategoryObject $M$ and a non-negative integer $p$. This method
#! then computes the $p$-th Frobenius power of $M$.
#! @Returns a presentation category object
#! @Arguments M, p
DeclareOperation( "FrobeniusPowerOfFPGradedModule",
                  [ IsFpGradedLeftOrRightModulesObject, IsInt ] );
