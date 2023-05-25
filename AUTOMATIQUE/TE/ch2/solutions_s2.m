%% exercice 1, question 3 : développement en fractions simples
num = [1]; %numérateur de Y(s)
den = [40 14 1 0]; %dénominateur de Y(s)
[r,p,k] = residue(num,den)
%% exercice 1, question 3 : esquisse de la réponse indicielle
num = [1]; %numérateur de la fonction de transfert
den = [40 14 1]; %dénominateur de la fonction de transfert
step(num,den);
%% exercice 3, question 3, décomposition en fractions simples
num = [1]; %numérateur de Y(s)
den = [4 1 0]; %dénminateur de Y(s)
[r,p,k] = residue(num,den)
%% exercice 3, question 3, esquisse de la réponse indicielle
num = [1]; %numérateur de la F.T.
den = [4 1]; %dénominateur de la F.T.
step(num,den)
%impulse(num,den) %réponse impulsionnelle

%% exercice 4, question 2, décomposition en fractions simples
p1=-1+i*3;p2=-1-i*3;
num=[100]; %numérateur de Y(s)
den=[1 -(p1+p2) +p1*p2 0]; %dénominateur de Y(s)
[r,p,k] = residue(num,den)
%% exercice 4, question 2, esquisse de la réponse indicielle
p1=-1+i*3;p2=-1-i*3;
num=[100]; %numérateur de la F.T.
den=[1 -(p1+p2) +p1*p2]; %dénominateur de la F.T.
step(num,den)

%% exercice 5, réponse par rapport à la commande, décomposition en fractions simples
num = [1 2]; %numérateur de Y(s)
den = [1 4 0]; %dénoominateur de Y(s)
[r,p,k] = residue(num,den)
%% exercice 5, esquisse de la réponse par rapport à la commande
num = [1 2];%numérateur de Hs
den = [1 4 0];%dénominateur de Hs
impulse(num,den)
%% exercice 6bis, question 1, décomposition en fractions simples
num=[2 1 -1]; %numérateur de Y(s)
den=[2 12 21 12]; %dénominateur de Y(s)
[r,p,k] = residue(num,den)
%% exercice 7, question 3, esquisse de la réponse impulsionnelle
Cc=10^-5;Lc=10^-3;Rc=2;
num=[Cc 1]; %numérateur de la F.T.
den=[Lc*Cc Rc*Cc 1]; %dénominateur de la F.T.
impulse(num,den)
%% exercice 13, question 2, décomposition en fractions simples
num=[10]; %numérateur de Y(s)
den=[1 1 0 0]; %dénominateur de Y(s)
[r,p,k] = residue(num,den)
%% exercice 17, question 3, esquisse de la réponse indicielle
kd=3;kr=50;m=0.1;
num = [kr];%numérateur de H(s)
den = [m kd kr];%dénominateur de H(s)
step(num,den)
%% exercice 21, question 3, esquisse de la réponse indicielle
ka=9.79; kf=0.01; J= 0.0258;
num = [ka];%numérateur de la F.T.
den = [J kf ka];%dénominateur de la F.T.
%step(num,den,30) 
roots(den)