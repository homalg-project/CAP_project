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
#!  This is a synonym for `CoclosedMonoidalLeftCoevaluationMorphism`.
# DeclareOperation( "CoclosedCoevaluationMorphism", [ IsObject ] );
# this comment stops AutoDoc from trying to parse the next line (which it can't at the moment)
DeclareSynonym( "CoclosedCoevaluationMorphism", CoclosedMonoidalLeftCoevaluationMorphism );

#! @Description
#!  This is a synonym for `CoclosedMonoidalLeftCoevaluationMorphismWithGivenSource`.
# DeclareOperation( "CoclosedCoevaluationMorphismWithGivenSource", [ IsObject ] );
# this comment stops AutoDoc from trying to parse the next line (which it can't at the moment)
DeclareSynonym( "CoclosedCoevaluationMorphismWithGivenSource", CoclosedMonoidalLeftCoevaluationMorphismWithGivenSource );

#! @Description
#!  This is a synonym for `CoclosedMonoidalLeftEvaluationMorphism`.
# DeclareOperation( "CoclosedEvaluationMorphism", [ IsObject ] );
# this comment stops AutoDoc from trying to parse the next line (which it can't at the moment)
DeclareSynonym( "CoclosedEvaluationMorphism", CoclosedMonoidalLeftEvaluationMorphism );

#! @Description
#!  This is a synonym for `CoclosedMonoidalLeftEvaluationMorphismWithGivenRange`.
# DeclareOperation( "CoclosedEvaluationMorphismWithGivenRange", [ IsObject ] );
# this comment stops AutoDoc from trying to parse the next line (which it can't at the moment)
DeclareSynonym( "CoclosedEvaluationMorphismWithGivenRange", CoclosedMonoidalLeftEvaluationMorphismWithGivenRange );

#! @Description
#!  This is a synonym for `ClosedMonoidalLeftCoevaluationMorphism`.
# DeclareOperation( "CoevaluationMorphism", [ IsObject ] );
# this comment stops AutoDoc from trying to parse the next line (which it can't at the moment)
DeclareSynonym( "CoevaluationMorphism", ClosedMonoidalLeftCoevaluationMorphism );

#! @Description
#!  This is a synonym for `ClosedMonoidalLeftCoevaluationMorphismWithGivenRange`.
# DeclareOperation( "CoevaluationMorphismWithGivenRange", [ IsObject ] );
# this comment stops AutoDoc from trying to parse the next line (which it can't at the moment)
DeclareSynonym( "CoevaluationMorphismWithGivenRange", ClosedMonoidalLeftCoevaluationMorphismWithGivenRange );

#! @Description
#!  This is a synonym for `ClosedMonoidalLeftEvaluationMorphism`.
# DeclareOperation( "EvaluationMorphism", [ IsObject ] );
# this comment stops AutoDoc from trying to parse the next line (which it can't at the moment)
DeclareSynonym( "EvaluationMorphism", ClosedMonoidalLeftEvaluationMorphism );

#! @Description
#!  This is a synonym for `ClosedMonoidalLeftEvaluationMorphismWithGivenSource`.
# DeclareOperation( "EvaluationMorphismWithGivenSource", [ IsObject ] );
# this comment stops AutoDoc from trying to parse the next line (which it can't at the moment)
DeclareSynonym( "EvaluationMorphismWithGivenSource", ClosedMonoidalLeftEvaluationMorphismWithGivenSource );

#! @Description
#!  This is a synonym for `InternalCoHomToTensorProductLeftAdjunctionMap`.
# DeclareOperation( "InternalCoHomToTensorProductAdjunctionMap", [ IsObject ] );
# this comment stops AutoDoc from trying to parse the next line (which it can't at the moment)
DeclareSynonym( "InternalCoHomToTensorProductAdjunctionMap", InternalCoHomToTensorProductLeftAdjunctionMap );

#! @Description
#!  This is a synonym for `InternalCoHomToTensorProductLeftAdjunctionMapWithGivenTensorProduct`.
# DeclareOperation( "InternalCoHomToTensorProductAdjunctionMapWithGivenTensorProduct", [ IsObject ] );
# this comment stops AutoDoc from trying to parse the next line (which it can't at the moment)
DeclareSynonym( "InternalCoHomToTensorProductAdjunctionMapWithGivenTensorProduct", InternalCoHomToTensorProductLeftAdjunctionMapWithGivenTensorProduct );

#! @Description
#!  This is a synonym for `InternalHomToTensorProductLeftAdjunctionMap`.
# DeclareOperation( "InternalHomToTensorProductAdjunctionMap", [ IsObject ] );
# this comment stops AutoDoc from trying to parse the next line (which it can't at the moment)
DeclareSynonym( "InternalHomToTensorProductAdjunctionMap", InternalHomToTensorProductLeftAdjunctionMap );

#! @Description
#!  This is a synonym for `InternalHomToTensorProductLeftAdjunctionMapWithGivenTensorProduct`.
# DeclareOperation( "InternalHomToTensorProductAdjunctionMapWithGivenTensorProduct", [ IsObject ] );
# this comment stops AutoDoc from trying to parse the next line (which it can't at the moment)
DeclareSynonym( "InternalHomToTensorProductAdjunctionMapWithGivenTensorProduct", InternalHomToTensorProductLeftAdjunctionMapWithGivenTensorProduct );

#! @Description
#!  This is a synonym for `TensorProductToInternalCoHomLeftAdjunctionMap`.
# DeclareOperation( "TensorProductToInternalCoHomAdjunctionMap", [ IsObject ] );
# this comment stops AutoDoc from trying to parse the next line (which it can't at the moment)
DeclareSynonym( "TensorProductToInternalCoHomAdjunctionMap", TensorProductToInternalCoHomLeftAdjunctionMap );

#! @Description
#!  This is a synonym for `TensorProductToInternalCoHomLeftAdjunctionMapWithGivenInternalCoHom`.
# DeclareOperation( "TensorProductToInternalCoHomAdjunctionMapWithGivenInternalCoHom", [ IsObject ] );
# this comment stops AutoDoc from trying to parse the next line (which it can't at the moment)
DeclareSynonym( "TensorProductToInternalCoHomAdjunctionMapWithGivenInternalCoHom", TensorProductToInternalCoHomLeftAdjunctionMapWithGivenInternalCoHom );

#! @Description
#!  This is a synonym for `TensorProductToInternalHomLeftAdjunctionMap`.
# DeclareOperation( "TensorProductToInternalHomAdjunctionMap", [ IsObject ] );
# this comment stops AutoDoc from trying to parse the next line (which it can't at the moment)
DeclareSynonym( "TensorProductToInternalHomAdjunctionMap", TensorProductToInternalHomLeftAdjunctionMap );

#! @Description
#!  This is a synonym for `TensorProductToInternalHomLeftAdjunctionMapWithGivenInternalHom`.
# DeclareOperation( "TensorProductToInternalHomAdjunctionMapWithGivenInternalHom", [ IsObject ] );
# this comment stops AutoDoc from trying to parse the next line (which it can't at the moment)
DeclareSynonym( "TensorProductToInternalHomAdjunctionMapWithGivenInternalHom", TensorProductToInternalHomLeftAdjunctionMapWithGivenInternalHom );

# =#
