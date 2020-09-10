<!-- BEGIN HEADER -->
# FreydCategoriesForCAP – Freyd categories - Formal (co)kernels for additive categories

| **Documentation**         | **Build Status of [CAP_project](/../../)**                                            |
|:-------------------------:|:-----------------------------------------------------------:|
| [![][docs-img]][docs-url] | [![][tests-img]][tests-url] [![][codecov-img]][codecov-url] |
<!-- END HEADER -->

A package for various universal constructions mostly in an Ab-enriched context.

This package includes implementations (amongst others) of:
- [Freyd categories](#freyd-categories)
- [Cokernel image closures](#cokernel-image-closures)
- [Adelman categories](#adelman-categories)
- [Additive closures](#additive-closures)

## Freyd categories

Freyd categories provide a universal way of equipping a given additive category with cokernels. They can be identified with categories of finitely presented functors.

#### Paper (describing the underlying algorithms)

Sebastian Posur, [*A constructive approach to Freyd categories*](https://arxiv.org/abs/1712.03492).

Martin Bies, Sebastian Posur, [*Tensor products of finitely presented functors*](https://arxiv.org/abs/1909.00172).

## Cokernel image closures

Given an additive category, closing its category of finitely presented functors under images in the big category of all additive functors can be made constructive.

#### Paper (describing the underlying algorithms)

Sebastian Posur, [*Closing the category of finitely presented functors under images made constructive*](https://arxiv.org/abs/1911.11469).

## Adelman categories

Adelman categories provide a universal way of turning an additive category into an abelian category.

## Additive closures

Additive closures provide a universal way of equipping a given Ab-category with finite direct sums.

#### Paper (describing the underlying algorithms)

Sebastian Posur, [*Methods of constructive category theory*](https://arxiv.org/abs/1908.04132).

<!-- BEGIN FOOTER -->
[docs-img]: https://img.shields.io/badge/PDF-dev-blue.svg
[docs-url]: /../../raw/doc/FreydCategoriesForCAP.pdf

[tests-img]: https://github.com/homalg-project/CAP_project/workflows/Tests/badge.svg
[tests-url]: https://github.com/homalg-project/CAP_project/actions?query=workflow%3ATests

[codecov-img]: https://codecov.io/gh/homalg-project/CAP_project/branch/master/graph/badge.svg
[codecov-url]: https://codecov.io/gh/homalg-project/CAP_project
<!-- END FOOTER -->
