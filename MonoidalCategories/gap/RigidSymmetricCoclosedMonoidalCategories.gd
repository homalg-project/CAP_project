####################################
##
#! @Chapter Monoidal Categories
##
#! @Section Rigid Symmetric Coclosed Monoidal Categories
##
####################################

DeclareGlobalVariable( "CAP_INTERNAL_RIGID_SYMMETRIC_COCLOSED_MONOIDAL_CATEGORIES_BASIC_OPERATIONS" );
  
DeclareGlobalVariable( "RIGID_SYMMETRIC_COCLOSED_MONOIDAL_CATEGORIES_METHOD_NAME_RECORD" );

##
#! @Description
#! The arguments are two objects $a,b$.
#! The output is the natural morphism $\mathrm{IsomorphismFromInternalCoHomToTensorProductWithGivenObjects}_{a,b}: \mathrm{\underline{coHom}}(a,b) \rightarrow a \otimes b_{\vee}$.
#! @Returns a morphism in $\mathrm{Hom}( \mathrm{\underline{coHom}}(a,b), a \otimes b_{\vee} )$.
#! @Arguments a,b
DeclareOperation( "IsomorphismFromInternalCoHomToTensorProduct",
                  [ IsCapCategoryObject, IsCapCategoryObject ] );

#! @Description
#! The arguments are a category $C$ and a function $F$.
#! This operations adds the given function $F$
#! to the category for the basic operation <C>IsomorphismFromInternalCoHomToTensorProduct</C>.
#! $F: ( a, b ) \mapsto \mathrm{IsomorphismFromInternalCoHomToTensorProduct}_{a,b}$.
#! @Returns nothing
#! @Arguments C, F
DeclareOperation( "AddIsomorphismFromInternalCoHomToTensorProduct",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddIsomorphismFromInternalCoHomToTensorProduct",
                  [ IsCapCategory, IsFunction, IsInt ] );

DeclareOperation( "AddIsomorphismFromInternalCoHomToTensorProduct",
                  [ IsCapCategory, IsList, IsInt ] );

DeclareOperation( "AddIsomorphismFromInternalCoHomToTensorProduct",
                  [ IsCapCategory, IsList ] );

##
#! @Description
#! The arguments are two objects $a,b$.
#! The output is the inverse of $\mathrm{MorphismFromInternalCoHomToTensorProductWithGivenObjects}$, namely
#! $\mathrm{MorphismFromTensorProductToInternalCoHomWithGivenObjects}_{a,b}: a \otimes b_{\vee} \rightarrow \mathrm{\underline{coHom}}(a,b)$.
#! @Returns a morphism in $\mathrm{Hom}( a \otimes b_{\vee}, \mathrm{\underline{coHom}}(a,b) )$.
#! @Arguments a,b
DeclareOperation( "MorphismFromTensorProductToInternalCoHom",
                  [ IsCapCategoryObject, IsCapCategoryObject ] );


#! @Description
#! The arguments are an object $s = a \otimes b_{\vee}$,
#! two objects $a,b$,
#! and an object $r = \mathrm{\underline{coHom}}(a,b)$.
#! The output is the inverse of $\mathrm{MorphismFromInternalCoHomToTensorProductWithGivenObjects}$, namely
#! $\mathrm{MorphismFromTensorProductToInternalCoHomWithGivenObjects}_{a,b}: a \otimes b_{\vee} \rightarrow \mathrm{\underline{coHom}}(a,b)$.
#! @Returns a morphism in $\mathrm{Hom}( a \otimes b_{\vee}, \mathrm{\underline{coHom}}(a,b)$.
#! @Arguments s,a,b,r
DeclareOperation( "MorphismFromTensorProductToInternalCoHomWithGivenObjects",
                  [ IsCapCategoryObject, IsCapCategoryObject, IsCapCategoryObject, IsCapCategoryObject ] );

