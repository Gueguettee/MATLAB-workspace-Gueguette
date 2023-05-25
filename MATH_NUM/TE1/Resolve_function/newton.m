function s = newton(f,fp,x0,tol)
%on recherche le zéro de f
x1 = x0 - f(x0)/fp(x0);
while(abs(x0-x1) > tol*abs(x1))
    x0=x1;
    x1=x0-f(x0)/fp(x0);
end
s=x1;
end
