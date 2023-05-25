function s = secante(f,x0,x1,tol)
%on recherche le zéro de f
x2=x1-f(x1)*(x1-x0)/(f(x1)-f(x0));
while(abs(x2-x1) > tol*abs(x2))
    x0=x1;
    x1=x2;
    x2=x1-f(x1)*(x1-x0)/(f(x1)-f(x0));
end
s=x2;
end
