# SPDX-License-Identifier: GPL-2.0-or-later
# CAP: Categories, Algorithms, Programming
#
# Declarations
#
#! @Chapter Technical Details

#! @Section Install Functions for IsWellDefined

#! @Description
#!  The IsWellDefined filter is a basic function of CAP.
#!  For every categorial construction the outcome is well defined if
#!  and only if every input object or morphism of the construction is well defined.
#!  So for every implementation of a categorial construction a ToDoListEntry needs
#!  to be defined which propagates well definedness from the input cells to the output.
#!  For not writing this construction in every method, this function can be used to install
#!  a method which then installs the correct ToDoListEntries for the output.
#!  The input syntax works exactly like InstallMethod, with one extension:
#!  The method creates an auxilliary function which computes the output from the function given to
#!  InstallMethodWithToDoForIsWellDefined, then installs the ToDoListEntries, and then installs the
#!  auxilliary function instead of the original one. This is normally done with InstallMethod.
#!  However, one can change this via the option InstallMethod, which can be set to any other function
#!  which is then used instead of InstallMethod. This is used for the caching functions.
DeclareGlobalFunction( "InstallMethodWithToDoForIsWellDefined" );

DeclareGlobalFunction( "ToDoForIsWellDefinedWrapper" );


#! @Description
#!  For the caching one needs the possibility to install setters for functions with multiple arguments.
#!  This is a setter function which automatically adds ToDoListEntries for IsWellDefined like described above
#!  for the manually setted result of a method.
DeclareOperation( "InstallSetWithToDoForIsWellDefined",
                  [ IsObject, IsString, IsList ] );

#! @Description
#!  Since attributes install their setters themselfes, one needs to declare attributes
#!  in another way to ensure ToDoListEntries for IsWellDefined in the setter of an attribute.
#!  This function works like DeclareAttribute, but installs ToDoListEntries for the setter of
#!  the attribute. Please note that implementations still need to be done with InstallMethodWithToDoForIsWellDefined.
DeclareGlobalFunction( "DeclareAttributeWithToDoForIsWellDefined" );

#!
DeclareGlobalFunction( "DeclareFamilyProperty" );


#! @Arguments list[, category]
#! @Returns Replaced list
#! @Description
#!  The function takes a list (of lists) of filters or strings, where the strings
#!  can be category, cell, object, morphism, or twocell. The strings are then recursively replaced
#!  by the corresponding filters of the category. The replaced list is returned.
#!  If no category is given, generic filters (`IsCapCategoryObject`, `IsCapCategoryMorphism` etc.) are used.
DeclareGlobalFunction( "CAP_INTERNAL_REPLACE_STRINGS_WITH_FILTERS" );

#! @Arguments list, additional list
#! @Returns merged lists
#! @Description
#!  The first argument should be a dense list with filters, the second a sparse list containing filters
#!  not longer then the first one. The filters of the second list are then appended (via and) to the
#!  filters in the first list at the corresponding position, and the resulting list is returned.
DeclareGlobalFunction( "CAP_INTERNAL_MERGE_FILTER_LISTS" );

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

DeclareGlobalFunction( "CAP_INTERNAL_GET_CORRESPONDING_OUTPUT_OBJECTS" );

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
#!  <A>human_readable_identifier_getter</A> is a 0-ary function returning a string which is used to refer to <A>object</A> in the error message.
DeclareGlobalFunction( "CAP_INTERNAL_ASSERT_IS_OBJECT_OF_CATEGORY" );

#! @Arguments morphism, category, human_readable_identifier_getter
#! @Description
#!  The function throws an error if <A>morphism</A> is not a morphism of <A>category</A>.
#!  If <A>category</A> is the boolean <C>false</C>, only general checks not specific to a concrete category are performed.
#!  <A>human_readable_identifier_getter</A> is a 0-ary function returning a string which is used to refer to <A>morphism</A> in the error message.
DeclareGlobalFunction( "CAP_INTERNAL_ASSERT_IS_MORPHISM_OF_CATEGORY" );

#! @Arguments two_cell, category, human_readable_identifier_getter
#! @Description
#!  The function throws an error if <A>two_cell</A> is not a $2$-cell of <A>category</A>.
#!  If <A>category</A> is the boolean <C>false</C>, only general checks not specific to a concrete category are performed.
#!  <A>human_readable_identifier_getter</A> is a 0-ary function returning a string which is used to refer to <A>two_cell</A> in the error message.
DeclareGlobalFunction( "CAP_INTERNAL_ASSERT_IS_TWO_CELL_OF_CATEGORY" );

