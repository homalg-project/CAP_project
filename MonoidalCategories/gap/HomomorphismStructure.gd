####################################
##
#! @Chapter Monoidal Categories
##
#! @Section Homomorphism Structure
##
####################################

#! The following operations are used by &CAP; to derive a homomorphism structure
#! from the closed structure of the closed monoidal category.

DeclareGlobalVariable( "CAP_INTERNAL_CLOSED_MONOIDAL_CATEGORIES_WITH_COMPATIBLE_HOMOMORPHISM_STRUCTURE_BASIC_OPERATIONS" );

DeclareGlobalVariable( "HOMOMORPHISM_STRUCTURE_FROM_CLOSED_STRUCTURE_METHOD_NAME_RECORD" );

#! @Description
#!  The argument is an object $a$.
#!  The output is a morphism $\eta: h \to a$,
#!  such for for each morphism $\iota: 1 \to a$ from the tensor unit $1$
#!  there exists a lift $\lambda: 1 \to h$ of $\iota$ along $\eta$.
#! @Returns a morphism in $\mathrm{Hom}(h,a)$
#! @Arguments a
DeclareOperation( "MorphismLiftingMorphismsFromTensorUnit",
                  [ IsCapCategoryObject ] );

#! @Description
#!  The argument is a morphism $\iota: 1 \to a$ from the tensor unit $1$.
#!  The output is a lift $\lambda: 1 \to h$ of $\iota$ along $\eta:h \to a$,
#!  where $\eta =$ <C>MorphismLiftingMorphismsFromTensorUnit</C>($a$)
#! @Returns a morphism in $\mathrm{Hom}(1,h)$
#! @Arguments iota
DeclareOperation( "LiftAlongMorphismLiftingMorphismsFromTensorUnit",
                  [ IsCapCategoryMorphism ] );

#! @Description
#!  The arguments are two morphisms $\iota: 1 \to a$ and $\eta:h \to a$,
#!  where $1$ is the tensor unit.
#!  The output is a lift $\lambda: 1 \to h$ of $\iota$ along $\eta$.
#! @Returns a morphism in $\mathrm{Hom}(1,h)$
#! @Arguments iota, eta
DeclareOperation( "LiftAlongMorphismLiftingMorphismsFromTensorUnitWithGivenMorphism",
                  [ IsCapCategoryMorphism, IsCapCategoryMorphism ] );

#! @Description
#!  The argument is an object $a$.
#!  The output is a morphism $\eta: h \to a$,
#!  such for for each morphism $\iota: 1 \to a$ from the tensor unit $1$
#!  there exists a unique lift $\lambda: 1 \to h$ of $\iota$ along $\eta$.
#! @Returns a morphism in $\mathrm{Hom}(h,a)$
#! @Arguments a
DeclareOperation( "MorphismUniquelyLiftingMorphismsFromTensorUnit",
                  [ IsCapCategoryObject ] );

#! @Description
#!  The argument is a morphism $\iota: 1 \to a$ from the tensor unit $1$.
#!  The output is the unique lift $\lambda: 1 \to h$ of $\iota$ along $\eta:h \to a$,
#!  where $\eta =$ <C>MorphismUniquelyLiftingMorphismsFromTensorUnit</C>($a$)
#! @Returns a morphism in $\mathrm{Hom}(1,h)$
#! @Arguments iota
DeclareOperation( "LiftAlongMorphismUniquelyLiftingMorphismsFromTensorUnit",
                  [ IsCapCategoryMorphism ] );

#! @Description
#!  The arguments are two morphisms $\iota: 1 \to a$ and $\eta:h \to a$,
#!  where $1$ is the tensor unit.
#!  The output is the unique lift $\lambda: 1 \to h$ of $\iota$ along $\eta$.
#! @Returns a morphism in $\mathrm{Hom}(1,h)$
#! @Arguments iota, eta
DeclareOperation( "LiftAlongMorphismUniquelyLiftingMorphismsFromTensorUnitWithGivenMorphism",
                  [ IsCapCategoryMorphism, IsCapCategoryMorphism ] );

#! @Description
#!  The argument is a morphism $h$ in the category $C$,
#!  for which there exists an object $a$ in $C$ such that
#!  $h=$<C>Source</C>(<C>LiftAlongMorphismLiftingMorphismsFromTensorUnit</C>($a$)).
#!  The output is an object in the range category $D$
#!  of the homomorphism structure on $C$.
#! @Returns an object in $D$
#! @Arguments h
DeclareOperation( "InterpretAsObjectInRangeCategoryOfHomomorphismStructure",
                  [ IsCapCategoryObject ] );

#! @Description
#!  The argument is an object $\alpha:h_1 \to h_2$ in the category $C$,
#!  for which there exist objects $a_1, a_2$ in $C$ such that
#!  $h_i=$<C>Source</C>(<C>LiftAlongMorphismLiftingMorphismsFromTensorUnit</C>($a_i$))
#!  for $i=1,2$. The output is a morphism in the range category $D$
#!  of the homomorphism structure on $C$.
#! @Returns a morphism in $D$
#! @Arguments alpha
DeclareOperation( "InterpretAsMorphismInRangeCategoryOfHomomorphismStructure",
                  [ IsCapCategoryMorphism ] );

#! @Description
#!  The argument is an object $o$ in the range category $D$
#!  of the homomorphism structure on the category $C$.
#!  The output is an object $h$ in the category $C$ such that
#!  $o=$<C>InterpretAsObjectInRangeCategoryOfHomomorphismStructure</C>($h$).
#! @Returns an object in $C$
#! @Arguments o
DeclareOperation( "InterpretObjectFromRangeCategoryOfHomomorphismStructure",
                  [ IsCapCategory, IsCapCategoryObject ] );

#! @Description
#!  The argument is a morphism $\omega:o_1 \to o_2$ in the range category $D$
#!  of the homomorphism structure on the category $C$.
#!  The output is a morphism $\alpha:h_1 \to h_2$ in the category $C$ such that
#!  $\omega=$<C>InterpretAsMorphismInRangeCategoryOfHomomorphismStructure</C>($\alpha$).
#! @Returns a morphism in $C$
#! @Arguments omega
DeclareOperation( "InterpretMorphismFromRangeCategoryOfHomomorphismStructure",
                  [ IsCapCategory, IsCapCategoryMorphism ] );
