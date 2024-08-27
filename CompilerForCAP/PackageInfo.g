# SPDX-License-Identifier: GPL-2.0-or-later
# CompilerForCAP: Speed up and verify categorical algorithms
#
# This file contains package meta data. For additional information on
# the meaning and correct usage of these fields, please consult the
# manual of the "Example" package as well as the comments in its
# PackageInfo.g file.
#
SetPackageInfo( rec(

PackageName := "CompilerForCAP",
Subtitle := "Speed up and verify categorical algorithms",
Version := "2024.08-03",
Date := "2024-08-27",
License := "GPL-2.0-or-later",

Persons := [
  rec(
    IsAuthor := true,
    IsMaintainer := true,
    FirstNames := "Fabian",
    LastName := "Zickgraf",
    WWWHome := "https://github.com/zickgraf/",
    Email := "fabian.zickgraf@uni-siegen.de",
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
    URL := "https://github.com/homalg-project/CAP_project",
),
IssueTrackerURL := Concatenation( ~.SourceRepository.URL, "/issues" ),
PackageWWWHome  := "https://homalg-project.github.io/pkg/CompilerForCAP",
PackageInfoURL  := "https://homalg-project.github.io/CAP_project/CompilerForCAP/PackageInfo.g",
README_URL      := "https://homalg-project.github.io/CAP_project/CompilerForCAP/README.md",
ArchiveURL      := Concatenation( "https://github.com/homalg-project/CAP_project/releases/download/CompilerForCAP-", ~.Version, "/CompilerForCAP-", ~.Version ),
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
  BookName  := "CompilerForCAP",
  ArchiveURLSubset := ["doc"],
  HTMLStart := "doc/chap0.html",
  PDFFile   := "doc/manual.pdf",
  SixFile   := "doc/manual.six",
  LongTitle := "Speed up and verify categorical algorithms",
),

Dependencies := rec(
  GAP := ">= 4.13.0",
  NeededOtherPackages := [
      [ "ToolsForHomalg", ">= 2022.09-04" ],
      [ "CAP", ">= 2023.06-06" ],
  ],
  SuggestedOtherPackages := [ ],
  ExternalConditions := [ ],
),

Extensions := [
  rec(
    needed := [ [ "MatricesForHomalg", ">= 2023.11-02" ] ],
    filename := "gap/TypeSignaturesOfMatricesForHomalg.gi",
  ),
  rec(
    needed := [ [ "QPA", ">= 2.0" ] ],
    filename := "gap/TypeSignaturesOfQPA.gi",
  ),
],

AvailabilityTest := ReturnTrue,

TestFile := "tst/testall.g",

#Keywords := [ "TODO" ],

));
