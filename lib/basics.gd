DeclareOperation( "HHypergraph", [ IsList, IsList ] );

DeclareOperation( "IsUniform", [ IsHHypergraph ] );

#F  HCompleteHypergraph( n, r ) 
##
##  <#GAPDoc Label="HCompleteHypergraph">
##  <ManSection>
##  <Func Name="HCompleteHypergraph" Arg="n, r"/>
##
##  <Description>
##
##  Returns the hypergraph that has <M>\{1\ldots <A>n</A>\}</M> as set of
##  vertices, and all <A>r</A>-subsets of <M>\{1\ldots <A>n</A>\}</M> as
##  hyperedges.
##
##  </Description>
##
##  </ManSection>
##  <#/GAPDoc>
DeclareGlobalFunction( "HCompleteHypergraph" );

#F  HRandomUniformHypergraph( n, r, p ) 
##
##  <#GAPDoc Label="HRandomUniformHypergraph">
##  <ManSection>
##  <Func Name="HRandomUniformHypergraph" Arg="n, r, p"/>
##
##  <Description>
##
##  Returns a hypergraph with set of vertices given by
##  <M>\{1\ldots<A>n</A>\}</M>, and where each <A>r</A>-subset of
##  <M>\{1\ldots<A>n</A>\}</M> appears as a hyperedge with probability
##  <A>p</A>.
##
##  </Description>
##
##  </ManSection>
##  <#/GAPDoc>
DeclareGlobalFunction( "HRandomUniformHypergraph" );

#F  HNeighborhood( H, x ) 
##
##  <#GAPDoc Label="HNeighborhood">
##  <ManSection>
##  <Func Name="HNeighborhood" Arg="H, x"/>
##
##  <Description>
##
##  Given a hypergraph <A>H</A> and one of its vertices <A>x</A>,
##  returns the set of vertices that share an edge with <A>x</A>.
##
##  </Description>
##
##  </ManSection>
##  <#/GAPDoc>
DeclareGlobalFunction( "HNeighborhood" );

#F  HDistancesFrom( H, x ) 
##
##  <#GAPDoc Label="HDistancesFrom">
##  <ManSection>
##  <Func Name="HDistancesFrom" Arg="H, x"/>
##
##  <Description>
##
##   Given a hypergraph <A>H</A> and one of its vertices <A>x</A>, it
##   returns a record <A>L</A>, where <A>L.u</A> is equal to the
##   distance in <A>H</A> from the vertex <A>x</A> to the vertex
##   <A>u</A>.
##
##  </Description>
##
##  </ManSection>
##  <#/GAPDoc>
DeclareGlobalFunction( "HDistancesFrom" );

#F  HDistance( H, x, y ) 
##
##  <#GAPDoc Label="HDistance">
##  <ManSection>
##  <Func Name="HDistance" Arg="H, x, y"/>
##
##  <Description>
##
##   Given a hypergraph <A>H</A> and two of its vertices <A>x</A>,
##   <A>y</A>, this function returns the distance in <A>H</A> from
##   <A>x</A> to <A>y</A>.
##
##  </Description>
##
##  </ManSection>
##  <#/GAPDoc>
DeclareGlobalFunction( "HDistance" );

#F  HRemovedEdge( H, e ) 
##
##  <#GAPDoc Label="HRemovedEdge">
##  <ManSection>
##  <Func Name="HRemovedEdge" Arg="H, e"/>
##
##  <Description>
##
##  Returns the graph obtained from the hypergraph <A>H</A> removing
##  its edge <A>e</A>.
##
##  </Description>
##
##  </ManSection>
##  <#/GAPDoc>
DeclareGlobalFunction( "HRemovedEdge" );
