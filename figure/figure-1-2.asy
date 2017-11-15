import graph;

size(250,150,IgnoreAspect);

real f(real x) {return 1/x  ; }
pair F(real x) {return (x,f(x));}

xaxis("$k$");
yaxis("$P(deg(u) = k)$",0);

draw(graph(f,0.1,1.5,operator ..),black);

// labely(1,E);
// label("$e^x$",F(1),SE);
