# SPDX-License-Identifier: GPL-2.0-or-later
# FreydCategoriesForCAP: Freyd categories - Formal (co)kernels for additive categories
#
# Declarations
#
#! @Chapter Rings as categories

####################################
##
#! @Section GAP Categories
##
####################################

##
DeclareCategory( "IsRingAsCategoryObject",
                 IsCapCategoryObject );

DeclareCategory( "IsRingAsCategoryMorphism",
                 IsCapCategoryMorphism );

DeclareCategory( "IsRingAsCategory",
                 IsCapCategory );

DeclareGlobalFunction( "INSTALL_FUNCTIONS_FOR_RING_AS_CATEGORY" );

####################################
##
#! @Section Constructors
##
####################################

DeclareAttribute( "RingAsCategory",
                  IsRing );

DeclareOperation( "RING_AS_CATEGORY",
                  [ IsRing ] );

DeclareAttribute( "RingAsCategoryUniqueObject",
                  IsRingAsCategory );

CapJitAddTypeSignature( "RingAsCategoryUniqueObject", [ IsRingAsCategory ], function ( input_types )
    
    return CapJitDataTypeOfObjectOfCategory( input_types[1].category );
    
end );

DeclareOperation( "RingAsCategoryMorphism",
                  [ IsRingAsCategory, IsRingElement ] );

CapJitAddTypeSignature( "RingAsCategoryMorphism", [ IsRingAsCategory, IsRingElement ], function ( input_types )
    
    return CapJitDataTypeOfMorphismOfCategory( input_types[1].category );
    
end );

####################################
##
#! @Section Attributes
##
####################################

DeclareAttribute( "UnderlyingRingElement",
                  IsRingAsCategoryMorphism );
CapJitAddTypeSignature( "UnderlyingRingElement", [ IsRingAsCategoryMorphism ], function ( input_types )
    
    if HasRingElementFilter( UnderlyingRing( input_types[1].category ) ) then
        
        return rec( filter := RingElementFilter( UnderlyingRing( input_types[1].category ) ) );
        
    else
        
        return rec( filter := IsRingElement );
        
    fi;
    
end );

DeclareAttribute( "UnderlyingRing",
                  IsRingAsCategory );

CapJitAddTypeSignature( "UnderlyingRing", [ IsRingAsCategory ], function ( input_types )
    
    if HasRingFilter( UnderlyingRing( input_types[1].category ) ) then
        
        return rec( filter := RingFilter( UnderlyingRing( input_types[1].category ) ) );
        
    else
        
        return rec( filter := IsRing );
        
    fi;
    
end );

DeclareAttribute( "BasisOverBaseFieldAsColumnVector",
                  IsRingAsCategory );

CapJitAddTypeSignature( "BasisOverBaseFieldAsColumnVector", [ IsRingAsCategory ], function ( input_types )
    
    Assert( 0, IsHomalgRing( UnderlyingRing( input_types[1].category ) ) );
    
    return rec( filter := IsHomalgMatrix );
    
end );

####################################
##
#! @Section Operations
##
####################################

##
DeclareOperation( "\*",
                  [ IsRingAsCategoryMorphism, IsRingAsCategoryMorphism ] );

##
DeclareOperation( "\/",
                  [ IsRingElement, IsRingAsCategory ] );

####################################
##
#! @Section Random methods
##
####################################

if false then

#! @Description
#! The arguments are a ring as category <A>C</A> and a list <A>L</A> consisting of one integer.
#! The output is the unique object of <A>C</A>, i.e., <C>RingAsCategoryUniqueObject</C>(<A>C</A>).
#! @Returns an object in C
#! @Arguments C, L
DeclareOperation( RandomObjectByList, [ IsRingAsCategory, IsList ] );

#! @Description
#! The arguments are a ring as category <A>C</A> and an integer <A>n</A>.
#! The output is the unique object of <A>C</A>, i.e., <C>RingAsCategoryUniqueObject</C>(<A>C</A>).
#! @Returns an object in C
#! @Arguments C, n
DeclareOperation( RandomObjectByInteger, [ IsRingAsCategory, IsInt ] );

