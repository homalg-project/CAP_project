<!-- BEGIN HEADER -->
# FreydCategoriesForCAP&ensp;<sup><sup>[![View code][code-img]][code-url]</sup></sup>

### Freyd categories - Formal (co)kernels for additive categories

| Documentation | Latest Release | Build Status of [CAP_project](/../../) | Code Coverage |
| ------------- | -------------- | ------------ | ------------- |
| [![HTML stable documentation][html-img]][html-url] [![PDF stable documentation][pdf-img]][pdf-url] | [![version][version-img]][version-url] [![date][date-img]][date-url] | [![Build Status][tests-img]][tests-url] | [![Code Coverage][codecov-img]][codecov-url] |

<!-- END HEADER -->

A package for various universal constructions mostly in an Ab-enriched context.

This package includes implementations (amongst others) of:
- [Freyd categories](#freyd-categories)
- [Cokernel image closures](#cokernel-image-closures)
- [Adelman categories](#adelman-categories)

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

#### Paper (describing the underlying algorithms)

Sebastian Posur, [*Methods of constructive category theory*](https://arxiv.org/abs/1908.04132).

<!-- BEGIN FOOTER -->
[html-img]: https://img.shields.io/badge/🔗%20HTML-stable-blue.svg
[html-url]: https://homalg-project.github.io/CAP_project/FreydCategoriesForCAP/doc/chap0_mj.html

[pdf-img]: https://img.shields.io/badge/🔗%20PDF-stable-blue.svg
[pdf-url]: https://homalg-project.github.io/CAP_project/FreydCategoriesForCAP/download_pdf.html

[version-img]: https://img.shields.io/endpoint?url=https://homalg-project.github.io/CAP_project/FreydCategoriesForCAP/badge_version.json&label=🔗%20version&color=yellow
[version-url]: https://homalg-project.github.io/CAP_project/FreydCategoriesForCAP/view_release.html

[date-img]: https://img.shields.io/endpoint?url=https://homalg-project.github.io/CAP_project/FreydCategoriesForCAP/badge_date.json&label=🔗%20released%20on&color=yellow
[date-url]: https://homalg-project.github.io/CAP_project/FreydCategoriesForCAP/view_release.html

[tests-img]: https://github.com/homalg-project/CAP_project/actions/workflows/Tests.yml/badge.svg?branch=master
[tests-url]: https://github.com/homalg-project/CAP_project/actions/workflows/Tests.yml?query=branch%3Amaster

[codecov-img]: https://codecov.io/gh/homalg-project/CAP_project/branch/master/graph/badge.svg?flag=FreydCategoriesForCAP
[codecov-url]: https://app.codecov.io/gh/homalg-project/CAP_project/tree/master/FreydCategoriesForCAP

[code-img]: https://img.shields.io/badge/-View%20code-blue?logo=github
[code-url]: https://github.com/homalg-project/CAP_project/tree/master/FreydCategoriesForCAP#top
<!-- END FOOTER -->