#! @Arguments list_of_objects, category, human_readable_identifier_getter
#! @Description
#!  The function throws an error if <A>list_of_objects</A> is not a dense list of objects of <A>category</A>.
#!  If <A>category</A> is the boolean <C>false</C>, only general checks not specific to a concrete category are performed.
#!  <A>human_readable_identifier_getter</A> is a 0-ary function returning a string which is used to refer to <A>list_of_objects</A> in the error message.
DeclareGlobalFunction( "CAP_INTERNAL_ASSERT_IS_LIST_OF_OBJECTS_OF_CATEGORY" );

#! @Arguments list_of_morphisms, category, human_readable_identifier_getter
#! @Description
#!  The function throws an error if <A>list_of_morphisms</A> is not a dense list of morphisms of <A>category</A>.
#!  If <A>category</A> is the boolean <C>false</C>, only general checks not specific to a concrete category are performed.
#!  <A>human_readable_identifier_getter</A> is a 0-ary function returning a string which is used to refer to <A>list_of_morphisms</A> in the error message.
DeclareGlobalFunction( "CAP_INTERNAL_ASSERT_IS_LIST_OF_MORPHISMS_OF_CATEGORY" );

#! @Arguments list_of_twocells, category, human_readable_identifier_getter
#! @Description
#!  The function throws an error if <A>list_of_twocells</A> is not a dense list of $2$-cells of <A>category</A>.
#!  If <A>category</A> is the boolean <C>false</C>, only general checks not specific to a concrete category are performed.
#!  <A>human_readable_identifier_getter</A> is a 0-ary function returning a string which is used to refer to <A>list_of_twocells</A> in the error message.
DeclareGlobalFunction( "CAP_INTERNAL_ASSERT_IS_LIST_OF_TWO_CELLS_OF_CATEGORY" );

#! @Arguments nnintorinf, human_readable_identifier_getter
#! @Description
#!  The function throws an error if <A>nnintorinf</A> is not a nonnegative integer or infinity.
#!  <A>human_readable_identifier_getter</A> is a 0-ary function returning a string which is used to refer to <A>nnintorinf</A> in the error message.
DeclareGlobalFunction( "CAP_INTERNAL_ASSERT_IS_NON_NEGATIVE_INTEGER_OR_INFINITY" );

DeclareGlobalFunction( "ListKnownCategoricalProperties" );

DeclareGlobalFunction( "CAP_MergeRecords" );

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
#! @Arguments filter1, filter2
DeclareGlobalFunction( "IsSpecializationOfFilter" );

#! @Description
#!   Checks if <A>filter_list2</A> is more special than <A>filter_list1</A>,
#!   i.e. if both lists have the same length and any element of <A>filter_list2</A> implies the corresponding element of <A>filter_list1</A>.
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
#!   The first argument of the method must be a CAP category.
#!   Method selection happens via the number of arguments and the category filter.
#!   In particular, adding two methods (or a convenience method for a CAP operation)
#!   with the same number of arguments and one category filter implying the other is not supported.
#! @Arguments operation, filters, method
DeclareGlobalFunction( "CapJitAddKnownMethod" );

#! @Description
#!   (experimental) Adds a type signature for the global function or operation given by <A>name</A> to the compiler.
#!   <A>input_filters</A> must be a list of filters.
#!   <A>output_data_type</A> must be a filter, a data type, or a function.
#!   If it is a function with one argument, it must accept a list of input types and return the corresponding data type of the output.
#!   If it is a function with two arguments, it must accept the arguments of a function call of <A>name</A> (as syntax trees)
#!   and the function stack and return a record with components `args` (the possibly modified arguments) and `output_type`
#!   (the data type of the output).
#!   See <Ref BookName="CompilerForCAP" Func="CapJitInferredDataTypes" /> for more details on data types.
#! @Arguments name, input_filters, output_data_type
DeclareGlobalFunction( "CapJitAddTypeSignature" );

#! @Description
#!   (experimental) Same as <Ref Func="CapJitAddTypeSignature" />, but the filters and the output data type must be given as strings
#!   which will be evaluated once <A>package_name</A> is loaded.
#!   This should be used with care because errors will only be detected at runtime.
#! @Arguments package_name, name, input_filters, output_data_type
DeclareGlobalFunction( "CapJitAddTypeSignatureDeferred" );

#! @Description
#!   Computes a fixpoint of <A>func</A> with regard to equality given by <A>predicate</A>, starting with <A>initial_value</A>.
#!   If no such fixpoint exists, the execution does not terminate.
#! @Arguments predicate, func, initial_value
DeclareGlobalFunction( "CapFixpoint" );
