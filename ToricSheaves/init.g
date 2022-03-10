# SPDX-License-Identifier: GPL-2.0-or-later
# ToricSheaves: Toric sheaves as Serre quotients
#
# Reading the declaration part of the package.
#

ReadPackage( "ToricSheaves", "gap/ToricSheaves.gd");

ReadPackage( "ToricSheaves", "gap/GlobalSectionFunctors.gd" );

ReadPackage( "ToricSheaves", "gap/CoverByLocallyFreeObject.gd" );

if IsPackageMarkedForLoading( "ToricVarieties", ">=0" ) then
    ReadPackage( "ToricSheaves", "gap/ToricSheavesForToricVarieties.gd" );
fi;
