SetPackageInfo( rec(

PackageName := "CAP",

Subtitle := "Categories, Algorithms, Programming",

Version := Maximum( [
  "2015.01.08", ## Mohamed's version
  ## this line prevents merge conflicts
  "2015.04.01", ## Oystein's version
  ## this line prevents merge conflicts
  "2016.02.19", ## Sebas' version
  ## this line prevents merge conflicts
  "2015.10.14", ## Sepp's version
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
    PostalAddress := Concatenation( [
      "Lehrstuhl B für Mathematik RWTH - Aachen\n",
      "Templergraben 64\n",
      "52062 Aachen\n",
      "Germany" ] ),
    Place := "Aachen",
    Institution := "Rheinisch-Westfälische Technische Hochschule Aachen",
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

#PackageWWWHome := "http://www.TODO.INSERT.WEBPAGE.HERE/",
PackageWWWHome := "http://homalg-project.github.io/CAP_project/CAP/",

ArchiveFormats := ".tar.gz .zip",

ArchiveURL     := Concatenation( "https://github.com/homalg-project/CAP_project/releases/download/CAP-", ~.Version, "/CAP-", ~.Version ),
README_URL     := Concatenation( ~.PackageWWWHome, "README" ),
PackageInfoURL := Concatenation( ~.PackageWWWHome, "PackageInfo.g" ),

AbstractHTML   :=  "",

PackageDoc := rec(
  BookName  := "CAP",
  ArchiveURLSubset := ["doc"],
  HTMLStart := "doc/chap0.html",
  PDFFile   := "doc/manual.pdf",
  SixFile   := "doc/manual.six",
  LongTitle := "Categories, Algorithms, Programming",
),

Dependencies := rec(
  GAP := ">= 4.6",
  NeededOtherPackages := [ [ "AutoDoc", ">= 2016.02.16" ],
                           [ "ToolsForHomalg", ">= 2016.01.17" ],
                           [ "io", ">=0" ],
  ],
  SuggestedOtherPackages := [ ],
  ExternalConditions := []
                      
),

AvailabilityTest := function()
        return true;
    end,

Autoload := false,

#Keywords := [ " TODO" ],

));


