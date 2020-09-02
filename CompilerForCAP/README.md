<!-- BEGIN HEADER -->
# CompilerForCAP – Speed up computations in CAP categories

| **Documentation**         | **Build Status of [CAP_project](/../../)**                                            |
|:-------------------------:|:-----------------------------------------------------------:|
| [![][docs-img]][docs-url] | [![][tests-img]][tests-url] [![][codecov-img]][codecov-url] |
<!-- END HEADER -->

**WARNING**: This package is still in alpha and not tested or validated extensively!

Using the notions of category theory allows for a very clean and concise description of the theory but initially comes with a large performance overhead when implementing algorithms on a computer.
The main reason for this is that a lot of wrapping and unwrapping occurs during computations once we use several category constructors.
For example, we can visualize a computation in

<p align="center">
	<img src="https://render.githubusercontent.com/render/math?math=\mathcal{A}(\mathrm{S}W\text{-frmod}(\mathrm{srep}_k(G)_%2B))">
</p>

consisting of three operations as follows:

<img src="img/computation_example.svg" width="100%">

We start with an input in the outermost category and first have to unwrap it to get the defining data in <img src="https://render.githubusercontent.com/render/math?math=\mathrm{srep}_k(G)"> where we do the actual computations.
When this computation is finished, the result is wrapped so we can interpret it in the outermost category again, producing the first intermediate result.
Now this intermediate result is immediately unwrapped again to perform the computations for the second operation and the result of these computations is wrapped again producing the second intermediate result.
This process is reapeated once more to get the final result.

To avoid repeatedly wrapping and unwrapping the same data during a computation we have started the package `CompilerForCAP`.
This package rewrites code so objects and morphisms in the input only have to be unwrapped once at the beginning of a computation and wrapped again once the computation is finished:

<img src="img/visualized_compilation_process.svg" width="100%">

Thus, when using the package there is no penalty in writing high-level code since it gets transformed into low-level code using highly optimized data structures and algorithms anyway, while writing the low-level code by hand instead would be error-prone if not impossible due to its complexity.

<!-- BEGIN FOOTER -->
[docs-img]: https://img.shields.io/badge/PDF-dev-blue.svg
[docs-url]: /../../raw/doc/CompilerForCAP.pdf

[tests-img]: https://github.com/homalg-project/CAP_project/workflows/Tests/badge.svg
[tests-url]: https://github.com/homalg-project/CAP_project/actions?query=workflow%3ATests

[codecov-img]: https://codecov.io/gh/homalg-project/CAP_project/branch/master/graph/badge.svg
[codecov-url]: https://codecov.io/gh/homalg-project/CAP_project
<!-- END FOOTER -->
