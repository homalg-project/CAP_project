SetPackageInfo( rec(

PackageName := "ModulePresentationsForCAP",
Subtitle := "Category R-pres for CAP",
Version := Maximum( [
           ##
           "2017.12.30", # Sebas version
           ##
           "2018.02.02", # Sepps version
           ##
           "2017.03.27", # Mohamed's version
           ##
           ] ),

Date := ~.Version{[ 1 .. 10 ]},
Date := Concatenation( ~.Date{[ 9, 10 ]}, "/", ~.Date{[ 6, 7 ]}, "/", ~.Date{[ 1 .. 4 ]} ),

Persons := [
  rec(
    IsAuthor := true,
    IsMaintainer := true,
    FirstNames := "Sebastian",
    LastName := "Gutsche",
    WWWHome := "http://www.uni-siegen.de/fb6/rmi/",
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

PackageWWWHome := "http://homalg-project.github.io/CAP_project/ModulePresentationsForCAP/",

ArchiveURL     := Concatenation( "https://github.com/homalg-project/CAP_project/releases/download/ModulePresentationsForCAP-", ~.Version, "/ModulePresentationsForCAP-", ~.Version ),
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

AbstractHTML   :=  "<span class=\"pkgname\">ModulePresentationsForCAP</span> provides the category of finitely presented modules over a computable ring.",

PackageDoc := rec(
  BookName  := "ModulePresentationsForCAP",
  ArchiveURLSubset := ["doc"],
  HTMLStart := "doc/chap0.html",
  PDFFile   := "doc/manual.pdf",
  SixFile   := "doc/manual.six",
  LongTitle := "Category R-pres for CAP",
),

Dependencies := rec(
  GAP := ">= 4.6",
  NeededOtherPackages := [ [ "GAPDoc", ">= 1.5" ],
                           [ "MatricesForHomalg", ">=2017.03.27" ],
                           [ "CAP", ">=2018.02.02" ],
                           [ "GeneralizedMorphismsForCAP", ">=0" ],
  ],
  SuggestedOtherPackages := [ ],
  ExternalConditions := [ ],
),

AvailabilityTest := function()
        return true;
    end,


#Keywords := [ "TODO" ],

));


