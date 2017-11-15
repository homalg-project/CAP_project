## CAP info functions

* CanCompute( category, string )
  Returns true if the the function with name <string> is computable in <category>.

* CheckConstructivenessOfCategory( category, string )
  Returns a list of names of basic operations which are not computable in <category> but
  needed to have the categorical property <string> completely constructive.

* ListKnownCategoricalProperties( category )
  Lists all known categorical properties of <category>.

* InstalledMethodsOfCategory( category )
  Lists all installed methods of category.

* DerivationsOfMethodByCategory( category, method )
  Shows how <method> can be derived in <category>.

* ListInstalledOperationsOfCategory( category )
  Returns a list of strings of all installed operations of <category>.

* ListPrimitivelyInstalledOperationsOfCategory( category )
  Returns a list of strings of all primitively installed operations of <category>.

* ListCAPPrepareFunctions( )
  Lists all prepare functions currently available.
