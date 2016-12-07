#F  HypergraphWithGirth( v,k,g,u )
##
InstallGlobalFunction( HypergraphWithGirth, function( v,k,g,u )
    local B, LiveVertices, IndexLiveVertices, Switch, stop, removes, maxb, maxB;
    Switch := function()
        local H, Ind, combs, select, extra, j, deg, DegreeSum, IsAdmissibleBlock,
              RemoveRandom, RemoveUsingDistances;
        deg := function(x)
            return Length(Ind.(x));
        end;
        DegreeSum := function (B)
            return Sum(List(B, deg)) + removes*(1/Sum(B)) + removes*Sum(List(B, deg));
            #return Sum(List(B, deg)) + removes*(1/Sum(B));
        end;
        IsAdmissibleBlock := function(P)
            local pairs, p, i, isit;
            i := 0;
            isit := true;
            while isit and i < Length(P) do
                i := i+1;
                isit := deg(P[i]) < k;
            od;
            pairs := Combinations(P, 2);
            i := 0;
            while isit and i < Length(pairs) do
                i := i+1;
                p := pairs[i];
                isit := (HDistance(H, p[1], p[2]) >= g-1);
            od;
            return isit;
        end;
        RemoveRandom := function()
            local rem;
            rem := Random(B);
            B := Difference(B, [rem]);
            Print("Removing ", rem, "\n");
            for j in rem do
                if IndexLiveVertices[j] = 0 then
                    Add(LiveVertices, j);
                fi;
                IndexLiveVertices[j] := IndexLiveVertices[j] + 1;
            od;
        end;
        RemoveUsingDistances := function()
            local DistancesSum, DistancesSumRemoved, M, blocks, rem;
            DistancesSum := function(P)
                local pair, pairs, dsum;
                dsum := 0;
                pairs := Combinations(P, 2);
                for pair in pairs do
                    dsum := dsum + M.(pair[1]).(pair[2]);
                od;
                return dsum;
            end;
            DistancesSumRemoved := function(P)
                local Hrem;
                Hrem := HRemovedEdge(H, P);
                M := HAllDistances(Hrem);
                return DistancesSum(P);
            end;
            blocks := ShallowCopy(B);
            SortBy(blocks, DistancesSumRemoved);
            Print("Distances = ", List(blocks, DistancesSumRemoved), "\n");
            rem := blocks[Length(blocks)];
            blocks := Filtered(blocks, x -> DistancesSumRemoved(x) = DistancesSumRemoved(rem) );
            rem := Random(blocks);
            B := Difference(B, [rem]);
            Print("Removing ", rem, "\n");
            for j in rem do
                if IndexLiveVertices[j] = 0 then
                    Add(LiveVertices, j);
                fi;
                IndexLiveVertices[j] := IndexLiveVertices[j] + 1;
            od;
        end;
        H := HHypergraph([1..v], B);
        Ind := IndexOfEdges(H);
        combs := Combinations(LiveVertices, u);
        combs := Filtered(combs, IsAdmissibleBlock);
        if combs <> [] then
            if Length(combs) = 1 then
                Print("Unique choice!\n");
            else
                Print(Length(combs), " choices.\n");
            fi;
            SortBy(combs, DegreeSum);
            extra := combs[Length(combs)];
            Add(B, extra);
            Print("Adding: ", extra, "\n");
            for j in extra do
                IndexLiveVertices[j] := IndexLiveVertices[j] - 1;
                if IndexLiveVertices[j] = 0 then
                    LiveVertices := Difference(LiveVertices, [j]);
                fi;
            od;
        else
            removes := removes + 1;
            RemoveRandom();
            RemoveUsingDistances();
            RemoveUsingDistances();
            RemoveUsingDistances();
            RemoveUsingDistances();
            RemoveUsingDistances();
        fi;
        return;
    end;
    B := [];
    stop := 0;
    removes := 0;
    LiveVertices := [1..v];
    IndexLiveVertices := List([1..v], x -> k);
    maxb := 0;
    maxB := [];
    while Length(B) < v*k/u and stop < v+10000 do
        stop := stop+1;
        Print("Attempt ",stop," of ",v+10000, ".");
        Print(" We have ", Length(B), " blocks, of a total of ",v*k/u,".\n");
        Switch();
        if Length(B) > maxb then
            maxb := Length(B);
            maxB := ShallowCopy(B);
        fi;
        if k*Length(Union(B)) = u*Length(B) and Length(B)>0 then
            Print("Done!\n");
            return B;
        fi;
        Print("LiveVertices: ", LiveVertices, "\n");
        Print("IndexLiveVertices: ", IndexLiveVertices, "\n");
    od;
    return [B, maxb, maxB];
end);
