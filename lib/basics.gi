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

InstallMethod(PrintObj,"for hypergraphs",
  [IsHHypergraph],
  function(G)
  Print("Hypergraph with vertices ",G!.vertices," and edges ",G!.hyperedges,"\n");
end);

InstallMethod(ViewObj,"for hypergraphs",
  [IsHHypergraph],
function(G)
  Print("Hypergraph with vertices ",G!.vertices," and edges ",G!.hyperedges);
end);

InstallMethod(Vertices," for hypergraphs",
              [IsHHypergraph],
    function( H )
        return H!.vertices;
    end);

InstallMethod(IsUniform,"for hypergraphs",
              [IsHHypergraph],
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

InstallMethod(IsSimple, "for hypergraphs", [IsHHypergraph],
    function( H )
        local Ed, isit, n, i, j;
        Ed := H!.hyperedges;
        n := Length(Ed);
        isit := true;
        i := 0;
        while i < n and isit do
            i := i+1;
            j := i;
            while j < n and isit do
                j := j+1;
                isit := not(IsSubset(Ed[i], Ed[j]) or IsSubset(Ed[j], Ed[i]));
            od;
        od;
        return isit;
    end);

HCompleteHypergraph := function (n, r)
    return HHypergraph([1..n], Combinations([1..n], r));
end;

HDualHypergraph :=function ( V, E )
    local i, j, k, EE;
    EE:=[[]];
    k :=Length(E);
    for i in V do
        EE[i] := [];
        for j in [1..k] do
            if i in E[j] then
                Add(EE[i],j);
            fi;
        od; 
    od;   
    return EE;
end;
