# SPDX-License-Identifier: GPL-2.0-or-later
# Toposes: Elementary toposes
#
# Implementations
#

InstallValue( DISTRIBUTIVE_CARTESIAN_CATEGORIES_METHOD_NAME_RECORD, rec(

LeftCartesianDistributivityExpandingWithGivenObjects := rec(
  installation_name := "LeftCartesianDistributivityExpandingWithGivenObjects",
  filter_list := [ "category", "object", "object", IsList, "object" ],
  io_type := [ [ "s", "a", "L", "r" ], [ "s", "r" ] ],
  cache_name := "LeftCartesianDistributivityExpandingWithGivenObjects",
  return_type := "morphism" ),

LeftCartesianDistributivityFactoringWithGivenObjects := rec(
  installation_name := "LeftCartesianDistributivityFactoringWithGivenObjects",
  filter_list := [ "category", "object", "object", IsList, "object" ],
  io_type := [ [ "s", "a", "L", "r" ], [ "s", "r" ] ],
  cache_name := "LeftCartesianDistributivityFactoringWithGivenObjects",
  return_type := "morphism" ),

RightCartesianDistributivityExpandingWithGivenObjects := rec(
  installation_name := "RightCartesianDistributivityExpandingWithGivenObjects",
  filter_list := [ "category", "object", IsList, "object", "object" ],
  io_type := [ [ "s", "L", "a", "r" ], [ "s", "r" ] ],
  cache_name := "RightCartesianDistributivityExpandingWithGivenObjects",
  return_type := "morphism" ),

RightCartesianDistributivityFactoringWithGivenObjects := rec(
  installation_name := "RightCartesianDistributivityFactoringWithGivenObjects",
  filter_list := [ "category", "object", IsList, "object", "object" ],
  io_type := [ [ "s", "L", "a", "r" ], [ "s", "r" ] ],
  cache_name := "RightCartesianDistributivityFactoringWithGivenObjects",
  return_type := "morphism" ),

) );

CAP_INTERNAL_ENHANCE_NAME_RECORD( DISTRIBUTIVE_CARTESIAN_CATEGORIES_METHOD_NAME_RECORD );

CAP_INTERNAL_INSTALL_ADDS_FROM_RECORD( DISTRIBUTIVE_CARTESIAN_CATEGORIES_METHOD_NAME_RECORD );
