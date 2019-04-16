#############################################################################
##
##                                               CAP package
##
##  Copyright 2013, Sebastian Gutsche, TU Kaiserslautern
##                  Sebastian Posur,   RWTH Aachen
##
#! @Chapter Morphisms
#!  Any GAP object satisfying <C>IsCapCategoryMorphism</C> can be added to a category
#!  and then becomes a morphism in this category.
#!  Any morphism can belong to one or no category.
#!  After a GAP object is added to the category, it knows which things can be
#!  computed in its category and to which category it belongs.
#!  It knows categorical properties and attributes, and the functions for existential quantifiers
#!  can be applied to the morphism.
##
#############################################################################


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

# this attribute is also an implied operation

DeclareOperation( "InverseOp",
                  [ IsCapCategoryMorphism ] );

###################################
##
#! @Section Technical stuff
##
###################################

DeclareGlobalFunction( "CAP_INTERNAL_CREATE_MORPHISM_PRINT" );

DeclareGlobalFunction( "INSTALL_TODO_LIST_FOR_EQUAL_MORPHISMS" );

DeclareGlobalVariable( "PROPAGATION_LIST_FOR_EQUAL_MORPHISMS" );

###################################
##
#! @Section Categorical Properties of Morphisms
##
###################################

## TODO
# @Description
# The argument is a morphism $\alpha$.
# The output is <C>true</C> if $\alpha$ is a monomorphism,
# otherwise the output is <C>false</C>.
# @Returns a boolean
# @Arguments alpha
DeclareFamilyProperty( "IsMonomorphism",
                       IsCapCategoryMorphism, "morphism" : reinstall := false );

#! @Description
#! The arguments are a category $C$ and a function $F$.
#! This operations adds the given function $F$
#! to the category for the basic operation <C>IsMonomorphism</C>.
#! $F: \alpha \mapsto \mathtt{IsMonomorphism}(\alpha)$.
#! @Returns nothing
#! @Arguments C, F
DeclareOperation( "AddIsMonomorphism",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddIsMonomorphism",
                  [ IsCapCategory, IsFunction, IsInt ] );

DeclareOperation( "AddIsMonomorphism",
                  [ IsCapCategory, IsList, IsInt ] );

DeclareOperation( "AddIsMonomorphism",
                  [ IsCapCategory, IsList ] );





## TODO
# @Description
# The argument is a morphism $\alpha$.
# The output is <C>true</C> if $\alpha$ is an epimorphism,
# otherwise the output is <C>false</C>.
# @Returns a boolean
# @Arguments alpha
DeclareFamilyProperty( "IsEpimorphism",
                       IsCapCategoryMorphism, "morphism" : reinstall := false );

#! @Description
#! The arguments are a category $C$ and a function $F$.
#! This operations adds the given function $F$
#! to the category for the basic operation <C>IsEpimorphism</C>.
#! $F: \alpha \mapsto \mathtt{IsEpimorphism}(\alpha)$.
#! @Returns nothing
#! @Arguments C, F
DeclareOperation( "AddIsEpimorphism",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddIsEpimorphism",
                  [ IsCapCategory, IsFunction, IsInt ] );

DeclareOperation( "AddIsEpimorphism",
                  [ IsCapCategory, IsList, IsInt ] );

DeclareOperation( "AddIsEpimorphism",
                  [ IsCapCategory, IsList ] );



## TODO
# @Description
# The argument is a morphism $\alpha$.
# The output is <C>true</C> if $\alpha$ is an isomorphism,
# otherwise the output is <C>false</C>.
# @Returns a boolean
# @Arguments alpha
DeclareFamilyProperty( "IsIsomorphism",
                       IsCapCategoryMorphism, "morphism" : reinstall := false );

#! @Description
#! The arguments are a category $C$ and a function $F$.
#! This operations adds the given function $F$
#! to the category for the basic operation <C>IsIsomorphism</C>.
#! $F: \alpha \mapsto \mathtt{IsIsomorphism}(\alpha)$.
#! @Returns nothing
#! @Arguments C, F
DeclareOperation( "AddIsIsomorphism",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddIsIsomorphism",
                  [ IsCapCategory, IsFunction, IsInt ] );

DeclareOperation( "AddIsIsomorphism",
                  [ IsCapCategory, IsList, IsInt ] );

DeclareOperation( "AddIsIsomorphism",
                  [ IsCapCategory, IsList ] );



## TODO
# @Description
# The argument is a morphism $\alpha$.
# The output is <C>true</C> if $\alpha$ is a split monomorphism,
# otherwise the output is <C>false</C>.
# @Returns a boolean
# @Arguments alpha
DeclareFamilyProperty( "IsSplitMonomorphism",
                       IsCapCategoryMorphism, "morphism" : reinstall := false );

#! @Description
#! The arguments are a category $C$ and a function $F$.
#! This operations adds the given function $F$
#! to the category for the basic operation <C>IsSplitMonomorphism</C>.
#! $F: \alpha \mapsto \mathtt{IsSplitMonomorphism}(\alpha)$.
#! @Returns nothing
#! @Arguments C, F
DeclareOperation( "AddIsSplitMonomorphism",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddIsSplitMonomorphism",
                  [ IsCapCategory, IsFunction, IsInt ] );

DeclareOperation( "AddIsSplitMonomorphism",
                  [ IsCapCategory, IsList, IsInt ] );

DeclareOperation( "AddIsSplitMonomorphism",
                  [ IsCapCategory, IsList ] );

## TODO
# @Description
# The argument is a morphism $\alpha$.
# The output is <C>true</C> if $\alpha$ is a split epimorphism,
# otherwise the output is <C>false</C>.
# @Returns a boolean
# @Arguments alpha
DeclareFamilyProperty( "IsSplitEpimorphism",
                       IsCapCategoryMorphism, "morphism" : reinstall := false );

#! @Description
#! The arguments are a category $C$ and a function $F$.
#! This operations adds the given function $F$
#! to the category for the basic operation <C>IsSplitEpimorphism</C>.
#! $F: \alpha \mapsto \mathtt{IsSplitEpimorphism}(\alpha)$.
#! @Returns nothing
#! @Arguments C, F
DeclareOperation( "AddIsSplitEpimorphism",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddIsSplitEpimorphism",
                  [ IsCapCategory, IsFunction, IsInt ] );

DeclareOperation( "AddIsSplitEpimorphism",
                  [ IsCapCategory, IsList, IsInt ] );

DeclareOperation( "AddIsSplitEpimorphism",
                  [ IsCapCategory, IsList ] );

## TODO
# @Description
# The argument is a morphism $\alpha: a \rightarrow a$.
# The output is <C>true</C> if $\alpha$ is congruent to the identity of $a$,
# otherwise the output is <C>false</C>.
# @Returns a boolean
# @Arguments alpha
DeclareFamilyProperty( "IsOne",
                       IsCapCategoryMorphism, "morphism" : reinstall := false );

#! @Description
#! The arguments are a category $C$ and a function $F$.
#! This operations adds the given function $F$
#! to the category for the basic operation <C>IsOne</C>.
#! $F: \alpha \mapsto \mathtt{IsOne}(\alpha)$.
#! @Returns nothing
#! @Arguments C, F
DeclareOperation( "AddIsOne",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddIsOne",
                  [ IsCapCategory, IsFunction, IsInt ] );

DeclareOperation( "AddIsOne",
                  [ IsCapCategory, IsList, IsInt ] );

DeclareOperation( "AddIsOne",
                  [ IsCapCategory, IsList ] );

## TODO
# @Description
# The argument is a morphism $\alpha: a \rightarrow a$.
# The output is <C>true</C> if $\alpha^2 \sim_{a,a} \alpha$,
# otherwise the output is <C>false</C>.
# @Returns a boolean
# @Arguments alpha
DeclareFamilyProperty( "IsIdempotent",
                       IsCapCategoryMorphism, "morphism" : reinstall := false );

#! @Description
#! The arguments are a category $C$ and a function $F$.
#! This operations adds the given function $F$
#! to the category for the basic operation <C>IsIdempotent</C>.
#! $F: \alpha \mapsto \mathtt{IsIdempotent}(\alpha)$.
#! @Returns nothing
#! @Arguments C, F
DeclareOperation( "AddIsIdempotent",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddIsIdempotent",
                  [ IsCapCategory, IsFunction, IsInt ] );

DeclareOperation( "AddIsIdempotent",
                  [ IsCapCategory, IsList, IsInt ] );

DeclareOperation( "AddIsIdempotent",
                  [ IsCapCategory, IsList ] );

###################################
##
#! @Section Random Morphisms
##
###################################

#! CAP provides two principal methods to generate random morphisms with or without fixed source and range:
#!  * <E>By integers</E>: The integer is simply a parameter that can be used to create a random morphism.
#!  * <E>By lists</E>: The list is used when creating a random morphism would need more than one parameter. Lists offer more
#!    flexibility at the expense of the genericity of the methods. This happens because lists that are valid as input in
#!    some category may be not valid for other categories. Hence, these operations are not thought to be used in
#!    generic categorical algorithms.

#! @Description
#! The arguments are an object $a$ in a category $C$ and an integer $n$.
#! The output is a random morphism $\alpha: a \rightarrow b$ for some object
#! $b$ in $C$ or <C>fail</C>.
#! @Returns a morphism in $\mathrm{Hom}(a,b)$ or <C>fail</C>
#! @Arguments a, n
DeclareOperation( "RandomMorphismWithFixedSourceByInteger",
                  [ IsCapCategoryObject, IsInt ] );

