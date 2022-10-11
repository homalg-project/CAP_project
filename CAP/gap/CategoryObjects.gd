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

###################################
##
#! @Section Equality for Objects
##
###################################

#! @Description
#! The arguments are two objects $a$ and $b$.
#! The output is <C>true</C> if $a = b$,
#! otherwise the output is <C>false</C>.
#! @Returns a boolean
#! @Arguments a,b
DeclareOperation( "IsEqualForObjects",
                  [ IsCapCategoryObject, IsCapCategoryObject ] );

## adds the given string to PROPAGATION_LIST_FOR_EQUAL_OBJECTS
DeclareOperation( "AddPropertyToMatchAtIsEqualForObjects",
                  [ IsCapCategory, IsString ] );

###################################
##
#! @Section Categorical Properties of Objects
##
###################################

#! @Description
#! The argument is an object $a$.
#! The output is <C>true</C> if $a$ is a bijective object,
#! otherwise the output is <C>false</C>.
#! @Returns a boolean
#! @Arguments a
DeclareProperty( "IsBijectiveObject",
                 IsCapCategoryObject );

#! @Description
#! The argument is an object $a$.
#! The output is <C>true</C> if $a$ is a projective object,
#! otherwise the output is <C>false</C>.
#! @Returns a boolean
#! @Arguments a
DeclareProperty( "IsProjective",
                 IsCapCategoryObject );

#! @Description
#! The argument is an object $a$.
#! The output is <C>true</C> if $a$ is an injective object,
#! otherwise the output is <C>false</C>.
#! @Returns a boolean
#! @Arguments a
DeclareProperty( "IsInjective",
                 IsCapCategoryObject );

#! @Description
#! The argument is an object $a$ of a category $\mathbf{C}$.
#! The output is <C>true</C> if $a$ is isomorphic to the terminal object of $\mathbf{C}$, 
#! otherwise the output is <C>false</C>.
#! @Returns a boolean
#! @Arguments a
DeclareProperty( "IsTerminal",
                 IsCapCategoryObject );

#! @Description
#! The argument is an object $a$ of a category $\mathbf{C}$.
#! The output is <C>true</C> if $a$ is isomorphic to the initial object of $\mathbf{C}$, 
#! otherwise the output is <C>false</C>.
#! @Returns a boolean
#! @Arguments a
DeclareProperty( "IsInitial",
                 IsCapCategoryObject );

#! @Description
#! The argument is an object $a$ of a category $\mathbf{C}$.
#! The output is <C>true</C> if $a$ is isomorphic to the zero object of $\mathbf{C}$, 
#! otherwise the output is <C>false</C>.
#! @Returns a boolean
#! @Arguments a
DeclareProperty( "IsZeroForObjects",
                 IsCapCategoryObject );

#! @Description
#! The argument is an object $a$ of a category $\mathbf{C}$.
#! The output is <C>true</C> if $a$ is isomorphic to the zero object of $\mathbf{C}$, 
#! otherwise the output is <C>false</C>.
#! @Returns a boolean
#! @Arguments a
DeclareProperty( "IsZero",
                 IsCapCategoryObject );

###################################
##
#! @Section Random Objects
##
###################################

#! CAP provides two principal methods to generate random objects:
#!  * <E>By integers</E>: The integer is simply a parameter that can be used to create a random object.
#!  * <E>By lists</E>: The list is used when creating a random object would need more than one parameter. Lists offer more
#!    flexibility at the expense of the genericity of the methods. This happens because lists that are valid as input in
#!    some category may be not valid for other categories. Hence, these operations are not thought to be used in
#!    generic categorical algorithms.


#! @Description
#! The arguments are a category $C$ and an integer $n$.
#! The output is a random object in $C$.
#! @Returns an object in $C$
#! @Arguments C, n
DeclareOperation( "RandomObjectByInteger",
                  [ IsCapCategory, IsInt ] );

#! @Description
#! The arguments are a category $C$ and a list $L$.
#! The output is a random object in $C$.
#! @Returns an object in $C$
#! @Arguments C, L
DeclareOperation( "RandomObjectByList",
                  [ IsCapCategory, IsList ] );

#! @Description
#! These are convenient methods and they, depending on the input, delegate to one of the above methods.
#! @Arguments C, n
DeclareOperation( "RandomObject", [ IsCapCategory, IsInt ] );
#! @Arguments C, L
DeclareOperation( "RandomObject", [ IsCapCategory, IsList ] );
#! @EndGroup

###################################
##
#! @Section Tool functions for caches
##
###################################

#! @Description
#!  By default, CAP uses caches to store the values of Categorical operations.
#!  To get a value out of the cache, one needs to compare the input of a basic operation
#!  with its previous input. To compare objects in the category, IsEqualForCacheForObjects is
#!  used. By default, IsEqualForCacheForObjects falls back to IsEqualForCache (see ToolsForHomalg),
#!  which in turn defaults to recursive comparison for lists and `IsIdenticalObj` in all other cases.
#!  If you add a function via `AddIsEqualForCacheForObjects`, that function is used instead.
#!  A function $F: a,b \mapsto bool$ is expected there. The output has to be
#!  true or false. Fail is not allowed in this context.
#! @Arguments phi, psi
#! @Returns true or false
DeclareOperation( "IsEqualForCacheForObjects",
                  [ IsCapCategoryObject, IsCapCategoryObject ] );

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

