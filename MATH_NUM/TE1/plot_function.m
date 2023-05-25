f=@(x) x^2/(3+x);
g=@(x) x*sin(1/x);

interval=[-2;2];

ezplot(f,interval);
hold on;
ezplot(g,interval);
