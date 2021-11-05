# SPDX-License-Identifier: GPL-2.0-or-later
# ModulePresentationsForCAP: Category R-pres for CAP
#
# Declarations
#
#! @Chapter Module Presentations

#######################################
##
#! @Section Natural Transformations
##
#######################################

#! @Description
#! The argument is a homalg ring $R$.
#! The output is the natural isomorphism from the identity functor
#! to the left standard module functor.
#! @Returns a natural transformation $\mathrm{Id} \rightarrow \mathrm{StandardModuleLeft}$
#! @Arguments R
DeclareAttribute( "NaturalIsomorphismFromIdentityToStandardModuleLeft",
                  IsHomalgRing );

#! @Description
#! The argument is a homalg ring $R$.
#! The output is the natural isomorphism from the identity functor
#! to the right standard module functor.
#! @Returns a natural transformation $\mathrm{Id} \rightarrow \mathrm{StandardModuleRight}$
#! @Arguments R
DeclareAttribute( "NaturalIsomorphismFromIdentityToStandardModuleRight",
                  IsHomalgRing );

#! @Description
#! The argument is a homalg ring $R$.
#! The output is the natural isomorphism from the identity functor
#! to the functor that gets rid of zero generators of left modules.
#! @Returns a natural transformation $\mathrm{Id} \rightarrow \mathrm{GetRidOfZeroGeneratorsLeft}$
#! @Arguments R
DeclareAttribute( "NaturalIsomorphismFromIdentityToGetRidOfZeroGeneratorsLeft",
                  IsHomalgRing );

#! @Description
#! The argument is a homalg ring $R$.
#! The output is the natural isomorphism from the identity functor
#! to the functor that gets rid of zero generators of right modules.
#! @Returns a natural transformation $\mathrm{Id} \rightarrow \mathrm{GetRidOfZeroGeneratorsRight}$
#! @Arguments R
DeclareAttribute( "NaturalIsomorphismFromIdentityToGetRidOfZeroGeneratorsRight",
                  IsHomalgRing );

#! @Description
#! The argument is a homalg ring $R$.
#! The output is the natural morphism from the identity functor
#! to the left less generators functor.
#! @Returns a natural transformation $\mathrm{Id} \rightarrow \mathrm{LessGeneratorsLeft}$
#! @Arguments R
DeclareAttribute( "NaturalIsomorphismFromIdentityToLessGeneratorsLeft",
                  IsHomalgRing );

#! @Description
#! The argument is a homalg ring $R$.
#! The output is the natural morphism from the identity functor
#! to the right less generator functor.
#! @Returns a natural transformation $\mathrm{Id} \rightarrow \mathrm{LessGeneratorsRight}$
#! @Arguments R
DeclareAttribute( "NaturalIsomorphismFromIdentityToLessGeneratorsRight",
                  IsHomalgRing );

#! @Description
#! The argument is a homalg ring $R$.
#! The output is the natural morphism from the identity functor
#! to the double dual functor in left Presentations category.
#! @Returns a natural transformation $\mathrm{Id} \rightarrow \mathrm{FunctorDoubleDualLeft}$
#! @Arguments R
DeclareAttribute( "NaturalTransformationFromIdentityToDoubleDualLeft",
                  IsHomalgRing );

#! @Description
#! The argument is a homalg ring $R$.
#! The output is the natural morphism from the identity functor
#! to the double dual functor in right Presentations category.
#! @Returns a natural transformation $\mathrm{Id} \rightarrow \mathrm{FunctorDoubleDualRight}$
#! @Arguments R
DeclareAttribute( "NaturalTransformationFromIdentityToDoubleDualRight",
                  IsHomalgRing );
