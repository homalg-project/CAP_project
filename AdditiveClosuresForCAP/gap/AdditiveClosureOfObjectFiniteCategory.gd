# SPDX-License-Identifier: GPL-2.0-or-later
# FiniteCocompletions: Finite (co)product/(co)limit (co)completions
#
# Declarations
#

#! @Chapter Additive closure of an object finite category

#! @BeginChunk AddClosureObjFinIntroduction

#! Let $C$ be a pre-additive category and $C^\oplus \coloneqq \texttt{AdditiveClosure}( C )$.
#! An object $O = o_1 \oplus \dots \oplus o_n$ of $C^\oplus$ is modeled as a list
#! of objects $[ o_1, \dots, o_n ]$ with $o_i \in C$. If $C$ has only finitely
#! many objects $\{ o_1, \dots, o_n \}$, a shorter data structure for the objects of $C^\oplus$
#! can be achieved by remembering only the multiplicities of each object $o_j \in C$ in the list $o$.
#!
#! As an example, assume $C$ contains exactly four objects $\{ o_1, o_2, o_3, o_4 \}$ and let
#! @BeginLatexOnly
#! \begin{center}
#!      $o \coloneqq o_2 \oplus o_3 \oplus o_1 \oplus o_3 \oplus o_2 \oplus o_2 \in C^\oplus$
#! \end{center}
#! @EndLatexOnly
#! be modeled by the list $[ o_2, o_3, o_1, o_3, o_2, o_2 ]$.
#! We can abbreviate this by remembering only the list of multiplicities $[ 1, 3, 2, 0 ]$.
#! The object $o_1$ occurs one time, $o_2$ occurs three times, $o_3$ occurs two times
#! and $o_4$ occurs zero times in $o$.
#! For compilation purposes, we additionally store the sum of all multiplicities, which is 6.
#! The final result is thus $o = [ 6, [ 1, 3, 2, 0 ] ]$.
#! Notice, that this requires an ordering on the set of objects of $C$.
#!
#! The morphisms in $C^\oplus$ are given by matrices whose entries are morphisms
#! in $C$ and whose matrix-dimensions are given by the number of objects in the source and
#! range lists. In the case that $C$ has only finitely many objects,
#! this constructor uses the same datastructure, however, the ordering of the
#! underlying objects of $C$ has to be respected.
#!
#! Again, as an example, a morphism $o_1 \oplus o_1 \oplus o_2 \rightarrow o_2 \oplus o_3$
#! is given by the below matrix.
#!
#! @BeginLatexOnly
#! \begin{center}
#!    \[
#!      \begin{array}{c|cc}
#!              & o_2    & o_3 \\
#!          \hline
#!          o_1 & m_{12} & m_{13} \\
#!          o_1 & m_{12} & m_{13} \\
#!          o_2 & m_{22} & m_{23}
#!      \end{array}
#!    \]
#! \end{center}
#! @EndLatexOnly
#!
#! If $C$ is skeletal, then this additive closure is also skeletal.

#! @EndChunk

####################################
##
#! @Section GAP Categories
##
####################################

#! @Description
#!  The &GAP; category of additive closures of object finite Ab-categories.
#! @Arguments object
#! @Returns true or false
DeclareCategory( "IsAdditiveClosureOfObjectFiniteCategory",
                 IsCapCategory );

#! @Description
#!  The &GAP; category of objects in additive closures of object finite Ab-categories.
#! @Arguments object
#! @Returns true or false
DeclareCategory( "IsObjectInAdditiveClosureOfObjectFiniteCategory",
                 IsCapCategoryObject );

#! @Description
#!  The &GAP; category of morphisms in additive closures of object finite Ab-categories.
#! @Arguments object
#! @Returns true or false
DeclareCategory( "IsMorphismInAdditiveClosureOfObjectFiniteCategory",
                 IsCapCategoryMorphism );

