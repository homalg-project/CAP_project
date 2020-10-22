# SPDX-License-Identifier: GPL-2.0-or-later
# Toposes: Elementary toposes
#
# Declarations
#

####################################
##
#! @Chapter Toposes
##
####################################

DeclareGlobalVariable( "TOPOS_METHOD_NAME_RECORD" );

#! @Section Subobject Classifier

#! @Description
#!  The property of <A>C</A> being an elementary topos.
#! @Arguments C
AddCategoricalProperty( [ "IsElementaryTopos" ] );

#! A subobject classifier object consists of three parts:
#! * an object $\Omega$,
#! * a function $\mathrm{true}$ providing a morphism $\mathrm{true}: 1 \rightarrow \Omega$,
#! * a function $\chi$ mapping each monomorphism $i : A \rightarrow S$ to a morphism $\chi_i : S \to \Omega$.
#! The triple $(\Omega,\mathrm{true},\chi)$ is called a <Emph>subobject classifier</Emph> if
#! for each monomorphism $i : A \to S$, the morphism $\chi_i : S \to \Omega$ is the unique
#! morphism such that $\chi_i \circ i = \mathrm{true} \circ \ast$ determine a pullback diagram.

#! @Description
#! The argument is a category $C$.
#! The output is a subobject classifier object $\Omega$ of $C$.
#! @Returns an object
#! @Arguments C
DeclareAttribute( "SubobjectClassifier",
                  IsCapCategory );

#! @Description
#! This is a convenience method.
#! The argument is a cell $c$.
#! The output is a subobject classifier $\Omega$ of the
#! category $C$ for which $c \in C$.
#! @Returns an object
#! @Arguments c
DeclareAttribute( "SubobjectClassifier",
                  IsCapCategoryCell );


#! @Description
#! The arguments are a terminal object of the category and
#! a subobject classifier.
#! The output is the truth morphism to the subobject classifier
#! $\mathrm{true}: \mathrm{TerminalObject} \rightarrow \mathrm{SubobjectClassifier}$.
#! @Returns a morphism in $\mathrm{Hom}( \mathrm{TerminalObject} , \mathrm{SubobjectClassifier} )$
#! @Arguments T, W
DeclareOperation( "TruthMorphismIntoSubobjectClassifierWithGivenObjects",
                  [ IsCapCategoryObject , IsCapCategoryObject ]);


#! @Description
#! The argument is a category $C$.
#! The output is the truth morphism to the subobject classifier 
#! $\mathrm{true}: \mathrm{TerminalObject} \rightarrow \mathrm{SubobjectClassifier}$.
#! @Returns a morphism in $\mathrm{Hom}( \mathrm{TerminalObject} , \mathrm{SubobjectClassifier} )$
#! @Arguments C
DeclareOperation( "TruthMorphismIntoSubobjectClassifier",
                  [ IsCapCategory ] );

#! @Description
#! This is a convenience method.
#! The argument is a cell $c$.
#! The output is the truth morphism to the subobject classifier 
#! $\mathrm{true}: \mathrm{TerminalObject} \rightarrow \mathrm{SubobjectClassifier}$
#! of the category $C$ for which $c \in C$.
#! @Returns a morphism in $\mathrm{Hom}( \mathrm{TerminalObject} , \mathrm{SubobjectClassifier} )$
#! @Arguments c
DeclareOperation( "TruthMorphismIntoSubobjectClassifier",
                  [ IsCapCategoryCell ] );


#! @Description
#! The argument is a monomorphism $m : A \rightarrow S$.
#! The output is its classifying morphism 
#! $\chi_m : S \rightarrow \mathrm{SubobjectClassifier}$.
#! @Returns a morphism in $\mathrm{Hom}( \mathrm{Range}(m) , \mathrm{SubobjectClassifier} )$
#! @Arguments m
DeclareOperation( "ClassifyingMorphismOfSubobject",
                  [ IsCapCategoryMorphism ] );

#! @Description
#! The arguments are a monomorphism $m : A \rightarrow S$ and
#! a subobject classifier $\Omega$. The output is the classifying morphism 
#! of the monomorphism $\chi_m : S \rightarrow \mathrm{SubobjectClassifier}$.
#! @Returns a morphism in $\mathrm{Hom}( \mathrm{Range}(m) , \mathrm{SubobjectClassifier} )$
#! @Arguments m, omega
DeclareOperation( "ClassifyingMorphismOfSubobjectWithGivenSubobjectClassifier",
                  [ IsCapCategoryMorphism , IsCapCategoryObject ] );


