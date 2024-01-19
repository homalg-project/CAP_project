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

#! @Description
#!  This is a synonym for `LeftInternalHom`.
DeclareOperation( "InternalHom",
                  [ IsCapCategoryCell, IsCapCategoryCell ] );

#! @Description
#!  This is a synonym for `LeftInternalCoHom`.
DeclareOperation( "InternalCoHom",
                  [ IsCapCategoryCell, IsCapCategoryCell ] );

#= comment for Julia

#! @Description
#!  This is a synonym for `LeftCoDualOnMorphisms`.
# DeclareOperation( "CoDualOnMorphisms", [ IsObject ] );
# this comment stops AutoDoc from trying to parse the next line (which it can't at the moment)
DeclareSynonym( "CoDualOnMorphisms", LeftCoDualOnMorphisms );

#! @Description
#!  This is a synonym for `LeftCoDualOnMorphismsWithGivenLeftCoDuals`.
# DeclareOperation( "CoDualOnMorphismsWithGivenCoDuals", [ IsObject ] );
# this comment stops AutoDoc from trying to parse the next line (which it can't at the moment)
DeclareSynonym( "CoDualOnMorphismsWithGivenCoDuals", LeftCoDualOnMorphismsWithGivenLeftCoDuals );

#! @Description
#!  This is a synonym for `LeftCoDualOnObjects`.
# DeclareOperation( "CoDualOnObjects", [ IsObject ] );
# this comment stops AutoDoc from trying to parse the next line (which it can't at the moment)
DeclareSynonym( "CoDualOnObjects", LeftCoDualOnObjects );

#! @Description
#!  This is a synonym for `LeftCoDualityTensorProductCompatibilityMorphism`.
# DeclareOperation( "CoDualityTensorProductCompatibilityMorphism", [ IsObject ] );
# this comment stops AutoDoc from trying to parse the next line (which it can't at the moment)
DeclareSynonym( "CoDualityTensorProductCompatibilityMorphism", LeftCoDualityTensorProductCompatibilityMorphism );

#! @Description
#!  This is a synonym for `LeftCoDualityTensorProductCompatibilityMorphismWithGivenObjects`.
# DeclareOperation( "CoDualityTensorProductCompatibilityMorphismWithGivenObjects", [ IsObject ] );
# this comment stops AutoDoc from trying to parse the next line (which it can't at the moment)
DeclareSynonym( "CoDualityTensorProductCompatibilityMorphismWithGivenObjects", LeftCoDualityTensorProductCompatibilityMorphismWithGivenObjects );

#! @Description
#!  This is a synonym for `LeftCoclosedMonoidalLambdaElimination`.
# DeclareOperation( "CoLambdaElimination", [ IsObject ] );
# this comment stops AutoDoc from trying to parse the next line (which it can't at the moment)
DeclareSynonym( "CoLambdaElimination", LeftCoclosedMonoidalLambdaElimination );

#! @Description
#!  This is a synonym for `LeftCoclosedMonoidalLambdaIntroduction`.
# DeclareOperation( "CoLambdaIntroduction", [ IsObject ] );
# this comment stops AutoDoc from trying to parse the next line (which it can't at the moment)
DeclareSynonym( "CoLambdaIntroduction", LeftCoclosedMonoidalLambdaIntroduction );

#! @Description
#!  This is a synonym for `LeftCoclosedMonoidalCoevaluationForLeftCoDual`.
# DeclareOperation( "CoclosedCoevaluationForCoDual", [ IsObject ] );
# this comment stops AutoDoc from trying to parse the next line (which it can't at the moment)
DeclareSynonym( "CoclosedCoevaluationForCoDual", LeftCoclosedMonoidalCoevaluationForLeftCoDual );

#! @Description
#!  This is a synonym for `LeftCoclosedMonoidalCoevaluationForLeftCoDualWithGivenTensorProduct`.
# DeclareOperation( "CoclosedCoevaluationForCoDualWithGivenTensorProduct", [ IsObject ] );
# this comment stops AutoDoc from trying to parse the next line (which it can't at the moment)
DeclareSynonym( "CoclosedCoevaluationForCoDualWithGivenTensorProduct", LeftCoclosedMonoidalCoevaluationForLeftCoDualWithGivenTensorProduct );

#! @Description
#!  This is a synonym for `LeftCoclosedMonoidalCoevaluationMorphism`.
# DeclareOperation( "CoclosedCoevaluationMorphism", [ IsObject ] );
# this comment stops AutoDoc from trying to parse the next line (which it can't at the moment)
DeclareSynonym( "CoclosedCoevaluationMorphism", LeftCoclosedMonoidalCoevaluationMorphism );

#! @Description
#!  This is a synonym for `LeftCoclosedMonoidalCoevaluationMorphismWithGivenSource`.
# DeclareOperation( "CoclosedCoevaluationMorphismWithGivenSource", [ IsObject ] );
# this comment stops AutoDoc from trying to parse the next line (which it can't at the moment)
DeclareSynonym( "CoclosedCoevaluationMorphismWithGivenSource", LeftCoclosedMonoidalCoevaluationMorphismWithGivenSource );

