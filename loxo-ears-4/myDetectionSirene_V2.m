%% Détecter une sirène grâce à l'autocorrélation
%  Décomposition signal et récup fréquence la plus élevée
clc; clear; close all; 

sounddirectory = 'Sounds';

R = 1;
L = 2;

vSound = 343;

Fmax = 4000;     % à ajuster
Fmin = 200;     % à ajuster
F_step = 20;

[data, Fs] = audioread(fullfile(sounddirectory,'PoliceSuisse.mp3'));

data = data';
lData = length(data);

figure(1)
plot(data(1,:))
hold on
plot(data(2,:))

maxDelay = 1/Fmin;% à ajuster
minDelay = 1/Fmax;% à ajuster

Ps = 1/Fs;
maxLag = round(maxDelay/Ps);
minLag = round(minDelay/Ps);
stepLag = 1;
nLag = floor(maxLag - minLag)/stepLag + 1; % "+1" pour le 0 de lag

time_audio = lData*Ps;
time_step = 0.05;

n_cycle = uint32(floor(time_audio/time_step));
n_data_cycle = uint32(floor(lData/(time_audio/time_step)));

maxCorrCycle = zeros(1,n_cycle);
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
    freqR = 1/(lagMaxCorrR * Ps);
    %[maxCorrL, indexMaxCorrL] = max(corr(:,L));
    %lagMaxCorrL = indexMaxCorrL-1+minLag;
    %freqL = 1/(lagMaxCorrL * Ps);
    if((freqR < 320)||(freqR > 720))
        freqR = 0;
    end
    maxCorrCycle(cycle) = freqR;
end

%%

t = 0:time_step:time_audio-time_step;
figure(3)
stem(t, maxCorrCycle)

%% Sirene detection 

count = 0;
Freq = 0;
oldFreq = 0;
sirenFlag = 0;
siren = zeros(1,length(maxCorrCycle(:)));

tol = 20;
time = 0;
mintime = 0.5; %minimum duration of one siren tone in seconds
maxtime = 0.9; %maximum duration of one siren tone in seconds
sirentime = 0;

sizeSlide = floor(mintime/time_step);
slideTable = zeros(1,sizeSlide);
periode = 0;

n=1;
while n <= length(maxCorrCycle(:))-sizeSlide
    n = n+1;
    count = 0;
    if sirenFlag
        time = time + time_step;
    end
    for m = 1:sizeSlide
        slideTable(m) = maxCorrCycle(n+sizeSlide-m);
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
                for index = round(n-(time/time_step)):round(n+(time/time_step))
                    siren(index) = 1;
                end
                sirenflag = 0;
                periode = periode + 1;
            elseif (Freq <= oldFreq/1.2) &&  (Freq >= oldFreq/1.4)
                for index = round(n-(time/time_step)):round(n+(time/time_step))
                    siren(index) = 1;
                end
                sirenflag = 0;
                periode = periode + 1;
            end
        else 
            sirenFlag = 1;
            oldFreq = Freq;
            n = n + sizeSlide;
            time = sizeSlide * time_step;
        end
    end
    if mean(slideTable) < 300
        sirenFlag = 0;
        periode = 0;
    end
%     if periode >= 3
%         for y = 1:50
%             siren(n+y) = 1;
%         end
%     end
end

figure(2)
stem(t,siren)
set(gca,'FontSize',12)
ylim([0 1.1]);
xlim([0 90])
xlabel('[t] = s','Fontsize',18);
ylabel('Siren alarm','Fontsize',16);
