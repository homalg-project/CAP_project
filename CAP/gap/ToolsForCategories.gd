# SPDX-License-Identifier: GPL-2.0-or-later
# CAP: Categories, Algorithms, Programming
#
# Declarations
#
#! @Chapter Technical Details

#! @Section Tools

#! @Arguments specification, func
#! @Returns a function
#! @Description
#!  Simulates named arguments in &GAP; as follows:
#!  * <A>specification</A> is a list of pairs with first entry the name of the argument and second entry a default value (which must be immutable).
#!  * <A>func</A> must be a function with first argument `CAP_NAMED_ARGUMENTS`.
#!  * The return value is a function with one argument fewer than <A>func</A>.
#!  
#!  When calling the returned function, the arguments are passed on to <A>func</A>.
#!  To simulate named arguments, any &GAP; options appearing in <A>specification</A> are consumed and put into the record `CAP_NAMED_ARGUMENTS`.
DeclareGlobalFunction( "FunctionWithNamedArguments" );

#! @Arguments filter_string[, category]
#! @Returns a record
#! @Description
#!  The function takes one of the strings listed under `filter_list` in <Ref Sect="Section_method_name_record_entries" /> as input
#!  and returns the corresponding data type (see <Ref BookName="CompilerForCAP" Func="CapJitInferredDataTypes" /> for details).
#!  If no category is given, data types with generic filters (`IsCapCategoryObject`, `IsCapCategoryMorphism` etc.) are returned.
#!  However, those cannot be used in the context of `CompilerForCAP` because the component `category` cannot be set in this case.
DeclareGlobalFunction( "CAP_INTERNAL_GET_DATA_TYPE_FROM_STRING" );

#! @Arguments list_of_strings[, category]
#! @Returns a list
#! @Description
#!  Applies <Ref Func="CAP_INTERNAL_GET_DATA_TYPE_FROM_STRING" /> to all elements of <A>list</A> and returns the result.
DeclareGlobalFunction( "CAP_INTERNAL_GET_DATA_TYPES_FROM_STRINGS" );

#! @Arguments filter_string[, category]
#! @Returns a filter
#! @Description
#!  The function takes one of the strings listed under `filter_list` in <Ref Sect="Section_method_name_record_entries" /> as input.
#!  The corresponding filter of the category <A>category</A> is returned.
#!  If no category is given, generic filters (`IsCapCategoryObject`, `IsCapCategoryMorphism` etc.) are used.
DeclareGlobalFunction( "CAP_INTERNAL_REPLACED_STRING_WITH_FILTER" );

#! @Arguments list[, category]
#! @Returns Replaced list
#! @Description
#!  Applies <Ref Func="CAP_INTERNAL_REPLACED_STRING_WITH_FILTER" /> to all elements of <A>list</A> and returns the result.
DeclareGlobalFunction( "CAP_INTERNAL_REPLACED_STRINGS_WITH_FILTERS" );

DeclareGlobalFunction( "CAP_INTERNAL_REPLACED_STRINGS_WITH_FILTERS_FOR_JULIA" );

#! @Arguments string, value
#! @Returns option value
#! @Description
#!  Returns the value of the option with name string, or, if this value is fail,
#!  the object value.
DeclareGlobalFunction( "CAP_INTERNAL_RETURN_OPTION_OR_DEFAULT" );

#! @Arguments function, symbol_list, loop_multiple, replacement_record
#! @Returns a list of symbols with multiples
#! @Description
#!  The function searches for the appearance of the strings in symbol list on the function function
#!  and returns a list of pairs, containing the name of the symbol and the number of appearance.
#!  If the symbol appears in a loop, the number of appearance is counted times the loop multiple.
#!  Moreover, if appearances of found strings should be replaced by collections of other strings, then
#!  these can be specified in the replacement record.
DeclareGlobalFunction( "CAP_INTERNAL_FIND_APPEARANCE_OF_SYMBOL_IN_FUNCTION" );

