# SPDX-License-Identifier: GPL-2.0-or-later
# Toposes: Elementary toposes
#
# Implementations
#

InstallValue( COCARTESIAN_CATEGORIES_METHOD_NAME_RECORD, rec(

## Basic Operations for Cocartesian Categories

CoproductOnMorphismsWithGivenCoproducts := rec(
  installation_name := "CoproductOnMorphismsWithGivenCoproducts",
  filter_list := [ "object", "morphism", "morphism", "object" ],
  io_type := [ [ "s", "alpha", "beta", "r" ], [ "s", "r" ] ],
  cache_name := "CoproductOnMorphismsWithGivenCoproducts",
  return_type := "morphism" ),

CocartesianAssociatorRightToLeftWithGivenCoproducts := rec(
  installation_name := "CocartesianAssociatorRightToLeftWithGivenCoproducts",
  filter_list := [ "object", "object", "object", "object", "object" ],
  io_type := [ [ "s", "a", "b", "c", "r" ], [ "s", "r" ] ],
  cache_name := "CocartesianAssociatorRightToLeftWithGivenCoproducts",
  return_type := "morphism" ),

CocartesianAssociatorLeftToRightWithGivenCoproducts := rec(
  installation_name := "CocartesianAssociatorLeftToRightWithGivenCoproducts",
  filter_list := [ "object", "object", "object", "object", "object" ],
  io_type := [ [ "s", "a", "b", "c", "r" ], [ "s", "r" ] ],
  cache_name := "CocartesianAssociatorLeftToRightWithGivenCoproducts",
  return_type := "morphism" ),

CocartesianLeftUnitorWithGivenCoproduct := rec(
  installation_name := "CocartesianLeftUnitorWithGivenCoproduct",
  filter_list := [ "object", "object" ],
  io_type := [ [ "a", "s" ], [ "s", "a" ] ],
  cache_name := "CocartesianLeftUnitorWithGivenCoproduct",
  return_type := "morphism" ),

CocartesianLeftUnitorInverseWithGivenCoproduct := rec(
  installation_name := "CocartesianLeftUnitorInverseWithGivenCoproduct",
  filter_list := [ "object", "object" ],
  io_type := [ [ "a", "r" ], [ "a", "r" ] ],
  cache_name := "CocartesianLeftUnitorInverseWithGivenCoproduct",
  return_type := "morphism" ),

CocartesianRightUnitorWithGivenCoproduct := rec(
  installation_name := "CocartesianRightUnitorWithGivenCoproduct",
  filter_list := [ "object", "object" ],
  io_type := [ [ "a", "s" ], [ "s", "a" ] ],
  cache_name := "CocartesianRightUnitorWithGivenCoproduct",
  return_type := "morphism" ),

CocartesianRightUnitorInverseWithGivenCoproduct := rec(
  installation_name := "CocartesianRightUnitorInverseWithGivenCoproduct",
  filter_list := [ "object", "object" ],
  io_type := [ [ "a", "r" ], [ "a", "r" ] ],
  cache_name := "CocartesianRightUnitorInverseWithGivenCoproduct",
  return_type := "morphism" ),

) );

CAP_INTERNAL_ENHANCE_NAME_RECORD( COCARTESIAN_CATEGORIES_METHOD_NAME_RECORD );

CAP_INTERNAL_INSTALL_ADDS_FROM_RECORD( COCARTESIAN_CATEGORIES_METHOD_NAME_RECORD );
