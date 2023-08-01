# SPDX-License-Identifier: GPL-2.0-or-later
# CAP: Categories, Algorithms, Programming
#
# Declarations
#
DeclareGlobalVariable( "CATEGORIES_LOGIC_FILES" );

DeclareInfoClass( "CapLogicInfo" );

DeclareGlobalFunction( "SetCapLogicInfo" );

############################
##
## Theorems
##
############################

DeclareGlobalFunction( "AddTheoremFileToCategory" );

DeclareGlobalFunction( "ADD_THEOREM_TO_CATEGORY" );

DeclareGlobalFunction( "SANITIZE_RECORD" );

DeclareGlobalFunction( "INSTALL_TODO_FOR_LOGICAL_THEOREMS" );

#############################
##
## Predicate implications
##
#############################

DeclareGlobalFunction( "AddPredicateImplicationFileToCategory" );

DeclareGlobalFunction( "ADD_PREDICATE_IMPLICATIONS_TO_CATEGORY" );

DeclareGlobalFunction( "INSTALL_PREDICATE_IMPLICATION" );

#############################
##
## API for EvalRules
##
#############################

DeclareGlobalFunction( "AddEvalRuleFileToCategory" );

DeclareGlobalFunction( "ADD_EVAL_RULES_TO_CATEGORY" );

#############################
##
## Technical functions
##
#############################

DeclareGlobalFunction( "INSTALL_LOGICAL_IMPLICATIONS_HELPER" );
