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
minDelay = 0;

Ps = 1/Fs(1);
maxLag = round(maxDelay/Ps);
minLag = round(minDelay/Ps);
stepLag = 1;
nLag = floor(maxLag - minLag)/stepLag + 1; % "+1" pour le 0 de lag

time_audio = lData*Ps;
time_step = 0.001;

n_cycle = uint32(floor(time_audio/time_step));
n_data_cycle = uint32(floor(lData/(time_audio/time_step)));

delayMaxCorrCycle = zeros(1,n_cycle);
for cycle=1:n_cycle
    corr = zeros(1,nLag);
    offsetCycle = (cycle-1)*n_data_cycle;
    maxLData = offsetCycle+n_data_cycle;
    for lag=minLag:stepLag:maxLag
        sumR = 0;
        %sumL = 0;
        lagAddToT = lag;
        for t=offsetCycle+1:maxLData
            sumR = sumR + data(R,t)*data(R,t+lagAddToT);
            %sumL = sumL + data(L,t)*data(L,t+lagAddToT);
        end
        corr((lag-minLag)/stepLag+1) = sumR;
        %corr(lag-minLag+1,L) = sumL;
    end

    if cycle==19    %juste pour afficher une fois une correlation
        figure(2)
        delayTable = linspace(minDelay,maxDelay,length(corr));
        plot(delayTable, corr)
    end

    [maxCorrR, indexMaxCorrR] = max(corr(:));
    lagMaxCorrR = indexMaxCorrR-1+minLag;
    delayMaxCorrCycle(cycle) = lagMaxCorrR*Ps;
end

t = 0:time_step:time_audio-time_step;
figure(3)
stem(t, delayMaxCorrCycle)

%% Mesurer l'angle du véhicule approchant en fonction du retard calculé

angleMaxCorrCycle = zeros(1,n_cycle);

for cycle=1:n_cycle
    dDelay = delayMaxCorrCycle(cycle) * vSound;
    angle = acos(dDelay/dMicro);
    angleDeg = angle * 360 / (2*pi);
    angleMaxCorrCycle(cycle) = angleDeg;
end

figure(4)
stem(t, angleMaxCorrCycle)
