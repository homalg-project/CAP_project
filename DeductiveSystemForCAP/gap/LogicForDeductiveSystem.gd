#############################################################################
##
##                                               CAP package
##
##  Copyright 2014, Sebastian Gutsche, TU Kaiserslautern
##                  Sebastian Posur,   RWTH Aachen
##
#! @Chapter Deduction system
##
#############################################################################

## Global files and add functions

DeclareAttribute( "INSTALL_LOGICAL_IMPLICATIONS",
                  IsCapCategory );

DeclareGlobalFunction( "INSTALL_LOGICAL_IMPLICATIONS_HELPER" );

DeclareGlobalFunction( "AddTheoremFileToCategory" );

DeclareGlobalFunction( "AddPredicateImplicationFileToCategory" );

DeclareGlobalFunction( "AddEvalRuleFileToCategory" );

## Theorems

DeclareGlobalFunction( "ADD_THEOREM_TO_CATEGORY" );

DeclareGlobalFunction( "SANITIZE_RECORD" );

DeclareGlobalFunction( "INSTALL_TODO_FOR_LOGICAL_THEOREMS" );

## True methods

DeclareGlobalFunction( "ADD_PREDICATE_IMPLICATIONS_TO_CATEGORY" );

DeclareGlobalFunction( "INSTALL_PREDICATE_IMPLICATION" );

## Eval rules

DeclareGlobalFunction( "FIX_WELL_DEFINED_PART" );

DeclareGlobalFunction( "IS_EQUAL_FOR_SUBTREES_RECURSIVE" );

DeclareGlobalFunction( "APPLY_JUDGEMENT_TO_HISTORY_RECURSIVE" );

DeclareGlobalFunction( "ADD_EVAL_RULES_TO_CATEGORY" );

DeclareGlobalFunction( "CHECK_CORRECT_COMMAND_HISTORY_RECURSIVE" );

DeclareGlobalFunction( "SANITIZE_SOURCE_PART_WITH_EVERYTHING_GIVEN_RECURSIVE" );

DeclareFilter( "EvalCanComputePredicates" );

