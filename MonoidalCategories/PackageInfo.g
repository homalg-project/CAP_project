#
# MonoidalCategories: Monoidal and monoidal (co)closed categories
#
# This file contains package meta data. For additional information on
# the meaning and correct usage of these fields, please consult the
# manual of the "Example" package as well as the comments in its
# PackageInfo.g file.
#
SetPackageInfo( rec(

PackageName := "MonoidalCategories",
Subtitle := "Monoidal and monoidal (co)closed categories",
Version := Maximum( [
  "2020.03-01", ## Mohamed's version
  ## this line prevents merge conflicts
  "2019.06-07", ## Sebas' version
  ## this line prevents merge conflicts
  "2020.04-16", ## Sepp's version
  ## this line prevents merge conflicts
  "2020.10-01", ## Fabian's version
  ## this line prevents merge conflicts
  "2019.02-01", ## Tom's version
] ),

Date := "19/10/2020",
License := "GPL-2.0-or-later",

Persons := [
  rec(
    IsAuthor := true,
    IsMaintainer := true,
    FirstNames := "Mohamed",
    LastName := "Barakat",
    WWWHome := "http://algebra.mathematik.uni-siegen.de/barakat/",
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
    FirstNames := "Sebastian",
    LastName := "Gutsche",
    WWWHome := "http://algebra.mathematik.uni-siegen.de/gutsche/",
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
    WWWHome := "http://algebra.mathematik.uni-siegen.de/posur/",
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
PackageWWWHome  := "https://homalg-project.github.io/CAP_project/MonoidalCategories",
PackageInfoURL  := "https://homalg-project.github.io/CAP_project/MonoidalCategories/PackageInfo.g",
README_URL      := "https://homalg-project.github.io/CAP_project/MonoidalCategories/README.md",
ArchiveURL      := Concatenation( "https://github.com/homalg-project/CAP_project/releases/download/MonoidalCategories-", ~.Version, "/MonoidalCategories-", ~.Version ),
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

AbstractHTML   :=  "",

PackageDoc := rec(
  BookName  := "MonoidalCategories",
  ArchiveURLSubset := ["doc"],
  HTMLStart := "doc/chap0.html",
  PDFFile   := "doc/manual.pdf",
  SixFile   := "doc/manual.six",
  LongTitle := "Monoidal and monoidal (co)closed categories",
),

Dependencies := rec(
  GAP := ">= 4.9.1",
  NeededOtherPackages := [
                   [ "GAPDoc", ">= 1.5" ],
                   [ "ToolsForHomalg", ">= 2018.05.22" ],
                   [ "CAP", ">= 2019.08.10" ],
                   ],
  SuggestedOtherPackages := [ ],
  ExternalConditions := [ ],
),

AvailabilityTest := function()
        return true;
    end,

TestFile := "tst/testall.g",

Keywords := [ "monoidal categories", "monoidal closed categories", "monoidal coclosed categories", "tensor-Hom adjuction", "coHom-tensor adjuction" ],

));
