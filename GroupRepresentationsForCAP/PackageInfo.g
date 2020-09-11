#
# GroupRepresentationsForCAP: Skeletal category of group representations for CAP
#
# This file contains package meta data. For additional information on
# the meaning and correct usage of these fields, please consult the
# manual of the "Example" package as well as the comments in its
# PackageInfo.g file.
#
SetPackageInfo( rec(

PackageName := "GroupRepresentationsForCAP",
Subtitle := "Skeletal category of group representations for CAP",
Version := Maximum( [
  "2017.01.11", ## Sepp's version
  ## this line prevents merge conflicts
  "2019.09.02", ## Mohamed's version
  ## this line prevents merge conflicts
  "2020.09.08", ## Fabian's version
] ),

Date := Concatenation( ~.Version{[ 9, 10 ]}, "/", ~.Version{[ 6, 7 ]}, "/", ~.Version{[ 1 .. 4 ]} ),
License := "GPL-2.0-or-later",


Persons := [
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
PackageWWWHome  := "https://github.com/homalg-project/CAP_project/tree/master/GroupRepresentationsForCAP",
PackageInfoURL  := "https://raw.githubusercontent.com/homalg-project/CAP_project/master/GroupRepresentationsForCAP/PackageInfo.g",
README_URL      := "https://raw.githubusercontent.com/homalg-project/CAP_project/master/GroupRepresentationsForCAP/README.md",
ArchiveURL      := Concatenation( "https://github.com/homalg-project/CAP_project/releases/download/GroupRepresentationsForCAP-", ~.Version, "/GroupRepresentationsForCAP-", ~.Version ),
# END URLS

ArchiveFormats := ".tar.gz",

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
  BookName  := "GroupRepresentationsForCAP",
  ArchiveURLSubset := ["doc"],
  HTMLStart := "doc/chap0.html",
  PDFFile   := "doc/manual.pdf",
  SixFile   := "doc/manual.six",
  LongTitle := "Skeletal category of group representations for CAP",
),

Dependencies := rec(
  GAP := ">= 4.8",
  NeededOtherPackages := [ [ "GAPDoc", ">= 1.5" ],
                           [ "ToolsForHomalg", ">= 2020.09.01" ],
                           [ "CAP", ">= 2015.08.17" ],
                           [ "LinearAlgebraForCAP", ">=2015.12.03" ],
                           [ "RingsForHomalg", ">=2016.08.12" ],
                           [ "repsn", ">=3.0.2" ] ],
  SuggestedOtherPackages := [ ],
  ExternalConditions := [ ],
),

AvailabilityTest := function()
        return true;
    end,

#Keywords := [ "TODO" ],

));
