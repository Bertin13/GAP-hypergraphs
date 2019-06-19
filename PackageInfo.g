SetPackageInfo( rec(
  PackageName := "hypergraphs",
  Version := "0.1",
  Subtitle := "Basic functions for hypergraphs",
  Date := "19/06/2019",
  ArchiveURL := "https://github.com/Bertin13/GAP-hypergraphs",
  ArchiveFormats := ".tar.gz",
  Status := "dev",
  README_URL := "https://github.com/Bertin13/GAP-hypergraphs/blob/master/README.md",
  PackageInfoURL := "https://github.com/Bertin13/GAP-hypergraphs/blob/master/PackageInfo.g",
  AbstractHTML :=
  "The <span class=\"pkgname\">hypergraphs</span> package, as its name suggests, \
   provides basic functions for working with hypergraphs.",
  PackageWWWHome := "https://github.com/Bertin13/GAP-hypergraphs",

##  <#GAPDoc Label="PKGVERSIONDATA">
##  <!ENTITY VERSION "0.1">
##  <!ENTITY RELEASEDATE "16 February 2016">
##  <#/GAPDoc>

  PackageDoc := rec(
                     BookName  := "hypergraphs",
                     ArchiveURLSubset := ["doc"],
                     HTMLStart := "doc/chap0.html",
                     PDFFile   := "doc/manual.pdf",
                     SixFile   := "doc/manual.six",
                     LongTitle := "Basic functions for hypergraphs",
                     Autoload  := true ),
  Dependencies := rec(
                       GAP       := "4.5",
                       NeededOtherPackages := [ ["GAPDoc", "1.3"], ["design", "1.6"] ] ),
  AvailabilityTest := ReturnTrue ) );
