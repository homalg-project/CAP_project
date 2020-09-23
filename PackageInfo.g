#
# Toposes: Elementary toposes
#
# This file contains package meta data. For additional information on
# the meaning and correct usage of these fields, please consult the
# manual of the "Example" package as well as the comments in its
# PackageInfo.g file.
#
SetPackageInfo( rec(

PackageName := "Toposes",
Subtitle := "Elementary toposes",
Version := Maximum( [
                   "2020.07.01", ## Mohamed's version
                   ## this line prevents merge conflicts
                   "2019.03.16", ## Tom's version
                   ## this line prevents merge conflicts
                   "2019.01.29", ## Mario's version
                   ## this line prevents merge conflicts
                   "2020.04.27", ## Fabian's version
                   ## this line prevents merge conflicts
                   "2019.09.17", ## Sepp's version
                   ] ),

Date := ~.Version{[ 1 .. 10 ]},
Date := Concatenation( ~.Version{[ 9, 10 ]}, "/", ~.Version{[ 6, 7 ]}, "/", ~.Version{[ 1 .. 4 ]} ),
License := "GPL-2.0-or-later",

Persons := [
  rec(
    IsAuthor := true,
    IsMaintainer := true,
    FirstNames := "Mohamed",
    LastName := "Barakat",
    WWWHome := "https://mohamed-barakat.github.io",
    Email := "mohamed.barakat@uni-siegen.de",
    PostalAddress := Concatenation(
               "Walter-Flex-Str. 3\n",
               "57068 Siegen\n",
               "Germany" ),
    Place := "Siegen",
    Institution := "University of Siegen",
  ),
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
  rec(
    IsAuthor := true,
    IsMaintainer := true,
    FirstNames := "Mario",
    LastName := "Román",
    WWWHome := "https://mroman42.github.io/",
    Email := "mromang08@gmail.com",
    PostalAddress := Concatenation(
               "Mathematical Institute\n",
               "University of Oxford\n",
               "Oxford, United Kingdom" ),
    Place := "Oxford",
    Institution := "University of Oxford",
  ),
  rec(
    IsAuthor := true,
    IsMaintainer := true,
    FirstNames := "Tom",
    LastName := "Kuhmichel",
    WWWHome := "https://github.com/TKuh",
    Email := "tom.kuhmichel@student.uni-siegen.de",
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
    URL := "https://github.com/homalg-project/Toposes",
),
IssueTrackerURL := Concatenation( ~.SourceRepository.URL, "/issues" ),
PackageWWWHome  := "https://homalg-project.github.io/Toposes",
PackageInfoURL  := "https://homalg-project.github.io/Toposes/PackageInfo.g",
README_URL      := "https://homalg-project.github.io/Toposes/README.md",
ArchiveURL      := Concatenation( "https://github.com/homalg-project/Toposes/releases/download/v", ~.Version, "/Toposes-", ~.Version ),
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
  BookName  := "Toposes",
  ArchiveURLSubset := ["doc"],
  HTMLStart := "doc/chap0.html",
  PDFFile   := "doc/manual.pdf",
  SixFile   := "doc/manual.six",
  LongTitle := "Elementary toposes",
),

Dependencies := rec(
  GAP := ">= 4.9.1",
  NeededOtherPackages := [
                   [ "GAPDoc", ">= 1.5" ],
                   [ "CAP", ">= 2020.05.16" ],
                   ],
  SuggestedOtherPackages := [
                   [ "MonoidalCategories", ">= 2019.03.16" ],
                   ],
  ExternalConditions := [ ],
),

AvailabilityTest := function()
        return true;
    end,

TestFile := "tst/testall.g",

Keywords := [ "elementary toposes" ],

));
