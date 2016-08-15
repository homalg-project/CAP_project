#
# ToricSheaves: Toric sheaves as Serre quotients
#
# Reading the implementation part of the package.
#
ReadPackage( "ToricSheaves", "gap/ZeroPartOfModule.gi" );

ReadPackage( "ToricSheaves", "gap/ToricSheaves.gi");

if IsPackageMarkedForLoading( "ToricVarieties", ">=0" ) then
    ReadPackage( "ToricSheaves", "gap/ToricSheavesForToricVarieties.gi" );
fi;
