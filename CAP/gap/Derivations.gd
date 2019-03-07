#############################################################################
##
##                                               CAP package
##
##  Copyright 2013, Sebastian Gutsche, TU Kaiserslautern
##                  Sebastian Posur,   RWTH Aachen
##
#! @Chapter Managing Derived Methods
#!
##
#############################################################################


####################################
##
#! @Section Info Class
##
####################################

#! @Description
#!  Info class for derivations.
DeclareInfoClass( "DerivationInfo" );

#!
DeclareGlobalFunction( "ActivateDerivationInfo" );

#!
DeclareGlobalFunction( "DeactivateDerivationInfo" );


####################################
##
#! @Section Derivation Objects
##
####################################

#! @Description
#!  A derivation object describes a derived method.
#!  It contains information about which operation the derived method
#!  implements, and which other operations it relies on.
DeclareCategory( "IsDerivedMethod", IsObject );

#! @Description
#!  Creates a new derivation object.
#!  The argument <A>name</A> is an arbitrary name used to
#!  identify this derivation, and is useful only for debugging
#!  purposes.
#!  The argument <A>target_op</A> is the operation which
#!  the derived method implements.
#!  The argument <A>used_ops_with_multiples</A> contains each
#!  operation used by the derived method, together with a positive
#!  integer specifying how many times that operation is used.
#!  This is given as a list of lists, where each sublist has as
#!  first entry an operation and as second entry an integer.
#!  The argument <A>weight</A> is an additional number to add
#!  when calculating the resulting weight of the target operation
#!  using this derivation.  Unless there is any particular reason
#!  to regard the derivation as exceedingly expensive, this number
#!  should be <C>1</C>.
#!  The argument <A>implementations_with_extra_filters</A> contains
#!  one or more functions with the actual implementation of the
#!  derived method, together with lists of extra argument filters
#!  for each function.  The argument is a list with entries of the
#!  form <C>[fun, filters]</C>, where <C>fun</C> is a function and
#!  <C>filters</C> is a (not necessarily dense) list of argument
#!  filters.  If only one function is given, then <C>filters</C>
#!  should be the empty list; in this case the argument's value
#!  would be [[fun,[]]], where <C>fun</C> is the function.
#!  The argument <A>category_filter</A> is a filter describing
#!  which categories the derivation is valid for.  If it is valid
#!  for all categories, then this argument should have the value
#!  <C>IsCapCategory</C>.
#!  The Option <C>ConditionsListComplete</C> indicates if the manually
#!  given list of preconditions for this derivation is complete
#!  or should be extended by looking for categorical operations
#!  in the function body. The value <C>false</C> indicates it is not complete,
#!  every other value that it is complete. Default is <C>false</C>.
#! @Arguments name, target_op, used_ops_with_multiples, weight, implementations_with_extra_filters, category_filter
DeclareOperation( "MakeDerivation",
                  [ IsString, IsFunction, IsDenseList,
                    IsPosInt, IsDenseList, IsFunction ] );

#! @Description
#!  The name of the derivation.  This is a name identifying this
#!  particular derivation, and normally not the same as the name
#!  of the operation implemented by the derivation.
#! @Arguments d
DeclareAttribute( "DerivationName", IsDerivedMethod );

#! @Description
#!  Extra weight for the derivation.
#! @Arguments d
DeclareAttribute( "DerivationWeight", IsDerivedMethod );

#! @Description
#!  The implementation(s) of the derivation, together with lists
#!  of extra filters for each implementation.
#! @Arguments d
DeclareAttribute( "DerivationFunctionsWithExtraFilters", IsDerivedMethod );

#! @Description
#!  Filter describing which categories the derivation is valid for.
#! @Arguments d
DeclareAttribute( "CategoryFilter", IsDerivedMethod );

#! @Description
#!  Checks if the derivation is known to be valid for a given category.
#! @Arguments d, C
#! @Returns <C>true</C> if the category <A>C</A> is known to satisfy
#!          the category filter of the derivation <A>d</A>.
DeclareOperation( "IsApplicableToCategory", [ IsDerivedMethod, IsCapCategory ] );

