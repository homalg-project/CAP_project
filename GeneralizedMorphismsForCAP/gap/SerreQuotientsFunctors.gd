# SPDX-License-Identifier: GPL-2.0-or-later
# GeneralizedMorphismsForCAP: Implementations of generalized morphisms for the CAP project
#
# Declarations
#

#! @Chapter Serre Quotients Functors

#! The operations in this chapter construct conversion functors between two
#! Serre quotients of different standards.
#! Please note that all the operations DO NOT CARE if the Serre quotients
#! are modeling the same category, they only care wether the categories are
#! based upon the same underlying honest category.

####################################
##
#! @Section Functors
##
####################################

#! @Description
#!  Given two Serre quotients <A>A</A> and <A>B</A> of the same category <A>C</A> by equivalent functions, this operation
#!  returns the conversion functor between the two categories. Please note that this function does not check the
#!  quotients in any sense, i.e., wether the functions are equivalent.
#! @Arguments A,B
#! @Returns a functor
DeclareOperation( "SerreQuotientConversionFunctor",
                  [ IsCapCategory, IsCapCategory ] );

