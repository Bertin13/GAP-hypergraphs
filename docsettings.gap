# Useful to create GAP documentation of this package

path := Directory("./doc");;
main := "main.xml";;
files := ["../lib/weak-coloring.gd", "../lib/weak-coloring.gi","../PackageInfo.g"];;
bookname := "hypergraphs";;

MakeGAPDocDoc(path, main, files, bookname);;