#! @Arguments d
#! @Returns
#!  The name (as a string) of the operation implemented
#!  by the derivation <A>d</A>
DeclareAttribute( "TargetOperation", IsDerivedMethod );

#! @Arguments d
#! @Returns
#!  The names (as strings) of the operations used by the
#!  derivation <A>d</A>
DeclareAttribute( "UsedOperations", IsDerivedMethod );

#! @Arguments d
#! @Returns
#!  Multiplicities of each operation used by the derivation
#!  <A>d</A>, in order corresponding to the operation names
#!  returned by <C>UsedOperations(d)</C>.
DeclareAttribute( "UsedOperationMultiples", IsDerivedMethod );

#! @Arguments d
#! @Returns
#!  The names of the operations used by the derivation <A>d</A>,
#!  together with their multiplicities.
#!  The result is a list consisting of lists of the form
#!  <C>[op_name, mult]</C>, where <C>op_name</C> is a string
#!  and <C>mult</C> a positive integer.
DeclareAttribute( "UsedOperationsWithMultiples", IsDerivedMethod );

#! @Description
#!  Install the derived method <A>d</A> for the category <A>C</A>.
#!  The integer <A>weight</A> is the computed weight of the operation
#!  implemented by this derivation.
#! @Arguments d, weight, C
DeclareOperation( "InstallDerivationForCategory",
                  [ IsDerivedMethod, IsPosInt, IsCapCategory ] );

#! @Description
#!  Computes the resulting weight of the target operation of this
#!  derivation given a list of weights for the operations it uses.
#!  The argument <A>op_weights</A> should be a list of integers
#!  specifying weights for the operations given by
#!  <C>UsedOperations( d )</C>, in the same order.
#! @Arguments d, op_weights
DeclareOperation( "DerivationResultWeight",
                  [ IsDerivedMethod, IsDenseList ] );


####################################
##
#! @Section Derivation Graphs
##
####################################

#! @Description
#!  A derivation graph consists of a set of operations and a set of derivations
#!  specifying how some operations can be implemented in terms of other operations.
DeclareCategory( "IsDerivedMethodGraph", IsObject );

#! @Description
#!  Make a derivation graph containing the given set of operations and no derivations.
#!  The argument <A>operations</A> should be a list of strings, the names of the
#!  operations.  The set of operations is fixed once the graph is created.
#!  Derivations can be added to the graph by calling <C>AddDerivation</C>.
#! @Arguments operations
DeclareOperation( "MakeDerivationGraph", [ IsDenseList ] );


#! @Description Adds a list of operation names <A>operations</A> to a given derivation graph <A>graph</A>.
#!  This is used in extensions of CAP which want to have their own basic operations,
#!  but do not want to pollute the CAP kernel any more. Please use it with caution. If
#!  a weight list/category was created before it will not be aware of the operations.
#! @Arguments graph, operations
DeclareOperation( "AddOperationsToDerivationGraph", [ IsDerivedMethodGraph, IsDenseList ] );

#! @Description
#!  Add a derivation to a derivation graph.
#! @Arguments G, d
DeclareOperation( "AddDerivation", [ IsDerivedMethodGraph, IsDerivedMethod ] );

#!
DeclareOperation( "AddDerivation", [ IsDerivedMethodGraph, IsFunction, IsDenseList, IsObject ] );
#!
DeclareOperation( "AddDerivation", [ IsDerivedMethodGraph, IsFunction, IsDenseList ] );
#!
DeclareOperation( "AddDerivation", [ IsDerivedMethodGraph, IsFunction, IsFunction ] );

#!
DeclareOperation( "AddDerivationPair", [ IsDerivedMethodGraph, IsFunction, IsFunction, IsDenseList, IsDenseList, IsDenseList ] );
DeclareOperation( "AddDerivationPair", [ IsDerivedMethodGraph, IsFunction, IsFunction, IsDenseList, IsDenseList ] );
DeclareOperation( "AddDerivationPair", [ IsDerivedMethodGraph, IsFunction, IsFunction, IsDenseList, IsFunction, IsFunction ] );
DeclareOperation( "AddDerivationPair", [ IsDerivedMethodGraph, IsFunction, IsFunction, IsFunction, IsFunction ] );

#!
DeclareGlobalFunction( "AddDerivationToCAP" );

