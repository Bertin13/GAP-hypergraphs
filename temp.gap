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

#Cycles :=function( V, E );
#    local i, j, k, aux, v, e, VP, EE, VV;
#    k:=Lenght(E);
#    aux :=function ( EP, VP )
#    for i in [1..k] do
#        for j in [1,2,3] do
#            if E[i][j] in E[i] then
#                VP:=Add(VP,E[i]);  #Revisar si es Add o Append
#                EP:=Add(EP,E[i]);
#            fi;
#        od;
#    od;
#    end;
#end;

MatrixBlock :=function( M, r)
    local i, j, k, v, e, MM;
    MM:=NullMat(r,r);
    for j in [1..Length(M)-r+1] do
        for i in [1..r] do 
            for k in [1..r] do
                MM[i][k]:=M[j+i-1][k];
            od;
        od;
        Print("Matriz de bloques ", MM, " \n");
    od;    
end;

Hypertree :=function( V, E)
    local i, j, k, v, e, M, T, C, VV, IP, EP, INP, aux, auxI, auxE, Vaux, cycle, a, aa;
    k:=Length(E);
    v:=Length(V);
    e:=[];
    IP:=[1..k];
    aux:=1;
    auxE:=[];
    cycle:=[];
    for i in [1..k] do
        a:=1;
        e[i]:=Set(E[i]);
        INP:=[i];
        VV:=e[i];
        Vaux:=e[i];
        cycle:=[i];
        while a <> 0 do
        for j in Difference(IP,INP) do
            if Intersection(E[j],VV) <> [] then
                aux:=aux+1;
                Add(auxE,E[j]);
                Add(cycle,j);                
                Vaux:=ShallowCopy(Union(Vaux,E[j]));
            fi;
        VV:=ShallowCopy(Union(VV,Vaux));
        if 2*aux=Length(VV)-1 then
            a:=1;
        else                
            Print("There is a cycle in ", cycle, "\n");
            a:=0;        
            return;
        fi; 
        od;
        if Length(VV)=v then
            a:=0;
        fi;
        od;
        aux:=1; VV:=[];
    od;
    return;
end;

Hypertree2 :=function( V, E)
    local i, j, k, v, VV, IP, INP, aux, Vaux, cycle, a, suma;
    k :=Length(E);
    v :=Length(V);
    IP :=[1..k];
    aux :=1;
    cycle :=[];
    a :=1;
    suma := Length(Union(E));
    if suma=2*k+1 then
        Print("Tree");
        return;
    else
        while a <> 0 do
            for i in [1..k] do
            INP:=[i];
            VV:=E[i];
            Vaux:=E[i];
            cycle:=[i];
                for j in Difference(IP,INP) do
                    if Intersection(E[j],VV) <> [] then
                        aux:=aux+1;
                        Add(cycle,j);
                        Vaux:=ShallowCopy(Union(Vaux,E[j]));
                    fi;
                    VV:=ShallowCopy(Union(VV,Vaux));
                od;
                if 2*aux <> Length(VV)-1 then
                    Print("There is a cycle in ", cycle, "\n");
                    a := 0;
                    return;
                fi;
            od;
        od;
    fi;
    return cycle;
end;

HGirth2 :=function( V, E)
    local i, j, k, v, VV, IP, INP, aux, Vaux, cycle, a, suma, CC, CCC, EE, XX;
    k :=Length(E);
    v :=Length(V);
    aux :=1;
    cycle :=[];
    XX :=[];
    a :=1;
    CC :=[[]];
    suma := Length(Union(E));
    if suma=2*k+1 then
        Print("Tree");
        return;
    else
        XX :=E;
        while a <> 0 do
             IP :=[1..Length(XX)];
            for i in [1..Length(XX)] do
                EE:=[];
            INP:=[i];
            VV:=XX[i];
            Vaux:=XX[i];
            cycle:=[i];
                 for j in Difference(IP,INP) do
                    if Intersection(XX[j],VV) <> [] then
                        aux:=aux+1;
                        Add(cycle,j);
                        Vaux:=ShallowCopy(Union(Vaux,XX[j]));
                    fi;
                    VV:=ShallowCopy(Union(VV,Vaux));
                 if 2*aux <> Length(VV)-1 then
                     CC[i] := cycle;
                     aux := 1;
                     Vaux := [];
                     VV:=[];
                     break;
                 fi;
                 od;
        od;
            CCC := Set(List(CC, i -> Set(i)));
            for i in CCC do
                if Length(i)=Minimum(List(CCC, j -> Length(j))) then
                    Add(EE,i);
                fi;
            od;
            if XX = EE then 
                 a := 0;
            else
                XX :=ShallowCopy(EE);
            fi;
        od;
    fi;
    return Length(XX[1]);
