%% intégrateur
num=[1];den=[1 0];
sys=tf(num,den);
%figure(1);bode(sys,{0.01,1})
figure(2);nyquist(sys,{0.01,1000})
%% différentiateur
den=[0 1];num=[1 0];
sys=tf(num,den);
figure(1);bode(sys,{0.01,1})
figure(2);nyquist(sys,{0.001,1})
%% FT 1er ordre (constante de temps)
den=[1 1];num=[1];
sys=tf(num,den);
figure(1);bode(sys,{0.01,100});
figure(2);nyquist(sys,{0.001,10000})
%% FT 2er ordre oscillant
w0=1;ksi=0.01;wr=w0*sqrt(1-ksi^2);
num=[1];den=[1/w0^2 2*ksi/w0 1];
sys=tf(num,den);
figure(1);bode(sys,{0.01,100});
figure(2);nyquist(sys,{0.001,100})
%% Exemple 1
kp=10;dens=[2 1];nums=[2.5];
numHn=kp*nums;denHn=dens;
sys=tf(numHn,denHn);
%figure(1);bode(sys,{0.01,100});
figure(2);nyquist(sys,{0.01,100})