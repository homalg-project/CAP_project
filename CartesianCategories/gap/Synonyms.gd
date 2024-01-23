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
#!  This is a synonym for `CoexponentialToCoproductLeftAdjunctionMap`.
# DeclareOperation( "CoexponentialToCoproductAdjunctionMap", [ IsObject ] );
# this comment stops AutoDoc from trying to parse the next line (which it can't at the moment)
DeclareSynonym( "CoexponentialToCoproductAdjunctionMap", CoexponentialToCoproductLeftAdjunctionMap );

#! @Description
#!  This is a synonym for `CoexponentialToCoproductLeftAdjunctionMapWithGivenCoproduct`.
# DeclareOperation( "CoexponentialToCoproductAdjunctionMapWithGivenCoproduct", [ IsObject ] );
# this comment stops AutoDoc from trying to parse the next line (which it can't at the moment)
DeclareSynonym( "CoexponentialToCoproductAdjunctionMapWithGivenCoproduct", CoexponentialToCoproductLeftAdjunctionMapWithGivenCoproduct );

#! @Description
#!  This is a synonym for `ExponentialToDirectProductLeftAdjunctionMap`.
# DeclareOperation( "ExponentialToDirectProductAdjunctionMap", [ IsObject ] );
# this comment stops AutoDoc from trying to parse the next line (which it can't at the moment)
DeclareSynonym( "ExponentialToDirectProductAdjunctionMap", ExponentialToDirectProductLeftAdjunctionMap );

#! @Description
#!  This is a synonym for `ExponentialToDirectProductLeftAdjunctionMapWithGivenDirectProduct`.
# DeclareOperation( "ExponentialToDirectProductAdjunctionMapWithGivenDirectProduct", [ IsObject ] );
# this comment stops AutoDoc from trying to parse the next line (which it can't at the moment)
DeclareSynonym( "ExponentialToDirectProductAdjunctionMapWithGivenDirectProduct", ExponentialToDirectProductLeftAdjunctionMapWithGivenDirectProduct );

#! @Description
#!  This is a synonym for `CoproductToCoexponentialLeftAdjunctionMap`.
# DeclareOperation( "CoproductToCoexponentialAdjunctionMap", [ IsObject ] );
# this comment stops AutoDoc from trying to parse the next line (which it can't at the moment)
DeclareSynonym( "CoproductToCoexponentialAdjunctionMap", CoproductToCoexponentialLeftAdjunctionMap );

#! @Description
#!  This is a synonym for `CoproductToCoexponentialLeftAdjunctionMapWithGivenCoexponential`.
# DeclareOperation( "CoproductToCoexponentialAdjunctionMapWithGivenCoexponential", [ IsObject ] );
# this comment stops AutoDoc from trying to parse the next line (which it can't at the moment)
DeclareSynonym( "CoproductToCoexponentialAdjunctionMapWithGivenCoexponential", CoproductToCoexponentialLeftAdjunctionMapWithGivenCoexponential );

#! @Description
#!  This is a synonym for `DirectProductToExponentialLeftAdjunctionMap`.
# DeclareOperation( "DirectProductToExponentialAdjunctionMap", [ IsObject ] );
# this comment stops AutoDoc from trying to parse the next line (which it can't at the moment)
DeclareSynonym( "DirectProductToExponentialAdjunctionMap", DirectProductToExponentialLeftAdjunctionMap );

#! @Description
#!  This is a synonym for `DirectProductToExponentialLeftAdjunctionMapWithGivenExponential`.
# DeclareOperation( "DirectProductToExponentialAdjunctionMapWithGivenExponential", [ IsObject ] );
# this comment stops AutoDoc from trying to parse the next line (which it can't at the moment)
DeclareSynonym( "DirectProductToExponentialAdjunctionMapWithGivenExponential", DirectProductToExponentialLeftAdjunctionMapWithGivenExponential );

##
## Add-methods
##

#! @Description
#!  This is a synonym for `AddCartesianLeftEvaluationMorphism`
# DeclareOperation( "AddCartesianEvaluationMorphism", [ IsObject ] );
# this comment stops AutoDoc from trying to parse the next line (which it can't at the moment)
DeclareSynonym( "AddCartesianEvaluationMorphism", AddCartesianLeftEvaluationMorphism );

