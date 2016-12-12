# Useful to create GAP documentation of this package

path := Directory("./doc");;
main := "main.xml";;
files := [
           "../lib/weak-coloring.gd", 
           "../lib/weak-coloring.gi",
           "../lib/basics.gd",
           "../lib/basics.gi",
           "../lib/objects.gd",
           "../lib/objects.gi",
           "../lib/library.gd",
           "../lib/library.gi",
           "../PackageInfo.g"];;
bookname := "hypergraphs";;

MakeGAPDocDoc(path, main, files, bookname);;
