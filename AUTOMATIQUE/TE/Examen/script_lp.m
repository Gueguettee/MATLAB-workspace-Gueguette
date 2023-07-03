% Script LP
clear;clc;

REG = "P"   %%% Selection du régulateur (H'r(s))
s1 = -10;
s2 = s1;


% Attention a avoir le numérateur et dénominateur de même taille !!

% H'r
if REG=="P" % Hpr(s)=1
    numHpr=[1];
    denHpr=[1];
elseif REG=="PI" % Hpr(s)=(s-s1)/s
    numHpr=[1, -s1];
    denHpr=[1, 0];
elseif REG=="PD" % Hpr(s)=1-s/s1
     numHpr=[-1/s1, 1];
     denHpr=[0, 1];
elseif REG=="PID" % Hpr(s)=(s-s1)(s-s2)/(-s(s1+s2))
    numHpr=[1, -s1-s2, s1*s2];
    denHpr=(-s1-s2)*[0, 1, 0];
end

% H'r customisé. Commenter si non utilisé
% REG="?"
%numHpr=[1, 8e5];
%denHpr=[1, 0];


% Hcm
numHcm=[2.3];
denHcm=[1];

% Hs
numHs=[0 0 0.2];
denHs=[1 0.2 0];

% Hm
numHm=[10];
denHm=[1];


%%%%%%%%%% LP

% calcul de HL
[numHL, denHL] = series(numHcm, denHcm, numHs, denHs);
[numHL, denHL] = series(numHL, denHL, numHm, denHm);
[numHL, denHL] = series(numHL, denHL, numHpr, denHpr);
%numHL = [0 22 4.6];
%denHL = [1 0.2 0];
% LP de HL
figure; sgrid('new');
rlocus(numHL, denHL);
title("LP régulateur " + REG)

% Hit target
[kp, poles]=rlocfind(numHL, denHL)

% Choix de Kp
% kp=8e5


%%%%%%%%%% Response indicielle

% calcul de la fonction de transfert en bouclefermee
[numH0, denH0]=series(kp*numHcm, denHcm, numHs, denHs);
[numH0, denH0]=series(numH0, denH0, numHpr, denHpr);

% calcul de Hbc
[numHbc, denHbc]=feedback(numH0, denH0, numHm, denHm);

% Dessin de la response indicielle
figure;
step(numHbc, denHbc);
title("réponse indicielle régulateur " + REG)