SetPackageInfo( rec(

PackageName := "GeneralizedMorphismsForCAP",
Subtitle := "Implementations of generalized morphisms for the CAP project",

Version := Maximum( [
  "2015.12.09", ## Sebas' version
## this line prevents merge conflicts
  "2015.11.19", ## Sepp's version
## this line prevents merge conflicts
   ] ),

Date := ~.Version{[ 1 .. 10 ]},
Date := Concatenation( ~.Date{[ 9, 10 ]}, "/", ~.Date{[ 6, 7 ]}, "/", ~.Date{[ 1 .. 4 ]} ),

Persons := [
  rec(
    IsAuthor := true,
    IsMaintainer := true,
    FirstNames := "Sebastian",
    LastName := "Posur",
    WWWHome := "http://wwwb.math.rwth-aachen.de/Mitarbeiter/posur.php",
    Email := "sposur@momo.math.rwth-aachen.de",
    PostalAddress := Concatenation(
               "Sebastian Posur\n",
               "Lehrstuhl B fuer Mathematik, RWTH Aachen\n",
               "Templergraben 64\n",
               "52062 Aachen\n",
               "Germany" ),
    Place := "Aachen",
    Institution := "RWTH Aachen University",
  ),
  rec(
    IsAuthor := true,
    IsMaintainer := true,
    FirstNames := "Sebastian",
    LastName := "Gutsche",
    WWWHome := "http://wwwb.math.rwth-aachen.de/~gutsche/",
    Email := "gutsche@momo.math.rwth-aachen.de",
    PostalAddress := Concatenation(
               "Department of Mathematics\n",
               "University of Kaiserslautern\n",
               "67653 Kaiserslautern\n",
               "Germany" ),
    Place := "Kaiserslautern",
    Institution := "TU Kaiserslautern",
  ),
],

PackageWWWHome := "http://homalg-project.github.io/CAP_project/GeneralizedMorphismsForCAP/",

ArchiveURL     := Concatenation( "https://github.com/homalg-project/CAP_project/releases/download/GeneralizedMorphismsForCAP-", ~.Version, "/GeneralizedMorphismsForCAP-", ~.Version ),
README_URL     := Concatenation( ~.PackageWWWHome, "README" ),
PackageInfoURL := Concatenation( ~.PackageWWWHome, "PackageInfo.g" ),

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
  BookName  := "GeneralizedMorphismsForCAP",
  ArchiveURLSubset := ["doc"],
  HTMLStart := "doc/chap0.html",
  PDFFile   := "doc/manual.pdf",
  SixFile   := "doc/manual.six",
  LongTitle := "Implementations of generalized morphisms for the CAP project",
),

Dependencies := rec(
  GAP := ">= 4.6",
  NeededOtherPackages := [ [ "GAPDoc", ">= 1.5" ],
                           [ "CAP", ">=2015.05.08" ] ],
  SuggestedOtherPackages := [ ],
  ExternalConditions := [ ],
),

AvailabilityTest := function()
        return true;
    end,


#Keywords := [ "TODO" ],

));


