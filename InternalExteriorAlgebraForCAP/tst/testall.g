# SPDX-License-Identifier: GPL-2.0-or-later
# InternalExteriorAlgebraForCAP: Constructions for Modules over the Internal Exterior Algebra for CAP
#
# This file runs package tests. It is also referenced in the package
# metadata in PackageInfo.g.
#
options := rec(
    exitGAP := true,
    testOptions := rec(
        compareFunction := "uptowhitespace",
    ),
);

TestDirectory( DirectoriesPackageLibrary( "InternalExteriorAlgebraForCAP", "tst" ), options );

FORCE_QUIT_GAP( 1 ); # if we ever get here, there was an error
