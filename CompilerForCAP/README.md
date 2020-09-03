<!-- BEGIN HEADER -->
# CompilerForCAP – Speed up computations in CAP categories

| **Documentation**         | **Build Status of [CAP_project](/../../)**                                            |
|:-------------------------:|:-----------------------------------------------------------:|
| [![][docs-img]][docs-url] | [![][tests-img]][tests-url] [![][codecov-img]][codecov-url] |
<!-- END HEADER -->

**WARNING**: This package is still in alpha and not tested or validated extensively!

Using the notions of category initially comes with a large performance overhead when implementing algorithms on a computer.
The main reason for this is that a lot of wrapping and unwrapping occurs during computations once we use several category constructors.
As an example, consider the category

<p align="center">
	<img src="img/example_category.svg" height="24" align="top"> = <code>FreydCategory( AdditiveClosure( RingAsCategory( R ) ) )</code>.
</p>

built from a ring using category constructors available in [FreydCategoriesForCAP](/FreydCategoriesForCAP).

We can visualize a computation in this category consisting of three operations as follows:

<img src="img/example_computation.svg" width="80%">

We start with an input in the outermost category and first have to unwrap it to get the defining data in the ring where we do the actual computations.
When this computation is finished, the result is successively wrapped so we can interpret it in the outermost category again, producing the first intermediate result.
Now this intermediate result is again immediately fully unwrapped to perform the computations for the second operation and the result of these computations is wrapped again producing the second intermediate result.
This process is reapeated once more to get the final result.

`CompilerForCAP` was started to avoid repeatedly wrapping and unwrapping the same data during a computation.
It rewrites code so objects and morphisms in the input only have to be unwrapped once at the beginning of a computation and wrapped again once the computation is finished:

<img src="img/compilation_process.svg" width="100%">

Thus, when using `CompilerForCAP` there is no penalty in writing high-level code since it gets transformed into low-level code using highly optimized data structures and algorithms anyway, while writing the low-level code by hand would be error-prone if not impossible due to its complexity.

### Additional features:

* The example above highlights another problem: although `AdditiveClosure( RingAsCategory( R ) )` is equivalent to the category of matrices over `R`, we do not use existing highly-optimized matrix data structures and algorithms in the underlying computer algebra systems but instead descend all the way down to ring elements as our basic data structure. `CompilerForCAP` is able to detect such situations and replaces algorithms which iterate over ring elements by matrix operations in the underlying computer algebra systems where possible.
* `CAP` can use the linear algebra in OSCAR/Nemo via the package [`NemoLinearAlgebraForCAP`](https://github.com/sebastianpos/NemoLinearAlgebraForCAP/). If this package is used, `CompilerForCAP` is able to generate native OSCAR-code, see [this pull request](https://github.com/sebastianpos/NemoLinearAlgebraForCAP/pull/1).
* [planned] In some settings, e.g. in product categories, opportunities for parallelisation arise naturally. `CompilerForCAP` should be able to detect such situations and parallelise code using HPC-GAP or Julia where possible.

<!-- BEGIN FOOTER -->
[docs-img]: https://img.shields.io/badge/PDF-dev-blue.svg
[docs-url]: /../../raw/doc/CompilerForCAP.pdf

[tests-img]: https://github.com/homalg-project/CAP_project/workflows/Tests/badge.svg
[tests-url]: https://github.com/homalg-project/CAP_project/actions?query=workflow%3ATests

[codecov-img]: https://codecov.io/gh/homalg-project/CAP_project/branch/master/graph/badge.svg
[codecov-url]: https://codecov.io/gh/homalg-project/CAP_project
<!-- END FOOTER -->
