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

srand(42);

int N = 10;
int M = 30;
int R = 5;

pair[] P = {
	(0,0),(2,0),(1,1.4142),
	(-1.5,-1), (0, -2),
	(2,-2), (3.5, -1),
	(-0.5, 2.5), (1, 3.5), (2.5, 2.5)
};


// posizioni dei vertici
//pair[] P = {
//	(0,0), (2,0), 
//	(3, 1.5), (2,3), (0,3),
//	(-1, 1.5)
//};


// colori dei vertici
pen[]  colV = {pb};

// archi del grafo
int[][] E = { {0,2}, {1,2}, {0,3}, {0,4}, {1,5}, {1,6}, {2, 7}, {2,8}, {2,9}, {3,4}, {5,6} };

// colori degli archi
pen[]  colE = {p2, p2};


//for (int i=0; i<5; ++i)
//   filldraw(roundedpath(P[i]+(0.7,0.7)--P[i]+(-0.7,0.7)--P[i]+(-0.7,-0.7)--P[i]+(0.7,-0.7)--cycle,0.2), palegrey, grey+2);

grafi.main(P, colV, E, colE);