#! @Description
#!  This is a synonym for `AddCartesianLeftEvaluationMorphismWithGivenSource`
# DeclareOperation( "AddCartesianEvaluationMorphismWithGivenSource", [ IsObject ] );
# this comment stops AutoDoc from trying to parse the next line (which it can't at the moment)
DeclareSynonym( "AddCartesianEvaluationMorphismWithGivenSource", AddCartesianLeftEvaluationMorphismWithGivenSource );

#! @Description
#!  This is a synonym for `AddCoexponentialToCoproductLeftAdjunctionMap`
# DeclareOperation( "AddCoexponentialToCoproductAdjunctionMap", [ IsObject ] );
# this comment stops AutoDoc from trying to parse the next line (which it can't at the moment)
DeclareSynonym( "AddCoexponentialToCoproductAdjunctionMap", AddCoexponentialToCoproductLeftAdjunctionMap );

#! @Description
#!  This is a synonym for `AddCoexponentialToCoproductLeftAdjunctionMapWithGivenCoproduct`
# DeclareOperation( "AddCoexponentialToCoproductAdjunctionMapWithGivenCoproduct", [ IsObject ] );
# this comment stops AutoDoc from trying to parse the next line (which it can't at the moment)
DeclareSynonym( "AddCoexponentialToCoproductAdjunctionMapWithGivenCoproduct", AddCoexponentialToCoproductLeftAdjunctionMapWithGivenCoproduct );

#! @Description
#!  This is a synonym for `AddExponentialToDirectProductLeftAdjunctionMap`
# DeclareOperation( "AddExponentialToDirectProductAdjunctionMap", [ IsObject ] );
# this comment stops AutoDoc from trying to parse the next line (which it can't at the moment)
DeclareSynonym( "AddExponentialToDirectProductAdjunctionMap", AddExponentialToDirectProductLeftAdjunctionMap );

#! @Description
#!  This is a synonym for `AddExponentialToDirectProductLeftAdjunctionMapWithGivenDirectProduct`
# DeclareOperation( "AddExponentialToDirectProductAdjunctionMapWithGivenDirectProduct", [ IsObject ] );
# this comment stops AutoDoc from trying to parse the next line (which it can't at the moment)
DeclareSynonym( "AddExponentialToDirectProductAdjunctionMapWithGivenDirectProduct", AddExponentialToDirectProductLeftAdjunctionMapWithGivenDirectProduct );

#! @Description
#!  This is a synonym for `AddCoproductToCoexponentialLeftAdjunctionMap`
# DeclareOperation( "AddCoproductToCoexponentialAdjunctionMap", [ IsObject ] );
# this comment stops AutoDoc from trying to parse the next line (which it can't at the moment)
DeclareSynonym( "AddCoproductToCoexponentialAdjunctionMap", AddCoproductToCoexponentialLeftAdjunctionMap );

#! @Description
#!  This is a synonym for `AddCoproductToCoexponentialLeftAdjunctionMapWithGivenCoexponential`
# DeclareOperation( "AddCoproductToCoexponentialAdjunctionMapWithGivenCoexponential", [ IsObject ] );
# this comment stops AutoDoc from trying to parse the next line (which it can't at the moment)
DeclareSynonym( "AddCoproductToCoexponentialAdjunctionMapWithGivenCoexponential", AddCoproductToCoexponentialLeftAdjunctionMapWithGivenCoexponential );

#! @Description
#!  This is a synonym for `AddDirectProductToExponentialLeftAdjunctionMap`
# DeclareOperation( "AddDirectProductToExponentialAdjunctionMap", [ IsObject ] );
# this comment stops AutoDoc from trying to parse the next line (which it can't at the moment)
DeclareSynonym( "AddDirectProductToExponentialAdjunctionMap", AddDirectProductToExponentialLeftAdjunctionMap );

#! @Description
#!  This is a synonym for `AddDirectProductToExponentialLeftAdjunctionMapWithGivenExponential`
# DeclareOperation( "AddDirectProductToExponentialAdjunctionMapWithGivenExponential", [ IsObject ] );
# this comment stops AutoDoc from trying to parse the next line (which it can't at the moment)
DeclareSynonym( "AddDirectProductToExponentialAdjunctionMapWithGivenExponential", AddDirectProductToExponentialLeftAdjunctionMapWithGivenExponential );
