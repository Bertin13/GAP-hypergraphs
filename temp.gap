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
               
               
               
               


