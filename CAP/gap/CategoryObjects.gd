#############################################################################
##
##                                               CAP package
##
##  Copyright 2013, Sebastian Gutsche, TU Kaiserslautern
##                  Sebastian Posur,   RWTH Aachen
##
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
DeclareOperationWithCache( "IsEqualForObjects",
                  [ IsCapCategoryObject, IsCapCategoryObject ] );

#! @Description
#! The arguments are a category $C$ and a function $F$.
#! This operations adds the given function $F$
#! to the category for the basic operation <C>IsEqualForObjects</C>.
#! $F: (a,b) \mapsto \mathtt{IsEqualForObjects}(a,b)$.
#! @Returns nothing
#! @Arguments C, F
DeclareOperation( "AddIsEqualForObjects",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddIsEqualForObjects",
                  [ IsCapCategory, IsFunction, IsInt ] );

DeclareOperation( "AddIsEqualForObjects",
                  [ IsCapCategory, IsList, IsInt ] );

DeclareOperation( "AddIsEqualForObjects",
                  [ IsCapCategory, IsList ] );

## adds the given string to PROPAGATION_LIST_FOR_EQUAL_OBJECTS
DeclareOperation( "AddPropertyToMatchAtIsEqualForObjects",
                  [ IsCapCategory, IsString ] );


###################################
##
#! @Section Categorical Properties of Objects
##
###################################

## TODO
# @Description
# The argument is an object $a$.
# The output is <C>true</C> if $a$ is a projective object,
# otherwise the output is <C>false</C>.
# @Returns a boolean
# @Arguments a
DeclareFamilyProperty( "IsProjective",
                       IsCapCategoryObject, "object" : reinstall := false );

#! @Description
#! The arguments are a category $C$ and a function $F$.
#! This operations adds the given function $F$
#! to the category for the basic operation <C>IsProjective</C>.
#! $F: a \mapsto \mathtt{IsProjective}(a)$.
#! @Returns nothing
#! @Arguments C, F
DeclareOperation( "AddIsProjective",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddIsProjective",
                  [ IsCapCategory, IsFunction, IsInt ] );

DeclareOperation( "AddIsProjective",
                  [ IsCapCategory, IsList, IsInt ] );

DeclareOperation( "AddIsProjective",
                  [ IsCapCategory, IsList ] );

## TODO
# @Description
# The argument is an object $a$.
# The output is <C>true</C> if $a$ is an injective object,
# otherwise the output is <C>false</C>.
# @Returns a boolean
# @Arguments a
DeclareFamilyProperty( "IsInjective",
                       IsCapCategoryObject, "object" : reinstall := false );

#! @Description
#! The arguments are a category $C$ and a function $F$.
#! This operations adds the given function $F$
#! to the category for the basic operation <C>IsInjective</C>.
#! $F: a \mapsto \mathtt{IsInjective}(a)$.
#! @Returns nothing
#! @Arguments C, F
DeclareOperation( "AddIsInjective",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddIsInjective",
                  [ IsCapCategory, IsFunction, IsInt ] );

DeclareOperation( "AddIsInjective",
                  [ IsCapCategory, IsList, IsInt ] );

DeclareOperation( "AddIsInjective",
                  [ IsCapCategory, IsList ] );

## TODO
# @Description
# The argument is an object $a$ of a category $\mathbf{C}$.
# The output is <C>true</C> if $a$ is isomorphic to the terminal object of $\mathbf{C}$, 
# otherwise the output is <C>false</C>.
# @Returns a boolean
# @Arguments a
DeclareFamilyProperty( "IsTerminal",
                       IsCapCategoryObject, "object" : reinstall := false );

#! @Description
#! The arguments are a category $C$ and a function $F$.
#! This operations adds the given function $F$
#! to the category for the basic operation <C>IsTerminal</C>.
#! $F: a \mapsto \mathtt{IsTerminal}(a)$.
#! @Returns nothing
#! @Arguments C, F
DeclareOperation( "AddIsTerminal",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddIsTerminal",
                  [ IsCapCategory, IsFunction, IsInt ] );

