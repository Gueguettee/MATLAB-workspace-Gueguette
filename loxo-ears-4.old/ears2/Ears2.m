%% PS5 Test
%% FFT

clc; %clear all; close all; 

[dataRL,Fs] = audioread("Sounds\PoliceSuisse.mp3");

dataL = dataRL(:,1);
dataR = dataRL(:,1);

% Fs = 8000;
% dataL = record;
% dataR = record;

timeaudio = length(dataL)/Fs %sec
timestep = 0.05 %sec

%f = -Fs/2:Fs/length(data):Fs/2-Fs/length(data)

Ncycle = uint32(ceil(timeaudio/timestep));
Ndata_cycle = uint32(length(dataL)/(timeaudio/timestep));

data_t = zeros(2,Ndata_cycle);

for x=0:Ncycle-1
    for n=1:Ndata_cycle
        if uint32(x)*(Ndata_cycle)+n <= length(dataL)
            data_t(1,n) = dataL(uint32(x)*(Ndata_cycle)+n);
            data_t(2,n) = dataR(uint32(x)*(Ndata_cycle)+n);
        end
    end
    %figure(double(x)+1);
    %t = 0:1/Fs:timestep-1/Fs;
    %plot(t,data_t);
    %sound(data_t,Fs)
    spectre(x+1,:) = abs(fftshift(fft(data_t(1,:)))) + abs(fftshift(fft(data_t(2,:))));
    data_t = zeros(2,Ndata_cycle);
end

f = -Fs/2:Fs/length(data_t):Fs/2-Fs/length(data_t);

%sound(dataRL, Fs)

freqstep = Fs/length(f);
offset = round(length(f)/2);

Fmin = 300; %multiple de freqstep
Fmax = 725; %multiple de freqstep
harmMax = zeros(1,Ncycle);
FharmMax = Fmin;

% % Initialize video
% myVideo = VideoWriter('myVideoFile'); %open video file
% myVideo.FrameRate = 10;  %can adjust this, 5 - 10 works well for me
% open(myVideo)

% for y=1:Ncycle
%     figure(3)
%     %figure(double(y))   
%     hold off;
%     stem(f,spectre(y,:),'Color',[0 0 0])
%     xlim([0 0.8]*1e3)
%     ylim([0 180])
%     
% % %     figure(2)
% % %     for v=Fmin:freqstep:Fmax
% % %         if spectre(y,v/freqstep+offset) > spectre(y,FharmMax/freqstep+offset)
% % %             harmMax(y) = v;
% % %             FharmMax = v;
% % %         end
% % %     end
% % %     FharmMax = Fmin;
% % %     hold on;
% % %     stem(t,harmMax)
% % %     harmMax = zeros(1,Ncycle);
%     
%     pause(Ncycle/Fs)
%     
% %     frame = getframe(gcf); %get frame
% %     writeVideo(myVideo, frame);
% end

stem(f,spectre(Ncycle/2 + 110,:),'Color',[0 0 0])
xlim([0 0.8]*1e3)
ylim([0 180])
set(gca,'FontSize',12)
xlabel('[f] = Hz','Fontsize',18)
ylabel('[Amplitude]','Fontsize',18)

for u=1:Ncycle
    for v=Fmin:freqstep:Fmax
        if spectre(u,v/freqstep+offset) > spectre(u,FharmMax/freqstep+offset)
            harmMax(u) = v;
            FharmMax = v;
        end
    end
    FharmMax = Fmin;
end

t = 0:timestep:timeaudio;
figure(4)
%ax(1) = subplot(2,1,1)
stem(t,harmMax)
set(gca,'FontSize',12)
xlabel('[t] = s','Fontsize',18);
ylabel('[f] = Hz','Fontsize',18);
xlim([0 106])
ylim([0 800])

figure(3)
%ax(1) = subplot(2,1,1)
stem(t,harmMax)
set(gca,'FontSize',12)
xlabel('[t] = s','Fontsize',18);
ylabel('[f] = Hz','Fontsize',18);
xlim([33 44])
ylim([0 800])
clear data_t
data_t(1,:) = harmMax;

%% MDF (v2)
clc; %clear all; %close all; 

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

%% Time analysis
countF1 = 0;
countF2 = 0;
meanTime = 10;

syms tol
dataMean = 0;
constFreq = 0;
siren = zeros(1,length(data_t(1,:)));

for m = meanTime+1:length(data_t(1,:))
    dataMean = 0;
    for n = 1:meanTime
            dataMean = dataMean + data_t(1,m-n); 
    end
    dataMean = dataMean/meanTime;
    tol = 0.2 * dataMean;
    
    if data_t(1,m) ~= 0
        if (data_t(1,m) >= dataMean - tol) && (data_t(1,m) <= dataMean + tol)
            if constFreq ~= 0
                if (dataMean >= 1.2*constFreq) &&  (dataMean <= 1.4*constFreq)
                    siren(m-10) = 1;
                else if (dataMean <= constFreq/1.2) &&  (dataMean >= constFreq/1.4)
                    siren(m-10) = 1;
                end
                end
            end
            if (dataMean >= 1.25*constFreq) || (dataMean <= constFreq/1.25)
                constFreq = dataMean;
            end
        end
    end
    
    if dataMean < 300
        constFreq = 0;
    end
end

figure(3)
stem(t,siren)

%% Time analysis (v.2)
sizeSlide = 10;
slideTable = zeros(1,sizeSlide);

count = 0;
Freq = 0;
oldFreq = 0;
sirenFlag = 0;
siren = zeros(1,length(data_t(1,:)));

%t = 0:timestep:timeaudio+40*timestep; % Seulement pour FFT

tol = 40; %Hz
time = 0;
sirentime = 0;

for n = 1:length(data_t(1,:))-10
    count = 0;
    for m = 1:10
        slideTable(m) = data_t(1,n+10-m);
        if (slideTable(1) >= slideTable(m) - tol) && (slideTable(1) <= slideTable(m) + tol)
            count = count + 1;
        end
    end
    if count >= 7
        Freq = slideTable(1);
        if sirenFlag && time<25
            if (Freq >= 1.2*oldFreq) &&  (Freq <= 1.4*oldFreq)
                siren(n) = 1;
            elseif (Freq <= oldFreq/1.2) &&  (Freq >= oldFreq/1.4)
                siren(n) = 1;
            elseif (Freq >= oldFreq - tol) && (Freq <= oldFreq + tol)
                siren(n) = 1;
                time = time + 1;
                if(time > 15)
                    oldFreq = Freq;
                    time = 0;
                end
            end
        else 
            sirenFlag = 1;
            oldFreq = Freq;
        end
    end
    if mean(slideTable) < 300
        sirenFlag = 0;
        sirentime = 0;
    end
    if sirenFlag
        sirentime = sirentime + 1;
        if (Freq >= 1.2*oldFreq) &&  (Freq <= 1.4*oldFreq)
                siren(n) = 1;
        elseif (Freq <= oldFreq/1.2) &&  (Freq >= oldFreq/1.4)
            siren(n) = 1;
        end
    end
%     if sirentime > 50
%         for y = 1:50
%             siren(n+y) = 1;
%         end
%     end
end

figure(2)
%figure(4)
ax(2) = subplot(2,1,2)
stem(t,siren)

linkaxes(ax,'x')

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
ax(2) = subplot(2,1,2)
stem(t,siren)
set(gca,'FontSize',12)
ylim([0 1.1]);
xlim([0 90])
xlabel('[t] = s','Fontsize',18);
ylabel('Siren alarm','Fontsize',16);

linkaxes(ax,'x')


