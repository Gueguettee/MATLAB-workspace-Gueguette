%% Exemple 1
kp=10;numHn=[kp*2.5];denHn=[2 1 0];
sys=tf(numHn,denHn);
figure(1);nyquist(sys)
[Mg,Mp,wg,wp] = margin(sys)
MgdB=20*log10(Mg)


%% exemple 1
numHr=[0.25 1 0.25];denHr=[0 1 0];
numHs=[1.2];denHs=[1 0.2 1];
[numHn,denHn]=series(numHr,denHr,numHs,denHs);
sys=tf(numHn,denHn);
nyquist(sys);
[Mg,Mp,wg,wp] = margin(sys)
MgdB=20*log10(Mg)
%% sys=tf(num,den);FT 1er ordre (constante de temps)
den=[0.1 3 20 0];num=[12.5];
sys=tf(num,den);

figure(1);bode(sys,{0.01,100});
figure(2);nyquist(sys,{0.001,10000})
[Mg,Mp,wg,wp] = margin(sys);
MgdB=20*log10(Mg);
% Mg est la marge de gain, en échelle linéaire (en dB:20*Log(Mg))
% wg est la pulsation correspondant au point d'intersection du D.N. avec l'axe réel (voir le cours)
% Mp est la marge de phase, en degrés
% wp est la pulsation correspondant au point d'intersection du D.N. avec le cercle unité (voir le cours) 