#! @Description
#!  This is a synonym for `LeftCoclosedMonoidalEvaluationForLeftCoDual`.
# DeclareOperation( "CoclosedEvaluationForCoDual", [ IsObject ] );
# this comment stops AutoDoc from trying to parse the next line (which it can't at the moment)
DeclareSynonym( "CoclosedEvaluationForCoDual", LeftCoclosedMonoidalEvaluationForLeftCoDual );

#! @Description
#!  This is a synonym for `LeftCoclosedMonoidalEvaluationForLeftCoDualWithGivenTensorProduct`.
# DeclareOperation( "CoclosedEvaluationForCoDualWithGivenTensorProduct", [ IsObject ] );
# this comment stops AutoDoc from trying to parse the next line (which it can't at the moment)
DeclareSynonym( "CoclosedEvaluationForCoDualWithGivenTensorProduct", LeftCoclosedMonoidalEvaluationForLeftCoDualWithGivenTensorProduct );

#! @Description
#!  This is a synonym for `LeftCoclosedMonoidalEvaluationMorphism`.
# DeclareOperation( "CoclosedEvaluationMorphism", [ IsObject ] );
# this comment stops AutoDoc from trying to parse the next line (which it can't at the moment)
DeclareSynonym( "CoclosedEvaluationMorphism", LeftCoclosedMonoidalEvaluationMorphism );

#! @Description
#!  This is a synonym for `LeftCoclosedMonoidalEvaluationMorphismWithGivenRange`.
# DeclareOperation( "CoclosedEvaluationMorphismWithGivenRange", [ IsObject ] );
# this comment stops AutoDoc from trying to parse the next line (which it can't at the moment)
DeclareSynonym( "CoclosedEvaluationMorphismWithGivenRange", LeftCoclosedMonoidalEvaluationMorphismWithGivenRange );

#! @Description
#!  This is a synonym for `CoevaluationForLeftDual`.
# DeclareOperation( "CoevaluationForDual", [ IsObject ] );
# this comment stops AutoDoc from trying to parse the next line (which it can't at the moment)
DeclareSynonym( "CoevaluationForDual", CoevaluationForLeftDual );

#! @Description
#!  This is a synonym for `CoevaluationForLeftDualWithGivenTensorProduct`.
# DeclareOperation( "CoevaluationForDualWithGivenTensorProduct", [ IsObject ] );
# this comment stops AutoDoc from trying to parse the next line (which it can't at the moment)
DeclareSynonym( "CoevaluationForDualWithGivenTensorProduct", CoevaluationForLeftDualWithGivenTensorProduct );

#! @Description
#!  This is a synonym for `LeftClosedMonoidalCoevaluationMorphism`.
# DeclareOperation( "CoevaluationMorphism", [ IsObject ] );
# this comment stops AutoDoc from trying to parse the next line (which it can't at the moment)
DeclareSynonym( "CoevaluationMorphism", LeftClosedMonoidalCoevaluationMorphism );

#! @Description
#!  This is a synonym for `LeftClosedMonoidalCoevaluationMorphismWithGivenRange`.
# DeclareOperation( "CoevaluationMorphismWithGivenRange", [ IsObject ] );
# this comment stops AutoDoc from trying to parse the next line (which it can't at the moment)
DeclareSynonym( "CoevaluationMorphismWithGivenRange", LeftClosedMonoidalCoevaluationMorphismWithGivenRange );

#! @Description
#!  This is a synonym for `LeftDualOnMorphisms`.
# DeclareOperation( "DualOnMorphisms", [ IsObject ] );
# this comment stops AutoDoc from trying to parse the next line (which it can't at the moment)
DeclareSynonym( "DualOnMorphisms", LeftDualOnMorphisms );

#! @Description
#!  This is a synonym for `LeftDualOnMorphismsWithGivenLeftDuals`.
# DeclareOperation( "DualOnMorphismsWithGivenDuals", [ IsObject ] );
# this comment stops AutoDoc from trying to parse the next line (which it can't at the moment)
DeclareSynonym( "DualOnMorphismsWithGivenDuals", LeftDualOnMorphismsWithGivenLeftDuals );

#! @Description
#!  This is a synonym for `LeftDualOnObjects`.
# DeclareOperation( "DualOnObjects", [ IsObject ] );
# this comment stops AutoDoc from trying to parse the next line (which it can't at the moment)
DeclareSynonym( "DualOnObjects", LeftDualOnObjects );

#! @Description
#!  This is a synonym for `LeftClosedMonoidalEvaluationForLeftDual`.
# DeclareOperation( "EvaluationForDual", [ IsObject ] );
# this comment stops AutoDoc from trying to parse the next line (which it can't at the moment)
DeclareSynonym( "EvaluationForDual", LeftClosedMonoidalEvaluationForLeftDual );

#! @Description
#!  This is a synonym for `LeftClosedMonoidalEvaluationForLeftDualWithGivenTensorProduct`.
# DeclareOperation( "EvaluationForDualWithGivenTensorProduct", [ IsObject ] );
# this comment stops AutoDoc from trying to parse the next line (which it can't at the moment)
DeclareSynonym( "EvaluationForDualWithGivenTensorProduct", LeftClosedMonoidalEvaluationForLeftDualWithGivenTensorProduct );

