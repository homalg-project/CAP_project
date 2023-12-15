# SPDX-License-Identifier: GPL-2.0-or-later
# CompilerForCAP: Speed up and verify categorical algorithms
#
# Declarations
#

#! @Chapter Using the compiler

#! @Section Proof assistant mode

DeclareGlobalName( "CAP_JIT_PROOF_ASSISTANT_MODE_ENABLED" );

#! @BeginGroup
#! @Description
#!   (experimental) Enables or disables the (experimental) proof assistant mode.
#!   For example, in this mode the compiler will display warnings if the code involves CAP operations which are not known to be compatible with the congruence of morphisms,
#!   and expressions will not be hoisted or deduplicated.
#! @Arguments
DeclareGlobalFunction( "CapJitEnableProofAssistantMode" );
#! @Arguments
DeclareGlobalFunction( "CapJitDisableProofAssistantMode" );
#! @EndGroup

DeclareGlobalName( "CAP_JIT_PROOF_ASSISTANT_ACTIVE_LEMMA" );

#! @Description
#!   (experimental) States a new categorical lemma to be proven in proof assistant mode.
#!   * <A>description</A> is a human readable version of the statement
#!   * <A>claim</A> is a function formalizing the statement, that is, returning <K>true</K> if and only if the statement holds
#!   * <A>category</A> is the category for which the statement shall be proven; the category must be the first argument of `claim`
#!   * <A>filter_strings</A> is a list of filter strings as in the method name record
#!   * <A>preconditions</A> is a list of records of the form `rec( src_template := &lt;string&gt;, dst_template := &lt;string&gt; )`;
#!      the template strings are interpreted in the context of `claim` and can be used to describe relations between the arguments of `claim`
#!
#!   The aim is to reduce the function <A>claim</A> to `{...} -> true` by applying logic templates via <Ref Oper="ApplyLogicTemplate" Label="for IsRecord" />.
#! @Arguments description, claim, category, filter_strings, preconditions
DeclareOperation( "StateLemma", [ IsString, IsFunction, IsCapCategory, IsList, IsList ] );

#! @Description
#!   (experimental) Prints the state of the current lemma.
#! @Arguments
DeclareOperation( "PrintLemma", [ ] );

#! @Description
#!   (experimental) Lets the user attest that all arguments in function calls in the state of the current lemma
#!   form valid inputs for the functions, for example, that two morphisms passed to `PreCompose` are actually composable.
#!   This allows CompilerForCAP to simplify type checks, for example, that the return value of the call to `PreCompose`
#!   is a well-defined morphism.
#! @Arguments
DeclareOperation( "AttestValidInputs", [ ] );

#! @Description
#!   (experimental) Applies a logic template to the state of the current lemma.
#!   If `number_of_applications` is not set, it defaults to `1`.
#! @Arguments logic_template
DeclareOperation( "ApplyLogicTemplate", [ IsRecord ] );

#! @Description
#!   (experimental) Applies a logic template <A>n</A> times to the state of the current lemma.
#!   Note: `number_of_applications` must not be set.
#! @Arguments n, logic_template
DeclareOperation( "ApplyLogicTemplateNTimes", [ IsPosInt, IsRecord ] );

#! @Description
#!   (experimental) Asserts that the current lemma is proven, that is, that the state of the current lemma is `{...} -> true`.
#!   If this is the case, the current lemma is cleared, which allows a new lemma to be stated.
#! @Arguments
DeclareOperation( "AssertLemma", [ ] );

DeclareGlobalName( "CAP_JIT_PROOF_ASSISTANT_ACTIVE_PROPOSITION" );

#! @Description
#!   (experimental) States a new proposition to be proven for the category <A>category</A>.
#!   Valid IDs are the entries of `RecNames( CAP_JIT_INTERNAL_PROOF_ASSISTANT_PROPOSITIONS )`.
#!   A proposition is a collection of lemmata which can be stated using <Ref Func="StateNextLemma" />
#!   and can then be proven in the same way as a lemma stated using <Ref Func="StateLemma" Label="for IsString, IsFunction, IsCapCategory, IsList, IsList" />.
#! @Arguments category, proposition_id
DeclareOperation( "StateProposition", [ IsCapCategory, IsString ] );

#! @Description
#!   (experimental) States the next lemma of the current proposition.
#! @Arguments
DeclareOperation( "StateNextLemma", [ ] );

#! @Description
#!   (experimental) Asserts that the current proposition is proven, that is, that all lemmata of the current proposition
#!   are proven.
#! @Arguments
DeclareOperation( "AssertProposition", [ ] );
