####################################
##
#! @Chapter Monoidal Categories
##
#! @Section Rigid Symmetric Closed Monoidal Categories
##
####################################

DeclareGlobalVariable( "CAP_INTERNAL_RIGID_SYMMETRIC_CLOSED_MONOIDAL_CATEGORIES_BASIC_OPERATIONS" );
  
DeclareGlobalVariable( "RIGID_SYMMETRIC_CLOSED_MONOIDAL_CATEGORIES_METHOD_NAME_RECORD" );

##
#! @Description
#! The arguments are two objects $a,b$.
#! The output is the natural morphism $\mathrm{IsomorphismFromTensorProductToInternalHom}_{a,b}: a^{\vee} \otimes b \rightarrow \mathrm{\underline{Hom}}(a,b)$.
#! @Returns a morphism in $\mathrm{Hom}( a^{\vee} \otimes b, \mathrm{\underline{Hom}}(a,b) )$.
#! @Arguments a,b
DeclareOperation( "IsomorphismFromTensorProductToInternalHom",
                  [ IsCapCategoryObject, IsCapCategoryObject ] );

#! @Description
#! The arguments are a category $C$ and a function $F$.
#! This operation adds the given function $F$
#! to the category for the basic operation <C>IsomorphismFromTensorProductToInternalHom</C>.
#! $F: ( a, b ) \mapsto \mathrm{IsomorphismFromTensorProductToInternalHom}_{a,b}$.
#! @Returns nothing
#! @Arguments C, F
DeclareOperation( "AddIsomorphismFromTensorProductToInternalHom",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddIsomorphismFromTensorProductToInternalHom",
                  [ IsCapCategory, IsFunction, IsInt ] );

DeclareOperation( "AddIsomorphismFromTensorProductToInternalHom",
                  [ IsCapCategory, IsList, IsInt ] );

DeclareOperation( "AddIsomorphismFromTensorProductToInternalHom",
                  [ IsCapCategory, IsList ] );

##
#! @Description
#! The arguments are two objects $a,b$.
#! The output is the inverse of $\mathrm{MorphismFromTensorProductToInternalHomWithGivenObjects}$, namely
#! $\mathrm{MorphismFromInternalHomToTensorProductWithGivenObjects}_{a,b}: \mathrm{\underline{Hom}}(a,b) \rightarrow a^{\vee} \otimes b$.
#! @Returns a morphism in $\mathrm{Hom}( \mathrm{\underline{Hom}}(a,b), a^{\vee} \otimes b )$.
#! @Arguments a,b
DeclareOperation( "MorphismFromInternalHomToTensorProduct",
                  [ IsCapCategoryObject, IsCapCategoryObject ] );


#! @Description
#! The arguments are an object $s = \mathrm{\underline{Hom}}(a,b)$,
#! two objects $a,b$,
#! and an object $r = a^{\vee} \otimes b$.
#! The output is the inverse of $\mathrm{MorphismFromTensorProductToInternalHomWithGivenObjects}$, namely
#! $\mathrm{MorphismFromInternalHomToTensorProductWithGivenObjects}_{a,b}: \mathrm{\underline{Hom}}(a,b) \rightarrow a^{\vee} \otimes b$.
#! @Returns a morphism in $\mathrm{Hom}( \mathrm{\underline{Hom}}(a,b), a^{\vee} \otimes b )$.
#! @Arguments s,a,b,r
DeclareOperation( "MorphismFromInternalHomToTensorProductWithGivenObjects",
                  [ IsCapCategoryObject, IsCapCategoryObject, IsCapCategoryObject, IsCapCategoryObject ] );

#! @Description
#! The arguments are a category $C$ and a function $F$.
#! This operation adds the given function $F$
#! to the category for the basic operation <C>MorphismFromInternalHomToTensorProductWithGivenObjects</C>.
#! $F: ( \mathrm{\underline{Hom}}(a,b),a,b,a^{\vee} \otimes b ) \mapsto \mathrm{MorphismFromInternalHomToTensorProductWithGivenObjects}_{a,b}$.
#! @Returns nothing
#! @Arguments C, F
DeclareOperation( "AddMorphismFromInternalHomToTensorProductWithGivenObjects",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddMorphismFromInternalHomToTensorProductWithGivenObjects",
                  [ IsCapCategory, IsFunction, IsInt ] );

DeclareOperation( "AddMorphismFromInternalHomToTensorProductWithGivenObjects",
                  [ IsCapCategory, IsList, IsInt ] );

DeclareOperation( "AddMorphismFromInternalHomToTensorProductWithGivenObjects",
                  [ IsCapCategory, IsList ] );

##
#! @Description
#! The arguments are two objects $a,b$.
#! The output is the inverse of $\mathrm{IsomorphismFromTensorProductToInternalHom}$, namely
#! $\mathrm{IsomorphismFromInternalHomToTensorProduct}_{a,b}: \mathrm{\underline{Hom}}(a,b) \rightarrow a^{\vee} \otimes b$.
#! @Returns a morphism in $\mathrm{Hom}( \mathrm{\underline{Hom}}(a,b), a^{\vee} \otimes b )$.
#! @Arguments a,b
DeclareOperation( "IsomorphismFromInternalHomToTensorProduct",
                  [ IsCapCategoryObject, IsCapCategoryObject ] );

