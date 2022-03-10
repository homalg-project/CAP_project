# SPDX-License-Identifier: GPL-2.0-or-later
# DeductiveSystemForCAP: Deductive system for CAP
#
# Declarations
#

#! @Chapter Deduction system

## Global files and add functions

DeclareGlobalFunction( "INSTALL_LOGICAL_IMPLICATIONS_HELPER_EVAL_RULES" );

DeclareAttribute( "INSTALL_LOGICAL_IMPLICATIONS",
                  IsCapCategory );

## Theorems

## True methods

## Eval rules

DeclareGlobalFunction( "FIX_WELL_DEFINED_PART" );

DeclareGlobalFunction( "IS_EQUAL_FOR_SUBTREES_RECURSIVE" );

DeclareGlobalFunction( "APPLY_JUDGEMENT_TO_HISTORY_RECURSIVE" );

DeclareGlobalFunction( "CHECK_CORRECT_COMMAND_HISTORY_RECURSIVE" );

DeclareGlobalFunction( "SANITIZE_SOURCE_PART_WITH_EVERYTHING_GIVEN_RECURSIVE" );

DeclareFilter( "EvalCanComputePredicates" );

