# SPDX-License-Identifier: GPL-2.0-or-later
# MonoidalCategories: Monoidal and monoidal (co)closed categories
#
# Declarations
#

####################################
##
#! @Chapter Monoidal Categories
##
#! @Section Additive Monoidal Categories
##
####################################

DeclareGlobalVariable( "DISTRIBUTIVE_MONOIDAL_CATEGORIES_METHOD_NAME_RECORD" );

#! @Description
#! The arguments are an object $a$
#! and a list of objects $L = (b_1, \dots, b_n)$.
#! The output is the left distributivity morphism
#! $a \otimes (b_1 \oplus \dots \oplus b_n) \rightarrow (a \otimes b_1) \oplus \dots \oplus (a \otimes b_n)$.
#! @Returns a morphism in $\mathrm{Hom}( a \otimes (b_1 \oplus \dots \oplus b_n), (a \otimes b_1) \oplus \dots \oplus (a \otimes b_n) )$
#! @Arguments a, L
DeclareOperation( "LeftDistributivityExpanding",
                  [ IsCapCategoryObject, IsList ] );

#! @Description
#! The arguments are an object $s = a \otimes (b_1 \oplus \dots \oplus b_n)$,
#! an object $a$,
#! a list of objects $L = (b_1, \dots, b_n)$,
#! and an object $r = (a \otimes b_1) \oplus \dots \oplus (a \otimes b_n)$.
#! The output is the left distributivity morphism
#! $s \rightarrow r$.
#! @Returns a morphism in $\mathrm{Hom}( s, r )$
#! @Arguments s, a, L, r
DeclareOperation( "LeftDistributivityExpandingWithGivenObjects",
                  [ IsCapCategoryObject, IsCapCategoryObject, IsList, IsCapCategoryObject ] );

#! @Description
#! The arguments are
#! * an object $a$,
#! * a list of objects $L = (b_1, \dots, b_n)$,
#! * a list of positive integers $M = (i_1, \dots, i_n)$.
#!
#! The output is the left distributivity morphism
#! $a \otimes (\underbrace{b_1 \oplus \dots \oplus b_1}_{i_1 \mathrm{times}} \oplus \dots \oplus \underbrace{b_n \oplus \dots \oplus b_n}_{{i_n \mathrm{times}}}) \rightarrow
#!  \underbrace{(a \otimes b_1) \oplus \dots \oplus (a \otimes b_1)}_{i_1 \mathrm{times}} \oplus \dots \oplus \underbrace{(a \otimes b_n) \oplus \dots \oplus (a \otimes b_n)}_{i_n \mathrm{times}}$
#! @Returns a morphism in $\mathrm{Hom}( a \otimes (b_1^{i_1} \oplus \dots \oplus b_n^{i_n}), (a \otimes b_1)^{i_1} \oplus \dots \oplus (a \otimes b_n)^{i_n} )$.
#! @Arguments category, a, L, M
DeclareOperation( "LeftDistributivityExpandingUsingMultiplicities",
                  [ IsCapCategoryObject, IsList, IsList ] );

#! @Description
#! The arguments are
#! * an object $s = a \otimes (\underbrace{b_1 \oplus \dots \oplus b_1}_{i_1 \mathrm{times}} \oplus \dots \oplus \underbrace{b_n \oplus \dots \oplus b_n}_{{i_n \mathrm{times}}})$,
#! * an object $a$,
#! * a list of objects $L = (b_1, \dots, b_n)$,
#! * a list of positive integers $M = (i_1, \dots, i_n)$,
#! * an object $r = \underbrace{(a \otimes b_1) \oplus \dots \oplus (a \otimes b_1)}_{i_1 \mathrm{times}} \oplus \dots \oplus \underbrace{(a \otimes b_n) \oplus \dots \oplus (a \otimes b_n)}_{i_n \mathrm{times}}$.
#!
#! The output is the left distributivity morphism $s \rightarrow r$.
#! @Returns a morphism in $\mathrm{Hom}( s, r )$
#! @Arguments category, s, a, L, M, r
DeclareOperation( "LeftDistributivityExpandingUsingMultiplicitiesWithGivenObjects",
                  [ IsCapCategoryObject, IsCapCategoryObject, IsList, IsList, IsCapCategoryObject ] );

