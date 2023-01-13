# SPDX-License-Identifier: GPL-2.0-or-later
# ActionsForCAP: Actions and Coactions for CAP
#
# This file contains package meta data. For additional information on
# the meaning and correct usage of these fields, please consult the
# manual of the "Example" package as well as the comments in its
# PackageInfo.g file.
#
SetPackageInfo( rec(

PackageName := "ActionsForCAP",
Subtitle := "Actions and Coactions for CAP",
Version := "2023.01-01",
Date := "13/01/2023",
License := "GPL-2.0-or-later",

Persons := [
  rec(
    IsAuthor := true,
    IsMaintainer := true,
    FirstNames := "Sebastian",
    LastName := "Gutsche",
    WWWHome := "http://wwwb.math.rwth-aachen.de/~gutsche",
    Email := "gutsche@mathematik.uni-kl.de",
    Place := "Kaiserslautern",
    Institution := "TU Kaiserslautern",
  ),
  rec(
    IsAuthor := true,
    IsMaintainer := true,
    FirstNames := "Sebastian",
    LastName := "Posur",
    WWWHome := "https://sebastianpos.github.io",
    Email := "sposur@momo.math.rwth-aachen.de",
    PostalAddress := Concatenation(
               "Lehrstuhl B für Mathematik RWTH - Aachen\n",
               "Templergraben 64\n",
               "52062 Aachen\n",
               "Germany" ),
    Place := "Aachen",
    Institution := "Rheinisch-Westfälische Technische Hochschule Aachen",
  ),
],

# BEGIN URLS
SourceRepository := rec(
    Type := "git",
    URL := "https://github.com/homalg-project/CAP_project",
),
IssueTrackerURL := Concatenation( ~.SourceRepository.URL, "/issues" ),
PackageWWWHome  := "https://homalg-project.github.io/pkg/ActionsForCAP",
PackageInfoURL  := "https://homalg-project.github.io/CAP_project/ActionsForCAP/PackageInfo.g",
README_URL      := "https://homalg-project.github.io/CAP_project/ActionsForCAP/README.md",
ArchiveURL      := Concatenation( "https://github.com/homalg-project/CAP_project/releases/download/ActionsForCAP-", ~.Version, "/ActionsForCAP-", ~.Version ),
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
  BookName  := "ActionsForCAP",
  ArchiveURLSubset := ["doc"],
  HTMLStart := "doc/chap0.html",
  PDFFile   := "doc/manual.pdf",
  SixFile   := "doc/manual.six",
  LongTitle := "Actions and Coactions for CAP",
),

Dependencies := rec(
  GAP := ">= 4.12.1",
  NeededOtherPackages := [ [ "GAPDoc", ">= 1.5" ],
                           [ "CAP", ">= 2019.09.16" ],
                           [ "MonoidalCategories", ">= 2019.01.16" ],
                           [ "AttributeCategoryForCAP", ">=2016.09.14" ]
                         ],
  SuggestedOtherPackages := [ ],
  ExternalConditions := [ ],
),

AvailabilityTest := function()
        return true;
    end,

TestFile := "tst/testall.g",

#Keywords := [ "TODO" ],

));