#!
DeclareGlobalFunction( "AddDerivationPairToCAP" );

#!
DeclareGlobalFunction( "AddWithGivenDerivationPairToCAP" );

#! @Description
#!  Gives the operations in the graph <A>G</A>, as a list of strings.
#! @Arguments G
DeclareAttribute( "Operations", IsDerivedMethodGraph, "mutable" );

#! @Description
#!  Finds all the derivations in the graph <A>G</A> that use the operation named
#!  <A>op_name</A>, and returns them as a list.
#! @Arguments G, op_name
DeclareOperation( "DerivationsUsingOperation", [ IsDerivedMethodGraph, IsString ] );

#! @Description
#!  Finds all the derivations in the graph <A>G</A> targeting the operation named
#!  <A>op_name</A> (that is, the derivations that provide implementations of this
#!  operation), and returns them as a list.
#! @Arguments G, op_name
DeclareOperation( "DerivationsOfOperation", [ IsDerivedMethodGraph, IsString ] );


####################################
##
#! @Section Managing Derivations in a Category
##
####################################

#! @Description
#!  An operation weight list manages the use of derivations in a single category $C$.
#!  For every operation, it keeps a weight value which indicates how costly it is
#!  to perform that operation in the category $C$.  Whenever a new operation is
#!  implemented in $C$, the operation weight list should be notified about this and
#!  given a weight to assign to this operation.  It will then automatically install
#!  all possible derived methods for $C$ in such a way that every operation has the
#!  smallest possible weight (the weight of a derived method is computed by using
#!  the weights of the operations it uses; see <C>DerivationResultWeight</C>).
DeclareCategory( "IsOperationWeightList", IsObject );

#! @Description
#!  Create the operation weight list for a category.
#!  This should only be done once for every category, and the category should
#!  afterwards remember the returned object.
#!  The argument <A>C</A> is the CAP category this operation weight list is associated to,
#!  and the argument <A>G</A> is a derivation graph containing operation names and derivations.
#! @Arguments C, G
DeclareOperation( "MakeOperationWeightList", [ IsCapCategory, IsDerivedMethodGraph ] );

#! @Description
#!  Returns the derivation graph used by the operation weight list <A>owl</A>.
#! @Arguments owl
DeclareAttribute( "DerivationGraph", IsOperationWeightList );

#! @Description
#!  Returns the CAP category associated to the operation weight list <A>owl</A>.
#! @Arguments owl
DeclareAttribute( "CategoryOfOperationWeightList", IsOperationWeightList );

#! @Description
#!  Returns the current weight of the operation named <A>op_name</A>.
#! @Arguments owl, op_name
DeclareOperation( "CurrentOperationWeight", [ IsOperationWeightList, IsString ] );

#! @Description
#!  Finds out what the weight of the operation implemented by the derivation <A>d</A>
#!  would be if we had used that derivation.
#! @Arguments owl, d
DeclareOperation( "OperationWeightUsingDerivation",
                  [ IsOperationWeightList, IsDerivedMethod ] );

#! @Description
#!  Returns the derivation which is currently used to implement the operation
#!  named <A>op_name</A>.
#!  If the operation is not implemented by a derivation (that is, either implemented
#!  directly or not implemented at all), then <C>fail</C> is returned.
#! @Arguments owl, op_name
DeclareOperation( "DerivationOfOperation", [ IsOperationWeightList, IsString ] );

#! @Description
#!  Performs a search from the operation <A>op_name</A>, and installs all derivations
#!  that give improvements over the current state.
#!  This is used internally by <C>AddPrimitiveOperation</C> and <C>Reevaluate</C>.
#!  It should normally not be necessary to call this function directly.
#! @Arguments owl, op_name
DeclareOperation( "InstallDerivationsUsingOperation",
                  [ IsOperationWeightList, IsString ] );

#! @Description
#!  Reevaluate the installed derivations, installing better derivations if possible.
#!  This should be called if new derivations become available for the category,
#!  either because the category has acquired more knowledge about itself
#!  (e.g. it is told that it is abelian)
#!  or because new derivations have been added to the graph.
#! @Arguments owl
DeclareOperation( "Reevaluate", [ IsOperationWeightList ] );