#! @Description
#! The arguments are an object $a$
#! and a list of objects $L = (b_1, \dots, b_n)$.
#! The output is the left distributivity morphism
#! $(a \otimes b_1) \oplus \dots \oplus (a \otimes b_n) \rightarrow a \otimes (b_1 \oplus \dots \oplus b_n)$.
#! @Returns a morphism in $\mathrm{Hom}( (a \otimes b_1) \oplus \dots \oplus (a \otimes b_n), a \otimes (b_1 \oplus \dots \oplus b_n) )$
#! @Arguments a, L
DeclareOperation( "LeftDistributivityFactoring",
                  [ IsCapCategoryObject, IsList ] );

#! @Description
#! The arguments are an object $s = (a \otimes b_1) \oplus \dots \oplus (a \otimes b_n)$,
#! an object $a$,
#! a list of objects $L = (b_1, \dots, b_n)$,
#! and an object $r = a \otimes (b_1 \oplus \dots \oplus b_n)$.
#! The output is the left distributivity morphism
#! $s \rightarrow r$.
#! @Returns a morphism in $\mathrm{Hom}( s, r )$
#! @Arguments s, a, L, r
DeclareOperation( "LeftDistributivityFactoringWithGivenObjects",
                  [ IsCapCategoryObject, IsCapCategoryObject, IsList, IsCapCategoryObject ] );

#! @Description
#! The arguments are
#! * an object $a$,
#! * a list of objects $L = (b_1, \dots, b_n)$,
#! * a list of positive integers $M = (i_1, \dots, i_n)$.
#!
#! The output is the left distributivity morphism
#! $\underbrace{(a \otimes b_1) \oplus \dots \oplus (a \otimes b_1)}_{i_1 \mathrm{times}} \oplus \dots \oplus \underbrace{(a \otimes b_n) \oplus \dots \oplus (a \otimes b_n)}_{i_n \mathrm{times}} \rightarrow
#!  a \otimes (\underbrace{b_1 \oplus \dots \oplus b_1}_{i_1 \mathrm{times}} \oplus \dots \oplus \underbrace{b_n \oplus \dots \oplus b_n}_{{i_n \mathrm{times}}})$
#! @Returns a morphism in $\mathrm{Hom}( (a \otimes b_1)^{i_1} \oplus \dots \oplus (a \otimes b_n)^{i_n}, a \otimes (b_1^{i_1} \oplus \dots \oplus b_n^{i_n}) )$.
#! @Arguments category, a, L, M
DeclareOperation( "LeftDistributivityFactoringUsingMultiplicities",
                  [ IsCapCategoryObject, IsList, IsList ] );

#! @Description
#! The arguments are
#! * an object $s = \underbrace{(a \otimes b_1) \oplus \dots \oplus (a \otimes b_1)}_{i_1 \mathrm{times}} \oplus \dots \oplus \underbrace{(a \otimes b_n) \oplus \dots \oplus (a \otimes b_n)}_{i_n \mathrm{times}}$,
#! * an object $a$,
#! * a list of objects $L = (b_1, \dots, b_n)$,
#! * a list of positive integers $M = (i_1, \dots, i_n)$,
#! * an object $r = a \otimes (\underbrace{b_1 \oplus \dots \oplus b_1}_{i_1 \mathrm{times}} \oplus \dots \oplus \underbrace{b_n \oplus \dots \oplus b_n}_{{i_n \mathrm{times}}})$.
#!
#! The output is the left distributivity morphism $s \rightarrow r$.
#! @Returns a morphism in $\mathrm{Hom}( s, r )$
#! @Arguments category, s, a, L, M, r
DeclareOperation( "LeftDistributivityFactoringUsingMultiplicitiesWithGivenObjects",
                  [ IsCapCategoryObject, IsCapCategoryObject, IsList, IsList, IsCapCategoryObject ] );