#! @Arguments category, filter
#! @Description
#!  The argument <A>filter</A> is used to create an object type for the
#!  category <A>category</A>, which is then used in <C>ObjectifyObjectForCAPWithAttributes</C>
#!  to objectify objects for this category. <A>filter</A> must imply `IsCapCategoryObject`.
DeclareOperation( "AddObjectRepresentation",
                  [ IsCapCategory, IsObject ] );

#! @Arguments object, category[, attribute1, value1, ...]
#! @Description
#!  Objectifies the object <A>object</A> with the type created
#!  for objects in the category <A>category</A>. The type
#!  is created by passing a representation to <C>AddObjectRepresentation</C>.
#!  Objects which are objectified using this method do not have to be passed
#!  to the <C>AddObject</C> function.
#!  The optional arguments behave like the corresponding arguments in <C>ObjectifyWithAttributes</C>.
#!  Also returns the objectified object.
#! @Returns an object
DeclareGlobalFunction( "ObjectifyObjectForCAPWithAttributes" );

#! @Arguments category, [attribute1, value1, ...]
#! @Description
#!  Shorthand for `ObjectifyObjectForCAPWithAttributes( rec( ), category[, attribute1, value1, ...] )`.
#! @Returns an object
DeclareGlobalFunction( "CreateCapCategoryObjectWithAttributes" );

###################################
##
#! @Section Object constructors
##
###################################

#! @Description
#! The arguments are a category $C$ and an object datum $a$
#! (type and semantics of the object datum depend on the category).
#! The output is an object of $C$ defined by $a$.
#! Note that by default this CAP operation is not cached. You can change this behaviour
#! by calling `SetCachingToWeak( C, "ObjectConstructor" )` resp. `SetCachingToCrisp( C, "ObjectConstructor" )`.
#! @Returns an object
#! @Arguments C, a
DeclareOperation( "ObjectConstructor",
                  [ IsCapCategory, IsObject ] );

#! @Description
#!   Shorthand for `ObjectConstructor( C, a )`.
#! @Returns an object
#! @Arguments a, C
DeclareOperation( "\/",
                  [ IsObject, IsCapCategory ] );

#! @Description
#! The argument is a CAP category object <A>obj</A>.
#! The output is a datum which can be used to construct <A>obj</A>, that is,
#! `IsEqualForObjects( `<A>obj</A>`, ObjectConstructor( CapCategory( `<A>obj</A>` ), ObjectDatum( `<A>obj</A>` ) ) )`.
#! Note that by default this CAP operation is not cached. You can change this behaviour
#! by calling `SetCachingToWeak( C, "ObjectDatum" )` resp. `SetCachingToCrisp( C, "ObjectDatum" )`.
#! @Returns depends on the category
#! @Arguments obj
DeclareAttribute( "ObjectDatum",
                  IsCapCategoryObject );

###################################
##
#! @Section Well-Definedness of Objects
##
###################################

#! @Description
#! The argument is an object $a$.
#! The output is <C>true</C> if $a$ is well-defined,
#! otherwise the output is <C>false</C>.
#! @Returns a boolean
#! @Arguments a
DeclareOperation( "IsWellDefinedForObjects",
                  [ IsCapCategoryObject ] );


###################################
##
#! @Section Projectives
##
###################################

#! For a given object $A$ in an abelian category having enough projectives,
#! the following commands allow us to compute some projective object $P$
#! together with an epimorphism $\pi: P \rightarrow A$.

## Main Operations and Attributes
#! @Description
#! The argument is an object $A$.
#! The output is some projective object $P$
#! for which there exists an epimorphism $\pi: P \rightarrow A$.
#! @Returns an object
#! @Arguments A
DeclareAttribute( "SomeProjectiveObject",
                  IsCapCategoryObject );

#! @Description
#! The argument is an object $A$.
#! The output is an epimorphism $\pi: P \rightarrow A$
#! with $P$ a projective object that equals the output of $\mathrm{SomeProjectiveObject}(A)$.
#! @Returns a morphism in $\mathrm{Hom}(P,A)$
#! @Arguments A
DeclareAttribute( "EpimorphismFromSomeProjectiveObject",
                  IsCapCategoryObject );

#! @Description
#! The arguments are an object $A$
#! and a projective object $P$ that equals the output of $\mathrm{SomeProjectiveObject}(A)$.
#! The output is an epimorphism $\pi: P \rightarrow A$.
#! @Returns a morphism in $\mathrm{Hom}(P,A)$
#! @Arguments A, P
DeclareOperation( "EpimorphismFromSomeProjectiveObjectWithGivenSomeProjectiveObject",
                  [ IsCapCategoryObject, IsCapCategoryObject ] );

