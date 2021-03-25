# SPDX-License-Identifier: GPL-2.0-or-later
# Toposes: Elementary toposes
#
# Implementations
#

InstallValue( CARTESIAN_CATEGORIES_METHOD_NAME_RECORD, rec(

## Basic Operations for Cartesian Categories

DirectProductOnMorphismsWithGivenDirectProducts := rec(
  installation_name := "DirectProductOnMorphismsWithGivenDirectProducts",
  filter_list := [ "category", "object", "morphism", "morphism", "object" ],
  io_type := [ [ "s", "alpha", "beta", "r" ], [ "s", "r" ] ],
  cache_name := "DirectProductOnMorphismsWithGivenDirectProducts",
  return_type := "morphism" ),

CartesianAssociatorRightToLeftWithGivenDirectProducts := rec(
  installation_name := "CartesianAssociatorRightToLeftWithGivenDirectProducts",
  filter_list := [ "category", "object", "object", "object", "object", "object" ],
  io_type := [ [ "s", "a", "b", "c", "r" ], [ "s", "r" ] ],
  cache_name := "CartesianAssociatorRightToLeftWithGivenDirectProducts",
  return_type := "morphism" ),

CartesianAssociatorLeftToRightWithGivenDirectProducts := rec(
  installation_name := "CartesianAssociatorLeftToRightWithGivenDirectProducts",
  filter_list := [ "category", "object", "object", "object", "object", "object" ],
  io_type := [ [ "s", "a", "b", "c", "r" ], [ "s", "r" ] ],
  cache_name := "CartesianAssociatorLeftToRightWithGivenDirectProducts",
  return_type := "morphism" ),

CartesianLeftUnitorWithGivenDirectProduct := rec(
  installation_name := "CartesianLeftUnitorWithGivenDirectProduct",
  filter_list := [ "category", "object", "object" ],
  io_type := [ [ "a", "s" ], [ "s", "a" ] ],
  cache_name := "CartesianLeftUnitorWithGivenDirectProduct",
  return_type := "morphism" ),

CartesianLeftUnitorInverseWithGivenDirectProduct := rec(
  installation_name := "CartesianLeftUnitorInverseWithGivenDirectProduct",
  filter_list := [ "category", "object", "object" ],
  io_type := [ [ "a", "r" ], [ "a", "r" ] ],
  cache_name := "CartesianLeftUnitorInverseWithGivenDirectProduct",
  return_type := "morphism" ),

CartesianRightUnitorWithGivenDirectProduct := rec(
  installation_name := "CartesianRightUnitorWithGivenDirectProduct",
  filter_list := [ "category", "object", "object" ],
  io_type := [ [ "a", "s" ], [ "s", "a" ] ],
  cache_name := "CartesianRightUnitorWithGivenDirectProduct",
  return_type := "morphism" ),

CartesianRightUnitorInverseWithGivenDirectProduct := rec(
  installation_name := "CartesianRightUnitorInverseWithGivenDirectProduct",
  filter_list := [ "category", "object", "object" ],
  io_type := [ [ "a", "r" ], [ "a", "r" ] ],
  cache_name := "CartesianRightUnitorInverseWithGivenDirectProduct",
  return_type := "morphism" ),

) );

CAP_INTERNAL_ENHANCE_NAME_RECORD( CARTESIAN_CATEGORIES_METHOD_NAME_RECORD );

CAP_INTERNAL_INSTALL_ADDS_FROM_RECORD( CARTESIAN_CATEGORIES_METHOD_NAME_RECORD );
