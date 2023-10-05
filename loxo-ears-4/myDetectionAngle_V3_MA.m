%% Calculer le retard du signal 2 par rapport au signal 1

clc; clear; close all; 

sounddirectory = 'tb-simsound3d\Enregistrement\Audio\AvecBruitAveDecalage';

R = 1;
L = 2;

vSound = 343;
dMicro = 1;

angleMax = 90;
angleMin = -angleMax;
angleMiddle = 0;

[data, Fs(1)] = audioread(fullfile(sounddirectory,'RecorderBack.wav'));
[data2, Fs(2)] = audioread(fullfile(sounddirectory,'RecorderFront.wav'));
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
minDelay = 0;

Ps = 1/Fs(1);
maxLag = round(maxDelay/Ps);
minLag = round(minDelay/Ps);
stepLag = 1;
nLag = floor(maxLag - minLag)/stepLag + 1; % "+1" pour le 0 de lag

time_audio = lData*Ps;
time_bigStep = 0.05;
time_microStep = 0.001;

n_microCycleInBigCycle = floor(time_bigStep/time_microStep);
n_data_microCycle = floor(time_microStep/Ps);
n_data_bigCycle = n_data_microCycle*n_microCycleInBigCycle;
%n_bigCycle = floor(lData/n_data_bigCycle);
n_microCycle = floor((lData-maxLag)/n_data_microCycle);   % bizarre à corriger

corrMicroCycle = zeros(nLag,n_microCycleInBigCycle);
corrBigCycle = zeros(1, nLag);
delayMaxCorrMicroCycle = zeros(1,n_microCycle);
for microCycle=1:n_microCycle
    for lag=minLag:stepLag:maxLag
        iLag = (lag-minLag)/stepLag+1;
        offsetMicroCycle = (microCycle-1)*n_data_microCycle;
        endMicroCycle = offsetMicroCycle+n_data_microCycle;
        sumToAdd = 0;
        for t=offsetMicroCycle+1:endMicroCycle
            sumToAdd = sumToAdd + data(R,t)*data(R,t+lag);
        end
        iMicroCycle = mod(microCycle, n_microCycleInBigCycle);
        if iMicroCycle == 0
            iMicroCycle = n_microCycleInBigCycle;
        end
        nToSub = corrMicroCycle(iLag,iMicroCycle);
        corrMicroCycle(iLag,iMicroCycle) = sumToAdd;
        corrBigCycle(iLag) = corrBigCycle(iLag) + sumToAdd - nToSub;
    end

    if microCycle==201    %juste pour afficher une fois une correlation
        figure(2)
        delayTable = linspace(minDelay,maxDelay,length(corrBigCycle));
        plot(delayTable, corrBigCycle)
    end

    [maxCorr, indexMaxCorr] = max(corrBigCycle(:));
    lagMaxCorr = indexMaxCorr-1+minLag;
    delayMaxCorrMicroCycle(microCycle) = lagMaxCorr*Ps;
end

t = linspace(0.0, (n_microCycle*Ps), n_microCycle);
figure(3)
stem(t, delayMaxCorrMicroCycle)

%% Mesurer l'angle du véhicule approchant en fonction du retard calculé

angleMaxCorrCycle = zeros(1,n_microCycle);

for cycle=1:n_microCycle
    dDelay = delayMaxCorrMicroCycle(cycle) * vSound;
    if dDelay == 0
        angleMaxCorrCycle(cycle) = 0;
        continue
    end
    angle = acos(dDelay/dMicro);
    angleDeg = angle * 360 / (2*pi);
    angleMaxCorrCycle(cycle) = angleDeg;
end

figure(4)
stem(t, angleMaxCorrCycle)
