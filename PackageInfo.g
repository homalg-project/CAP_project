SetPackageInfo( rec(

PackageName := "CategoriesForHomalg",

Subtitle := "TODO",

Version := "0.1",

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
  NeededOtherPackages := [ [ "GAPDoc", ">= 1.5" ] ],
  SuggestedOtherPackages := [ ],
  ExternalConditions := []
                      
),

AvailabilityTest := function()
        return true;
    end,

Autoload := false,

#Keywords := [ " TODO" ],

));