DeclareOperation( "AddIsTerminal",
                  [ IsCapCategory, IsList, IsInt ] );

DeclareOperation( "AddIsTerminal",
                  [ IsCapCategory, IsList ] );

## TODO
# @Description
# The argument is an object $a$ of a category $\mathbf{C}$.
# The output is <C>true</C> if $a$ is isomorphic to the initial object of $\mathbf{C}$, 
# otherwise the output is <C>false</C>.
# @Returns a boolean
# @Arguments a
DeclareFamilyProperty( "IsInitial",
                       IsCapCategoryObject, "object" : reinstall := false );

#! @Description
#! The arguments are a category $C$ and a function $F$.
#! This operations adds the given function $F$
#! to the category for the basic operation <C>IsInitial</C>.
#! $F: a \mapsto \mathtt{IsInitial}(a)$.
#! @Returns nothing
#! @Arguments C, F
DeclareOperation( "AddIsInitial",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddIsInitial",
                  [ IsCapCategory, IsFunction, IsInt ] );

DeclareOperation( "AddIsInitial",
                  [ IsCapCategory, IsList, IsInt ] );

DeclareOperation( "AddIsInitial",
                  [ IsCapCategory, IsList ] );

## TODO
#! @Description
#! The argument is an object $a$ of a category $\mathbf{C}$.
#! The output is <C>true</C> if $a$ is isomorphic to the zero object of $\mathbf{C}$, 
#! otherwise the output is <C>false</C>.
#! @Returns a boolean
#! @Arguments a
DeclareProperty( "IsZeroForObjects",
                 IsCapCategoryObject );

# @Description
# The argument is an object $a$ of a category $\mathbf{C}$.
# The output is <C>true</C> if $a$ is isomorphic to the zero object of $\mathbf{C}$, 
# otherwise the output is <C>false</C>.
# @Returns a boolean
# @Arguments a
DeclareFamilyProperty( "IsZero",
                       IsCapCategoryObject, "object" : reinstall := false );

#! @Description
#! The arguments are a category $C$ and a function $F$.
#! This operations adds the given function $F$
#! to the category for the basic operation <C>IsZeroForObjects</C>.
#! $F: a \mapsto \mathtt{IsZeroForObjects}(a)$.
#! @Returns nothing
#! @Arguments C, F
DeclareOperation( "AddIsZeroForObjects",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddIsZeroForObjects",
                  [ IsCapCategory, IsFunction, IsInt ] );

DeclareOperation( "AddIsZeroForObjects",
                  [ IsCapCategory, IsList, IsInt ] );

