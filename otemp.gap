HCategory := NewCategory("HHypergraphs", IsRecord);

HFamily := NewFamily("HHypergraphsFamily");

HType := NewType(HFamily, HCategory);

HRep := NewRepresentation("HRep",
                          IsComponentObjectRep and IsAttributeStoringRep,
                          ["vertices", "hyperedges"]);

DeclareOperation("HHypergraph", [IsList, IsList]);

InstallMethod( HHypergraph,
"method to create hypergraphs",
[IsList, IsList],
function (verts,hedges)
    local ve, hed, isvalid, i;
    ve := Set(verts);
    hed := List(hedges,x->Set(x));
    isvalid := true;
    i := 0;
    while isvalid and i < Length(hed) do
        i := i+1;
        isvalid := IsSubset(ve, hed[i]);
    od;
    if isvalid then
        return Objectify(HType,
                         rec(vertices := ve,
                             hyperedges := hed));
    else
        Print("Error. Hyperedge not contained in set of vertices.\n");
        return;
    fi;
end);

G:=HHypergraph([1,2,3,4],[[1,2,3],[1,2,4]]);

InstallMethod(PrintObj,"for hypergraphs",
  [HCategory],
  function(G)
  Print("Hypergraph with vertices ",G!.vertices," and edges ",G!.hyperedges,"\n");
end);

InstallMethod(ViewObj,"for hypergraphs",
  [HCategory],
function(G)
  Print("Hypergraph with vertices ",G!.vertices," and edges ",G!.hyperedges);
end);

DeclareOperation("IsUniform",[HCategory]);

InstallMethod(IsUniform,"for hypergraphs",
              [HCategory],
    function( H )
        local E,e, i, j, k, aux,r, isit;
        E := H!.hyperedges;
        isit := true;
        i := 1;
        while i < Length(E) and isit do
            i := i+1;
            isit := (Length(E[i]) = Length(E[1]));
        od;
        if isit then
            Print("It's a ",Length(E[1]),"-uniform hypergraph \n");
            return Length(E[1]);
        else
            Print("It's not a uniform hypergraph.\n");
        fi;
    end);

InstallMethod(IsSimple, "for hypergraphs", [HCategory],
    function( H )
        local Ed, isit, n, i, j, k, combs;
        Ed := H!.hyperedges;
        n := Length(Ed);
        isit := true;
        i := 0;
        combs := Combinations([1..n], 2);
        while i < Binomial(n,2) and isit do
            i := i+1;
            j := combs[i][1];
            k := combs[i][2];
            isit := not(IsSubset(Ed[j], Ed[k]) or IsSubset(Ed[k], Ed[j]));
        od;
        return isit;
    end);

HCompleteHypergraph := function (n, r)
    return HHypergraph([1..n], Combinations([1..n], r));
end;

# HDualHypergraph := function( H )
#     local E, V;
    

