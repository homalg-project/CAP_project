# SPDX-License-Identifier: GPL-2.0-or-later
# FreydCategoriesForCAP: Freyd categories - Formal (co)kernels for additive categories
#
# Declarations
#
#! @Chapter Freyd category

####################################
##
#! @Section GAP Categories
##
####################################

DeclareCategory( "IsFreydCategoryObject",
                 IsCapCategoryObject );

DeclareCategory( "IsFreydCategoryMorphism",
                 IsCapCategoryMorphism );

DeclareCategory( "IsFreydCategory",
                 IsCapCategory );

DeclareGlobalFunction( "INSTALL_FUNCTIONS_FOR_FREYD_CATEGORY" );

####################################
##
#! @Section Constructors
##
####################################

DeclareGlobalFunction( "FREYD_CATEGORY" );

DeclareAttribute( "FreydCategory",
                  IsCapCategory );

DeclareAttribute( "FreydCategoryObject",
                  IsCapCategoryMorphism );

DeclareOperation( "FreydCategoryMorphism",
                  [ IsFreydCategoryObject, IsCapCategoryMorphism, IsFreydCategoryObject ] );

DeclareAttribute( "AsFreydCategoryObject",
                  IsCapCategoryObject );

DeclareAttribute( "AsFreydCategoryMorphism",
                  IsCapCategoryMorphism );

DeclareAttribute( "EmbeddingFunctorIntoFreydCategory",
                  IsCapCategory );

DeclareOperation( "\/",
                  [ IsCapCategoryMorphism, IsFreydCategory ] );

DeclareOperation( "\/",
                  [ IsHomalgMatrix, IsFreydCategory ] );

####################################
##
#! @Section Attributes
##
####################################

DeclareAttribute( "UnderlyingCategory",
                  IsFreydCategory );

CapJitAddTypeSignature( "UnderlyingCategory", [ IsFreydCategory ], function ( input_types )
    
    return CapJitDataTypeOfCategory( UnderlyingCategory( input_types[1].category ) );
    
end );

DeclareAttribute( "RelationMorphism",
                  IsFreydCategoryObject );

CapJitAddTypeSignature( "RelationMorphism", [ IsFreydCategoryObject ], function ( input_types )
    
    Assert( 0, IsFreydCategory( input_types[1].category ) );
    
    return CapJitDataTypeOfMorphismOfCategory( UnderlyingCategory( input_types[1].category ) );
    
end );

DeclareAttribute( "UnderlyingMorphism",
                  IsFreydCategoryMorphism );

CapJitAddTypeSignature( "UnderlyingMorphism", [ IsFreydCategoryMorphism ], function ( input_types )
    
    Assert( 0, IsFreydCategory( input_types[1].category ) );
    
    return CapJitDataTypeOfMorphismOfCategory( UnderlyingCategory( input_types[1].category ) );
    
end );

DeclareAttribute( "MorphismWitness",
                  IsFreydCategoryMorphism );

DeclareAttribute( "WitnessForBeingCongruentToZero",
                  IsFreydCategoryMorphism );

DeclareAttribute( "MereExistenceOfWitnessForBeingCongruentToZero",
                  IsFreydCategoryMorphism );

KeyDependentOperation( "FREYD_CATEGORIES_SimplifyObjectTuple", IsFreydCategoryObject, IsObject, ReturnTrue );

####################################################################################
##
#! @Section Determine properties of input category for Freyd category
##
####################################################################################

####################################################################################
##
#! @Section Random methods in Freyd categories
##
####################################################################################

if false then

#! @Description
#! The arguments are a Freyd category <A>cat</A> of a category <A>underlying_cat</A> and a list <A>L</A>.
#! The output is an object in <A>cat</A> whose relation morphism is a random morphism in <A>underlying_cat</A> constructed via
#! <C>RandomMorphismByList</C>(<A>underlying_cat</A>, <A>L</A>).
#! @Returns an object in a Freyd category
#! @Arguments cat, L
DeclareOperation( RandomObjectByList, [ IsFreydCategory, IsList ] );

#! @Description
#! The arguments are a Freyd category <A>cat</A> of a category <A>underlying_cat</A> and an integer <A>n</A>.
#! The output is an object in <A>cat</A> whose relation morphism is a random morphism in <A>underlying_cat</A> constructed via
#! <C>RandomMorphismByInteger</C>(<A>underlying_cat</A>, <A>n</A>).
#! @Returns an object in a Freyd category
#! @Arguments cat, n
DeclareOperation( RandomObjectByInteger, [ IsFreydCategory, IsInt ] );

