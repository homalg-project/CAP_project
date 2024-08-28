# SPDX-License-Identifier: GPL-2.0-or-later
# CAP: Categories, Algorithms, Programming
#
# Declarations
#
#! @Chapter Objects
#!  Any GAP object which is IsCapCategoryObject can be added to a category
#!  and then becomes an object in this category.
#!  Any object can belong to one or no category.
#!  After a GAP object is added to the category, it knows which things can be
#!  computed in its category and to which category it belongs.
#!  It knows categorial properties and attributes, and the functions for existential quantifiers
#!  can be applied to the object.
##
#############################################################################


###################################
##
#! @Section Attributes for the Type of Objects
##
###################################

#! @Description
#! The argument is an object $a$.
#! The output is the category $\mathbf{C}$
#! to which $a$ was added.
#! @Returns a category
#! @Arguments a
DeclareAttribute( "CapCategory",
                  IsCapCategoryObject );

###################################
##
#! @Section Technical stuff
##
###################################

DeclareGlobalFunction( "CAP_INTERNAL_CREATE_OBJECT_PRINT" );

DeclareGlobalFunction( "INSTALL_TODO_LIST_FOR_EQUAL_OBJECTS" );

DeclareGlobalVariable( "PROPAGATION_LIST_FOR_EQUAL_OBJECTS" );

## adds the given string to PROPAGATION_LIST_FOR_EQUAL_OBJECTS
DeclareOperation( "AddPropertyToMatchAtIsEqualForObjects",
                  [ IsCapCategory, IsString ] );

###################################
##
#! @Section Adding Objects to a Category
#! @SectionLabel Adding_Objects_to_a_Category
##
###################################

#! @Description
#!  Adds <A>object</A> as an object to <A>category</A>.
#! @Arguments category, object
DeclareOperation( "Add",
                  [ IsCapCategory, IsCapCategoryObject ] );

#! @Description
#!  Adds <A>object</A> as an object to <A>category</A>.
#!  If <A>object</A> already lies in the filter <C>IsCapCategoryObject</C>,
#!  the operation <Ref Oper="Add" Label="for IsCapCategory, IsCapCategoryObject" />
#!  can be used instead.
#! @Arguments category, object
DeclareOperation( "AddObject",
                  [ IsCapCategory, IsAttributeStoringRep ] );

#! @Arguments category, [attribute1, value1, ...]
#! @Description
#!  Creates an object in <A>category</A> with the given attributes.
#! @Returns an object
DeclareGlobalFunction( "CreateCapCategoryObjectWithAttributes" );

#! @Arguments category, value
#! @Description
#!  EXPERIMENTAL: This specification might change any time without prior notice.
#!  Views <A>value</A> as an object in <A>category</A>.
#! @Returns an object
DeclareGlobalFunction( "AsCapCategoryObject" );

#! @BeginGroup
#! @Description
#!  EXPERIMENTAL: This specification might change any time without prior notice.
#!  Views an object obtained via <Ref Func="AsCapCategoryObject" /> as a primitive value again.
#!  Here, the word **primitive** means **primitive from the perspective of the category**.
#!  For example, from the perspective of an opposite category, objects of the underlying category
#!  are primitive values.
#!  The attribute is chosen according to the object datum type:
#!  * For `IsInt`, the attribute `AsInteger` is used.
#!  * For `IsHomalgMatrix`, the attribute `AsHomalgMatrix` is used.
#!  
#!  In all other cases or if no object datum type is given, the attribute `AsPrimitiveValue` is used.
#! @Returns a value
#! @Arguments object
DeclareAttribute( "AsPrimitiveValue", IsCapCategoryObject );
#! @Arguments object
DeclareAttribute( "AsInteger", IsCapCategoryObject );
#! @Arguments object
DeclareAttribute( "AsHomalgMatrix", IsCapCategoryObject );
#! @EndGroup
