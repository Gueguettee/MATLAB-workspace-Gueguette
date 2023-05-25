%% EXERCICE 6
w1=0.1;w2=1;w3=8;w4=14;w5=35;w6=85;w7=120;
ym1=0.148;ym2=0.141;ym3=0.1;ym4=0.07;ym5=0.02;ym6=0.01;ym7=0.005;
pm1=0;pm2=-0.16;pm3=-0.91;pm4=-1.13;pm5=-1.40;pm6=-1.48;pm7=-1.52;
X=[ym1*exp(i*pm1);ym2*exp(i*pm2);ym3*exp(i*pm3);
    ym4*exp(i*pm4);ym5*exp(i*pm5);ym6*exp(i*pm6);
    ym7*exp(i*pm7)];
%diagramme de Bode
figure(1);loglog([w1;w2;w3;w4;w5;w6;w7],[ym1^20;ym2^20;ym3^20;ym4^20;ym5^20;ym6^20;ym7^20]); 
figure(2);semilogx([w1;w2;w3;w4;w5;w6;w7],angle(X)); 
%diagramme de Nyquist
figure(3);plot(real(X),imag(X));
%diagrammes de bode de H(s)=1/(s+8)=F.T. approximative
sys1=tf([1],[1 8]);
figure(4);bode(sys1);
figure(5);nyquist(sys1);
%% EXERCICE 7
sys1=tf([1],[15.95*10^-2 0.2934 1]);nyquist(sys1);
%diagramme de Bode
figure(1);bode(sys1); 
%diagramme de Nyquist
figure(2);nyquist(sys1); 
%% EXERCICE 8
kp=1; %valeur par défaut
numHN=[kp];denHN=[1 0 0 0]; 
sys1=tf(numHN,denHN);
nyquist(sys1);
%cercle unité
axis equal
theta = linspace(pi,2*pi);
xc = cos(theta);
yc = sin(theta);
hold on
plot(xc,yc)
hold off
%marges
[Mg,Mp,wg,wp] = margin(sys1)
MgdB=20*log10(Mg)
% on s'aperçoit que quel que soit kp>0, le point critique est à droite du Diagramme
% de Nyquist de HN, donc le réglage est instable.
% on remarquera que la marge de phase est négative.
%% EXERCICE 9
kp=1; %valeur par défaut
numHN=[kp];denHN=[1 0]; 
sys1=tf(numHN,denHN);
nyquist(sys1);
%cercle unité
axis equal
theta = linspace(pi,2*pi);
xc = cos(theta);
yc = sin(theta);
hold on
plot(xc,yc)
hold off
%marges
[Mg,Mp,wg,wp] = margin(sys1)
MgdB=20*log10(Mg)
% on s'aperçoit que quel que soit kp>0, le point critique est à gauche du
% diagramme de Nyquist de HN, donc le réglage est tj stable.
% on remarquera que la marge de phase est égale à 90 degrés, et la marge de
% gain infinie
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
kp=48;
[numHN,denHN]=series(kp*kcm*numHs,denHs,numHm,denHm); 
sys1=tf(numHN,denHN);
nyquist(sys1);
axis equal
[Mg,Mp,wg,wp] = margin(sys1);
MgdB=20*log10(Mg);
%% EXERCICE 11
%% diagramme de Nyquist
w1=0.1;w2=1;w3=5;w4=8;w5=14;w6=35;w7=85;w8=120;
ym1=3;ym2=2.8;ym3=2.4;ym4=2;ym5=1.4;ym6=0.4;ym7=0.2;ym8=0.1;
pm1=0;pm2=-9;pm3=-26;pm4=-52;pm5=-65;pm6=-80;pm7=-85;pm8=-87;
X=[ym1*exp(i*pm1*pi/180);ym2*exp(i*pm2*pi/180);ym3*exp(i*pm3*pi/180);
    ym4*exp(i*pm4*pi/180);ym5*exp(i*pm5*pi/180);ym6*exp(i*pm6*pi/180);
    ym7*exp(i*pm7*pi/180);ym8*exp(i*pm8*pi/180)];
figure(1);plot(real(X),imag(X))
axis equal
% demi-cercle unité
theta = linspace(pi,2*pi);
xc = cos(theta);
yc = sin(theta);
grid on
hold on
plot(xc,yc)
hold off
%% marge de phase
xm=0.386-i*0.922;
Mp=(pi+angle(xm))*180/pi
%la marge de gain est infinie

%% EXERCICE 12
%% question 1
kp=2;kcm=2.5;km=10;
numHN=[50];denHN=[1 5];
sys1=tf(numHN,denHN);
nyquist(sys1);
%% question 2
[Mg,Mp,wg,wp] = margin(sys1)
MgdB=20*log10(Mg)
%% question 3
kp=2;ki=12;s1=-ki/kp;
numHr=kp*[1 -s1];denHr=[1 0]; %régulateur PI
kcm=2.5;km=10;numHs=[1];denHs=[1 5];
[numHN,denHN]=series(kcm*km*numHs,denHs,numHr,denHr);
sys2=tf(numHN,denHN);
nyquist(sys2);
[Mg,Mp,wg,wp] = margin(sys2)
MgdB=20*log10(Mg)

