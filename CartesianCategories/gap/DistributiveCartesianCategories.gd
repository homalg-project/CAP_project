# SPDX-License-Identifier: GPL-2.0-or-later
# CartesianCategories: Cartesian and cocartesian categories and various subdoctrines
#
# Declarations
#
# THIS FILE WAS AUTOMATICALLY GENERATED



####################################
##
#! @Chapter Cartesian Categories
##
#! @Section Cartesian Categories
##
####################################

DeclareGlobalVariable( "DISTRIBUTIVE_CARTESIAN_CATEGORIES_METHOD_NAME_RECORD" );

#! @Description
#! The arguments are an object $a$
#! and a list of objects $L = (b_1, \dots, b_n)$.
#! The output is the left distributivity morphism
#! $a \times (b_1 \sqcup \dots \sqcup b_n) \rightarrow (a \times b_1) \sqcup \dots \sqcup (a \times b_n)$.
#! @Returns a morphism in $\mathrm{Hom}( a \times (b_1 \sqcup \dots \sqcup b_n), (a \times b_1) \sqcup \dots \sqcup (a \times b_n) )$
#! @Arguments a, L
DeclareOperation( "LeftCartesianDistributivityExpanding",
                  [ IsCapCategoryObject, IsList ] );

#! @Description
#! The arguments are an object $s = a \times (b_1 \sqcup \dots \sqcup b_n)$,
#! an object $a$,
#! a list of objects $L = (b_1, \dots, b_n)$,
#! and an object $r = (a \times b_1) \sqcup \dots \sqcup (a \times b_n)$.
#! The output is the left distributivity morphism
#! $s \rightarrow r$.
#! @Returns a morphism in $\mathrm{Hom}( s, r )$
#! @Arguments s, a, L, r
DeclareOperation( "LeftCartesianDistributivityExpandingWithGivenObjects",
                  [ IsCapCategoryObject, IsCapCategoryObject, IsList, IsCapCategoryObject ] );

#! @Description
#! The arguments are
#! * an object $a$,
#! * a list of objects $L = (b_1, \dots, b_n)$,
#! * a list of positive integers $M = (i_1, \dots, i_n)$.
#!
#! The output is the left distributivity morphism
#! $a \times (\underbrace{b_1 \sqcup \dots \sqcup b_1}_{i_1 \mathrm{times}} \sqcup \dots \sqcup \underbrace{b_n \sqcup \dots \sqcup b_n}_{{i_n \mathrm{times}}}) \rightarrow
#!  \underbrace{(a \times b_1) \sqcup \dots \sqcup (a \times b_1)}_{i_1 \mathrm{times}} \sqcup \dots \sqcup \underbrace{(a \times b_n) \sqcup \dots \sqcup (a \times b_n)}_{i_n \mathrm{times}}$
#! @Returns a morphism in $\mathrm{Hom}( a \times (b_1^{i_1} \sqcup \dots \sqcup b_n^{i_n}), (a \times b_1)^{i_1} \sqcup \dots \sqcup (a \times b_n)^{i_n} )$.
#! @Arguments category, a, L, M
DeclareOperation( "LeftCartesianDistributivityExpandingUsingMultiplicities",
                  [ IsCapCategoryObject, IsList, IsList ] );

#! @Description
#! The arguments are
#! * an object $s = a \times (\underbrace{b_1 \sqcup \dots \sqcup b_1}_{i_1 \mathrm{times}} \sqcup \dots \sqcup \underbrace{b_n \sqcup \dots \sqcup b_n}_{{i_n \mathrm{times}}})$,
#! * an object $a$,
#! * a list of objects $L = (b_1, \dots, b_n)$,
#! * a list of positive integers $M = (i_1, \dots, i_n)$,
#! * an object $r = \underbrace{(a \times b_1) \sqcup \dots \sqcup (a \times b_1)}_{i_1 \mathrm{times}} \sqcup \dots \sqcup \underbrace{(a \times b_n) \sqcup \dots \sqcup (a \times b_n)}_{i_n \mathrm{times}}$.
#!
#! The output is the left distributivity morphism $s \rightarrow r$.
#! @Returns a morphism in $\mathrm{Hom}( s, r )$
#! @Arguments category, s, a, L, M, r
DeclareOperation( "LeftCartesianDistributivityExpandingUsingMultiplicitiesWithGivenObjects",
                  [ IsCapCategoryObject, IsCapCategoryObject, IsList, IsList, IsCapCategoryObject ] );

