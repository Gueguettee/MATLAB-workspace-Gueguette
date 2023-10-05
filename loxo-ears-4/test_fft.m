clc; clear; close all; 

sounddirectory = 'Sounds';

R = 1;
L = 2;

vSound = 343;
dMicro = 1;

angleMax = 90;
angleMin = -angleMax;
angleMiddle = 0;

[data, Fs(1)] = audioread(fullfile(sounddirectory,'1.mp3'));
[data2, Fs(2)] = audioread(fullfile(sounddirectory,'2.mp3'));
if length(data2) < length(data)
    data = data(1:length(data2),:);
end

data = data';
data2 = data2';
data(2,:) = data2(1,1:length(data));
lData = length(data);

maxDelay = dMicro/vSound;
minDelay = -maxDelay;

Ps = 1/Fs(1);

% Calculez la longueur de la séquence FFT nécessaire pour la corrélation
nfft = 2^nextpow2(2 * lData - 1);

% Appliquez la FFT aux signaux
fft_data_R = fft(data(R,:), nfft);
fft_data_L = fft(data(L,:), nfft);

plot(abs(fft_data_L))

% Calculez la corrélation croisée en utilisant l'inverse de la FFT
corr = ifft(fft_data_R .* conj(fft_data_L));

% Déterminez le retard (delay)
[maxCorr, indexMaxCorr] = max(corr);
lagMaxCorr = indexMaxCorr - nfft;
delay = lagMaxCorr * Ps;

% Affichez le résultat
fprintf('Le retard entre les signaux est de %.3f secondes.\n', delay);