DeclareOperation( "AddIsZeroForObjects",
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
DeclareOperation( "IsEqualForCacheForObjects",
                  [ IsCapCategoryObject, IsCapCategoryObject ] );

#! @Description
#!  By default, CAP uses caches to store the values of Categorical operations.
#!  To get a value out of the cache, one needs to compare the input of a basic operation
#!  with its previous input. To compare objects in the category, IsEqualForCacheForObject is
#!  used. By default this is an alias for IsEqualForObjects, where fail is substituted by false.
#!  If you add a function, this function
#!  used instead. A function $F: a,b \mapsto bool$ is expected here. The output has to be
#!  true or false. Fail is not allowed in this context.
#! @Returns northing
#! @Arguments c,F
DeclareOperation( "AddIsEqualForCacheForObjects",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddIsEqualForCacheForObjects",
                  [ IsCapCategory, IsFunction, IsInt ] );

DeclareOperation( "AddIsEqualForCacheForObjects",
                  [ IsCapCategory, IsList, IsInt ] );

DeclareOperation( "AddIsEqualForCacheForObjects",
                  [ IsCapCategory, IsList ] );

###################################
##
#! @Section Adding Objects to a Category
##
###################################

DeclareOperation( "Add",
                  [ IsCapCategory, IsCapCategoryObject ] );

DeclareOperation( "AddObject",
                  [ IsCapCategory, IsObject ] );

#! @Arguments category, filter
#! @Description
#!  The argument <A>filter</A> is used to create an object type for the
#!  category <A>category</A>, which is then used in <C>ObjectifyObjectForCAPWithAttributes</C>
#!  to objectify objects for this category.
DeclareOperation( "AddObjectRepresentation",
                  [ IsCapCategory, IsObject ] );

#! @Arguments object, category, [attribute1, value1, ...]
#! @Description
#!  Objectifies the object <A>object</A> with the type created
#!  for objects in the category <A>category</A>. The type
#!  is created by passing a representation to <C>AddObjectRepresentation</C>.
#!  Objects which are objectified using this method do not have to be passed
#!  to the <C>AddObject</C> function.
DeclareGlobalFunction( "ObjectifyObjectForCAPWithAttributes" );

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

#! @Description
#! The arguments are a category $C$ and a function $F$.
#! This operations adds the given function $F$
#! to the category for the basic operation <C>IsWellDefinedForObjects</C>.
#! $F: a \mapsto \mathtt{IsWellDefinedForObjects}( a )$.
#! @Returns nothing
#! @Arguments C, F
DeclareOperation( "AddIsWellDefinedForObjects",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddIsWellDefinedForObjects",
                  [ IsCapCategory, IsFunction, IsInt ] );

DeclareOperation( "AddIsWellDefinedForObjects",
                  [ IsCapCategory, IsList, IsInt ] );

DeclareOperation( "AddIsWellDefinedForObjects",
                  [ IsCapCategory, IsList ] );


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

## Add Operations

#! @Description
#! The arguments are a category $C$ and a function $F$.
#! This operation adds the given function $F$
#! to the category for the basic operation <C>SomeProjectiveObject</C>.
#! $F: A \mapsto P$.
#! @Returns nothing
#! @Arguments C, F
DeclareOperation( "AddSomeProjectiveObject",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddSomeProjectiveObject",
                  [ IsCapCategory, IsFunction, IsInt ] );

DeclareOperation( "AddSomeProjectiveObject",
                  [ IsCapCategory, IsList, IsInt ] );

DeclareOperation( "AddSomeProjectiveObject",
                  [ IsCapCategory, IsList ] );

#! @Description
#! The arguments are a category $C$ and a function $F$.
#! This operation adds the given function $F$
#! to the category for the basic operation <C>EpimorphismFromSomeProjectiveObject</C>.
#! $F: A \mapsto \pi$.
#! @Returns nothing
#! @Arguments C, F
DeclareOperation( "AddEpimorphismFromSomeProjectiveObject",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddEpimorphismFromSomeProjectiveObject",
                  [ IsCapCategory, IsFunction, IsInt ] );

DeclareOperation( "AddEpimorphismFromSomeProjectiveObject",
                  [ IsCapCategory, IsList, IsInt ] );

DeclareOperation( "AddEpimorphismFromSomeProjectiveObject",
                  [ IsCapCategory, IsList ] );

#! @Description
#! The arguments are a category $C$ and a function $F$.
#! This operation adds the given function $F$
#! to the category for the basic operation <C>AddEpimorphismFromSomeProjectiveObjectWithGivenSomeProjectiveObject</C>.
#! $F: (A,P) \mapsto \pi$.
#! @Returns nothing
#! @Arguments C, F
DeclareOperation( "AddEpimorphismFromSomeProjectiveObjectWithGivenSomeProjectiveObject",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddEpimorphismFromSomeProjectiveObjectWithGivenSomeProjectiveObject",
                  [ IsCapCategory, IsFunction, IsInt ] );

DeclareOperation( "AddEpimorphismFromSomeProjectiveObjectWithGivenSomeProjectiveObject",
                  [ IsCapCategory, IsList, IsInt ] );

DeclareOperation( "AddEpimorphismFromSomeProjectiveObjectWithGivenSomeProjectiveObject",
                  [ IsCapCategory, IsList ] );

#! @Description
#! The arguments are a category $C$ and a function $F$.
#! This operations adds the given function $F$
#! to the category for the basic operation <C>ProjectiveLift</C>.
#! The function $F$ maps a pair $(\pi, \epsilon)$ to a projective lift $\lambda$.
#! @Returns nothing
#! @Arguments C, F
DeclareOperation( "AddProjectiveLift",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddProjectiveLift",
                  [ IsCapCategory, IsFunction, IsInt ] );

DeclareOperation( "AddProjectiveLift",
                  [ IsCapCategory, IsList, IsInt ] );

DeclareOperation( "AddProjectiveLift",
                  [ IsCapCategory, IsList ] );

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
#! The arguments are a morphism $\iota: B \rightarrow A$
#! and $\beta: B \rightarrow I$ where $I$ is an injective object.
#! The output is a morphism $\lambda: A \rightarrow I$ such that
#! $\lambda \circ \iota = \beta$.
#! @Returns a morphism in $\mathrm{Hom}(A,I)$
#! @Arguments \iota, \beta
DeclareOperation( "InjectiveColift",
                  [ IsCapCategoryMorphism, IsCapCategoryMorphism ] );

## Add Operations

#! @Description
#! The arguments are a category $C$ and a function $F$.
#! This operation adds the given function $F$
#! to the category for the basic operation <C>SomeInjectiveObject</C>.
#! $F: A \mapsto I$.
#! @Returns nothing
#! @Arguments C, F
DeclareOperation( "AddSomeInjectiveObject",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddSomeInjectiveObject",
                  [ IsCapCategory, IsFunction, IsInt ] );

DeclareOperation( "AddSomeInjectiveObject",
                  [ IsCapCategory, IsList, IsInt ] );

DeclareOperation( "AddSomeInjectiveObject",
                  [ IsCapCategory, IsList ] );

#! @Description
#! The arguments are a category $C$ and a function $F$.
#! This operation adds the given function $F$
#! to the category for the basic operation <C>MonomorphismIntoSomeInjectiveObject</C>.
#! $F: A \mapsto \pi$.
#! @Returns nothing
#! @Arguments C, F
DeclareOperation( "AddMonomorphismIntoSomeInjectiveObject",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddMonomorphismIntoSomeInjectiveObject",
                  [ IsCapCategory, IsFunction, IsInt ] );

DeclareOperation( "AddMonomorphismIntoSomeInjectiveObject",
                  [ IsCapCategory, IsList, IsInt ] );

DeclareOperation( "AddMonomorphismIntoSomeInjectiveObject",
                  [ IsCapCategory, IsList ] );

#! @Description
#! The arguments are a category $C$ and a function $F$.
#! This operation adds the given function $F$
#! to the category for the basic operation <C>AddMonomorphismIntoSomeInjectiveObjectWithGivenSomeInjectiveObject</C>.
#! $F: (A,I) \mapsto \pi$.
#! @Returns nothing
#! @Arguments C, F
DeclareOperation( "AddMonomorphismIntoSomeInjectiveObjectWithGivenSomeInjectiveObject",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddMonomorphismIntoSomeInjectiveObjectWithGivenSomeInjectiveObject",
                  [ IsCapCategory, IsFunction, IsInt ] );

DeclareOperation( "AddMonomorphismIntoSomeInjectiveObjectWithGivenSomeInjectiveObject",
                  [ IsCapCategory, IsList, IsInt ] );

DeclareOperation( "AddMonomorphismIntoSomeInjectiveObjectWithGivenSomeInjectiveObject",
                  [ IsCapCategory, IsList ] );

#! @Description
#! The arguments are a category $C$ and a function $F$.
#! This operations adds the given function $F$
#! to the category for the basic operation <C>InjectiveColift</C>.
#! The function $F$ maps a pair $(\iota, \beta)$ to an injective colift $\lambda$ if it
#! exists, and to <C>fail</C> otherwise.
#! @Returns nothing
#! @Arguments C, F
DeclareOperation( "AddInjectiveColift",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddInjectiveColift",
                  [ IsCapCategory, IsFunction, IsInt ] );

DeclareOperation( "AddInjectiveColift",
                  [ IsCapCategory, IsList, IsInt ] );

DeclareOperation( "AddInjectiveColift",
                  [ IsCapCategory, IsList ] );
