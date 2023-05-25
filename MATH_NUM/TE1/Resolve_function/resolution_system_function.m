f = @(x,y) x^2 + y^2 -4;
g = @(x,y) x^2 -y^2 -1;

ezplot(f);
hold on;
ezplot(g);

fsolve('fXY',[1; 1]);
