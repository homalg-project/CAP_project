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
#!  This is a legacy operation for `CoclosedMonoidalLeftCoevaluationMorphism`( <A>b</A>, <A>a</A> ),
#!  i.e., with the first and second argument interchanged.
#! @Arguments a, b
DeclareOperation( "CoclosedCoevaluationMorphism", [ IsCapCategoryObject, IsCapCategoryObject ] );

#! @Description
#!  This is a legacy operation for `CoclosedMonoidalLeftCoevaluationMorphismWithGivenSource`( <A>b</A>, <A>a</A>, <A>s</A> ),
#!  i.e., with the first and second argument interchanged.
#! @Arguments a, b, s
DeclareOperation( "CoclosedCoevaluationMorphismWithGivenSource", [ IsCapCategoryObject, IsCapCategoryObject, IsCapCategoryObject ] );

#! @Description
#!  This is a legacy operation for `CoclosedMonoidalLeftEvaluationMorphism`( <A>b</A>, <A>a</A> ),
#!  i.e., with the first and second argument interchanged.
#! @Arguments a, b
DeclareOperation( "CoclosedEvaluationMorphism", [ IsCapCategoryObject, IsCapCategoryObject ] );

#! @Description
#!  This is a legacy operation for `CoclosedMonoidalLeftEvaluationMorphismWithGivenRange`( <A>b</A>, <A>a</A>, <A>r</A> ),
#!  i.e., with the first and second argument interchanged.
#! @Arguments a, b, r
DeclareOperation( "CoclosedEvaluationMorphismWithGivenRange", [ IsCapCategoryObject, IsCapCategoryObject, IsCapCategoryObject ] );

#! @Description
#!  This is a legacy operation for `ClosedMonoidalLeftCoevaluationMorphism`( <A>b</A>, <A>a</A> ),
#!  i.e., with the first and second argument interchanged.
#! @Arguments a, b
DeclareOperation( "CoevaluationMorphism", [ IsCapCategoryObject, IsCapCategoryObject ] );

#! @Description
#!  This is a legacy operation for `ClosedMonoidalLeftCoevaluationMorphismWithGivenRange`( <A>b</A>, <A>a</A>, <A>r</A> ),
#!  i.e., with the first and second argument interchanged.
#! @Arguments a, b, r
DeclareOperation( "CoevaluationMorphismWithGivenRange", [ IsCapCategoryObject, IsCapCategoryObject, IsCapCategoryObject ] );

####################################
##
#! @Section Synonyms for legacy operations
##
####################################

#! @Description
#!  This is a synonym for `ClosedMonoidalLeftEvaluationMorphism`.
# DeclareOperation( "EvaluationMorphism", [ IsCapCategoryObject, IsCapCategoryObject ] );
# this comment stops AutoDoc from trying to parse the next line (which it can't at the moment)
DeclareSynonym( "EvaluationMorphism", ClosedMonoidalLeftEvaluationMorphism );

#! @Description
#!  This is a synonym for `ClosedMonoidalLeftEvaluationMorphismWithGivenSource`.
# DeclareOperation( "EvaluationMorphismWithGivenSource", [ IsCapCategoryObject, IsCapCategoryObject, IsCapCategoryObject ] );
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