#! @Description
#! The arguments are a category $C$ and a function $F$.
#! This operation adds the given function $F$
#! to the category for the basic operation <C>RandomMorphismWithFixedSourceByInteger</C>.
#! The function $F$ maps $(a,n)$ to <C>fail</C> or to a random morphism in
#! $C$ whose source is $a$.
#! @Returns nothing
#! @Arguments C, F
DeclareOperation( "AddRandomMorphismWithFixedSourceByInteger",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddRandomMorphismWithFixedSourceByInteger",
                  [ IsCapCategory, IsFunction, IsInt ] );

DeclareOperation( "AddRandomMorphismWithFixedSourceByInteger",
                  [ IsCapCategory, IsList, IsInt ] );

DeclareOperation( "AddRandomMorphismWithFixedSourceByInteger",
                  [ IsCapCategory, IsList ] );

#! @Description
#! The arguments are an object $a$ in a category $C$ and a list $L$.
#! The output is a random morphism $\alpha: a \rightarrow b$ for some object
#! $b$ in $C$ or <C>fail</C>.
#! @Returns a morphism in $\mathrm{Hom}(a,b)$ or <C>fail</C>
#! @Arguments a, L
DeclareOperation( "RandomMorphismWithFixedSourceByList",
                  [ IsCapCategoryObject, IsList ] );

#! @Description
#! The arguments are a category $C$ and a function $F$.
#! This operation adds the given function $F$
#! to the category for the basic operation <C>RandomMorphismWithFixedSourceByList</C>.
#! The function $F$ maps $(a,L)$ to <C>fail</C> or to a random morphism in
#! $C$ whose source is $a$.
#! @Returns nothing
#! @Arguments C, F
DeclareOperation( "AddRandomMorphismWithFixedSourceByList",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddRandomMorphismWithFixedSourceByList",
                  [ IsCapCategory, IsFunction, IsInt ] );

DeclareOperation( "AddRandomMorphismWithFixedSourceByList",
                  [ IsCapCategory, IsList, IsInt ] );

DeclareOperation( "AddRandomMorphismWithFixedSourceByList",
                  [ IsCapCategory, IsList ] );


#! @Description
#! The arguments are an object $b$ in a category $C$ and an integer $n$.
#! The output is a random morphism $\alpha: a \rightarrow b$ for some object
#! $a$ in $C$ or <C>fail</C>.
#! @Returns a morphism in $\mathrm{Hom}(a,b)$ or <C>fail</C>
#! @Arguments b, n
DeclareOperation( "RandomMorphismWithFixedRangeByInteger",
                  [ IsCapCategoryObject, IsInt ] );

#! @Description
#! The arguments are a category $C$ and a function $F$.
#! This operation adds the given function $F$
#! to the category for the basic operation <C>RandomMorphismWithFixedRangeByInteger</C>.
#! The function $F$ maps $(b,n)$ to <C>fail</C> or to a random morphism in
#! $C$ whose range is $b$.
#! @Returns nothing
#! @Arguments C, F
DeclareOperation( "AddRandomMorphismWithFixedRangeByInteger",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddRandomMorphismWithFixedRangeByInteger",
                  [ IsCapCategory, IsFunction, IsInt ] );

DeclareOperation( "AddRandomMorphismWithFixedRangeByInteger",
                  [ IsCapCategory, IsList, IsInt ] );

DeclareOperation( "AddRandomMorphismWithFixedRangeByInteger",
                  [ IsCapCategory, IsList ] );

#! @Description
#! The arguments are an object $b$ in a category $C$ and a list $L$.
#! The output is a random morphism $\alpha: a \rightarrow b$ for some object
#! $a$ in $C$ or <C>fail</C>.
#! @Returns a morphism in $\mathrm{Hom}(a,b)$ or <C>fail</C>
#! @Arguments b, L
DeclareOperation( "RandomMorphismWithFixedRangeByList",
                  [ IsCapCategoryObject, IsList ] );

#! @Description
#! The arguments are a category $C$ and a function $F$.
#! This operation adds the given function $F$
#! to the category for the basic operation <C>RandomMorphismWithFixedRangeByList</C>.
#! The function $F$ maps $(b,L)$ to <C>fail</C> or to a random morphism in
#! $C$ whose range is $b$.
#! @Returns nothing
#! @Arguments C, F
DeclareOperation( "AddRandomMorphismWithFixedRangeByList",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddRandomMorphismWithFixedRangeByList",
                  [ IsCapCategory, IsFunction, IsInt ] );

DeclareOperation( "AddRandomMorphismWithFixedRangeByList",
                  [ IsCapCategory, IsList, IsInt ] );

DeclareOperation( "AddRandomMorphismWithFixedRangeByList",
                  [ IsCapCategory, IsList ] );

#! @Description
#! The arguments are two objects $a$ and $b$ in a category $C$ and an integer $n$.
#! The output is a random morphism $\alpha: a \rightarrow b$ in $C$ or <C>fail</C>.
#! @Returns a morphism in $\mathrm{Hom}(a,b)$ or <C>fail</C>
#! @Arguments a, b, n
DeclareOperation( "RandomMorphismWithFixedSourceAndRangeByInteger",
                  [ IsCapCategoryObject, IsCapCategoryObject, IsInt ] );

#! @Description
#! The arguments are a category $C$ and a function $F$.
#! This operations adds the given function $F$
#! to the category for the basic operation <C>RandomMorphismWithFixedSourceAndRangeByInteger</C>.
#! The function $F$ maps $(a,b,n)$ to <C>fail</C> or to a random morphism in $C$
#! from $a$ to $b$.
#! @Returns nothing
#! @Arguments C, F
DeclareOperation( "AddRandomMorphismWithFixedSourceAndRangeByInteger",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddRandomMorphismWithFixedSourceAndRangeByInteger",
                  [ IsCapCategory, IsFunction, IsInt ] );

DeclareOperation( "AddRandomMorphismWithFixedSourceAndRangeByInteger",
                  [ IsCapCategory, IsList, IsInt ] );

DeclareOperation( "AddRandomMorphismWithFixedSourceAndRangeByInteger",
                  [ IsCapCategory, IsList ] );

#! @Description
#! This operation is not a CAP basic operation
#! The arguments are two objects $a$ and $b$ in a category $C$ and a list $L$.
#! The output is a random morphism $\alpha: a \rightarrow b$ in $C$ or <C>fail</C>.
#! @Returns a morphism in $\mathrm{Hom}(a,b)$ or <C>fail</C>
#! @Arguments a, b, L
DeclareOperation( "RandomMorphismWithFixedSourceAndRangeByList",
                  [ IsCapCategoryObject, IsCapCategoryObject, IsList ] );

#! @Description
#! The arguments are a category $C$ and a function $F$.
#! This operations adds the given function $F$
#! to the category for the basic operation <C>RandomMorphismWithFixedSourceAndRangeByList</C>.
#! The function $F$ maps $(a,b,L)$ to <C>fail</C> or to a random morphism in $C$
#! from $a$ to $b$.
#! @Returns nothing
#! @Arguments C, F
DeclareOperation( "AddRandomMorphismWithFixedSourceAndRangeByList",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddRandomMorphismWithFixedSourceAndRangeByList",
                  [ IsCapCategory, IsFunction, IsInt ] );

DeclareOperation( "AddRandomMorphismWithFixedSourceAndRangeByList",
                  [ IsCapCategory, IsList, IsInt ] );

DeclareOperation( "AddRandomMorphismWithFixedSourceAndRangeByList",
                  [ IsCapCategory, IsList ] );

#! @Description
#! The arguments are a category $C$ and an integer $n$.
#! The output is a random morphism in $C$ or <C>fail</C>.
#! If the methods <C>RandomObjectByInteger</C> and
#! <C>RandomMorphismWithFixedSourceByInteger</C>(<C>RandomMorphismWithFixedRangeByInteger</C>)
#! are added to the category $C$, then <C>RandomMorphismByInteger</C> can be
#! derived to return a random morphism of complexity $n$ with random
#! source(range) of complexity $n$.
#! @Returns a morphism or <C>fail</C>
#! @Arguments C, n
DeclareOperation( "RandomMorphismByInteger",
                  [ IsCapCategory, IsInt ] );

#! @Description
#! The arguments are a category $C$ and a function $F$.
#! This operation adds the given function $F$
#! to the category for the basic operation <C>RandomMorphismByInteger</C>.
#! The function $F$ maps $(C,n)$ to <C>fail</C> or to a random morphism in $C$.
#! @Returns nothing
#! @Arguments C, F
DeclareOperation( "AddRandomMorphismByInteger",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddRandomMorphismByInteger",
                  [ IsCapCategory, IsFunction, IsInt ] );

DeclareOperation( "AddRandomMorphismByInteger",
                  [ IsCapCategory, IsList, IsInt ] );

DeclareOperation( "AddRandomMorphismByInteger",
                  [ IsCapCategory, IsList ] );

#! @Description
#! The arguments are a category $C$ and a list $L$.
#! The output is a random morphism in $C$ or <C>fail</C>.
#! @Returns a morphism or <C>fail</C>
#! @Arguments C, L
DeclareOperation( "RandomMorphismByList",
                  [ IsCapCategory, IsList ] );

#! @Description
#! The arguments are a category $C$ and a function $F$.
#! This operation adds the given function $F$
#! to the category for the basic operation <C>RandomMorphismByList</C>.
#! The function $F$ maps $(C,L)$ to <C>fail</C> or to a random morphism in $C$.
#! @Returns nothing
#! @Arguments C, F
DeclareOperation( "AddRandomMorphismByList",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddRandomMorphismByList",
                  [ IsCapCategory, IsFunction, IsInt ] );

DeclareOperation( "AddRandomMorphismByList",
                  [ IsCapCategory, IsList, IsInt ] );

