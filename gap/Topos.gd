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

## For internal use only:
## we need an operation name different from `Coproduct`, since CompilerForCAP
## seems to be unable to compile the CAP operation `Coproduct`
## if declared in a way different from that in the method record
DeclareOperation( "CoproductOp",
        [ IsCapCategory, IsCapCategoryObject, IsCapCategoryObject ] );

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

CAP_INTERNAL_CONSTRUCTIVE_CATEGORIES_RECORD.IsElementaryTopos :=
  SortedList(
          Concatenation( [
                  "SubobjectClassifier",
                  "ClassifyingMorphismOfSubobjectWithGivenSubobjectClassifier",
                  "TruthMorphismOfTrueWithGivenObjects", ## can be derived from SubobjectClassifier and ClassifyingMorphismOfSubobjectWithGivenSubobjectClassifier
                  "SubobjectOfClassifyingMorphism", ## can be derived from SubobjectClassifier and TruthMorphismOfTrueWithGivenObjects
                  ],
                  CAP_INTERNAL_CONSTRUCTIVE_CATEGORIES_RECORD.IsCartesianClosedCategory,
                  CAP_INTERNAL_CONSTRUCTIVE_CATEGORIES_RECORD.IsCocartesianCategory ) );

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

#! @Description
#!  The arguments are two monomorphisms $\iota_i: S_i \hookrightarrow A$ for $i=1,2$.
#!  The output is the <Q>intersection of $S_1$ and $S_2$</Q>, which is
#!  naturally isomorphic to the pullback of $\iota_1$ and $\iota_2$.
#! @Returns an object
#! @Arguments iota1, iota2
DeclareOperation( "IntersectionSubobject",
                  [ IsCapCategoryMorphism, IsCapCategoryMorphism ]);

#! @Description
#!  The arguments are two monomorphisms $\iota_i: S_i \hookrightarrow A$ for $i=1,2$.
#!  The output is the embedding <C>IntersectionSubobject</C>($\iota$) $\hookrightarrow A$ of their intersection subobject.
#! @Returns an object
#! @Arguments iota
DeclareOperation( "EmbeddingOfIntersectionSubobject",
                  [ IsCapCategoryMorphism, IsCapCategoryMorphism ]);

#! @Description
#!  The arguments are two monomorphisms $\iota_i: S_i \hookrightarrow A$ for $i=1,2$ and an object $T$ with
#!  <C>IsEqualForObjects</C>($T$, <C>IntersectionSubobject</C>($\iota$)).
#!  The output the embedding $T \hookrightarrow A$ of their intersection subobject $T$.
#! @Returns an object
#! @Arguments iota
DeclareOperation( "EmbeddingOfIntersectionSubobjectWithGivenIntersection",
                  [ IsCapCategoryMorphism, IsCapCategoryMorphism, IsCapCategoryObject ]);

#! @Description
#!  The arguments are two monomorphisms $\iota_i: S_i \hookrightarrow A$ for $i=1,2$.
#!  The output is the <Q>union of $S_1$ and $S_2$</Q>, which is
#!  naturally isomorphic to the image object of the coproduct morphism of $\iota_1$ and $\iota_2$.
#! @Returns an object
#! @Arguments iota1, iota2
DeclareOperation( "UnionSubobject",
                  [ IsCapCategoryMorphism, IsCapCategoryMorphism ]);

#! @Description
#!  The arguments are two monomorphisms $\iota_i: S_i \hookrightarrow A$ for $i=1,2$.
#!  The output is the embedding <C>UnionSubobject</C>($\iota$) $\hookrightarrow A$ of their union subobject.
#! @Returns an object
#! @Arguments iota
DeclareOperation( "EmbeddingOfUnionSubobject",
                  [ IsCapCategoryMorphism, IsCapCategoryMorphism ]);

#! @Description
#!  The arguments are two monomorphisms $\iota_i: S_i \hookrightarrow A$ for $i=1,2$ and an object $T$ with
#!  <C>IsEqualForObjects</C>($T$, <C>UnionSubobject</C>($\iota$)).
#!  The output is the embedding $T \hookrightarrow A$ of their union subobject $T$.
#! @Returns an object
#! @Arguments iota
DeclareOperation( "EmbeddingOfUnionSubobjectWithGivenUnion",
                  [ IsCapCategoryMorphism, IsCapCategoryMorphism, IsCapCategoryObject ]);

#! @Description
#!  The arguments are two monomorphisms $\iota_i: S_i \hookrightarrow A$ for $i=1,2$.
#!  The output is the <Q>relative pseudo-complement of $S_1$ relative to $S_2$</Q>.
#! @Returns an object
#! @Arguments iota1, iota2
DeclareOperation( "RelativePseudoComplementSuboject",
                  [ IsCapCategoryMorphism, IsCapCategoryMorphism ]);

#! @Description
#!  The arguments are two monomorphisms $\iota_i: S_i \hookrightarrow A$ for $i=1,2$.
#!  The output is the embedding <C>RelativePseudoComplementSuboject</C>($\iota$) $\hookrightarrow A$
#!  of their relative pseudo-complement into $A$.
#! @Returns an object
#! @Arguments iota
DeclareOperation( "EmbeddingOfRelativePseudoComplementSuboject",
                  [ IsCapCategoryMorphism, IsCapCategoryMorphism ]);

#! @Description
#!  The arguments are two monomorphisms $\iota_i: S_i \hookrightarrow A$ for $i=1,2$ and an object $T$ with
#!  <C>IsEqualForObjects</C>($T$, <C>RelativePseudoComplementSuboject</C>($\iota$)).
#!  The output is the embedding $T \hookrightarrow A$ of their relative pseudo-complement $T$ into $A$.
#! @Returns an object
#! @Arguments iota
DeclareOperation( "EmbeddingOfRelativePseudoComplementSubojectWithGivenImplication",
                  [ IsCapCategoryMorphism, IsCapCategoryMorphism, IsCapCategoryObject ]);