#! @Arguments list1, list2
#! @Returns merge list
#! @Description
#!  The function takes two lists containing pairs of symbols (strings) and multiples.
#!  The lists are merged that pairs where the string only appears in one list is then
#!  added to the return list, if a pair with a string appears in both lists, the resulting
#!  lists only contains this pair once, with the higher multiple from both lists.
DeclareGlobalFunction( "CAP_INTERNAL_MERGE_PRECONDITIONS_LIST" );

#! @Arguments data_type, human_readable_identifier_getter
#! @Returns a function
#! @Description
#!  Returns a function `f` which throws an error if its first argument is not of type <A>data_type</A>.
#!  <A>human_readable_identifier_getter</A> is a function returning a string which is used to refer to the first argument of `f` in the error message.
#!  The arguments of `f` except the first argument are passed on to <A>human_readable_identifier_getter</A>.
DeclareGlobalFunction( "CAP_INTERNAL_ASSERT_VALUE_IS_OF_TYPE_GETTER" );

#! @Arguments cell, category, human_readable_identifier_getter
#! @Description
#!  The function throws an error if <A>cell</A> is not a cell of <A>category</A>.
#!  If <A>category</A> is the boolean <C>false</C>, only general checks not specific to a concrete category are performed.
#!  <A>human_readable_identifier_getter</A> is a 0-ary function returning a string which is used to refer to <A>cell</A> in the error message.
DeclareGlobalFunction( "CAP_INTERNAL_ASSERT_IS_CELL_OF_CATEGORY" );

#! @Arguments object, category, human_readable_identifier_getter
#! @Description
#!  The function throws an error if <A>object</A> is not an object of <A>category</A>.
#!  If <A>category</A> is the boolean <C>false</C>, only general checks not specific to a concrete category are performed.
#!  <A>human_readable_identifier_getter</A> is a 0-ary function returning a string which is used to refer to <A>cell</A> in the error message.
DeclareGlobalFunction( "CAP_INTERNAL_ASSERT_IS_OBJECT_OF_CATEGORY" );

#! @Arguments morphism, category, human_readable_identifier_getter
#! @Description
#!  The function throws an error if <A>morphism</A> is not a morphism of <A>category</A>.
#!  If <A>category</A> is the boolean <C>false</C>, only general checks not specific to a concrete category are performed.
#!  <A>human_readable_identifier_getter</A> is a 0-ary function returning a string which is used to refer to <A>cell</A> in the error message.
DeclareGlobalFunction( "CAP_INTERNAL_ASSERT_IS_MORPHISM_OF_CATEGORY" );

#! @Arguments two_cell, category, human_readable_identifier_getter
#! @Description
#!  The function throws an error if <A>two_cell</A> is not a $2$-cell of <A>category</A>.
#!  If <A>category</A> is the boolean <C>false</C>, only general checks not specific to a concrete category are performed.
#!  <A>human_readable_identifier_getter</A> is a 0-ary function returning a string which is used to refer to <A>cell</A> in the error message.
DeclareGlobalFunction( "CAP_INTERNAL_ASSERT_IS_TWO_CELL_OF_CATEGORY" );

DeclareGlobalFunction( "ListKnownCategoricalProperties" );

DeclareGlobalFunction( "HelpForCAP" );

#! @Arguments category[, operation]
#! @Description
#! Prints statistics for all caches in <A>category</A>.
#! If <A>operation</A> is given (as a string), only statistics
#! for the given operation cache is stored.
DeclareGlobalFunction( "CachingStatistic" );

#! @Arguments category
#! @Description
#! Displays statistics for all caches in <A>category</A>.
#! in a Browse window. Here "status" indicates if the cache is weak, strong, or inactive,
#! "hits" is the number of successful cache accesses, "misses" the number of unsuccessful cache
#! accesses, and "stored" the number of objects currently stored in the cache.
DeclareGlobalFunction( "BrowseCachingStatistic" );

#! @Arguments alias_name, function_name, deprecation_date
#! @Description
#!   Makes the function given by <A>function_name</A> available under the alias <A>alias_name</A>
#!   with a deprecation warning including the date <A>deprecation_date</A>.
DeclareGlobalFunction( "InstallDeprecatedAlias" );