DeclareOperation( "AddRandomMorphismByList",
                  [ IsCapCategory, IsList ] );

#! @BeginGroup
#! @Description
#! These are convenient methods and they, depending on the input, delegate to one of the above methods.
# @Returns an object, morphism or fail
#! @Arguments a, n
DeclareOperation( "RandomMorphismWithFixedSource", [ IsCapCategoryObject, IsInt ] );
#! @Arguments a, L
DeclareOperation( "RandomMorphismWithFixedSource", [ IsCapCategoryObject, IsList ] );
#! @Arguments b, n
DeclareOperation( "RandomMorphismWithFixedRange", [ IsCapCategoryObject, IsInt ] );
#! @Arguments b, L
DeclareOperation( "RandomMorphismWithFixedRange", [ IsCapCategoryObject, IsList ] );
#! @Arguments a, b, n
DeclareOperation( "RandomMorphismWithFixedSourceAndRange", [ IsCapCategoryObject, IsCapCategoryObject, IsInt ] );
#! @Arguments a, b, L
DeclareOperation( "RandomMorphismWithFixedSourceAndRange", [ IsCapCategoryObject, IsCapCategoryObject, IsList ] );
#! @Arguments C, n
DeclareOperation( "RandomMorphism", [ IsCapCategory, IsInt ] );
#! @Arguments C, L
DeclareOperation( "RandomMorphism", [ IsCapCategory, IsList ] );
#! @EndGroup

###################################
##
#! @Section Non-Categorical Properties of Morphisms
##
###################################

#! Non-categorical properties are not stable under equivalences of categories.

#! @Description
#! The argument is a morphism $\alpha: a \rightarrow b$.
#! The output is <C>true</C> if $\alpha = \mathrm{id}_a$,
#! otherwise the output is <C>false</C>.
#! @Returns a boolean
#! @Arguments alpha
DeclareProperty( "IsIdenticalToIdentityMorphism",
                 IsCapCategoryMorphism );

#! @Description
#! The arguments are a category $C$ and a function $F$.
#! This operations adds the given function $F$
#! to the category for the basic operation <C>IsIdenticalToIdentityMorphism</C>.
#! $F: \alpha \mapsto \mathtt{IsIdenticalToIdentityMorphism}(\alpha)$.
#! @Returns nothing
#! @Arguments C, F
DeclareOperation( "AddIsIdenticalToIdentityMorphism",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddIsIdenticalToIdentityMorphism",
                  [ IsCapCategory, IsFunction, IsInt ] );

DeclareOperation( "AddIsIdenticalToIdentityMorphism",
                  [ IsCapCategory, IsList, IsInt ] );

DeclareOperation( "AddIsIdenticalToIdentityMorphism",
                  [ IsCapCategory, IsList ] );

#! @Description
#! The argument is a morphism $\alpha: a \rightarrow b$.
#! The output is <C>true</C> if $\alpha = 0$,
#! otherwise the output is <C>false</C>.
#! @Returns a boolean
#! @Arguments alpha
DeclareProperty( "IsIdenticalToZeroMorphism",
                 IsCapCategoryMorphism );

#! @Description
#! The arguments are a category $C$ and a function $F$.
#! This operations adds the given function $F$
#! to the category for the basic operation <C>IsIdenticalToZeroMorphism</C>.
#! $F: \alpha \mapsto \mathtt{IsIdenticalToZeroMorphism }(\alpha)$.
#! @Returns nothing
#! @Arguments C, F
DeclareOperation( "AddIsIdenticalToZeroMorphism",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddIsIdenticalToZeroMorphism",
                  [ IsCapCategory, IsFunction, IsInt ] );

DeclareOperation( "AddIsIdenticalToZeroMorphism",
                  [ IsCapCategory, IsList, IsInt ] );

DeclareOperation( "AddIsIdenticalToZeroMorphism",
                  [ IsCapCategory, IsList ] );


## TODO
## This is not a categorical property because non-endomorphisms 
## can be mapped to endomorphisms under equivalences of categories.
# @Description
# The argument is a morphism $\alpha$.
# The output is <C>true</C> if $\alpha$ is an endomorphism,
# otherwise the output is <C>false</C>.
# @Returns a boolean
# @Arguments alpha
DeclareFamilyProperty( "IsEndomorphism",
                       IsCapCategoryMorphism, "morphism" : reinstall := false );

#! @Description
#! The arguments are a category $C$ and a function $F$.
#! This operations adds the given function $F$
#! to the category for the basic operation <C>IsEndomorphism</C>.
#! $F: \alpha \mapsto \mathtt{IsEndomorphism}(\alpha)$.
#! @Returns nothing
#! @Arguments C, F
DeclareOperation( "AddIsEndomorphism",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddIsEndomorphism",
                  [ IsCapCategory, IsFunction, IsInt ] );

DeclareOperation( "AddIsEndomorphism",
                  [ IsCapCategory, IsList, IsInt ] );

DeclareOperation( "AddIsEndomorphism",
                  [ IsCapCategory, IsList ] );

## TODO
## This is not a categorical property because non-endomorphisms 
## can be mapped to endomorphisms under equivalences of categories.
# @Description
# The argument is a morphism $\alpha$.
# The output is <C>true</C> if $\alpha$ is an automorphism,
# otherwise the output is <C>false</C>.
# @Returns a boolean
# @Arguments alpha
DeclareFamilyProperty( "IsAutomorphism",
                       IsCapCategoryMorphism, "morphism" : reinstall := false );

#! @Description
#! The arguments are a category $C$ and a function $F$.
#! This operations adds the given function $F$
#! to the category for the basic operation <C>IsAutomorphism</C>.
#! $F: \alpha \mapsto \mathtt{IsAutomorphism}(\alpha)$.
#! @Returns nothing
#! @Arguments C, F
DeclareOperation( "AddIsAutomorphism",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddIsAutomorphism",
                  [ IsCapCategory, IsFunction, IsInt ] );

DeclareOperation( "AddIsAutomorphism",
                  [ IsCapCategory, IsList, IsInt ] );

DeclareOperation( "AddIsAutomorphism",
                  [ IsCapCategory, IsList ] );


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

#! @Arguments category, filter
#! @Description
#!  The argument <A>filter</A> is used to create a morphism type for the
#!  category <A>category</A>, which is then used in <C>ObjectifyMorphismForCAPWithAttributes</C>
#!  to objectify morphisms for this category.
DeclareOperation( "AddMorphismRepresentation",
                  [ IsCapCategory, IsObject ] );

#! @Arguments morphism, category, [attribute1, value1, ...]
#! @Description
#!  Objectifies the morphism <A>morphism</A> with the type created
#!  for morphisms in the category <A>category</A>. The type
#!  is created by passing a representation to <C>AddMorphismRepresentation</C>.
#!  Morphisms which are objectified using this method do not have to be passed
#!  to the <C>AddMorphism</C> function.
#!
#!  Please note that the <C>Source</C> and <C>Range</C> attribute need to be passed to
#!  this function. The values belonging to these attrbutes will not be objectified.
DeclareGlobalFunction( "ObjectifyMorphismForCAPWithAttributes" );

###################################
##
#! @Section Equality and Congruence for Morphisms
##
###################################


#! @Description
#! The arguments are two morphisms $\alpha, \beta: a \rightarrow b$.
#! The output is <C>true</C> if $\alpha \sim_{a,b} \beta$,
#! otherwise the output is <C>false</C>.
#! @Returns a boolean
#! @Arguments alpha, beta
DeclareOperation( "IsCongruentForMorphisms",
                  [ IsCapCategoryMorphism, IsCapCategoryMorphism ] );

#! @Description
#! The arguments are a category $C$ and a function $F$.
#! This operations adds the given function $F$
#! to the category for the basic operation <C>IsCongruentForMorphisms</C>.
#! $F: (\alpha, \beta) \mapsto \mathtt{IsCongruentForMorphisms}(\alpha, \beta)$.
#! @Returns nothing
#! @Arguments C, F
DeclareOperation( "AddIsCongruentForMorphisms",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddIsCongruentForMorphisms",
                  [ IsCapCategory, IsFunction, IsInt ] );

DeclareOperation( "AddIsCongruentForMorphisms",
                  [ IsCapCategory, IsList, IsInt ] );

DeclareOperation( "AddIsCongruentForMorphisms",
                  [ IsCapCategory, IsList ] );


#! @Description
#! The arguments are two morphisms $\alpha, \beta: a \rightarrow b$.
#! The output is <C>true</C> if $\alpha = \beta$,
#! otherwise the output is <C>false</C>.
#! @Returns a boolean
#! @Arguments alpha, beta
DeclareOperation( "IsEqualForMorphisms",
                  [ IsCapCategoryMorphism, IsCapCategoryMorphism ] );

#! @Description
#! The arguments are a category $C$ and a function $F$.
#! This operations adds the given function $F$
#! to the category for the basic operation <C>IsEqualForMorphisms</C>.
#! $F: (\alpha, \beta) \mapsto \mathtt{IsEqualForMorphisms}(\alpha, \beta)$.
#! @Returns nothing
#! @Arguments C, F
DeclareOperation( "AddIsEqualForMorphisms",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddIsEqualForMorphisms",
                  [ IsCapCategory, IsFunction, IsInt ] );

DeclareOperation( "AddIsEqualForMorphisms",
                  [ IsCapCategory, IsList, IsInt ] );

DeclareOperation( "AddIsEqualForMorphisms",
                  [ IsCapCategory, IsList ] );


