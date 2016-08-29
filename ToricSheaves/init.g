#
# ToricSheaves: Toric sheaves as Serre quotients
#
# Reading the declaration part of the package.
#

ReadPackage( "ToricSheaves", "gap/ToricSheaves.gd");

ReadPackage( "ToricSheaves", "gap/GlobalSectionFunctors.gd" );

if IsPackageMarkedForLoading( "ToricVarieties", ">=0" ) then
    ReadPackage( "ToricSheaves", "gap/ToricSheavesForToricVarieties.gd" );
fi;
