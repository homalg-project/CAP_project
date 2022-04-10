# SPDX-License-Identifier: GPL-2.0-or-later
# Toposes: Elementary toposes
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

DeclareGlobalVariable( "DISTRIBUTIVE_COCARTESIAN_CATEGORIES_METHOD_NAME_RECORD" );

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
