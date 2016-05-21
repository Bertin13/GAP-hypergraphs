
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
    T:=[];
    C:=[];
    e:=[];
    IP:=[1..k];
    INP:=[];
    VV:=[[]];
    aux:=1;
    auxI:=[];
    auxE:=[];
    cycle:=[];
    aa:=0;    
    for i in [1..k] do
        a:=1;
#        Print("Valor de i ", i, "\n");
        e[i]:=Set(E[i]);
        C:=Union(C,E[i]);
        C[1]:=e[i];
        INP:=[i];
        VV:=e[i];
        Vaux:=e[i];
        cycle:=[i];
        while a <> 0 do
        for j in Difference(IP,INP) do
            if Intersection(E[j],VV) <> [] then
#                VV:=Union(VV,E[j]);
                Add(auxI,j);                
                aux:=aux+1;
                Add(auxE,E[j]);
                Add(cycle,j);                
                Vaux:=ShallowCopy(Union(Vaux,E[j]));
                Print("E ",E[j],auxI, Difference(IP,INP), auxE, " Vaux ", Vaux,"\n");
            fi;
#        od;
        VV:=ShallowCopy(Union(VV,Vaux));
        if 2*aux=Length(VV)-1 then
            Print("It's a tree \n", aux, VV, "\n");        
            a:=1;
        else                
            Print("Is not a tree \n", aux, VV, "\n");
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
    
#    Print("C ",C, "\n");
#    if 2*k=v-1 then 
#        Print("It's a tree \n");
#    else
#        Print("Is not a tree \n");
#    fi;
    #    suma:=Sum([1..k], i -> )
    return;
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
    

    
               
               
               
               
               


