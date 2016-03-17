
IsSimpleHypergraph := function ( E )
    local e, i, j, k, aux;
    e:=[];
    k:=Length(E);
    aux:=0;
    for i in [1..k] do
        e[i]:=Set(E[i]);
    od;
    for i in [1..k-1] do
        for j in [i+1..k] do
            if Intersection(e[i],e[j])=e[i] or Intersection(e[i],e[j])=e[j] then
                Print("Is not a simple hypergraph \n");
                return;
            fi;
        od;
        aux:=aux+1;
    od;
    if aux=k-1 then
        Print("It's a simple hypergraph \n");
    fi;
end;

IsUniformHypergraph :=function ( E, r )
    local e, i, j, k, aux;
    e:=[];
    k:=Length(E);
    aux:=0;
    for i in [1..k] do
        e[i]:=Set(E[i]);
        if Length(e[i]) <> r then
            Print("Is not a ", r,"-uniform hypergraph \n");
            return;
        else
            aux:=aux+1;
        fi;
    od;
    if aux=k then 
        Print("It's a ", r,"-uniform hypergraph \n");
    fi;
end;

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

    
               
               
               
               
               


