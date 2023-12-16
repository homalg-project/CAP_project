## CAP info functions

* CanCompute( category, string )
  Returns true if the operation with name <string> is computable in <category>.

* MissingOperationsForConstructivenessOfCategory( category, string )
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

* PrintAutomaticallyGeneratedInstallationsForLimits( string )
  Prints all installations of the method with name <string> which are automatically generated
  by the (co)limit mechanism. If no method name is given, all such installations are printed.

* PackageOfCAPOperation( string )
  Returns the package where the operation with name <string> is defined.
  
