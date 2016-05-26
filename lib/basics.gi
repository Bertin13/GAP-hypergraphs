#M  HHypergraph( V, Ed ) 
##
##  <#GAPDoc Label="HHypergraph">
##  <ManSection>
##  <Meth Name="HHypergraph" Arg="V, Ed"/>
##
##  <Description>
##
##  Returns the hypergraph object, with vertices <A>V</A> and
##  hyperedges <A>Ed</A>.
##
##  </Description>
##
##  </ManSection>
##  <#/GAPDoc>
InstallMethod( HHypergraph,
"method to create hypergraphs",
[IsList, IsList],
function (verts, hedges)
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

# InstallMethod(Vertices, "for hypergraphs",
#               [IsHHypergraph],
#     function( H )
#         return H!.vertices;
#     end);

#M  IsUniform( H ) 
##
##  <#GAPDoc Label="IsUniform">
##  <ManSection>
##  <Meth Name="IsUniform" Arg="H"/>
##
##  <Description>
##
##  Determines if the hypergraph <A>H</A> is uniform, that is, if all
##  edges of <A>H</A> have the same cardinality <M>k</M>. If <A>H</A>
##  is uniform, then the function returns <M>k</M>, otherwise, it returns false.
##
##  </Description>
##
##  </ManSection>
##  <#/GAPDoc>
InstallMethod(IsUniform, "for hypergraphs", [ IsHHypergraph ],
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
            return false;
        fi;
    end);

#M  IsSimple( H ) 
##
##  <#GAPDoc Label="IsSimple">
##  <ManSection>
##  <Meth Name="IsSimple" Arg="H"/>
##
##  <Description>
##
##  Determines whether the hypergraph <A>H</A> is simple. (A
##  hypergraph is simple if no edge is contained in another edge.)
##
##  </Description>
##
##  </ManSection>
##  <#/GAPDoc>
InstallMethod(IsSimple, "for hypergraphs", [ IsHHypergraph ],
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

#F  HCompleteHypergraph( n, r ) 
##
InstallGlobalFunction( HCompleteHypergraph, function( n, r )
    return HHypergraph([1..n], Combinations([1..n], r));    
end);

#F  HRandomUniformHypergraph( n, r, p ) 
##
InstallGlobalFunction( HRandomUniformHypergraph, function( n, r, p )
    local combs, edges, i, e, fl;
    edges := [];
    combs := Combinations([1..n], r);
    for e in combs do
        fl := Float((1/1000000)*Random(0,1000000));
        if fl < p then
            Add(edges, e);
        fi;
    od;
    return HHypergraph([1..n], edges);
end);

#F  HNeighborhood( H, x ) 
##
InstallGlobalFunction( HNeighborhood, function( H, x )
    local Ve, Ed, Hn, e;
    Ve := H!.vertices;
    Ed := ShallowCopy(H!.hyperedges);
    Hn := [];
    for e in Ed do
        if x in e then
            Append(Hn, Difference(e, [x]));
        fi;
    od;
    return Set(Hn);    
end);

#F  HDistancesFrom( H, x ) 
##
InstallGlobalFunction( HDistancesFrom, function( H, x )
    local Q, l, T, nq, u, Hn, v;
    Q := [x];
    l := rec();
    l.(x) := 0;
    T := [];
    Add(T, x);
    nq := Length(Q);
    while nq <> 0 do
        #Print(l,"\n");
        u := Remove(Q, 1);
        nq := nq-1;
        Hn := Difference(HNeighborhood(H, u), T);
        for v in Hn do
            Add(T, v);
            l.(v) := l.(u)+1;
            Add(Q, v);
            nq := nq+1;
        od;
    od;
    return l;    
end);

#F  HDistance( H, x, y ) 
##
InstallGlobalFunction( HDistance, function( H, x, y )
    local Q, l, T, nq, u, Hn, v;
    Q := [x];
    l := rec();
    l.(x) := 0;
    T := [];
    Add(T, x);
    nq := Length(Q);
    while nq <> 0 do
        #Print(l,"\n");
        u := Remove(Q, 1);
        nq := nq-1;
        Hn := Difference(HNeighborhood(H, u), T);
        if y in Hn then
            return l.(u)+1;
        else
            for v in Hn do
                Add(T, v);
                l.(v) := l.(u)+1;
                Add(Q, v);
                nq := nq+1;
            od;
        fi;
    od;
    return infinity;
end);

HY@DIAMETER := function( H )
    local Ve, i, j, n, notinf, diam, d;
    Ve := H!.vertices;
    n := Length(Ve);
    notinf := true;
    i := 0;
    diam := 0;
    while notinf and i < n do
        i := i+1;
        j := i;
        while notinf and j < n do
            j := j+1;
            d := HDistance(H, Ve[i], Ve[j]);
            if d = infinity then 
                notinf := false;
                diam := infinity;
            else
                if d > diam then
                    diam := d;
                fi;
            fi;
        od;
    od;
    return diam;
end;

#M  Diameter( H ) 
##
##  <#GAPDoc Label="Diameter">
##  <ManSection>
##  <Meth Name="Diameter" Arg="H"/>
##
##  <Description>
##
##  Returns the diameter of the hypergraph <A>H</A>.
##
##  </Description>
##
##  </ManSection>
##  <#/GAPDoc>
InstallMethod(Diameter, "for hypergraphs", [ IsHHypergraph ], 1, HY@DIAMETER);

#F  HRemovedEdge( H, e ) 
##
InstallGlobalFunction( HRemovedEdge, function( H, e )
    local Ve, Ed, newEd;
    Ve := H!.vertices;
    Ed := H!.hyperedges;
    newEd := Difference(Ed, [e]);
    return HHypergraph(Ve, newEd);    
end);

HY@GIRTH := function( H )
    local Ve, Ed, e, i, j, Htemp, pairs, p, nottwo, m, girth, g;
    Ve := H!.vertices;
    Ed := H!.hyperedges;
    nottwo := true;
    m := Length(Ed);
    i := 0;
    girth := infinity;
    while nottwo and i < m do
        i := i+1;
        e := Ed[i];
        pairs := Combinations(e, 2);
        p := Length(pairs);
        Htemp := HRemovedEdge(H, e);
        j := 0;
        while nottwo and j < p do
            j := j+1;
            g := HDistance(Htemp, pairs[j][1], pairs[j][2]) + 1;
            if g = 2 then
                nottwo := false;
                girth := 2;
            else
                if g < girth then
                    girth := g;
                    #Print("Girth improved!, x=",pairs[j][1],", y=", pairs[j][2], "\n");
                fi;
            fi;
        od;
    od;
    return girth;
end;

#M  Girth( H ) 
##
##  <#GAPDoc Label="Girth">
##  <ManSection>
##  <Meth Name="Girth" Arg="H"/>
##
##  <Description>
##
##  Returns the girth of the hypergraph <A>H</A>.
##
##  </Description>
##
##  </ManSection>
##  <#/GAPDoc>
InstallMethod( Girth, "for hypergraphs", [ IsHHypergraph ], 1, HY@GIRTH);


