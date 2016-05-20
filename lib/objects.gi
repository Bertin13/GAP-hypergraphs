HFamily := NewFamily("HHypergraphsFamily");

HType := NewType(HFamily, IsHHypergraph);

DeclareRepresentation("HRep",
                      IsComponentObjectRep and IsAttributeStoringRep,
                      ["vertices", "hyperedges"]);


