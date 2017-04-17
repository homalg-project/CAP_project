#############################################################################
##
##                                       ModulePresentationsForCAP package
##
##  Copyright 2014, Sebastian Gutsche, TU Kaiserslautern
##                  Sebastian Posur,   RWTH Aachen
##
#! @Chapter Module Presentations
##
#############################################################################

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
#! it a presentation having less generators.
#! @Returns a functor
#! @Arguments R
DeclareAttribute( "FunctorLessGeneratorsLeft",
                  IsHomalgRing );

#! @Description
#! The argument is a homalg ring $R$.
#! The output is functor which takes
#! a right presentation as input and computes
#! it a presentation having less generators.
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
DeclareAttribute( "FunctorDualForLeftPresentations",
                  IsHomalgRing );

#! @Description
#! The argument is a homalg ring $R$ that has an involution function.
#! The output is functor which takes
#! a left presentation <A>M</A> as input and computes
#! its <A>Hom( Hom(M, R), R )</A> as a left presentation.
#! @Returns a functor
#! @Arguments R
DeclareAttribute( "FunctorDoubleDualForLeftPresentations",
                  IsHomalgRing );