#! @Description
#! The arguments are two objects <A>S</A> and <A>R</A> in a Freyd category <A>cat</A> of a category <A>underlying_cat</A> and a list <A>L</A>.
#! The category <A>cat</A> is required to have a homomorphism structure $(1,H,\nu)$ over <A>underlying_cat</A> or <A>cat</A>.
#! The output is a morphism in <A>cat</A> constructed as follows:
#! * If the source of the relation morphism $\rho_S$ of <A>S</A> is zero, then the morphism datum of the output is constructed via
#!   <C>RandomMorphismWithFixedSourceAndRangeByList</C>(<C>Range</C>($\rho_S$), <C>Range</C>($\rho_R$), <A>L</A>) where $\rho_R$ is the relation morphism of <A>R</A>.
#! * Otherwise, the output is $\nu^{-1}_{S,R}(\eta):S \to R$ where
#!   $\eta:1\to H(S,R)$ is a random morphism constructed via <C>RandomMorphismWithFixedSourceAndRangeByList</C>($1$,$H(S,R)$,<A>L</A>).
#! @Returns  a morphism in a Freyd category
#! @Arguments S, R, L
DeclareOperation( RandomMorphismWithFixedSourceAndRangeByList, [ IsFreydCategoryObject, IsFreydCategoryObject, IsList ] );

#! @Description
#! The arguments are two objects <A>S</A> and <A>R</A> in a Freyd category <A>cat</A> of a category <A>underlying_cat</A> and an integer <A>n</A>.
#! The category <A>cat</A> is required to have a homomorphism structure $(1,H,\nu)$ over <A>underlying_cat</A> or <A>cat</A>.
#! The output is a morphism in <A>cat</A> constructed as follows:
#! * If the source of the relation morphism $\rho_S$ of <A>S</A> is zero, then the morphism datum of the output is constructed via
#!   <C>RandomMorphismWithFixedSourceAndRangeByInteger</C>(<C>Range</C>($\rho_S$), <C>Range</C>($\rho_R$), <A>n</A>) where $\rho_R$ is the relation morphism of <A>R</A>.
#! * Otherwise, the output is $\nu^{-1}_{S,R}(\eta):S \to R$ where
#!   $\eta:1\to H(S,R)$ is a random morphism constructed via <C>RandomMorphismWithFixedSourceAndRangeByInteger</C>($1$,$H(S,R)$,<A>n</A>).
#! @Returns  a morphism in a Freyd category
#! @Arguments S, R, n
DeclareOperation( RandomMorphismWithFixedSourceAndRangeByInteger, [ IsFreydCategoryObject, IsFreydCategoryObject, IsInt ] );

#! @Description
#! The arguments are an object <A>S</A> in a Freyd category <A>cat</A> of a category <A>underlying_cat</A> and a list <A>L</A>.
#! We denote the relation morphism of <A>S</A> by $\rho_S:S_1 \to S_2$ in <A>underlying_cat</A>.
#! The output is a morphism in <A>cat</A> constructed as follows:
#! * Compute a morphism $\rho:S_1 \to R_1$ via <C>RandomMorphismWithFixedSourceByList</C>($S_1$,<A>L</A>).
#! * Compute the pair of injections $\mu_1:S_2 \to K$ and $\mu_2:R_1 \to K$ in the weak-bipushout $K$ of the pair ($\rho_S$, $\rho$).
#! * Compute a morphism $\delta:K \to R_2$ via <C>RandomMorphismWithFixedSourceByList</C>($K$,<A>L</A>).
#! The output is a morphism $S \to R$ in <A>cat</A> whose morphism datum is $\delta \circ \mu_1$ and whose range's relation morphism is $\delta \circ \mu_2$.
#! @Returns  a morphism in a Freyd category
#! @Arguments S, L
DeclareOperation( RandomMorphismWithFixedSourceByList, [ IsFreydCategoryObject, IsList ] );

#! @Description
#! The arguments are an object <A>S</A> in a Freyd category <A>cat</A> of a category <A>underlying_cat</A> and an integer <A>n</A>.
#! We denote the relation morphism of <A>S</A> by $\rho_S:S_1 \to S_2$ in <A>underlying_cat</A>.
#! The output is a morphism in <A>cat</A> constructed as follows:
#! * Compute a morphism $\rho:S_1 \to R_1$ via <C>RandomMorphismWithFixedSourceByInteger</C>($S_1$,<A>n</A>).
#! * Compute the pair of injections $\mu_1:S_2 \to K$ and $\mu_2:R_1 \to K$ in the weak-bipushout $K$ of the pair ($\rho_S$, $\rho$).
#! * Compute a morphism $\delta:K \to R_2$ via <C>RandomMorphismWithFixedSourceByInteger</C>($K$,<A>n</A>).
#! The output is a morphism $S \to R$ in <A>cat</A> whose morphism datum is $\delta \circ \mu_1$ and whose range's relation morphism is $\delta \circ \mu_2$.
#! @Returns  a morphism in a Freyd category
#! @Arguments S, n
DeclareOperation( RandomMorphismWithFixedSourceByInteger, [ IsFreydCategoryObject, IsInt ] );

