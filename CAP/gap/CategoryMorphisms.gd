#############################################################################
##
##                                               CAP package
##
##  Copyright 2013, Sebastian Gutsche, TU Kaiserslautern
##                  Sebastian Posur,   RWTH Aachen
##
#! @Chapter Category morphism
#!  Any GAP object which is IsCapCategoryMorphism can be added to a category
#!  and then becomes a morphism in this category.
#!  Any morphism can belong to one or no category.
#!  After a GAP object is added to the category, it knows which things can be
#!  computed in its category and to which category it belongs.
#!  It knows categorial properties and attributes, and the functions for existential quantifiers
#!  can be applied to the morphism.
#!  If an GAP object in the category was constructed by a categorial construction
#!  it knows its Genesis.
##
#############################################################################

###################################
##
#! @Section Categories
##
###################################

## Moved to CAP.gd

###################################
##
#! @Section Functions for all objects
##
###################################

#! @Group Category getter
DeclareAttribute( "CapCategory",
                  IsCapCategoryMorphism );

DeclareAttribute( "Source",
                  IsCapCategoryMorphism );

DeclareAttribute( "Range",
                  IsCapCategoryMorphism );

DeclareAttribute( "UnderlyingObject",
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

DeclareGlobalFunction( "INSTALL_TODO_LIST_ENTRIES_FOR_MORPHISM" );

DeclareGlobalFunction( "INSTALL_TODO_LIST_FOR_EQUAL_MORPHISMS" );

DeclareGlobalVariable( "PROPAGATION_LIST_FOR_EQUAL_MORPHISMS" );

###################################
##
## Properties
##
###################################

##
DeclareFamilyProperty( "IsMonomorphism",
                       IsCapCategoryMorphism, "morphism" : reinstall := false );

DeclareOperation( "AddIsMonomorphism",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddIsMonomorphism",
                  [ IsCapCategory, IsFunction, IsInt ] );

DeclareOperation( "AddIsMonomorphism",
                  [ IsCapCategory, IsList, IsInt ] );

DeclareOperation( "AddIsMonomorphism",
                  [ IsCapCategory, IsList ] );

DeclareSynonymAttr( "IsSubobject",
                    IsMonomorphism );

##
DeclareFamilyProperty( "IsEpimorphism",
                       IsCapCategoryMorphism, "morphism" : reinstall := false );

DeclareOperation( "AddIsEpimorphism",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddIsEpimorphism",
                  [ IsCapCategory, IsFunction, IsInt ] );

DeclareOperation( "AddIsEpimorphism",
                  [ IsCapCategory, IsList, IsInt ] );

DeclareOperation( "AddIsEpimorphism",
                  [ IsCapCategory, IsList ] );

DeclareSynonymAttr( "IsFactorobject",
                    IsEpimorphism );

##
DeclareFamilyProperty( "IsIsomorphism",
                       IsCapCategoryMorphism, "morphism" : reinstall := false );

DeclareOperation( "AddIsIsomorphism",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddIsIsomorphism",
                  [ IsCapCategory, IsFunction, IsInt ] );

DeclareOperation( "AddIsIsomorphism",
                  [ IsCapCategory, IsList, IsInt ] );

DeclareOperation( "AddIsIsomorphism",
                  [ IsCapCategory, IsList ] );

##
DeclareFamilyProperty( "IsEndomorphism",
                       IsCapCategoryMorphism, "morphism" : reinstall := false );

DeclareOperation( "AddIsEndomorphism",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddIsEndomorphism",
                  [ IsCapCategory, IsFunction, IsInt ] );

DeclareOperation( "AddIsEndomorphism",
                  [ IsCapCategory, IsList, IsInt ] );

DeclareOperation( "AddIsEndomorphism",
                  [ IsCapCategory, IsList ] );

##
DeclareFamilyProperty( "IsAutomorphism",
                       IsCapCategoryMorphism, "morphism" : reinstall := false );

DeclareOperation( "AddIsAutomorphism",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddIsAutomorphism",
                  [ IsCapCategory, IsFunction, IsInt ] );

DeclareOperation( "AddIsAutomorphism",
                  [ IsCapCategory, IsList, IsInt ] );

DeclareOperation( "AddIsAutomorphism",
                  [ IsCapCategory, IsList ] );

##
DeclareFamilyProperty( "IsSplitMonomorphism",
                       IsCapCategoryMorphism, "morphism" : reinstall := false );

DeclareOperation( "AddIsSplitMonomorphism",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddIsSplitMonomorphism",
                  [ IsCapCategory, IsFunction, IsInt ] );

DeclareOperation( "AddIsSplitMonomorphism",
                  [ IsCapCategory, IsList, IsInt ] );

DeclareOperation( "AddIsSplitMonomorphism",
                  [ IsCapCategory, IsList ] );

##
DeclareFamilyProperty( "IsSplitEpimorphism",
                       IsCapCategoryMorphism, "morphism" : reinstall := false );

DeclareOperation( "AddIsSplitEpimorphism",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddIsSplitEpimorphism",
                  [ IsCapCategory, IsFunction, IsInt ] );

DeclareOperation( "AddIsSplitEpimorphism",
                  [ IsCapCategory, IsList, IsInt ] );

DeclareOperation( "AddIsSplitEpimorphism",
                  [ IsCapCategory, IsList ] );

## TODO: IsIdentity
DeclareFamilyProperty( "IsOne",
                       IsCapCategoryMorphism, "morphism" : reinstall := false );

DeclareOperation( "AddIsOne",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddIsOne",
                  [ IsCapCategory, IsFunction, IsInt ] );

DeclareOperation( "AddIsOne",
                  [ IsCapCategory, IsList, IsInt ] );

DeclareOperation( "AddIsOne",
                  [ IsCapCategory, IsList ] );

##
DeclareFamilyProperty( "IsIdempotent",
                       IsCapCategoryMorphism, "morphism" : reinstall := false );

DeclareOperation( "AddIsIdempotent",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddIsIdempotent",
                  [ IsCapCategory, IsFunction, IsInt ] );

DeclareOperation( "AddIsIdempotent",
                  [ IsCapCategory, IsList, IsInt ] );

DeclareOperation( "AddIsIdempotent",
                  [ IsCapCategory, IsList ] );

##
DeclareProperty( "IsIdenticalToIdentityMorphism",
                 IsCapCategoryMorphism );

DeclareOperation( "AddIsIdenticalToIdentityMorphism",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddIsIdenticalToIdentityMorphism",
                  [ IsCapCategory, IsFunction, IsInt ] );

DeclareOperation( "AddIsIdenticalToIdentityMorphism",
                  [ IsCapCategory, IsList, IsInt ] );

DeclareOperation( "AddIsIdenticalToIdentityMorphism",
                  [ IsCapCategory, IsList ] );

###################################
##
#! @Section Morphism add functions
##
###################################

DeclareOperation( "Add",
                  [ IsCapCategory, IsCapCategoryMorphism ] );

DeclareOperation( "AddMorphism",
                  [ IsCapCategory, IsObject ] );

###################################
##
#! @Section Constructive Hom-sets functions
##
###################################


## IsCongruentForMorphisms
DeclareOperation( "AddIsCongruentForMorphisms",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddIsCongruentForMorphisms",
                  [ IsCapCategory, IsFunction, IsInt ] );

DeclareOperation( "AddIsCongruentForMorphisms",
                  [ IsCapCategory, IsList, IsInt ] );

DeclareOperation( "AddIsCongruentForMorphisms",
                  [ IsCapCategory, IsList ] );

DeclareOperation( "IsCongruentForMorphisms",
                  [ IsCapCategoryMorphism, IsCapCategoryMorphism ] );

## IsEqualForMorphisms
DeclareOperation( "AddIsEqualForMorphisms",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddIsEqualForMorphisms",
                  [ IsCapCategory, IsFunction, IsInt ] );

DeclareOperation( "AddIsEqualForMorphisms",
                  [ IsCapCategory, IsList, IsInt ] );

DeclareOperation( "AddIsEqualForMorphisms",
                  [ IsCapCategory, IsList ] );


DeclareOperation( "AddIsEqualForMorphismsOnMor",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddIsEqualForMorphismsOnMor",
                  [ IsCapCategory, IsFunction, IsInt ] );

DeclareOperation( "AddIsEqualForMorphismsOnMor",
                  [ IsCapCategory, IsList, IsInt ] );

DeclareOperation( "AddIsEqualForMorphismsOnMor",
                  [ IsCapCategory, IsList ] );



DeclareOperation( "IsEqualForMorphisms",
                  [ IsCapCategoryMorphism, IsCapCategoryMorphism ] );

DeclareOperation( "IsEqualForMorphismsOnMor",
                  [ IsCapCategoryMorphism, IsCapCategoryMorphism ] );

DeclareOperation( "AddPropertyToMatchAtIsCongruentForMorphisms",
                  [ IsCapCategory, IsString ] );

DeclareOperation( "AddIsZeroForMorphisms",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddIsZeroForMorphisms",
                  [ IsCapCategory, IsFunction, IsInt ] );

DeclareOperation( "AddIsZeroForMorphisms",
                  [ IsCapCategory, IsList, IsInt ] );

DeclareOperation( "AddIsZeroForMorphisms",
                  [ IsCapCategory, IsList ] );

DeclareOperation( "IsZeroForMorphisms",
                  [ IsCapCategoryMorphism ] );


DeclareOperation( "AddAdditionForMorphisms",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddAdditionForMorphisms",
                  [ IsCapCategory, IsFunction, IsInt ] );

DeclareOperation( "AddAdditionForMorphisms",
                  [ IsCapCategory, IsList, IsInt ] );

DeclareOperation( "AddAdditionForMorphisms",
                  [ IsCapCategory, IsList ] );

DeclareOperation( "AdditionForMorphisms",
                  [ IsCapCategoryMorphism, IsCapCategoryMorphism ] );


DeclareOperation( "AddAdditiveInverseForMorphisms",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddAdditiveInverseForMorphisms",
                  [ IsCapCategory, IsFunction, IsInt ] );

DeclareOperation( "AddAdditiveInverseForMorphisms",
                  [ IsCapCategory, IsList, IsInt ] );

DeclareOperation( "AddAdditiveInverseForMorphisms",
                  [ IsCapCategory, IsList ] );

DeclareOperation( "AdditiveInverseForMorphisms",
                  [ IsCapCategoryMorphism ] );



DeclareOperation( "AddZeroMorphism",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddZeroMorphism",
                  [ IsCapCategory, IsFunction, IsInt ] );

DeclareOperation( "AddZeroMorphism",
                  [ IsCapCategory, IsList, IsInt ] );

DeclareOperation( "AddZeroMorphism",
                  [ IsCapCategory, IsList ] );


DeclareOperation( "TransportHom",
                  [ IsCapCategoryMorphism, IsCapCategoryMorphism, IsCapCategoryMorphism ] );

###################################
##
#! @Section Subobject functions
##
###################################

DeclareOperation( "AddIsEqualAsSubobjects",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddIsEqualAsSubobjects",
                  [ IsCapCategory, IsFunction, IsInt ] );

DeclareOperation( "AddIsEqualAsSubobjects",
                  [ IsCapCategory, IsList, IsInt ] );

DeclareOperation( "AddIsEqualAsSubobjects",
                  [ IsCapCategory, IsList ] );

DeclareOperation( "IsEqualAsSubobjects",
                  [ IsCapCategoryMorphism, IsCapCategoryMorphism ] );

DeclareOperation( "AddIsEqualAsFactorobjects",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddIsEqualAsFactorobjects",
                  [ IsCapCategory, IsFunction, IsInt ] );

DeclareOperation( "AddIsEqualAsFactorobjects",
                  [ IsCapCategory, IsList, IsInt ] );

DeclareOperation( "AddIsEqualAsFactorobjects",
                  [ IsCapCategory, IsList ] );

DeclareOperation( "IsEqualAsFactorobjects",
                  [ IsCapCategoryMorphism, IsCapCategoryMorphism ] );

DeclareOperation( "Dominates",
                  [ IsCapCategoryMorphism, IsCapCategoryMorphism ] );

DeclareOperation( "AddDominates",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddDominates",
                  [ IsCapCategory, IsFunction, IsInt ] );

DeclareOperation( "AddDominates",
                  [ IsCapCategory, IsList, IsInt ] );

DeclareOperation( "AddDominates",
                  [ IsCapCategory, IsList ] );



DeclareOperation( "Codominates",
                  [ IsCapCategoryMorphism, IsCapCategoryMorphism ] );

DeclareOperation( "AddCodominates",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddCodominates",
                  [ IsCapCategory, IsFunction, IsInt ] );

DeclareOperation( "AddCodominates",
                  [ IsCapCategory, IsList, IsInt ] );

DeclareOperation( "AddCodominates",
                  [ IsCapCategory, IsList ] );


###################################
##
#! @Section Morphism functions
##
###################################

DeclareOperation( "PreCompose",
                  [ IsCapCategoryMorphism, IsCapCategoryMorphism ] );

###################################
##
## IsWellDefined
##
###################################

DeclareOperation( "AddIsWellDefinedForMorphisms",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddIsWellDefinedForMorphisms",
                  [ IsCapCategory, IsFunction, IsInt ] );

DeclareOperation( "AddIsWellDefinedForMorphisms",
                  [ IsCapCategory, IsList, IsInt ] );

DeclareOperation( "AddIsWellDefinedForMorphisms",
                  [ IsCapCategory, IsList ] );

DeclareOperation( "IsWellDefinedForMorphisms",
                  [ IsCapCategoryMorphism ] );

###################################
##
## Monomorphism as kernel lift
##
###################################

#! @Description
#! This operation takes a monomorphism $\iota: K \rightarrow A$
#! and a test morphism $\tau: T \rightarrow A$ and tries
#! to compute a lift $u: T \rightarrow K$ such that
#! $\iota \circ u = \tau$. If this is not possible the method 
#! will return fail.
#! @Returns $u$
#! @Arguments monomorphism, test_morphism
DeclareOperation( "MonoAsKernelLift",
                  [ IsCapCategoryMorphism, IsCapCategoryMorphism ] );

####################################
##
## Epismorphism as cokernel lift
##
####################################

#! @Description
#! This operation takes an epimorphism $\epsilon: A \rightarrow C$
#! and a test morphism $\tau: A \rightarrow T$ and tries
#! to compute a colift $u: T \rightarrow K$ such that
#! $u \circ \epsilon = \tau$. If this is not possible the method 
#! will return fail.
#! @Returns $u$
#! @Arguments epimorphism, test_morphism
DeclareOperation( "EpiAsCokernelColift",
                  [ IsCapCategoryMorphism, IsCapCategoryMorphism ] );


###################################
##
## Lift/ Colift
##
###################################

##
DeclareOperation( "Lift",
                  [ IsCapCategoryMorphism, IsCapCategoryMorphism ] );

DeclareOperation( "AddLift",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddLift",
                  [ IsCapCategory, IsFunction, IsInt ] );

DeclareOperation( "AddLift",
                  [ IsCapCategory, IsList, IsInt ] );

DeclareOperation( "AddLift",
                  [ IsCapCategory, IsList ] );

##
DeclareOperation( "Colift",
                  [ IsCapCategoryMorphism, IsCapCategoryMorphism ] );

DeclareOperation( "AddColift",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddColift",
                  [ IsCapCategory, IsFunction, IsInt ] );

DeclareOperation( "AddColift",
                  [ IsCapCategory, IsList, IsInt ] );

DeclareOperation( "AddColift",
                  [ IsCapCategory, IsList ] );

###################################
##
#! @Section Implied operations
##
###################################


DeclareOperation( "PostCompose",
                  [ IsCapCategoryMorphism, IsCapCategoryMorphism ] );