#! @Description
#! The arguments are a list of objects $L = (b_1, \dots, b_n)$
#! and an object $a$.
#! The output is the right distributivity morphism
#! $(b_1 \oplus \dots \oplus b_n) \otimes a \rightarrow (b_1 \otimes a) \oplus \dots \oplus (b_n \otimes a)$.
#! @Returns a morphism in $\mathrm{Hom}( (b_1 \oplus \dots \oplus b_n) \otimes a, (b_1 \otimes a) \oplus \dots \oplus (b_n \otimes a) )$
#! @Arguments L, a
DeclareOperation( "RightDistributivityExpanding",
                  [ IsList, IsCapCategoryObject ] );

#! @Description
#! The arguments are an object $s = (b_1 \oplus \dots \oplus b_n) \otimes a$,
#! a list of objects $L = (b_1, \dots, b_n)$,
#! an object $a$,
#! and an object $r = (b_1 \otimes a) \oplus \dots \oplus (b_n \otimes a)$.
#! The output is the right distributivity morphism
#! $s \rightarrow r$.
#! @Returns a morphism in $\mathrm{Hom}( s, r )$
#! @Arguments s, L, a, r
DeclareOperation( "RightDistributivityExpandingWithGivenObjects",
                  [ IsCapCategoryObject, IsList, IsCapCategoryObject, IsCapCategoryObject ] );

#! @Description
#! The arguments are
#! * a list of objects $L = (b_1, \dots, b_n)$,
#! * a list of positive integers $M = (i_1, \dots, i_n)$,
#! * an object $a$.
#!
#! The output is the right distributivity morphism
#! $(\underbrace{b_1 \oplus \dots \oplus b_1}_{i_1 \mathrm{times}} \oplus \dots \oplus \underbrace{b_n \oplus \dots \oplus b_n}_{{i_n \mathrm{times}}}) \otimes a \rightarrow
#!  \underbrace{(b_1 \otimes a) \oplus \dots \oplus (b_1 \otimes a)}_{i_1 \mathrm{times}} \oplus \dots \oplus \underbrace{(b_n \otimes a) \oplus \dots \oplus (b_n \otimes a)}_{i_n \mathrm{times}}$
#! @Returns a morphism in $\mathrm{Hom}( (b_1^{i_1} \oplus \dots \oplus b_n^{i_n}) \otimes a, (b_1 \otimes a)^{i_1} \oplus \dots \oplus (b_n \otimes a)^{i_n} )$.
#! @Arguments category, a, L, M
DeclareOperation( "RightDistributivityExpandingUsingMultiplicities",
                  [ IsList, IsList, IsCapCategoryObject ] );

#! @Description
#! The arguments are
#! * an object $s = (\underbrace{b_1 \oplus \dots \oplus b_1}_{i_1 \mathrm{times}} \oplus \dots \oplus \underbrace{b_n \oplus \dots \oplus b_n}_{{i_n \mathrm{times}}}) \otimes a$,
#! * a list of objects $L = (b_1, \dots, b_n)$,
#! * a list of positive integers $M = (i_1, \dots, i_n)$,
#! * an object $a$,
#! * an object $r = \underbrace{(b_1 \otimes a) \oplus \dots \oplus (b_1 \otimes a)}_{i_1 \mathrm{times}} \oplus \dots \oplus \underbrace{(b_n \otimes a) \oplus \dots \oplus (b_n \otimes a)}_{i_n \mathrm{times}}$.
#!
#! The output is the right distributivity morphism $s \rightarrow r$.
#! @Returns a morphism in $\mathrm{Hom}( s, r )$.
#! @Arguments category, s, L, M, a, r
DeclareOperation( "RightDistributivityExpandingUsingMultiplicitiesWithGivenObjects",
                  [ IsCapCategoryObject, IsList, IsList, IsCapCategoryObject, IsCapCategoryObject ] );

