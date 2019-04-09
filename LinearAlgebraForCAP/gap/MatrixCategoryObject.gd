#############################################################################
##
##                                LinearAlgebraForCAP package
##
##  Copyright 2015, Sebastian Gutsche, TU Kaiserslautern
##                  Sebastian Posur,   RWTH Aachen
##
#! @Chapter Category of Matrices
##
#############################################################################

####################################
##
#! @Section GAP Categories
##
####################################

#! @Description
#! The GAP category of objects in the category
#! of matrices of a field $F$.
#! @Arguments object
DeclareCategory( "IsVectorSpaceObject",
                 IsCapCategoryObject and IsCellOfSkeletalCategory );

####################################
##
#! @Section Constructors
##
####################################

#! @Description
#! The arguments are a non-negative integer $d$
#! and a homalg field $F$.
#! The output is an object in the category of
#! matrices over $F$ of dimension $d$.
#! @Returns an object
#! @Arguments d, F
DeclareOperationWithCache( "VectorSpaceObject",
                           [ IsInt, IsFieldForHomalg ] );

if false then

  #! @Description
  #! The arguments are a category <A>C</A> and an integer <A>n</A>. The output is a vector space of dimension at most <A>n</A>
  #! if <A>n</A> is non-negative and <C>fail</C> otherwise.
  #! @Returns a vector space
  #! @Arguments C, n
  DeclareOperation( RandomObjectByInteger, [ IsCapMatrixCategory, IsInt ] );
  
  #! @Description
  #! The arguments are a category <A>C</A> and a nonempty list <A>L</A> of integers. The output is a vector space whose
  #! dimension is a random element in <A>L</A>. Hence the output may be <C>fail</C> if <A>L</A> contains negative integers.
  #! @Returns a vector space
  #! @Arguments C, L
  DeclareOperation( RandomObjectByList, [ IsCapMatrixCategory, IsList ] );

fi;


####################################
##
#! @Section Attributes
##
####################################

#! @Description
#! The argument is an object $A$ in the matrix category over a
#! homalg field $F$.
#! The output is the field $F$.
#! @Returns a homalg field
#! @Arguments A
DeclareAttribute( "UnderlyingFieldForHomalg",
                  IsVectorSpaceObject );

#! @Description
#! The argument is an object $A$ in a matrix category.
#! The output is the dimension of $A$.
#! @Returns a non-negative integer
#! @Arguments A
DeclareAttribute( "Dimension",
                  IsVectorSpaceObject );