DeclareGlobalFunction( "INSTALL_FUNCTIONS_FOR_ADDITIVE_CLOSURE_OF_OBJECT_FINITE_CATEGORY" );

####################################
##
#! @Section Constructors
##
####################################

#! @Description
#!  The argument is an object finite pre-additive category $C$. The output is its additive closure $C^\oplus$.
#! @Arguments C
#! @Returns the category $C^\oplus$
DeclareAttribute( "AdditiveClosureOfObjectFiniteCategory",
                  IsCapCategory );

#! @Description
#!  Same as <Ref Attr="AdditiveClosureOfObjectFiniteCategory" Label="for IsCapCategory" />, but as an operation instead of an attribute.
#! @Arguments C
#! @Returns the category $C^\oplus$
DeclareOperation( "ADDITIVE_CLOSURE_OF_OBJECT_FINITE_CATEGORY",
                  [ IsCapCategory ] );

if false then
#! @Description
#!  The input is an additive closure <A>AC</A><C> := AdditiveClosureOfObjectFiniteCategory(</C> $A$ <C>)</C>
#!  of an object finite pre-additive category <A>A</A> and a list of the format
#!  $[ s, [ m_1, ..., m_n ] ]$ representing a direct sum $o_1^{m_1} \oplus \dots \oplus o_n^{m_n}$ where
#!  * $o_1, \dots, o_n$ are all of the objects in the underlying category;
#!  * $m_1, ..., m_n$ are non-negative integers representing the multiplicties;
#!  * $s$ is the sum of integers $m_1 + \dots + m_n$.
#!  See also <Ref Attr="NrSummandsAndMultiplicities" Label="for IsObjectInAdditiveClosureOfObjectFiniteCategory" />.
#! @Arguments AC, l
#! @Returns an object in $C^\oplus$
DeclareOperation( "ObjectConstructor", [ IsAdditiveClosureOfObjectFiniteCategory, IsList ] );
fi;

#! @Description
#!  This method takes the same arguments as <C>ObjectConstructor</C> and delegates to it.
#! @Arguments AC, l
#! @Returns an object in $C^\oplus$
DeclareOperation( "AdditiveClosureObject",
                  [ IsAdditiveClosureOfObjectFiniteCategory, IsList ] );

CapJitAddTypeSignature( "AdditiveClosureObject", [ IsAdditiveClosureOfObjectFiniteCategory, IsList ],
  function ( input_types )
    
    return CapJitDataTypeOfObjectOfCategory( input_types[1].category );
    
end );

if false then
#! @Description
#!  The input is an additive closure <A>AC</A><C> := AdditiveClosureOfObjectFiniteCategory(</C> $A$ <C>)</C>
#!  of an object finite pre-additive category <A>A</A>,
#!  * <A>s</A> is the source object,
#!  * <A>matrix</A> is a list of lists of morphisms in A,
#!  * <A>t</A> is the target object.
#!  See also <Ref Attr="MorphismMatrix" Label="for IsMorphismInAdditiveClosureOfObjectFiniteCategory" />.
#! @Arguments AC, s, matrix, t
#! @Returns an morphism in $C^\oplus$
DeclareOperation( "MorphismConstructor", [ IsAdditiveClosureOfObjectFiniteCategory, ] );
fi;

#! @Description
#!  This method takes the same arguments as <C>MorphismConstructor</C> and delegates to it.
#! @Arguments AC, s, matrix, t
#! @Returns an morphism in $C^\oplus$
DeclareOperation( "AdditiveClosureMorphism",
                  [ IsObjectInAdditiveClosureOfObjectFiniteCategory,
                    IsList,
                    IsObjectInAdditiveClosureOfObjectFiniteCategory
                  ] );

CapJitAddTypeSignature( "AdditiveClosureMorphism",
                        [ IsAdditiveClosureOfObjectFiniteCategory,
                          IsObjectInAdditiveClosureOfObjectFiniteCategory,
                          IsList,
                          IsObjectInAdditiveClosureOfObjectFiniteCategory ],
  function ( input_types )
    
    return CapJitDataTypeOfMorphismOfCategory( input_types[1].category );
    
end );

