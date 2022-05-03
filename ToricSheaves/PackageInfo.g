# SPDX-License-Identifier: GPL-2.0-or-later
# ToricSheaves: Toric sheaves as Serre quotients
#
# This file contains package meta data. For additional information on
# the meaning and correct usage of these fields, please consult the
# manual of the "Example" package as well as the comments in its
# PackageInfo.g file.
#
SetPackageInfo( rec(

PackageName := "ToricSheaves",
Subtitle := "Toric sheaves as Serre quotients",
Version := "2022.05-01",
Date := Concatenation( "01/", ~.Version{[ 6, 7 ]}, "/", ~.Version{[ 1 .. 4 ]} ),
License := "GPL-2.0-or-later",

Persons := [
  rec(
    IsAuthor := true,
    IsMaintainer := true,
    FirstNames := "Sebastian",
    LastName := "Gutsche",
    WWWHome := "http://wwwb.math.rwth-aachen.de/~gutsche/",
    Email := "gutsche@mathematik.uni-siegen.de",
    PostalAddress := "TODO",
    Place := "Siegen",
    Institution := "Universitaet Siegen",
  ),
],

# BEGIN URLS
SourceRepository := rec(
    Type := "git",
    URL := "https://github.com/homalg-project/CAP_project",
),
IssueTrackerURL := Concatenation( ~.SourceRepository.URL, "/issues" ),
PackageWWWHome  := "https://homalg-project.github.io/pkg/ToricSheaves",
PackageInfoURL  := "https://homalg-project.github.io/CAP_project/ToricSheaves/PackageInfo.g",
README_URL      := "https://homalg-project.github.io/CAP_project/ToricSheaves/README.md",
ArchiveURL      := Concatenation( "https://github.com/homalg-project/CAP_project/releases/download/ToricSheaves-", ~.Version, "/ToricSheaves-", ~.Version ),
# END URLS

ArchiveFormats := ".tar.gz .zip",

##  Status information. Currently the following cases are recognized:
##    "accepted"      for successfully refereed packages
##    "submitted"     for packages submitted for the refereeing
##    "deposited"     for packages for which the GAP developers agreed
##                    to distribute them with the core GAP system
##    "dev"           for development versions of packages
##    "other"         for all other packages
##
Status := "dev",

AbstractHTML   :=  "",

PackageDoc := rec(
  BookName  := "ToricSheaves",
  ArchiveURLSubset := ["doc"],
  HTMLStart := "doc/chap0.html",
  PDFFile   := "doc/manual.pdf",
  SixFile   := "doc/manual.six",
  LongTitle := "Toric sheaves as Serre quotients",
),

Dependencies := rec(
  GAP := ">= 4.11.1",
  NeededOtherPackages := [ [ "GAPDoc", ">= 1.5" ],
                           [ "GradedModulePresentationsForCAP", ">=0" ],
                           [ "GeneralizedMorphismsForCAP", ">=0" ],
                           [ "4ti2Interface", ">=0" ],
                           [ "NConvex", "2019.03.25" ] ],
  SuggestedOtherPackages := [ [ "ToricVarieties", ">=0" ] ],
  ExternalConditions := [ ],
),

AvailabilityTest := function()
        return true;
    end,

TestFile := "tst/testall.g",

#Keywords := [ "TODO" ],

));
