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

####################################
##
#! @Section Subobject Classifier
##
####################################

DeclareGlobalVariable( "TOPOS_METHOD_NAME_RECORD" );

#! @Section Subobject Classifier

#! @Description
#!  The property of <A>C</A> being an elementary topos.
#! @Arguments C
AddCategoricalProperty( [ "IsElementaryTopos", fail ] );

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
#! The argument is a category $C$.
#! The output is  cartesian square of a subobject classifier object $\Omega$ of $C$.
#! @Returns an object
#! @Arguments C
DeclareAttribute( "CartesianSquareOfSubobjectClassifier",
                  IsCapCategory );

#! @Description
#! The argument is a monomorphism $m : A \rightarrow S$.
#! The output is its classifying morphism
#! $\chi_m : S \rightarrow \mathrm{SubobjectClassifier}$.
#! @Returns a morphism in $\mathrm{Hom}( \mathrm{Range}(m), \mathrm{SubobjectClassifier} )$
#! @Arguments m
DeclareOperation( "ClassifyingMorphismOfSubobject",
                  [ IsCapCategoryMorphism ] );

#! @Description
#! The arguments are a monomorphism $m : A \rightarrow S$ and
#! a subobject classifier $\Omega$. The output is the classifying morphism
#! of the monomorphism $\chi_m : S \rightarrow \mathrm{SubobjectClassifier}$.
#! @Returns a morphism in $\mathrm{Hom}( \mathrm{Range}(m), \mathrm{SubobjectClassifier} )$
#! @Arguments m, omega
DeclareOperation( "ClassifyingMorphismOfSubobjectWithGivenSubobjectClassifier",
                  [ IsCapCategoryMorphism, IsCapCategoryObject ] );

#! @Description
#! The argument is a classifying morphism $\chi : S \rightarrow \Omega$.
#! The output is the subobject monomorphism of the classifying morphism,
#! $m : A \rightarrow S$.
#! @Returns a monomorphism in $\mathrm{Hom}( A, S )$
#! @Arguments chi
DeclareOperation( "SubobjectOfClassifyingMorphism",
                  [ IsCapCategoryMorphism ] );

####################################
##
#! @Section Truth Morphisms
##
####################################

#! @Description
#! The argument is a category $C$.
#! The output is the truth morphism of true into the subobject classifier
#! $\mathrm{true}: \mathrm{TerminalObject} \rightarrow \mathrm{SubobjectClassifier}$.
#! @Returns a morphism in $\mathrm{Hom}( \mathrm{TerminalObject}, \mathrm{SubobjectClassifier} )$
#! @Arguments C
DeclareOperation( "TruthMorphismOfTrue",
                  [ IsCapCategory ] );

#! @Description
#! The arguments are a terminal object of the category and
#! a subobject classifier.
#! The output is the truth morphism of true into the subobject classifier <A>Omega</A>
#! $\mathrm{true}: \mathrm{TerminalObject} \rightarrow \Omega$.
#! @Returns a morphism in $\mathrm{Hom}( \mathrm{TerminalObject}, \Omega )$
#! @Arguments T, Omega
DeclareOperation( "TruthMorphismOfTrueWithGivenObjects",
                  [ IsCapCategoryObject, IsCapCategoryObject ]);

#! @Description
#! The argument is a category $C$.
#! The output is the truth morphism of false into the subobject classifier
#! $\mathrm{false}: \mathrm{TerminalObject} \rightarrow \mathrm{SubobjectClassifier}$.
#! @Returns a morphism in $\mathrm{Hom}( \mathrm{TerminalObject}, \mathrm{SubobjectClassifier} )$
#! @Arguments C
DeclareOperation( "TruthMorphismOfFalse",
                  [ IsCapCategory ] );

#! @Description
#! The arguments are a terminal object of the category and
#! a subobject classifier.
#! The output is the truth morphism of false into the subobject classifier <A>Omega</A>
#! $\mathrm{false}: \mathrm{TerminalObject} \rightarrow \Omega$.
#! @Returns a morphism in $\mathrm{Hom}( \mathrm{TerminalObject}, \Omega )$
#! @Arguments T, Omega
DeclareOperation( "TruthMorphismOfFalseWithGivenObjects",
                  [ IsCapCategoryObject, IsCapCategoryObject ]);

#! @Description
#! The argument is a category $C$.
#! The output is the truth morphism of <Q>not</Q> of the subobject classifier
#! $\mathrm{not}: \mathrm{SubobjectClassifier} \rightarrow \mathrm{SubobjectClassifier}$.
#! @Returns a morphism in $\mathrm{Hom}( \mathrm{SubobjectClassifier}, \mathrm{SubobjectClassifier} )$
#! @Arguments C
DeclareOperation( "TruthMorphismOfNot",
                  [ IsCapCategory ] );

#! @Description
#! The argument is a subobject classifier.
#! The output is the truth endomorphism of <Q>not</Q> of the subobject classifier <A>Omega</A>
#! $\mathrm{not}: \Omega \rightarrow \Omega$.
#! @Returns a morphism in $\mathrm{Hom}( \Omega, \Omega )$
#! @Arguments Omega, Omega
DeclareOperation( "TruthMorphismOfNotWithGivenObjects",
                  [ IsCapCategoryObject, IsCapCategoryObject ]);