#! @Description
#!   Checks if <A>filter2</A> is more special than <A>filter1</A>,
#!   i.e. if <A>filter2</A> implies <A>filter1</A>.
#!   <A>filter1</A> and/or <A>filter2</A> can also be one of the strings listed under `filter_list` in <Ref Sect="Section_method_name_record_entries" /> and
#!   in this case are replaced by the corresponding filters (e.g. `IsCapCategory`, `IsCapCategoryObject`, `IsCapCategoryMorphism`, ...).
#! @Arguments filter1, filter2
DeclareGlobalFunction( "IsSpecializationOfFilter" );

#! @Description
#!   Checks if <A>filter_list2</A> is more special than <A>filter_list1</A>,
#!   i.e. if both lists have the same length and any element of <A>filter_list2</A> is more special than
#!   the corresponding element of <A>filter_list1</A> in the sense of <Ref Func="IsSpecializationOfFilter" />.
#!   <A>filter_list1</A> and <A>filter_list2</A> can also be the string `"any"`, respresenting a most general filter list of any length.
#! @Arguments filter_list1, filter_list2
DeclareGlobalFunction( "IsSpecializationOfFilterList" );

#! @Description
#!   Installs a method via `InstallMethod` and adds it to the list of methods known to the compiler.
#!   See <Ref Func="CapJitAddKnownMethod" /> for requirements.
#! @Arguments same as for InstallMethod
DeclareGlobalFunction( "InstallMethodForCompilerForCAP" );

#! @Description
#!   Installs a method via `InstallOtherMethod` and adds it to the list of methods known to the compiler.
#!   See <Ref Func="CapJitAddKnownMethod" /> for requirements.
#! @Arguments same as for InstallOtherMethod
DeclareGlobalFunction( "InstallOtherMethodForCompilerForCAP" );

#! @Description
#!   Adds a method to the list of methods known to the compiler.
#!   If the first filter implies `IsCapCategory`,
#!   method selection only takes the number of arguments and the first filter into account.
#!   This allows to resolve operations even in the case that the syntax tree cannot fully be typed.
#!   If the first filter does not imply `IsCapCategory`,
#!   method selection takes all filters into account.
#!   To strictly distinguish between the two cases, `IsCapCategory` must not imply the first filter
#!   (except if the first filter is equal to `IsCapCategory`).
#!   Method selection is strict in the sense that two different methods for the same operation
#!   must not be comparable. That is, they must have a different number of filters or the filters
#!   at at least one position must not be related via implication.
#!   In particular, adding two methods with a CAP category as first argument (or a convenience method for a CAP operation)
#!   with the same number of arguments and one category filter implying the other is not supported.
#! @Arguments operation, filters, method
DeclareGlobalFunction( "CapJitAddKnownMethod" );

#! @Description
#!   (experimental) Adds a type signature for the global function or operation given by <A>name</A> to the compiler.
#!   <A>input_filters</A> must be a list of filters, or the string '"any"' representing a most general filter list of any length.
#!   <A>output_data_type</A> must be a filter, a data type, or a function.
#!   If it is a function with one argument, it must accept a list of input types and return the corresponding data type of the output.
#!   If it is a function with two arguments, it must accept the arguments of a function call of <A>name</A> (as syntax trees)
#!   and the function stack and return a record with components `args` (the possibly modified arguments) and `output_type`
#!   (the data type of the output).
#!   See <Ref BookName="CompilerForCAP" Func="CapJitInferredDataTypes" /> for more details on data types.
#! @Arguments name, input_filters, output_data_type
DeclareGlobalFunction( "CapJitAddTypeSignature" );

#! @Description
#!   (experimental) Returns the data type of a list whose elements are of type <A>element_type</A>.
#!   <A>element_type</A> must be a filter or a data type.
#! @Arguments element_type
DeclareGlobalFunction( "CapJitDataTypeOfListOf" );

