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

DeclareAttribute( "Genesis",
                  IsCapCategoryCell, 
                  "mutable" );

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
DeclareOperation( "IsZeroForObjects", 
                  [ IsCapCategoryObject ] );

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








