# SPDX-License-Identifier: GPL-2.0-or-later
# MonoidalCategories: Monoidal and monoidal (co)closed categories
#
# Declarations
#

####################################
##
#! @Chapter Legacy Operations and Synonyms
##
####################################

####################################
##
#! @Section Legacy operations
##
####################################

#! @Description
#!  This is a legacy operation for `CocartesianLeftCoevaluationMorphism`( <A>b</A>, <A>a</A> ),
#!  i.e., with the first and second argument interchanged.
#! @Arguments a, b
DeclareOperation( "CocartesianCoevaluationMorphism", [ IsCapCategoryObject, IsCapCategoryObject ] );

#! @Description
#!  This is a legacy operation for `CocartesianLeftCoevaluationMorphismWithGivenSource`( <A>b</A>, <A>a</A>, <A>s</A> ),
#!  i.e., with the first and second argument interchanged.
#! @Arguments a, b, s
DeclareOperation( "CocartesianCoevaluationMorphismWithGivenSource", [ IsCapCategoryObject, IsCapCategoryObject, IsCapCategoryObject ] );

#! @Description
#!  This is a legacy operation for `CocartesianLeftEvaluationMorphism`( <A>b</A>, <A>a</A> ),
#!  i.e., with the first and second argument interchanged.
#! @Arguments a, b
DeclareOperation( "CocartesianEvaluationMorphism", [ IsCapCategoryObject, IsCapCategoryObject ] );

#! @Description
#!  This is a legacy operation for `CocartesianLeftEvaluationMorphismWithGivenRange`( <A>b</A>, <A>a</A>, <A>r</A> ),
#!  i.e., with the first and second argument interchanged.
#! @Arguments a, b, r
DeclareOperation( "CocartesianEvaluationMorphismWithGivenRange", [ IsCapCategoryObject, IsCapCategoryObject, IsCapCategoryObject ] );

#! @Description
#!  This is a legacy operation for `CartesianLeftCoevaluationMorphism`( <A>b</A>, <A>a</A> ),
#!  i.e., with the first and second argument interchanged.
#! @Arguments a, b
DeclareOperation( "CartesianCoevaluationMorphism", [ IsCapCategoryObject, IsCapCategoryObject ] );

#! @Description
#!  This is a legacy operation for `CartesianLeftCoevaluationMorphismWithGivenRange`( <A>b</A>, <A>a</A>, <A>r</A> ),
#!  i.e., with the first and second argument interchanged.
#! @Arguments a, b, r
DeclareOperation( "CartesianCoevaluationMorphismWithGivenRange", [ IsCapCategoryObject, IsCapCategoryObject, IsCapCategoryObject ] );

####################################
##
#! @Section Synonyms for legacy operations
##
####################################

#! @Description
#!  This is a synonym for `CartesianLeftEvaluationMorphism`.
# DeclareOperation( "CartesianEvaluationMorphism", [ IsObject ] );
# this comment stops AutoDoc from trying to parse the next line (which it can't at the moment)
DeclareSynonym( "CartesianEvaluationMorphism", CartesianLeftEvaluationMorphism );

#! @Description
#!  This is a synonym for `CartesianLeftEvaluationMorphismWithGivenSource`.
# DeclareOperation( "CartesianEvaluationMorphismWithGivenSource", [ IsObject ] );
# this comment stops AutoDoc from trying to parse the next line (which it can't at the moment)
DeclareSynonym( "CartesianEvaluationMorphismWithGivenSource", CartesianLeftEvaluationMorphismWithGivenSource );

#! @Description
#!  This is a synonym for `CoexponentialToCoproductLeftAdjunctMorphism`.
# DeclareOperation( "CoexponentialToCoproductAdjunctionMap", [ IsObject ] );
# this comment stops AutoDoc from trying to parse the next line (which it can't at the moment)
DeclareSynonym( "CoexponentialToCoproductAdjunctionMap", CoexponentialToCoproductLeftAdjunctMorphism );

