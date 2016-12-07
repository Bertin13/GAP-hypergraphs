PLovasz :=function ( E )
    local aux, i, j, k, a, suma, XX;
    k:=Length(E);
    aux:=0;
    suma:=0;
    a:=1;
    for i in [1..k-1] do
        XX:=ShallowCopy(E[i]);
        for j in [i+1..k] do
            suma:=Length(Union(XX,E[j]));
            a:=a+1;
            if suma < a+1 then
                Print("Try with another method \n");
                aux:=0;
                return;
            else
                XX:=Union(XX,E[j]);
                aux:=1;
            fi;
        od;
        a:=1;
        suma:=0;
    od;
    if aux = 1 then
        Print("The hypergraph has chromatic number 2\n");
    fi;
end;

HIncidenceMatrix :=function ( E, n )
    local aux, i, j, k, a, suma, M;
    k:=Length(E);
    aux:=0;
    suma:=0;
    a:=1;
    M:=NullMat(n,k);
    for i in [1..n] do
        for j in [1..k] do
            if i in E[j] then
                M[i][j]:=1;
            else
                M[i][j]:=0;
            fi;
        od;
    od;
    Print("Incidence matrix is ", M, "\n");
end;

DualHypergraph := function (H)
    local l, N, Ed, v;
    l := IndexOfEdges(H);
    Ed := [];
    N := RecNames(l);
    for v in N do
        Add(Ed, l.(v));
    od;
    return HHypergraph(Ed);
end;

IsIsomorphicHypergraph := function (H1, H2)
    local D1, D2;
    D1 := BlockDesign(Length(Vertices(H1)), Edges(H1));
    D2 := BlockDesign(Length(Vertices(H2)), Edges(H2));
    return IsIsomorphicBlockDesign(D1, D2);
end;

BipartiteGraphFromHypergraph := function(H)
    local ady, V, TrivialAction;
    V := Concatenation(Vertices(H), Edges(H));
    ady := function(x,y)
        return IsList(y) and (x in y);
    end;
    TrivialAction := function(x,g)
        return x;
    end;
    return UnderlyingGraph(Graph(Group(()),V,TrivialAction,ady));
end;
        
# ConnectedComponents := NewAttribute("ConnectedComponents", IsHHypergraph);
# HasConnectedComponents := Tester(ConnectedComponents);
# SetConnectedComponents := Setter(ConnectedComponents);
        
ConnectedComponents@ := function(H)
    local d, notc, Ve, fin, u, T, CC, CCcur, v;
    if IsConnected(H) then 
        return Vertices(H);
    else
        fin := false;
        Ve := Vertices(H);
        notc := Vertices(H);
        T := [];
        CC := [];
        while not(fin) do
            u := notc[1];
            d := HDistancesFrom(H, u);
            CCcur := [];
            for v in Ve do
                if IsBound(d.(v)) then
                    Add(CCcur, v);
                fi;
            od;
            Add(CC, CCcur);
            T := Union(CC);
            notc := Difference(Ve, T);
            fin := ( notc = []);
        od;
        return CC;
    fi;
end;

RepresentativesConnectedComponents@ := function(H)
    return List(ConnectedComponents@(H), x-> x[1]);
end;

# Girth2 := function(H)
#     local Q, l, T, nq, u, Hn, v, In, x, i, Ed, eds, reps;
#     reps := RepresentativesConnectedComponents@(H);
#     Ed := Edges(H);
#     In := IndexOfEdges(H);
#     for x in reps do
#         Q := [x];
#         T := [];
#         Add(T, x);
#         nq := Length(Q);
#         while nq <> 0 do
#             u := Remove(Q, 1);
#             nq := nq-1;
#             i := 0;
#             i := i+1;
#             eds := In.(u);
#             while i < Length(eds) do
#                 i := i+1;
#                 Hn := RemovedSet@hypergraphs(eds[i],u);
#                 #Difference(HNeighborhood(H, u), T);
#                 if u in Hn then
#                     return l.(u)+1;
#                 else
#                     for v in Hn do
#                         Add(T, v);
#                         l.(v) := l.(u)+1;
#                         Add(Q, v);
#                         nq := nq+1;
#                     od;
#                 fi;
#             od;
#         od;
#     od;
#     return infinity;
# end;