#! @Description
#!   (experimental) Returns the data type of an <A>n</A>-tuple whose entries are of types corresponding to <A>element_types</A>.
#!   <A>element_types...</A> must be filters or data types.
#! @Arguments n, element_types...
DeclareGlobalFunction( "CapJitDataTypeOfNTupleOf" );

#! @BeginGroup
#! @Description
#!   (experimental) Returns the data type of the group (or elements of the group) <A>group</A>.
#! @Arguments group
DeclareGlobalFunction( "CapJitDataTypeOfGroup" );
#! @Arguments group
DeclareGlobalFunction( "CapJitDataTypeOfElementOfGroup" );
#! @EndGroup

#! @BeginGroup
#! @Description
#!   (experimental) Returns the data type of the ring (or elements of the ring) <A>ring</A>.
#! @Arguments ring
DeclareGlobalFunction( "CapJitDataTypeOfRing" );
#! @Arguments ring
DeclareGlobalFunction( "CapJitDataTypeOfElementOfRing" );
#! @EndGroup

#! @BeginGroup
#! @Description
#!   (experimental) Returns the data type of the category (or objects, morphisms, or two cells in the category) <A>category</A>.
#! @Arguments category
DeclareGlobalFunction( "CapJitDataTypeOfCategory" );
#! @Arguments category
DeclareGlobalFunction( "CapJitDataTypeOfObjectOfCategory" );
#! @Arguments category
DeclareGlobalFunction( "CapJitDataTypeOfMorphismOfCategory" );
#! @Arguments category
DeclareGlobalFunction( "CapJitDataTypeOfTwoCellOfCategory" );
#! @EndGroup

#! @Description
#!   (experimental) Simply returns <A>value</A>, but allows to specify the data type of <A>value</A> for CompilerForCAP.
#!   <A>data_type_getter</A> must be a literal function or a global variable pointing to a function.
#!   The function must accept no arguments or a single argument, and return a valid data type.
#!   If the function accepts a single argument, it must be inside a CAP operation or method known to CompilerForCAP (for example, see <Ref Func="InstallMethodForCompilerForCAP" />),
#!   and the current category (i.e. the first argument of the CAP operation or method known to CompilerForCAP) will be passed to the function.
#!   IMPORTANT: If <A>data_type_getter</A> is a literal function, it must not contain references to variables in its context.
#!   Otherwise the code might access random memory locations.
#!   See <Ref BookName="CompilerForCAP" Func="CapJitInferredDataTypes" /> for more details on data types.
#! @Arguments value, data_type_getter
DeclareGlobalFunction( "CapJitTypedExpression" );

#! @Description
#!   Computes a fixpoint of <A>func</A> with regard to equality given by <A>predicate</A>, starting with <A>initial_value</A>.
#!   If no such fixpoint exists, the execution does not terminate.
#! @Arguments predicate, func, initial_value
DeclareGlobalFunction( "CapFixpoint" );

#! @Description
#!   Shorthand for `Iterated( Concatenation( [ <A>initial_value</A> ], <A>list</A> ), <A>func</A> )`.
#! @Arguments list, func, initial_value
DeclareOperation( "Iterated", [ IsList, IsFunction, IsObject ] );

#! @Description
#!   Shorthand for `Iterated( Concatenation( [ <A>initial_value</A> ], <A>list</A>, [ <A>terminal_value</A> ] ), <A>func</A> )`.
#! @Arguments list, func, initial_value, terminal_value
DeclareOperation( "Iterated", [ IsList, IsFunction, IsObject, IsObject ] );

#! @Description
#!   Returns a list of package names which are transitively needed other packages of the package <A>package_name</A>.
#! @Arguments package_name
DeclareGlobalFunction( "TransitivelyNeededOtherPackages" );

#! @Description
#!   Returns the name of the package to which the CAP operation given by <A>operation_name</A> belongs or fail if the package is not known.
#! @Arguments operation_name
DeclareGlobalFunction( "PackageOfCAPOperation" );

#! @Description
#!   Returns `Position( <A>list</A>, <A>obj</A> )` while asserting that this value is not `fail`.
#! @Arguments list, obj
#! @Returns an integer
DeclareOperation( "SafePosition", [ IsList, IsObject ] );