#! @Description
#!  This is a synonym for `CoexponentialToCoproductLeftAdjunctMorphismWithGivenCoproduct`.
# DeclareOperation( "CoexponentialToCoproductAdjunctionMapWithGivenCoproduct", [ IsObject ] );
# this comment stops AutoDoc from trying to parse the next line (which it can't at the moment)
DeclareSynonym( "CoexponentialToCoproductAdjunctionMapWithGivenCoproduct", CoexponentialToCoproductLeftAdjunctMorphismWithGivenCoproduct );

#! @Description
#!  This is a synonym for `ExponentialToDirectProductLeftAdjunctMorphism`.
# DeclareOperation( "ExponentialToDirectProductAdjunctionMap", [ IsObject ] );
# this comment stops AutoDoc from trying to parse the next line (which it can't at the moment)
DeclareSynonym( "ExponentialToDirectProductAdjunctionMap", ExponentialToDirectProductLeftAdjunctMorphism );

#! @Description
#!  This is a synonym for `ExponentialToDirectProductLeftAdjunctMorphismWithGivenDirectProduct`.
# DeclareOperation( "ExponentialToDirectProductAdjunctionMapWithGivenDirectProduct", [ IsObject ] );
# this comment stops AutoDoc from trying to parse the next line (which it can't at the moment)
DeclareSynonym( "ExponentialToDirectProductAdjunctionMapWithGivenDirectProduct", ExponentialToDirectProductLeftAdjunctMorphismWithGivenDirectProduct );

#! @Description
#!  This is a synonym for `CoproductToCoexponentialLeftAdjunctMorphism`.
# DeclareOperation( "CoproductToCoexponentialAdjunctionMap", [ IsObject ] );
# this comment stops AutoDoc from trying to parse the next line (which it can't at the moment)
DeclareSynonym( "CoproductToCoexponentialAdjunctionMap", CoproductToCoexponentialLeftAdjunctMorphism );

#! @Description
#!  This is a synonym for `CoproductToCoexponentialLeftAdjunctMorphismWithGivenCoexponential`.
# DeclareOperation( "CoproductToCoexponentialAdjunctionMapWithGivenCoexponential", [ IsObject ] );
# this comment stops AutoDoc from trying to parse the next line (which it can't at the moment)
DeclareSynonym( "CoproductToCoexponentialAdjunctionMapWithGivenCoexponential", CoproductToCoexponentialLeftAdjunctMorphismWithGivenCoexponential );

#! @Description
#!  This is a synonym for `DirectProductToExponentialLeftAdjunctMorphism`.
# DeclareOperation( "DirectProductToExponentialAdjunctionMap", [ IsObject ] );
# this comment stops AutoDoc from trying to parse the next line (which it can't at the moment)
DeclareSynonym( "DirectProductToExponentialAdjunctionMap", DirectProductToExponentialLeftAdjunctMorphism );

#! @Description
#!  This is a synonym for `DirectProductToExponentialLeftAdjunctMorphismWithGivenExponential`.
# DeclareOperation( "DirectProductToExponentialAdjunctionMapWithGivenExponential", [ IsObject ] );
# this comment stops AutoDoc from trying to parse the next line (which it can't at the moment)
DeclareSynonym( "DirectProductToExponentialAdjunctionMapWithGivenExponential", DirectProductToExponentialLeftAdjunctMorphismWithGivenExponential );

##
## Add-methods
##

#! @Description
#!  This is a synonym for `AddCartesianLeftEvaluationMorphism`.
# DeclareOperation( "AddCartesianEvaluationMorphism", [ IsObject ] );
# this comment stops AutoDoc from trying to parse the next line (which it can't at the moment)
DeclareSynonym( "AddCartesianEvaluationMorphism", AddCartesianLeftEvaluationMorphism );

#! @Description
#!  This is a synonym for `AddCartesianLeftEvaluationMorphismWithGivenSource`.
# DeclareOperation( "AddCartesianEvaluationMorphismWithGivenSource", [ IsObject ] );
# this comment stops AutoDoc from trying to parse the next line (which it can't at the moment)
DeclareSynonym( "AddCartesianEvaluationMorphismWithGivenSource", AddCartesianLeftEvaluationMorphismWithGivenSource );