#! @Description
#! The arguments are two morphisms $\alpha: a \rightarrow b, \beta: c \rightarrow d$.
#! The output is <C>true</C> if $\alpha = \beta$,
#! otherwise the output is <C>false</C>.
#! @Returns a boolean
#! @Arguments alpha, beta
DeclareOperation( "IsEqualForMorphismsOnMor",
                  [ IsCapCategoryMorphism, IsCapCategoryMorphism ] );

#! @Description
#! The arguments are a category $C$ and a function $F$.
#! This operations adds the given function $F$
#! to the category for the basic operation <C>IsEqualForMorphismsOnMor</C>.
#! $F: (\alpha, \beta) \mapsto \mathtt{IsEqualForMorphismsOnMor}(\alpha, \beta)$.
#! @Returns nothing
#! @Arguments C, F
DeclareOperation( "AddIsEqualForMorphismsOnMor",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddIsEqualForMorphismsOnMor",
                  [ IsCapCategory, IsFunction, IsInt ] );

DeclareOperation( "AddIsEqualForMorphismsOnMor",
                  [ IsCapCategory, IsList, IsInt ] );

DeclareOperation( "AddIsEqualForMorphismsOnMor",
                  [ IsCapCategory, IsList ] );


## adds the given string to PROPAGATION_LIST_FOR_EQUAL_MORPHISMS
DeclareOperation( "AddPropertyToMatchAtIsCongruentForMorphisms",
                  [ IsCapCategory, IsString ] );

###################################
##
#! @Section Basic Operations for Morphisms in Ab-Categories
##
###################################

#! @Description
#! The argument is a morphism $\alpha: a \rightarrow b$.
#! The output is <C>true</C> if $\alpha \sim_{a,b} 0$,
#! otherwise the output is <C>false</C>.
#! @Returns a boolean
#! @Arguments alpha
DeclareProperty( "IsZeroForMorphisms",
                 IsCapCategoryMorphism );

#! @Description
#! The arguments are a category $C$ and a function $F$.
#! This operations adds the given function $F$
#! to the category for the basic operation <C>IsZeroForMorphisms</C>.
#! $F: \alpha \mapsto \mathtt{IsZeroForMorphisms}(\alpha)$.
#! @Returns nothing
#! @Arguments C, F
DeclareOperation( "AddIsZeroForMorphisms",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddIsZeroForMorphisms",
                  [ IsCapCategory, IsFunction, IsInt ] );

DeclareOperation( "AddIsZeroForMorphisms",
                  [ IsCapCategory, IsList, IsInt ] );

DeclareOperation( "AddIsZeroForMorphisms",
                  [ IsCapCategory, IsList ] );

DeclareProperty( "IsZero", IsCapCategoryMorphism );

DeclareOperation( "\+", [ IsCapCategoryMorphism, IsCapCategoryMorphism ] );

DeclareAttribute( "AdditiveInverseImmutable", IsCapCategoryMorphism );

DeclareOperation( "\-", [ IsCapCategoryMorphism, IsCapCategoryMorphism ] );

#! @Description
#! The arguments are two morphisms $\alpha, \beta: a \rightarrow b$.
#! The output is the addition $\alpha + \beta$.
#! @Returns a morphism in $\mathrm{Hom}(a,b)$
#! @Arguments alpha, beta
DeclareOperation( "AdditionForMorphisms",
                  [ IsCapCategoryMorphism, IsCapCategoryMorphism ] );

#! @Description
#! The arguments are a category $C$ and a function $F$.
#! This operations adds the given function $F$
#! to the category for the basic operation <C>AdditionForMorphisms</C>.
#! $F: (\alpha, \beta) \mapsto \alpha + \beta$.
#! @Returns nothing
#! @Arguments C, F
DeclareOperation( "AddAdditionForMorphisms",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddAdditionForMorphisms",
                  [ IsCapCategory, IsFunction, IsInt ] );

DeclareOperation( "AddAdditionForMorphisms",
                  [ IsCapCategory, IsList, IsInt ] );

DeclareOperation( "AddAdditionForMorphisms",
                  [ IsCapCategory, IsList ] );

#! @Description
#! The arguments are two morphisms $\alpha, \beta: a \rightarrow b$.
#! The output is the addition $\alpha - \beta$.
#! @Returns a morphism in $\mathrm{Hom}(a,b)$
#! @Arguments alpha, beta
DeclareOperation( "SubtractionForMorphisms",
                  [ IsCapCategoryMorphism, IsCapCategoryMorphism ] );

#! @Description
#! The arguments are a category $C$ and a function $F$.
#! This operations adds the given function $F$
#! to the category for the basic operation <C>SubtractionForMorphisms</C>.
#! $F: (\alpha, \beta) \mapsto \alpha - \beta$.
#! @Returns nothing
#! @Arguments C, F
DeclareOperation( "AddSubtractionForMorphisms",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddSubtractionForMorphisms",
                  [ IsCapCategory, IsFunction, IsInt ] );

DeclareOperation( "AddSubtractionForMorphisms",
                  [ IsCapCategory, IsList, IsInt ] );

DeclareOperation( "AddSubtractionForMorphisms",
                  [ IsCapCategory, IsList ] );

#! @Description
#! The argument is a morphism $\alpha: a \rightarrow b$.
#! The output is its additive inverse $-\alpha$.
#! @Returns a morphism in $\mathrm{Hom}(a,b)$
#! @Arguments alpha
DeclareAttribute( "AdditiveInverseForMorphisms",
                  IsCapCategoryMorphism );

#! @Description
#! The arguments are a category $C$ and a function $F$.
#! This operations adds the given function $F$
#! to the category for the basic operation <C>AdditiveInverseForMorphisms</C>.
#! $F: \alpha \mapsto -\alpha$.
#! @Returns nothing
#! @Arguments C, F
DeclareOperation( "AddAdditiveInverseForMorphisms",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddAdditiveInverseForMorphisms",
                  [ IsCapCategory, IsFunction, IsInt ] );

DeclareOperation( "AddAdditiveInverseForMorphisms",
                  [ IsCapCategory, IsList, IsInt ] );

DeclareOperation( "AddAdditiveInverseForMorphisms",
                  [ IsCapCategory, IsList ] );

#! @Description
#! The arguments are an element $r$ of a commutative ring
#! and a morphism $\alpha: a \rightarrow b$.
#! The output is the multiplication with the ring element $r \cdot \alpha$.
#! @Returns a morphism in $\mathrm{Hom}(a,b)$
#! @Arguments r, alpha
DeclareOperation( "MultiplyWithElementOfCommutativeRingForMorphisms",
                  [ IsRingElement, IsCapCategoryMorphism ] );

DeclareOperation( "\*",
                  [ IsRingElement, IsCapCategoryMorphism ] );

DeclareOperation( "\*",
                  [ IsCapCategoryMorphism, IsRingElement ] );

#! @Description
#! The arguments are a category $C$ and a function $F$.
#! This operations adds the given function $F$
#! to the category for the basic operation <C>MultiplyWithElementOfCommutativeRingForMorphisms</C>.
#! $F: (r, \alpha) \mapsto r \cdot \alpha$.
#! @Returns nothing
#! @Arguments C, F
DeclareOperation( "AddMultiplyWithElementOfCommutativeRingForMorphisms",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddMultiplyWithElementOfCommutativeRingForMorphisms",
                  [ IsCapCategory, IsFunction, IsInt ] );

DeclareOperation( "AddMultiplyWithElementOfCommutativeRingForMorphisms",
                  [ IsCapCategory, IsList, IsInt ] );

DeclareOperation( "AddMultiplyWithElementOfCommutativeRingForMorphisms",
                  [ IsCapCategory, IsList ] );

###################################
##
## Zero Morphism
##
###################################

#! @Description
#! The arguments are two objects $a$ and $b$.
#! The output is the zero morphism $0: a \rightarrow b$.
#! @Returns a morphism in $\mathrm{Hom}(a,b)$
#! @Arguments a, b
DeclareOperation( "ZeroMorphism",
                  [ IsCapCategoryObject, IsCapCategoryObject ] );

#! @Description
#! The arguments are a category $C$ and a function $F$.
#! This operations adds the given function $F$
#! to the category for the basic operation <C>ZeroMorphism</C>.
#! $F: (a,b) \mapsto (0: a \rightarrow b)$.
#! @Returns nothing
#! @Arguments C, F
DeclareOperation( "AddZeroMorphism",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddZeroMorphism",
                  [ IsCapCategory, IsFunction, IsInt ] );

DeclareOperation( "AddZeroMorphism",
                  [ IsCapCategory, IsList, IsInt ] );

DeclareOperation( "AddZeroMorphism",
                  [ IsCapCategory, IsList ] );


###################################
##
#! @Section Subobject and Factorobject Operations
##
###################################

#! Subobjects of an object $c$ are monomorphisms
#! with range $c$ and a special function for comparision.
#! Similarly, factorobjects of an object $c$ are epimorphisms
#! with source $c$ and a special function for comparision.

## TODO
# @Description
# This is a synonym for <C>IsMonomorphism</C>.
DeclareSynonymAttr( "IsSubobject",
                    IsMonomorphism );

## TODO
# @Description
# This is a synonym for <C>IsEpimorphism</C>.
DeclareSynonymAttr( "IsFactorobject",
                    IsEpimorphism );

#! @Description
#! The arguments are two subobjects $\alpha: a \rightarrow c$, $\beta: b \rightarrow c$.
#! The output is <C>true</C> if there exists an isomorphism $\iota: a \rightarrow b$
#! such that $\beta \circ \iota \sim_{a,c} \alpha$,
#! otherwise the output is <C>false</C>.
#! @Returns a boolean
#! @Arguments alpha, beta
DeclareOperation( "IsEqualAsSubobjects",
                  [ IsCapCategoryMorphism, IsCapCategoryMorphism ] );