#! @Description
#!  This is a synonym for `LeftClosedMonoidalEvaluationMorphism`.
# DeclareOperation( "EvaluationMorphism", [ IsObject ] );
# this comment stops AutoDoc from trying to parse the next line (which it can't at the moment)
DeclareSynonym( "EvaluationMorphism", LeftClosedMonoidalEvaluationMorphism );

#! @Description
#!  This is a synonym for `LeftClosedMonoidalEvaluationMorphismWithGivenSource`.
# DeclareOperation( "EvaluationMorphismWithGivenSource", [ IsObject ] );
# this comment stops AutoDoc from trying to parse the next line (which it can't at the moment)
DeclareSynonym( "EvaluationMorphismWithGivenSource", LeftClosedMonoidalEvaluationMorphismWithGivenSource );

#! @Description
#!  This is a synonym for `LeftInternalCoHomOnMorphisms`.
# DeclareOperation( "InternalCoHomOnMorphisms", [ IsObject ] );
# this comment stops AutoDoc from trying to parse the next line (which it can't at the moment)
DeclareSynonym( "InternalCoHomOnMorphisms", LeftInternalCoHomOnMorphisms );

#! @Description
#!  This is a synonym for `LeftInternalCoHomOnMorphismsWithGivenLeftInternalCoHoms`.
# DeclareOperation( "InternalCoHomOnMorphismsWithGivenInternalCoHoms", [ IsObject ] );
# this comment stops AutoDoc from trying to parse the next line (which it can't at the moment)
DeclareSynonym( "InternalCoHomOnMorphismsWithGivenInternalCoHoms", LeftInternalCoHomOnMorphismsWithGivenLeftInternalCoHoms );

#! @Description
#!  This is a synonym for `LeftInternalCoHomOnObjects`.
# DeclareOperation( "InternalCoHomOnObjects", [ IsObject ] );
# this comment stops AutoDoc from trying to parse the next line (which it can't at the moment)
DeclareSynonym( "InternalCoHomOnObjects", LeftInternalCoHomOnObjects );

#! @Description
#!  This is a synonym for `LeftInternalCoHomTensorProductCompatibilityMorphism`.
# DeclareOperation( "InternalCoHomTensorProductCompatibilityMorphism", [ IsObject ] );
# this comment stops AutoDoc from trying to parse the next line (which it can't at the moment)
DeclareSynonym( "InternalCoHomTensorProductCompatibilityMorphism", LeftInternalCoHomTensorProductCompatibilityMorphism );

#! @Description
#!  This is a synonym for `LeftInternalCoHomTensorProductCompatibilityMorphismInverse`.
# DeclareOperation( "InternalCoHomTensorProductCompatibilityMorphismInverse", [ IsObject ] );
# this comment stops AutoDoc from trying to parse the next line (which it can't at the moment)
DeclareSynonym( "InternalCoHomTensorProductCompatibilityMorphismInverse", LeftInternalCoHomTensorProductCompatibilityMorphismInverse );

#! @Description
#!  This is a synonym for `LeftInternalCoHomTensorProductCompatibilityMorphismInverseWithGivenObjects`.
# DeclareOperation( "InternalCoHomTensorProductCompatibilityMorphismInverseWithGivenObjects", [ IsObject ] );
# this comment stops AutoDoc from trying to parse the next line (which it can't at the moment)
DeclareSynonym( "InternalCoHomTensorProductCompatibilityMorphismInverseWithGivenObjects", LeftInternalCoHomTensorProductCompatibilityMorphismInverseWithGivenObjects );

#! @Description
#!  This is a synonym for `LeftInternalCoHomTensorProductCompatibilityMorphismWithGivenObjects`.
# DeclareOperation( "InternalCoHomTensorProductCompatibilityMorphismWithGivenObjects", [ IsObject ] );
# this comment stops AutoDoc from trying to parse the next line (which it can't at the moment)
DeclareSynonym( "InternalCoHomTensorProductCompatibilityMorphismWithGivenObjects", LeftInternalCoHomTensorProductCompatibilityMorphismWithGivenObjects );

#! @Description
#!  This is a synonym for `LeftInternalCoHomToTensorProductAdjunctionMap`.
# DeclareOperation( "InternalCoHomToTensorProductAdjunctionMap", [ IsObject ] );
# this comment stops AutoDoc from trying to parse the next line (which it can't at the moment)
DeclareSynonym( "InternalCoHomToTensorProductAdjunctionMap", LeftInternalCoHomToTensorProductAdjunctionMap );

#! @Description
#!  This is a synonym for `LeftInternalCoHomToTensorProductAdjunctionMapWithGivenTensorProduct`.
# DeclareOperation( "InternalCoHomToTensorProductAdjunctionMapWithGivenTensorProduct", [ IsObject ] );
# this comment stops AutoDoc from trying to parse the next line (which it can't at the moment)
DeclareSynonym( "InternalCoHomToTensorProductAdjunctionMapWithGivenTensorProduct", LeftInternalCoHomToTensorProductAdjunctionMapWithGivenTensorProduct );

#! @Description
#!  This is a synonym for `LeftInternalHomOnMorphisms`.
# DeclareOperation( "InternalHomOnMorphisms", [ IsObject ] );
# this comment stops AutoDoc from trying to parse the next line (which it can't at the moment)
DeclareSynonym( "InternalHomOnMorphisms", LeftInternalHomOnMorphisms );

