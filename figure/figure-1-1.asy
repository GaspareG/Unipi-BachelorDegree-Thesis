import graph;

size(250,150,IgnoreAspect);

real f(real x) {return exp( -(x*5-2)^2 / 10 )   ; }
pair F(real x) {return (x,f(x));}

xaxis("$k$");
yaxis("$P(deg(u) = k)$",0);

draw(graph(f,0.1,1.5,operator ..),black);

// labely(1,E);
// label("$e^x$",F(1),SE);
