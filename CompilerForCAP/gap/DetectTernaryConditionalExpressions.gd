# SPDX-License-Identifier: GPL-2.0-or-later
# CompilerForCAP: Speed up computations in CAP categories
#
# Declarations
#
#! @Chapter Improving and extending the compiler

#! @Section Compilation steps

#! @Description
#!   Detects statements of the form `if condition then return expr_if_true; else return expr_if_false; fi` and
#!   changes their representation by using a new expression type `EXPR_CONDITIONAL` with components `condition`,
#!   `expr_if_true`, and `expr_if_false`. This makes such statements easier to handle.
#! @Returns a record
#! @Arguments tree
DeclareGlobalFunction( "CapJitDetectedTernaryConditionalExpressions" );