#! @Description
#!  Add the operation named <A>op_name</A> to the operation weight list <A>owl</A>
#!  with weight <A>weight</A>.
#!  This causes all operations that can be derived, directly or indirectly,
#!  from the newly added operation to be installed as well
#!  (unless they are already installed with the same or lower weight).
#! @Arguments owl, op_name, weight
DeclareOperation( "AddPrimitiveOperation", [ IsOperationWeightList, IsString, IsInt ] );

#! @Description
#!  Print a tree representation of the way the operation named <A>op_name</A>
#!  is implemented in the category of the operation weight list <A>owl</A>.
#! @Arguments owl, op_name
DeclareOperation( "PrintDerivationTree",
                  [ IsOperationWeightList, IsString ] );

#! @Description
#!  Prints a tree structure.
DeclareOperation( "PrintTree", [ IsObject, IsFunction, IsFunction ] );
DeclareOperation( "PrintTreeRec",
                  [ IsObject, IsFunction, IsFunction, IsInt ] );

####################################
##
#! @Section Min Heaps for Strings
##
####################################

#! This section describes an implementation of min heaps for storing strings with
#! associated integer keys, used internally by operation weight lists.

#! @Description
#!  A string min heap is a min heap where every node contains a string label and an
#!  integer key.
DeclareCategory( "IsStringMinHeap", IsObject );

#! @Description
#!  Create an empty string min heap.
DeclareGlobalFunction( "StringMinHeap" );

#! @Description
#!  Add a new node containing the label <A>string</A> and the key <A>key</A>
#!  to the heap <A>H</A>.
#! @Arguments H, string, key
DeclareOperation( "Add", [ IsStringMinHeap, IsString, IsInt ] );

#! @Description
#!  Remove a node with minimal key value from the heap <A>H</A>, and return it.
#!  The return value is a list <C>[ label, key ]</C>, where <C>label</C>
#!  is the extracted node's label (a string) and <C>key</C> is the
#!  node's key (an integer).
#! @Arguments H
DeclareOperation( "ExtractMin", [ IsStringMinHeap ] );

#! @Description
#!  Decrease the key value for the node with label <A>string</A> in the
#!  heap <A>H</A>.  The new key value is given by <A>key</A> and must be
#!  smaller than the node's current value.
#! @Arguments H, string, key
DeclareOperation( "DecreaseKey", [ IsStringMinHeap, IsString, IsInt ] );

#! @Description
#!  Returns <C>true</C> if the heap <A>H</A> is empty, <C>false</C> otherwise.
#! @Arguments H
DeclareOperation( "IsEmptyHeap", [ IsStringMinHeap ] );

#! @Description
#!  Returns the number of nodes in the heap <A>H</A>.
#! @Arguments H
DeclareOperation( "HeapSize", [ IsStringMinHeap ] );

#! @Description
#!  Returns <C>true</C> if the heap <A>H</A> contains a node with
#!  label <A>string</A>, and <C>false</C> otherwise.
#! @Arguments H, string
DeclareOperation( "Contains", [ IsStringMinHeap, IsString ] );

#! @Description
#!  Swaps two elements in the list used to implement the heap,
#!  and updates the heap's internal mapping of labels to list indices.
#!  This is an internal function which should only be called from the
#!  functions that implement the heap functionality.
#! @Arguments H, i, j
DeclareOperation( "Swap", [ IsStringMinHeap, IsPosInt, IsPosInt ] );

#! @Description
#!  Heapify the heap <A>H</A>, starting from index <A>i</A>.
#!  This is an internal function.
#! @Arguments H, i
DeclareOperation( "Heapify", [ IsStringMinHeap, IsPosInt ] );


#################################
##
## Some print functions
##
#################################

DeclareGlobalFunction( "InstalledMethodsOfCategory" );
DeclareGlobalFunction( "DerivationsOfMethodByCategory" );

DeclareGlobalFunction( "ListInstalledOperationsOfCategory" );
DeclareGlobalFunction( "ListPrimitivelyInstalledOperationsOfCategory" );

DeclareGlobalFunction( "CAP_INTERNAL_DERIVATION_SANITY_CHECK" );
