# SPDX-License-Identifier: GPL-2.0-or-later
# CompilerForCAP: Speed up computations in CAP categories
#
# Declarations
#
#! @Chapter Improving and extending the compiler

#! @Section Compilation steps

#! @Description
#!   Hoists expressions which are part of but indepedent of inner functions to outer functions.
#! @Returns a record
#! @Arguments tree
DeclareGlobalFunction( "CapJitHoistedExpressions" );
