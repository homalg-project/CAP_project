# SPDX-License-Identifier: GPL-2.0-or-later
# CAP: Categories, Algorithms, Programming
#
# This file contains package meta data. For additional information on
# the meaning and correct usage of these fields, please consult the
# manual of the "Example" package as well as the comments in its
# PackageInfo.g file.
#
SetPackageInfo( rec(

PackageName := "CAP",
Subtitle := "Categories, Algorithms, Programming",
Version := "2022.08-05",
Date := "16/08/2022",
License := "GPL-2.0-or-later",

Persons := [
  rec(
    IsAuthor := true,
    IsMaintainer := true,
    FirstNames := "Sebastian",
    LastName := "Gutsche",
    WWWHome := "https://sebasguts.github.io/",
    Email := "gutsche@mathematik.uni-siegen.de",
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
    Email := "sebastian.posur@uni-siegen.de",
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
    FirstNames := "Øystein",
    LastName := "Skartsæterhagen",
    WWWHome := "http://www.math.ntnu.no/~oysteini/",
    Email := "oysteini@math.ntnu.no",
    PostalAddress := Concatenation( [
      "NTNU\n",
      "Institutt for matematiske fag\n",
      "7491 Trondheim\n",
      "Norway" ] ),
    Place := "Trondheim",
    Institution := "Norges teknisk-naturvitenskapelige universitet",
   ),
],

Status := "deposited",

# BEGIN URLS
SourceRepository := rec(
    Type := "git",
    URL := "https://github.com/homalg-project/CAP_project",
),
IssueTrackerURL := Concatenation( ~.SourceRepository.URL, "/issues" ),
PackageWWWHome  := "https://homalg-project.github.io/pkg/CAP",
PackageInfoURL  := "https://homalg-project.github.io/CAP_project/CAP/PackageInfo.g",
README_URL      := "https://homalg-project.github.io/CAP_project/CAP/README.md",
ArchiveURL      := Concatenation( "https://github.com/homalg-project/CAP_project/releases/download/CAP-", ~.Version, "/CAP-", ~.Version ),
# END URLS

ArchiveFormats := ".tar.gz .zip",

AbstractHTML   :=  
  Concatenation( [
  "<span class=\"pkgname\">CAP</span> (Categories, Algorithms, Programming) is a package for category theory.\n",
  "It facilitates the implementation of specific instances of categories\n",
  "and provides a language for writing generic categorical algorithms." ] ),

PackageDoc := rec(
  BookName  := "CAP",
  ArchiveURLSubset := ["doc"],
  HTMLStart := "doc/chap0.html",
  PDFFile   := "doc/manual.pdf",
  SixFile   := "doc/manual.six",
  LongTitle := "Categories, Algorithms, Programming",
),

Dependencies := rec(
  GAP := ">= 4.11.1",
  NeededOtherPackages := [ [ "AutoDoc", ">= 2016.02.16" ],
                           [ "ToolsForHomalg", ">= 2022.04-03" ],
                           [ "io", ">=0" ],
  ],
  SuggestedOtherPackages := [ [ "Browse", ">=0" ],
                              [ "CompilerForCAP", ">= 2021.12-05" ],
  ],
  ExternalConditions := []

),

AvailabilityTest := function()
        return true;
    end,

TestFile := "tst/testall.g",

));