#! @Description
#! The arguments are an object $a$
#! and a list of objects $L = (b_1, \dots, b_n)$.
#! The output is the left distributivity morphism
#! $(a \times b_1) \sqcup \dots \sqcup (a \times b_n) \rightarrow a \times (b_1 \sqcup \dots \sqcup b_n)$.
#! @Returns a morphism in $\mathrm{Hom}( (a \times b_1) \sqcup \dots \sqcup (a \times b_n), a \times (b_1 \sqcup \dots \sqcup b_n) )$
#! @Arguments a, L
DeclareOperation( "LeftCartesianDistributivityFactoring",
                  [ IsCapCategoryObject, IsList ] );

#! @Description
#! The arguments are an object $s = (a \times b_1) \sqcup \dots \sqcup (a \times b_n)$,
#! an object $a$,
#! a list of objects $L = (b_1, \dots, b_n)$,
#! and an object $r = a \times (b_1 \sqcup \dots \sqcup b_n)$.
#! The output is the left distributivity morphism
#! $s \rightarrow r$.
#! @Returns a morphism in $\mathrm{Hom}( s, r )$
#! @Arguments s, a, L, r
DeclareOperation( "LeftCartesianDistributivityFactoringWithGivenObjects",
                  [ IsCapCategoryObject, IsCapCategoryObject, IsList, IsCapCategoryObject ] );

#! @Description
#! The arguments are
#! * an object $a$,
#! * a list of objects $L = (b_1, \dots, b_n)$,
#! * a list of positive integers $M = (i_1, \dots, i_n)$.
#!
#! The output is the left distributivity morphism
#! $\underbrace{(a \times b_1) \sqcup \dots \sqcup (a \times b_1)}_{i_1 \mathrm{times}} \sqcup \dots \sqcup \underbrace{(a \times b_n) \sqcup \dots \sqcup (a \times b_n)}_{i_n \mathrm{times}} \rightarrow
#!  a \times (\underbrace{b_1 \sqcup \dots \sqcup b_1}_{i_1 \mathrm{times}} \sqcup \dots \sqcup \underbrace{b_n \sqcup \dots \sqcup b_n}_{{i_n \mathrm{times}}})$
#! @Returns a morphism in $\mathrm{Hom}( (a \times b_1)^{i_1} \sqcup \dots \sqcup (a \times b_n)^{i_n}, a \times (b_1^{i_1} \sqcup \dots \sqcup b_n^{i_n}) )$.
#! @Arguments category, a, L, M
DeclareOperation( "LeftCartesianDistributivityFactoringUsingMultiplicities",
                  [ IsCapCategoryObject, IsList, IsList ] );

#! @Description
#! The arguments are
#! * an object $s = \underbrace{(a \times b_1) \sqcup \dots \sqcup (a \times b_1)}_{i_1 \mathrm{times}} \sqcup \dots \sqcup \underbrace{(a \times b_n) \sqcup \dots \sqcup (a \times b_n)}_{i_n \mathrm{times}}$,
#! * an object $a$,
#! * a list of objects $L = (b_1, \dots, b_n)$,
#! * a list of positive integers $M = (i_1, \dots, i_n)$,
#! * an object $r = a \times (\underbrace{b_1 \sqcup \dots \sqcup b_1}_{i_1 \mathrm{times}} \sqcup \dots \sqcup \underbrace{b_n \sqcup \dots \sqcup b_n}_{{i_n \mathrm{times}}})$.
#!
#! The output is the left distributivity morphism $s \rightarrow r$.
#! @Returns a morphism in $\mathrm{Hom}( s, r )$
#! @Arguments category, s, a, L, M, r
DeclareOperation( "LeftCartesianDistributivityFactoringUsingMultiplicitiesWithGivenObjects",
                  [ IsCapCategoryObject, IsCapCategoryObject, IsList, IsList, IsCapCategoryObject ] );