#! @Description
#!  This is a synonym for `LeftInternalHomOnMorphismsWithGivenLeftInternalHoms`.
# DeclareOperation( "InternalHomOnMorphismsWithGivenInternalHoms", [ IsObject ] );
# this comment stops AutoDoc from trying to parse the next line (which it can't at the moment)
DeclareSynonym( "InternalHomOnMorphismsWithGivenInternalHoms", LeftInternalHomOnMorphismsWithGivenLeftInternalHoms );

#! @Description
#!  This is a synonym for `LeftInternalHomOnObjects`.
# DeclareOperation( "InternalHomOnObjects", [ IsObject ] );
# this comment stops AutoDoc from trying to parse the next line (which it can't at the moment)
DeclareSynonym( "InternalHomOnObjects", LeftInternalHomOnObjects );

#! @Description
#!  This is a synonym for `LeftInternalHomToTensorProductAdjunctionMap`.
# DeclareOperation( "InternalHomToTensorProductAdjunctionMap", [ IsObject ] );
# this comment stops AutoDoc from trying to parse the next line (which it can't at the moment)
DeclareSynonym( "InternalHomToTensorProductAdjunctionMap", LeftInternalHomToTensorProductAdjunctionMap );

#! @Description
#!  This is a synonym for `LeftInternalHomToTensorProductAdjunctionMapWithGivenTensorProduct`.
# DeclareOperation( "InternalHomToTensorProductAdjunctionMapWithGivenTensorProduct", [ IsObject ] );
# this comment stops AutoDoc from trying to parse the next line (which it can't at the moment)
DeclareSynonym( "InternalHomToTensorProductAdjunctionMapWithGivenTensorProduct", LeftInternalHomToTensorProductAdjunctionMapWithGivenTensorProduct );

#! @Description
#!  This is a synonym for `IsomorphismFromLeftCoDualObjectToLeftInternalCoHomFromTensorUnit`.
# DeclareOperation( "IsomorphismFromCoDualObjectToInternalCoHomFromTensorUnit", [ IsObject ] );
# this comment stops AutoDoc from trying to parse the next line (which it can't at the moment)
DeclareSynonym( "IsomorphismFromCoDualObjectToInternalCoHomFromTensorUnit", IsomorphismFromLeftCoDualObjectToLeftInternalCoHomFromTensorUnit );

#! @Description
#!  This is a synonym for `IsomorphismFromLeftDualObjectToLeftInternalHomIntoTensorUnit`.
# DeclareOperation( "IsomorphismFromDualObjectToInternalHomIntoTensorUnit", [ IsObject ] );
# this comment stops AutoDoc from trying to parse the next line (which it can't at the moment)
DeclareSynonym( "IsomorphismFromDualObjectToInternalHomIntoTensorUnit", IsomorphismFromLeftDualObjectToLeftInternalHomIntoTensorUnit );

#! @Description
#!  This is a synonym for `IsomorphismFromLeftInternalCoHomFromTensorUnitToLeftCoDualObject`.
# DeclareOperation( "IsomorphismFromInternalCoHomFromTensorUnitToCoDualObject", [ IsObject ] );
# this comment stops AutoDoc from trying to parse the next line (which it can't at the moment)
DeclareSynonym( "IsomorphismFromInternalCoHomFromTensorUnitToCoDualObject", IsomorphismFromLeftInternalCoHomFromTensorUnitToLeftCoDualObject );

#! @Description
#!  This is a synonym for `IsomorphismFromLeftInternalCoHomToObject`.
# DeclareOperation( "IsomorphismFromInternalCoHomToObject", [ IsObject ] );
# this comment stops AutoDoc from trying to parse the next line (which it can't at the moment)
DeclareSynonym( "IsomorphismFromInternalCoHomToObject", IsomorphismFromLeftInternalCoHomToObject );

#! @Description
#!  This is a synonym for `IsomorphismFromLeftInternalCoHomToObjectWithGivenLeftInternalCoHom`.
# DeclareOperation( "IsomorphismFromInternalCoHomToObjectWithGivenInternalCoHom", [ IsObject ] );
# this comment stops AutoDoc from trying to parse the next line (which it can't at the moment)
DeclareSynonym( "IsomorphismFromInternalCoHomToObjectWithGivenInternalCoHom", IsomorphismFromLeftInternalCoHomToObjectWithGivenLeftInternalCoHom );

#! @Description
#!  This is a synonym for `IsomorphismFromLeftInternalCoHomToTensorProductWithLeftCoDualObject`.
# DeclareOperation( "IsomorphismFromInternalCoHomToTensorProductWithCoDualObject", [ IsObject ] );
# this comment stops AutoDoc from trying to parse the next line (which it can't at the moment)
DeclareSynonym( "IsomorphismFromInternalCoHomToTensorProductWithCoDualObject", IsomorphismFromLeftInternalCoHomToTensorProductWithLeftCoDualObject );

#! @Description
#!  This is a synonym for `IsomorphismFromLeftInternalHomIntoTensorUnitToLeftDualObject`.
# DeclareOperation( "IsomorphismFromInternalHomIntoTensorUnitToDualObject", [ IsObject ] );
# this comment stops AutoDoc from trying to parse the next line (which it can't at the moment)
DeclareSynonym( "IsomorphismFromInternalHomIntoTensorUnitToDualObject", IsomorphismFromLeftInternalHomIntoTensorUnitToLeftDualObject );

