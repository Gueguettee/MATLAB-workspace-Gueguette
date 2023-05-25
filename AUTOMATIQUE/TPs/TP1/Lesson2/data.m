Ra = 5.4;
La = 10e-6;

kc = 0.022;
ku = 0.022;
ki = 0; 
kp = 1;
kd = 0;
kcm = 1;

J0 = 14e-7;
Ja1 = J0;
Ja2 = 2*J0;
Ja3 = 3*J0;
Jt = 2*J0 + Ja2;

Unom = 15;
Cnom = 50e-3;
TPMmax = 5100;

mr = 5e-3;

numHl = [kcm*kc*ku];
denHl = [Ra*Jt ku*kc];
rlocus(numHl,denHl);
taum=Jt*Ra/(ku*kc);
%[kp poles] = rlocfind(numHl,denHl,[-2*ku*kc/(Jt*Ra)])

%kp = 8
%ki = 400 %valeur donner par le prof et ensuite comparer lées valeurs avec la théorie
%Prochaine étape test avec S1 = -30 et Ki max du datasheet