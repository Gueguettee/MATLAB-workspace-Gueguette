%% Calculer le retard du signal 2 par rapport au signal 1

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
[data2, Fs(2)] = audioread(fullfile(sounddirectory,'3.mp3'));
if length(data2) < length(data)
    data = data(1:length(data2),:);
end

data = data';
data2 = data2';
data(2,:) = data2(1,1:length(data));
lData = length(data);
figure(1)
plot(data(1,:))
hold on
plot(data(2,:))

maxDelay = dMicro/vSound;
minDelay = -maxDelay;

Ps = 1/Fs(1);
maxLag = round(maxDelay/Ps);
minLag = round(minDelay/Ps);
nLag = maxLag - minLag + 1; % "+1" pour le 0 de lag

tic;
corr = zeros(1,nLag);
for lag=1:nLag
    tempCorr = 0;
    if -lag >= minLag  %retard négatif only
        maxLData = lData-(-minLag-lag+1);
        addToT = -minLag-lag+1;
        for t=1:maxLData
            tempCorr = tempCorr + data(R,t+addToT)*data(L,t);
        end
    else    %retard positif et nul
        maxLData = lData-(lag-maxLag-1);
        addToT = lag-maxLag-1;
        for t=1:maxLData
            tempCorr = tempCorr + data(R,t)*data(L,t+addToT);
        end
    end
    corr(lag) = tempCorr;
end
durationCalcul = toc;

figure(2)
plot(corr)
[maxCorr, indexMaxCorr] = max(corr);
lagMaxCorr = indexMaxCorr - maxLag - 1;
delay = lagMaxCorr * Ps;

% Verif avec xcorr
tic;
corr2 = xcorr(data(L,:),data(R,:),maxLag);
durationCalcul2 = toc;
[maxCorr2, indexMaxCorr2] = max(corr2);
indexMaxCorr2 = lData - indexMaxCorr2;
figure(3)
plot(corr2)

%% Mesurer l'angle du véhicule approchant en fonction du retard calculé

dDelay = delay * vSound;
angle = acos(dDelay/dMicro);
angleDeg = angle * 360 / (2*pi);
