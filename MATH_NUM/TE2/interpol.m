% Script pour interpoler
x = linspace(1, 9, 5); y = exp(x/2); 
a = polyfit(x, y, 4);
xx = linspace(1, 9, 1000); 
yy = polyval(a, xx);
yys = spline(x,y,xx);
plot(x, y, 'o', xx, yy,'r', xx, yys, 'g', xx, exp(xx/2))
