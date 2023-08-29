# SPDX-License-Identifier: GPL-2.0-or-later
# LinearAlgebraForCAP: Category of Matrices over a Field for CAP
#
# This file contains package meta data. For additional information on
# the meaning and correct usage of these fields, please consult the
# manual of the "Example" package as well as the comments in its
# PackageInfo.g file.
#
SetPackageInfo( rec(

PackageName := "LinearAlgebraForCAP",
Subtitle := "Category of Matrices over a Field for CAP",
Version := "2023.08-08",
Date := (function ( ) if IsBound( GAPInfo.SystemEnvironment.GAP_PKG_RELEASE_DATE ) then return GAPInfo.SystemEnvironment.GAP_PKG_RELEASE_DATE; else return Concatenation( ~.Version{[ 1 .. 4 ]}, "-", ~.Version{[ 6, 7 ]}, "-01" ); fi; end)( ),
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
],

# BEGIN URLS
SourceRepository := rec(
    Type := "git",
    URL := "https://github.com/homalg-project/CAP_project",
),
IssueTrackerURL := Concatenation( ~.SourceRepository.URL, "/issues" ),
PackageWWWHome  := "https://homalg-project.github.io/pkg/LinearAlgebraForCAP",
PackageInfoURL  := "https://homalg-project.github.io/CAP_project/LinearAlgebraForCAP/PackageInfo.g",
README_URL      := "https://homalg-project.github.io/CAP_project/LinearAlgebraForCAP/README.md",
ArchiveURL      := Concatenation( "https://github.com/homalg-project/CAP_project/releases/download/LinearAlgebraForCAP-", ~.Version, "/LinearAlgebraForCAP-", ~.Version ),
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

AbstractHTML   :=  "<span class=\"pkgname\">LinearAlgebraForCAP</span> provides a skeletal model of the category of finite dimensional vector spaces over a computable field.",

PackageDoc := rec(
  BookName  := "LinearAlgebraForCAP",
  ArchiveURLSubset := ["doc"],
  HTMLStart := "doc/chap0.html",
  PDFFile   := "doc/manual.pdf",
  SixFile   := "doc/manual.six",
  LongTitle := "Category of Matrices over a Field for CAP",
),

Dependencies := rec(
  GAP := ">= 4.12.1",
  NeededOtherPackages := [ [ "ToolsForHomalg", ">= 2015.09.18" ],
                           [ "MatricesForHomalg", ">= 2023.01-01" ],
                           [ "GaussForHomalg", ">= 2021.04-02" ],
                           [ "CAP", ">= 2023.08-16" ],
                           [ "MonoidalCategories", ">= 2023.08-11" ],
                           ],
  SuggestedOtherPackages := [
    [ "FreydCategoriesForCAP", ">= 2022.12-02" ],
  ],
  ExternalConditions := [ ],
),

AvailabilityTest := function()
        return true;
    end,

TestFile := "tst/testall.g",

));
