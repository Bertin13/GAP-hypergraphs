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
        
