# SPDX-License-Identifier: GPL-2.0-or-later
# CompilerForCAP: Speed up computations in CAP categories
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