#! @Description
#!  This is a synonym for `IsomorphismFromLeftInternalHomToObject`.
# DeclareOperation( "IsomorphismFromInternalHomToObject", [ IsObject ] );
# this comment stops AutoDoc from trying to parse the next line (which it can't at the moment)
DeclareSynonym( "IsomorphismFromInternalHomToObject", IsomorphismFromLeftInternalHomToObject );

#! @Description
#!  This is a synonym for `IsomorphismFromLeftInternalHomToObjectWithGivenLeftInternalHom`.
# DeclareOperation( "IsomorphismFromInternalHomToObjectWithGivenInternalHom", [ IsObject ] );
# this comment stops AutoDoc from trying to parse the next line (which it can't at the moment)
DeclareSynonym( "IsomorphismFromInternalHomToObjectWithGivenInternalHom", IsomorphismFromLeftInternalHomToObjectWithGivenLeftInternalHom );

#! @Description
#!  This is a synonym for `IsomorphismFromLeftInternalHomToTensorProductWithLeftDualObject`.
# DeclareOperation( "IsomorphismFromInternalHomToTensorProductWithDualObject", [ IsObject ] );
# this comment stops AutoDoc from trying to parse the next line (which it can't at the moment)
DeclareSynonym( "IsomorphismFromInternalHomToTensorProductWithDualObject", IsomorphismFromLeftInternalHomToTensorProductWithLeftDualObject );

#! @Description
#!  This is a synonym for `IsomorphismFromObjectToLeftInternalCoHom`.
# DeclareOperation( "IsomorphismFromObjectToInternalCoHom", [ IsObject ] );
# this comment stops AutoDoc from trying to parse the next line (which it can't at the moment)
DeclareSynonym( "IsomorphismFromObjectToInternalCoHom", IsomorphismFromObjectToLeftInternalCoHom );

#! @Description
#!  This is a synonym for `IsomorphismFromObjectToLeftInternalCoHomWithGivenLeftInternalCoHom`.
# DeclareOperation( "IsomorphismFromObjectToInternalCoHomWithGivenInternalCoHom", [ IsObject ] );
# this comment stops AutoDoc from trying to parse the next line (which it can't at the moment)
DeclareSynonym( "IsomorphismFromObjectToInternalCoHomWithGivenInternalCoHom", IsomorphismFromObjectToLeftInternalCoHomWithGivenLeftInternalCoHom );

#! @Description
#!  This is a synonym for `IsomorphismFromObjectToLeftInternalHom`.
# DeclareOperation( "IsomorphismFromObjectToInternalHom", [ IsObject ] );
# this comment stops AutoDoc from trying to parse the next line (which it can't at the moment)
DeclareSynonym( "IsomorphismFromObjectToInternalHom", IsomorphismFromObjectToLeftInternalHom );

#! @Description
#!  This is a synonym for `IsomorphismFromObjectToLeftInternalHomWithGivenLeftInternalHom`.
# DeclareOperation( "IsomorphismFromObjectToInternalHomWithGivenInternalHom", [ IsObject ] );
# this comment stops AutoDoc from trying to parse the next line (which it can't at the moment)
DeclareSynonym( "IsomorphismFromObjectToInternalHomWithGivenInternalHom", IsomorphismFromObjectToLeftInternalHomWithGivenLeftInternalHom );

#! @Description
#!  This is a synonym for `IsomorphismFromTensorProductWithLeftCoDualObjectToLeftInternalCoHom`.
# DeclareOperation( "IsomorphismFromTensorProductWithCoDualObjectToInternalCoHom", [ IsObject ] );
# this comment stops AutoDoc from trying to parse the next line (which it can't at the moment)
DeclareSynonym( "IsomorphismFromTensorProductWithCoDualObjectToInternalCoHom", IsomorphismFromTensorProductWithLeftCoDualObjectToLeftInternalCoHom );

#! @Description
#!  This is a synonym for `IsomorphismFromTensorProductWithLeftDualObjectToLeftInternalHom`.
# DeclareOperation( "IsomorphismFromTensorProductWithDualObjectToInternalHom", [ IsObject ] );
# this comment stops AutoDoc from trying to parse the next line (which it can't at the moment)
DeclareSynonym( "IsomorphismFromTensorProductWithDualObjectToInternalHom", IsomorphismFromTensorProductWithLeftDualObjectToLeftInternalHom );

#! @Description
#!  This is a synonym for `LeftClosedMonoidalLambdaElimination`.
# DeclareOperation( "LambdaElimination", [ IsObject ] );
# this comment stops AutoDoc from trying to parse the next line (which it can't at the moment)
DeclareSynonym( "LambdaElimination", LeftClosedMonoidalLambdaElimination );

#! @Description
#!  This is a synonym for `LeftClosedMonoidalLambdaIntroduction`.
# DeclareOperation( "LambdaIntroduction", [ IsObject ] );
# this comment stops AutoDoc from trying to parse the next line (which it can't at the moment)
DeclareSynonym( "LambdaIntroduction", LeftClosedMonoidalLambdaIntroduction );