%% EXERCICE 13
%% question 1
nums=[0.1];dens=[20 1];
taui=2.4;numHr=[taui 1];denHr=[taui 0];
[numHN,denHN]=series(nums,dens,numHr,denHr);
sys1=tf(numHN,denHN);
nyquist(sys1);
[Mg,Mp,wg,wp] = margin(sys1);
MgdB=20*log10(Mg);
% Mg est la marge de gain, en échelle linéaire (en dB:20*Log(Mg))
% wg est la pulsation correspondant au point d'intersection du D.N. avec l'axe réel (voir le cours)
% Mp est la marge de phase, en degrés
% wp est la pulsation correspondant au point d'intersection du D.N. avec le cercle unité (voir le cours) 
%% question 2
% on obtient taui=2.4 s

%% EXERCICE 14 / boucle 1
%% régulateur P 
kp=0.2;
kcm=2.5;
numHs=[1];denHs=[1/25 0.2/5 1];
numHm=[10];denHm=[1 15];
[numHN,denHN]=series(kp*kcm*numHs,denHs,numHm,denHm); 
sys1=tf(numHN,denHN);
figure(1);nyquist(sys1);
%cercle unité
axis equal
theta = linspace(0,2*pi);
xc = cos(theta);
yc = sin(theta);
hold on
plot(xc,yc)
hold off
%marges
[Mg,Mp,wg,wp] = margin(sys1)
MgdB=20*log10(Mg)
% Mg est la marge de gain, en échelle linéaire (en dB:20*Log(Mg))
% wg est la pulsation correspondant au point d'intersection du D.N. avec l'axe réel (voir le cours)
% Mp est la marge de phase, en degrés
% wp est la pulsation correspondant au point d'intersection du D.N. avec le cercle unité (voir le cours) 

%% régulateur PD
s1=-0.5;kp=0.11;
numHr=kp*[-1 s1];denHr=[0 s1]; %régulateur
kcm=2.5;
numHs=[1];denHs=[1/25 0.2/5 1];
numHm=[10];denHm=[1 15];
[numHN,denHN]=series(kcm*numHs,denHs,numHm,denHm); 
[numHN,denHN]=series(numHr,denHr,numHN,denHN); 
sys2=tf(numHN,denHN);
nyquist(sys2);
%cercle unité
axis equal
theta = linspace(pi,2*pi);
xc = cos(theta);
yc = sin(theta);
hold on
plot(xc,yc)
hold off
%marges
[Mg,Mp,wg,wp] = margin(sys2)
MgdB=20*log10(Mg)
%% régulateur PID
s1=-2;s2=-4;kp=0.16;
numHr=kp*[1 -s1-s2 s1*s2];denHr=[0 -s1-s2 0]; %régulateur
kcm=2.5;
numHs=[1];denHs=[1/25 0.2/5 1];
numHm=[10];denHm=[1 15];
[numHN,denHN]=series(kcm*numHs,denHs,numHm,denHm); 
[numHN,denHN]=series(numHr,denHr,numHN,denHN); 
sys3=tf(numHN,denHN);
nyquist(sys3);
%cercle unité
axis equal
theta = linspace(pi,2*pi);
xc = cos(theta);
yc = sin(theta);
hold on
plot(xc,yc)
hold off
%marges
[Mg,Mp,wg,wp] = margin(sys3);
MgdB=20*log10(Mg)

%% EXERCICE 14 / boucle 2
%% régulateur P 
kp=0.22;
kcm=20;
numHs=[0.1 0.2];denHs=[0.2 0.2 2];
numHm=[1.5];denHm=[0.1 1];
[numHN,denHN]=series(kp*kcm*numHs,denHs,numHm,denHm); 
sys1=tf(numHN,denHN);
nyquist(sys1);
%cercle unité
axis equal
theta = linspace(pi,2*pi);
xc = cos(theta);
yc = sin(theta);
hold on
plot(xc,yc)
hold off
%marges
[Mg,Mp,wg,wp] = margin(sys1)
MgdB=20*log10(Mg)
% Mg est la marge de gain, en échelle linéaire (en dB:20*Log(Mg))
%% régulateur PI
s1=-2;kp=0.074;
numHr=kp*[1 -s1];denHr=[1 0]; %régulateur
kcm=20;
numHs=[0.1 0.2];denHs=[0.2 0.2 2];
numHm=[1.5];denHm=[0.1 1];
[numHN,denHN]=series(kcm*numHs,denHs,numHm,denHm); 
[numHN,denHN]=series(numHr,denHr,numHN,denHN); 
sys2=tf(numHN,denHN);
nyquist(sys2);
%cercle unité
axis equal
theta = linspace(pi,2*pi);
xc = cos(theta);
yc = sin(theta);
hold on
plot(xc,yc)
hold off
%marges
[Mg,Mp,wg,wp] = margin(sys2)
MgdB=20*log10(Mg)