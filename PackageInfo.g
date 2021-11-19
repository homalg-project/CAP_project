# SPDX-License-Identifier: GPL-2.0-or-later
# WrapperCategories: Construct an equivalent wrapper category out of a CAP category
#
# This file contains package meta data. For additional information on
# the meaning and correct usage of these fields, please consult the
# manual of the "Example" package as well as the comments in its
# PackageInfo.g file.
#
SetPackageInfo( rec(

PackageName := "WrapperCategories",
Subtitle := "Construct an equivalent wrapper category out of a CAP category",
Version := "2021.11-01",
Date := ~.Version{[ 1 .. 10 ]},
Date := Concatenation( "01/", ~.Version{[ 6, 7 ]}, "/", ~.Version{[ 1 .. 4 ]} ),
License := "GPL-2.0-or-later",

Persons := [
  rec(
    IsAuthor := true,
    IsMaintainer := true,
    FirstNames := "Mohamed",
    LastName := "Barakat",
    WWWHome := "https://mohamed-barakat.github.io/",
    Email := "mohamed.barakat@uni-siegen.de",
    PostalAddress := Concatenation(
               "Walter-Flex-Str. 3\n",
               "57068 Siegen\n",
               "Germany" ),
    Place := "Siegen",
    Institution := "University of Siegen",
  ),
],

# BEGIN URLS
SourceRepository := rec(
    Type := "git",
    URL := "https://github.com/homalg-project/WrapperCategories",
),
IssueTrackerURL := Concatenation( ~.SourceRepository.URL, "/issues" ),
PackageWWWHome  := "https://homalg-project.github.io/pkg/WrapperCategories",
PackageInfoURL  := "https://homalg-project.github.io/WrapperCategories/PackageInfo.g",
README_URL      := "https://homalg-project.github.io/WrapperCategories/README.md",
ArchiveURL      := Concatenation( "https://github.com/homalg-project/WrapperCategories/releases/download/v", ~.Version, "/WrapperCategories-", ~.Version ),
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
  BookName  := "WrapperCategories",
  ArchiveURLSubset := ["doc"],
  HTMLStart := "doc/chap0.html",
  PDFFile   := "doc/manual.pdf",
  SixFile   := "doc/manual.six",
  LongTitle := "Construct an equivalent wrapper category out of a CAP category",
),

Dependencies := rec(
  GAP := ">= 4.9.1",
  NeededOtherPackages := [
                   [ "GAPDoc", ">= 1.5" ],
                   [ "ToolsForHomalg", ">= 2020.09.06" ],
                   [ "CAP", ">= 2021.11-09" ],
                   [ "CompilerForCAP", ">= 2021.10-03" ],
                   [ "MonoidalCategories", ">= 2020.03.01" ],
                   [ "CategoryConstructor", ">= 2021.10-01" ],
                  ],
  SuggestedOtherPackages := [
                  ],
  ExternalConditions := [ ],
),

AvailabilityTest := function()
        return true;
    end,

TestFile := "tst/testall.g",

));