#! @Description
#!  This is a synonym for `AddCoexponentialToCoproductLeftAdjunctMorphism`.
# DeclareOperation( "AddCoexponentialToCoproductAdjunctionMap", [ IsObject ] );
# this comment stops AutoDoc from trying to parse the next line (which it can't at the moment)
DeclareSynonym( "AddCoexponentialToCoproductAdjunctionMap", AddCoexponentialToCoproductLeftAdjunctMorphism );

#! @Description
#!  This is a synonym for `AddCoexponentialToCoproductLeftAdjunctMorphismWithGivenCoproduct`.
# DeclareOperation( "AddCoexponentialToCoproductAdjunctionMapWithGivenCoproduct", [ IsObject ] );
# this comment stops AutoDoc from trying to parse the next line (which it can't at the moment)
DeclareSynonym( "AddCoexponentialToCoproductAdjunctionMapWithGivenCoproduct", AddCoexponentialToCoproductLeftAdjunctMorphismWithGivenCoproduct );

#! @Description
#!  This is a synonym for `AddExponentialToDirectProductLeftAdjunctMorphism`.
# DeclareOperation( "AddExponentialToDirectProductAdjunctionMap", [ IsObject ] );
# this comment stops AutoDoc from trying to parse the next line (which it can't at the moment)
DeclareSynonym( "AddExponentialToDirectProductAdjunctionMap", AddExponentialToDirectProductLeftAdjunctMorphism );

#! @Description
#!  This is a synonym for `AddExponentialToDirectProductLeftAdjunctMorphismWithGivenDirectProduct`.
# DeclareOperation( "AddExponentialToDirectProductAdjunctionMapWithGivenDirectProduct", [ IsObject ] );
# this comment stops AutoDoc from trying to parse the next line (which it can't at the moment)
DeclareSynonym( "AddExponentialToDirectProductAdjunctionMapWithGivenDirectProduct", AddExponentialToDirectProductLeftAdjunctMorphismWithGivenDirectProduct );

#! @Description
#!  This is a synonym for `AddCoproductToCoexponentialLeftAdjunctMorphism`.
# DeclareOperation( "AddCoproductToCoexponentialAdjunctionMap", [ IsObject ] );
# this comment stops AutoDoc from trying to parse the next line (which it can't at the moment)
DeclareSynonym( "AddCoproductToCoexponentialAdjunctionMap", AddCoproductToCoexponentialLeftAdjunctMorphism );

#! @Description
#!  This is a synonym for `AddCoproductToCoexponentialLeftAdjunctMorphismWithGivenCoexponential`.
# DeclareOperation( "AddCoproductToCoexponentialAdjunctionMapWithGivenCoexponential", [ IsObject ] );
# this comment stops AutoDoc from trying to parse the next line (which it can't at the moment)
DeclareSynonym( "AddCoproductToCoexponentialAdjunctionMapWithGivenCoexponential", AddCoproductToCoexponentialLeftAdjunctMorphismWithGivenCoexponential );

#! @Description
#!  This is a synonym for `AddDirectProductToExponentialLeftAdjunctMorphism`.
# DeclareOperation( "AddDirectProductToExponentialAdjunctionMap", [ IsObject ] );
# this comment stops AutoDoc from trying to parse the next line (which it can't at the moment)
DeclareSynonym( "AddDirectProductToExponentialAdjunctionMap", AddDirectProductToExponentialLeftAdjunctMorphism );

#! @Description
#!  This is a synonym for `AddDirectProductToExponentialLeftAdjunctMorphismWithGivenExponential`.
# DeclareOperation( "AddDirectProductToExponentialAdjunctionMapWithGivenExponential", [ IsObject ] );
# this comment stops AutoDoc from trying to parse the next line (which it can't at the moment)
DeclareSynonym( "AddDirectProductToExponentialAdjunctionMapWithGivenExponential", AddDirectProductToExponentialLeftAdjunctMorphismWithGivenExponential );

