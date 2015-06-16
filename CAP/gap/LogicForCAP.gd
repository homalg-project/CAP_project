#############################################################################
##
##                                               CAP package
##
##  Copyright 2015, Sebastian Gutsche, TU Kaiserslautern
##                  Sebastian Posur,   RWTH Aachen
##
#############################################################################

DeclareGlobalVariable( "CATEGORIES_LOGIC_FILES" );

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
## Technical functions
##
#############################

DeclareAttribute( "INSTALL_LOGICAL_IMPLICATIONS",
                  IsCapCategory );


DeclareGlobalFunction( "INSTALL_LOGICAL_IMPLICATIONS_HELPER" );