#! @Description
#! The arguments are a category $C$ and a function $F$.
#! This operations adds the given function $F$
#! to the category for the basic operation <C>MorphismFromTensorProductToInternalCoHomWithGivenObjects</C>.
#! $F: ( a \otimes b_{\vee},a,b,\mathrm{\underline{coHom}}(a,b) ) \mapsto \mathrm{MorphismFromTensorProductToInternalCoHomWithGivenObjects}_{a,b}$.
#! @Returns nothing
#! @Arguments C, F
DeclareOperation( "AddMorphismFromTensorProductToInternalCoHomWithGivenObjects",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddMorphismFromTensorProductToInternalCoHomWithGivenObjects",
                  [ IsCapCategory, IsFunction, IsInt ] );

DeclareOperation( "AddMorphismFromTensorProductToInternalCoHomWithGivenObjects",
                  [ IsCapCategory, IsList, IsInt ] );

DeclareOperation( "AddMorphismFromTensorProductToInternalCoHomWithGivenObjects",
                  [ IsCapCategory, IsList ] );

##
#! @Description
#! The arguments are two objects $a,b$.
#! The output is the inverse of $\mathrm{IsomorphismFromInternalCoHomToTensorProduct}$, namely
#! $\mathrm{IsomorphismFromTensorProductToInternalCoHom}_{a,b}: a \otimes b_{\vee} \rightarrow \mathrm{\underline{coHom}}(a,b)$.
#! @Returns a morphism in $\mathrm{Hom}( a \otimes b_{\vee}, \mathrm{\underline{coHom}}(a,b)$.
#! @Arguments a,b
DeclareOperation( "IsomorphismFromTensorProductToInternalCoHom",
                  [ IsCapCategoryObject, IsCapCategoryObject ] );

#! @Description
#! The arguments are a category $C$ and a function $F$.
#! This operations adds the given function $F$
#! to the category for the basic operation <C>IsomorphismFromTensorProductToInternalCoHom</C>.
#! $F: ( a,b ) \mapsto \mathrm{IsomorphismFromTensorProductToInternalCoHom}_{a,b}$.
#! @Returns nothing
#! @Arguments C, F
DeclareOperation( "AddIsomorphismFromTensorProductToInternalCoHom",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddIsomorphismFromTensorProductToInternalCoHom",
                  [ IsCapCategory, IsFunction, IsInt ] );

DeclareOperation( "AddIsomorphismFromTensorProductToInternalCoHom",
                  [ IsCapCategory, IsList, IsInt ] );

DeclareOperation( "AddIsomorphismFromTensorProductToInternalCoHom",
                  [ IsCapCategory, IsList ] );

##
#! @Description
#! The arguments are four objects $a, a', b, b'$.
#! The output is the natural morphism
#! $\mathrm{InternalCoHomTensorProductCompatibilityMorphismInverseWithGivenObjects}_{a,a',b,b'}: \mathrm{\underline{coHom}}(a_1, a_2) \otimes \mathrm{\underline{coHom}}(b_1, b_2) \rightarrow \mathrm{\underline{coHom}}(a_1 \otimes b_1, a_2 \otimes b_2)$.
#! @Returns a morphism in $\mathrm{Hom}( \mathrm{\underline{coHom}}(a_1, a_2) \otimes \mathrm{\underline{coHom}}(b_1, b_2), \mathrm{\underline{coHom}}(a_1 \otimes b_1, a_2 \otimes b_2)$.
#! @Arguments a,a',b,b'
DeclareOperation( "InternalCoHomTensorProductCompatibilityMorphismInverse",
                  [ IsCapCategoryObject, IsCapCategoryObject, IsCapCategoryObject, IsCapCategoryObject ] );

