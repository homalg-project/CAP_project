# SPDX-License-Identifier: GPL-2.0-or-later
# CAP: Categories, Algorithms, Programming
#
# Declarations
#
#! @Chapter Managing Derived Methods

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
DeclareCategory( "IsDerivedMethod", IsAttributeStoringRep );

#! @Description
#!  Creates a new derivation object.
#!  The argument <A>target_op_name</A> is the name of the operation which
#!  the derived method implements.
#!  The argument <A>description</A> should describe the derivation.
#!  The argument <A>used_ops_with_multiples</A> contains
#!  
#!  * the name of each operation used by the derived method,
#!  * together with a positive integer specifying how many times that operation is used and
#!  * either a category getter or <C>fail</C>.
#!  
#!  This is given as a list of lists, where each sublist has as
#!  first entry the name of an operation, as second entry an integer and as
#!  third entry either a function or <C>fail</C>. This function should accept the
#!  category for which this derivation will be installed,
#!  and return a category for which the operation in the first
#!  entry must be installed for the derivation to be considered applicable.
#!  The argument <A>func</A> contains the actual implementation of the
#!  derived method.
#!  The argument <A>weight</A> is an additional number to add
#!  when calculating the resulting weight of the target operation
#!  using this derivation. Unless there is any particular reason
#!  to regard the derivation as exceedingly expensive, this number
#!  should be <C>1</C>.
#!  The argument <A>category_filter</A> is a filter (or function) describing
#!  which categories the derivation is valid for. If it is valid
#!  for all categories, then this argument should have the value
#!  <C>IsCapCategory</C>. The output of <A>category_filter</A> must not
#!  change during the installation of operations. In particular, it must
#!  not rely on `CanCompute` to check conditions.
#! @Arguments target_op_name, description, used_ops_with_multiples, func, weight, category_filter, loop_multiplier, category_getters
DeclareGlobalFunction( "CreateDerivation" );

#! @Description
#!  A description of the derivation.
#! @Arguments d
DeclareAttribute( "Description", IsDerivedMethod );

#! @Description
#!  Additional weight for the derivation.
#! @Arguments d
DeclareAttribute( "AdditionalWeight", IsDerivedMethod );

#! @Description
#!  The implementation of the derivation.
#! @Arguments d
DeclareAttribute( "DerivationFunction", IsDerivedMethod );

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
#!  The names of the operations used by the derivation <A>d</A>,
#!  together with their multiplicities and category getters.
#!  The result is a list consisting of lists of the form
#!  `[op_name, mult, getter]`, where `op_name` is a string,
#!  `mult` a positive integer and `getter` is a function or `fail`.
DeclareAttribute( "UsedOperationsWithMultiplesAndCategoryGetters", IsDerivedMethod );

#! @Description
#!  Install the derived method <A>d</A> for the category <A>C</A>.
#!  The integer <A>weight</A> is the computed weight of the operation
#!  implemented by this derivation.
#! @Arguments d, weight, C
DeclareOperation( "InstallDerivationForCategory",
                  [ IsDerivedMethod, IsPosInt, IsCapCategory ] );

#! @Description
#! Input is a derived method. Output is a unary function that takes as an input
#! a category and does not output anything. This function is always called before
#! the installation of the derived method for a concrete instance of a category.
#! @Arguments d
DeclareAttribute( "FunctionCalledBeforeInstallation", IsDerivedMethod );

####################################
##
#! @Section Derivation Graphs
##
####################################

#! @Description
#!  A derivation graph consists of a set of operations and a set of derivations
#!  specifying how some operations can be implemented in terms of other operations.
DeclareCategory( "IsDerivedMethodGraph", IsAttributeStoringRep );

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
#! @Arguments graph, target_op, description, used_ops_with_multiples_and_category_getters, func, weight, category_filter, loop_multiplier, category_getters, function_called_before_installation
DeclareGlobalFunction( "AddDerivation" );

DeclareGlobalName( "CAP_INTERNAL_DERIVATION_GRAPH" );

#!
DeclareGlobalFunction( "AddDerivationToCAP" );

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
#!  the weights of the operations it uses).
DeclareCategory( "IsOperationWeightList", IsAttributeStoringRep );

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
#!  Performs a search from the operation <A>op_name</A>, and triggers all derivations
#!  that give improvements over the current state.
#!  This is used internally by <C>InstallDerivations</C> and <C>Reevaluate</C>.
#!  It should normally not be necessary to call this function directly.
#! @Arguments owl, op_name
DeclareOperation( "TriggerDerivationsUsingOperation",
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
#!  Saturates the derivation graph, i.e., calls reevaluate until
#!  no more changes in the derivation graph occur.
#! @Arguments owl
DeclareOperation( "Saturate", [ IsOperationWeightList ] );

#! @Description
#!  Add the operation named <A>op_name</A> to the operation weight list <A>owl</A>
#!  with weight <A>weight</A>.
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

#################################
##
## Final derivations
##
#################################

DeclareGlobalVariable( "CAP_INTERNAL_FINAL_DERIVATION_LIST" );

DeclareGlobalFunction( "AddFinalDerivation" );

DeclareGlobalFunction( "AddFinalDerivationBundle" );

#################################
##
## Installing derivations
##
#################################

DeclareGlobalFunction( "InstallDerivations" );

#################################
##
## Some print functions
##
#################################

DeclareGlobalFunction( "InstalledMethodsOfCategory" );
DeclareGlobalFunction( "DerivationsOfMethodByCategory" );