#! @Description
#! The arguments are two objects <A>S</A>, <A>R</A> and a list <A>L</A> consisting of one integer.
#! The output is a morphism from <A>S</A> to <A>R</A> whose underlying element is a sum of <A>L</A>[1] random elements in the underlying ring.
#! @Returns  a morphism in C
#! @Arguments S, R, L
DeclareOperation( RandomMorphismWithFixedSourceAndRangeByList, [ IsRingAsCategoryObject, IsRingAsCategoryObject, IsList ] );

#! @Description
#! The arguments are two objects <A>S</A>, <A>R</A> and an integer <A>n</A>.
#! The output is a morphism from <A>S</A> to <A>R</A> whose underlying element is a sum of <A>n</A> random elements in the underlying ring.
#! @Returns  a morphism in C
#! @Arguments S, R, n
DeclareOperation( RandomMorphismWithFixedSourceAndRangeByInteger, [ IsRingAsCategoryObject, IsRingAsCategoryObject, IsInt ] );

#! @Description
#! The arguments are an object <A>S</A> in a ring as category <A>C</A> and a list <A>L</A> consisting of one integer.
#! The output is an endomorphism of <A>S</A> whose underlying element is a sum of $1$+<C>Log2Int</C>(<A>L</A>[1]) random elements in the underlying ring.
#! @Returns a morphism in C
#! @Arguments S, L
DeclareOperation( RandomMorphismWithFixedSourceByList, [ IsRingAsCategoryObject, IsList ] );

#! @Description
#! The arguments are an object <A>S</A> in a ring as category <A>C</A> and an integer <A>n</A>.
#! The output is an endomorphism of <A>S</A> whose underlying element is a sum of $1$+<C>Log2Int</C>(<A>n</A>) random elements in the underlying ring.
#! @Returns  a morphism in C
#! @Arguments S, n
DeclareOperation( RandomMorphismWithFixedSourceByInteger, [ IsRingAsCategoryObject, IsInt ] );

#! @Description
#! The arguments are an object <A>R</A> in a ring as category <A>C</A> and a list <A>L</A> consisting of one integer.
#! The output is an endomorphism of <A>R</A> whose underlying element is a sum of $1$+<C>Log2Int</C>(<A>L</A>[1]) random elements in the underlying ring.
#! @Returns a morphism in C
#! @Arguments R, L
DeclareOperation( RandomMorphismWithFixedRangeByList, [ IsRingAsCategoryObject, IsList ] );

#! @Description
#! The arguments are an object <A>R</A> in a ring as category <A>C</A> and an integer <A>n</A>.
#! The output is an endomorphism of <A>R</A> whose underlying element is a sum of $1$+<C>Log2Int</C>(<A>n</A>) random elements in the underlying ring.
#! @Returns  a morphism in C
#! @Arguments R, n
DeclareOperation( RandomMorphismWithFixedRangeByInteger, [ IsRingAsCategoryObject, IsInt ] );

#! @Description
#! The arguments are a ring as category <A>C</A> and a list <A>L</A> consisting of one integer.
#! The output is an endomorphism of the unique object of <A>C</A> whose underlying element is a sum of $1$+<C>Log2Int</C>(<A>L</A>[1]) random elements in the underlying ring.
#! @Returns  a morphism in C
#! @Arguments C, L
DeclareOperation( RandomMorphismByList, [ IsRingAsCategory, IsList ] );

#! @Description
#! The arguments are a ring as category <A>C</A> and an integer <A>n</A>.
#! The output is an endomorphism of the unique object of <A>C</A> whose underlying element is a sum of $1$+<C>Log2Int</C>(<A>n</A>) random elements in the underlying ring.
#! @Returns  a morphism in C
#! @Arguments C, n
DeclareOperation( RandomMorphismByInteger, [ IsRingAsCategory, IsInt ] );

fi;

