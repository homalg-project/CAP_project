# SPDX-License-Identifier: GPL-2.0-or-later
# GeneralizedMorphismsForCAP: Implementations of generalized morphisms for the CAP project
#
# This file contains package meta data. For additional information on
# the meaning and correct usage of these fields, please consult the
# manual of the "Example" package as well as the comments in its
# PackageInfo.g file.
#
SetPackageInfo( rec(

PackageName := "GeneralizedMorphismsForCAP",
Subtitle := "Implementations of generalized morphisms for the CAP project",
Version := "2025.08-01",
Date := "2025-08-25",
License := "GPL-2.0-or-later",

Persons := [
  rec(
    IsAuthor := true,
    IsMaintainer := true,
    FirstNames := "Sebastian",
    LastName := "Gutsche",
    WWWHome := "https://sebasguts.github.io/",
    Email := "sebastian.gutsche@gmail.com",
    PostalAddress := Concatenation(
               "Department Mathematik\n",
               "Universität Siegen\n",
               "Walter-Flex-Straße 3\n",
               "57068 Siegen\n",
               "Germany" ),
    Place := "Siegen",
    Institution := "University of Siegen",
  ),
  rec(
    IsAuthor := true,
    IsMaintainer := true,
    FirstNames := "Sebastian",
    LastName := "Posur",
    WWWHome := "https://sebastianpos.github.io",
    Email := "sebastian.posur@uni-muenster.de",
    PostalAddress := Concatenation(
               "Department Mathematik\n",
               "Universität Siegen\n",
               "Walter-Flex-Straße 3\n",
               "57068 Siegen\n",
               "Germany" ),
    Place := "Siegen",
    Institution := "University of Siegen",
  ),
],

# BEGIN URLS
SourceRepository := rec(
    Type := "git",
    URL := "https://github.com/homalg-project/CAP_project",
),
IssueTrackerURL := Concatenation( ~.SourceRepository.URL, "/issues" ),
PackageWWWHome  := "https://homalg-project.github.io/pkg/GeneralizedMorphismsForCAP",
PackageInfoURL  := "https://homalg-project.github.io/CAP_project/GeneralizedMorphismsForCAP/PackageInfo.g",
README_URL      := "https://homalg-project.github.io/CAP_project/GeneralizedMorphismsForCAP/README.md",
ArchiveURL      := Concatenation( "https://github.com/homalg-project/CAP_project/releases/download/GeneralizedMorphismsForCAP-", ~.Version, "/GeneralizedMorphismsForCAP-", ~.Version ),
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
Status := "deposited",

AbstractHTML   :=  "<span class=\"pkgname\">GeneralizedMorphismsForCAP</span> provides the category of generalized morphisms associated to an abelian category.",

PackageDoc := rec(
  BookName  := "GeneralizedMorphismsForCAP",
  ArchiveURLSubset := ["doc"],
  HTMLStart := "doc/chap0.html",
  PDFFile   := "doc/manual.pdf",
  SixFile   := "doc/manual.six",
  LongTitle := "Implementations of generalized morphisms for the CAP project",
),

Dependencies := rec(
  GAP := ">= 4.13.0",
  NeededOtherPackages := [ [ "GAPDoc", ">= 1.5" ],
                           [ "CAP", ">= 2021.05-01" ],
                           [ "MonoidalCategories", ">= 2024.01-03" ],
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
