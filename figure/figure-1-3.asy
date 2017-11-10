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

int N = 8;
int M = 20;
int R = 3;

pair[] P = {};

for(int i =0; i<N; ++i)
{
	pair p = ( R*cos( 2* 3.1415 / N * i ), R*sin( 2*3.1415 / N * i  )  );
	P.push( p );
}

// posizioni dei vertici
//pair[] P = {
//	(0,0), (2,0), 
//	(3, 1.5), (2,3), (0,3),
//	(-1, 1.5)
//};


// colori dei vertici
pen[]  colV = {pb};

// archi del grafo
int[][] E = {}; // { {0,1}, {0,2}, {0,3}, {1,4}, {2,5}, {3,4}, {4,5} };

for(int i=0; i<M ; ++i)
{
	int[] e = { rand()%N,  rand()%N };
	if( e[0] == e[1] )
	{
		--i;
		continue;
	}
	E[i] =  e ;
}

// colori degli archi
pen[]  colE = {p2, p2};


//for (int i=0; i<5; ++i)
//   filldraw(roundedpath(P[i]+(0.7,0.7)--P[i]+(-0.7,0.7)--P[i]+(-0.7,-0.7)--P[i]+(0.7,-0.7)--cycle,0.2), palegrey, grey+2);

grafi.main(P, colV, E, colE);