#! @Description
#! The argument is a category $C$.
#! The output is the truth morphism of <Q>and</Q> into the subobject classifier
#! $\mathrm{and}: \mathrm{CartesianSquareOfSubobjectClassifier} \rightarrow \mathrm{SubobjectClassifier}$.
#! @Returns a morphism in $\mathrm{Hom}( \mathrm{CartesianSquareOfSubobjectClassifier}, \mathrm{SubobjectClassifier} )$
#! @Arguments C
DeclareOperation( "TruthMorphismOfAnd",
                  [ IsCapCategory ] );

#! @Description
#! The arguments are a cartesian square of a subobject classifier of the category and
#! a subobject classifier.
#! The output is the truth morphism of <Q>and</Q> into the subobject classifier <A>Omega</A>
#! $\mathrm{and}: \Omega^{\times 2} \rightarrow \Omega$.
#! @Returns a morphism in $\mathrm{Hom}( \Omega^{\times 2}, \Omega )$
#! @Arguments Omega2, Omega
DeclareOperation( "TruthMorphismOfAndWithGivenObjects",
                  [ IsCapCategoryObject, IsCapCategoryObject ]);

#! @Description
#! The argument is a category $C$.
#! The output is the truth morphism of <Q>or</Q> into the subobject classifier
#! $\mathrm{or}: \mathrm{CartesianSquareOfSubobjectClassifier} \rightarrow \mathrm{SubobjectClassifier}$.
#! @Returns a morphism in $\mathrm{Hom}( \mathrm{CartesianSquareOfSubobjectClassifier}, \mathrm{SubobjectClassifier} )$
#! @Arguments C
DeclareOperation( "TruthMorphismOfOr",
                  [ IsCapCategory ] );

#! @Description
#! The arguments are a cartesian square of a subobject classifier of the category and
#! a subobject classifier.
#! The output is the truth morphism of <Q>or</Q> into the subobject classifier <A>Omega</A>
#! $\mathrm{or}: \Omega^{\times 2} \rightarrow \Omega$.
#! @Returns a morphism in $\mathrm{Hom}( \Omega^{\times 2}, \Omega )$
#! @Arguments Omega2, Omega
DeclareOperation( "TruthMorphismOfOrWithGivenObjects",
                  [ IsCapCategoryObject, IsCapCategoryObject ]);

#! @Description
#! The argument is a category $C$.
#! The output is the truth morphism of <Q>implies</Q> into the subobject classifier
#! $\mathrm{implies}: \mathrm{CartesianSquareOfSubobjectClassifier} \rightarrow \mathrm{SubobjectClassifier}$.
#! @Returns a morphism in $\mathrm{Hom}( \mathrm{CartesianSquareOfSubobjectClassifier}, \mathrm{SubobjectClassifier} )$
#! @Arguments C
DeclareOperation( "TruthMorphismOfImplies",
                  [ IsCapCategory ] );

#! @Description
#! The arguments are a cartesian square of a subobject classifier of the category and
#! a subobject classifier.
#! The output is the truth morphism of <Q>implies</Q> into the subobject classifier <A>Omega</A>
#! $\mathrm{implies}: \Omega^{\times 2} \rightarrow \Omega$.
#! @Returns a morphism in $\mathrm{Hom}( \Omega^{\times 2}, \Omega )$
#! @Arguments Omega2, Omega
DeclareOperation( "TruthMorphismOfImpliesWithGivenObjects",
                  [ IsCapCategoryObject, IsCapCategoryObject ]);

####################################
##
#! @Section Heyting Algebra of Subobjects
##
####################################

#! @Description
#!  The argument is a monomorphism $\iota: S \hookrightarrow A$.
#!  The output is the <Q>pseudo-complement of $S$ in $A$</Q>, i.e.,
#!  the pseudo-complement object of $\iota$.
#! @Returns an object
#! @Arguments iota
DeclareOperation( "PseudoComplementSubobject",
                  [ IsCapCategoryMorphism ]);

#! @Description
#!  The argument is a monomorphism $\iota: S \hookrightarrow A$.
#!  The output is the embedding <C>PseudoComplementSubobject</C>($\iota$) $\hookrightarrow A$
#!  of pseudo-complement object of $\iota$.
#! @Returns an object
#! @Arguments iota
DeclareOperation( "EmbeddingOfPseudoComplementSubobject",
                  [ IsCapCategoryMorphism ]);

#! @Description
#!  The argument is a monomorphism $\iota: S \hookrightarrow A$ and an object $T$ with
#!  <C>IsEqualForObjects</C>($T$, <C>PseudoComplementSubobject</C>($\iota$)).
#!  The output is the embedding of $\iota:T \hookrightarrow A$
#!  of pseudo-complement object $T$ of $\iota$.
#! @Returns an object
#! @Arguments iota
DeclareOperation( "EmbeddingOfPseudoComplementSubobjectWithGivenPseudoComplement",
                  [ IsCapCategoryMorphism, IsCapCategoryObject ]);
