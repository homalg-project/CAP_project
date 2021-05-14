# SPDX-License-Identifier: GPL-2.0-or-later
# CAP: Categories, Algorithms, Programming
#
# Declarations
#

#! @Chapter Limits and Colimits

#! @Section Functions

#! @Description
#!   This function takes a package name, a method name record and a list of enhanced limits,
#!   and generates convenience methods for the limits as a string of GAP code.
#!   The result is compared to the content of the file <A>package_name</A>`/gap/LimitConvenienceOutput.gi`.
#!   If a difference is found, a warning is raised and the generated string is written to a temporary file for manual inspection.
#! @Arguments package_name, method_name_record, limits
DeclareGlobalFunction( "CAP_INTERNAL_GENERATE_CONVENIENCE_METHODS_FOR_LIMITS" );
