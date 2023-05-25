function [t, y] = euler2_te(f, tspan, y0, h)
% Input :
% f     : représente l'équation différentielle 
% dydt  : f(t, y)
% tspan : [t0, tf] t0: temps initial, tf: temps final
% y0    : condition initiale y(t0)
% h     : pas d'intégration
% Output:
% t     : [t0, t1, t2, t3, ..., tf]
% y     : [y0, y1, y2, y3, ..., yf]

t0 = tspan(1);
tf = tspan(2);
t(1) = t0;
y(1,1) = y0(1);
y(1,2) = y0(2);
n = 1;
while t(n) < tf
    f = dydx2(t(n), [(y(n,1)),(y(n,2))]);
    y(n+1,1) = y(n,1) + h*f(1);
    y(n+1,2) = y(n,2) + h*f(2);
    t(n+1) = t(n) + h;
    n = n + 1;
end