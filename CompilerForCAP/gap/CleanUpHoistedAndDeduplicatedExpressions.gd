# SPDX-License-Identifier: GPL-2.0-or-later
# CompilerForCAP: Speed up computations in CAP categories
#
# Declarations
#
#! @Chapter Improving and extending the compiler

#! @Section Compilation steps

#! @Description
#!   Cleans up variable names after hoisting and deduplication:
#!   * Assignments of the form `hoisted_xxx := deduped_yyy;` are deleted and all references to `hoisted_xxx` are replaced by references to `deduped_yyy`.
#!   * If `hoisted_xxx` is used more than once, it is renamed to `deduped_xxx`. Note: Even if a hoisted value is used more than once during <Ref Func="CapJitHoistedExpressions" />,
#!     it is not necessarily used more than once after <Ref Func="CapJitDeduplicatedExpressions" /> because the places where it was used might have been deduplicated themselves.
#! @Returns a record
#! @Arguments tree
DeclareGlobalFunction( "CapJitCleanedUpHoistedAndDeduplicatedExpressions" );
