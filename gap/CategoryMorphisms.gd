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

DeclareGlobalFunction( "CATEGORIES_FOR_HOMALG_CREATE_MORPHISM_PRINT" );

DeclareGlobalFunction( "INSTALL_TODO_LIST_ENTRIES_FOR_MORPHISM" );

DeclareGlobalFunction( "INSTALL_TODO_LIST_FOR_EQUAL_MORPHISMS" );

DeclareGlobalVariable( "PROPAGATION_LIST_FOR_EQUAL_MORPHISMS" );

###################################
##
## Properties
##
###################################

DeclareFamilyProperty( "IsMonomorphism",
                       IsCapCategoryMorphism, "morphism" : reinstall := false );

DeclareOperation( "AddIsMonomorphism",
                  [ IsCapCategory, IsFunction ] );

DeclareAttribute( "IsMonomorphismFunction",
                  IsCapCategory );

DeclareSynonymAttr( "IsSubobject",
                    IsMonomorphism );

DeclareFamilyProperty( "IsEpimorphism",
                       IsCapCategoryMorphism, "morphism" : reinstall := false );

DeclareOperation( "AddIsEpimorphism",
                  [ IsCapCategory, IsFunction ] );

DeclareAttribute( "IsEpimorphismFunction",
                  IsCapCategory );

DeclareSynonymAttr( "IsFactorobject",
                    IsEpimorphism );

DeclareFamilyProperty( "IsIsomorphism",
                       IsCapCategoryMorphism, "morphism" : reinstall := false );

DeclareOperation( "AddIsIsomorphism",
                  [ IsCapCategory, IsFunction ] );

DeclareAttribute( "IsIsomorphismFunction",
                  IsCapCategory );

DeclareFamilyProperty( "IsEndomorphism",
                       IsCapCategoryMorphism, "morphism" : reinstall := false );

DeclareFamilyProperty( "IsAutomorphism",
                       IsCapCategoryMorphism, "morphism" : reinstall := false );

DeclareFamilyProperty( "IsSplitMonomorphism",
                       IsCapCategoryMorphism, "morphism" : reinstall := false );

DeclareFamilyProperty( "IsSplitEpimorphism",
                       IsCapCategoryMorphism, "morphism" : reinstall := false );

## TODO: IsIdentity
DeclareFamilyProperty( "IsOne",
                       IsCapCategoryMorphism, "morphism" : reinstall := false );

DeclareFamilyProperty( "IsIdempotent",
                       IsCapCategoryMorphism, "morphism" : reinstall := false );

###################################
##
#! @Section Morphism add functions
##
###################################

DeclareOperation( "Add",
                  [ IsCapCategory, IsCapCategoryMorphism ] );

###################################
##
#! @Section Constructive Hom-sets functions
##
###################################

DeclareOperation( "AddIsEqualForMorphisms",
                  [ IsCapCategory, IsFunction ] );

DeclareAttribute( "MorphismEqualityFunction",
                  IsCapCategory );

DeclareOperation( "IsEqualForMorphisms",
                  [ IsCapCategoryMorphism, IsCapCategoryMorphism ] );

DeclareOperation( "AddPropertyToMatchAtIsEqualForMorphisms",
                  [ IsCapCategory, IsString ] );

DeclareOperation( "AddIsZeroForMorphisms",
                  [ IsCapCategory, IsFunction ] );

DeclareAttribute( "IsZeroForMorphismsFunction",
                  IsCapCategory );

DeclareOperation( "AddAdditionForMorphisms",
                  [ IsCapCategory, IsFunction ] );

DeclareAttribute( "AdditionForMorphismsFunction",
                  IsCapCategory );

DeclareOperation( "AddAdditiveInverseForMorphisms",
                  [ IsCapCategory, IsFunction ] );

DeclareAttribute( "AdditiveInverseForMorphismsFunction",
                  IsCapCategory );

DeclareOperation( "AddZeroMorphism",
                  [ IsCapCategory, IsFunction ] );

DeclareAttribute( "ZeroMorphismFunction",
                  IsCapCategory );

DeclareOperation( "TransportHom",
                  [ IsCapCategoryMorphism, IsCapCategoryMorphism, IsCapCategoryMorphism ] );

###################################
##
#! @Section Subobject functions
##
###################################

DeclareOperation( "IsEqualAsSubobject",
                  [ IsCapCategoryMorphism, IsCapCategoryMorphism ] );

DeclareOperation( "IsEqualAsFactorobject",
                  [ IsCapCategoryMorphism, IsCapCategoryMorphism ] );

DeclareOperation( "Dominates",
                  [ IsCapCategoryMorphism, IsCapCategoryMorphism ] );

DeclareOperation( "AddDominates",
                  [ IsCapCategory, IsFunction ] );

DeclareAttribute( "DominatesFunction",
                  IsCapCategory );

DeclareOperation( "Codominates",
                  [ IsCapCategoryMorphism, IsCapCategoryMorphism ] );

DeclareOperation( "AddCodominates",
                  [ IsCapCategory, IsFunction ] );

DeclareAttribute( "CodominatesFunction",
                  IsCapCategory );

###################################
##
#! @Section Morphism functions
##
###################################

DeclareOperation( "PreCompose",
                  [ IsCapCategoryMorphism, IsCapCategoryMorphism ] );

DeclareAttributeWithToDoForIsWellDefined( "EpiMonoFactorization",
                                          IsCapCategoryMorphism );

###################################
##
## IsWellDefined
##
###################################

DeclareOperation( "AddIsWellDefinedForMorphisms",
                  [ IsCapCategory, IsFunction ] );

DeclareAttribute( "IsWellDefinedForMorphismsFunction",
                  IsCapCategory );

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
#! @Section Implied operations
##
###################################


DeclareOperation( "PostCompose",
                  [ IsCapCategoryMorphism, IsCapCategoryMorphism ] );