Girth2 := function(H)            
    local Q, l, T, nq, Hn, v, x, y, g, In, Eds, i, edgeused, Ed;
    g := infinity;
    Ed := Edges(H);
    In := IndexOfEdges(H);
    edgeused := rec();
    for v in Vertices(H) do
        for y in Vertices(H) do
            edgeused.(y) := [];
        od;
        T := [];
        Q := [v];
        l := rec();
        l.(v) := 0;
        nq := Length(Q);
        while nq <> 0 do
            x := Remove(Q, 1);
            nq := nq-1;
            Add(T, x);
            Eds := In.(x);
            for i in Difference(Eds, edgeused.(x)) do
                #Print("current edge=",Ed[i],"\n");
                Hn := Difference(Ed[i], [x]);
                for y in Hn do
                    if y in T then
                        g := Minimum(g, l.(x)+l.(y)+1);
                        if g = 2 then 
                            return g;
                        fi;
                    else
                        l.(y) := l.(x)+1;
                        Add(Q, y);
                        nq := nq+1;
                        Add(edgeused.(y), i);
                    fi;
                    #Print("g=",g,", v=",v,", x=",x,", y=",y,", l=",l,"\n");
                od;
                Append(T, Hn);
            od;
        od;
    od;
    return g;
end;
        
H5_1 := HHypergraph([ [ 1, 14, 28 ], [ 1, 20, 24 ], [ 2, 6, 7 ], [ 2, 11, 14 ], [ 2, 12, 18 ], 
  [ 3, 21, 26 ], [ 3, 22, 25 ], [ 4, 5, 7 ], [ 4, 25, 29 ], [ 5, 9, 20 ], 
  [ 6, 13, 16 ], [ 7, 8, 15 ], [ 9, 13, 19 ], [ 9, 18, 34 ], [ 10, 14, 19 ], 
  [ 10, 30, 35 ], [ 12, 22, 24 ], [ 15, 19, 22 ], [ 15, 23, 33 ], 
  [ 16, 17, 33 ], [ 16, 24, 27 ], [ 25, 28, 34 ], [ 27, 34, 35 ], 
  [ 4, 10, 17 ], [ 3, 6, 30 ], [ 17, 18, 21 ], [ 1, 8, 21 ], [ 20, 23, 30 ], 
  [ 11, 23, 29 ], [ 11, 26, 27 ], [ 5, 26, 31 ], [ 28, 31, 33 ], 
  [ 13, 29, 32 ], [ 12, 31, 32 ], [ 8, 32, 35 ] ]
                   );

H5_2 := HHypergraph([ [ 1, 13, 16 ], [ 1, 21, 23 ], [ 2, 4, 14 ], [ 2, 6, 32 ], [ 3, 6, 26 ], [ 3, 15, 27 ], [ 4, 11, 20 ], [ 4, 25, 28 ], [ 5, 8, 25 ], [ 5, 15, 23 ], 
                [ 5, 32, 33 ], [ 6, 18, 19 ], [ 7, 8, 13 ], [ 7, 11, 34 ], [ 8, 22, 35 ], [ 9, 10, 24 ], [ 10, 12, 29 ], [ 10, 25, 26 ], [ 11, 19, 23 ], 
                [ 12, 21, 22 ], [ 12, 32, 34 ], [ 13, 18, 29 ], [ 14, 15, 29 ], [ 14, 31, 35 ], [ 16, 26, 31 ], [ 17, 21, 28 ], [ 18, 28, 30 ], [ 19, 24, 35 ], 
  [ 30, 31, 34 ], [ 1, 2, 9 ], [ 3, 7, 17 ], [ 9, 27, 30 ], [ 20, 22, 27 ], [ 16, 20, 33 ], [ 17, 24, 33 ] ]
                   );

