#
# CAPCategoryOfProjectiveGradedModules: Category of projective graded modules over a graded ring
#
# This file contains package meta data. For additional information on
# the meaning and correct usage of these fields, please consult the
# manual of the "Example" package as well as the comments in its
# PackageInfo.g file.
#
SetPackageInfo( rec(

PackageName := "CAPCategoryOfProjectiveGradedModules",

Subtitle := "Category of projective graded modules over a graded ring",

Version := Maximum( [
  "2015.11.13", ## Martin's version
] ),

Date := ~.Version{[ 1 .. 10 ]},
Date := Concatenation( ~.Date{[ 9, 10 ]}, "/", ~.Date{[ 6, 7 ]}, "/", ~.Date{[ 1 .. 4 ]} ),

Persons := [
  rec(
    IsAuthor := true,
    IsMaintainer := true,
    FirstNames := "Martin",
    LastName := "Bies",
    WWWHome := "TODO",
    Email := "bies@thphys.uni-heidelberg.de",
    PostalAddress := Concatenation( 
                 "Institut für theoretische Physik - Heidelberg \n",
                 "Philosophenweg 19 \n",
                 "69120 Heidelberg \n",
                 "Germany" ), 
    Place := "Heidelberg",
    Institution := "ITP Heidelberg",
  ),
],

PackageWWWHome := "http://TODO/",

ArchiveURL     := Concatenation( ~.PackageWWWHome, "CAPCategoryOfProjectiveGradedModules-", ~.Version ),
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
  BookName  := "CAPCategoryOfProjectiveGradedModules",
  ArchiveURLSubset := ["doc"],
  HTMLStart := "doc/chap0.html",
  PDFFile   := "doc/manual.pdf",
  SixFile   := "doc/manual.six",
  LongTitle := "Category of projective graded modules over a graded ring",
),

Dependencies := rec(
  GAP := ">= 4.6",
  NeededOtherPackages := [ [ "GAPDoc", ">= 1.5" ],
                           [ "MatricesForHomalg", ">= 2015.06.20" ],
                           [ "GradedRingForHomalg", "2014.08.27" ],
                           [ "CAP", ">= 2015.08.17" ],
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