####################################
#
#! @Section Attributes
#
####################################

#! @Description
#!  Return the category $A$ underlying the additive closure
#!  <A>AC</A><C> := AdditiveClosureOfObjectFiniteCategory(</C> $A$ <C>)</C>.
#! @Arguments AC
#! @Returns $A$.
DeclareAttribute( "UnderlyingCategory", IsAdditiveClosureOfObjectFiniteCategory );

CapJitAddTypeSignature( "UnderlyingCategory", [ IsAdditiveClosureOfObjectFiniteCategory ],
  function ( input_types )
    
    return CapJitDataTypeOfCategory( UnderlyingCategory( input_types[1].category ) );
    
end );

#! @Description
#! @Arguments AC
#! @Returns a list of objects of the underlying category.
DeclareAttribute( "ListOfObjectsOfUnderlyingCategory", IsAdditiveClosureOfObjectFiniteCategory );

CapJitAddTypeSignature( "ListOfObjectsOfUnderlyingCategory", [ IsAdditiveClosureOfObjectFiniteCategory ],
  function ( input_types )
    
    return CapJitDataTypeOfListOf( CapJitDataTypeOfObjectOfCategory( UnderlyingCategory( input_types[1].category ) ) );
    
end );

#! @Description
#!  Return the number of objects in the category $A$ underlying the additive closure
#!  <A>AC</A><C> := AdditiveClosureOfObjectFiniteCategory(</C> $A$ <C>)</C>.
#! @Arguments AC
#! @Returns an integer
DeclareAttribute( "NumberOfObjectsOfUnderlyingCategory", IsAdditiveClosureOfObjectFiniteCategory );

CapJitAddTypeSignature( "NumberOfObjectsOfUnderlyingCategory", [ IsAdditiveClosureOfObjectFiniteCategory ], IsBigInt );

#! @Description
#!  The argument is an object $O$ in the additive closure of an object finite pre-additive category.
#!  It returns a list of the format $[ s, [ m_1, ..., m_n ] ]$ representing a direct sum $o_1^{m_1} \oplus \dots \oplus o_n^{m_n}$ where
#!  * $o_1, \dots, o_n$ are all of the objects in the underlying category;
#!  * $m_1, ..., m_n$ are non-negative integers representing the multiplicties;
#!  * $s$ is the sum of integers $m_1 + \dots + m_n$, i.e., the number of summands of $A$.
#! @Arguments object
#! @Returns a list consisting of an integer and a list of integers.
DeclareAttribute( "NrSummandsAndMultiplicities", IsObjectInAdditiveClosureOfObjectFiniteCategory );

CapJitAddTypeSignature( "NrSummandsAndMultiplicities", [ IsObjectInAdditiveClosureOfObjectFiniteCategory ],
 function ( input_types )
    
    Assert( 0, IsAdditiveClosureOfObjectFiniteCategory( input_types[1].category ) );
    
    return CapJitDataTypeOfNTupleOf( 2, IsBigInt, CapJitDataTypeOfListOf( IsBigInt ) );
    
end );

#! @Description
#!  The argument is an object $O$ in the additive closure $C^\oplus$ of an object finite pre-additive category $C$.
#!  It returns a list of objects of $C$ in the format
#!  $[ \underbrace{o_1, \dots, o_1}_{m_1}, \dots, \underbrace{o_n, \dots, o_n}_{m_n} ]$
#!  corresponding to the list of multiplicties $[ s, [ m_1, ..., m_n ] ]$ of $A$.
#! @Arguments A
#! @Returns a list of objects of the underlying category.
DeclareOperation( "UnderlyingObjectList", [ IsAdditiveClosureOfObjectFiniteCategory, IsObjectInAdditiveClosureOfObjectFiniteCategory ] );

