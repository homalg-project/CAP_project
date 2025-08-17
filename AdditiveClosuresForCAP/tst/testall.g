# SPDX-License-Identifier: GPL-2.0-or-later
# AdditiveClosuresForCAP: Additive closures for pre-additive categories
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

# reverse RecNames 50% of the time to detect code relying on the order of RecNames
if Random( RandomSource( IsMersenneTwister, NanosecondsSinceEpoch( ) ), [ false, true ] ) then
    
    Display( "Executing with reversed RecNames" );
    
    MakeReadWriteGlobal( "RecNames" );
    
    old_RecNames := RecNames;
    
    RecNames := record -> Reversed( old_RecNames( record ) );
    
    MakeReadOnlyGlobal( "RecNames" );
    
else
    
    Display( "Executing with non-reversed RecNames" );
    
fi;

TestDirectory( DirectoriesPackageLibrary( "AdditiveClosuresForCAP", "tst" ), options );

FORCE_QUIT_GAP( 1 ); # if we ever get here, there was an error