end;

HConnected3Random :=function( n, m)
    local i, j, k, CombE, E, aux, r, InPos, a, UE;
    E:=[];
    UE:=[];
    CombE:=Combinations([1..n],3);
    k:=Length(CombE);
    r:=Random([1..k]);
    InPos:=[1..k];    
    E[1]:=CombE[r];
    UE:=ShallowCopy(Union(UE,E[1]));
    Remove(InPos,r);
    aux:=0;
    a:=1;
    if m > k then
        Print("Not exist H \n");
    else 
        while aux <> 1 do
            r:=Random(InPos);
            if Intersection(CombE[r],UE) <> [] then
                a:=a+1;
                E[a]:=CombE[r];
                Remove(InPos,r);
            fi;
            if a = m then
                aux:=1;
                #                Print("Hypergraph = ", E, "\n");
                return E;

            fi;
        od;
    fi;
    return;
end;

HRandomCycle :=function( n, m)
    local i, j, k, CombE, E, aux, r, InPos, a, UE, auxE, cont;
    E:=[];
    UE:=[];
#    auxE:=[];
    CombE:=Combinations([1..n-1],3);
    k:=Length(CombE);
    r:=Random([1..k]);
    InPos:=[1..k];    
    E[1]:=CombE[r];
    UE:=ShallowCopy(Union(UE,E[1]));
    Remove(InPos,r);
    aux:=0;
    a:=1;
    cont:=0;
    if m > k then
        Print("Not exist H \n");
    else 
        while aux = 0 do
            cont:=cont+1;
            r:=Random(InPos);
            Print("Va", r, InPos, CombE[r]," \n");            
            if Length(Intersection(CombE[r],UE)) = 1  then
                Print("Conjuntos ", CombE[r],UE, "\n");
                a:=a+1;
                E[a]:=CombE[r];
                UE:=ShallowCopy(Union(UE,E[a]));
                Print("UE ", UE, "\n");
                Remove(InPos,r);
            fi;
            if a = m-1 or cont =5000  then
                aux:=1;
                if E[1][3] = E[a][2] then
                    E[a]:=[E[1][3],n,n+1];
                else
                    E[a+1]:=[E[1][3],E[a-1][2],n];
                    #                Print("Hypergraph = ", E, "\n");
                fi;
            fi;
        od;
    fi;
    return E;
end;

HGirth :=function( E)
    local m, i, j, k, CombE, NCombE, U, UU;
    m:=Length(E);
    U:=[];
    for i in [1..m] do
        U:=ShallowCopy(Union(U,E[i]));
    od;
    if 2*m = Length(U)-1 then
        Print("H is a hypertree \n");
    else
        Print("H is not a hypertree \n");
        for j in [2..m] do
            CombE :=Combinations( E, j);
            NCombE := NrCombinations( E, j);
            for k in [1..NCombE] do
                UU:=CombE[k][1];
                for i in [2..j] do
                    UU:=ShallowCopy(Union(UU,CombE[k][i]));
                od;
                    if Length(UU) = 2*i then
                        Print("H has girth ", i," \n");
                        Print("Edges ", CombE[k], "\n");
                        return;
                    fi;                
            od;
        od;
    fi;
end;
# HH:=[[1,2,3],[3,4,5],[5,6,7],[7,8,9],[9,10,11],[11,12,13],[13,14,15],[15,16,17],[17,18,19],[19,20,21],[21,22,23],[23,24,25],[1,25,#26],[1,27,28],[3,29,30]];

# HH:=[[1,2,3],[3,4,5],[5,6,7],[7,8,9],[9,10,11],[11,12,13],[13,14,15],[15,16,17],[17,18,19],[19,20,21],[21,22,23],[23,24,25],[1,25,#26],[1,27,28],[3,29,30],[11,31,32],[12,33,34],[34,35,36],[23,37,38]]; time: 9 645 ms

# HH:=[[1,2,3],[3,4,5],[5,6,7],[7,8,9],[9,10,11],[11,12,13],[13,14,15],[15,16,17],[17,18,19],[19,20,21],[21,22,23],[23,24,25],[1,25,#26],[1,27,28],[3,29,30],[11,31,32],[12,33,34],[34,35,36],[23,37,38],[19,39,40],[26,41,42],[41,43,44]]; time: 72 952 ms; n=44, m=22

