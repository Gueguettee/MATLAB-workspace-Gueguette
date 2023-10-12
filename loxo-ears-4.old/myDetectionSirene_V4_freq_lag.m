%% Détecter la sirène

clc; clear; close all; 

sounddirectory = 'Sounds';

R = 1;
L = 2;

vSound = 343;

v_max_alpha = 25;
v_max_emergency = 70;
v_diff_max = v_max_alpha + v_max_emergency;

%Fmax_meas = 4000;     % à ajuster
%Fmin_meas = 100;     % à ajuster
F_step = 10;    % Fmax and Fmin must be multiple of F_step
fmin = 360;
fmax = 630;
fmin = fmin - fmin*v_diff_max/3.6/vSound;
fmax = fmax + fmax*v_diff_max/3.6/vSound;
Fmin_meas = floor(fmin) - mod(floor(fmin),F_step);
Fmax_meas = ceil(fmax) + (F_step-mod(ceil(fmax),F_step));

[data, Fs] = audioread(fullfile(sounddirectory,'PompiersSuisse.mp3'));

data = data';
lData = length(data);
figure(1)
plot(data(1,:))
hold on
plot(data(2,:))

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
        hold on
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

count = 0;
Freq = 0;
oldFreq = 0;
sirenFlag = 0;
siren = zeros(1,length(maxFreqMicroCycle(:)));
time_microStep = time_microCylce;

tol = 20;
time = 0;
mintime = 0.5; %minimum duration of one siren tone in seconds
maxtime = 0.9; %maximum duration of one siren tone in seconds
sirentime = 0;

sizeSlide = floor(mintime/time_microStep);
slideTable = zeros(1,sizeSlide);
periode = 0;

n=1;
while n <= length(maxFreqMicroCycle(:))-sizeSlide
    n = n+1;
    count = 0;
    if sirenFlag
        time = time + time_microStep;
    end
    for m = 1:sizeSlide
        slideTable(m) = maxFreqMicroCycle(n+sizeSlide-m);
        if (slideTable(1) >= slideTable(m) - tol) && (slideTable(1) <= slideTable(m) + tol)
            count = count + 1;
        end
    end
    if count >= floor(0.8*sizeSlide) && slideTable(1) ~= 0 % 80% des valeurs ok
        Freq = slideTable(1);
        if time > maxtime
            sirenFlag = 0;
            periode = 0;
        end
        if sirenFlag 
            if (Freq >= 1.2*oldFreq) &&  (Freq <= 1.4*oldFreq)
                for index = round(n-(time/time_microStep)):round(n+(time/time_microStep))
                    siren(index) = 1;
                end
                sirenflag = 0;
                periode = periode + 1;
            elseif (Freq <= oldFreq/1.2) &&  (Freq >= oldFreq/1.4)
                for index = round(n-(time/time_microStep)):round(n+(time/time_microStep))
                    siren(index) = 1;
                end
                sirenflag = 0;
                periode = periode + 1;
            end
        else 
            sirenFlag = 1;
            oldFreq = Freq;
            n = n + sizeSlide;
            time = sizeSlide * time_microStep;
        end
    end
    % if mean(slideTable) < 300
    %     sirenFlag = 0;
    %     periode = 0;
    % end
    % if periode >= 3
    %     for y = 1:50
    %         siren(n+y) = 1;
    %     end
    % end
end

figure(5)
stem(t,siren)
set(gca,'FontSize',12)
xlabel('[t] = s','Fontsize',18);
ylabel('Siren alarm','Fontsize',16);
