#
# ToricSheaves: Toric sheaves as Serre quotients
#
# This file contains package meta data. For additional information on
# the meaning and correct usage of these fields, please consult the
# manual of the "Example" package as well as the comments in its
# PackageInfo.g file.
#
SetPackageInfo( rec(

PackageName := "ToricSheaves",
Subtitle := "Toric sheaves as Serre quotients",
Version := "2016.08.12",
Date := "12/08/2016", # dd/mm/yyyy format
License := "GPL-2.0-or-later",

Persons := [
  rec(
    IsAuthor := true,
    IsMaintainer := true,
    FirstNames := "Sebastian",
    LastName := "Gutsche",
    WWWHome := "http://wwwb.math.rwth-aachen.de/~gutsche/",
    Email := "gutsche@mathematik.uni-siegen.de",
    PostalAddress := "TODO",
    Place := "Siegen",
    Institution := "Universitaet Siegen",
  ),
],

PackageWWWHome := "http://homalg-project.github.io/CAP_project/",

ArchiveURL     := Concatenation( ~.PackageWWWHome, "ToricSheaves-", ~.Version ),
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
  BookName  := "ToricSheaves",
  ArchiveURLSubset := ["doc"],
  HTMLStart := "doc/chap0.html",
  PDFFile   := "doc/manual.pdf",
  SixFile   := "doc/manual.six",
  LongTitle := "Toric sheaves as Serre quotients",
),

Dependencies := rec(
  GAP := ">= 4.6",
  NeededOtherPackages := [ [ "GAPDoc", ">= 1.5" ],
                           [ "GradedModulePresentationsForCAP", ">=0" ],
                           [ "GeneralizedMorphismsForCAP", ">=0" ],
                           [ "PolymakeInterface", ">=0" ],
                           [ "4ti2Interface", ">=0" ] ],
  SuggestedOtherPackages := [ [ "ToricVarieties", ">=0" ] ],
  ExternalConditions := [ ],
),

AvailabilityTest := function()
        return true;
    end,

TestFile := "tst/testall.g",

#Keywords := [ "TODO" ],

));


