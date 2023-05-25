function s = bissection(f,x0,x1,tol)
%on recherche le zéro de f sur l'intervalle [a,b]
%signe de f(a) != signe de f(b)
while abs(x0-x1)>tol*abs(x1)   %erreur relative
    s=(x0+x1)/2;
    if f(x0)*f(s)<0
        x1=s;
    else
        x0=s;
    end
end
s=(x0+x1)/2;
