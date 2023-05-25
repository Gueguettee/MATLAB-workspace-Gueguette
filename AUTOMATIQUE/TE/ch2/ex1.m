
% c)
clear;clc;close;

num = [1];
den = [40 14 1 0];

% Décomposition en fractions partielles
[r p k] = residue(num, den)

% réponse indicielle
den = [40 14 1];
step(num, den, 40);

%% plot step
% On a passé le pole -0.1 en +0.1

clear;clc;close;

num = [1];
den = [40 6 -1];
step(num, den, 40);

tf