#! @Description
#! The arguments are an object <A>R</A> in a Freyd category <A>cat</A> of a category <A>underlying_cat</A> and a list <A>L</A>.
#! We denote the relation morphism of <A>R</A> by $\rho_R:R_1 \to R_2$ in <A>underlying_cat</A>.
#! The output is a morphism in <A>cat</A> constructed as follows:
#! * Compute a morphism $\rho:S_2 \to R_2$ via <C>RandomMorphismWithFixedRangeByList</C>($R_2$,<A>L</A>).
#! * Compute the projection $\rho_S:K \to S_2$ in the second factor of the weak-bifiber-product of the pair ($\rho_R$,$\rho$).
#! * Compute a morphism $\delta:S_1 \to K$ via <C>RandomMorphismWithFixedRangeByList</C>($K$,<A>L</A>).
#! The output is a morphism $S \to R$ in <A>cat</A> whose morphism datum is $\rho$ and whose source's relation morphism is $\rho_S \circ \delta$.
#! @Returns a morphism in a Freyd category
#! @Arguments R, L
DeclareOperation( RandomMorphismWithFixedRangeByList, [ IsFreydCategoryObject, IsList ] );

#! @Description
#! The arguments are an object <A>R</A> in a Freyd category <A>cat</A> of a category <A>underlying_cat</A> and an integer <A>n</A>.
#! We denote the relation morphism of <A>R</A> by $\rho_R:R_1 \to R_2$ in <A>underlying_cat</A>.
#! The output is a morphism in <A>cat</A> constructed as follows:
#! * Compute a morphism $\rho:S_2 \to R_2$ via <C>RandomMorphismWithFixedRangeByInteger</C>($R_2$,<A>n</A>).
#! * Compute the projection $\rho_S:K \to S_2$ in the second factor of the weak-bifiber-product of the pair ($\rho_R$,$\rho$).
#! * Compute a morphism $\delta:S_1 \to K$ via <C>RandomMorphismWithFixedRangeByInteger</C>($K$,<A>n</A>).
#! The output is a morphism $S \to R$ in <A>cat</A> whose morphism datum is $\rho$ and whose source's relation morphism is $\rho_S \circ \delta$.
#! @Returns a morphism in a Freyd category
#! @Arguments R, n
DeclareOperation( RandomMorphismWithFixedRangeByInteger, [ IsFreydCategoryObject, IsInt ] );

#! @Description
#! The arguments are a Freyd category <A>cat</A> and a list <A>L</A> consisting of three lists.
#! The output is constructed via <C>RandomMorphismWithFixedSourceAndRangeByList</C>($S$,$R$,<A>L</A>[3]) where
#! $S$ is constructed via <C>RandomObjectByList</C>(<A>cat</A>,<A>L</A>[1]) and $R$ via <C>RandomObjectByList</C>(<A>cat</A>,<A>L</A>[2]).
#! @Returns  a morphism in a Freyd category
#! @Arguments cat, L
DeclareOperation( RandomMorphismByList, [ IsFreydCategory, IsList ] );

#! @Description
#! The arguments are a Freyd category <A>cat</A> and an integer <A>n</A>.
#! The output is constructed via <C>RandomMorphismWithFixedSourceAndRangeByInteger</C>($S$,$R$,<A>n</A>) where
#! $S$ and $R$ are random objects constructed via <C>RandomObjectByInteger</C>(<A>cat</A>,<A>n</A>).
#! @Returns  a morphism in a Freyd category
#! @Arguments cat, n
DeclareOperation( RandomMorphismByInteger, [ IsFreydCategory, IsInt ] );

fi;

DeclareGlobalFunction( "IsValidInputForFreydCategory" );

##############################################
##
#! @Section Internal Hom-Embedding
##
##############################################

#! @Description
#! The arguments are two objects <A>a</A> and <A>b</A> of a Freyd category <A>cat</A>.
#! Assume that the relation morphism for $a$ is $\alpha \colon R_A \to A$, then we have the exact sequence
#! $0 \to \mathrm{\underline{Hom}} \left( a,b \right) \to \mathrm{\underline{Hom}}(A, b) \to \mathrm{\underline{Hom}}(R_A, b)$. The embedding of $\mathrm{\underline{Hom}}( a, b )$ 
#! into $\mathrm{\underline{Hom}}(A, b)$ is the internal Hom-embedding. This method returns this very map.
#! @Returns a (mono)morphism
#! @Arguments cat, a, b
DeclareOperationWithCache( "INTERNAL_HOM_EMBEDDING",
                           [ IsFreydCategory, IsFreydCategoryObject, IsFreydCategoryObject ] );


####################################################################################
##
#! @Section Convenient methods for tensor products of freyd objects and morphisms
##
####################################################################################

#!
DeclareOperation( "\*",
               [ IsFreydCategoryObject, IsFreydCategoryObject ] );

#!
DeclareOperation( "\^",
               [ IsFreydCategoryObject, IsInt ] );

#!
DeclareOperation( "\*",
               [ IsFreydCategoryMorphism, IsFreydCategoryMorphism ] );

#!
DeclareOperation( "\^",
               [ IsFreydCategoryMorphism, IsInt ] );
