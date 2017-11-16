#############################################################################
##
##                                               CAP package
##
##  Copyright 2014, Sebastian Gutsche, TU Kaiserslautern
##                  Sebastian Posur,   RWTH Aachen
##
#! @Chapter Technical Details
##
#############################################################################

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


#! @Arguments list, category
#! @Returns Replaced list
#! @Description
#!  The function takes a list (of lists) of filters or strings, where the strings
#!  can be category, cell, object, morphism, or twocell. The strings are then recursively replaced
#!  by the corresponding filters of the category. The replaced list is returned.
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

#! @Arguments function, symbol_list, loop_multiple
#! @Returns a list of symbols with multiples
#! @Description
#!  The function searches for the appearance of the strings in symbol list on the function function
#!  and returns a list of pairs, containing the name of the symbol and the number of appearance.
#!  If the symbol appears in a loop, the number of appearance is counted times the loop multiple.
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
