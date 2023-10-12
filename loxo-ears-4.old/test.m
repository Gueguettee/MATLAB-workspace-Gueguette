%% MDF (v2)
clc; clear all; close all; 

[dataRL,Fs] = audioread("Sounds\PoliceSuisse.mp3");

%sound(dataRL, Fs)
dataL = dataRL(:,1);
dataR = dataRL(:,2);

% Fs = 8000;
% dataL = record;
% dataR = record;

timeaudio = length(dataL)/Fs %sec
timestep = 0.05 %sec

%f = -Fs/2:Fs/length(data):Fs/2-Fs/length(data)

Ncycle = uint32(ceil(timeaudio/timestep));
Ndata_cycle = uint32(length(dataL)/(timeaudio/timestep));
 
data_t = zeros(2,Ncycle);

frequencystep = 20;
Fmin = 200; %Hz
Fmax = 4000; %Hz

freqTable = Fmin:frequencystep:Fmax;
Dm = zeros(2,length(freqTable));  
for x=1:Ncycle
    for lag=Fmin:frequencystep:Fmax
        sumR = 0;
        sumL = 0;
        offset = uint32(Fs/lag);
        for n=1:Ndata_cycle
            if offset < n && uint32(x-1)*(Ndata_cycle)+n < length(dataR)
                sumR = sumR + abs(dataR(uint32(x-1)*(Ndata_cycle)+n) - dataR(uint32(x-1)*(Ndata_cycle)+n-offset));
                sumL = sumL + abs(dataL(uint32(x-1)*(Ndata_cycle)+n) - dataL(uint32(x-1)*(Ndata_cycle)+n-offset));
        
            end
        end
        Dm(1,(lag - Fmin)/frequencystep + 1) = sumR;
        Dm(2,(lag - Fmin)/frequencystep + 1) = sumL;
    end
    
    lag=Fmin:frequencystep:Fmax;
    l = 1./lag;
    if x == Ncycle/2 + 110 
        figure(10)
        subplot(2,1,1)
        stem(l*1000,Dm(1,:),'Color',[0 0 0])
        set(gca,'FontSize',12)
        xlabel('[lag] = ms','Fontsize',18)
        ylabel('[MDF(lag)]','Fontsize',18)
        
        subplot(2,1,2)
        stem(lag,Dm(1,:),'Color',[0 0 0])
        set(gca,'FontSize',12)
        xlabel('[f] = Hz','Fontsize',18)
        ylabel('[MDF(1/f)]','Fontsize',18)
    end
    
    Amin(1) = Fmin;
    Amin(2) = Fmin;
    
    for v=Fmin:frequencystep:Fmax
        if Dm(1,(Amin(1) - Fmin)/frequencystep + 1) > Dm(1,(v - Fmin)/frequencystep + 1)
            Amin(1) = v;
        end
        if Dm(2,(Amin(2) - Fmin)/frequencystep + 1) > Dm(2,(v - Fmin)/frequencystep + 1)
            Amin(2) = v;
        end
    end
    
    if abs(Amin(1) - Amin(2)) <= 40 && Amin(1) <= 720 && Amin(1) >= 320
        data_t(1,x) = Amin(1);
        data_t(2,x) = Amin(2);
    else
        data_t(1,x) = 0;
        data_t(2,x) = 0;
    end
    
end


t = 0:timestep:timeaudio;
figure(2)
hold off
ax(1) = subplot(2,1,1)
stem(t,data_t(1,:));
set(gca,'FontSize',12)
ylim([0 800]);
xlim([0 106])
xlabel('[t] = s','Fontsize',18);
ylabel('[f] = Hz','Fontsize',18);

figure(3)
hold off
%ax(2) = subplot(2,1,1)
stem(t,data_t(1,:));
set(gca,'FontSize',12)
ylim([0 800]);
xlim([33 44])
xlabel('[t] = s','Fontsize',18);
ylabel('[f] = Hz','Fontsize',18);

%% Time analysis (v.3)
count = 0;
Freq = 0;
oldFreq = 0;
sirenFlag = 0;
siren = zeros(1,length(data_t(1,:)));

%t = 0:timestep:timeaudio+40*timestep; % Seulement pour FFT

tol = 20; %Hz
time = 0;
mintime = 0.5; %minimum duration of one siren tone in seconds
maxtime = 0.9; %maximum duration of one siren tone in seconds
sirentime = 0;

sizeSlide = floor(mintime/timestep);
slideTable = zeros(1,sizeSlide);
periode = 0;

n=1;
while n <= length(data_t(1,:))-sizeSlide
    n = n+1;
    count = 0;
    if sirenFlag
        time = time + timestep;
    end
    for m = 1:sizeSlide
        slideTable(m) = data_t(1,n+sizeSlide-m);
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
                for index = round(n-(time/timestep)):round(n+(time/timestep))
                    siren(index) = 1;
                end
                sirenflag = 0;
                periode = periode + 1;
            elseif (Freq <= oldFreq/1.2) &&  (Freq >= oldFreq/1.4)
                for index = round(n-(time/timestep)):round(n+(time/timestep))
                    siren(index) = 1;
                end
                sirenflag = 0;
                periode = periode + 1;
            end
        else 
            sirenFlag = 1;
            oldFreq = Freq;
            n = n + sizeSlide;
            time = sizeSlide * timestep;
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
%figure(4)
ax(2) = subplot(2,1,2);
stem(t,siren)
set(gca,'FontSize',12)
ylim([0 1.1]);
xlim([0 90])
xlabel('[t] = s','Fontsize',18);
ylabel('Siren alarm','Fontsize',16);

linkaxes(ax,'x')