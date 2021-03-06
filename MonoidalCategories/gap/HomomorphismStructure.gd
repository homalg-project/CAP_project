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
#!  The arguments are a category $C$ and a function $F$.
#!  This operation adds the given function $F$
#!  to the category for the basic operation <C>MorphismLiftingMorphismsFromTensorUnit</C>.
#! @Returns nothing
#! @Arguments C, F
DeclareOperation( "AddMorphismLiftingMorphismsFromTensorUnit",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddMorphismLiftingMorphismsFromTensorUnit",
                  [ IsCapCategory, IsFunction, IsInt ] );

DeclareOperation( "AddMorphismLiftingMorphismsFromTensorUnit",
                  [ IsCapCategory, IsList, IsInt ] );

DeclareOperation( "AddMorphismLiftingMorphismsFromTensorUnit",
                  [ IsCapCategory, IsList ] );

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
#!  The arguments are a category $C$ and a function $F$.
#!  This operation adds the given function $F$
#!  to the category for the basic operation <C>LiftAlongMorphismLiftingMorphismsFromTensorUnitWithGivenMorphism</C>.
#! @Returns nothing
#! @Arguments C, F
DeclareOperation( "AddLiftAlongMorphismLiftingMorphismsFromTensorUnitWithGivenMorphism",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddLiftAlongMorphismLiftingMorphismsFromTensorUnitWithGivenMorphism",
                  [ IsCapCategory, IsFunction, IsInt ] );

DeclareOperation( "AddLiftAlongMorphismLiftingMorphismsFromTensorUnitWithGivenMorphism",
                  [ IsCapCategory, IsList, IsInt ] );

DeclareOperation( "AddLiftAlongMorphismLiftingMorphismsFromTensorUnitWithGivenMorphism",
                  [ IsCapCategory, IsList ] );

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
#!  The arguments are a category $C$ and a function $F$.
#!  This operation adds the given function $F$
#!  to the category for the basic operation <C>MorphismUniquelyLiftingMorphismsFromTensorUnit</C>.
#! @Returns nothing
#! @Arguments C, F
DeclareOperation( "AddMorphismUniquelyLiftingMorphismsFromTensorUnit",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddMorphismUniquelyLiftingMorphismsFromTensorUnit",
                  [ IsCapCategory, IsFunction, IsInt ] );

DeclareOperation( "AddMorphismUniquelyLiftingMorphismsFromTensorUnit",
                  [ IsCapCategory, IsList, IsInt ] );

DeclareOperation( "AddMorphismUniquelyLiftingMorphismsFromTensorUnit",
                  [ IsCapCategory, IsList ] );

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
#!  The arguments are a category $C$ and a function $F$.
#!  This operation adds the given function $F$
#!  to the category for the basic operation <C>LiftAlongMorphismUniquelyLiftingMorphismsFromTensorUnitWithGivenMorphism</C>.
#! @Returns nothing
#! @Arguments C, F
DeclareOperation( "AddLiftAlongMorphismUniquelyLiftingMorphismsFromTensorUnitWithGivenMorphism",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddLiftAlongMorphismUniquelyLiftingMorphismsFromTensorUnitWithGivenMorphism",
                  [ IsCapCategory, IsFunction, IsInt ] );

DeclareOperation( "AddLiftAlongMorphismUniquelyLiftingMorphismsFromTensorUnitWithGivenMorphism",
                  [ IsCapCategory, IsList, IsInt ] );

DeclareOperation( "AddLiftAlongMorphismUniquelyLiftingMorphismsFromTensorUnitWithGivenMorphism",
                  [ IsCapCategory, IsList ] );

#! @Description
#!  The argument is an object $h$ in the category $C$,
#!  for which there exists an object $a$ in $C$ such that
#!  $h=$<C>Source</C>(<C>LiftAlongMorphismLiftingMorphismsFromTensorUnit</C>($a$)).
#!  The output is an object in the range category $D$
#!  of the homomorphism structure on $C$.
#! @Returns an object in $D$
#! @Arguments h
DeclareOperation( "InterpretAsObjectInRangeCategoryOfHomomorphismStructure",
                  [ IsCapCategoryObject ] );