#! @Description
#!  This is a synonym for `LeftCoclosedMonoidalPostCoComposeMorphism`.
# DeclareOperation( "MonoidalPostCoComposeMorphism", [ IsObject ] );
# this comment stops AutoDoc from trying to parse the next line (which it can't at the moment)
DeclareSynonym( "MonoidalPostCoComposeMorphism", LeftCoclosedMonoidalPostCoComposeMorphism );

#! @Description
#!  This is a synonym for `LeftCoclosedMonoidalPostCoComposeMorphismWithGivenObjects`.
# DeclareOperation( "MonoidalPostCoComposeMorphismWithGivenObjects", [ IsObject ] );
# this comment stops AutoDoc from trying to parse the next line (which it can't at the moment)
DeclareSynonym( "MonoidalPostCoComposeMorphismWithGivenObjects", LeftCoclosedMonoidalPostCoComposeMorphismWithGivenObjects );

#! @Description
#!  This is a synonym for `LeftClosedMonoidalPostComposeMorphism`.
# DeclareOperation( "MonoidalPostComposeMorphism", [ IsObject ] );
# this comment stops AutoDoc from trying to parse the next line (which it can't at the moment)
DeclareSynonym( "MonoidalPostComposeMorphism", LeftClosedMonoidalPostComposeMorphism );

#! @Description
#!  This is a synonym for `LeftClosedMonoidalPostComposeMorphismWithGivenObjects`.
# DeclareOperation( "MonoidalPostComposeMorphismWithGivenObjects", [ IsObject ] );
# this comment stops AutoDoc from trying to parse the next line (which it can't at the moment)
DeclareSynonym( "MonoidalPostComposeMorphismWithGivenObjects", LeftClosedMonoidalPostComposeMorphismWithGivenObjects );

#! @Description
#!  This is a synonym for `LeftCoclosedMonoidalPreCoComposeMorphism`.
# DeclareOperation( "MonoidalPreCoComposeMorphism", [ IsObject ] );
# this comment stops AutoDoc from trying to parse the next line (which it can't at the moment)
DeclareSynonym( "MonoidalPreCoComposeMorphism", LeftCoclosedMonoidalPreCoComposeMorphism );

#! @Description
#!  This is a synonym for `LeftCoclosedMonoidalPreCoComposeMorphismWithGivenObjects`.
# DeclareOperation( "MonoidalPreCoComposeMorphismWithGivenObjects", [ IsObject ] );
# this comment stops AutoDoc from trying to parse the next line (which it can't at the moment)
DeclareSynonym( "MonoidalPreCoComposeMorphismWithGivenObjects", LeftCoclosedMonoidalPreCoComposeMorphismWithGivenObjects );

#! @Description
#!  This is a synonym for `LeftClosedMonoidalPreComposeMorphism`.
# DeclareOperation( "MonoidalPreComposeMorphism", [ IsObject ] );
# this comment stops AutoDoc from trying to parse the next line (which it can't at the moment)
DeclareSynonym( "MonoidalPreComposeMorphism", LeftClosedMonoidalPreComposeMorphism );

#! @Description
#!  This is a synonym for `LeftClosedMonoidalPreComposeMorphismWithGivenObjects`.
# DeclareOperation( "MonoidalPreComposeMorphismWithGivenObjects", [ IsObject ] );
# this comment stops AutoDoc from trying to parse the next line (which it can't at the moment)
DeclareSynonym( "MonoidalPreComposeMorphismWithGivenObjects", LeftClosedMonoidalPreComposeMorphismWithGivenObjects );

#! @Description
#!  This is a synonym for `MorphismFromLeftBidual`.
# DeclareOperation( "MorphismFromBidual", [ IsObject ] );
# this comment stops AutoDoc from trying to parse the next line (which it can't at the moment)
DeclareSynonym( "MorphismFromBidual", MorphismFromLeftBidual );

#! @Description
#!  This is a synonym for `MorphismFromLeftBidualWithGivenLeftBidual`.
# DeclareOperation( "MorphismFromBidualWithGivenBidual", [ IsObject ] );
# this comment stops AutoDoc from trying to parse the next line (which it can't at the moment)
DeclareSynonym( "MorphismFromBidualWithGivenBidual", MorphismFromLeftBidualWithGivenLeftBidual );

#! @Description
#!  This is a synonym for `MorphismFromLeftCoBidual`.
# DeclareOperation( "MorphismFromCoBidual", [ IsObject ] );
# this comment stops AutoDoc from trying to parse the next line (which it can't at the moment)
DeclareSynonym( "MorphismFromCoBidual", MorphismFromLeftCoBidual );

#! @Description
#!  This is a synonym for `MorphismFromLeftCoBidualWithGivenLeftCoBidual`.
# DeclareOperation( "MorphismFromCoBidualWithGivenCoBidual", [ IsObject ] );
# this comment stops AutoDoc from trying to parse the next line (which it can't at the moment)
DeclareSynonym( "MorphismFromCoBidualWithGivenCoBidual", MorphismFromLeftCoBidualWithGivenLeftCoBidual );

