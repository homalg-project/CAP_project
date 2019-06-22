#############################################################################
##
## GradedModulePresentationsbyFreyd
##
## Copyright 2019,  Martin Bies,       ULB Brussels
##
#! @Chapter Natural transformations for FPGradedModules
##
#############################################################################


####################################################################################
##
#! @Section Natural isomorphism from identity functor to the standard module functor
##
####################################################################################

# a function that computes the natural isomorphism $1 \Rightarrow \mathrm{StandardModule}$ for both
# left and right presentations
DeclareGlobalFunction( "NaturalIsomorphismFromIdentityToGradedStandardModule" );

#! @Description
#! The argument is a homalg graded ring $S$. The output is the natural morphism from the identity functor
#! to the left standard module functor.
#! @Returns a natural transformation $\mathrm{Id} \Rightarrow \mathrm{StandardModuleLeft}$
#! @Arguments S
DeclareAttribute( "NaturalIsomorphismFromIdentityToGradedStandardModuleLeft",
                  IsHomalgGradedRing );

#! @Description
#! The argument is a homalg ring $S$. The output is the natural morphism from the identity functor
#! to the right standard module functor.
#! @Returns a natural transformation $\mathrm{Id} \Rightarrow \mathrm{StandardModuleRight}$
#! @Arguments S
DeclareAttribute( "NaturalIsomorphismFromIdentityToGradedStandardModuleRight",
                  IsHomalgGradedRing );