H5_3 := HHypergraph([ [ 1, 2, 9 ], [ 1, 4, 21 ], [ 1, 6, 16 ], [ 2, 5, 25 ], [ 2, 7, 32 ], [ 3, 5, 23 ], [ 3, 12, 15 ], [ 3, 13, 31 ], [ 4, 12, 17 ], [ 5, 28, 29 ], 
  [ 6, 11, 31 ], [ 7, 8, 14 ], [ 7, 12, 27 ], [ 8, 10, 28 ], [ 9, 10, 24 ], [ 9, 15, 30 ], [ 10, 13, 26 ], [ 11, 17, 25 ], [ 13, 18, 21 ], 
  [ 14, 16, 23 ], [ 14, 18, 30 ], [ 15, 19, 22 ], [ 16, 19, 26 ], [ 17, 20, 24 ], [ 18, 20, 29 ], [ 19, 20, 32 ], [ 23, 24, 33 ], [ 25, 26, 34 ], 
  [ 31, 32, 35 ], [ 8, 11, 22 ], [ 6, 27, 29 ], [ 4, 28, 35 ], [ 21, 22, 33 ], [ 27, 33, 34 ], [ 30, 34, 35 ] ]
                   );

H5_4 := HHypergraph([ [ 1, 5, 34 ], [ 1, 9, 22 ], [ 1, 14, 23 ], [ 2, 5, 12 ], [ 2, 17, 29 ], [ 2, 18, 26 ], [ 3, 10, 34 ], [ 3, 15, 18 ], [ 3, 25, 28 ], [ 4, 7, 10 ], 
  [ 4, 11, 14 ], [ 4, 12, 13 ], [ 5, 21, 27 ], [ 6, 13, 15 ], [ 6, 16, 33 ], [ 6, 23, 29 ], [ 7, 8, 26 ], [ 8, 23, 28 ], [ 8, 31, 32 ], [ 9, 26, 33 ], 
  [ 9, 30, 35 ], [ 10, 20, 29 ], [ 11, 17, 25 ], [ 11, 21, 33 ], [ 13, 22, 31 ], [ 14, 18, 19 ], [ 15, 27, 30 ], [ 16, 32, 34 ], [ 19, 20, 35 ], 
  [ 20, 21, 31 ], [ 12, 28, 35 ], [ 17, 30, 32 ], [ 7, 24, 27 ], [ 16, 19, 24 ], [ 22, 24, 25 ] ]
                   );

H5_5 := HHypergraph([ [ 1, 15, 19 ], [ 1, 21, 25 ], [ 2, 6, 9 ], [ 2, 7, 24 ], [ 2, 20, 26 ], [ 3, 5, 23 ], [ 3, 13, 31 ], [ 3, 15, 27 ], [ 4, 6, 13 ], [ 4, 32, 34 ], 
  [ 5, 7, 17 ], [ 5, 10, 21 ], [ 7, 18, 29 ], [ 8, 27, 29 ], [ 9, 15, 22 ], [ 9, 30, 33 ], [ 10, 12, 26 ], [ 10, 22, 32 ], [ 11, 14, 25 ], 
  [ 11, 18, 22 ], [ 12, 16, 19 ], [ 12, 30, 31 ], [ 13, 18, 35 ], [ 14, 17, 33 ], [ 14, 26, 27 ], [ 24, 25, 31 ], [ 24, 28, 32 ], [ 28, 33, 35 ], 
  [ 29, 30, 34 ], [ 4, 17, 19 ], [ 6, 8, 21 ], [ 8, 16, 28 ], [ 11, 16, 23 ], [ 1, 20, 35 ], [ 20, 23, 34 ] ]);


H5_6 := HHypergraph([ [ 1, 5, 7 ], [ 1, 6, 9 ], [ 1, 28, 32 ], [ 2, 4, 5 ], [ 2, 18, 20 ], [ 2, 25, 34 ], [ 3, 5, 23 ], [ 3, 13, 31 ], [ 4, 8, 10 ], [ 4, 11, 22 ], 
  [ 6, 25, 31 ], [ 7, 12, 21 ], [ 7, 17, 29 ], [ 8, 32, 35 ], [ 9, 10, 24 ], [ 9, 15, 30 ], [ 10, 13, 26 ], [ 11, 14, 28 ], [ 11, 17, 31 ], 
  [ 13, 18, 21 ], [ 14, 16, 23 ], [ 14, 18, 30 ], [ 17, 20, 24 ], [ 19, 20, 32 ], [ 21, 22, 33 ], [ 23, 24, 33 ], [ 25, 33, 35 ], [ 26, 28, 34 ], 
  [ 29, 30, 35 ], [ 8, 12, 16 ], [ 12, 15, 34 ], [ 3, 15, 19 ], [ 6, 16, 27 ], [ 19, 22, 27 ], [ 26, 27, 29 ] ]
                   );