## AdjunctionMap -> AdjunctMorphism

#! @Description
#!  This is a synonym for `CoexponentialToCoproductLeftAdjunctMorphism`.
# DeclareOperation( "CoexponentialToCoproductLeftAdjunctionMap", [ IsObject ] );
# this comment stops AutoDoc from trying to parse the next line (which it can't at the moment)
DeclareSynonym( "CoexponentialToCoproductLeftAdjunctionMap", CoexponentialToCoproductLeftAdjunctMorphism );

#! @Description
#!  This is a synonym for `CoexponentialToCoproductLeftAdjunctMorphismWithGivenCoproduct`.
# DeclareOperation( "CoexponentialToCoproductLeftAdjunctionMapWithGivenCoproduct", [ IsObject ] );
# this comment stops AutoDoc from trying to parse the next line (which it can't at the moment)
DeclareSynonym( "CoexponentialToCoproductLeftAdjunctionMapWithGivenCoproduct", CoexponentialToCoproductLeftAdjunctMorphismWithGivenCoproduct );

#! @Description
#!  This is a synonym for `ExponentialToDirectProductLeftAdjunctMorphism`.
# DeclareOperation( "ExponentialToDirectProductLeftAdjunctionMap", [ IsObject ] );
# this comment stops AutoDoc from trying to parse the next line (which it can't at the moment)
DeclareSynonym( "ExponentialToDirectProductLeftAdjunctionMap", ExponentialToDirectProductLeftAdjunctMorphism );

#! @Description
#!  This is a synonym for `ExponentialToDirectProductLeftAdjunctMorphismWithGivenDirectProduct`.
# DeclareOperation( "ExponentialToDirectProductLeftAdjunctionMapWithGivenDirectProduct", [ IsObject ] );
# this comment stops AutoDoc from trying to parse the next line (which it can't at the moment)
DeclareSynonym( "ExponentialToDirectProductLeftAdjunctionMapWithGivenDirectProduct", ExponentialToDirectProductLeftAdjunctMorphismWithGivenDirectProduct );

#! @Description
#!  This is a synonym for `CoproductToCoexponentialLeftAdjunctMorphism`.
# DeclareOperation( "CoproductToCoexponentialLeftAdjunctionMap", [ IsObject ] );
# this comment stops AutoDoc from trying to parse the next line (which it can't at the moment)
DeclareSynonym( "CoproductToCoexponentialLeftAdjunctionMap", CoproductToCoexponentialLeftAdjunctMorphism );

#! @Description
#!  This is a synonym for `CoproductToCoexponentialLeftAdjunctMorphismWithGivenCoexponential`.
# DeclareOperation( "CoproductToCoexponentialLeftAdjunctionMapWithGivenCoexponential", [ IsObject ] );
# this comment stops AutoDoc from trying to parse the next line (which it can't at the moment)
DeclareSynonym( "CoproductToCoexponentialLeftAdjunctionMapWithGivenCoexponential", CoproductToCoexponentialLeftAdjunctMorphismWithGivenCoexponential );

#! @Description
#!  This is a synonym for `DirectProductToExponentialLeftAdjunctMorphism`.
# DeclareOperation( "DirectProductToExponentialLeftAdjunctionMap", [ IsObject ] );
# this comment stops AutoDoc from trying to parse the next line (which it can't at the moment)
DeclareSynonym( "DirectProductToExponentialLeftAdjunctionMap", DirectProductToExponentialLeftAdjunctMorphism );

#! @Description
#!  This is a synonym for `DirectProductToExponentialLeftAdjunctMorphismWithGivenExponential`.
# DeclareOperation( "DirectProductToExponentialLeftAdjunctionMapWithGivenExponential", [ IsObject ] );
# this comment stops AutoDoc from trying to parse the next line (which it can't at the moment)
DeclareSynonym( "DirectProductToExponentialLeftAdjunctionMapWithGivenExponential", DirectProductToExponentialLeftAdjunctMorphismWithGivenExponential );

