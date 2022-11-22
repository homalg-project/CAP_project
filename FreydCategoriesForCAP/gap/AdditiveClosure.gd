# SPDX-License-Identifier: GPL-2.0-or-later
# FreydCategoriesForCAP: Freyd categories - Formal (co)kernels for additive categories
#
# Declarations
#
#! @Chapter Additive closure

####################################
##
#! @Section GAP Categories
##
####################################

#! @Description
#! The GAP category of additive closures of Ab-categories.
#! @Arguments object
#! @Returns true or false
DeclareCategory( "IsAdditiveClosureCategory",
                 IsCapCategory );

#! @Description
#! The GAP category of objects in additive closures of Ab-categories.
#! @Arguments object
#! @Returns true or false
DeclareCategory( "IsAdditiveClosureObject",
                 IsCapCategoryObject );

#! @Description
#! The GAP category of morphisms in additive closures of Ab-categories.
#! @Arguments object
#! @Returns true or false
DeclareCategory( "IsAdditiveClosureMorphism",
                 IsCapCategoryMorphism );

DeclareGlobalFunction( "INSTALL_FUNCTIONS_FOR_ADDITIVE_CLOSURE" );

DeclareGlobalFunction( "INSTALL_FUNCTIONS_OF_RANDOM_METHODS_FOR_ADDITIVE_CLOSURE" );

####################################
##
#! @Section Constructors
##
####################################


#! @Description
#! The argument is an Ab-category $C$. The output is its additive closure $C^\oplus$.
#! @Arguments C
#! @Returns the category $C^\oplus$
DeclareAttribute( "AdditiveClosure",
                  IsCapCategory );

#! @Description
#! Same as <Ref Attr="AdditiveClosure" Label="for IsCapCategory" />, but as an operation instead of an attribute.
#! @Arguments C
#! @Returns the category $C^\oplus$
DeclareOperation( "ADDITIVE_CLOSURE",
                  [ IsCapCategory ] );

#! @Description
#! The argument is a list of objects $L=[A_1,\dots,A_n]$ in an Ab-category $C$. The output is the formal direct sum
#! $A_1\oplus\dots\oplus A_n$ in the additive closure $C^\oplus$.
#! @Arguments L, C^\oplus
#! @Returns an object in $C^\oplus$
DeclareOperation( "AdditiveClosureObject",
                  [ IsList, IsAdditiveClosureCategory ] );

#! @Description
#! The argument is an object $A$ in an Ab-category $C$. The output is the image of $A$ under the inclusion functor $\iota:C\to C^\oplus$.
#! @Arguments A
#! @Returns an object in $C^\oplus$
DeclareAttribute( "AsAdditiveClosureObject",
                  IsCapCategoryObject );

#! @Description
#! The arguments are formal direct sums $A=A_1\oplus\dots\oplus A_m$, $B=B_1\oplus\dots\oplus B_n$ in some additive category $C^\oplus$
#! and an $m\times n$ matrix $M :=(\alpha_{ij}:A_i\to B_j)_{ij}$ for $i=1,\dots,m,j=1,\dots,n$.
#! The output is the formal morphism between $A$ and $B$ that is defined by $M$.
#! @Arguments A, M, B
#! @Returns a morphism in $\mathrm{Hom}_{C^\oplus}(A,B)$
DeclareOperation( "AdditiveClosureMorphism",
                  [ IsAdditiveClosureObject, IsList, IsAdditiveClosureObject ] );

# deprecated
DeclareOperation( "AdditiveClosureMorphismListList",
                  [ IsAdditiveClosureObject, IsList, IsAdditiveClosureObject ] );

#! @Description
#! The argument is a morphism $\alpha$ in an Ab-category $C$. The output is the image of $\alpha$ under the inclusion functor $\iota:C\to C^\oplus$.
#! @Arguments alpha
#! @Returns a morphism in $C^\oplus$
DeclareAttribute( "AsAdditiveClosureMorphism",
                  IsCapCategoryMorphism );

#! @Description
#! The argument is an Ab-category $C$. The output is the inclusion functor $\iota:C\to C^\oplus$.
#! @Arguments C
#! @Returns a functor $C\to C^\oplus$
DeclareAttribute( "InclusionFunctorInAdditiveClosure",
                  IsCapCategory );

#! @Description
#! The argument is a functor $F:C\to D$, and the output is the extension functor
#! $F^\oplus:C^\oplus \to D^\oplus$.
#! @Arguments F
#! @Returns a functor $C^\oplus \to D^\oplus$
DeclareAttribute( "ExtendFunctorToAdditiveClosures",
                  IsCapFunctor );