#! @Description
#! The arguments are a list of objects $L = (b_1, \dots, b_n)$
#! and an object $a$.
#! The output is the right distributivity morphism
#! $(b_1 \otimes a) \oplus \dots \oplus (b_n \otimes a) \rightarrow (b_1 \oplus \dots \oplus b_n) \otimes a $.
#! @Returns a morphism in $\mathrm{Hom}( (b_1 \otimes a) \oplus \dots \oplus (b_n \otimes a), (b_1 \oplus \dots \oplus b_n) \otimes a)$
#! @Arguments L, a
DeclareOperation( "RightDistributivityFactoring",
                  [ IsList, IsCapCategoryObject ] );

#! @Description
#! The arguments are an object $s = (b_1 \otimes a) \oplus \dots \oplus (b_n \otimes a)$,
#! a list of objects $L = (b_1, \dots, b_n)$,
#! an object $a$,
#! and an object $r = (b_1 \oplus \dots \oplus b_n) \otimes a$.
#! The output is the right distributivity morphism
#! $s \rightarrow r$.
#! @Returns a morphism in $\mathrm{Hom}( s, r )$
#! @Arguments s, L, a, r
DeclareOperation( "RightDistributivityFactoringWithGivenObjects",
                  [ IsCapCategoryObject, IsList, IsCapCategoryObject, IsCapCategoryObject ] );

#! @Description
#! The arguments are
#! * a list of objects $L = (b_1, \dots, b_n)$,
#! * a list of positive integers $M = (i_1, \dots, i_n)$,
#! * an object $a$.
#!
#! The output is the right distributivity morphism
#! $\underbrace{(b_1 \otimes a) \oplus \dots \oplus (b_1 \otimes a)}_{i_1 \mathrm{times}} \oplus \dots \oplus \underbrace{(b_n \otimes a) \oplus \dots \oplus (b_n \otimes a)}_{i_n \mathrm{times}} \rightarrow
#!  (\underbrace{b_1 \oplus \dots \oplus b_1}_{i_1 \mathrm{times}} \oplus \dots \oplus \underbrace{b_n \oplus \dots \oplus b_n}_{{i_n \mathrm{times}}}) \otimes a$
#! @Returns a morphism in $\mathrm{Hom}( (b_1 \otimes a)^{i_1} \oplus \dots \oplus (b_n \otimes a)^{i_n}, (b_1^{i_1} \oplus \dots \oplus b_n^{i_n}) \otimes a )$.
#! @Arguments category, a, L, M
DeclareOperation( "RightDistributivityFactoringUsingMultiplicities",
                  [ IsList, IsList, IsCapCategoryObject ] );

#! @Description
#! The arguments are
#! * an object $s = \underbrace{(b_1 \otimes a) \oplus \dots \oplus (b_1 \otimes a)}_{i_1 \mathrm{times}} \oplus \dots \oplus \underbrace{(b_n \otimes a) \oplus \dots \oplus (b_n \otimes a)}_{i_n \mathrm{times}}$,
#! * a list of objects $L = (b_1, \dots, b_n)$,
#! * a list of positive integers $M = (i_1, \dots, i_n)$,
#! * an object $a$,
#! * an object $r = (\underbrace{b_1 \oplus \dots \oplus b_1}_{i_1 \mathrm{times}} \oplus \dots \oplus \underbrace{b_n \oplus \dots \oplus b_n}_{{i_n \mathrm{times}}}) \otimes a$.
#!
#! The output is the right distributivity morphism $s \rightarrow r$.
#! @Returns a morphism in $\mathrm{Hom}( s, r )$.
#! @Arguments category, s, L, M, a, r
DeclareOperation( "RightDistributivityFactoringUsingMultiplicitiesWithGivenObjects",
                  [ IsCapCategoryObject, IsList, IsList, IsCapCategoryObject, IsCapCategoryObject ] );

