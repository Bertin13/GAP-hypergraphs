#V  HFano
##
InstallValue( 
    HFano, 
    HHypergraph([1..7],
                [ [ 1, 2, 6 ], [ 1, 3, 7 ], [ 1, 4, 5 ], [ 2, 3, 4 ], [ 2, 5, 7 ], 
                  [ 3, 5, 6 ], [ 4, 6, 7 ] ]) 
);

#V  HQuad
##
InstallValue( 
        HQuad, 
        HHypergraph([1..15],
                    [ [ 1, 10, 15 ], [ 1, 11, 14 ], [ 1, 12, 13 ], [ 2, 7, 15 ], 
                      [ 2, 8, 14 ], [ 2, 9, 13 ], [ 3, 6, 15 ], [ 3, 8, 12 ], [ 3, 9, 11 ],
                      [ 4, 6, 14 ], [ 4, 7, 12 ], [ 4, 9, 10 ], [ 5, 6, 13 ], [ 5, 7, 11 ], 
                      [ 5, 8, 10 ] ])
);

