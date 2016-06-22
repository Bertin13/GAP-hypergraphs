HFamily := NewFamily("HHypergraphsFamily");

DeclareRepresentation("HRep",
                      IsComponentObjectRep and IsAttributeStoringRep,
                      ["vertices", "hyperedges"]);

HType := NewType(HFamily, IsHHypergraph and HRep);