##
## The new_source and new_range arguments are the first and second element of the list.
## This construction is due to the fact that the maximal number of arguments for an operation is 6,
## but a basic operation with 6 arguments would install a setter having 7 arguments.
#! @Description
#! The arguments are four objects $a, a', b, b'$,
#! and a list $L = [ \mathrm{\underline{coHom}}(a_1 \otimes b_1, a_2 \otimes b_2), \mathrm{\underline{coHom}}(a_1, a_2) \otimes \mathrm{\underline{coHom}}(b_1, b_2) ]$.
#! The output is the natural morphism
#! $\mathrm{InternalCoHomTensorProductCompatibilityMorphismInverseWithGivenObjects}_{a,a',b,b'}: \mathrm{\underline{coHom}}(a_1, a_2) \otimes \mathrm{\underline{coHom}}(b_1, b_2) \rightarrow \mathrm{\underline{coHom}}(a_1 \otimes b_1, a_2 \otimes b_2)$.
#! @Returns a morphism in $\mathrm{Hom}( \mathrm{\underline{coHom}}(a_1, a_2) \otimes \mathrm{\underline{coHom}}(b_1, b_2), \mathrm{\underline{coHom}}(a_1 \otimes b_1, a_2 \otimes b_2) )$.
#! @Arguments a,a',b,b',L
DeclareOperation( "InternalCoHomTensorProductCompatibilityMorphismInverseWithGivenObjects",
                  [ IsCapCategoryObject, IsCapCategoryObject, IsCapCategoryObject, IsCapCategoryObject, IsList ] );

#! @Description
#! The arguments are a category $C$ and a function $F$.
#! This operations adds the given function $F$
#! to the category for the basic operation <C>InternalCoHomTensorProductCompatibilityMorphismInverseWithGivenObjects</C>.
#! $F: ( a,a',b,b', [ \mathrm{\underline{coHom}}(a_1 \otimes b_1, a_2 \otimes b_2), \mathrm{\underline{coHom}}(a_1, a_2) \otimes \mathrm{\underline{coHom}}(b_1, b_2) ]) \mapsto \mathrm{InternalCoHomTensorProductCompatibilityMorphismInverseWithGivenObjects}_{a,a',b,b'}$.
#! @Returns nothing
#! @Arguments C, F
DeclareOperation( "AddInternalCoHomTensorProductCompatibilityMorphismInverseWithGivenObjects",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddInternalCoHomTensorProductCompatibilityMorphismInverseWithGivenObjects",
                  [ IsCapCategory, IsFunction, IsInt ] );

DeclareOperation( "AddInternalCoHomTensorProductCompatibilityMorphismInverseWithGivenObjects",
                  [ IsCapCategory, IsList, IsInt ] );

DeclareOperation( "AddInternalCoHomTensorProductCompatibilityMorphismInverseWithGivenObjects",
                  [ IsCapCategory, IsList ] );

##
#! @Description
#! The argument is an object $a$.
#! The output is the dual coevaluation morphism $\mathrm{dcoev}_{a}: a_{\vee} \otimes a \rightarrow 1$.
#! @Returns a morphism in $\mathrm{Hom}(a_{\vee} \otimes a, 1)$.
#! @Arguments a
DeclareAttribute( "DualCoEvaluationForCoDual",
                  IsCapCategoryObject );


#! @Description
#! The arguments are an object $s = a_{\vee} \otimes a$,
#! an object $a$,
#! and an object $r = 1$.
#! The output is the dual coevaluation morphism $\mathrm{dcoev}_{a}: a_{\vee} \otimes a \rightarrow 1$.
#! @Returns a morphism in $\mathrm{Hom}(a_{\vee} \otimes a, 1)$.
#! @Arguments s,a,r
DeclareOperation( "DualCoEvaluationForCoDualWithGivenTensorProduct",
                  [ IsCapCategoryObject, IsCapCategoryObject, IsCapCategoryObject ] );

#! @Description
#! The arguments are a category $C$ and a function $F$.
#! This operations adds the given function $F$
#! to the category for the basic operation <C>DualCoEvaluationForCoDualWithGivenTensorProduct</C>.
#! $F: (a_{\vee} \otimes a, a,1) \mapsto \mathrm{dcoev}_{a}$.
#! @Returns nothing
#! @Arguments C, F
DeclareOperation( "AddDualCoEvaluationForCoDualWithGivenTensorProduct",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddDualCoEvaluationForCoDualWithGivenTensorProduct",
                  [ IsCapCategory, IsFunction, IsInt ] );