#! @Description
#!  This is a synonym for `MorphismFromLeftInternalCoHomToTensorProduct`.
# DeclareOperation( "MorphismFromInternalCoHomToTensorProduct", [ IsObject ] );
# this comment stops AutoDoc from trying to parse the next line (which it can't at the moment)
DeclareSynonym( "MorphismFromInternalCoHomToTensorProduct", MorphismFromLeftInternalCoHomToTensorProduct );

#! @Description
#!  This is a synonym for `MorphismFromLeftInternalCoHomToTensorProductWithGivenObjects`.
# DeclareOperation( "MorphismFromInternalCoHomToTensorProductWithGivenObjects", [ IsObject ] );
# this comment stops AutoDoc from trying to parse the next line (which it can't at the moment)
DeclareSynonym( "MorphismFromInternalCoHomToTensorProductWithGivenObjects", MorphismFromLeftInternalCoHomToTensorProductWithGivenObjects );

#! @Description
#!  This is a synonym for `MorphismFromLeftInternalHomToTensorProduct`.
# DeclareOperation( "MorphismFromInternalHomToTensorProduct", [ IsObject ] );
# this comment stops AutoDoc from trying to parse the next line (which it can't at the moment)
DeclareSynonym( "MorphismFromInternalHomToTensorProduct", MorphismFromLeftInternalHomToTensorProduct );

#! @Description
#!  This is a synonym for `MorphismFromLeftInternalHomToTensorProductWithGivenObjects`.
# DeclareOperation( "MorphismFromInternalHomToTensorProductWithGivenObjects", [ IsObject ] );
# this comment stops AutoDoc from trying to parse the next line (which it can't at the moment)
DeclareSynonym( "MorphismFromInternalHomToTensorProductWithGivenObjects", MorphismFromLeftInternalHomToTensorProductWithGivenObjects );

#! @Description
#!  This is a synonym for `MorphismFromTensorProductToLeftInternalCoHom`.
# DeclareOperation( "MorphismFromTensorProductToInternalCoHom", [ IsObject ] );
# this comment stops AutoDoc from trying to parse the next line (which it can't at the moment)
DeclareSynonym( "MorphismFromTensorProductToInternalCoHom", MorphismFromTensorProductToLeftInternalCoHom );

#! @Description
#!  This is a synonym for `MorphismFromTensorProductToLeftInternalCoHomWithGivenObjects`.
# DeclareOperation( "MorphismFromTensorProductToInternalCoHomWithGivenObjects", [ IsObject ] );
# this comment stops AutoDoc from trying to parse the next line (which it can't at the moment)
DeclareSynonym( "MorphismFromTensorProductToInternalCoHomWithGivenObjects", MorphismFromTensorProductToLeftInternalCoHomWithGivenObjects );

#! @Description
#!  This is a synonym for `MorphismFromTensorProductToLeftInternalHom`.
# DeclareOperation( "MorphismFromTensorProductToInternalHom", [ IsObject ] );
# this comment stops AutoDoc from trying to parse the next line (which it can't at the moment)
DeclareSynonym( "MorphismFromTensorProductToInternalHom", MorphismFromTensorProductToLeftInternalHom );

#! @Description
#!  This is a synonym for `MorphismFromTensorProductToLeftInternalHomWithGivenObjects`.
# DeclareOperation( "MorphismFromTensorProductToInternalHomWithGivenObjects", [ IsObject ] );
# this comment stops AutoDoc from trying to parse the next line (which it can't at the moment)
DeclareSynonym( "MorphismFromTensorProductToInternalHomWithGivenObjects", MorphismFromTensorProductToLeftInternalHomWithGivenObjects );

#! @Description
#!  This is a synonym for `MorphismToLeftBidual`.
# DeclareOperation( "MorphismToBidual", [ IsObject ] );
# this comment stops AutoDoc from trying to parse the next line (which it can't at the moment)
DeclareSynonym( "MorphismToBidual", MorphismToLeftBidual );

#! @Description
#!  This is a synonym for `MorphismToLeftBidualWithGivenLeftBidual`.
# DeclareOperation( "MorphismToBidualWithGivenBidual", [ IsObject ] );
# this comment stops AutoDoc from trying to parse the next line (which it can't at the moment)
DeclareSynonym( "MorphismToBidualWithGivenBidual", MorphismToLeftBidualWithGivenLeftBidual );

#! @Description
#!  This is a synonym for `MorphismToLeftCoBidual`.
# DeclareOperation( "MorphismToCoBidual", [ IsObject ] );
# this comment stops AutoDoc from trying to parse the next line (which it can't at the moment)
DeclareSynonym( "MorphismToCoBidual", MorphismToLeftCoBidual );

#! @Description
#!  This is a synonym for `MorphismToLeftCoBidualWithGivenLeftCoBidual`.
# DeclareOperation( "MorphismToCoBidualWithGivenCoBidual", [ IsObject ] );
# this comment stops AutoDoc from trying to parse the next line (which it can't at the moment)
DeclareSynonym( "MorphismToCoBidualWithGivenCoBidual", MorphismToLeftCoBidualWithGivenLeftCoBidual );

#! @Description
#!  This is a synonym for `TensorProductLeftDualityCompatibilityMorphism`.
# DeclareOperation( "TensorProductDualityCompatibilityMorphism", [ IsObject ] );
# this comment stops AutoDoc from trying to parse the next line (which it can't at the moment)
DeclareSynonym( "TensorProductDualityCompatibilityMorphism", TensorProductLeftDualityCompatibilityMorphism );

