close all;clc;clear;

num = [1];
den = [1 4 0];
sys = tf(num,den);
figure(1); nyquist(sys, {2,1000});
hold on
figure(2); bode(sys);