#! @Description
#! The arguments are a category $C$ and a function $F$.
#! This operations adds the given function $F$
#! to the category for the basic operation <C>IsEqualAsSubobjects</C>.
#! $F: (\alpha, \beta) \mapsto \mathtt{IsEqualAsSubobjects}(\alpha,\beta)$.
#! @Returns nothing
#! @Arguments C, F
DeclareOperation( "AddIsEqualAsSubobjects",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddIsEqualAsSubobjects",
                  [ IsCapCategory, IsFunction, IsInt ] );

DeclareOperation( "AddIsEqualAsSubobjects",
                  [ IsCapCategory, IsList, IsInt ] );

DeclareOperation( "AddIsEqualAsSubobjects",
                  [ IsCapCategory, IsList ] );

#! @Description
#! The arguments are two factorobjects $\alpha: c \rightarrow a$, $\beta: c \rightarrow b$.
#! The output is <C>true</C> if there exists an isomorphism $\iota: b \rightarrow a$
#! such that $\iota \circ \beta \sim_{c,a} \alpha$,
#! otherwise the output is <C>false</C>.
#! @Returns a boolean
#! @Arguments alpha, beta
DeclareOperation( "IsEqualAsFactorobjects",
                  [ IsCapCategoryMorphism, IsCapCategoryMorphism ] );

#! @Description
#! The arguments are a category $C$ and a function $F$.
#! This operations adds the given function $F$
#! to the category for the basic operation <C>IsEqualAsFactorobjects</C>.
#! $F: (\alpha, \beta) \mapsto \mathtt{IsEqualAsFactorobjects}(\alpha,\beta)$.
#! @Returns nothing
#! @Arguments C, F
DeclareOperation( "AddIsEqualAsFactorobjects",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddIsEqualAsFactorobjects",
                  [ IsCapCategory, IsFunction, IsInt ] );

DeclareOperation( "AddIsEqualAsFactorobjects",
                  [ IsCapCategory, IsList, IsInt ] );

DeclareOperation( "AddIsEqualAsFactorobjects",
                  [ IsCapCategory, IsList ] );


#! @Description
#! @BeginLatexOnly
#! \begin{center}
#! \begin{tikzpicture}
#! \def\w{2};
#! \def\h{1};
#! \node (a) at (0,\h) {$a$};
#! \node (b) at (0,-\h) {$b$};
#! \node (c) at (\w,0) {$c$};
#! \draw[right hook-latex] (a) to node[pos=0.45, above] {$\alpha$} (c);
#! \draw[right hook-latex] (b) to node[pos=0.45, below] {$\beta$} (c);
#! \draw[-latex, dashed] (a) to node[pos=0.45, left] {$\exists \iota$} (b);
#! \end{tikzpicture}
#! \end{center}
#! @EndLatexOnly
#! In short: Returns <C>true</C> iff $\alpha$ is smaller than $\beta$.
#! Full description: The arguments are two subobjects $\alpha: a \rightarrow c$, $\beta: b \rightarrow c$.
#! The output is <C>true</C> if there exists a morphism $\iota: a \rightarrow b$
#! such that $\beta \circ \iota \sim_{a,c} \alpha$,
#! otherwise the output is <C>false</C>.
#! @Returns a boolean
#! @Arguments alpha, beta
DeclareOperation( "IsDominating",
                  [ IsCapCategoryMorphism, IsCapCategoryMorphism ] );

#! @Description
#! The arguments are a category $C$ and a function $F$.
#! This operations adds the given function $F$
#! to the category for the basic operation <C>IsDominating</C>.
#! $F: (\alpha, \beta) \mapsto \mathtt{IsDominating}(\alpha,\beta)$.
#! @Returns nothing
#! @Arguments C, F
DeclareOperation( "AddIsDominating",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddIsDominating",
                  [ IsCapCategory, IsFunction, IsInt ] );

DeclareOperation( "AddIsDominating",
                  [ IsCapCategory, IsList, IsInt ] );

DeclareOperation( "AddIsDominating",
                  [ IsCapCategory, IsList ] );


#! @Description
#! @BeginLatexOnly
#! \begin{center}
#! \begin{tikzpicture}
#! \def\w{2};
#! \def\h{1};
#! \node (c) at (0,0) {$c$};
#! \node (a) at (\w,\h) {$a$};
#! \node (b) at (\w,-\h) {$b$};
#! \draw[-twohead] (c) to node[pos=0.45, above] {$\alpha$} (a);
#! \draw[-twohead] (c) to node[pos=0.45, below] {$\beta$} (b);
#! \draw[-latex, dashed] (b) to node[pos=0.45, right] {$\exists \iota$} (a);
#! \end{tikzpicture}
#! \end{center}
#! @EndLatexOnly
#! In short: Returns <C>true</C> iff $\alpha$ is smaller than $\beta$.
#! Full description: 
#! The arguments are two factorobjects $\alpha: c \rightarrow a$, $\beta: c \rightarrow b$.
#! The output is <C>true</C> if there exists a morphism $\iota: b \rightarrow a$
#! such that $\iota \circ \beta \sim_{c,a} \alpha$,
#! otherwise the output is <C>false</C>.
#! @Returns a boolean
#! @Arguments alpha, beta
DeclareOperation( "IsCodominating",
                  [ IsCapCategoryMorphism, IsCapCategoryMorphism ] );

#! @Description
#! The arguments are a category $C$ and a function $F$.
#! This operations adds the given function $F$
#! to the category for the basic operation <C>IsCodominating</C>.
#! $F: (\alpha, \beta) \mapsto \mathtt{IsCodominating}(\alpha,\beta)$.
#! @Returns nothing
#! @Arguments C, F
DeclareOperation( "AddIsCodominating",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddIsCodominating",
                  [ IsCapCategory, IsFunction, IsInt ] );

DeclareOperation( "AddIsCodominating",
                  [ IsCapCategory, IsList, IsInt ] );

DeclareOperation( "AddIsCodominating",
                  [ IsCapCategory, IsList ] );


###################################
##
#! @Section Identity Morphism and Composition of Morphisms
##
###################################

#! @Description
#! The argument is an object $a$.
#! The output is its identity morphism $\mathrm{id}_a$.
#! @Returns a morphism in $\mathrm{Hom}(a,a)$
#! @Arguments a
DeclareAttribute( "IdentityMorphism",
                                          IsCapCategoryObject );

#! @Description
#! The arguments are a category $C$ and a function $F$.
#! This operations adds the given function $F$
#! to the category for the basic operation <C>IdentityMorphism</C>.
#! $F: a \mapsto \mathrm{id}_a$.
#! @Returns nothing
#! @Arguments C, F
DeclareOperation( "AddIdentityMorphism",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddIdentityMorphism",
                  [ IsCapCategory, IsFunction, IsInt ] );

DeclareOperation( "AddIdentityMorphism",
                  [ IsCapCategory, IsList, IsInt ] );

DeclareOperation( "AddIdentityMorphism",
                  [ IsCapCategory, IsList ] );


#! @Description
#! The arguments are two morphisms $\alpha: a \rightarrow b$, $\beta: b \rightarrow c$.
#! The output is the composition $\beta \circ \alpha: a \rightarrow c$.
#! @Returns a morphism in $\mathrm{Hom}( a, c )$
#! @Arguments alpha, beta
DeclareOperation( "PreCompose",
                  [ IsCapCategoryMorphism, IsCapCategoryMorphism ] );

#! @Description
#! This is a convenience method.
#! The argument is a list of morphisms
#! $L = ( \alpha_1: a_1 \rightarrow a_2, \alpha_2: a_2 \rightarrow a_3, \dots, \alpha_n: a_n \rightarrow a_{n+1} )$.
#! The output is the composition 
#! $\alpha_{n} \circ ( \alpha_{n-1} \circ ( \dots ( \alpha_2 \circ \alpha_1 ) ) )$.
#! @Returns a morphism in $\mathrm{Hom}(a_1, a_{n+1})$
#! @Arguments L
DeclareOperation( "PreCompose",
                  [ IsList ] );

#! @Description
#! The arguments are a category $C$ and a function $F$.
#! This operations adds the given function $F$
#! to the category for the basic operation <C>PreCompose</C>.
#! $F: (\alpha, \beta) \mapsto \beta \circ \alpha$.
#! @Returns nothing
#! @Arguments C, F
DeclareOperation( "AddPreCompose",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddPreCompose",
                  [ IsCapCategory, IsFunction, IsInt ] );

DeclareOperation( "AddPreCompose",
                  [ IsCapCategory, IsList, IsInt ] );

DeclareOperation( "AddPreCompose",
                  [ IsCapCategory, IsList ] );


#! @Description
#! The arguments are two morphisms $\beta: b \rightarrow c$, $\alpha: a \rightarrow b$.
#! The output is the composition $\beta \circ \alpha: a \rightarrow c$.
#! @Returns a morphism in $\mathrm{Hom}( a, c )$
#! @Arguments beta, alpha
DeclareOperation( "PostCompose",
                  [ IsCapCategoryMorphism, IsCapCategoryMorphism ] );

#! @Description
#! This is a convenience method.
#! The argument is a list of morphisms
#! $L = ( \alpha_n: a_n \rightarrow a_{n+1}, \alpha_{n-1}: a_{n-1} \rightarrow a_n, \dots, \alpha_1: a_1 \rightarrow a_2 )$.
#! The output is the composition 
#! $((\alpha_{n} \circ  \alpha_{n-1}) \circ \dots  \alpha_2) \circ \alpha_1$.
#! @Returns a morphism in $\mathrm{Hom}(a_1, a_{n+1})$
#! @Arguments L
DeclareOperation( "PostCompose",
                  [ IsList ] );