#! @Description
#! The arguments are a list of objects $L = (b_1, \dots, b_n)$
#! and an object $a$.
#! The output is the right distributivity morphism
#! $(b_1 \sqcup \dots \sqcup b_n) \times a \rightarrow (b_1 \times a) \sqcup \dots \sqcup (b_n \times a)$.
#! @Returns a morphism in $\mathrm{Hom}( (b_1 \sqcup \dots \sqcup b_n) \times a, (b_1 \times a) \sqcup \dots \sqcup (b_n \times a) )$
#! @Arguments L, a
DeclareOperation( "RightCartesianDistributivityExpanding",
                  [ IsList, IsCapCategoryObject ] );

#! @Description
#! The arguments are an object $s = (b_1 \sqcup \dots \sqcup b_n) \times a$,
#! a list of objects $L = (b_1, \dots, b_n)$,
#! an object $a$,
#! and an object $r = (b_1 \times a) \sqcup \dots \sqcup (b_n \times a)$.
#! The output is the right distributivity morphism
#! $s \rightarrow r$.
#! @Returns a morphism in $\mathrm{Hom}( s, r )$
#! @Arguments s, L, a, r
DeclareOperation( "RightCartesianDistributivityExpandingWithGivenObjects",
                  [ IsCapCategoryObject, IsList, IsCapCategoryObject, IsCapCategoryObject ] );

#! @Description
#! The arguments are
#! * a list of objects $L = (b_1, \dots, b_n)$,
#! * a list of positive integers $M = (i_1, \dots, i_n)$,
#! * an object $a$.
#!
#! The output is the right distributivity morphism
#! $(\underbrace{b_1 \sqcup \dots \sqcup b_1}_{i_1 \mathrm{times}} \sqcup \dots \sqcup \underbrace{b_n \sqcup \dots \sqcup b_n}_{{i_n \mathrm{times}}}) \times a \rightarrow
#!  \underbrace{(b_1 \times a) \sqcup \dots \sqcup (b_1 \times a)}_{i_1 \mathrm{times}} \sqcup \dots \sqcup \underbrace{(b_n \times a) \sqcup \dots \sqcup (b_n \times a)}_{i_n \mathrm{times}}$
#! @Returns a morphism in $\mathrm{Hom}( (b_1^{i_1} \sqcup \dots \sqcup b_n^{i_n}) \times a, (b_1 \times a)^{i_1} \sqcup \dots \sqcup (b_n \times a)^{i_n} )$.
#! @Arguments category, a, L, M
DeclareOperation( "RightCartesianDistributivityExpandingUsingMultiplicities",
                  [ IsList, IsList, IsCapCategoryObject ] );

#! @Description
#! The arguments are
#! * an object $s = (\underbrace{b_1 \sqcup \dots \sqcup b_1}_{i_1 \mathrm{times}} \sqcup \dots \sqcup \underbrace{b_n \sqcup \dots \sqcup b_n}_{{i_n \mathrm{times}}}) \times a$,
#! * a list of objects $L = (b_1, \dots, b_n)$,
#! * a list of positive integers $M = (i_1, \dots, i_n)$,
#! * an object $a$,
#! * an object $r = \underbrace{(b_1 \times a) \sqcup \dots \sqcup (b_1 \times a)}_{i_1 \mathrm{times}} \sqcup \dots \sqcup \underbrace{(b_n \times a) \sqcup \dots \sqcup (b_n \times a)}_{i_n \mathrm{times}}$.
#!
#! The output is the right distributivity morphism $s \rightarrow r$.
#! @Returns a morphism in $\mathrm{Hom}( s, r )$.
#! @Arguments category, s, L, M, a, r
DeclareOperation( "RightCartesianDistributivityExpandingUsingMultiplicitiesWithGivenObjects",
                  [ IsCapCategoryObject, IsList, IsList, IsCapCategoryObject, IsCapCategoryObject ] );

