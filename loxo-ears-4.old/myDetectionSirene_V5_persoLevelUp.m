%% Détecter la sirène

clc; clear; close all; 

sounddirectory = 'Sounds';

R = 1;
L = 2;

vSound = 343;

v_max_alpha = 25;
v_max_emergency = 70;
v_diff_max = v_max_alpha + v_max_emergency;

F_step = 20;
fmin = 360;
fmax = 630;
fmin = fmin - fmin*v_diff_max/3.6/vSound;
fmax = fmax + fmax*v_diff_max/3.6/vSound;
Fmin_meas = floor(fmin) - mod(floor(fmin),F_step);
Fmax_meas = ceil(fmax) + (F_step-mod(ceil(fmax),F_step));

[data, Fs] = audioread(fullfile(sounddirectory,'PoliceSuisse.mp3'));

data = data';
lData = length(data);
% figure(1)
% plot(data(1,:))
% hold on
% plot(data(2,:))

maxDelay = 1/Fmin_meas;% à ajuster
minDelay = 1/Fmax_meas;% à ajuster

Ps = 1/Fs(1);
maxLag = round(maxDelay/Ps);
% minLag = round(minDelay/Ps);
% stepLag = 1;
% nLag = floor(maxLag - minLag)/stepLag + 1; % "+1" pour le 0 de lag

time_audio = lData*Ps;
time_bigCycle = 0.05;
time_microCylce = 0.001;

nFreq = floor((Fmax_meas-Fmin_meas)/F_step)+1;

tic
n_microCycleInBigCycle = floor(time_bigCycle/time_microCylce);
n_data_microCycle = floor(time_microCylce/Ps);
n_data_bigCycle = n_data_microCycle*n_microCycleInBigCycle;
%n_bigCycle = floor(lData/n_data_bigCycle);
n_microCycle = floor((lData-maxLag)/n_data_microCycle);

corrMicroCycle = zeros(nFreq,n_microCycleInBigCycle);
corrBigCycle = zeros(1, nFreq);
maxFreqMicroCycle = zeros(1,n_microCycle);
for microCycle=1:n_microCycle
    for f=Fmin_meas:F_step:Fmax_meas
        iFreq = (f-Fmin_meas)/F_step+1;
        lag = round(1/(f*Ps));
        offsetMicroCycle = (microCycle-1)*n_data_microCycle;
        endMicroCycle = offsetMicroCycle+n_data_microCycle;
        sumToAdd = 0;
        for t=offsetMicroCycle+1:endMicroCycle
            sumToAdd = sumToAdd + abs(data(R,t)-data(R,t+lag));
        end
        iMicroCycle = mod(microCycle, n_microCycleInBigCycle);
        if iMicroCycle == 0
            iMicroCycle = n_microCycleInBigCycle;
        end
        nToSub = corrMicroCycle(iFreq,iMicroCycle);
        corrMicroCycle(iFreq,iMicroCycle) = sumToAdd;
        corrBigCycle(iFreq) = corrBigCycle(iFreq) + sumToAdd - nToSub;
    end

    if microCycle==201    %juste pour afficher une fois une correlation
        figure(2)
        delayTable = linspace(minDelay,maxDelay,length(corrBigCycle));
        plot(delayTable, corrBigCycle)
    end

    [maxCorr, indexMaxCorr] = min(corrBigCycle(:));
    freq = (indexMaxCorr-1)*F_step+Fmin_meas;
    % if((freq < fmin)||(freq > fmax))
    %     freq = 0;
    % end
    maxFreqMicroCycle(microCycle) = freq;
end
toc

t = linspace(0.0, (n_microCycle*n_data_microCycle*Ps), n_microCycle);
figure(3)
stem(t, maxFreqMicroCycle)

%% Sirene detection 

siren = zeros(1,length(maxFreqMicroCycle));

%tolMeas = 0.1;
tolMeasFreq = F_step;

rapport = 3/4;
minRatio = 3/4*(1-0.03);
maxRatio = 3/4*(1+0.07);
maxGapFreqTolRatio = (1-maxRatio)/2;

timeCylceSiren = 3;
tolTimeCycleSiren = 0.167;% 1/6
timeCylceSirenMin = timeCylceSiren*(1-tolTimeCycleSiren);
timeCylceSirenMax = timeCylceSiren*(1+tolTimeCycleSiren);

timeSizeSlide = time_bigCycle;


freqFlag = false;
for microCycle=1:n_microCycle
    
end

figure(3)
stem(t, siren)