Q1 := HHypergraph([ [ 1, 4, 6 ], [ 1, 8, 27 ], [ 1, 12, 18 ], [ 2, 7, 18 ], [ 3, 6, 13 ], [ 3, 7, 15 ], [ 3, 10, 27 ], [ 3, 12, 20 ], [ 4, 5, 20 ], 
      [ 4, 7, 19 ], [ 4, 10, 25 ], [ 4, 16, 23 ], [ 5, 9, 15 ], [ 5, 13, 18 ], [ 5, 21, 27 ], [ 7, 8, 14 ], [ 7, 17, 21 ], [ 8, 9, 23 ], [ 8, 13, 25 ], 
      [ 8, 20, 26 ], [ 9, 10, 17 ], [ 9, 12, 19 ], [ 12, 14, 16 ], [ 12, 21, 25 ], [ 15, 16, 26 ], [ 15, 24, 25 ], [ 17, 20, 24 ], [ 18, 23, 24 ], 
      [ 13, 16, 17 ], [ 10, 18, 26 ], [ 2, 16, 27 ], [ 19, 24, 27 ], [ 2, 6, 9 ], [ 6, 14, 24 ], [ 6, 21, 26 ], [ 1, 11, 15 ], [ 2, 11, 20 ], 
      [ 10, 11, 14 ], [ 11, 13, 19 ], [ 11, 21, 23 ], [ 1, 17, 22 ], [ 5, 14, 22 ], [ 3, 22, 23 ], [ 2, 22, 25 ], [ 19, 22, 26 ] ]);

Q2 := HHypergraph([ [ 1, 6, 14 ], [ 1, 8, 13 ], [ 1, 10, 18 ], [ 1, 11, 23 ], [ 2, 5, 9 ], [ 2, 6, 22 ], [ 2, 8, 20 ], [ 2, 10, 25 ], [ 2, 11, 27 ], 
      [ 4, 6, 26 ], [ 4, 10, 17 ], [ 4, 11, 21 ], [ 4, 12, 20 ], [ 5, 7, 14 ], [ 5, 16, 23 ], [ 5, 18, 24 ], [ 6, 19, 24 ], [ 7, 8, 26 ], [ 7, 10, 19 ], 
      [ 7, 12, 22 ], [ 8, 16, 21 ], [ 8, 17, 24 ], [ 10, 15, 16 ], [ 12, 16, 27 ], [ 12, 24, 25 ], [ 13, 15, 22 ], [ 13, 19, 27 ], [ 14, 15, 20 ], 
      [ 14, 21, 25 ], [ 17, 22, 23 ], [ 18, 26, 27 ], [ 23, 25, 26 ], [ 4, 5, 13 ], [ 14, 17, 27 ], [ 11, 15, 24 ], [ 18, 21, 22 ], [ 19, 20, 23 ], 
      [ 1, 9, 12 ], [ 9, 19, 21 ], [ 9, 15, 26 ], [ 3, 7, 11 ], [ 3, 6, 16 ], [ 3, 9, 17 ], [ 3, 18, 20 ], [ 3, 13, 25 ] ] 
);
 

TableOfDistances := function(H)
    local i,j, Ve, n, M, dfrom;
    Ve := Vertices(H);
    n := Length(Ve);
    M := [];
    for i in [1..n] do
        M[i] := [];
        for j in [1..n] do
            M[i][j] := infinity;
        od;
        M[i][i] := 0;
    od;
    i := 0;
    while i < n do
        i := i+1;
        dfrom := HDistancesFrom(H, Ve[i]);
        for j in [i+1..n] do
            if IsBound(dfrom.(Ve[j])) then
                M[i][j] := dfrom.(Ve[j]);
                M[j][i] := dfrom.(Ve[j]);
            fi;
        od;
    od;
    return M;
end;
    
