# SPDX-License-Identifier: GPL-2.0-or-later
# CAP: Categories, Algorithms, Programming
#
# Declarations
#
DeclareGlobalName( "CAP_INTERNAL_METHOD_NAME_RECORD" );

DeclareGlobalFunction( "CAP_INTERNAL_ENHANCE_NAME_RECORD_LIMITS" );

#! @Chapter Limits and Colimits
#! @Section Functions
#! @Description
#!   This function takes a method name record and a list of enhanced limits, and validates the entries of the method name record.
#!   Prefunctions, full prefunctions and postfunctions are excluded from the validation.
#! @Arguments method_name_record, limits
DeclareGlobalFunction( "CAP_INTERNAL_VALIDATE_LIMITS_IN_NAME_RECORD" );

DeclareGlobalName( "CAP_INTERNAL_METHOD_RECORD_REPLACEMENTS" );

DeclareGlobalFunction( "CAP_INTERNAL_ADD_REPLACEMENTS_FOR_METHOD_RECORD" );

DeclareGlobalFunction( "CAP_INTERNAL_FIND_OPPOSITE_PROPERTY_PAIRS_IN_METHOD_NAME_RECORD" );

DeclareGlobalFunction( "CAP_INTERNAL_ENHANCE_NAME_RECORD" );

DeclareGlobalFunction( "CAP_INTERNAL_GENERATE_DECLARATIONS_AND_INSTALLATIONS_FROM_METHOD_NAME_RECORD" );

DeclareGlobalName( "CAP_INTERNAL_METHOD_NAME_RECORDS_BY_PACKAGE" );

DeclareGlobalFunction( "CAP_INTERNAL_REGISTER_METHOD_NAME_RECORD_OF_PACKAGE" );

DeclareGlobalFunction( "CAP_INTERNAL_GENERATE_DOCUMENTATION_FOR_CATEGORY_INSTANCES" );
