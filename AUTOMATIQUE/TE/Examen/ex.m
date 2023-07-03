%% EXERCICE 10
%% question 2
kcm=12.5;numHm=[10];denHm=[1 20];numHs=[0.1];denHs=[0.1 1 0];
kp=1; %1er cas
[numHN,denHN]=series(kp*kcm*numHs,denHs,numHm,denHm); 
sys1=tf(numHN,denHN);
nyquist(sys1);
hold on
kp=5; %2ème cas
[numHN,denHN]=series(kp*kcm*numHs,denHs,numHm,denHm); 
sys1=tf(numHN,denHN);
nyquist(sys1);
% cercle unité
theta = linspace(pi,2*pi);
xc = cos(theta);
yc = sin(theta);
plot(xc,yc)
axis equal
hold off
%% question 3
kcm=12.5;numHm=[10];denHm=[1 20];numHs=[0.1];denHs=[0.1 1 0];
kp=5;
[numHN,denHN]=series(kp*kcm*numHs,denHs,numHm,denHm); 
sys1=tf(numHN,denHN);
nyquist(sys1);
axis equal
[Mg,Mp,wg,wp] = margin(sys1);
MgdB=20*log10(Mg);