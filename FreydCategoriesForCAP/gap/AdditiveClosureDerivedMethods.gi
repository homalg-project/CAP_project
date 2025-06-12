# SPDX-License-Identifier: GPL-2.0-or-later
# FreydCategoriesForCAP: Freyd categories - Formal (co)kernels for additive categories
#
# Implementations
#

##
AddDerivationToCAP( WeakKernelEmbedding,
                    "WeakKernelEmbedding in additive closures of categories with finite number of objects and homomorphism structure",
                    [ [ ObjectConstructor, 2 ],
                      [ BasisOfSolutionsOfHomogeneousLinearSystemInLinearCategory, 2 ],
                      [ IdentityMorphism, 2 ],
                      [ SetOfObjectsOfCategory, 1, UnderlyingCategory ],
                      [ DirectSum, 1 ],
                      [ UniversalMorphismFromDirectSumWithGivenDirectSum, 1 ]
                      ],
                    
  function ( cat, phi )
    local underlying_cat, objs, tau, diagram, S;
    
    underlying_cat := UnderlyingCategory( cat );
    
    objs := List( SetOfObjectsOfCategory( underlying_cat ), o -> ObjectConstructor( cat, [ o ] ) );
    
    tau := Concatenation( List( objs,
            o -> Concatenation( BasisOfSolutionsOfHomogeneousLinearSystemInLinearCategory( cat, [ [  IdentityMorphism( cat, o ) ] ], [ [ phi ] ] ) ) ) );
    
    diagram := List( tau, m -> Source( m ) );
    
    S := DirectSum( cat, diagram );
    
    return UniversalMorphismFromDirectSumWithGivenDirectSum( cat, diagram, Source( phi ), tau, S );
    
  end : CategoryGetters := rec( underlying_cat := UnderlyingCategory ),
        CategoryFilter := cat -> HasUnderlyingCategory( cat ) and HasIsObjectFiniteCategory( UnderlyingCategory( cat ) ) and IsObjectFiniteCategory( UnderlyingCategory( cat ) )
);

##
AddDerivationToCAP( WeakCokernelProjection,
                    "WeakCokernelProjection in additive closures of categories with finite number of objects and homomorphism structure",
                    [ [ ObjectConstructor, 2 ],
                      [ BasisOfSolutionsOfHomogeneousLinearSystemInLinearCategory, 2 ],
                      [ IdentityMorphism, 2 ],
                      [ SetOfObjectsOfCategory, 1, UnderlyingCategory ],
                      [ DirectSum, 1 ],
                      [ UniversalMorphismIntoDirectSumWithGivenDirectSum, 1 ]
                      ],
                    
  function ( cat, phi )
    local underlying_cat, objs, tau, diagram, S;
    
    underlying_cat := UnderlyingCategory( cat );
    
    objs := List( SetOfObjectsOfCategory( underlying_cat ), o -> ObjectConstructor( cat, [ o ] ) );
    
    tau := Concatenation( List( objs,
              o -> Concatenation( BasisOfSolutionsOfHomogeneousLinearSystemInLinearCategory( cat, [ [ phi ] ], [ [  IdentityMorphism( cat, o ) ] ]  ) ) ) );
    
    diagram := List( tau, m -> Target( m ) );
    
    S := DirectSum( cat, diagram );
    
    return UniversalMorphismIntoDirectSumWithGivenDirectSum( cat, diagram, Target( phi ), tau, S );
    
  end : CategoryGetters := rec( underlying_cat := UnderlyingCategory ),
        CategoryFilter := cat -> HasUnderlyingCategory( cat ) and HasIsObjectFiniteCategory( UnderlyingCategory( cat ) ) and IsObjectFiniteCategory( UnderlyingCategory( cat ) )
);
