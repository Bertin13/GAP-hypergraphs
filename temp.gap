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

HGirth3 :=function( V, E)
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

#([1..15],
#                    [ [ 1, 10, 15 ], [ 1, 11, 14 ], [ 1, 12, 13 ], [ 2, 7, 15 ], 
#                      [ 2, 8, 14 ], [ 2, 9, 13 ], [ 3, 6, 15 ], [ 3, 8, 12 ], [ 3, 9, 11 ],
#                      [ 4, 6, 14 ], [ 4, 7, 12 ], [ 4, 9, 10 ], [ 5, 6, 13 ], [ 5, 7, 11 ], 
#                      [ 5, 8, 10 ] ])

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
#            Print("Va", r, InPos, CombE[r]," \n");            
            if Length(Intersection(CombE[r],UE)) = 1  then
#                Print("Conjuntos ", CombE[r],UE, "\n");
                a:=a+1;
                E[a]:=CombE[r];
                UE:=ShallowCopy(Union(UE,E[a]));
#                Print("UE ", UE, "\n");
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

HGirth4 :=function( E)    
    local m, i, j, k, CombE, NCombE, U, UU;
    m:=Length(E);
    U:=[];
    for i in [1..m] do
        U:=ShallowCopy(Union(U,E[i]));
    od;
    if 2*m = Length(U)-1 then
        Print("H is a hypertree \n");
    else
#        Print("H is not a hypertree \n");
        for j in [2..m] do
            CombE :=Combinations( E, j);
            NCombE := NrCombinations( E, j);
            for k in [1..NCombE] do
                UU:=CombE[k][1];
                for i in [2..j] do
                    UU:=ShallowCopy(Union(UU,CombE[k][i]));
                od;
                    if Length(UU) = 2*i then
#                        Print("H has girth ", i," \n");
#                        Print("Edges ", CombE[k], "\n");
                        return i;
                    fi;                
            od;
        od;
    fi;
end;

HHH:= [ [ 1, 2, 21 ], [ 1, 3, 29 ], [ 1, 4, 14 ], [ 1, 5, 23 ], [ 1, 6, 31 ], 
  [ 1, 7, 20 ], [ 1, 8, 15 ], [ 1, 9, 17 ], [ 1, 10, 30 ], [ 1, 11, 18 ], 
  [ 1, 12, 19 ], [ 1, 13, 16 ], [ 1, 22, 26 ], [ 1, 24, 28 ], [ 1, 25, 27 ], 
  [ 2, 3, 17 ], [ 2, 4, 31 ], [ 2, 5, 16 ], [ 2, 6, 28 ], [ 2, 7, 23 ], 
  [ 2, 8, 10 ], [ 2, 9, 27 ], [ 2, 11, 14 ], [ 2, 12, 25 ], [ 2, 13, 24 ], 
  [ 2, 15, 29 ], [ 2, 18, 26 ], [ 2, 19, 22 ], [ 2, 20, 30 ], [ 3, 4, 26 ], 
  [ 3, 5, 24 ], [ 3, 6, 30 ], [ 3, 7, 21 ], [ 3, 8, 18 ], [ 3, 9, 20 ], 
  [ 3, 10, 12 ], [ 3, 11, 19 ], [ 3, 13, 15 ], [ 3, 14, 28 ], [ 3, 16, 31 ], 
  [ 3, 22, 27 ], [ 3, 23, 25 ], [ 4, 5, 8 ], [ 4, 6, 19 ], [ 4, 7, 29 ], 
  [ 4, 9, 15 ], [ 4, 10, 16 ], [ 4, 11, 24 ], [ 4, 12, 30 ], [ 4, 13, 20 ], 
  [ 4, 17, 22 ], [ 4, 18, 27 ], [ 4, 21, 25 ], [ 4, 23, 28 ], [ 5, 6, 27 ], 
  [ 5, 7, 30 ], [ 5, 9, 19 ], [ 5, 10, 28 ], [ 5, 11, 25 ], [ 5, 12, 17 ], 
  [ 5, 13, 18 ], [ 5, 14, 15 ], [ 5, 20, 29 ], [ 5, 21, 26 ], [ 5, 22, 31 ], 
  [ 6, 7, 22 ], [ 6, 8, 17 ], [ 6, 9, 14 ], [ 6, 10, 25 ], [ 6, 11, 21 ], 
  [ 6, 12, 24 ], [ 6, 13, 23 ], [ 6, 15, 16 ], [ 6, 18, 29 ], [ 6, 20, 26 ], 
  [ 7, 8, 27 ], [ 7, 9, 25 ], [ 7, 10, 18 ], [ 7, 11, 17 ], [ 7, 12, 15 ], 
  [ 7, 13, 28 ], [ 7, 14, 19 ], [ 7, 16, 26 ], [ 7, 24, 31 ], [ 8, 9, 31 ], 
  [ 8, 11, 12 ], [ 8, 13, 29 ], [ 8, 14, 22 ], [ 8, 16, 30 ], [ 8, 19, 21 ], 
  [ 8, 20, 23 ], [ 8, 24, 25 ], [ 8, 26, 28 ], [ 9, 10, 23 ], [ 9, 11, 22 ], 
  [ 9, 12, 29 ], [ 9, 13, 26 ], [ 9, 16, 24 ], [ 9, 18, 21 ], [ 9, 28, 30 ], 
  [ 10, 11, 20 ], [ 10, 13, 17 ], [ 10, 14, 27 ], [ 10, 15, 21 ], 
  [ 10, 19, 26 ], [ 10, 22, 24 ], [ 10, 29, 31 ], [ 11, 13, 30 ], 
  [ 11, 15, 28 ], [ 11, 16, 27 ], [ 11, 23, 31 ], [ 11, 26, 29 ], 
  [ 12, 13, 31 ], [ 12, 14, 18 ], [ 12, 16, 21 ], [ 12, 20, 22 ], 
  [ 12, 23, 26 ], [ 12, 27, 28 ], [ 13, 14, 21 ], [ 13, 19, 27 ], 
  [ 13, 22, 25 ], [ 14, 16, 25 ], [ 14, 17, 24 ], [ 14, 20, 31 ], 
  [ 14, 23, 29 ], [ 14, 26, 30 ], [ 15, 17, 23 ], [ 15, 18, 25 ], 
  [ 15, 19, 31 ], [ 15, 20, 27 ], [ 15, 22, 30 ], [ 15, 24, 26 ], 
  [ 16, 17, 20 ], [ 16, 18, 23 ], [ 16, 19, 28 ], [ 16, 22, 29 ], 
  [ 17, 18, 31 ], [ 17, 19, 30 ], [ 17, 21, 27 ], [ 17, 25, 26 ], 
  [ 17, 28, 29 ], [ 18, 19, 20 ], [ 18, 22, 28 ], [ 18, 24, 30 ], 
  [ 19, 23, 24 ], [ 19, 25, 29 ], [ 20, 21, 24 ], [ 20, 25, 28 ], 
  [ 21, 22, 23 ], [ 21, 28, 31 ], [ 21, 29, 30 ], [ 23, 27, 30 ], 
  [ 24, 27, 29 ], [ 25, 30, 31 ], [ 26, 27, 31 ] ];