DeclareOperation( "AddDualCoEvaluationForCoDualWithGivenTensorProduct",
                  [ IsCapCategory, IsList, IsInt ] );

DeclareOperation( "AddDualCoEvaluationForCoDualWithGivenTensorProduct",
                  [ IsCapCategory, IsList ] );


##
#! @Description
#! The argument is an endomorphism $\alpha: A \rightarrow A$.
#! The output is the cotrace morphism $\mathrm{cotrace}_{\alpha}: 1 \rightarrow 1$.
#! @Returns a morphism in $\mathrm{Hom}(1,1)$.
#! @Arguments alpha
DeclareAttribute( "CoTraceMap",
                  IsCapCategoryMorphism );

#! @Description
#! The arguments are a category $C$ and a function $F$.
#! This operations adds the given function $F$
#! to the category for the basic operation <C>CoTraceMap</C>.
#! $F: \alpha \mapsto \mathrm{cotrace}_{\alpha}$
#! @Returns nothing
#! @Arguments C, F
DeclareOperation( "AddCoTraceMap",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddCoTraceMap",
                  [ IsCapCategory, IsFunction, IsInt ] );

DeclareOperation( "AddCoTraceMap",
                  [ IsCapCategory, IsList, IsInt ] );

DeclareOperation( "AddCoTraceMap",
                  [ IsCapCategory, IsList ] );


##
#! @Description
#! The argument is an object $a$.
#! The output is the corank morphism $\mathrm{corank}_a: 1 \rightarrow 1$.
#! @Returns a morphism in $\mathrm{Hom}(1,1)$.
#! @Arguments a
DeclareAttribute( "CoRankMorphism",
                  IsCapCategoryObject );

#! @Description
#! The arguments are a category $C$ and a function $F$.
#! This operations adds the given function $F$
#! to the category for the basic operation <C>CoRankMorphism</C>.
#! $F: a \mapsto \mathrm{corank}_{a}$
#! @Returns nothing
#! @Arguments C, F
DeclareOperation( "AddCoRankMorphism",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddCoRankMorphism",
                  [ IsCapCategory, IsFunction, IsInt ] );

DeclareOperation( "AddCoRankMorphism",
                  [ IsCapCategory, IsList, IsInt ] );

DeclareOperation( "AddCoRankMorphism",
                  [ IsCapCategory, IsList ] );


##
#! @Description
#! The argument is an object $a$.
#! The output is the inverse of the morphism from the cobidual $a \rightarrow (a_{\vee})_{\vee}$.
#! @Returns a morphism in $\mathrm{Hom}(a, (a_{\vee})_{\vee})$.
#! @Arguments a
DeclareAttribute( "MorphismToCoBidual",
                  IsCapCategoryObject );

#! @Description
#! The argument is an object $a$,
#! and an object $r = (a_{\vee})_{\vee}$.
#! The output is the inverse of the morphism from the cobidual $a \rightarrow (a_{\vee})_{\vee}$.
#! @Returns a morphism in $\mathrm{Hom}(a,(a_{\vee})_{\vee})$.
#! @Arguments a, r
DeclareOperation( "MorphismToCoBidualWithGivenCoBidual",
                  [ IsCapCategoryObject, IsCapCategoryObject ] );

#! @Description
#! The arguments are a category $C$ and a function $F$.
#! This operations adds the given function $F$
#! to the category for the basic operation <C>MorphismToCoBidualWithGivenCoBidual</C>.
#! $F: (a, (a_{\vee})_{\vee}) \mapsto (a \rightarrow (a_{\vee})_{\vee} )$.
#! @Returns nothing
#! @Arguments C, F
DeclareOperation( "AddMorphismToCoBidualWithGivenCoBidual",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddMorphismToCoBidualWithGivenCoBidual",
                  [ IsCapCategory, IsFunction, IsInt ] );

DeclareOperation( "AddMorphismToCoBidualWithGivenCoBidual",
                  [ IsCapCategory, IsList, IsInt ] );

DeclareOperation( "AddMorphismToCoBidualWithGivenCoBidual",
                  [ IsCapCategory, IsList ] );