#! @Description
#! The arguments are a morphism $\pi: P \rightarrow A$ with $P$ a projective, 
#! and an epimorphism $\epsilon: B \rightarrow A$.
#! The output is a morphism $\lambda: P \rightarrow B$ such that
#! $\epsilon \circ \lambda = \pi$.
#! @Returns a morphism in $\mathrm{Hom}(P,B)$
#! @Arguments pi, epsilon
DeclareOperation( "ProjectiveLift",
                  [ IsCapCategoryMorphism, IsCapCategoryMorphism ] );

###################################
##
#! @Section Injectives
##
###################################

#! For a given object $A$ in an abelian category having enough injectives,
#! the following commands allow us to compute some injective object $I$
#! together with a monomorphism $\iota: A \rightarrow I$.

## Main Operations and Attributes
#! @Description
#! The argument is an object $A$.
#! The output is some injective object $I$
#! for which there exists a monomorphism $\iota: A \rightarrow I$.
#! @Returns an object
#! @Arguments A
DeclareAttribute( "SomeInjectiveObject",
                  IsCapCategoryObject );

#! @Description
#! The argument is an object $A$.
#! The output is a monomorphism $\iota: A \rightarrow I$
#! with $I$ an injective object that equals the output of $\mathrm{SomeInjectiveObject}(A)$.
#! @Returns a morphism in $\mathrm{Hom}(I,A)$
#! @Arguments A
DeclareAttribute( "MonomorphismIntoSomeInjectiveObject",
                  IsCapCategoryObject );

#! @Description
#! The arguments are an object $A$
#! and an injective object $I$ that equals the output of $\mathrm{SomeInjectiveObject}(A)$.
#! The output is a monomorphism $\iota: A \rightarrow I$.
#! @Returns a morphism in $\mathrm{Hom}(I,A)$
#! @Arguments A, I
DeclareOperation( "MonomorphismIntoSomeInjectiveObjectWithGivenSomeInjectiveObject",
                  [ IsCapCategoryObject, IsCapCategoryObject ] );

##
#! @Description
#! The arguments are a monomorphism $\iota: B \rightarrow A$
#! and a morphism $\beta: B \rightarrow I$ where $I$ is an injective object.
#! The output is a morphism $\lambda: A \rightarrow I$ such that
#! $\lambda \circ \iota = \beta$.
#! @Returns a morphism in $\mathrm{Hom}(A,I)$
#! @Arguments iota, beta
DeclareOperation( "InjectiveColift",
                  [ IsCapCategoryMorphism, IsCapCategoryMorphism ] );

###################################
##
#! @Section Simplified Objects
##
###################################

#! Let $i$ be a positive integer or $\infty$.
#! For a given object $A$, an $i$-th simplified object of $A$ consists of
#! * an object $A_i$, 
#! * an isomorphism $\iota_A^i: A \rightarrow A_i$.
#! The idea is that the greater the $i$, the "simpler" the $A_i$ (but this could mean the harder the computation)
#! with $\infty$ as a possible value.

#! @Description
#! The argument is an object $A$.
#! The output is a simplified object $A_{\infty}$.
#! @Returns an object
#! @Arguments A
DeclareAttribute( "Simplify",
                  IsCapCategoryObject );

#! @Description
#! The arguments are an object $A$ and a positive integer $i$ or <C>infinity</C>.
#! The output is a simplified object $A_i$.
#! @Returns an object
#! @Arguments A, i
DeclareOperation( "SimplifyObject",
                  [ IsCapCategoryObject, IsObject ] );

#! @Description
#! The arguments are an object $A$ and a positive integer $i$ or <C>infinity</C>.
#! The output is an isomorphism to a simplified object $\iota_A^i: A \rightarrow A_i$.
#! @Returns a morphism in $\mathrm{Hom}(A,A_i)$
#! @Arguments A, i
DeclareOperation( "SimplifyObject_IsoFromInputObject",
                  [ IsCapCategoryObject, IsObject ] );

#! @Description
#! The arguments are an object $A$ and a positive integer $i$ or <C>infinity</C>.
#! The output is an isomorphism from a simplified object $(\iota_A^i)^{-1}: A_i \rightarrow A$
#! which is the inverse of the output of <C>SimplifyObject_IsoFromInputObject</C>.
#! @Returns a morphism in $\mathrm{Hom}(A_i,A)$
#! @Arguments A, i
DeclareOperation( "SimplifyObject_IsoToInputObject",
                  [ IsCapCategoryObject, IsObject ] );

###################################
##
#! @Section Dimensions
##
###################################

#! @Description
#! The argument is an object $A$.
#! The output is a the projective dimension of $A$.
#! @Returns a nonnegative integer or infinity
#! @Arguments A
DeclareAttribute( "ProjectiveDimension",
                  IsCapCategoryObject );

#! @Description
#! The argument is an object $A$.
#! The output is a the injective dimension of $A$.
#! @Returns a nonnegative integer or infinity
#! @Arguments A
DeclareAttribute( "InjectiveDimension",
                  IsCapCategoryObject );
