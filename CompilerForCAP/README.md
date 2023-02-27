<!-- BEGIN HEADER -->
# CompilerForCAP&ensp;<sup><sup>[![View code][code-img]][code-url]</sup></sup>

### Speed up computations in CAP categories

| Documentation | Latest Release | Build Status of [CAP_project](/../../) | Code Coverage |
| ------------- | -------------- | ------------ | ------------- |
| [![HTML stable documentation][html-img]][html-url] [![PDF stable documentation][pdf-img]][pdf-url] | [![version][version-img]][version-url] [![date][date-img]][date-url] | [![Build Status][tests-img]][tests-url] | [![Code Coverage][codecov-img]][codecov-url] |

<!-- END HEADER -->

Using the notions of category theory initially comes with a measurable performance overhead when implementing algorithms on a computer.
The main reason for this is the excessive amount of superfluous wrapping and unwrapping occurring during complex computations once we use several category constructors.
As an example, consider the category

<p align="center">
	<img src="img/example_category.svg" height="24" align="top"> = <code>FreydCategory( AdditiveClosure( RingAsCategory( R ) ) )</code>.
</p>

built from a ring using category constructors available in [FreydCategoriesForCAP](/FreydCategoriesForCAP).

We can visualize a computation in this category consisting of three operations as follows:

<img src="img/example_computation.svg" width="80%">

We start with an input in the top category and first have to successively unwrap it to get the defining data in the ring where the actual computation is done.
When this computation is finished, the result is successively wrapped again so we can interpret it in the top category, producing the first intermediate result.
Now this intermediate result has to be immediately unwrapped again to perform the computations for the second operation, and the result of these computations is wrapped again producing the second intermediate result.
This process is repeated once more to get the final result.

`CompilerForCAP` was started to avoid repeatedly wrapping and then subsequently unwrapping the same data during a computation.
It rewrites code so objects and morphisms in the input only have to be unwrapped once at the beginning of a computation and wrapped again once the computation is finished:

<img src="img/compilation_process.svg" width="100%">

Thus, there is no penalty in writing high-level code: Using `CompilerForCAP`, any arbitrary high tower of categorical constructions can be transformed into low-level code, while writing the low-level code by hand would be error-prone if not impossible due to its complexity.

### Additional features:

* The example above highlights another problem: Although `AdditiveClosure( RingAsCategory( R ) )` is equivalent to the category of matrices over `R`, we do not use existing, highly optimised matrix data structures and algorithms in the underlying computer algebra systems but instead descend all the way down to ring elements as our basic data structure. `CompilerForCAP` is able to detect such situations and replaces algorithms which iterate over ring elements by matrix operations in the underlying computer algebra systems where possible.
* `CAP` can use the linear algebra in OSCAR/Nemo via the package [`NemoLinearAlgebraForCAP`](https://github.com/sebastianpos/NemoLinearAlgebraForCAP/). If this package is used, `CompilerForCAP` is able to generate native OSCAR-code, see [this pull request](https://github.com/sebastianpos/NemoLinearAlgebraForCAP/pull/1).
* [planned] In some settings, e.g. in product categories, opportunities for parallelisation arise naturally. `CompilerForCAP` should be able to detect such situations and parallelise code using HPC-GAP or Julia where possible.

## Funding

<img src="img/BMWK_Fz_2017_WebSVG_en.svg" width="170px">

<!-- BEGIN FOOTER -->
[html-img]: https://img.shields.io/badge/🔗%20HTML-stable-blue.svg
[html-url]: https://homalg-project.github.io/CAP_project/CompilerForCAP/doc/chap0_mj.html

[pdf-img]: https://img.shields.io/badge/🔗%20PDF-stable-blue.svg
[pdf-url]: https://homalg-project.github.io/CAP_project/CompilerForCAP/download_pdf.html

[version-img]: https://img.shields.io/endpoint?url=https://homalg-project.github.io/CAP_project/CompilerForCAP/badge_version.json&label=🔗%20version&color=yellow
[version-url]: https://homalg-project.github.io/CAP_project/CompilerForCAP/view_release.html

[date-img]: https://img.shields.io/endpoint?url=https://homalg-project.github.io/CAP_project/CompilerForCAP/badge_date.json&label=🔗%20released%20on&color=yellow
[date-url]: https://homalg-project.github.io/CAP_project/CompilerForCAP/view_release.html

[tests-img]: https://github.com/homalg-project/CAP_project/actions/workflows/Tests.yml/badge.svg?branch=master
[tests-url]: https://github.com/homalg-project/CAP_project/actions/workflows/Tests.yml?query=branch%3Amaster

[codecov-img]: https://codecov.io/gh/homalg-project/CAP_project/branch/master/graph/badge.svg?flag=CompilerForCAP
[codecov-url]: https://app.codecov.io/gh/homalg-project/CAP_project/tree/master/CompilerForCAP

[code-img]: https://img.shields.io/badge/-View%20code-blue?logo=github
[code-url]: https://github.com/homalg-project/CAP_project/tree/master/CompilerForCAP#top
<!-- END FOOTER -->