#! @Description
#! The argument is a functor $F:C\to D$, where $D$ is an additive category. The output is the extension functor
#! $F^\oplus:C^\oplus \to D$.
#! @Arguments F
#! @Returns a functor $C^\oplus \to D$
DeclareAttribute( "ExtendFunctorWithAdditiveRangeToFunctorFromAdditiveClosureOfSource",
                  IsCapFunctor );

#! @Description
#! The argument is a functor $F:C\to D$. If $D$ is not known to be an additive category, then return
#! <C>ExtendFunctorToAdditiveClosures</C>(<A>F</A>), otherwise return
#! <C>ExtendFunctorWithAdditiveRangeToFunctorFromAdditiveClosureOfSource</C>(<A>F</A>).
#! @Arguments F
#! @Returns a functor $C^\oplus \to D^\oplus$ or $C^\oplus \to D$
DeclareAttribute( "ExtendFunctorToAdditiveClosureOfSource",
                  IsCapFunctor );

#! @Description
#! The argument is a natural transformation $\eta:(F:C\to D)\Rightarrow (G:C\to D)$ where $D$
#! is an additive category.
#! The ouput is the extension natural transformation
#! $\eta^\oplus:(F^\oplus:C^\oplus\to D)\to(G^\oplus:C^\oplus\to D)$.
#! @Arguments eta
#! @Returns a natural transformation from $F^\oplus$ to $G^\oplus$
DeclareAttribute( "ExtendNaturalTransformationToAdditiveClosureOfSource",
                  IsCapNaturalTransformation );

####################################
##
#! @Section Attributes
##
####################################

#! @Description
#! The argument is some additive closure category $A:=C^\oplus$. The output is $C$.
#! @Arguments A
#! @Returns the category $C$
DeclareAttribute( "UnderlyingCategory",
                  IsAdditiveClosureCategory );

CapJitAddTypeSignature( "UnderlyingCategory", [ IsAdditiveClosureCategory ], function ( input_types )
    
    return CapJitDataTypeOfCategory( UnderlyingCategory( input_types[1].category ) );
    
end );

#! @Description
#! The argument is a formal direct sum $A:=A_1\oplus\dots\oplus A_m$ in some additive closure category $C^\oplus$.
#! The output is the list $[A_1,\dots,A_m]$.
#! @Arguments A
#! @Returns a list of the objects in $C$
DeclareAttribute( "ObjectList",
                  IsAdditiveClosureObject );

CapJitAddTypeSignature( "ObjectList", [ IsAdditiveClosureObject ], function ( input_types )
    
    Assert( 0, IsAdditiveClosureCategory( input_types[1].category ) );
    
    return rec( filter := IsList, element_type := CapJitDataTypeOfObjectOfCategory( UnderlyingCategory( input_types[1].category ) ) );
    
end );

#! @Description
#! The argument is a morphism $\alpha:A\to B$ between formal direct sums in some additive closure category $C^\oplus$.
#! The output is the defining matrix of $\alpha$.
#! @Arguments alpha
#! @Returns a list of lists the morphisms in $C$
DeclareAttribute( "MorphismMatrix",
                  IsAdditiveClosureMorphism );

CapJitAddTypeSignature( "MorphismMatrix", [ IsAdditiveClosureMorphism ], function ( input_types )
    
    Assert( 0, IsAdditiveClosureCategory( input_types[1].category ) );
    
    return rec( filter := IsList, element_type := rec( filter := IsList, element_type := CapJitDataTypeOfMorphismOfCategory( UnderlyingCategory( input_types[1].category ) ) ) );
    
end );

#! @Description
#! The argument is a morphism $\alpha:A\to B$ between formal direct sums. The output is the number of summands of the the source.
#! @Arguments alpha
#! @Returns a non-negative integer
DeclareAttribute( "NumberRows",
                  IsAdditiveClosureMorphism );
CapJitAddTypeSignature( "NumberRows", [ IsAdditiveClosureMorphism ], IsInt );

#! @Description
#! The argument is a morphism $\alpha:A\to B$ between formal direct sums. The output is the number of summands of the the range.
#! @Arguments alpha
#! @Returns a non-negative integer
DeclareAttribute( "NumberColumns",
                  IsAdditiveClosureMorphism );
CapJitAddTypeSignature( "NumberColumns", [ IsAdditiveClosureMorphism ], IsInt );

####################################
##
#! @Section Operators
##
####################################

#! @Description
#! The arguments are a formal direct sum $A$ in some additive category $C^\oplus$ and an integers $i$.
#! The output is the $i$'th entry in <C>ObjectList</C>($A$).
#! @Arguments A, i
#! @Returns an object in $C$
DeclareOperation( "[]",
                  [ IsAdditiveClosureObject, IsInt ] );

