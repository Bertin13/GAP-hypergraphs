#M  HHypergraph( V, Ed ) 
##
##  <#GAPDoc Label="HHypergraph">
##  <ManSection>
##  <Meth Name="HHypergraph" Arg="V, Ed" Label="for list of vertices and edges"/>
##  <Meth Name="HHypergraph" Arg="Ed" Label="for only edges"/>
##
##  <Description>
##
##  Returns the hypergraph object, with vertices <A>V</A> and
##  hyperedges <A>Ed</A>. In the second form, the hyperedges determine
##  the set of vertices, as the union of the hyperedges.
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
    hed := List(hedges, x -> Set(x));
    hed := Filtered(hed, x -> (x<>[]));
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
        Print("Error. Hyperedge", hed[i],
              " not contained in set of vertices", ve, ".\n");
        return;
    fi;
end);

InstallMethod( HHypergraph, "only edges", [ IsList ],  
              function(Ed)
                  return HHypergraph(Union(Ed),Ed);
              end);

#M  Vertices( H ) 
##
##  <#GAPDoc Label="Vertices">
##  <ManSection>
##  <Meth Name="Vertices" Arg="H"/>
##
##  <Description>
##
##  Returns the list of vertices of the hypergraph <A>H</A>.
##
##  </Description>
##
##  </ManSection>
##  <#/GAPDoc>
InstallMethod( Vertices, "for hypergraphs", [ IsHHypergraph ],  
              function(H) return H!.vertices;
              end);

#M  Edges( H ) 
##
##  <#GAPDoc Label="Edges">
##  <ManSection>
##  <Meth Name="Edges" Arg="H"/>
##
##  <Description>
##
##  Returns the list of edges of the hypergraph <A>H</A>.
##
##  </Description>
##
##  </ManSection>
##  <#/GAPDoc>
InstallMethod( Edges, "for hypergraphs", [ IsHHypergraph ], 
              function(H) return H!.hyperedges;
              end);

InstallMethod(PrintObj, "for hypergraphs",
    [IsHHypergraph],
              function(G)
                  Print("Hypergraph with vertices ", Vertices(G), " and edges ", Edges(G), "\n");
              end);

InstallMethod(ViewObj, "for hypergraphs",
              [IsHHypergraph],
              function(G)
                  Print("Hypergraph with vertices ", Vertices(G), " and edges ", Edges(G));
              end);


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
        local Ed, e, i, j, k, isit;
        Ed := Edges(H);
        isit := true;
        i := 1;
        while i < Length(Ed) and isit do
            i := i+1;
            isit := (Length(Ed[i]) = Length(Ed[1]));
        od;
        if isit then
            return Length(Ed[1]);
        else
            return false;
        fi;
    end);

InstallGlobalFunction(IsSimple@,
    function( H )
        local Ed, isit, n, i, j;
        Ed := Edges(H);
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
InstallMethod(IsSimpleH, "for hypergraphs", [ IsHHypergraph ], IsSimple@);

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
    local l, Hn, i, Ed;
    Ed := Edges(H);
    l := IndexOfEdges(H);
    Hn := [];
    for i in l.(x) do
        Append(Hn, RemovedSet@(Ed[i], x));
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
    if not(x in Vertices(H)) or not(y in Vertices(H)) then
        return infinity;
    fi;
    Q := [x];
    l := rec();
    l.(x) := 0;
    T := [];
    Add(T, x);
    nq := Length(Q);
    while nq <> 0 do
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

HDiameter@ := function( H )
    local Ve, i, j, n, notinf, diam, d;
    Ve := Vertices(H);
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

#M  HDiameter( H ) 
##
##  <#GAPDoc Label="HDiameter">
##  <ManSection>
##  <Meth Name="HDiameter" Arg="H"/>
##
##  <Description>
##
##  Returns the diameter of the hypergraph <A>H</A>.
##
##  </Description>
##
##  </ManSection>
##  <#/GAPDoc>
InstallMethod(HDiameter, "for hypergraphs", [ IsHHypergraph ], HDiameter@);

#F  HRemovedEdge( H, e ) 
##
InstallGlobalFunction( HRemovedEdge, function( H, e )
    local Ve, Ed, newEd;
    Ve := Vertices(H);
    Ed := Edges(H);
    newEd := Difference(Ed, [e]);
    return HHypergraph(Ve, newEd);    
end);

HGirth@ := function( H )
    local Ve, Ed, e, i, j, Htemp, pairs, p, nottwo, m, girth, g;
    Ve := Vertices(H);
    Ed := Edges(H);
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
                fi;
            fi;
        od;
    od;
    return girth;
end;

#M  HGirth( H ) 
##
##  <#GAPDoc Label="HGirth">
##  <ManSection>
##  <Meth Name="HGirth" Arg="H"/>
##
##  <Description>
##
##  Returns the girth of the hypergraph <A>H</A>.
##
##  </Description>
##
##  </ManSection>
##  <#/GAPDoc>
InstallMethod( HGirth, "for hypergraphs", [ IsHHypergraph ], HGirth@);

IndexOfEdges@ := function( H )
    local l, Ed, m, x, Ve, v, i, e;
    l := rec();
    Ve := Vertices(H);
    Ed := Edges(H);
    m := Length(Ed);
    for v in Ve do
        l.(v) := [];
    od;
    for i in [1..m] do
        e := Ed[i];
        for x in e do
            Add(l.(x), i);
        od;
    od;
    return l;
end;

#M  IndexOfEdges( H )
##
##  <#GAPDoc Label="IndexOfEdges">
##  <ManSection>
##  <Meth Name="IndexOfEdges" Arg="H"/>
##
##  <Description>
##
##  Given a hypergraph <A>H</A>, the function returns a record
##  <A>I</A>, where <M>I.u</M> is a list of the indices of the edges
##  where the vertex <A>u</A> appears.
##
##  </Description>
##
##  </ManSection>
##  <#/GAPDoc>
InstallMethod( IndexOfEdges, "for hypergraphs", [ IsHHypergraph ], IndexOfEdges@ );

#F  RemovedSet@( S, x )
##
InstallGlobalFunction( RemovedSet@, function( S, x )
    local p, l;
    l := ShallowCopy(S);
    p := PositionSet(S, x);
    if p <> fail then
        Remove(l, p);
    fi;
    return l;
end);

#F  HRemovedVertex( H, x )
##
InstallGlobalFunction( HRemovedVertex, function( H, x )
    local Ve, Ed, nVe, nEd;
    Ve := Vertices(H);
    Ed := Edges(H);
    nVe := RemovedSet@(Ve, x);
    nEd := List(Ed, u -> RemovedSet@(u, x));
    return HHypergraph(nVe, nEd);
end);

#F  IsConnected@( H )
##
InstallGlobalFunction( IsConnected@, function( H )
    local l, x;
    x := Vertices(H)[1];
    l := HDistancesFrom(H, x);
    return (Length(RecNames(l)) = Length(Vertices(H)));
end);

#M  IsConnected( H )
##
##  <#GAPDoc Label="IsConnected">
##  <ManSection>
##  <Meth Name="IsConnected" Arg="H"/>
##
##  <Description>
##
##  Determines whether the hypergraph <A>H</A> is connected.
##
##  </Description>
##
##  </ManSection>
##  <#/GAPDoc>
InstallMethod( IsConnected, "for hypergraphs", [ IsHHypergraph ], IsConnected@ );
