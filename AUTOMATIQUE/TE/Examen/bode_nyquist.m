close all;clc;clear;

kp=1;

num = [kp*12.5];
den = [0.1 -3 20];
sys = tf(num,den);
figure(1); nyquist(sys);
hold on
%figure(2); bode(sys);