CapJitAddTypeSignature( "[]", [ IsAdditiveClosureObject, IsInt ], function ( input_types )
    
    Assert( 0, IsAdditiveClosureCategory( input_types[1].category ) );
    
    return CapJitDataTypeOfObjectOfCategory( UnderlyingCategory( input_types[1].category ) );
    
end );

#! @Description
#! The arguments are a morphism $\alpha:A\to B$ between formal direct sums in some additive category $C^\oplus$ and two integers $i,j$.
#! The output is the $(i,j)$'th entry in <C>MorphismMatrix</C>($\alpha$).
#! @Arguments alpha, i, j
#! @Returns a morphism $C$
DeclareOperation( "[,]",
                  [ IsAdditiveClosureMorphism, IsInt, IsInt ] );

CapJitAddTypeSignature( "[,]", [ IsAdditiveClosureMorphism, IsInt, IsInt ], function ( input_types )
    
    Assert( 0, IsAdditiveClosureCategory( input_types[1].category ) );
    
    return CapJitDataTypeOfMorphismOfCategory( UnderlyingCategory( input_types[1].category ) );
    
end );

#! @Description
#! The input is either a list of objects or list of lists of morphisms. The method delegates to
#! either <C>AdditiveClosureObject</C> or <C>AdditiveClosureMorphism</C>.
DeclareOperation( "\/",
                  [ IsList, IsAdditiveClosureCategory ] );

#! @Description
#! This is a convenience method for
#! <C>AsAdditiveClosureObject</C> and <C>AsAdditiveClosureMorphism</C>.
DeclareOperation( "\/",
                  [ IsCapCategoryCell, IsAdditiveClosureCategory ] );

####################################
##
#! @Section Random methods for additive closure category
##
####################################

if false then

#! @Description
#! The arguments are an additive closure category <A>C</A> of a category <A>U</A> and a list <A>L</A> whose first entry is a non-empty list of non-negative integers and second entry is a list.
#! The output is an object in <A>C</A> which is a formal direct sum of <C>Random</C>(<A>L</A>[1]) objects in <A>U</A> each computed via <C>RandomObjectByList</C>(<A>U</A>,<A>L</A>[2]).
#! @Returns an object in C
#! @Arguments C, L
DeclareOperation( RandomObjectByList, [ IsAdditiveClosureCategory, IsList ] );

#! @Description
#! The arguments are an additive closure category <A>C</A> of a category <A>U</A> and a non-negative integer <A>n</A>.
#! The output is an object in <A>C</A> which is a formal direct sum of at most <A>n</A> objects in <A>U</A> each computed via <C>RandomObjectByInteger</C>(<A>U</A>,<A>n</A>).
#! @Returns an object in C
#! @Arguments C, n
DeclareOperation( RandomObjectByInteger, [ IsAdditiveClosureCategory, IsInt ] );

#! @Description
#! The arguments are two objects <A>S</A>, <A>R</A> and a list <A>L</A>.
#! The output is a morphism from <A>S</A> to <A>R</A> whose matrix entry at index $i,j$ is computed via <C>RandomMorphismWithFixedSourceAndRangeByList</C>(<A>S</A>[$i$],<A>R</A>[$j$],<A>L</A>).
#! @Returns  a morphism in C
#! @Arguments S, R, L
DeclareOperation( RandomMorphismWithFixedSourceAndRangeByList, [ IsAdditiveClosureObject, IsAdditiveClosureObject, IsList ] );

#! @Description
#! The arguments are two objects <A>S</A>, <A>R</A> and an integer <A>n</A>.
#! The output is a morphism from <A>S</A> to <A>R</A> whose matrix entry at index $i,j$ is computed via <C>RandomMorphismWithFixedSourceAndRangeByInteger</C>(<A>S</A>[$i$],<A>R</A>[$j$],<A>n</A>).
#! @Returns  a morphism in C
#! @Arguments S, R, n
DeclareOperation( RandomMorphismWithFixedSourceAndRangeByInteger, [ IsAdditiveClosureObject, IsAdditiveClosureObject, IsInt ] );

#! @Description
#! The arguments are an object <A>S</A> in an additive closure category <A>C</A> and a list <A>L</A> consisting of two lists.
#! The output is <C>RandomMorphismWithFixedSourceAndRangeByList</C>(<A>S</A>,$R$,<A>L</A>[2]) where
#! $R$ is computed via <C>RandomObjectByList</C>(<A>C</A>,<A>L</A>[1]).
#! @Returns a morphism in C
#! @Arguments S, L
DeclareOperation( RandomMorphismWithFixedSourceByList, [ IsAdditiveClosureObject, IsList ] );

