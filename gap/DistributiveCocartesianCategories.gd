# THIS FILE WAS AUTOMATICALLY GENERATED
# FROM MonoidalCategories v2021.12-07
# USING CategoryConstructor v2021.12-05

# SPDX-License-Identifier: GPL-2.0-or-later
# Toposes: Elementary toposes
#
# Declarations
#

####################################
##
#! @Chapter Cocartesian Categories
##
#! @Section Cocartesian Categories
##
####################################

DeclareGlobalVariable( "DISTRIBUTIVE_COCARTESIAN_CATEGORIES_METHOD_NAME_RECORD" );

#! @Description
#! The arguments are an object $a$
#! and a list of objects $L = (b_1, \dots, b_n)$.
#! The output is the left distributivity morphism
#! $a \sqcup (b_1 \times \dots \times b_n) \rightarrow (a \sqcup b_1) \times \dots \times (a \sqcup b_n)$.
#! @Returns a morphism in $\mathrm{Hom}( a \sqcup (b_1 \times \dots \times b_n), (a \sqcup b_1) \times \dots \times (a \sqcup b_n) )$
#! @Arguments a, L
DeclareOperation( "LeftCocartesianDistributivityExpanding",
                  [ IsCapCategoryObject, IsList ] );

#! @Description
#! The arguments are an object $s = a \sqcup (b_1 \times \dots \times b_n)$,
#! an object $a$,
#! a list of objects $L = (b_1, \dots, b_n)$,
#! and an object $r = (a \sqcup b_1) \times \dots \times (a \sqcup b_n)$.
#! The output is the left distributivity morphism
#! $s \rightarrow r$.
#! @Returns a morphism in $\mathrm{Hom}( s, r )$
#! @Arguments s, a, L, r
DeclareOperation( "LeftCocartesianDistributivityExpandingWithGivenObjects",
                  [ IsCapCategoryObject, IsCapCategoryObject, IsList, IsCapCategoryObject ] );

#! @Description
#! The arguments are an object $a$
#! and a list of objects $L = (b_1, \dots, b_n)$.
#! The output is the left distributivity morphism
#! $(a \sqcup b_1) \times \dots \times (a \sqcup b_n) \rightarrow a \sqcup (b_1 \times \dots \times b_n)$.
#! @Returns a morphism in $\mathrm{Hom}( (a \sqcup b_1) \times \dots \times (a \sqcup b_n), a \sqcup (b_1 \times \dots \times b_n) )$
#! @Arguments a, L
DeclareOperation( "LeftCocartesianDistributivityFactoring",
                  [ IsCapCategoryObject, IsList ] );

#! @Description
#! The arguments are an object $s = (a \sqcup b_1) \times \dots \times (a \sqcup b_n)$,
#! an object $a$,
#! a list of objects $L = (b_1, \dots, b_n)$,
#! and an object $r = a \sqcup (b_1 \times \dots \times b_n)$.
#! The output is the left distributivity morphism
#! $s \rightarrow r$.
#! @Returns a morphism in $\mathrm{Hom}( s, r )$
#! @Arguments s, a, L, r
DeclareOperation( "LeftCocartesianDistributivityFactoringWithGivenObjects",
                  [ IsCapCategoryObject, IsCapCategoryObject, IsList, IsCapCategoryObject ] );

#! @Description
#! The arguments are a list of objects $L = (b_1, \dots, b_n)$
#! and an object $a$.
#! The output is the right distributivity morphism
#! $(b_1 \times \dots \times b_n) \sqcup a \rightarrow (b_1 \sqcup a) \times \dots \times (b_n \sqcup a)$.
#! @Returns a morphism in $\mathrm{Hom}( (b_1 \times \dots \times b_n) \sqcup a, (b_1 \sqcup a) \times \dots \times (b_n \sqcup a) )$
#! @Arguments L, a
DeclareOperation( "RightCocartesianDistributivityExpanding",
                  [ IsList, IsCapCategoryObject ] );

#! @Description
#! The arguments are an object $s = (b_1 \times \dots \times b_n) \sqcup a$,
#! a list of objects $L = (b_1, \dots, b_n)$,
#! an object $a$,
#! and an object $r = (b_1 \sqcup a) \times \dots \times (b_n \sqcup a)$.
#! The output is the right distributivity morphism
#! $s \rightarrow r$.
#! @Returns a morphism in $\mathrm{Hom}( s, r )$
#! @Arguments s, L, a, r
DeclareOperation( "RightCocartesianDistributivityExpandingWithGivenObjects",
                  [ IsCapCategoryObject, IsList, IsCapCategoryObject, IsCapCategoryObject ] );

#! @Description
#! The arguments are a list of objects $L = (b_1, \dots, b_n)$
#! and an object $a$.
#! The output is the right distributivity morphism
#! $(b_1 \sqcup a) \times \dots \times (b_n \sqcup a) \rightarrow (b_1 \times \dots \times b_n) \sqcup a $.
#! @Returns a morphism in $\mathrm{Hom}( (b_1 \sqcup a) \times \dots \times (b_n \sqcup a), (b_1 \times \dots \times b_n) \sqcup a)$
#! @Arguments L, a
DeclareOperation( "RightCocartesianDistributivityFactoring",
                  [ IsList, IsCapCategoryObject ] );

#! @Description
#! The arguments are an object $s = (b_1 \sqcup a) \times \dots \times (b_n \sqcup a)$,
#! a list of objects $L = (b_1, \dots, b_n)$,
#! an object $a$,
#! and an object $r = (b_1 \times \dots \times b_n) \sqcup a$.
#! The output is the right distributivity morphism
#! $s \rightarrow r$.
#! @Returns a morphism in $\mathrm{Hom}( s, r )$
#! @Arguments s, L, a, r
DeclareOperation( "RightCocartesianDistributivityFactoringWithGivenObjects",
                  [ IsCapCategoryObject, IsList, IsCapCategoryObject, IsCapCategoryObject ] );
