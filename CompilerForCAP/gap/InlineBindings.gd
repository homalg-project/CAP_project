# SPDX-License-Identifier: GPL-2.0-or-later
# CompilerForCAP: Speed up computations in CAP categories
#
# Declarations
#
#! @Chapter Improving and extending the compiler

#! @Section Compilation steps

# helper
DeclareGlobalFunction( "CAP_JIT_INTERNAL_INLINED_BINDINGS" );

#! @Description
#!   Example: transforms `function() local x; x := 1; return x^2; end` into `function() return 1^2; end()`.
#!   Details: Replaces references to local variables of a function by the value of the corresponding binding of the function.
#!   If the option `inline_var_refs_only` is set to `true`, this is only done if the value is a reference to a (local or global) variable.
#!   If the option `inline_fully` is NOT set to `true`, wrapped arguments are not inlined (see <Ref Func="CapJitOutlinedWrappedArguments" />).
#!   Also drops the inlined bindings.
#! @Returns a record
#! @Arguments tree
DeclareGlobalFunction( "CapJitInlinedBindings" );

#! @Description
#!   Short hand for `CapJitInlinedBindings( `<A>tree</A>` : inline_var_refs_only := true )`.
#! @Returns a record
#! @Arguments tree
DeclareGlobalFunction( "CapJitInlinedBindingsToVariableReferences" );

#! @Description
#!   Short hand for `CapJitInlinedBindings( `<A>tree</A>` : inline_fully := true )`.
#! @Returns a record
#! @Arguments tree
DeclareGlobalFunction( "CapJitInlinedBindingsFully" );
