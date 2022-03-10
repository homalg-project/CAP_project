# SPDX-License-Identifier: GPL-2.0-or-later
# GeneralizedMorphismsForCAP: Implementations of generalized morphisms for the CAP project
#
# Declarations
#

#! @Chapter Conversion functors for generalized morphisms

####################################
##
#! @Section Functors from Cospans
##
####################################

#! @Description
#!  For the given category <A>C</A>, this attribute is the functor from
#!  the cospan generalized morphism category of <A>C</A> to the generalized
#!  morphism category modeled by three arrows.
#! @Arguments C
#! @Returns a functor
DeclareAttribute( "FunctorFromCospansToThreeArrows",
                  IsCapCategory );

#! @Description
#!  For the given category <A>C</A>, this attribute is the functor from
#!  the cospan generalized morphism category of <A>C</A> to the generalized
#!  morphism category modeled by spans.
#! @Arguments C
#! @Returns a functor
DeclareAttribute( "FunctorFromCospansToSpans",
                  IsCapCategory );

####################################
##
#! @Section Functors from Spans
##
####################################

#! @Description
#!  For the given category <A>C</A>, this attribute is the functor from
#!  the span generalized morphism category of <A>C</A> to the generalized
#!  morphism category modeled by three arrows.
#! @Arguments C
#! @Returns a functor
DeclareAttribute( "FunctorFromSpansToThreeArrows",
                  IsCapCategory );

#! @Description
#!  For the given category <A>C</A>, this attribute is the functor from
#!  the span generalized morphism category of <A>C</A> to the generalized
#!  morphism category modeled by cospans.
#! @Arguments C
#! @Returns a functor
DeclareAttribute( "FunctorFromSpansToCospans",
                  IsCapCategory );

####################################
##
#! @Section Functors from Three Arrows
##
####################################

#! @Description
#!  For the given category <A>C</A>, this attribute is the functor from
#!  the three arrow generalized morphism category of <A>C</A> to the generalized
#!  morphism category modeled by cospans.
#! @Arguments C
#! @Returns a functor
DeclareAttribute( "FunctorFromThreeArrowsToCospans",
                  IsCapCategory );

#! @Description
#!  For the given category <A>C</A>, this attribute is the functor from
#!  the three arrow generalized morphism category of <A>C</A> to the generalized
#!  morphism category modeled by spans.
#! @Arguments C
#! @Returns a functor
DeclareAttribute( "FunctorFromThreeArrowsToSpans",
                  IsCapCategory );
