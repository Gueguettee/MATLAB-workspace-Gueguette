function [u] = delta(n)
%delta vecteur n en entrée
%   return l'impulsion unité discrète en sortie

u = zeros(size(n));

for m=1:length(n)
    if n(m)==0
        u(m)=1;
    else
        u(m)=0;
    end
end
end
