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

#! @Section Install functions for IsWellDefined

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
DeclareGlobalFunction( "AddSpecialMethod" );

#!
DeclareGlobalFunction( "DeclareFamilyProperty" );

DeclareGlobalVariable( "CAP_INTERNAL_METHOD_IMPLICATION_LIST" );

#!
DeclareGlobalFunction( "InstallTrueMethodAndStoreImplication" );


DeclareGlobalFunction( "CAP_INTERNAL_REPLACE_STRINGS_WITH_FILTERS" );
DeclareGlobalFunction( "CAP_INTERNAL_MERGE_FILTER_LISTS" );