CapJitAddTypeSignature( "UnderlyingObjectList", [ IsAdditiveClosureOfObjectFiniteCategory, IsObjectInAdditiveClosureOfObjectFiniteCategory ],
  function ( input_types )
    
    Assert( 0, IsAdditiveClosureOfObjectFiniteCategory( input_types[2].category ) );
    
    return CapJitDataTypeOfListOf( CapJitDataTypeOfObjectOfCategory( UnderlyingCategory( input_types[1].category ) ) );
    
end );

#! @Description
#!  The argument is a morphism in the additive closure of an object finite pre-additive category.
#!  It returns a list of lists representing a matrix of morphisms of the underlying category.
#! @Arguments morphism
#! @Returns a list of lists of morphisms of the underlying category.
DeclareAttribute( "MorphismMatrix", IsMorphismInAdditiveClosureOfObjectFiniteCategory );

CapJitAddTypeSignature( "MorphismMatrix", [ IsMorphismInAdditiveClosureOfObjectFiniteCategory ],
 function ( input_types )
    
    Assert( 0, IsAdditiveClosureOfObjectFiniteCategory( input_types[1].category ) );
    
    return CapJitDataTypeOfListOf(
               CapJitDataTypeOfListOf(
                   CapJitDataTypeOfMorphismOfCategory( UnderlyingCategory( input_types[1].category ) ) ) );
    
end );

#! @Description
#!  The argument is a morphism $\alpha \colon A \to B$. The output is the number of rows
#!  of the morphism matrix of $\alpha$.
#! @Arguments alpha
#! @Returns an integer
DeclareAttribute( "NumberRows", IsMorphismInAdditiveClosureOfObjectFiniteCategory );

CapJitAddTypeSignature( "NumberRows", [ IsMorphismInAdditiveClosureOfObjectFiniteCategory ], IsBigInt );

#! @Description
#!  The argument is a morphism $\alpha \colon A \to B$. The output is the number of columns of the morphism matrix of $\alpha$.
#! @Arguments alpha
#! @Returns an integer
DeclareAttribute( "NumberColumns",
                  IsMorphismInAdditiveClosureOfObjectFiniteCategory );

CapJitAddTypeSignature( "NumberColumns", [ IsMorphismInAdditiveClosureOfObjectFiniteCategory ], IsBigInt );

####################################
##
#! @Section Operations
##
####################################

#! @Description
#!  The argument is an object $O$ in the additive closure $C^\oplus$ of an object finite pre-additive category $C$.
#!  It returns the number $s$ of summands of $A$ corresponding to the list of multiplicties
#!  $[ s, [ m_1, ..., m_n ] ]$ of $A$.
#! @Arguments A
#! @Returns an integer
DeclareOperation( "NrOfSummands", [ IsObjectInAdditiveClosureOfObjectFiniteCategory ] );

CapJitAddTypeSignature( "NrOfSummands", [ IsObjectInAdditiveClosureOfObjectFiniteCategory ], IsBigInt );

#! @Description
#!  The argument is an object $O$ in the additive closure $C^\oplus$ of an object finite pre-additive category $C$.
#!  It returns the list of multiplicties $[ m_1, \dots, m_n ]$ of $A$.
#! @Arguments A
#! @Returns a list of integers.
DeclareOperation( "Multiplicities", [ IsObjectInAdditiveClosureOfObjectFiniteCategory ] );

CapJitAddTypeSignature( "Multiplicities", [ IsObjectInAdditiveClosureOfObjectFiniteCategory ],
  function ( input_types )
    
    Assert( 0, IsAdditiveClosureOfObjectFiniteCategory( input_types[1].category ) );
    
    return CapJitDataTypeOfListOf( IsBigInt );
    
end );