#! @Description
#! The arguments are a category $C$ and a function $F$.
#! This operation adds the given function $F$
#! to the category for the basic operation <C>IsomorphismFromInternalHomToTensorProduct</C>.
#! $F: ( a,b ) \mapsto \mathrm{IsomorphismFromInternalHomToTensorProduct}_{a,b}$.
#! @Returns nothing
#! @Arguments C, F
DeclareOperation( "AddIsomorphismFromInternalHomToTensorProduct",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddIsomorphismFromInternalHomToTensorProduct",
                  [ IsCapCategory, IsFunction, IsInt ] );

DeclareOperation( "AddIsomorphismFromInternalHomToTensorProduct",
                  [ IsCapCategory, IsList, IsInt ] );

DeclareOperation( "AddIsomorphismFromInternalHomToTensorProduct",
                  [ IsCapCategory, IsList ] );

##
#! @Description
#! The arguments are four objects $a, a', b, b'$.
#! The output is the natural morphism
#! $\mathrm{TensorProductInternalHomCompatibilityMorphismInverseWithGivenObjects}_{a,a',b,b'}: \mathrm{\underline{Hom}}(a \otimes b,a' \otimes b') \rightarrow \mathrm{\underline{Hom}}(a,a') \otimes \mathrm{\underline{Hom}}(b,b')$.
#! @Returns a morphism in $\mathrm{Hom}( \mathrm{\underline{Hom}}(a \otimes b,a' \otimes b'), \mathrm{\underline{Hom}}(a,a') \otimes \mathrm{\underline{Hom}}(b,b'))$.
#! @Arguments a,a',b,b'
DeclareOperation( "TensorProductInternalHomCompatibilityMorphismInverse",
                  [ IsCapCategoryObject, IsCapCategoryObject, IsCapCategoryObject, IsCapCategoryObject ] );

##
## The new_source and new_range arguments are the first and second element of the list.
## This construction is due to the fact that the maximal number of arguments for an operation is 6,
## but a basic operation with 6 arguments would install a setter having 7 arguments.
#! @Description
#! The arguments are four objects $a, a', b, b'$,
#! and a list $L = [ \mathrm{\underline{Hom}}(a,a') \otimes \mathrm{\underline{Hom}}(b,b'), \mathrm{\underline{Hom}}(a \otimes b,a' \otimes b') ]$.
#! The output is the natural morphism
#! $\mathrm{TensorProductInternalHomCompatibilityMorphismInverseWithGivenObjects}_{a,a',b,b'}: \mathrm{\underline{Hom}}(a \otimes b,a' \otimes b') \rightarrow \mathrm{\underline{Hom}}(a,a') \otimes \mathrm{\underline{Hom}}(b,b')$.
#! @Returns a morphism in $\mathrm{Hom}( \mathrm{\underline{Hom}}(a \otimes b,a' \otimes b'), \mathrm{\underline{Hom}}(a,a') \otimes \mathrm{\underline{Hom}}(b,b'))$.
#! @Arguments a,a',b,b',L
DeclareOperation( "TensorProductInternalHomCompatibilityMorphismInverseWithGivenObjects",
                  [ IsCapCategoryObject, IsCapCategoryObject, IsCapCategoryObject, IsCapCategoryObject, IsList ] );

#! @Description
#! The arguments are a category $C$ and a function $F$.
#! This operation adds the given function $F$
#! to the category for the basic operation <C>TensorProductInternalHomCompatibilityMorphismInverseWithGivenObjects</C>.
#! $F: ( a,a',b,b', [ \mathrm{\underline{Hom}}(a,a') \otimes \mathrm{\underline{Hom}}(b,b'), \mathrm{\underline{Hom}}(a \otimes b,a' \otimes b') ]) \mapsto \mathrm{TensorProductInternalHomCompatibilityMorphismInverseWithGivenObjects}_{a,a',b,b'}$.
#! @Returns nothing
#! @Arguments C, F
DeclareOperation( "AddTensorProductInternalHomCompatibilityMorphismInverseWithGivenObjects",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddTensorProductInternalHomCompatibilityMorphismInverseWithGivenObjects",
                  [ IsCapCategory, IsFunction, IsInt ] );

DeclareOperation( "AddTensorProductInternalHomCompatibilityMorphismInverseWithGivenObjects",
                  [ IsCapCategory, IsList, IsInt ] );

DeclareOperation( "AddTensorProductInternalHomCompatibilityMorphismInverseWithGivenObjects",
                  [ IsCapCategory, IsList ] );

##
#! @Description
#! The argument is an object $a$.
#! The output is the coevaluation morphism $\mathrm{coev}_{a}:1 \rightarrow a \otimes a^{\vee}$.
#! @Returns a morphism in $\mathrm{Hom}(1,a \otimes a^{\vee})$.
#! @Arguments a
DeclareAttribute( "CoevaluationForDual",
                  IsCapCategoryObject );