# HH:=[[1,2,3],[3,4,5],[5,6,7],[7,8,9],[9,10,11],[11,12,13],[13,14,15],[15,16,17],[17,18,19],[19,20,21],[21,22,23],[23,24,25],[1,25,#26],[1,27,28],[3,29,30],[11,31,32],[12,33,34],[34,35,36],[23,37,38],[19,39,40],[26,41,42],[41,43,44],[17,45,46]]; time: 136 617 ms

GenerateRandomHypergraph :=function( n )
    local r, u, T, edges, e, j, k;
    edges := [];
    while edges=[] do 
        for k in [1..n] do
            u := NrCombinations([1..n],k);        
            r := Random(0,2^u-1);                 
            T := KSSubsetLexUnrank(u, r);   
#            Print("u,r,T ", u, " r ", r, T, "\n");
            for j in T do
                e := KSkSubsetLexUnrank(j-1, k, n);
                Add(edges,e);
            od;
        od;
    od;
    return edges;
end;

KSSubsetLexUnrank :=function( n,r )
    local T, i;
    T := [];
    for i in [n,n-1..1] do
        if r mod 2 = 1 then
            Add(T,i);
        fi;
        r := Int(r/2);
    od;
    return Reversed(T);
end;

KSkSubsetLexRank :=function( T, k, n )
    local U, r, i, j;
    U := [];
    r := 0;
    U[1] := 0;
    for i in [2..Length(T)+1] do
        U[i] := T[i-1];
    od;
    for i in [1..k] do
        if U[i] + 1 <= U[i+1] - 1 then
            for j in [U[i]+1..U[i+1]-1] do
                r := r + NrCombinations([1..n-j],k-i);
            od;
        fi;
    od;
    return r;
end;

KSkSubsetLexUnrank :=function( r, k, n )
    local x, T, i, comb;
    T := [];
    x := 1;
    for i in [1..k] do
        while n-x>=k-i and NrCombinations([1..n-x], k-i) <= r do
            r := r - NrCombinations([1..n-x], k-i);
            x := x+1;
        od;
        T[i] := x;
        x := x+1;
    od;
    return T;
end;

HLinear :=function ( E )
    local aux, i, j, k, a, RR;
    k:=Length(E);
    aux:=0;
    a := 0;
    while aux = 0 do
        for i in [1..k-1] do
            for j in [i+1..k] do
                if Length(Intersection(E[i],E[j])) <= 1 then
                    aux := 0;
                    a := a+1;
                    RR := true;
                else
                    aux := 1;
                    RR := false;
                    return RR;
                fi;
            od;
        od;
        if a = NrCombinations([1..k],2) then
            aux := 1;
        fi;
    od;
    return RR;
end;

HDual :=function ( V, E )
    local aux, i, j, k, a, VV, EE;
    EE:=[[]];
    k :=Length(E);
    aux:=0;
    a := 0;
    VV := [1..k];
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

HPartial :=function ( V, E, J )
    local i, j, k, a, VV, EE;
    k := Length(J);
    EE := [];
    if IsSubset([1..Length(E)],J) and J <> [] then 
        for i in J do
            Add(EE,E[i]);
        od;   
    else
        Print("Fail \n");
        return;
    fi;
    return EE;
end;

HSubHypergraph :=function ( V, E, A )
    local i, j, k, a, VV, XX;
    XX := [];
    for i in [1..Length(E)] do
        if Intersection(E[i],A) <> [] then 
            Add(XX,Intersection(E[i],A));
        fi;
    od;
    if A = [] or XX = [] then 
        Print("Fail \n");
        return;
    fi;
    return XX;
end;

HRank :=function ( E )
    local i, j, k, a, LL;
    LL := Maximum(List(E, i -> Length(i)));
    return LL;
end;

HAntiRank :=function ( E )
    local i, j, k, a, LL;
    LL := Minimum(List(E, i -> Length(i)));
    return LL;
end;

HSeqDegree :=function ( V, E )
    local i, j, k, a, LL, DD;
    LL:=[];
    for j in V do
        LL[j] := List(E, i -> Length(Intersection(i,[j])));
        Print("j , LL[j]", j, LL[j],"\n");
    od;
    DD:=List(LL, i -> Sum(i));
    Print("D", DD);
    # Falta ordenar conservando repeticiones.
    return Reversed(Set(DD));
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
    
