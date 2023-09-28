%% Lecture et autocorrelation du signal
% Théorique : F0=114.2, F1=558.3, F2=1342.8, F3=2204.1

clc; clear; close all;

root = 'Samples/corr.wav';

[data,Fs] = audioread(root); %pour la fenetre

t_max = length(data)/Fs;
t     = linspace(0, t_max, length(data));

figure(1);
subplot(2,1,1);
plot(t, data, 'k-', 'LineWidth', 2);
grid;
title('Signal');
xlabel('Temps [s]');
ylabel('Amplitude [V]');

[y, lags] = xcorr(data);
time      = (lags/Fs);

subplot(2,1,2);
plot(time, y, 'b-', 'LineWidth', 2);
grid;
title('Autocorrelation du signal');
xlabel('Temps [s]');
ylabel('Autocorrélation [V^2s]');
%axis([min(time), max(time), min(y), max(y)]);

%% Calcul Pitch

pitch = 1/0.00929705;
