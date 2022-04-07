# SPDX-License-Identifier: GPL-2.0-or-later
# Toposes: Elementary toposes
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
