#############################################################################
##
##
#W  weak-coloring.gd       hypergraphs Package             
##
##  Declaration file for weak-coloring functions
##
#############################################################################

#F  HCheckSimpleHypergraph( E ) 
##
##  <#GAPDoc Label="HCheckSimpleHypergraph">
##  <ManSection>
##  <Func Name="HCheckSimpleHypergraph" Arg="edges"/>
##
##  <Description>
##  Checks if <M>E</M> represents the set of edges of a simple hypergraph.
##  </Description>
##  </ManSection>
##  <#/GAPDoc>
DeclareGlobalFunction( "HCheckSimpleHypergraph" );

#F  HCheckIsUniformHypergraph( E, r ) 
##
##  <#GAPDoc Label="HCheckIsUniformHypergraph">
##  <ManSection>
##  <Func Name="HCheckIsUniformHypergraph" Arg="edges, number"/>
##
##  <Description>
##  Checks if <M>E</M> represents the set of edges of a <M>r-</M>uniform hypergraph.
##  </Description>
##  </ManSection>
##  <#/GAPDoc>
DeclareGlobalFunction( "HCheckIsUniformHypergraph" );

#F  HPLovasz ( E ) 
##
##  <#GAPDoc Label="HPLovasz">
##  <ManSection>
##  <Func Name="HPLovasz" Arg="edges"/>
##
##  <Description>
##  Checks if <M>E</M> represents the set of edges of a hypergraph with chromatic number 2 using the Lovász property.
##  </Description>
##  </ManSection>
##  <#/GAPDoc>
DeclareGlobalFunction( "HPLovasz" );
