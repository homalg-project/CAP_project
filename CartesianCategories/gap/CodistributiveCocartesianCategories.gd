# SPDX-License-Identifier: GPL-2.0-or-later
# CartesianCategories: Cartesian and cocartesian categories and various subdoctrines
#
# Declarations
#
# THIS FILE WAS AUTOMATICALLY GENERATED



####################################
##
#! @Chapter Cocartesian Categories
##
#! @Section Cocartesian Categories
##
####################################

DeclareGlobalVariable( "CODISTRIBUTIVE_COCARTESIAN_CATEGORIES_METHOD_NAME_RECORD" );

#! @Description
#! The arguments are an object $a$
#! and a list of objects $L = (b_1, \dots, b_n)$.
#! The output is the left distributivity morphism
#! $a \sqcup (b_1 \times \dots \times b_n) \rightarrow (a \sqcup b_1) \times \dots \times (a \sqcup b_n)$.
#! @Returns a morphism in $\mathrm{Hom}( a \sqcup (b_1 \times \dots \times b_n), (a \sqcup b_1) \times \dots \times (a \sqcup b_n) )$
#! @Arguments a, L
DeclareOperation( "LeftCocartesianCodistributivityExpanding",
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
DeclareOperation( "LeftCocartesianCodistributivityExpandingWithGivenObjects",
                  [ IsCapCategoryObject, IsCapCategoryObject, IsList, IsCapCategoryObject ] );

#! @Description
#! The arguments are
#! * an object $a$,
#! * a list of objects $L = (b_1, \dots, b_n)$,
#! * a list of positive integers $M = (i_1, \dots, i_n)$.
#!
#! The output is the left distributivity morphism
#! $a \sqcup (\underbrace{b_1 \times \dots \times b_1}_{i_1 \mathrm{times}} \times \dots \times \underbrace{b_n \times \dots \times b_n}_{{i_n \mathrm{times}}}) \rightarrow
#!  \underbrace{(a \sqcup b_1) \times \dots \times (a \sqcup b_1)}_{i_1 \mathrm{times}} \times \dots \times \underbrace{(a \sqcup b_n) \times \dots \times (a \sqcup b_n)}_{i_n \mathrm{times}}$
#! @Returns a morphism in $\mathrm{Hom}( a \sqcup (b_1^{i_1} \times \dots \times b_n^{i_n}), (a \sqcup b_1)^{i_1} \times \dots \times (a \sqcup b_n)^{i_n} )$.
#! @Arguments category, a, L, M
DeclareOperation( "LeftCocartesianCodistributivityExpandingUsingMultiplicities",
                  [ IsCapCategoryObject, IsList, IsList ] );

#! @Description
#! The arguments are
#! * an object $s = a \sqcup (\underbrace{b_1 \times \dots \times b_1}_{i_1 \mathrm{times}} \times \dots \times \underbrace{b_n \times \dots \times b_n}_{{i_n \mathrm{times}}})$,
#! * an object $a$,
#! * a list of objects $L = (b_1, \dots, b_n)$,
#! * a list of positive integers $M = (i_1, \dots, i_n)$,
#! * an object $r = \underbrace{(a \sqcup b_1) \times \dots \times (a \sqcup b_1)}_{i_1 \mathrm{times}} \times \dots \times \underbrace{(a \sqcup b_n) \times \dots \times (a \sqcup b_n)}_{i_n \mathrm{times}}$.
#!
#! The output is the left distributivity morphism $s \rightarrow r$.
#! @Returns a morphism in $\mathrm{Hom}( s, r )$
#! @Arguments category, s, a, L, M, r
DeclareOperation( "LeftCocartesianCodistributivityExpandingUsingMultiplicitiesWithGivenObjects",
                  [ IsCapCategoryObject, IsCapCategoryObject, IsList, IsList, IsCapCategoryObject ] );

#! @Description
#! The arguments are an object $a$
#! and a list of objects $L = (b_1, \dots, b_n)$.
#! The output is the left distributivity morphism
#! $(a \sqcup b_1) \times \dots \times (a \sqcup b_n) \rightarrow a \sqcup (b_1 \times \dots \times b_n)$.
#! @Returns a morphism in $\mathrm{Hom}( (a \sqcup b_1) \times \dots \times (a \sqcup b_n), a \sqcup (b_1 \times \dots \times b_n) )$
#! @Arguments a, L
DeclareOperation( "LeftCocartesianCodistributivityFactoring",
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
DeclareOperation( "LeftCocartesianCodistributivityFactoringWithGivenObjects",
                  [ IsCapCategoryObject, IsCapCategoryObject, IsList, IsCapCategoryObject ] );

#! @Description
#! The arguments are
#! * an object $a$,
#! * a list of objects $L = (b_1, \dots, b_n)$,
#! * a list of positive integers $M = (i_1, \dots, i_n)$.
#!
#! The output is the left distributivity morphism
#! $\underbrace{(a \sqcup b_1) \times \dots \times (a \sqcup b_1)}_{i_1 \mathrm{times}} \times \dots \times \underbrace{(a \sqcup b_n) \times \dots \times (a \sqcup b_n)}_{i_n \mathrm{times}} \rightarrow
#!  a \sqcup (\underbrace{b_1 \times \dots \times b_1}_{i_1 \mathrm{times}} \times \dots \times \underbrace{b_n \times \dots \times b_n}_{{i_n \mathrm{times}}})$
#! @Returns a morphism in $\mathrm{Hom}( (a \sqcup b_1)^{i_1} \times \dots \times (a \sqcup b_n)^{i_n}, a \sqcup (b_1^{i_1} \times \dots \times b_n^{i_n}) )$.
#! @Arguments category, a, L, M
DeclareOperation( "LeftCocartesianCodistributivityFactoringUsingMultiplicities",
                  [ IsCapCategoryObject, IsList, IsList ] );

#! @Description
#! The arguments are
#! * an object $s = \underbrace{(a \sqcup b_1) \times \dots \times (a \sqcup b_1)}_{i_1 \mathrm{times}} \times \dots \times \underbrace{(a \sqcup b_n) \times \dots \times (a \sqcup b_n)}_{i_n \mathrm{times}}$,
#! * an object $a$,
#! * a list of objects $L = (b_1, \dots, b_n)$,
#! * a list of positive integers $M = (i_1, \dots, i_n)$,
#! * an object $r = a \sqcup (\underbrace{b_1 \times \dots \times b_1}_{i_1 \mathrm{times}} \times \dots \times \underbrace{b_n \times \dots \times b_n}_{{i_n \mathrm{times}}})$.
#!
#! The output is the left distributivity morphism $s \rightarrow r$.
#! @Returns a morphism in $\mathrm{Hom}( s, r )$
#! @Arguments category, s, a, L, M, r
DeclareOperation( "LeftCocartesianCodistributivityFactoringUsingMultiplicitiesWithGivenObjects",
                  [ IsCapCategoryObject, IsCapCategoryObject, IsList, IsList, IsCapCategoryObject ] );

#! @Description
#! The arguments are a list of objects $L = (b_1, \dots, b_n)$
#! and an object $a$.
#! The output is the right distributivity morphism
#! $(b_1 \times \dots \times b_n) \sqcup a \rightarrow (b_1 \sqcup a) \times \dots \times (b_n \sqcup a)$.
#! @Returns a morphism in $\mathrm{Hom}( (b_1 \times \dots \times b_n) \sqcup a, (b_1 \sqcup a) \times \dots \times (b_n \sqcup a) )$
#! @Arguments L, a
DeclareOperation( "RightCocartesianCodistributivityExpanding",
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
DeclareOperation( "RightCocartesianCodistributivityExpandingWithGivenObjects",
                  [ IsCapCategoryObject, IsList, IsCapCategoryObject, IsCapCategoryObject ] );

#! @Description
#! The arguments are
#! * a list of objects $L = (b_1, \dots, b_n)$,
#! * a list of positive integers $M = (i_1, \dots, i_n)$,
#! * an object $a$.
#!
#! The output is the right distributivity morphism
#! $(\underbrace{b_1 \times \dots \times b_1}_{i_1 \mathrm{times}} \times \dots \times \underbrace{b_n \times \dots \times b_n}_{{i_n \mathrm{times}}}) \sqcup a \rightarrow
#!  \underbrace{(b_1 \sqcup a) \times \dots \times (b_1 \sqcup a)}_{i_1 \mathrm{times}} \times \dots \times \underbrace{(b_n \sqcup a) \times \dots \times (b_n \sqcup a)}_{i_n \mathrm{times}}$
#! @Returns a morphism in $\mathrm{Hom}( (b_1^{i_1} \times \dots \times b_n^{i_n}) \sqcup a, (b_1 \sqcup a)^{i_1} \times \dots \times (b_n \sqcup a)^{i_n} )$.
#! @Arguments category, a, L, M
DeclareOperation( "RightCocartesianCodistributivityExpandingUsingMultiplicities",
                  [ IsList, IsList, IsCapCategoryObject ] );

#! @Description
#! The arguments are
#! * an object $s = (\underbrace{b_1 \times \dots \times b_1}_{i_1 \mathrm{times}} \times \dots \times \underbrace{b_n \times \dots \times b_n}_{{i_n \mathrm{times}}}) \sqcup a$,
#! * a list of objects $L = (b_1, \dots, b_n)$,
#! * a list of positive integers $M = (i_1, \dots, i_n)$,
#! * an object $a$,
#! * an object $r = \underbrace{(b_1 \sqcup a) \times \dots \times (b_1 \sqcup a)}_{i_1 \mathrm{times}} \times \dots \times \underbrace{(b_n \sqcup a) \times \dots \times (b_n \sqcup a)}_{i_n \mathrm{times}}$.
#!
#! The output is the right distributivity morphism $s \rightarrow r$.
#! @Returns a morphism in $\mathrm{Hom}( s, r )$.
#! @Arguments category, s, L, M, a, r
DeclareOperation( "RightCocartesianCodistributivityExpandingUsingMultiplicitiesWithGivenObjects",
                  [ IsCapCategoryObject, IsList, IsList, IsCapCategoryObject, IsCapCategoryObject ] );

#! @Description
#! The arguments are a list of objects $L = (b_1, \dots, b_n)$
#! and an object $a$.
#! The output is the right distributivity morphism
#! $(b_1 \sqcup a) \times \dots \times (b_n \sqcup a) \rightarrow (b_1 \times \dots \times b_n) \sqcup a $.
#! @Returns a morphism in $\mathrm{Hom}( (b_1 \sqcup a) \times \dots \times (b_n \sqcup a), (b_1 \times \dots \times b_n) \sqcup a)$
#! @Arguments L, a
DeclareOperation( "RightCocartesianCodistributivityFactoring",
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
DeclareOperation( "RightCocartesianCodistributivityFactoringWithGivenObjects",
                  [ IsCapCategoryObject, IsList, IsCapCategoryObject, IsCapCategoryObject ] );

#! @Description
#! The arguments are
#! * a list of objects $L = (b_1, \dots, b_n)$,
#! * a list of positive integers $M = (i_1, \dots, i_n)$,
#! * an object $a$.
#!
#! The output is the right distributivity morphism
#! $\underbrace{(b_1 \sqcup a) \times \dots \times (b_1 \sqcup a)}_{i_1 \mathrm{times}} \times \dots \times \underbrace{(b_n \sqcup a) \times \dots \times (b_n \sqcup a)}_{i_n \mathrm{times}} \rightarrow
#!  (\underbrace{b_1 \times \dots \times b_1}_{i_1 \mathrm{times}} \times \dots \times \underbrace{b_n \times \dots \times b_n}_{{i_n \mathrm{times}}}) \sqcup a$
#! @Returns a morphism in $\mathrm{Hom}( (b_1 \sqcup a)^{i_1} \times \dots \times (b_n \sqcup a)^{i_n}, (b_1^{i_1} \times \dots \times b_n^{i_n}) \sqcup a )$.
#! @Arguments category, a, L, M
DeclareOperation( "RightCocartesianCodistributivityFactoringUsingMultiplicities",
                  [ IsList, IsList, IsCapCategoryObject ] );

#! @Description
#! The arguments are
#! * an object $s = \underbrace{(b_1 \sqcup a) \times \dots \times (b_1 \sqcup a)}_{i_1 \mathrm{times}} \times \dots \times \underbrace{(b_n \sqcup a) \times \dots \times (b_n \sqcup a)}_{i_n \mathrm{times}}$,
#! * a list of objects $L = (b_1, \dots, b_n)$,
#! * a list of positive integers $M = (i_1, \dots, i_n)$,
#! * an object $a$,
#! * an object $r = (\underbrace{b_1 \times \dots \times b_1}_{i_1 \mathrm{times}} \times \dots \times \underbrace{b_n \times \dots \times b_n}_{{i_n \mathrm{times}}}) \sqcup a$.
#!
#! The output is the right distributivity morphism $s \rightarrow r$.
#! @Returns a morphism in $\mathrm{Hom}( s, r )$.
#! @Arguments category, s, L, M, a, r
DeclareOperation( "RightCocartesianCodistributivityFactoringUsingMultiplicitiesWithGivenObjects",
                  [ IsCapCategoryObject, IsList, IsList, IsCapCategoryObject, IsCapCategoryObject ] );

