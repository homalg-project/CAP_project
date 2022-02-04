# SPDX-License-Identifier: GPL-2.0-or-later
# LinearAlgebraForCAP: Category of Matrices over a Field for CAP
#
# This file runs package tests without precompiled code.
#
PushOptions(
    rec(
        no_precompiled_code := true,
    )
);

options := rec(
    exitGAP := true,
    testOptions := rec(
        compareFunction := "uptowhitespace",
    ),
);

TestDirectory( DirectoriesPackageLibrary( "LinearAlgebraForCAP", "tst" ), options );

FORCE_QUIT_GAP( 1 ); # if we ever get here, there was an error
