import graph;

picture pic;
real xsize=400, ysize=300;

size(pic,xsize,ysize,IgnoreAspect);

scale(Log,Log);

pair[] f={
    (100,200),
    (200,520),    
    (500,870)
};
draw(pic,graph(pic,f),"q = 4", marker(scale(0.8mm)*unitcircle,green,FillDraw(green),above=false));

pair[] f2={
    (100,1206),
    (200,2736),    
    (500,6080)
};
draw(pic,graph(pic,f2),"q = 5", marker(scale(0.8mm)*unitcircle,yellow,FillDraw(yellow),above=false));

pair[] f3={
    (100,22715),
    (200,49828),    
    (500,104129)
};

draw(pic,graph(pic,f3),"q = 6", marker(scale(0.8mm)*unitcircle,red,FillDraw(red),above=false));

xaxis(pic,"$|A \cup B|$",BottomTop,LeftTicks);
yaxis(pic,"$t$",LeftRight,RightTicks);
add(pic,legend(pic),point(pic,NW),20SE,UnFill);

// Fit pic to W of origin:
add(pic.fit(),(0,0),W);
