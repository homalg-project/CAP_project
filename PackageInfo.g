SetPackageInfo( rec(

PackageName := "CategoriesForHomalg",

Subtitle := "TODO",

Version := Maximum( [
  "2014.05.08", ## Sebas' version
  ## this line prevents merge conflicts
  "2014.03.11", ## Sepp's version
] ),

Date := "12/12/2013",

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
],

Status := "dev",

PackageWWWHome := "http://www.TODO.INSERT.WEBPAGE.HERE/",
#PackageWWWHome := "http://github.com/username/CategoriesForHomalg/",

ArchiveFormats := ".tar.gz",

ArchiveURL     := Concatenation( ~.PackageWWWHome, "CategoriesForHomalg-", ~.Version ),
README_URL     := Concatenation( ~.PackageWWWHome, "README" ),
PackageInfoURL := Concatenation( ~.PackageWWWHome, "PackageInfo.g" ),

AbstractHTML   :=  "",

PackageDoc := rec(
  BookName  := "CategoriesForHomalg",
  ArchiveURLSubset := ["doc"],
  HTMLStart := "doc/chap0.html",
  PDFFile   := "doc/manual.pdf",
  SixFile   := "doc/manual.six",
  LongTitle := "TODO",
),

Dependencies := rec(
  GAP := ">= 4.6",
  NeededOtherPackages := [ [ "AutoDoc", ">= 2014.06.26" ],
                           [ "ToolsForHomalg", ">= 2014.05.08" ],
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