#! @Description
#!  This is a synonym for `TensorProductLeftDualityCompatibilityMorphismWithGivenObjects`.
# DeclareOperation( "TensorProductDualityCompatibilityMorphismWithGivenObjects", [ IsObject ] );
# this comment stops AutoDoc from trying to parse the next line (which it can't at the moment)
DeclareSynonym( "TensorProductDualityCompatibilityMorphismWithGivenObjects", TensorProductLeftDualityCompatibilityMorphismWithGivenObjects );

#! @Description
#!  This is a synonym for `TensorProductLeftInternalHomCompatibilityMorphism`.
# DeclareOperation( "TensorProductInternalHomCompatibilityMorphism", [ IsObject ] );
# this comment stops AutoDoc from trying to parse the next line (which it can't at the moment)
DeclareSynonym( "TensorProductInternalHomCompatibilityMorphism", TensorProductLeftInternalHomCompatibilityMorphism );

#! @Description
#!  This is a synonym for `TensorProductLeftInternalHomCompatibilityMorphismInverse`.
# DeclareOperation( "TensorProductInternalHomCompatibilityMorphismInverse", [ IsObject ] );
# this comment stops AutoDoc from trying to parse the next line (which it can't at the moment)
DeclareSynonym( "TensorProductInternalHomCompatibilityMorphismInverse", TensorProductLeftInternalHomCompatibilityMorphismInverse );

#! @Description
#!  This is a synonym for `TensorProductLeftInternalHomCompatibilityMorphismInverseWithGivenObjects`.
# DeclareOperation( "TensorProductInternalHomCompatibilityMorphismInverseWithGivenObjects", [ IsObject ] );
# this comment stops AutoDoc from trying to parse the next line (which it can't at the moment)
DeclareSynonym( "TensorProductInternalHomCompatibilityMorphismInverseWithGivenObjects", TensorProductLeftInternalHomCompatibilityMorphismInverseWithGivenObjects );

#! @Description
#!  This is a synonym for `TensorProductLeftInternalHomCompatibilityMorphismWithGivenObjects`.
# DeclareOperation( "TensorProductInternalHomCompatibilityMorphismWithGivenObjects", [ IsObject ] );
# this comment stops AutoDoc from trying to parse the next line (which it can't at the moment)
DeclareSynonym( "TensorProductInternalHomCompatibilityMorphismWithGivenObjects", TensorProductLeftInternalHomCompatibilityMorphismWithGivenObjects );

#! @Description
#!  This is a synonym for `TensorProductToLeftInternalCoHomAdjunctionMap`.
# DeclareOperation( "TensorProductToInternalCoHomAdjunctionMap", [ IsObject ] );
# this comment stops AutoDoc from trying to parse the next line (which it can't at the moment)
DeclareSynonym( "TensorProductToInternalCoHomAdjunctionMap", TensorProductToLeftInternalCoHomAdjunctionMap );

#! @Description
#!  This is a synonym for `TensorProductToLeftInternalCoHomAdjunctionMapWithGivenLeftInternalCoHom`.
# DeclareOperation( "TensorProductToInternalCoHomAdjunctionMapWithGivenInternalCoHom", [ IsObject ] );
# this comment stops AutoDoc from trying to parse the next line (which it can't at the moment)
DeclareSynonym( "TensorProductToInternalCoHomAdjunctionMapWithGivenInternalCoHom", TensorProductToLeftInternalCoHomAdjunctionMapWithGivenLeftInternalCoHom );

#! @Description
#!  This is a synonym for `TensorProductToLeftInternalHomAdjunctionMap`.
# DeclareOperation( "TensorProductToInternalHomAdjunctionMap", [ IsObject ] );
# this comment stops AutoDoc from trying to parse the next line (which it can't at the moment)
DeclareSynonym( "TensorProductToInternalHomAdjunctionMap", TensorProductToLeftInternalHomAdjunctionMap );

#! @Description
#!  This is a synonym for `TensorProductToLeftInternalHomAdjunctionMapWithGivenLeftInternalHom`.
# DeclareOperation( "TensorProductToInternalHomAdjunctionMapWithGivenInternalHom", [ IsObject ] );
# this comment stops AutoDoc from trying to parse the next line (which it can't at the moment)
DeclareSynonym( "TensorProductToInternalHomAdjunctionMapWithGivenInternalHom", TensorProductToLeftInternalHomAdjunctionMapWithGivenLeftInternalHom );

#! @Description
#!  This is a synonym for `UniversalPropertyOfLeftCoDual`.
# DeclareOperation( "UniversalPropertyOfCoDual", [ IsObject ] );
# this comment stops AutoDoc from trying to parse the next line (which it can't at the moment)
DeclareSynonym( "UniversalPropertyOfCoDual", UniversalPropertyOfLeftCoDual );

#! @Description
#!  This is a synonym for `UniversalPropertyOfLeftDual`.
# DeclareOperation( "UniversalPropertyOfDual", [ IsObject ] );
# this comment stops AutoDoc from trying to parse the next line (which it can't at the moment)
DeclareSynonym( "UniversalPropertyOfDual", UniversalPropertyOfLeftDual );

# =#
