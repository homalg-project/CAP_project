SetPackageInfo( rec(

PackageName := "CAP",

Subtitle := "Categories, Algorithms, Programming",

Version := Maximum( [
  "2018.08.03", ## Mohamed's version
  ## this line prevents merge conflicts
  "2015.04.01", ## Oystein's version
  ## this line prevents merge conflicts
  "2018.08.29", ## Sebas' version
  ## this line prevents merge conflicts
  "2018.02.27", ## Sepp's version
  ## this line prevents merge conflicts
  "2018.08.15", ## Fabian's version
  ## this line prevents merge conflicts
  "2018.08.31", ## Mario's version
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


PackageWWWHome := "http://homalg-project.github.io/CAP_project/CAP/",

ArchiveFormats := ".tar.gz .zip",

ArchiveURL     := Concatenation( "https://github.com/homalg-project/CAP_project/releases/download/CAP-", ~.Version, "/CAP-", ~.Version ),
README_URL     := Concatenation( ~.PackageWWWHome, "README" ),
PackageInfoURL := Concatenation( ~.PackageWWWHome, "PackageInfo.g" ),

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
  GAP := ">= 4.9.1",
  NeededOtherPackages := [ [ "AutoDoc", ">= 2016.02.16" ],
                           [ "ToolsForHomalg", ">= 2018.05.22" ],
                           [ "io", ">=0" ],
  ],
  SuggestedOtherPackages := [ [ "Browse", ">=0" ] ],
  ExternalConditions := []

),

AvailabilityTest := function()
        return true;
    end,

Autoload := false,


));