#! @Description
#!   Returns `Position( <A>list</A>, <A>obj</A> )` while asserting that this value is not `fail` and the position is unique.
#! @Arguments list, obj
#! @Returns an integer
DeclareOperation( "SafeUniquePosition", [ IsList, IsObject ] );

#! @Description
#!   Returns `PositionProperty( <A>list</A>, <A>func</A> )` while asserting that this value is not `fail`.
#! @Arguments list, func
#! @Returns an integer
DeclareOperation( "SafePositionProperty", [ IsList, IsFunction ] );

#! @Description
#!   Returns a position in <A>list</A> for which <A>func</A> returns `true` when applied to the corresponding entry while asserting that there exists exactly one such position.
#! @Arguments list, func
#! @Returns an integer
DeclareOperation( "SafeUniquePositionProperty", [ IsList, IsFunction ] );

#! @Description
#!   Returns `First( <A>list</A>, <A>func</A> )` while asserting that this value is not `fail`.
#! @Arguments list, func
#! @Returns an element of the list
DeclareOperation( "SafeFirst", [ IsList, IsFunction ] );

#! @Description
#!   Returns a value in <A>list</A> for which <A>func</A> returns `true` while asserting that there exists exactly one such entry.
#! @Arguments list, func
#! @Returns an element of the list
DeclareOperation( "SafeUniqueEntry", [ IsList, IsFunction ] );

#! @Description
#!   Returns <A>args</A> while asserting that its length is <A>n</A>.
#! @Arguments n, args...
#! @Returns a list
DeclareGlobalFunction( "NTuple" );

# This filter is only used for the type system in CompilerForCAP.
# It deliberately does not imply `IsList` because we want to treat tuples and lists in different ways in CompilerForCAP.
DeclareFilter( "IsNTuple" );

#! @Description
#!   Alias for `NTuple( 2, <A>first</A>, <A>second</A> )`.
#! @Arguments first, second
#! @Returns a list
DeclareGlobalFunction( "Pair" );

#! @Description
#!   Alias for `NTuple( 3, <A>first</A>, <A>second</A>, <A>third</A> )`.
#! @Arguments first, second, third
#! @Returns a list
DeclareGlobalFunction( "Triple" );

#! @Description
#!  The arguments are two integers <A>nr_rows</A>, <A>nr_cols</A> and a list of lists <A>listlist</A> such that
#!  <A>nr_rows</A> = <C>Length</C>(<A>listlist</A>) and <A>nr_cols</A> = <C>Length</C>(<A>listlist</A>$[i]$) for $i=1$ to <A>nr_rows</A>.
#!  The output is the transpose of <A>listlist</A> as a list consisting of <A>nr_cols</A> rows and <A>nr_rows</A> columns.
#! @Arguments nr_rows, nr_cols, listlist
#! @Returns a list (of lists)
DeclareGlobalFunction( "TransposedMatWithGivenDimensions" );

#! @Description
#!   Handles the information stored in `<A>underlying_category</A>!.compiler_hints.precompiled_towers` (if bound) which is a list of records with components:
#!   * `remaining_constructors_in_tower`: a non-empty list of strings (names of category constructors)
#!   * `precompiled_functions_adder`: a function accepting a CAP category as input
#!
#!   If <A>constructor_name</A> is the only entry of `remaining_constructors_in_tower`, `precompiled_functions_adder` is applied to <A>category</A>
#!   (except if the option `no_precompiled_code` is set to `true`) and should add precompiled code.
#!   Else, if <A>constructor_name</A> is the first entry of `remaining_constructors_in_tower`, the information is attached to `<A>category</A>!.compiler_hints.precompiled_towers`
#!   after removing <A>constructor_name</A> from `remaining_constructors_in_tower`.
#!   Note: Currently, there is no logic for finding the "optimal" code to install if <A>constructor_name</A> is the only entry of `remaining_constructors_in_tower` of multiple entries.
#! @Arguments category, underlying_category, constructor_name
DeclareGlobalFunction( "HandlePrecompiledTowers" );