#! @Description
#! The arguments are a category $C$ and a function $F$.
#! This operations adds the given function $F$
#! to the category for the basic operation <C>PostCompose</C>.
#! $F: (\alpha, \beta) \mapsto \alpha \circ \beta$.
#! @Returns nothing
#! @Arguments C, F
DeclareOperation( "AddPostCompose",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddPostCompose",
                  [ IsCapCategory, IsFunction, IsInt ] );

DeclareOperation( "AddPostCompose",
                  [ IsCapCategory, IsList, IsInt ] );

DeclareOperation( "AddPostCompose",
                  [ IsCapCategory, IsList ] );


###################################
##
#! @Section Well-Definedness of Morphisms
##
###################################

#! @Description
#! The argument is a morphism $\alpha$.
#! The output is <C>true</C> if $\alpha$ is well-defined,
#! otherwise the output is <C>false</C>.
#! @Returns a boolean
#! @Arguments alpha
DeclareOperation( "IsWellDefinedForMorphisms",
                  [ IsCapCategoryMorphism ] );

#! @Description
#! The arguments are a category $C$ and a function $F$.
#! This operations adds the given function $F$
#! to the category for the basic operation <C>IsWellDefinedForMorphisms</C>.
#! $F: \alpha \mapsto \mathtt{IsWellDefinedForMorphisms}( \alpha )$.
#! @Returns nothing
#! @Arguments C, F
DeclareOperation( "AddIsWellDefinedForMorphisms",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddIsWellDefinedForMorphisms",
                  [ IsCapCategory, IsFunction, IsInt ] );

DeclareOperation( "AddIsWellDefinedForMorphisms",
                  [ IsCapCategory, IsList, IsInt ] );

DeclareOperation( "AddIsWellDefinedForMorphisms",
                  [ IsCapCategory, IsList ] );

###################################
##
#! @Section Lift/Colift
##
###################################

#! * For any pair of morphisms $\alpha: a \rightarrow c$, $\beta: b \rightarrow c$,
#!  we call each morphism $\alpha / \beta: a \rightarrow b$ such that
#!  $\beta \circ (\alpha / \beta) \sim_{a,c} \alpha$ a <Emph>lift of $\alpha$ along $\beta$</Emph>.
#! @BeginLatexOnly
#! \begin{center}
#! \begin{tikzpicture}
#! \def\w{2};
#! \def\h{1};
#! \node (a) at (0,\h) {$a$};
#! \node (b) at (0,-\h) {$b$};
#! \node (c) at (\w,0) {$c$};
#! \draw[-latex] (a) to node[pos=0.45, above] {$\alpha$} (c);
#! \draw[-latex] (b) to node[pos=0.45, below] {$\beta$} (c);
#! \draw[-latex, dashed] (a) to node[pos=0.45, left] {$\alpha/\beta$} (b);
#! \end{tikzpicture}
#! \end{center}
#! @EndLatexOnly
#! * For any pair of morphisms $\alpha: a \rightarrow c$, $\beta: a \rightarrow b$,
#!  we call each morphism $\alpha \backslash \beta: c \rightarrow b$ such that
#!  $(\alpha \backslash \beta) \circ \alpha \sim_{a,b} \beta$ a <Emph> colift of $\beta$ along $\alpha$</Emph>.
#! @BeginLatexOnly
#! \begin{center}
#! \begin{tikzpicture}
#! \def\w{2};
#! \def\h{1};
#! \node (a) at (0,0) {$a$};
#! \node (c) at (\w,\h) {$c$};
#! \node (b) at (\w,-\h) {$b$};
#! \draw[-latex] (a) to node[pos=0.45, above] {$\alpha$} (c);
#! \draw[-latex] (a) to node[pos=0.45, below] {$\beta$} (b);
#! \draw[-latex, dashed] (c) to node[pos=0.45, right] {$\alpha \backslash \beta$} (b);
#! \end{tikzpicture}
#! \end{center}
#! @EndLatexOnly

#! Note that such lifts (or colifts) do not have to be unique. So in general,
#! we do not expect that algorithms computing lifts (or colifts) do this in a functorial way.
#! Thus the operations $\mathtt{Lift}$ and $\mathtt{Colift}$ are not regarded as 
#! categorical operations, but only as set-theoretic operations.

#! @Description
#! The arguments are a monomorphism $\iota: k \hookrightarrow a$
#! and a morphism $\tau: t \rightarrow a$
#! such that there is a morphism $u: t \rightarrow k$ with
#! $\iota \circ u \sim_{t,a} \tau$.
#! The output is such a $u$.
#! @Returns a morphism in $\mathrm{Hom}(t,k)$
#! @Arguments iota, tau
DeclareOperation( "LiftAlongMonomorphism",
                  [ IsCapCategoryMorphism, IsCapCategoryMorphism ] );

#! @Description
#! The arguments are a category $C$ and a function $F$.
#! This operations adds the given function $F$
#! to the category for the basic operation <C>LiftAlongMonomorphism</C>.
#! The function $F$ maps a pair $(\iota, \tau)$ to a lift $u$.
#! @Returns nothing
#! @Arguments C, F
DeclareOperation( "AddLiftAlongMonomorphism",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddLiftAlongMonomorphism",
                  [ IsCapCategory, IsFunction, IsInt ] );

DeclareOperation( "AddLiftAlongMonomorphism",
                  [ IsCapCategory, IsList, IsInt ] );

DeclareOperation( "AddLiftAlongMonomorphism",
                  [ IsCapCategory, IsList ] );

#! @Description
#! The arguments are an epimorphism $\epsilon: a \rightarrow c$
#! and a morphism $\tau: a \rightarrow t$
#! such that there is a morphism $u: c \rightarrow t$ with
#! $u \circ \epsilon \sim_{a,t} \tau$.
#! The output is such a $u$.
#! @Returns a morphism in $\mathrm{Hom}(c,t)$
#! @Arguments epsilon, tau
DeclareOperation( "ColiftAlongEpimorphism",
                  [ IsCapCategoryMorphism, IsCapCategoryMorphism ] );

#! @Description
#! The arguments are a category $C$ and a function $F$.
#! This operations adds the given function $F$
#! to the category for the basic operation <C>ColiftAlongEpimorphism</C>.
#! The function $F$ maps a pair $(\epsilon, \tau)$ to a lift $u$.
#! @Returns nothing
#! @Arguments C, F
DeclareOperation( "AddColiftAlongEpimorphism",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddColiftAlongEpimorphism",
                  [ IsCapCategory, IsFunction, IsInt ] );

DeclareOperation( "AddColiftAlongEpimorphism",
                  [ IsCapCategory, IsList, IsInt ] );

DeclareOperation( "AddColiftAlongEpimorphism",
                  [ IsCapCategory, IsList ] );

#! @Description
#! The arguments are a monomorphism $\iota: k \hookrightarrow a$
#! and a morphism $\tau: t \rightarrow a$.
#! The output is <C>true</C> if there exists
#! a morphism $u: t \rightarrow k$ with
#! $\iota \circ u \sim_{t,a} \tau$.
#! Otherwise, the output is  <C>false</C>.
#! @Returns a boolean
#! @Arguments iota, tau
DeclareOperation( "IsLiftableAlongMonomorphism",
                  [ IsCapCategoryMorphism, IsCapCategoryMorphism ] );

#! @Description
#! The arguments are a category $C$ and a function $F$.
#! This operations adds the given function $F$
#! to the category for the basic operation <C>IsLiftableAlongMonomorphism</C>.
#! $F: (\iota, \tau) \mapsto \texttt{IsLiftableAlongMonomorphism}( \iota, \tau )$.
#! @Returns nothing
#! @Arguments C, F
DeclareOperation( "AddIsLiftableAlongMonomorphism",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddIsLiftableAlongMonomorphism",
                  [ IsCapCategory, IsFunction, IsInt ] );

DeclareOperation( "AddIsLiftableAlongMonomorphism",
                  [ IsCapCategory, IsList, IsInt ] );

DeclareOperation( "AddIsLiftableAlongMonomorphism",
                  [ IsCapCategory, IsList ] );

#! @Description
#! The arguments are an epimorphism $\epsilon: a \rightarrow c$
#! and a morphism $\tau: a \rightarrow t$.
#! The output is <C>true</C> if there exists
#! a morphism $u: c \rightarrow t$ with
#! $u \circ \epsilon \sim_{a,t} \tau$.
#! Otherwise, the output is  <C>false</C>.
#! @Returns a boolean
#! @Arguments epsilon, tau
DeclareOperation( "IsColiftableAlongEpimorphism",
                  [ IsCapCategoryMorphism, IsCapCategoryMorphism ] );

#! @Description
#! The arguments are a category $C$ and a function $F$.
#! This operations adds the given function $F$
#! to the category for the basic operation <C>IsColiftableAlongEpimorphism</C>.
#! $F: (\epsilon, \tau) \mapsto \texttt{IsColiftableAlongEpimorphism}( \epsilon, \tau )$.
#! @Returns nothing
#! @Arguments C, F
DeclareOperation( "AddIsColiftableAlongEpimorphism",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddIsColiftableAlongEpimorphism",
                  [ IsCapCategory, IsFunction, IsInt ] );

DeclareOperation( "AddIsColiftableAlongEpimorphism",
                  [ IsCapCategory, IsList, IsInt ] );

DeclareOperation( "AddIsColiftableAlongEpimorphism",
                  [ IsCapCategory, IsList ] );