#! @Description
#!  The argument is an object $O$ in an object finite pre-additive category $C$.
#!  It returns the mulitplicity list for $A$, i.e., a list of integers
#!  $[ 0, \dots, 0, 1, 0, \dots 0]$ where $1$.
#! @Arguments A
#! @Returns a list of integers.
DeclareOperation( "ObjectToMultiplicityList",
                  [ IsCapCategory and IsObjectFiniteCategory, IsCapCategoryObject ] );

CapJitAddTypeSignature( "ObjectToMultiplicityList",
                        [ IsCapCategory and IsObjectFiniteCategory, IsCapCategoryObject ],
  function ( input_types )
    
    return CapJitDataTypeOfListOf( IsBigInt );
    
end );

#! @Description
#!  The argument is a list of objects <C>L</C> in an object finite pre-additive category $C$.
#!  It returns the mulitplicity list for the objects in <C>L</C>.
#! @Arguments L
#! @Returns a list of integers.
DeclareOperation( "ObjectsToMultiplicityList",
                  [ IsCapCategory and IsObjectFiniteCategory, IsList ] );

CapJitAddTypeSignature( "ObjectsToMultiplicityList",
                        [ IsCapCategory and IsObjectFiniteCategory, IsList  ],
  function ( input_types )
    
    return CapJitDataTypeOfListOf( IsBigInt );
    
end );

####################################
##
#! @Section Operators
##
####################################

#! @Description
#!  The arguments are an object $O$ in an additive closure $C^\oplus$ of
#!  an object finite category $C$ and an integer $i$.
#!  The output is the $i$'th entry in <C>UnderlyingObjectList</C>($A$).
#! @Arguments A, i
#! @Returns an object in $C$
DeclareOperation( "[]", [ IsObjectInAdditiveClosureOfObjectFiniteCategory, IsInt ] );

CapJitAddTypeSignature( "[]", [ IsObjectInAdditiveClosureOfObjectFiniteCategory, IsInt ], function ( input_types )
    
    Assert( 0, IsAdditiveClosureOfObjectFiniteCategory( input_types[1].category ) );
    
    return CapJitDataTypeOfObjectOfCategory( UnderlyingCategory( input_types[1].category ) );
    
end );

#! @Description
#!  The arguments are a morphism $\alpha \colon A \to B$ in the additive closure $C^\oplus$  of
#!  an object finite pre-additive category $C$ and two integers $i,j$.
#!  The output is the $(i,j)$'th entry in <C>MorphismMatrix</C>($\alpha$).
#! @Arguments alpha, i, j
#! @Returns a morphism $C$
DeclareOperation( "[,]", [ IsMorphismInAdditiveClosureOfObjectFiniteCategory, IsInt, IsInt ] );

CapJitAddTypeSignature( "[,]", [ IsMorphismInAdditiveClosureOfObjectFiniteCategory, IsInt, IsInt ], function ( input_types )
    
    Assert( 0, IsAdditiveClosureOfObjectFiniteCategory( input_types[1].category ) );
    
    return CapJitDataTypeOfMorphismOfCategory( UnderlyingCategory( input_types[1].category ) );
    
end );

#! @Description
#!  The input is either
#!  * a list of objects or
#!  * a list of lists of morphisms
#!  in the underlying category.
#!  This operation then constructs either an object or a morphism in <C>AdditiveClosureOfObjectFiniteCategory</C>.
#!  For a list of objects, the list will be automatically sorted and the underlying
#!  order on the objects need not be respected.
#!  
#!  WARNING: Morphism lists of dimensions $0 \times n$ or $n \times 0$ are not supported.
#! @Arguments list, AC
DeclareOperation( "/",
                  [ IsList, IsAdditiveClosureOfObjectFiniteCategory ] );

#! @Description
#!  This is a convenience method for
#!  <C>ObjectConstructor</C> and <C>MorphismConstructor</C>.
#! @Arguments object or morphism, AC
#! @Returns an object or morphism in AC.
DeclareOperation( "/",
                  [ IsCapCategoryCell, IsAdditiveClosureOfObjectFiniteCategory ] );

