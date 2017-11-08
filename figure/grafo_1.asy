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

pen c1 = red;
pen c2 = cyan;
pen c3 = green;

// posizioni dei vertici
pair[] P = {
	(1,3.5), (0,2), (2, 2), (0,0),(2,0), (3,3.5), (4, 2), (4, 0)
};

pair[] pos = {
	N, N, N, S, S
};

// colori dei vertici
pen[]  colV = {c1, c2, c3, c1, c2, c3, c1, c3, c2};

// archi del grafo
int[][] E = {{0, 1},{0, 2},{1,3},{2,4},{3,4},{1,2}, {0,5}, {2,6}, {4,7}, {6,7}, {5,6}, {6,4}};

// colori degli archi
pen[]  colE = {p1};

// label 
string C[] = {"","","","","","","","","","",""};

for (int i=0; i<5; ++i)
  label(C[i],P[i],4*pos[i]);

//for (int i=0; i<5; ++i)
//   filldraw(roundedpath(P[i]+(0.7,0.7)--P[i]+(-0.7,0.7)--P[i]+(-0.7,-0.7)--P[i]+(0.7,-0.7)--cycle,0.2), palegrey, grey+2);

// draw(ellipse((0,1),1,2.5), p3);
// label("S2",(-1.2,1),W,blue);

// draw(rotate(-35,(0.75,3))*ellipse((0.75,3),1,2.5), p4);
// label("S1",(0,4),W, red);

grafi.main(P, colV, E, colE);