#! @Description
#! The arguments are an object <A>S</A> in an additive closure category <A>C</A> and an integer <A>n</A>.
#! The output is <C>RandomMorphismWithFixedSourceAndRangeByInteger</C>(<A>S</A>,$R$,$1$+<C>Log2Int</C>(<A>n</A>)) where
#! $R$ is computed via <C>RandomObjectByInteger</C>(<A>C</A>,<A>n</A>).
#! @Returns  a morphism in C
#! @Arguments S, n
DeclareOperation( RandomMorphismWithFixedSourceByInteger, [ IsAdditiveClosureObject, IsInt ] );

#! @Description
#! The arguments are an object <A>R</A> in an additive closure category <A>C</A> and a list <A>L</A> consisting of two lists.
#! The output is <C>RandomMorphismWithFixedSourceAndRangeByList</C>(<A>S</A>,$R$,<A>L</A>[2]) where
#! $S$ is computed via <C>RandomObjectByList</C>(<A>C</A>,<A>L</A>[1]).
#! @Returns a morphism in a category of rows
#! @Arguments R, L
DeclareOperation( RandomMorphismWithFixedRangeByList, [ IsAdditiveClosureObject, IsList ] );

#! @Description
#! The arguments are an object <A>S</A> in an additive closure category <A>C</A> and an integer <A>n</A>.
#! The output is <C>RandomMorphismWithFixedSourceAndRangeByInteger</C>(<A>S</A>,$R$,$1$+<C>Log2Int</C>(<A>n</A>)) where
#! $S$ is computed via <C>RandomObjectByInteger</C>(<A>C</A>,<A>n</A>).
#! @Returns a morphism in C
#! @Arguments R, n
DeclareOperation( RandomMorphismWithFixedRangeByInteger, [ IsAdditiveClosureObject, IsInt ] );

#! @Description
#! The arguments are an additive closure category <A>C</A> and a list <A>L</A> consisiting of three lists.
#! The output is <C>RandomMorphismWithFixedSourceAndRangeByList</C>($S$,$R$,<A>L</A>[3])) where
#! $S$ and $R$ are computed via <C>RandomObjectByList</C>(<A>C</A>,<A>L</A>[i]) for $i=1,2$ respectively.
#! @Returns  a morphism in C
#! @Arguments C, L
DeclareOperation( RandomMorphismByList, [ IsAdditiveClosureCategory, IsList ] );

#! @Description
#! The arguments are an additive closure category <A>C</A> and a non-negative integer <A>n</A>.
#! The output is <C>RandomMorphismWithFixedSourceAndRangeByInteger</C>($S$,$R$,$1$+<C>Log2Int</C>(<A>n</A>))) where
#! $S$ and $R$ are computed via <C>RandomObjectByInteger</C>(<A>C</A>,<A>n</A>).
#! @Returns  a morphism in C
#! @Arguments C, n
DeclareOperation( RandomMorphismByInteger, [ IsAdditiveClosureCategory, IsInt ] );

fi;

####################################
##
#! @Section Global functions
##
####################################

#! @Description
#!   A (faster) version of `NullMat` returning an immutable matrix.
DeclareGlobalFunction( "NullMatImmutable" );
CapJitAddTypeSignature( "NullMatImmutable", [ IsInt, IsInt ], rec( filter := IsList, element_type := rec( filter := IsList, element_type := rec( filter := IsInt ) ) ) );

#! @Description
#!   Stacks the matrices (lists of lists) in the list <A>L</A>. The matrices must have `nr_cols` columns.
#! @Arguments nr_cols, L
#! @Returns a list of lists
DeclareGlobalFunction( "UnionOfRowsListList" );

CapJitAddTypeSignature( "UnionOfRowsListList", [ IsInt, IsList ], function ( input_types )
    
    Assert( 0, input_types[2].element_type.filter = IsList );
    Assert( 0, input_types[2].element_type.element_type.filter = IsList );
    
    return input_types[2].element_type;
    
end );

#! @Description
#!   Augments the matrices (lists of lists) in the list <A>L</A>. The matrices must have `nr_rows` rows.
#! @Arguments nr_rows, L
#! @Returns a list of lists
DeclareGlobalFunction( "UnionOfColumnsListList" );

CapJitAddTypeSignature( "UnionOfColumnsListList", [ IsInt, IsList ], function ( input_types )
    
    Assert( 0, input_types[2].element_type.filter = IsList );
    Assert( 0, input_types[2].element_type.element_type.filter = IsList );
    
    return input_types[2].element_type;
    
end );
