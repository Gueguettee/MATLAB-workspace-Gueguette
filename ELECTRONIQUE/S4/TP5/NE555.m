%% Circuit a

clear;close all;clc;

f0 = 20e3;
%Vco = 2;

T = 1/f0;
t1 = T/2;
t2 = T - t1;

Iout_max = 10e-3;
Vdd = 5;

Rmin = Vdd/Iout_max;
Tau = t2/(log(2));
Cmax = Tau/Rmin;

Cr = 2.2e-9;
Rr = Tau/Cr

%% Circuit b

%Vc = 3.33;
Vc = (0:0.01:Vdd);

ta = -log(1-Vc/(2*Vdd))*Tau;
tb = -log(1-Vc/Vdd)*Tau;

t1 = tb - ta;
t2 = -log(1/2)*Tau;

T = t1 + t2;
f = 1./T;

DutyCycle = t1./T;

tiledlayout(2,1);
nexttile
plot(Vc, f)
hold on
nexttile
plot(Vc, DutyCycle)
