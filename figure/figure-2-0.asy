import "grafi.asy" as grafi;
import roundedpath;

pen pa = 0.6*rgb(130/255.0, 82/255.0, 1/255.0)+0.4*white;
//pen pb = 0.5*rgb(112/255.0, 141/255.0, 19/255.0)+0.5*white;
pen pb = lightgrey;
pen p1 = black+1;
//pen p2 = heavyred+1+dashed;
pen p2 = black+1;
pen p3 = blue+1+dashed;
pen p4 = red+1+dashed;

path c = circle((0,0), 1);
fill(c, 0.5*blue+opacity(0.5));
draw(c, black);

path c = circle((2.5,0), 1);
fill(c, 0.5*red+opacity(0.5));
draw(c, black);


