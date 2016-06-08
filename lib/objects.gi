HFamily := NewFamily("HHypergraphsFamily");

DeclareRepresentation("HRep",
                      IsComponentObjectRep and IsAttributeStoringRep,
                      ["vertices", "hyperedges"]);

HType := NewType(HFamily, IsHHypergraph and HRep);
<<<<<<< HEAD
=======

>>>>>>> ce7c4b9e4fac0b477d504a56de124c35ab625fa9
