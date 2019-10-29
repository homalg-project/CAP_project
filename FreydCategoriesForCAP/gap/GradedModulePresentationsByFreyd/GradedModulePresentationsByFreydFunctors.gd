#############################################################################
##
## GradedModulePresentationsbyFreyd
##
## Copyright 2019,  Martin Bies,       ULB Brussels
##
#! @Chapter Functors in the CAP category of graded module presentations  by use of Freyd categories
##
#############################################################################


# an attribute for homalg_matrices, that allows to represent that matrix 'smaller'
DeclareAttribute( "LessGradedGeneratorsTransformationTripleLeft",
                  IsHomalgMatrix );
DeclareAttribute( "LessGradedGeneratorsTransformationTripleRight",
                  IsHomalgMatrix );


#######################################################
##
#! @Section Functor less_generators for FpGradedModules
##
#######################################################

#! @Description
#! The argument is a graded left or right module presentation $M$. We then return a presentation of this
#! module which uses less generators.
#! @Returns a graded left or right module presentation
#! @Arguments M
DeclareOperation( "LessGradedGenerators",
                  [ IsFpGradedLeftOrRightModulesObject ] );

#! @Description
#! The argument is a graded left or right module presentation morphism $a$. We then return a presentation of this
#! morphism which uses less generators.
#! @Returns a graded left or right module presentation morphism
#! @Arguments a
DeclareOperation( "LessGradedGenerators",
                  [ IsFpGradedLeftOrRightModulesMorphism ] );

# a function that computes the functor 'LessGenerators' for both left and right presentations
DeclareGlobalFunction( "FunctorLessGradedGenerators" );

#! @Description
#! The argument is a homalg graded ring $R$. The output is functor which takes a left 
#! presentation in FpGradedLeftModules as input and computes a presentation having less generators.
#! @Returns a functor
#! @Arguments R
DeclareAttribute( "FunctorLessGradedGeneratorsLeft",
                  IsHomalgGradedRing );

#! @Description
#! The argument is a homalg graded ring $R$. The output is functor which takes a right 
#! presentation in FpGradedRightModules as input and computes a presentation having less generators.
#! @Returns a functor
#! @Arguments R
DeclareAttribute( "FunctorLessGradedGeneratorsRight",
                  IsHomalgGradedRing );




######################################################
##
#! @Section Functor StandardModule for FpGradedModules
##
######################################################

#! @Description
#! The argument is a graded left or right module presentation $M$. We then try to reduce the relations and
#! thereby return a new presentation - the Standard module.
#! @Returns a graded left or right module presentation
#! @Arguments M
DeclareOperation( "GradedStandardModule",
                  [ IsFpGradedLeftOrRightModulesObject ] );

#! @Description
#! The argument is a graded left or right module presentation morphism $a$. We then try to reduce the relations
#! and thereby return a new presentation, which we term the Standard module morphism.
#! @Returns a graded left or right module presentation morphism
#! @Arguments a
DeclareOperation( "GradedStandardModule",
                  [ IsFpGradedLeftOrRightModulesMorphism ] );

# a function that computes the functor 'StandardModule' for both left and right presentations
DeclareGlobalFunction( "FunctorGradedStandardModule" );

#! @Description
#! The argument is a homalg graded ring $R$. The output is functor which takes a left
#! presentation in FpGradedLeftModules as input and computes its standard presentation.
#! @Returns a functor
#! @Arguments R
DeclareAttribute( "FunctorGradedStandardModuleLeft",
                  IsHomalgGradedRing );

#! @Description
#! The argument is a homalg graded ring $R$. The output is functor which takes a right
#! presentation in FpGradedRightModules as input and computes its standard presentation.
#! @Returns a functor
#! @Arguments R
DeclareAttribute( "FunctorGradedStandardModuleRight",
                  IsHomalgGradedRing );



##############################################################
##
#! @Section Functor ByASmallerPresentation for FpGradedModules
##
##############################################################

#! @Description
#! The argument is a graded left or right module presentation $M$. We then return a smaller presentation of this
#! module. This is obtained by first applying 'LessGenerators' and then 'StandardModule'.
#! @Returns a graded left or right module presentation
#! @Arguments M
DeclareOperation( "ByASmallerPresentation",
                  [ IsFpGradedLeftOrRightModulesObject ] );

#! @Description
#! The argument is a graded left or right module presentation morphism $a$. We then return a smaller presentation of this
#! morphism. This is obtained by first applying 'LessGenerators' and then 'StandardModule'.
#! @Returns a graded left or right module presentation morphism
#! @Arguments a
DeclareOperation( "ByASmallerPresentation",
                  [ IsFpGradedLeftOrRightModulesMorphism ] );

# a function that computes the functor 'LessGenerators' for both left and right presentations
DeclareGlobalFunction( "FunctorByASmallerPresentation" );

#! @Description
#! The argument is a homalg graded ring $R$. The output is functor which takes a left
#! presentation in FpGradedLeftModules as input and computes a smaller presentation. The latter is achieved by
#! first applying 'LessGenerators' and then acting with 'StandardModule'.
#! @Returns a functor
#! @Arguments R
DeclareAttribute( "FunctorByASmallerPresentationLeft",
                  IsHomalgGradedRing );

#! @Description
#! The argument is a homalg graded ring $R$. The output is functor which takes a right
#! presentation in FpGradedRightModules as input and computes a smaller presentation. The latter is achieved by
#! first applying 'LessGenerators' and then acting with 'StandardModule'.
#! @Returns a functor
#! @Arguments R
DeclareAttribute( "FunctorByASmallerPresentationRight",
                  IsHomalgGradedRing );
