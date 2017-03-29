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
##
###################################

DeclareOperation( "Add",
                  [ IsCapCategory, IsCapCategoryMorphism ] );

DeclareOperation( "AddMorphism",
                  [ IsCapCategory, IsObject ] );

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
DeclareOperation( "IsZeroForMorphisms",
                  [ IsCapCategoryMorphism ] );

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
#! The argument is a morphism $\alpha: a \rightarrow b$.
#! The output is its additive inverse $-\alpha$.
#! @Returns a morphism in $\mathrm{Hom}(a,b)$
#! @Arguments alpha
DeclareOperation( "AdditiveInverseForMorphisms",
                  [ IsCapCategoryMorphism ] );

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
#! In short: Returns <C>true</C> iff $\alpha$ is smaller than $\beta$.
#! $\\ $
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
#! In short: Returns <C>true</C> iff $\alpha$ is smaller than $\beta$.
#! $\\ $
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
#! @Section Basic Operations for Morphisms in Abelian Categories
##
###################################


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
#! The function $F$ maps a pair $(\iota, \tau)$ to a lift $u$ if it
#! exists, and to <C>fail</C> otherwise.
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
#! The function $F$ maps a pair $(\epsilon, \tau)$ to a lift $u$ if it
#! exists, and to <C>fail</C> otherwise.
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

###################################
##
#! @Section Lift/ Colift
##
###################################

#! * For any pair of morphisms $\alpha: a \rightarrow c$, $\beta: b \rightarrow c$,
#!  we call each morphism $\alpha / \beta: a \rightarrow b$ such that
#!  $\beta \circ (\alpha / \beta) \sim_{a,c} \alpha$ a <Emph>lift of $\alpha$ along $\beta$</Emph>.
#! * For any pair of morphisms $\alpha: a \rightarrow c$, $\beta: a \rightarrow b$,
#!  we call each morphism $\alpha \backslash \beta: c \rightarrow b$ such that
#!  $(\alpha \backslash \beta) \circ \alpha \sim_{a,b} \beta$ a <Emph> colift of $\beta$ along $\alpha$</Emph>.
#! Note that such lifts (or colifts) do not have to be unique. So in general,
#! we do not expect that algorithms computing lifts (or colifts) do this in a functorial way.
#! Thus the operations $\mathtt{Lift}$ and $\mathtt{Colift}$ are not regarded as 
#! categorical operations, but only as set-theoretic operations.

#! @Description
#! The arguments are two morphisms $\alpha: a \rightarrow c$, $\beta: b \rightarrow c$
#! such that there is a lift $\alpha / \beta: a \rightarrow b$ of $\alpha$ along $\beta$, i.e.,
#! a morphism such that $\beta \circ (\alpha / \beta) \sim_{a,c} \alpha$.
#! The output is such a lift or $\mathtt{fail}$ if it doesn't exist.
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
#! The arguments are two morphisms $\alpha: a \rightarrow c$, $\beta: a \rightarrow b$
#! such that there is a colift $\alpha \backslash \beta: c \rightarrow b$ of $\beta$ along $\alpha$., i.e.,
#! a morphism such that $(\alpha \backslash \beta) \circ \alpha \sim_{a,b} \beta$.
#! The output is such a colift or $\mathtt{fail}$ if it doesn't exist.
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


####################################
##
#! @Section Inverses
##
####################################

#! Let $\alpha: a \rightarrow b$ be a morphism. An inverse of $\alpha$
#! is a morphism $\alpha^{-1}: b \rightarrow a$ such that
#! $\alpha \circ \alpha^{-1} \sim_{b,b} \mathrm{id}_b$
#! and $\alpha^{-1} \circ \alpha \sim_{a,a} \mathrm{id}_a$.

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