#! @Description
#! The arguments are two morphisms $\alpha: a \rightarrow c$, $\beta: b \rightarrow c$.
#! The output is a lift $\alpha / \beta: a \rightarrow b$ of $\alpha$ along $\beta$
#! if such a lift exists or $\mathtt{fail}$ if it doesn't.
#! Recall that a lift $\alpha / \beta: a \rightarrow b$ of $\alpha$ along $\beta$ is
#! a morphism such that $\beta \circ (\alpha / \beta) \sim_{a,c} \alpha$.
#! @Returns a morphism in $\mathrm{Hom}(a,b) + \{ \mathtt{fail} \}$
#! @Arguments alpha, beta
DeclareOperation( "Lift",
                  [ IsCapCategoryMorphism, IsCapCategoryMorphism ] );

#! @Description
#! The arguments are a category $C$ and a function $F$.
#! This operations adds the given function $F$
#! to the category for the basic operation <C>Lift</C>.
#! The function $F$ maps a pair $(\alpha, \beta)$ to a lift $\alpha / \beta$ if it
#! exists, and to <C>fail</C> otherwise.
#! @Returns nothing
#! @Arguments C, F
DeclareOperation( "AddLift",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddLift",
                  [ IsCapCategory, IsFunction, IsInt ] );

DeclareOperation( "AddLift",
                  [ IsCapCategory, IsList, IsInt ] );

DeclareOperation( "AddLift",
                  [ IsCapCategory, IsList ] );

##
#! @Description
#! The arguments are two morphisms $\alpha: a \rightarrow c$, $\beta: a \rightarrow b$.
#! The output is a colift $\alpha \backslash \beta: c \rightarrow b$ of $\beta$ along $\alpha$
#! if such a colift exists or $\mathtt{fail}$ if it doesn't.
#! Recall that a colift $\alpha \backslash \beta: c \rightarrow b$ of $\beta$ along $\alpha$ is
#! a morphism such that $(\alpha \backslash \beta) \circ \alpha \sim_{a,b} \beta$.
#! @Returns a morphism in $\mathrm{Hom}(c,b) + \{ \mathtt{fail} \}$
#! @Arguments alpha, beta
DeclareOperation( "Colift",
                  [ IsCapCategoryMorphism, IsCapCategoryMorphism ] );


#! @Description
#! The arguments are a category $C$ and a function $F$.
#! This operations adds the given function $F$
#! to the category for the basic operation <C>Colift</C>.
#! The function $F$ maps a pair $(\alpha, \beta)$ to a colift $\alpha \backslash \beta$ if it
#! exists, and to <C>fail</C> otherwise.
#! @Returns nothing
#! @Arguments C, F
DeclareOperation( "AddColift",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddColift",
                  [ IsCapCategory, IsFunction, IsInt ] );

DeclareOperation( "AddColift",
                  [ IsCapCategory, IsList, IsInt ] );

DeclareOperation( "AddColift",
                  [ IsCapCategory, IsList ] );

#! @Description
#! The arguments are two morphisms $\alpha: a \rightarrow c$, $\beta: b \rightarrow c$.
#! The output is <C>true</C> if there exists
#!  a lift $\alpha / \beta: a \rightarrow b$ of $\alpha$ along $\beta$, i.e.,
#! a morphism such that $\beta \circ (\alpha / \beta) \sim_{a,c} \alpha$.
#! Otherwise, the output is <C>false</C>.
#! @Returns a boolean
#! @Arguments alpha, beta
DeclareOperation( "IsLiftable",
                  [ IsCapCategoryMorphism, IsCapCategoryMorphism ] );

#! @Description
#! The arguments are a category $C$ and a function $F$.
#! This operations adds the given function $F$
#! to the category for the basic operation <C>IsLiftable</C>.
#! $F: ( \alpha, \beta ) \mapsto \mathtt{IsLiftable}( \alpha, \beta )$.
#! @Returns nothing
#! @Arguments C, F
DeclareOperation( "AddIsLiftable",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddIsLiftable",
                  [ IsCapCategory, IsFunction, IsInt ] );

DeclareOperation( "AddIsLiftable",
                  [ IsCapCategory, IsList, IsInt ] );

DeclareOperation( "AddIsLiftable",
                  [ IsCapCategory, IsList ] );


##
#! @Description
#! The arguments are two morphisms $\alpha: a \rightarrow c$, $\beta: a \rightarrow b$.
#! The output is <C>true</C> if there exists
#! a colift $\alpha \backslash \beta: c \rightarrow b$ of $\beta$ along $\alpha$., i.e.,
#! a morphism such that $(\alpha \backslash \beta) \circ \alpha \sim_{a,b} \beta$.
#! Otherwise, the output is <C>false</C>.
#! @Returns a boolean
#! @Arguments alpha, beta
DeclareOperation( "IsColiftable",
                  [ IsCapCategoryMorphism, IsCapCategoryMorphism ] );

#! @Description
#! The arguments are a category $C$ and a function $F$.
#! This operations adds the given function $F$
#! to the category for the basic operation <C>IsColiftable</C>.
#! $F: ( \alpha, \beta ) \mapsto \mathtt{IsColiftable}( \alpha, \beta )$.
#! @Returns nothing
#! @Arguments C, F
DeclareOperation( "AddIsColiftable",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddIsColiftable",
                  [ IsCapCategory, IsFunction, IsInt ] );

DeclareOperation( "AddIsColiftable",
                  [ IsCapCategory, IsList, IsInt ] );

DeclareOperation( "AddIsColiftable",
                  [ IsCapCategory, IsList ] );

####################################
##
#! @Section Inverses
##
####################################

#! Let $\alpha: a \rightarrow b$ be a morphism. An inverse of $\alpha$
#! is a morphism $\alpha^{-1}: b \rightarrow a$ such that
#! $\alpha \circ \alpha^{-1} \sim_{b,b} \mathrm{id}_b$
#! and $\alpha^{-1} \circ \alpha \sim_{a,a} \mathrm{id}_a$.

#! @BeginLatexOnly
#! \begin{center}
#! \begin{tikzpicture}
#! \def\w{2};
#! \def\h{1};
#! \node (a) at (0,0) {$a$};
#! \node (b) at (\w,0) {$b$};
#! \draw[-latex] (a) to node[pos=0.45, above] {$\alpha$} (b);
#! \draw[-latex] (b) to [out = -135, in = -45] node[pos=0.45, below] {$\alpha^{-1}$} (a);
#! \draw [-latex] (a.135) arc (45:45+280:4mm) node[pos=0.5,left] {$\mathrm{id}_a$} (a);
#! \draw [-latex] (b.45) arc (-240:-240-280:4mm) node[pos=0.5,right] {$\mathrm{id}_b$} (b);
#! \end{tikzpicture}
#! \end{center}
#! @EndLatexOnly

#! @Description
#! The arguments are a category $C$ and a function $F$.
#! This operations adds the given function $F$
#! to the category for the basic operation <C>Inverse</C>.
#! $F: \alpha \mapsto \alpha^{-1}$.
#! @Returns nothing
#! @Arguments C, F
DeclareOperation( "AddInverse",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddInverse",
                  [ IsCapCategory, IsFunction, IsInt ] );

DeclareOperation( "AddInverse",
                  [ IsCapCategory, IsList, IsInt ] );

DeclareOperation( "AddInverse",
                  [ IsCapCategory, IsList ] );

## these are the Add functions which are actually called.
DeclareOperation( "AddInverseImmutable",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddInverseImmutable",
                  [ IsCapCategory, IsFunction, IsInt ] );

DeclareOperation( "AddInverseImmutable",
                  [ IsCapCategory, IsList, IsInt ] );

DeclareOperation( "AddInverseImmutable",
                  [ IsCapCategory, IsList ] );

###################################
##
#! @Section Tool functions for caches
##
###################################

#! @Description
#!  Compares two objects in the cache
#! @Arguments phi, psi
#! @Returns true or false
DeclareOperation( "IsEqualForCacheForMorphisms",
                  [ IsCapCategoryMorphism, IsCapCategoryMorphism ] );

#! @Description
#!  By default, CAP uses caches to store the values of Categorical operations.
#!  To get a value out of the cache, one needs to compare the input of a basic operation
#!  with its previous input. To compare morphisms in the category, IsEqualForCacheForMorphism is
#!  used. By default this is an alias for IsEqualForMorphismsOnMor, where fail is substituted by false.
#!  If you add a function, this function
#!  used instead. A function $F: a,b \mapsto bool$ is expected here. The output has to be
#!  true or false. Fail is not allowed in this context.
#! @Returns northing
#! @Arguments c,F
DeclareOperation( "AddIsEqualForCacheForMorphisms",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddIsEqualForCacheForMorphisms",
                  [ IsCapCategory, IsFunction, IsInt ] );

DeclareOperation( "AddIsEqualForCacheForMorphisms",
                  [ IsCapCategory, IsList, IsInt ] );

DeclareOperation( "AddIsEqualForCacheForMorphisms",
                  [ IsCapCategory, IsList ] );

###################################
##
#! @Section Transport Operations
##
###################################

## mor: x -> y
## equality_source: x -> x'
## equality_range: y -> y'
## TransportHom( mor, equality_source, equality_range ): x' -> y'
DeclareOperation( "TransportHom",
                  [ IsCapCategoryMorphism, IsCapCategoryMorphism, IsCapCategoryMorphism ] );

###################################
##
#! @Section Homomorphism structures
##
###################################

#! Homomorphism structures are way to "oversee" the homomorphisms between two given objects.
#! Let $C$, $D$ be categories.
#! A $D$-homomorphism structure for $C$ consists of the following data:
#! * a functor $H: C^{\mathrm{op}} \times C \rightarrow D$ (when $C$ and $D$ are Ab-categories, $H$ is assumed to be bilinear).
#! * an object $1 \in D$, called the distinguished object,
#! * a bijection $\nu: \mathrm{Hom}_{C}(a,b) \simeq \mathrm{Hom}_{D}(1, H(a,b))$ natural in $a,b \in C$.

