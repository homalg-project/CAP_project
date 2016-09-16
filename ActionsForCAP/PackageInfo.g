#
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

Version := Maximum( [
  "2015.08.19", ## Sebas' version
  ## this line prevents merge conflicts
  "2015.08.19", ## Sepp's version
] ),

Date := ~.Version{[ 1 .. 10 ]},
Date := Concatenation( ~.Date{[ 9, 10 ]}, "/", ~.Date{[ 6, 7 ]}, "/", ~.Date{[ 1 .. 4 ]} ),

Persons := [
  rec(
    IsAuthor := true,
    IsMaintainer := true,
    FirstNames := "Sebastian",
    LastName := "Gutsche",
    WWWHome := "http://wwwb.math.rwth-aachen.de/~gutsche",
    Email := "gutsche@mathematik.uni-kl.de",
    PostalAddress := "TODO",
    Place := "Kaiserslautern",
    Institution := "TU Kaiserslautern",
  ),
  rec(
    IsAuthor := true,
    IsMaintainer := true,
    FirstNames := "Sebastian",
    LastName := "Posur",
    WWWHome := "http://wwwb.math.rwth-aachen.de/Mitarbeiter/posur.php",
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

PackageWWWHome := "http://TODO/",

ArchiveURL     := Concatenation( ~.PackageWWWHome, "ActionsForCAP-", ~.Version ),
README_URL     := Concatenation( ~.PackageWWWHome, "README" ),
PackageInfoURL := Concatenation( ~.PackageWWWHome, "PackageInfo.g" ),

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
  BookName  := "ActionsForCAP",
  ArchiveURLSubset := ["doc"],
  HTMLStart := "doc/chap0.html",
  PDFFile   := "doc/manual.pdf",
  SixFile   := "doc/manual.six",
  LongTitle := "Actions and Coactions for CAP",
),

Dependencies := rec(
  GAP := ">= 4.6",
  NeededOtherPackages := [ [ "GAPDoc", ">= 1.5" ],
                           [ "CAP", ">= 2015.08.17" ],
                           [ "LinearAlgebraForCAP", ">=2015.12.03" ],
                           [ "RingsForHomalg", ">=2016.08.12" ],
                           [ "AttributeCategoryForCAP", ">=2016.09.14" ],
                           [ "ComplexesAndFilteredObjectsForCAP", ">=2015.10.20" ] ],
  SuggestedOtherPackages := [ ],
  ExternalConditions := [ ],
),

AvailabilityTest := function()
        return true;
    end,

TestFile := "tst/testall.g",

#Keywords := [ "TODO" ],

));


