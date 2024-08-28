# SPDX-License-Identifier: GPL-2.0-or-later
# CAP: Categories, Algorithms, Programming
#
# Declarations
#
#! @Chapter Morphisms
#!  Any GAP object satisfying <C>IsCapCategoryMorphism</C> can be added to a category
#!  and then becomes a morphism in this category.
#!  Any morphism can belong to one or no category.
#!  After a GAP object is added to the category, it knows which things can be
#!  computed in its category and to which category it belongs.
#!  It knows categorical properties and attributes, and the functions for existential quantifiers
#!  can be applied to the morphism.

###################################
##
#! @Section Attributes for the Type of Morphisms
##
###################################

#! @Description
#! The argument is a morphism $\alpha$.
#! The output is the category $\mathbf{C}$
#! to which $\alpha$ was added.
#! @Returns a category
#! @Arguments alpha
DeclareAttribute( "CapCategory",
                  IsCapCategoryMorphism );

#! @Description
#! The argument is a morphism $\alpha: a \rightarrow b$.
#! The output is its source $a$.
#! @Returns an object
#! @Arguments alpha
DeclareAttribute( "Source",
                  IsCapCategoryMorphism );

#! @Description
#! The argument is a morphism $\alpha: a \rightarrow b$.
#! The output is its range $b$.
#! @Returns an object
#! @Arguments alpha
DeclareAttribute( "Range",
                  IsCapCategoryMorphism );

#! @Description
#! The argument is a morphism $\alpha: a \rightarrow b$.
#! The output is its target $b$.
#! @Returns an object
#! @Arguments alpha
DeclareAttribute( "Target",
                  IsCapCategoryMorphism );

###################################
##
#! @Section Technical stuff
##
###################################

DeclareGlobalFunction( "CAP_INTERNAL_CREATE_MORPHISM_PRINT" );

DeclareGlobalFunction( "INSTALL_TODO_LIST_FOR_EQUAL_MORPHISMS" );

DeclareGlobalVariable( "PROPAGATION_LIST_FOR_EQUAL_MORPHISMS" );

## adds the given string to PROPAGATION_LIST_FOR_EQUAL_MORPHISMS
DeclareOperation( "AddPropertyToMatchAtIsCongruentForMorphisms",
                  [ IsCapCategory, IsString ] );

###################################
##
#! @Section Adding Morphisms to a Category
#! @SectionLabel Adding_Morphisms_to_a_Category
##
###################################

#! @Description
#!  Adds <A>morphism</A> as a morphism to <A>category</A>.
#! @Arguments category, morphism
DeclareOperation( "Add",
                  [ IsCapCategory, IsCapCategoryMorphism ] );

#! @Description
#!  Adds <A>morphism</A> as a morphism to <A>category</A>.
#!  If <A>morphism</A> already lies in the filter <C>IsCapCategoryMorphism</C>,
#!  the operation <Ref Oper="Add" Label="for IsCapCategory, IsCapCategoryMorphism" />
#!  can be used instead.
#! @Arguments category, morphism
DeclareOperation( "AddMorphism",
                  [ IsCapCategory, IsAttributeStoringRep ] );

#! @Arguments category, source, range[, attr1, val1, attr2, val2, ...]
#! @Description
#!  Creates a morphism in <A>category</A> with the given attributes.
#! @Returns a morphism
DeclareGlobalFunction( "CreateCapCategoryMorphismWithAttributes" );

#! @Arguments category, source, value, range
#! @Description
#!  EXPERIMENTAL: This specification might change any time without prior notice.
#!  Views <A>value</A> as a morphism from <A>source</A> to <A>range</A> in <A>category</A>.
#! @Returns a morphism
DeclareGlobalFunction( "AsCapCategoryMorphism" );

#! @BeginGroup
#! @Description
#!  EXPERIMENTAL: This specification might change any time without prior notice.
#!  Views a morphism obtained via <Ref Func="AsCapCategoryMorphism" /> as a primitive value again.
#!  Here, the word **primitive** means **primitive from the perspective of the category**.
#!  For example, from the perspective of an opposite category, morphisms of the underlying category
#!  are primitive values.
#!  The attribute is chosen according to the morphism datum type:
#!  * For `IsInt`, the attribute `AsInteger` is used.
#!  * For `IsHomalgMatrix`, the attribute `AsHomalgMatrix` is used.
#!  
#!  In all other cases or if no morphism datum type is given, the attribute `AsPrimitiveValue` is used.
#! @Returns a value
#! @Arguments morphism
DeclareAttribute( "AsPrimitiveValue", IsCapCategoryMorphism );
#! @Arguments morphism
DeclareAttribute( "AsInteger", IsCapCategoryMorphism );
#! @Arguments morphism
DeclareAttribute( "AsHomalgMatrix", IsCapCategoryMorphism );
#! @EndGroup
