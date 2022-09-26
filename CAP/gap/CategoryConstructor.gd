# SPDX-License-Identifier: GPL-2.0-or-later
# CAP: Categories, Algorithms, Programming
#
# Declarations
#

#! @Chapter The Category Constructor

####################################
#
#! @Section Info class
#
####################################

#! @Description
#!  Info class controlling the debugging output of <Ref Oper="CategoryConstructor" Label="for IsRecord" />.
DeclareInfoClass( "InfoCategoryConstructor" );

####################################
#
#! @Section Constructors
#
####################################

#! @Description
#!  Creates a &CAP; category subject to the options given via <A>options</A>,
#!  which is a record with the following keys:
#!  * `name` (optional): name of the category
#!  * `category_filter` (optional): filter set for the category via `SetFilterObj`
#!  * `category_object_filter` (optional): filter added via <Ref Oper="AddObjectRepresentation" Label="for IsCapCategory, IsObject" /> to the category
#!  * `category_morphism_filter` (optional): filter added via <Ref Oper="AddMorphismRepresentation" Label="for IsCapCategory, IsObject" /> to the category
#!  * `commutative_ring_of_linear_category` (optional): ring attached as <Ref Attr="CommutativeRingOfLinearCategory" Label="for IsCapCategory" /> to the category
#!  * `properties` (optional): list of categorical properties the category will have, see `CAP_INTERNAL_CATEGORICAL_PROPERTIES_LIST`
#!  * `object_constructor` (optional): function added as an installation of <Ref Oper="ObjectConstructor" Label="for IsCapCategory, IsObject" /> to the category
#!  * `object_datum` (optional): function added as an installation of <Ref Oper="ObjectDatum" Label="for IsCapCategoryObject" /> to the category
#!  * `morphism_constructor` (optional): function added as an installation of <Ref Oper="MorphismConstructor" Label="for IsCapCategoryObject, IsObject, IsCapCategoryObject" /> to the category
#!  * `morphism_datum` (optional): function added as an installation of <Ref Oper="MorphismDatum" Label="for IsCapCategoryMorphism" /> to the category
#!  * `list_of_operations_to_install` (mandatory): a list of names of &CAP; operations which should be installed for the category
#!  * `supports_empty_limits` (optional): whether the category supports empty lists in inputs to operations of limits and colimits
#!  * `underlying_category_getter_string` (optional): see below
#!  * `underlying_object_getter_string` (optional): see below
#!  * `underlying_morphism_getter_string` (optional): see below
#!  * `top_object_getter_string` (optional): see below
#!  * `top_morphism_getter_string` (optional): see below
#!  * `generic_output_source_getter_string` (optional): see below
#!  * `generic_output_range_getter_string` (optional): see below
#!  * `create_func_bool`: see below
#!  * `create_func_object`: see below
#!  * `create_func_object_or_fail`: see below
#!  * `create_func_morphism`: see below
#!  * `create_func_morphism_or_fail`: see below
#!
#!  The values of the keys `create_func_*` should be either the string `"default`" or functions which accept the category and the name of a &CAP; operation
#!  of the corresponding `return_type`. Values for return types occuring for operations in `list_of_operations_to_install` are mandatory.
#!  The functions must return strings, which (after some replacements described below) will be evaluated and added as an installation of the corresponding operation to the category.
#!  The value `"default"` chooses a suitable default string, see the implementation for details.
#!  The following placeholders may be used in the strings and are replaced automatically:
#!  * `operation_name` will be replaced by the name of the operation
#!  * `input_arguments...` will be replaced by the `input_arguments_names` specified in the method name record (see <Ref Sect="Section_CapInternalInstallAdd" />)
#!  * `underlying_arguments...`: If the constructed category is created from another category, `underlying_category_getter_string`, `underlying_object_getter_string`, and
#!    `underlying_morphism_getter_string` may be strings of functions computing the underlying category (when applied to the constructed category) and
#!    the underlying object resp. morphism (when applied to the constructed category and an object resp. morphism in the constructed category).
#!    These functions are applied to `input_arguments` and `underlying_arguments` is replaced by the result.
#!  * `number_of_arguments` will be replaced by the number of input/underlying arguments
#!  * `top_source` and `top_range`: If the return type is `morphism` or `morphism_or_fail`, source and range are computed if possible and `top_source` and `top_range` are replaced by the results.
#!    For computing source and range, the `output_source_getter_string` and `output_range_getter_string` from the method name record are used if available (see <Ref Sect="Section_CapInternalInstallAdd" />).
#!    In some categories, source and range can always be obtained in a generic way (e.g. from the morphism datum). In this case, `generic_output_source_getter_string` and `generic_output_range_getter_string`
#!    can be set and are used if the required information is not available in the method name record.
#!  * `top_object_getter` and `top_morphism_getter` are used in the `"default"` strings and are replaced by `top_object_getter_string` and `top_morphism_getter_string`, respectively.
#!
#!  Note that the category is created with `category_as_first_argument` set to `true` (see <Ref Sect="Section_CapInternalInstallAdd" />).
#! @Arguments options
#! @Returns a &CAP; category
DeclareOperation( "CategoryConstructor",
                  [ IsRecord ] );
