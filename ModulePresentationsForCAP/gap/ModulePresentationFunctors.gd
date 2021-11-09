# SPDX-License-Identifier: GPL-2.0-or-later
# ModulePresentationsForCAP: Category R-pres for CAP
#
# Declarations
#
#! @Chapter Module Presentations

#######################################
##
#! @Section Functors
##
#######################################

#! @Description
#! The argument is a homalg ring $R$.
#! The output is a functor which takes
#! a left presentation as input and computes
#! its standard presentation.
#! @Returns a functor
#! @Arguments R
DeclareAttribute( "FunctorStandardModuleLeft",
                  IsHomalgRing );

#! @Description
#! The argument is a homalg ring $R$.
#! The output is a functor which takes
#! a right presentation as input and computes
#! its standard presentation.
#! @Returns a functor
#! @Arguments R
DeclareAttribute( "FunctorStandardModuleRight",
                  IsHomalgRing );

#! @Description
#! The argument is a homalg ring $R$.
#! The output is a functor which takes
#! a left presentation as input and gets
#! rid of the zero generators.
#! @Returns a functor
#! @Arguments R
DeclareAttribute( "FunctorGetRidOfZeroGeneratorsLeft",
                  IsHomalgRing );

#! @Description
#! The argument is a homalg ring $R$.
#! The output is a functor which takes
#! a right presentation as input and gets
#! rid of the zero generators.
#! @Returns a functor
#! @Arguments R
DeclareAttribute( "FunctorGetRidOfZeroGeneratorsRight",
                  IsHomalgRing );

#! @Description
#! The argument is a homalg ring $R$.
#! The output is functor which takes
#! a left presentation as input and computes
#! a presentation having less generators.
#! @Returns a functor
#! @Arguments R
DeclareAttribute( "FunctorLessGeneratorsLeft",
                  IsHomalgRing );

#! @Description
#! The argument is a homalg ring $R$.
#! The output is functor which takes
#! a right presentation as input and computes
#! a presentation having less generators.
#! @Returns a functor
#! @Arguments R
DeclareAttribute( "FunctorLessGeneratorsRight",
                  IsHomalgRing );

#! @Description
#! The argument is a homalg ring $R$ that has an involution function.
#! The output is functor which takes
#! a left presentation <A>M</A> as input and computes
#! its Hom(M, R) as a left presentation.
#! @Returns a functor
#! @Arguments R
DeclareAttribute( "FunctorDualLeft",
                  IsHomalgRing );

#! @Description
#! The argument is a homalg ring $R$ that has an involution function.
#! The output is functor which takes
#! a right presentation <A>M</A> as input and computes
#! its Hom(M, R) as a right presentation.
#! @Returns a functor
#! @Arguments R
DeclareAttribute( "FunctorDualRight",
                  IsHomalgRing );

#! @Description
#! The argument is a homalg ring $R$ that has an involution function.
#! The output is functor which takes
#! a left presentation <A>M</A> as input and computes
#! its <A>Hom( Hom(M, R), R )</A> as a left presentation.
#! @Returns a functor
#! @Arguments R
DeclareAttribute( "FunctorDoubleDualLeft",
                  IsHomalgRing );

#! @Description
#! The argument is a homalg ring $R$ that has an involution function.
#! The output is functor which takes
#! a right presentation <A>M</A> as input and computes
#! its <A>Hom( Hom(M, R), R )</A> as a right presentation.
#! @Returns a functor
#! @Arguments R
DeclareAttribute( "FunctorDoubleDualRight",
                  IsHomalgRing );
