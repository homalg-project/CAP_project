# SPDX-License-Identifier: GPL-2.0-or-later
# CompilerForCAP: Speed up and verify categorical algorithms
#
# Declarations
#
#! @Chapter Improving and extending the compiler

#! @Section Compilation steps

#! @Description
#!   Deduplicates expressions occuring at least twice in the enhanced syntax tree <A>tree</A>.
#! @Returns a record
#! @Arguments tree
DeclareGlobalFunction( "CapJitDeduplicatedExpressions" );
