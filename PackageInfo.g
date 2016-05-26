SetPackageInfo( rec(
  PackageName := "hypergraphs",
  Version := "0.1",
##  <#GAPDoc Label="PKGVERSIONDATA">
##  <!ENTITY VERSION "0.1">
##  <!ENTITY RELEASEDATE "16 February 2016">
##  <#/GAPDoc>

  PackageDoc := rec(
      BookName  := "hypergraphs",
      SixFile   := "doc/manual.six",
      Autoload  := true ),
  Dependencies := rec(
      GAP       := "4.5",
      NeededOtherPackages := [ ["GAPDoc", "1.3"], ["design", "1.6"] ] ),
  AvailabilityTest := ReturnTrue ) );
