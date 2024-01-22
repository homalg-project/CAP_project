# SPDX-License-Identifier: GPL-2.0-or-later
# MonoidalCategories: Monoidal and monoidal (co)closed categories
#
# Declarations
#

####################################
##
#! @Chapter Synonyms
##
#! @Section Synonyms
##
####################################

#= comment for Julia

#! @Description
#!  This is a synonym for `CocartesianLeftCoevaluationMorphism`.
# DeclareOperation( "CocartesianCoevaluationMorphism", [ IsObject ] );
# this comment stops AutoDoc from trying to parse the next line (which it can't at the moment)
DeclareSynonym( "CocartesianCoevaluationMorphism", CocartesianLeftCoevaluationMorphism );

#! @Description
#!  This is a synonym for `CocartesianLeftCoevaluationMorphismWithGivenSource`.
# DeclareOperation( "CocartesianCoevaluationMorphismWithGivenSource", [ IsObject ] );
# this comment stops AutoDoc from trying to parse the next line (which it can't at the moment)
DeclareSynonym( "CocartesianCoevaluationMorphismWithGivenSource", CocartesianLeftCoevaluationMorphismWithGivenSource );

#! @Description
#!  This is a synonym for `CocartesianLeftEvaluationMorphism`.
# DeclareOperation( "CocartesianEvaluationMorphism", [ IsObject ] );
# this comment stops AutoDoc from trying to parse the next line (which it can't at the moment)
DeclareSynonym( "CocartesianEvaluationMorphism", CocartesianLeftEvaluationMorphism );

#! @Description
#!  This is a synonym for `CocartesianLeftEvaluationMorphismWithGivenRange`.
# DeclareOperation( "CocartesianEvaluationMorphismWithGivenRange", [ IsObject ] );
# this comment stops AutoDoc from trying to parse the next line (which it can't at the moment)
DeclareSynonym( "CocartesianEvaluationMorphismWithGivenRange", CocartesianLeftEvaluationMorphismWithGivenRange );

#! @Description
#!  This is a synonym for `CartesianLeftCoevaluationMorphism`.
# DeclareOperation( "CartesianCoevaluationMorphism", [ IsObject ] );
# this comment stops AutoDoc from trying to parse the next line (which it can't at the moment)
DeclareSynonym( "CartesianCoevaluationMorphism", CartesianLeftCoevaluationMorphism );

#! @Description
#!  This is a synonym for `CartesianLeftCoevaluationMorphismWithGivenRange`.
# DeclareOperation( "CartesianCoevaluationMorphismWithGivenRange", [ IsObject ] );
# this comment stops AutoDoc from trying to parse the next line (which it can't at the moment)
DeclareSynonym( "CartesianCoevaluationMorphismWithGivenRange", CartesianLeftCoevaluationMorphismWithGivenRange );

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
#!  This is a synonym for `AddCocartesianLeftCoevaluationMorphism`
# DeclareOperation( "AddCocartesianCoevaluationMorphism", [ IsObject ] );
# this comment stops AutoDoc from trying to parse the next line (which it can't at the moment)
DeclareSynonym( "AddCocartesianCoevaluationMorphism", AddCocartesianLeftCoevaluationMorphism );

#! @Description
#!  This is a synonym for `AddCocartesianLeftCoevaluationMorphismWithGivenSource`
# DeclareOperation( "AddCocartesianCoevaluationMorphismWithGivenSource", [ IsObject ] );
# this comment stops AutoDoc from trying to parse the next line (which it can't at the moment)
DeclareSynonym( "AddCocartesianCoevaluationMorphismWithGivenSource", AddCocartesianLeftCoevaluationMorphismWithGivenSource );

#! @Description
#!  This is a synonym for `AddCocartesianLeftEvaluationMorphism`
# DeclareOperation( "AddCocartesianEvaluationMorphism", [ IsObject ] );
# this comment stops AutoDoc from trying to parse the next line (which it can't at the moment)
DeclareSynonym( "AddCocartesianEvaluationMorphism", AddCocartesianLeftEvaluationMorphism );

#! @Description
#!  This is a synonym for `AddCocartesianLeftEvaluationMorphismWithGivenRange`
# DeclareOperation( "AddCocartesianEvaluationMorphismWithGivenRange", [ IsObject ] );
# this comment stops AutoDoc from trying to parse the next line (which it can't at the moment)
DeclareSynonym( "AddCocartesianEvaluationMorphismWithGivenRange", AddCocartesianLeftEvaluationMorphismWithGivenRange );

#! @Description
#!  This is a synonym for `AddCartesianLeftCoevaluationMorphism`
# DeclareOperation( "AddCartesianCoevaluationMorphism", [ IsObject ] );
# this comment stops AutoDoc from trying to parse the next line (which it can't at the moment)
DeclareSynonym( "AddCartesianCoevaluationMorphism", AddCartesianLeftCoevaluationMorphism );

#! @Description
#!  This is a synonym for `AddCartesianLeftCoevaluationMorphismWithGivenRange`
# DeclareOperation( "AddCartesianCoevaluationMorphismWithGivenRange", [ IsObject ] );
# this comment stops AutoDoc from trying to parse the next line (which it can't at the moment)
DeclareSynonym( "AddCartesianCoevaluationMorphismWithGivenRange", AddCartesianLeftCoevaluationMorphismWithGivenRange );

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

# =#
