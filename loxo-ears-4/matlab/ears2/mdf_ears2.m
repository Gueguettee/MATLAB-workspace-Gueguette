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