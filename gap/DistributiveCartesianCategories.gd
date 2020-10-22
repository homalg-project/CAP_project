# SPDX-License-Identifier: GPL-2.0-or-later
# Toposes: Elementary toposes
#
# Declarations
#

####################################
##
#! @Chapter Cartesian Categories
##
#! @Section Cartesian Categories
##
####################################

DeclareGlobalVariable( "CAP_INTERNAL_DISTRIBUTIVE_CARTESIAN_CATEGORIES_BASIC_OPERATIONS" );

DeclareGlobalVariable( "DISTRIBUTIVE_CARTESIAN_CATEGORIES_METHOD_NAME_RECORD" );

##
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
#! The arguments are a category $C$ and a function $F$.
#! This operation adds the given function $F$ 
#! to the category for the basic operation <C>LeftCartesianDistributivityExpandingWithGivenObjects</C>.
#! $F: (a \times (b_1 \sqcup \dots \sqcup b_n), a, L, (a \times b_1) \sqcup \dots \sqcup (a \times b_n)) \mapsto \mathrm{LeftCartesianDistributivityExpandingWithGivenObjects}(a,L)$.
#! @Returns nothing
#! @Arguments C, F
DeclareOperation( "AddLeftCartesianDistributivityExpandingWithGivenObjects",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddLeftCartesianDistributivityExpandingWithGivenObjects",
                  [ IsCapCategory, IsFunction, IsInt ] );

DeclareOperation( "AddLeftCartesianDistributivityExpandingWithGivenObjects",
                  [ IsCapCategory, IsList, IsInt ] );

DeclareOperation( "AddLeftCartesianDistributivityExpandingWithGivenObjects",
                  [ IsCapCategory, IsList ] );


##
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
#! The arguments are a category $C$ and a function $F$.
#! This operation adds the given function $F$ 
#! to the category for the basic operation <C>LeftCartesianDistributivityFactoringWithGivenObjects</C>.
#! $F: ((a \times b_1) \sqcup \dots \sqcup (a \times b_n), a, L, a \times (b_1 \sqcup \dots \sqcup b_n)) \mapsto \mathrm{LeftCartesianDistributivityFactoringWithGivenObjects}(a,L)$.
#! @Returns nothing
#! @Arguments C, F
DeclareOperation( "AddLeftCartesianDistributivityFactoringWithGivenObjects",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddLeftCartesianDistributivityFactoringWithGivenObjects",
                  [ IsCapCategory, IsFunction, IsInt ] );

DeclareOperation( "AddLeftCartesianDistributivityFactoringWithGivenObjects",
                  [ IsCapCategory, IsList, IsInt ] );

DeclareOperation( "AddLeftCartesianDistributivityFactoringWithGivenObjects",
                  [ IsCapCategory, IsList ] );

##
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
#! The arguments are a category $C$ and a function $F$.
#! This operation adds the given function $F$ 
#! to the category for the basic operation <C>RightCartesianDistributivityExpandingWithGivenObjects</C>.
#! $F: ((b_1 \sqcup \dots \sqcup b_n) \times a, L, a, (b_1 \times a) \sqcup \dots \sqcup (b_n \times a)) \mapsto \mathrm{RightCartesianDistributivityExpandingWithGivenObjects}(L,a)$.
#! @Returns nothing
#! @Arguments C, F
DeclareOperation( "AddRightCartesianDistributivityExpandingWithGivenObjects",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddRightCartesianDistributivityExpandingWithGivenObjects",
                  [ IsCapCategory, IsFunction, IsInt ] );

DeclareOperation( "AddRightCartesianDistributivityExpandingWithGivenObjects",
                  [ IsCapCategory, IsList, IsInt ] );

DeclareOperation( "AddRightCartesianDistributivityExpandingWithGivenObjects",
                  [ IsCapCategory, IsList ] );

##
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
#! The arguments are a category $C$ and a function $F$.
#! This operation adds the given function $F$ 
#! to the category for the basic operation <C>RightCartesianDistributivityFactoringWithGivenObjects</C>.
#! $F: ((b_1 \times a) \sqcup \dots \sqcup (b_n \times a), L, a, (b_1 \sqcup \dots \sqcup b_n) \times a) \mapsto \mathrm{RightCartesianDistributivityFactoringWithGivenObjects}(L,a)$.
#! @Returns nothing
#! @Arguments C, F
DeclareOperation( "AddRightCartesianDistributivityFactoringWithGivenObjects",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddRightCartesianDistributivityFactoringWithGivenObjects",
                  [ IsCapCategory, IsFunction, IsInt ] );

DeclareOperation( "AddRightCartesianDistributivityFactoringWithGivenObjects",
                  [ IsCapCategory, IsList, IsInt ] );

DeclareOperation( "AddRightCartesianDistributivityFactoringWithGivenObjects",
                  [ IsCapCategory, IsList ] );