#! @Description
#! The argument is a classifying morphism $\chi : S \rightarrow \Omega$.
#! The output is the subobject monomorphism of the classifying morphism, 
#! $m : A \rightarrow S$.
#! @Returns a monomorphism in $\mathrm{Hom}( A , S )$
#! @Arguments chi
DeclareOperation( "SubobjectOfClassifyingMorphism" , 
                  [ IsCapCategoryMorphism ] );

#! @Description
#! The arguments are a category and a function $F$.
#! This operation adds the given function $F$
#! to the category for the basic operation <C>SubobjectClassifier</C>.
#! $F : () \mapsto \mathrm{SubobjectClassifier}$.
#! @Returns nothing
#! @Arguments C, F
DeclareOperation( "AddSubobjectClassifier",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddSubobjectClassifier",
                  [ IsCapCategory, IsFunction, IsInt ] );

## don't document this function
DeclareOperation( "AddSubobjectClassifier",
                  [ IsCapCategory, IsList, IsInt ] );

DeclareOperation( "AddSubobjectClassifier",
                  [ IsCapCategory, IsList ] );


#! @Description
#! The arguments are a category $C$ and a function $F$.
#! This operation adds the given function $F$ to the category
#! for the basic operation <C>ClassifyingMorphismOfSubobject</C>.
#! $F : m \mapsto \mathrm{ClassifyingMorphism}(m)$.
#! @Returns nothing
#! @Arguments C, F
DeclareOperation( "AddClassifyingMorphismOfSubobject",
                  [ IsCapCategory , IsFunction ] );

DeclareOperation( "AddClassifyingMorphismOfSubobject",
                  [ IsCapCategory, IsFunction, IsInt ] );

## don't document this function
DeclareOperation( "AddClassifyingMorphismOfSubobject",
                  [ IsCapCategory, IsList, IsInt ] );

DeclareOperation( "AddClassifyingMorphismOfSubobject",
                  [ IsCapCategory, IsList ] );

#! @Description
#! The arguments are a category $C$ and a function $F$.
#! This operation adds the given function $F$ to the category
#! for the basic operation <C>ClassifyingMorphismOfSubobjectWithGivenSubobjectClassifier</C>.
#! $F : (m, \Omega) \mapsto \mathrm{ClassifyingMorphism}(m)$.
#! @Returns nothing
#! @Arguments C, F
DeclareOperation( "AddClassifyingMorphismOfSubobjectWithGivenSubobjectClassifier",
                  [ IsCapCategory , IsFunction ] );

DeclareOperation( "AddClassifyingMorphismOfSubobjectWithGivenSubobjectClassifier",
                  [ IsCapCategory, IsFunction, IsInt ] );

## don't document this function
DeclareOperation( "AddClassifyingMorphismOfSubobjectWithGivenSubobjectClassifier",
                  [ IsCapCategory, IsList, IsInt ] );

DeclareOperation( "AddClassifyingMorphismOfSubobjectWithGivenSubobjectClassifier",
                  [ IsCapCategory, IsList ] );


#! @Description
#! The arguments are a category $C$ and a function $F$.
#! This operation adds the given function $F$ to the category
#! for the basic operation 
#! <C>TruthMorphismIntoSubobjectClassifierWithGivenObjects</C>.
#! $F : (1, \Omega) \mapsto \mathrm{true}$.
#! @Returns nothing
#! @Arguments C, F
DeclareOperation( "AddTruthMorphismIntoSubobjectClassifierWithGivenObjects",
                  [ IsCapCategory , IsFunction ] );

DeclareOperation( "AddTruthMorphismIntoSubobjectClassifierWithGivenObjects",
                  [ IsCapCategory, IsFunction, IsInt ] );

## don't document this function
DeclareOperation( "AddTruthMorphismIntoSubobjectClassifierWithGivenObjects",
                  [ IsCapCategory, IsList, IsInt ] );

DeclareOperation( "AddTruthMorphismIntoSubobjectClassifierWithGivenObjects",
                  [ IsCapCategory, IsList ] );


#! @Description
#! The arguments are a category $C$ and a function $F$.
#! This operation adds the given function $F$ to the category
#! for the basic operation <C>SubobjectOfClassifyingMorphism</C>.
#! $F : m \mapsto \mathrm{SubobjectOfClassifyingMorphism}(m)$.
#! @Returns nothing
#! @Arguments C, F
DeclareOperation( "AddSubobjectOfClassifyingMorphism",
                  [ IsCapCategory , IsFunction ] );

DeclareOperation( "AddSubobjectOfClassifyingMorphism",
                  [ IsCapCategory, IsFunction, IsInt ] );

## don't document this function
DeclareOperation( "AddSubobjectOfClassifyingMorphism",
                  [ IsCapCategory, IsList, IsInt ] );

DeclareOperation( "AddSubobjectOfClassifyingMorphism",
                  [ IsCapCategory, IsList ] );