#! @Description
#!   Simply returns <A>value</A>. Used to signify that the argument is not fully run through all logic functions/templates by CompilerForCAP.
#! @Arguments value
DeclareGlobalFunction( "CAP_JIT_INCOMPLETE_LOGIC" );

#! @Description
#!   Simply returns <A>func</A>, which must be a literal function without arguments only containing an `if-elif-else` statement with each branch consisting of a single `return` statement.
#!   Used to write expressions of the form `function() if-elif-else end()` as `CAP_JIT_EXPR_CASE_WRAPPER(function() if-elif-else end)()` because the former is not valid in Julia.
#! @Arguments func
DeclareGlobalFunction( "CAP_JIT_EXPR_CASE_WRAPPER" );

#! @Description
#!   Same as `List( <A>list</A>, <A>func</A> )` but <A>func</A> gets both the key `i` and `<A>list</A>[i]` as arguments.
#! @Arguments list, func
#! @Returns a list
DeclareGlobalFunction( "ListWithKeys" );

#! @Description
#!   Same as `Sum( <A>list</A>, <A>func</A> )` but <A>func</A> gets both the key `i` and `<A>list</A>[i]` as arguments.
#! @Arguments list, func
#! @Returns a list
DeclareGlobalFunction( "SumWithKeys" );

#! @Description
#!   Same as `Product( <A>list</A>, <A>func</A> )` but <A>func</A> gets both the key `i` and `<A>list</A>[i]` as arguments.
#! @Arguments list, func
#! @Returns a list
DeclareGlobalFunction( "ProductWithKeys" );

#! @Description
#!   Same as `ForAll( <A>list</A>, <A>func</A> )` but <A>func</A> gets both the key `i` and `<A>list</A>[i]` as arguments.
#! @Arguments list, func
#! @Returns a list
DeclareGlobalFunction( "ForAllWithKeys" );

#! @Description
#!   Same as `ForAny( <A>list</A>, <A>func</A> )` but <A>func</A> gets both the key `i` and `<A>list</A>[i]` as arguments.
#! @Arguments list, func
#! @Returns a list
DeclareGlobalFunction( "ForAnyWithKeys" );

#! @Description
#!   Same as `Number( <A>list</A>, <A>func</A> )` but <A>func</A> gets both the key `i` and `<A>list</A>[i]` as arguments.
#! @Arguments list, func
#! @Returns a list
DeclareGlobalFunction( "NumberWithKeys" );

#! @Description
#!   Same as `Filtered( <A>list</A>, <A>func</A> )` but <A>func</A> gets both the key `i` and `<A>list</A>[i]` as arguments.
#! @Arguments list, func
#! @Returns a list
DeclareGlobalFunction( "FilteredWithKeys" );

#! @Description
#!   Same as `First( <A>list</A>, <A>func</A> )` but <A>func</A> gets both the key `i` and `<A>list</A>[i]` as arguments.
#! @Arguments list, func
#! @Returns a list
DeclareGlobalFunction( "FirstWithKeys" );

#! @Description
#!   Same as `Last( <A>list</A>, <A>func</A> )` but <A>func</A> gets both the key `i` and `<A>list</A>[i]` as arguments.
#! @Arguments list, func
#! @Returns a list
DeclareGlobalFunction( "LastWithKeys" );

#= comment for Julia
# In Julia we have to distinguish between (small) integers and big integers. In GAP there is no difference.
DeclareSynonym( "IsBigInt", IsInt );
# CompilerForCAP has to distinguish between BigInt and IdFunc
DeclareGlobalFunction( "BigInt" );
InstallGlobalFunction( BigInt, IdFunc );
# =#

#! @Description
#!   Shorthand for `ObjectifyWithAttributes( rec( ), type, [attribute1, value1, ...] )`.
#! @Arguments type, [attribute1, value1, ...]
DeclareGlobalFunction( "CreateGapObjectWithAttributes" );

#= comment for Julia
# This is relevant only in Julia to avoid world-age conflicts
DeclareSynonym( "CallFuncListAtRuntime", CallFuncList );
# =#