#! @Description
#!  The arguments are a category $C$ and a function $F$.
#!  This operation adds the given function $F$
#!  to the category for the basic operation
#!  <C>InterpretAsObjectInRangeCategoryOfHomomorphismStructure</C>.
#! @Returns nothing
#! @Arguments C, F
DeclareOperation( "AddInterpretAsObjectInRangeCategoryOfHomomorphismStructure",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddInterpretAsObjectInRangeCategoryOfHomomorphismStructure",
                  [ IsCapCategory, IsFunction, IsInt ] );

DeclareOperation( "AddInterpretAsObjectInRangeCategoryOfHomomorphismStructure",
                  [ IsCapCategory, IsList, IsInt ] );

DeclareOperation( "AddInterpretAsObjectInRangeCategoryOfHomomorphismStructure",
                  [ IsCapCategory, IsList ] );

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
#!  The arguments are a category $C$ and a function $F$.
#!  This operation adds the given function $F$
#!  to the category for the basic operation
#!  <C>InterpretAsMorphismInRangeCategoryOfHomomorphismStructure</C>.
#! @Returns nothing
#! @Arguments C, F
DeclareOperation( "AddInterpretAsMorphismInRangeCategoryOfHomomorphismStructure",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddInterpretAsMorphismInRangeCategoryOfHomomorphismStructure",
                  [ IsCapCategory, IsFunction, IsInt ] );

DeclareOperation( "AddInterpretAsMorphismInRangeCategoryOfHomomorphismStructure",
                  [ IsCapCategory, IsList, IsInt ] );

DeclareOperation( "AddInterpretAsMorphismInRangeCategoryOfHomomorphismStructure",
                  [ IsCapCategory, IsList ] );

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
#!  The arguments are a category $C$ and a function $F$.
#!  This operation adds the given function $F$
#!  to the category for the basic operation
#!  <C>InterpretObjectFromRangeCategoryOfHomomorphismStructure</C>.
#! @Returns nothing
#! @Arguments C, F
DeclareOperation( "AddInterpretObjectFromRangeCategoryOfHomomorphismStructure",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddInterpretObjectFromRangeCategoryOfHomomorphismStructure",
                  [ IsCapCategory, IsFunction, IsInt ] );

DeclareOperation( "AddInterpretObjectFromRangeCategoryOfHomomorphismStructure",
                  [ IsCapCategory, IsList, IsInt ] );

DeclareOperation( "AddInterpretObjectFromRangeCategoryOfHomomorphismStructure",
                  [ IsCapCategory, IsList ] );

#! @Description
#!  The argument is a morphism $\omega:o_1 \to o_2$ in the range category $D$
#!  of the homomorphism structure on the category $C$.
#!  The output is a morphism $\alpha:h_1 \to h_2$ in the category $C$ such that
#!  $\omega=$<C>InterpretAsMorphismInRangeCategoryOfHomomorphismStructure</C>($\alpha$).
#! @Returns a morphism in $C$
#! @Arguments omega
DeclareOperation( "InterpretMorphismFromRangeCategoryOfHomomorphismStructure",
                  [ IsCapCategory, IsCapCategoryMorphism ] );

#! @Description
#!  The arguments are a category $C$ and a function $F$.
#!  This operation adds the given function $F$
#!  to the category for the basic operation
#!  <C>InterpretMorphismFromRangeCategoryOfHomomorphismStructure</C>.
#! @Returns nothing
#! @Arguments C, F
DeclareOperation( "AddInterpretMorphismFromRangeCategoryOfHomomorphismStructure",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddInterpretMorphismFromRangeCategoryOfHomomorphismStructure",
                  [ IsCapCategory, IsFunction, IsInt ] );

DeclareOperation( "AddInterpretMorphismFromRangeCategoryOfHomomorphismStructure",
                  [ IsCapCategory, IsList, IsInt ] );

DeclareOperation( "AddInterpretMorphismFromRangeCategoryOfHomomorphismStructure",
                  [ IsCapCategory, IsList ] );