#! @Description
#! The arguments are an object $s = 1$,
#! an object $a$,
#! and an object $r = a \otimes a^{\vee}$.
#! The output is the coevaluation morphism $\mathrm{coev}_{a}:1 \rightarrow a \otimes a^{\vee}$.
#! @Returns a morphism in $\mathrm{Hom}(1,a \otimes a^{\vee})$.
#! @Arguments s,a,r
DeclareOperation( "CoevaluationForDualWithGivenTensorProduct",
                  [ IsCapCategoryObject, IsCapCategoryObject, IsCapCategoryObject ] );

#! @Description
#! The arguments are a category $C$ and a function $F$.
#! This operation adds the given function $F$
#! to the category for the basic operation <C>CoevaluationForDualWithGivenTensorProduct</C>.
#! $F: (1, a, a \otimes a^{\vee}) \mapsto \mathrm{coev}_{a}$.
#! @Returns nothing
#! @Arguments C, F
DeclareOperation( "AddCoevaluationForDualWithGivenTensorProduct",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddCoevaluationForDualWithGivenTensorProduct",
                  [ IsCapCategory, IsFunction, IsInt ] );

DeclareOperation( "AddCoevaluationForDualWithGivenTensorProduct",
                  [ IsCapCategory, IsList, IsInt ] );

DeclareOperation( "AddCoevaluationForDualWithGivenTensorProduct",
                  [ IsCapCategory, IsList ] );


##
#! @Description
#! The argument is an endomorphism $\alpha: A \rightarrow A$.
#! The output is the trace morphism $\mathrm{trace}_{\alpha}: 1 \rightarrow 1$.
#! @Returns a morphism in $\mathrm{Hom}(1,1)$.
#! @Arguments alpha
DeclareAttribute( "TraceMap",
                  IsCapCategoryMorphism );

#! @Description
#! The arguments are a category $C$ and a function $F$.
#! This operation adds the given function $F$
#! to the category for the basic operation <C>TraceMap</C>.
#! $F: \alpha \mapsto \mathrm{trace}_{\alpha}$
#! @Returns nothing
#! @Arguments C, F
DeclareOperation( "AddTraceMap",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddTraceMap",
                  [ IsCapCategory, IsFunction, IsInt ] );

DeclareOperation( "AddTraceMap",
                  [ IsCapCategory, IsList, IsInt ] );

DeclareOperation( "AddTraceMap",
                  [ IsCapCategory, IsList ] );


##
#! @Description
#! The argument is an object $a$.
#! The output is the rank morphism $\mathrm{rank}_a: 1 \rightarrow 1$.
#! @Returns a morphism in $\mathrm{Hom}(1,1)$.
#! @Arguments a
DeclareAttribute( "RankMorphism",
                  IsCapCategoryObject );

#! @Description
#! The arguments are a category $C$ and a function $F$.
#! This operation adds the given function $F$
#! to the category for the basic operation <C>RankMorphism</C>.
#! $F: a \mapsto \mathrm{rank}_{a}$
#! @Returns nothing
#! @Arguments C, F
DeclareOperation( "AddRankMorphism",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddRankMorphism",
                  [ IsCapCategory, IsFunction, IsInt ] );

DeclareOperation( "AddRankMorphism",
                  [ IsCapCategory, IsList, IsInt ] );

DeclareOperation( "AddRankMorphism",
                  [ IsCapCategory, IsList ] );


##
#! @Description
#! The argument is an object $a$.
#! The output is the inverse of the morphism to the bidual $(a^{\vee})^{\vee} \rightarrow a$.
#! @Returns a morphism in $\mathrm{Hom}((a^{\vee})^{\vee},a)$.
#! @Arguments a
DeclareAttribute( "MorphismFromBidual",
                  IsCapCategoryObject );

#! @Description
#! The argument is an object $a$,
#! and an object $s = (a^{\vee})^{\vee}$.
#! The output is the inverse of the morphism to the bidual $(a^{\vee})^{\vee} \rightarrow a$.
#! @Returns a morphism in $\mathrm{Hom}((a^{\vee})^{\vee},a)$.
#! @Arguments a, s
DeclareOperation( "MorphismFromBidualWithGivenBidual",
                  [ IsCapCategoryObject, IsCapCategoryObject ] );

#! @Description
#! The arguments are a category $C$ and a function $F$.
#! This operation adds the given function $F$
#! to the category for the basic operation <C>MorphismFromBidualWithGivenBidual</C>.
#! $F: (a, (a^{\vee})^{\vee}) \mapsto ((a^{\vee})^{\vee} \rightarrow a)$.
#! @Returns nothing
#! @Arguments C, F
DeclareOperation( "AddMorphismFromBidualWithGivenBidual",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddMorphismFromBidualWithGivenBidual",
                  [ IsCapCategory, IsFunction, IsInt ] );

DeclareOperation( "AddMorphismFromBidualWithGivenBidual",
                  [ IsCapCategory, IsList, IsInt ] );

DeclareOperation( "AddMorphismFromBidualWithGivenBidual",
                  [ IsCapCategory, IsList ] );