#! @Description
#!  This is a synonym for `AddCoexponentialToCoproductLeftAdjunctMorphism`.
# DeclareOperation( "AddCoexponentialToCoproductLeftAdjunctionMap", [ IsObject ] );
# this comment stops AutoDoc from trying to parse the next line (which it can't at the moment)
DeclareSynonym( "AddCoexponentialToCoproductLeftAdjunctionMap", AddCoexponentialToCoproductLeftAdjunctMorphism );

#! @Description
#!  This is a synonym for `AddCoexponentialToCoproductLeftAdjunctMorphismWithGivenCoproduct`.
# DeclareOperation( "AddCoexponentialToCoproductLeftAdjunctionMapWithGivenCoproduct", [ IsObject ] );
# this comment stops AutoDoc from trying to parse the next line (which it can't at the moment)
DeclareSynonym( "AddCoexponentialToCoproductLeftAdjunctionMapWithGivenCoproduct", AddCoexponentialToCoproductLeftAdjunctMorphismWithGivenCoproduct );

#! @Description
#!  This is a synonym for `AddExponentialToDirectProductLeftAdjunctMorphism`.
# DeclareOperation( "AddExponentialToDirectProductLeftAdjunctionMap", [ IsObject ] );
# this comment stops AutoDoc from trying to parse the next line (which it can't at the moment)
DeclareSynonym( "AddExponentialToDirectProductLeftAdjunctionMap", AddExponentialToDirectProductLeftAdjunctMorphism );

#! @Description
#!  This is a synonym for `AddExponentialToDirectProductLeftAdjunctMorphismWithGivenDirectProduct`.
# DeclareOperation( "AddExponentialToDirectProductLeftAdjunctionMapWithGivenDirectProduct", [ IsObject ] );
# this comment stops AutoDoc from trying to parse the next line (which it can't at the moment)
DeclareSynonym( "AddExponentialToDirectProductLeftAdjunctionMapWithGivenDirectProduct", AddExponentialToDirectProductLeftAdjunctMorphismWithGivenDirectProduct );

#! @Description
#!  This is a synonym for `AddCoproductToCoexponentialLeftAdjunctMorphism`.
# DeclareOperation( "AddCoproductToCoexponentialLeftAdjunctionMap", [ IsObject ] );
# this comment stops AutoDoc from trying to parse the next line (which it can't at the moment)
DeclareSynonym( "AddCoproductToCoexponentialLeftAdjunctionMap", AddCoproductToCoexponentialLeftAdjunctMorphism );

#! @Description
#!  This is a synonym for `AddCoproductToCoexponentialLeftAdjunctMorphismWithGivenCoexponential`.
# DeclareOperation( "AddCoproductToCoexponentialLeftAdjunctionMapWithGivenCoexponential", [ IsObject ] );
# this comment stops AutoDoc from trying to parse the next line (which it can't at the moment)
DeclareSynonym( "AddCoproductToCoexponentialLeftAdjunctionMapWithGivenCoexponential", AddCoproductToCoexponentialLeftAdjunctMorphismWithGivenCoexponential );

#! @Description
#!  This is a synonym for `AddDirectProductToExponentialLeftAdjunctMorphism`.
# DeclareOperation( "AddDirectProductToExponentialLeftAdjunctionMap", [ IsObject ] );
# this comment stops AutoDoc from trying to parse the next line (which it can't at the moment)
DeclareSynonym( "AddDirectProductToExponentialLeftAdjunctionMap", AddDirectProductToExponentialLeftAdjunctMorphism );

#! @Description
#!  This is a synonym for `AddDirectProductToExponentialLeftAdjunctMorphismWithGivenExponential`.
# DeclareOperation( "AddDirectProductToExponentialLeftAdjunctionMapWithGivenExponential", [ IsObject ] );
# this comment stops AutoDoc from trying to parse the next line (which it can't at the moment)
DeclareSynonym( "AddDirectProductToExponentialLeftAdjunctionMapWithGivenExponential", AddDirectProductToExponentialLeftAdjunctMorphismWithGivenExponential );
