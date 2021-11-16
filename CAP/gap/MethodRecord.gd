# SPDX-License-Identifier: GPL-2.0-or-later
# CAP: Categories, Algorithms, Programming
#
# Declarations
#
DeclareGlobalVariable( "CAP_INTERNAL_VALID_RETURN_TYPES" );

DeclareGlobalVariable( "CAP_INTERNAL_METHOD_NAME_RECORD" );

DeclareGlobalVariable( "CAP_INTERNAL_METHOD_NAME_RECORD_LIMITS" );

DeclareGlobalFunction( "CAP_INTERNAL_ENHANCE_NAME_RECORD_LIMITS" );

#! @Chapter Limits and Colimits
#! @Section Functions
#! @Description
#!   This function takes a method name record and a list of enhanced limits, and validates the entries of the method name record.
#!   Prefunctions, full prefunctions and postfunctions are excluded from the validation.
#! @Arguments method_name_record, limits
DeclareGlobalFunction( "CAP_INTERNAL_VALIDATE_LIMITS_IN_NAME_RECORD" );

DeclareGlobalVariable( "CAP_INTERNAL_METHOD_RECORD_REPLACEMENTS" );

DeclareGlobalFunction( "CAP_INTERNAL_ADD_REPLACEMENTS_FOR_METHOD_RECORD" );

DeclareGlobalVariable( "CAP_INTERNAL_OPPOSITE_PROPERTY_PAIRS_FOR_OBJECTS" );

DeclareGlobalVariable( "CAP_INTERNAL_OPPOSITE_PROPERTY_PAIRS_FOR_MORPHISMS" );

DeclareGlobalVariable( "CAP_INTERNAL_FIND_OPPOSITE_PROPERTY_PAIRS_IN_METHOD_NAME_RECORD" );

DeclareGlobalFunction( "CAP_INTERNAL_ENHANCE_NAME_RECORD" );

DeclareGlobalFunction( "CAP_INTERNAL_REVERSE_LISTS_IN_ARGUMENTS_FOR_OPPOSITE" );

DeclareGlobalFunction( "CAP_INTERNAL_GENERATE_DOCUMENTATION_FROM_METHOD_NAME_RECORD" );

DeclareGlobalFunction( "CAP_INTERNAL_REGISTER_METHOD_NAME_RECORD_OF_PACKAGE" );

DeclareGlobalFunction( "CAP_INTERNAL_GENERATE_DOCUMENTATION_FOR_CATEGORY_INSTANCES" );