# HH:=[[1,2,3],[3,4,5],[5,6,7],[7,8,9],[9,10,11],[11,12,13],[13,14,15],[15,16,17],[17,18,19],[19,20,21],[21,22,23],[23,24,25],[1,25,#26],[1,27,28],[3,29,30]];

# HH:=[[1,2,3],[3,4,5],[5,6,7],[7,8,9],[9,10,11],[11,12,13],[13,14,15],[15,16,17],[17,18,19],[19,20,21],[21,22,23],[23,24,25],[1,25,#26],[1,27,28],[3,29,30],[11,31,32],[12,33,34],[34,35,36],[23,37,38]]; time: 9 645 ms

# HH:=[[1,2,3],[3,4,5],[5,6,7],[7,8,9],[9,10,11],[11,12,13],[13,14,15],[15,16,17],[17,18,19],[19,20,21],[21,22,23],[23,24,25],[1,25,#26],[1,27,28],[3,29,30],[11,31,32],[12,33,34],[34,35,36],[23,37,38],[19,39,40],[26,41,42],[41,43,44]]; time: 72 952 ms; n=44, m=22

# HH:=[[1,2,3],[3,4,5],[5,6,7],[7,8,9],[9,10,11],[11,12,13],[13,14,15],[15,16,17],[17,18,19],[19,20,21],[21,22,23],[23,24,25],[1,25,#26],[1,27,28],[3,29,30],[11,31,32],[12,33,34],[34,35,36],[23,37,38],[19,39,40],[26,41,42],[41,43,44],[17,45,46]]; time: 136 617 ms

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

HStainerSystem :=function ( n )
    local k, SS;
    SS := [];
    for k in [3..n] do
        if IsInt((Binomial(k,2))/3) and IsInt((k-1)/2) then
            Add(SS,k);
#            Print("cosas", (Binomial(k,2))/3, "\n");
        fi;
    od;
    return SS;
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
        
HG5 := function( n )
    local i, j, k, a, aux, intentos, V, E, Index, VV;
    V := [1..31];
    VV := [1..31];
    E := [];
    Index := [];
    E[1] := [1..5];
    Index[1] := [2,1,1,1,1];
    i := 1;
    intentos := 1;
        while i < 31 or intentos <= n do
            for j in [1..5] do
                if Index[i]=2 then
                fi;
            od;
        od;
end;

H480 := function( n )
    local i, j, k, a, aux, intentos, V, E, Index, VV, m;
    V := [1..192];
    VV := V;
    E := [];
    while m <= 96 do
        for j in [1..5] do
            if Index[i]=2 then
            fi;
        od;
    od;
end;
             
                    

                     
        
        