#! @Description
#! The arguments are two objects $a, b$ in $C$.
#! The output is the value of the homomorphism structure on objects $H(a,b)$.
#! @Returns an object in $D$
#! @Arguments a,b
DeclareOperation( "HomomorphismStructureOnObjects",
                  [ IsCapCategoryObject, IsCapCategoryObject ] );

#! @Description
#! The arguments are a category $C$ and a function $F$.
#! This operations adds the given function $F$ 
#! to the category for the basic operation <C>HomomorphismStructureOnObjects</C>.
#! $F: (a,b) \mapsto H(a,b)$.
#! @Returns nothing
#! @Arguments C, F
DeclareOperation( "AddHomomorphismStructureOnObjects",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddHomomorphismStructureOnObjects",
                  [ IsCapCategory, IsFunction, IsInt ] );

DeclareOperation( "AddHomomorphismStructureOnObjects",
                  [ IsCapCategory, IsList, IsInt ] );

DeclareOperation( "AddHomomorphismStructureOnObjects",
                  [ IsCapCategory, IsList ] );

#! @Description
#! The arguments are two morphisms $\alpha: a \rightarrow a', \beta: b \rightarrow b'$ in $C$.
#! The output is the value of the homomorphism structure on morphisms $H(\alpha, \beta )$.
#! @Returns a morphism in $\mathrm{Hom}_{D}(H(a',b), H(a,b'))$
#! @Arguments alpha, beta
DeclareOperation( "HomomorphismStructureOnMorphisms",
                  [ IsCapCategoryMorphism, IsCapCategoryMorphism ] );

#! @Description
#! The arguments are an object $s = H(a',b)$ in $D$,
#! two morphisms $\alpha: a \rightarrow a', \beta: b \rightarrow b'$ in $C$,
#! and an object $r = H(a,b')$ in $D$.
#! The output is the value of the homomorphism structure on morphisms $H(\alpha, \beta )$.
#! @Returns a morphism in $\mathrm{Hom}_{D}(H(a',b), H(a,b'))$
#! @Arguments s, alpha, beta, r
DeclareOperation( "HomomorphismStructureOnMorphismsWithGivenObjects",
                  [ IsCapCategoryObject, IsCapCategoryMorphism, IsCapCategoryMorphism, IsCapCategoryObject ] );

#! @Description
#! The arguments are a category $C$ and a function $F$.
#! This operations adds the given function $F$ 
#! to the category for the basic operation <C>HomomorphismStructureOnMorphismsWithGivenObjects</C>.
#! $F: ( s, \alpha: a \rightarrow a', \beta: b \rightarrow b', r ) \mapsto H( \alpha, \beta )$.
#! @Returns nothing
#! @Arguments C, F
DeclareOperation( "AddHomomorphismStructureOnMorphismsWithGivenObjects",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddHomomorphismStructureOnMorphismsWithGivenObjects",
                  [ IsCapCategory, IsFunction, IsInt ] );

DeclareOperation( "AddHomomorphismStructureOnMorphismsWithGivenObjects",
                  [ IsCapCategory, IsList, IsInt ] );

DeclareOperation( "AddHomomorphismStructureOnMorphismsWithGivenObjects",
                  [ IsCapCategory, IsList ] );

#! @Description
#! The argument is a category $C$.
#! The output is the distinguished object $1$ in $D$ of the homomorphism structure.
#! @Returns an object in $D$
#! @Arguments C
DeclareAttribute( "DistinguishedObjectOfHomomorphismStructure",
                  IsCapCategory );

#! @Description
#! The arguments are a category $C$ and a function $F$.
#! This operations adds the given function $F$ 
#! to the category for the basic operation <C>DistinguishedObjectOfHomomorphismStructure</C>.
#! $F: ( ) \mapsto 1$.
#! @Returns nothing
#! @Arguments C, F
DeclareOperation( "AddDistinguishedObjectOfHomomorphismStructure",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddDistinguishedObjectOfHomomorphismStructure",
                  [ IsCapCategory, IsFunction, IsInt ] );

DeclareOperation( "AddDistinguishedObjectOfHomomorphismStructure",
                  [ IsCapCategory, IsList, IsInt ] );

DeclareOperation( "AddDistinguishedObjectOfHomomorphismStructure",
                  [ IsCapCategory, IsList ] );

#! @Description
#! The argument is a morphism  $\alpha: a \rightarrow a'$ in $C$.
#! The output is the corresponding morphism
#! $\nu( \alpha ): 1 \rightarrow H(a,a')$ in $D$ of the homomorphism structure.
#! @Returns a morphism in $\mathrm{Hom}_{D}(1, H(a,a'))$
#! @Arguments alpha
DeclareAttribute( "InterpretMorphismAsMorphismFromDinstinguishedObjectToHomomorphismStructure",
                  IsCapCategoryMorphism );

#! @Description
#! The arguments are a category $C$ and a function $F$.
#! This operations adds the given function $F$ 
#! to the category for the basic operation <C>InterpretMorphismAsMorphismFromDinstinguishedObjectToHomomorphismStructure</C>.
#! $F: (\alpha: a \rightarrow a') \mapsto (\nu(\alpha):1 \rightarrow H(a,a'))$.
#! @Returns nothing
#! @Arguments C, F
DeclareOperation( "AddInterpretMorphismAsMorphismFromDinstinguishedObjectToHomomorphismStructure",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddInterpretMorphismAsMorphismFromDinstinguishedObjectToHomomorphismStructure",
                  [ IsCapCategory, IsFunction, IsInt ] );

DeclareOperation( "AddInterpretMorphismAsMorphismFromDinstinguishedObjectToHomomorphismStructure",
                  [ IsCapCategory, IsList, IsInt ] );

DeclareOperation( "AddInterpretMorphismAsMorphismFromDinstinguishedObjectToHomomorphismStructure",
                  [ IsCapCategory, IsList ] );

#! @Description
#! The arguments are
#! objects $a,a'$ in $C$
#! and a morphism $\iota: 1 \rightarrow H(a,a')$ in $D$.
#! The output is the corresponding morphism
#! $\nu^{-1}(\iota): a \rightarrow a'$ in $C$ of the homomorphism structure.
#! @Returns a morphism in $\mathrm{Hom}_{C}(a,a')$
#! @Arguments a,a',iota
DeclareOperation( "InterpretMorphismFromDinstinguishedObjectToHomomorphismStructureAsMorphism",
                   [ IsCapCategoryObject, IsCapCategoryObject, IsCapCategoryMorphism ] );

#! @Description
#! The arguments are a category $C$ and a function $F$.
#! This operations adds the given function $F$ 
#! to the category for the basic operation <C>InterpretMorphismFromDinstinguishedObjectToHomomorphismStructureAsMorphism</C>.
#! $F: (a,a',\iota: 1 \rightarrow H(a,a')) \mapsto (\nu^{-1}(\iota): a \rightarrow a')$.
#! @Returns nothing
#! @Arguments C, F
DeclareOperation( "AddInterpretMorphismFromDinstinguishedObjectToHomomorphismStructureAsMorphism",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddInterpretMorphismFromDinstinguishedObjectToHomomorphismStructureAsMorphism",
                  [ IsCapCategory, IsFunction, IsInt ] );

DeclareOperation( "AddInterpretMorphismFromDinstinguishedObjectToHomomorphismStructureAsMorphism",
                  [ IsCapCategory, IsList, IsInt ] );

DeclareOperation( "AddInterpretMorphismFromDinstinguishedObjectToHomomorphismStructureAsMorphism",
                  [ IsCapCategory, IsList ] );

##
DeclareOperation( "SolveLinearSystemInAbCategoryOp",
                   [ IsList, IsList, IsList, IsCapCategory ] );

#! @Description
#! The arguments are three lists $\alpha$, $\beta$, and $\gamma$.
#! The first list $\alpha$ (the left coefficients) is a list of list of morphisms $\alpha_{ij}: A_i \rightarrow B_j$,
#! where $i = 1 \dots m$ and $j = 1 \dots n$ for integers $m,n \geq 1$.
#! The second list $\beta$ (the right coefficients) is a list of list of morphisms $\beta_{ij}: C_j \rightarrow D_i$,
#! where $i = 1 \dots m$ and $j = 1 \dots n$.
#! The third list $\gamma$ (the right side) is a list of morphisms $\gamma_i: A_i \rightarrow D_i$,
#! where $i = 1, \dots, m$.
#! The output is either
#! a list of morphisms $X_j: B_j \rightarrow C_j$ for $j=1\dots n$ solving the linear system
#! defined by $\alpha$, $\beta$, $\gamma$, i.e.,
#! $\sum_{j = 1}^n \alpha_{ij}\cdot X_j \cdot \beta_{ij} = \gamma_i$
#! for all $i = 1 \dots m$,
#! or $\texttt{fail}$ if no such solution exists.
#! @Returns a list of morphisms $[X_1, \dots, X_n]$
#! @Arguments alpha, beta, gamma
DeclareOperation( "SolveLinearSystemInAbCategory",
                   [ IsList, IsList, IsList ] );

DeclareOperation( "AddSolveLinearSystemInAbCategory",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddSolveLinearSystemInAbCategory",
                  [ IsCapCategory, IsFunction, IsInt ] );

DeclareOperation( "AddSolveLinearSystemInAbCategory",
                  [ IsCapCategory, IsList, IsInt ] );

DeclareOperation( "AddSolveLinearSystemInAbCategory",
                  [ IsCapCategory, IsList ] );
