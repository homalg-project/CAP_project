# SPDX-License-Identifier: GPL-2.0-or-later
# HomologicalAlgebraForCAP: Homological algebra algorithms for CAP
#
# This file contains package meta data. For additional information on
# the meaning and correct usage of these fields, please consult the
# manual of the "Example" package as well as the comments in its
# PackageInfo.g file.
#
SetPackageInfo( rec(

PackageName := "HomologicalAlgebraForCAP",
Subtitle := "Homological algebra algorithms for CAP",
Version := "2023.08-01",
Date := (function ( ) if IsBound( GAPInfo.SystemEnvironment.GAP_PKG_RELEASE_DATE ) then return GAPInfo.SystemEnvironment.GAP_PKG_RELEASE_DATE; else return Concatenation( ~.Version{[ 1 .. 4 ]}, "-", ~.Version{[ 6, 7 ]}, "-01" ); fi; end)( ),
License := "GPL-2.0-or-later",

Persons := [
  rec(
    IsAuthor := true,
    IsMaintainer := true,
    FirstNames := "Sebastian",
    LastName := "Posur",
    WWWHome := "https://sebastianpos.github.io",
    Email := "sposur@momo.math.rwth-aachen.de",
    PostalAddress := Concatenation(
               "Sebastian Posur\n",
               "Lehrstuhl B fuer Mathematik, RWTH Aachen\n",
               "Templergraben 64\n",
               "52062 Aachen\n",
               "Germany" ),
    Place := "Aachen",
    Institution := "RWTH Aachen University",
  ),
  rec(
    IsAuthor := true,
    IsMaintainer := true,
    FirstNames := "Sebastian",
    LastName := "Gutsche",
    WWWHome := "http://wwwb.math.rwth-aachen.de/~gutsche/",
    Email := "gutsche@momo.math.rwth-aachen.de",
    PostalAddress := Concatenation(
               "Department of Mathematics\n",
               "University of Kaiserslautern\n",
               "67653 Kaiserslautern\n",
               "Germany" ),
    Place := "Kaiserslautern",
    Institution := "TU Kaiserslautern",
  ),
],

# BEGIN URLS
SourceRepository := rec(
    Type := "git",
    URL := "https://github.com/homalg-project/CAP_project",
),
IssueTrackerURL := Concatenation( ~.SourceRepository.URL, "/issues" ),
PackageWWWHome  := "https://homalg-project.github.io/pkg/HomologicalAlgebraForCAP",
PackageInfoURL  := "https://homalg-project.github.io/CAP_project/HomologicalAlgebraForCAP/PackageInfo.g",
README_URL      := "https://homalg-project.github.io/CAP_project/HomologicalAlgebraForCAP/README.md",
ArchiveURL      := Concatenation( "https://github.com/homalg-project/CAP_project/releases/download/HomologicalAlgebraForCAP-", ~.Version, "/HomologicalAlgebraForCAP-", ~.Version ),
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
  BookName  := "HomologicalAlgebraForCAP",
  ArchiveURLSubset := ["doc"],
  HTMLStart := "doc/chap0.html",
  PDFFile   := "doc/manual.pdf",
  SixFile   := "doc/manual.six",
  LongTitle := "Homological algebra algorithms for CAP",
),

Dependencies := rec(
  GAP := ">= 4.12.1",
  NeededOtherPackages := [ [ "GAPDoc", ">= 1.5" ],
                           [ "GeneralizedMorphismsForCAP", ">=2015.05.08" ],
                           [ "ComplexesAndFilteredObjectsForCAP", ">=2015.05.08" ] ],
  SuggestedOtherPackages := [ ],
  ExternalConditions := [ ],
),

AvailabilityTest := function()
        return true;
    end,

TestFile := "tst/testall.g",

#Keywords := [ "TODO" ],

));