#! @Description
#! The arguments are a list of objects $L = (b_1, \dots, b_n)$
#! and an object $a$.
#! The output is the right distributivity morphism
#! $(b_1 \times a) \sqcup \dots \sqcup (b_n \times a) \rightarrow (b_1 \sqcup \dots \sqcup b_n) \times a $.
#! @Returns a morphism in $\mathrm{Hom}( (b_1 \times a) \sqcup \dots \sqcup (b_n \times a), (b_1 \sqcup \dots \sqcup b_n) \times a)$
#! @Arguments L, a
DeclareOperation( "RightCartesianDistributivityFactoring",
                  [ IsList, IsCapCategoryObject ] );

#! @Description
#! The arguments are an object $s = (b_1 \times a) \sqcup \dots \sqcup (b_n \times a)$,
#! a list of objects $L = (b_1, \dots, b_n)$,
#! an object $a$,
#! and an object $r = (b_1 \sqcup \dots \sqcup b_n) \times a$.
#! The output is the right distributivity morphism
#! $s \rightarrow r$.
#! @Returns a morphism in $\mathrm{Hom}( s, r )$
#! @Arguments s, L, a, r
DeclareOperation( "RightCartesianDistributivityFactoringWithGivenObjects",
                  [ IsCapCategoryObject, IsList, IsCapCategoryObject, IsCapCategoryObject ] );

#! @Description
#! The arguments are
#! * a list of objects $L = (b_1, \dots, b_n)$,
#! * a list of positive integers $M = (i_1, \dots, i_n)$,
#! * an object $a$.
#!
#! The output is the right distributivity morphism
#! $\underbrace{(b_1 \times a) \sqcup \dots \sqcup (b_1 \times a)}_{i_1 \mathrm{times}} \sqcup \dots \sqcup \underbrace{(b_n \times a) \sqcup \dots \sqcup (b_n \times a)}_{i_n \mathrm{times}} \rightarrow
#!  (\underbrace{b_1 \sqcup \dots \sqcup b_1}_{i_1 \mathrm{times}} \sqcup \dots \sqcup \underbrace{b_n \sqcup \dots \sqcup b_n}_{{i_n \mathrm{times}}}) \times a$
#! @Returns a morphism in $\mathrm{Hom}( (b_1 \times a)^{i_1} \sqcup \dots \sqcup (b_n \times a)^{i_n}, (b_1^{i_1} \sqcup \dots \sqcup b_n^{i_n}) \times a )$.
#! @Arguments category, a, L, M
DeclareOperation( "RightCartesianDistributivityFactoringUsingMultiplicities",
                  [ IsList, IsList, IsCapCategoryObject ] );

#! @Description
#! The arguments are
#! * an object $s = \underbrace{(b_1 \times a) \sqcup \dots \sqcup (b_1 \times a)}_{i_1 \mathrm{times}} \sqcup \dots \sqcup \underbrace{(b_n \times a) \sqcup \dots \sqcup (b_n \times a)}_{i_n \mathrm{times}}$,
#! * a list of objects $L = (b_1, \dots, b_n)$,
#! * a list of positive integers $M = (i_1, \dots, i_n)$,
#! * an object $a$,
#! * an object $r = (\underbrace{b_1 \sqcup \dots \sqcup b_1}_{i_1 \mathrm{times}} \sqcup \dots \sqcup \underbrace{b_n \sqcup \dots \sqcup b_n}_{{i_n \mathrm{times}}}) \times a$.
#!
#! The output is the right distributivity morphism $s \rightarrow r$.
#! @Returns a morphism in $\mathrm{Hom}( s, r )$.
#! @Arguments category, s, L, M, a, r
DeclareOperation( "RightCartesianDistributivityFactoringUsingMultiplicitiesWithGivenObjects",
                  [ IsCapCategoryObject, IsList, IsList, IsCapCategoryObject, IsCapCategoryObject ] );

