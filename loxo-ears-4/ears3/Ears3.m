%% TB Test
%% FFT

clc; %clear all; close all; 

rootdirectory = 'C:\Users\rolan\Desktop\Arafat\TB\Matlab_et_code_LOXO_Ears_3\loxo-ears-3\Test MATLAB\Sounds';

[dataRL,Fs] = audioread(fullfile(rootdirectory,'Police2.mp3'));

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

%% FFT glissante 

clc; %clear all; close all; 

rootdirectory = 'C:\Users\rolan\Desktop\Arafat\TB\Matlab_et_code_LOXO_Ears_3\loxo-ears-3\Test MATLAB\Sounds';

[dataRL,Fs] = audioread(fullfile(rootdirectory,'Police2.mp3'));
[dataRL2,Fs2] = audioread(fullfile(rootdirectory,'Police2.mp3'));


dataL = dataRL(:,1);
dataR = dataRL(:,1);

timeaudio = length(dataL)/Fs %sec
timestep = 0.05 %taille fenetre
% Calculer le nombre d'échantillons correspondant à 50 millisecondes
samples_to_remove = round(Fs * 35);
% Supprimer les échantillons des 50 premières millisecondes
dataRL2 = dataRL2((samples_to_remove + 1):end, :);
dataL2 = dataRL2(:,1);
dataR2 = dataRL2(:,2);

% Fs = 8000;
% dataL = record;
% dataR = record;

timeaudio2 = length(dataL2)/Fs;
timestep2 = 0.001;

%f = -Fs/2:Fs/length(data):Fs/2-Fs/length(data)

Ncycle = uint32(ceil(timeaudio/timestep));
Ndata_cycle = uint32(length(dataL)/(timeaudio/timestep));

Ncycle2 = uint32(ceil(timeaudio2/timestep2));%Pour 1ms
Ndata_cycle2 = uint32(length(dataL2)/(timeaudio2/timestep2));%Pour 1ms
data_t = zeros(2,Ndata_cycle);
for x=0:1%remplissage fenetre
    for n=1:Ndata_cycle
        if uint32(x)*(Ndata_cycle)+n <= length(dataL)
            data_t(1,n) = dataL(uint32(x)*(Ndata_cycle)+n);
            data_t(2,n) = dataR(uint32(x)*(Ndata_cycle)+n);
%             data_t2(1,n) = dataL(uint32(x)*(Ndata_cycle)+n);
%             data_t2(2,n) = dataR(uint32(x)*(Ndata_cycle)+n);
        end
    end
    %figure(double(x)+1);
    %t = 0:1/Fs:timestep-1/Fs;
    %plot(t,data_t);
    %sound(data_t,Fs)
%    spectre(x+1,:) = abs(fftshift(fft(data_t(1,:)))) + abs(fftshift(fft(data_t(2,:))));
%    data_t = zeros(2,Ndata_cycle);
end
for x=0:Ncycle2-1
    data_t = circshift(data_t, [0, -int32(Ndata_cycle2)]);
%     data_t(1,:)=data_t(1,Ndata_cycle2+1:end);
%     data_t(2,:)=data_t(2,Ndata_cycle2+1:end);
%     data_t(1,end-Ndata_cycle2+1:end) = 0;
    Counter = Ndata_cycle-Ndata_cycle2+1;
    for n=1:Ndata_cycle2
        if uint32(x)*(Ndata_cycle2)+n <= length(dataL2)
            data_t(1,Counter) = dataL2(uint32(x)*(Ndata_cycle2)+n);
            data_t(2,Counter) = dataR2(uint32(x)*(Ndata_cycle2)+n);
            Counter = Counter +1;  
        end
    end
    
    %figure(double(x)+1);
    %t = 0:1/Fs:timestep-1/Fs;
    %plot(t,data_t);
    %sound(data_t,Fs)
    spectre(x+1,:) = abs(fftshift(fft(data_t(1,:)))) + abs(fftshift(fft(data_t(2,:))));
%    data_t = zeros(2,Ndata_cycle);
end
f = -Fs/2:Fs/length(data_t):Fs/2-Fs/length(data_t);

%sound(dataRL, Fs)

freqstep = Fs/length(f);
offset = round(length(f)/2);

Fmin = 300; %multiple de freqstep
Fmax = 725; %multiple de freqstep
harmMax = zeros(1,Ncycle2);
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

stem(f,spectre(Ncycle2/2 + 110,:),'Color',[0 0 0])
xlim([0 0.8]*1e3)
ylim([0 180])
set(gca,'FontSize',12)
xlabel('[f] = Hz','Fontsize',18)
ylabel('[Amplitude]','Fontsize',18)

for u=1:Ncycle2
    for v=Fmin:freqstep:Fmax
        if spectre(u,v/freqstep+offset) > spectre(u,FharmMax/freqstep+offset)
            harmMax(u) = v;
            FharmMax = v;
        end
    end
    FharmMax = Fmin;
end

t = 0:timestep2:timeaudio2;
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
xlim([00 12])
ylim([0 800])
clear data_t
data_t(1,:) = harmMax;


%% MDF (v2)
clc; %clear all; %close all; 

rootdirectory = 'C:\Users\rolan\Desktop\Arafat\TB\Matlab_et_code_LOXO_Ears_3\loxo-ears-3\Test MATLAB\Sounds'
[dataRL,Fs] = audioread(fullfile(rootdirectory,'Police2.mp3'));

%sound(dataRL, Fs)
dataL = dataRL(:,1);
dataR = dataRL(:,2);


% Fs = 8000;
% dataL = record;
% dataR = record;

timeaudio = length(dataL)/Fs; %sec
timestep = 0.05; %sec


%f = -Fs/2:Fs/length(data):Fs/2-Fs/length(data)

Ncycle = uint32(ceil(timeaudio/timestep));
Ndata_cycle = uint32(length(dataL)/(timeaudio/timestep));

%Ncycle2 = uint32(ceil(timeaudio2/timestep2));%Pour 1ms
%Ndata_cycle2 = uint32(length(dataL2)/(timeaudio2/timestep2));%Pour 1ms
 
data_t = zeros(2,Ncycle);

frequencystep = 20;
Fmin = 260; %Hz
Fmax = 800; %Hz

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
%% MDF Moyenne glissante (non fonctionnel pour 1 ms)
clc; %clear all; %close all; 
 
rootdirectory = 'C:\Users\rolan\Desktop\Arafat\TB\Matlab et code LOXO Ears 3\loxo-ears-3\Test MATLAB\Sounds'

[dataRL,Fs] = audioread(fullfile(rootdirectory,'Police2.mp3'));%Pour fenetre
[dataRL2,Fs2] = audioread(fullfile(rootdirectory,'Police2.mp3'));%Pour le reste du signal audio

%sound(dataRL, Fs)
dataL = dataRL(:,1);
dataR = dataRL(:,2);
timeaudio = length(dataL)/Fs; %sec
timestep = 0.05; %time de fenetre

% Calculer le nombre d'échantillons correspondant à 50 millisecondes
samples_to_remove = round(Fs * 0.05);
% Supprimer les échantillons des 50 premières millisecondes
dataRL2 = dataRL2((samples_to_remove + 1):end, :);
dataL2 = dataRL2(:,1);
dataR2 = dataRL2(:,2);

% Fs = 8000;
% dataL = record;
% dataR = record;


timeaudio2 = length(dataL2)/Fs;%time audio sans fenetre
timestep2 = 0.001;

%f = -Fs/2:Fs/length(data):Fs/2-Fs/length(data)

Ncycle = uint32(ceil(timeaudio/timestep));
Ndata_cycle = uint32(length(dataL)/(timeaudio/timestep));

Ncycle2 = uint32(ceil(timeaudio2/timestep2));%Pour 1ms
Ndata_cycle2 = uint32(length(dataL2)/(timeaudio2/timestep2));%Pour 1ms


 
data_t = zeros(2,Ncycle2);
%data_t = zeros(2,Ncycle);

frequencystep = 20;
Fmin = 420; %Hz
Fmax = 740; %Hz

freqTable = Fmin:frequencystep:Fmax;
% TableauR = zeros(Ndata_cycle,length(freqTable)); % Crée une matrice freqtablexNdatacycle remplie de zéros.
% TableauL = zeros(Ndata_cycle,length(freqTable)); % Crée une matrice freqtablexNdatacycle remplie de zéros.
% TableauR2 = zeros(Ndata_cycle2,length(freqTable)); % Crée une matrice freqtablexNdatacycle remplie de zéros.
% TableauL2 = zeros(Ndata_cycle2,length(freqTable)); % Crée une matrice freqtablexNdatacycle remplie de zéros.
Dm = zeros(2,length(freqTable));
A=Ndata_cycle/Ndata_cycle2;%Nombre de partie dans la fenetre
BufferR = zeros(A,length(freqTable));
BufferL = zeros(A,length(freqTable));
for x=1:1%remplissage fenetre
    for lag=Fmin:frequencystep:Fmax
        sumR = 0;
        sumL = 0;
        sumR2 = 0;
        sumL2 = 0;
        Buffercount = 1;
        Buffercount2 = 1;
        offset = uint32(Fs/lag);
        for n=1:Ndata_cycle
            if offset < n && uint32(x-1)*(Ndata_cycle)+n < length(dataR)
                sumR = sumR + abs(dataR(uint32(x-1)*(Ndata_cycle)+n) - dataR(uint32(x-1)*(Ndata_cycle)+n-offset));
                sumL = sumL + abs(dataL(uint32(x-1)*(Ndata_cycle)+n) - dataL(uint32(x-1)*(Ndata_cycle)+n-offset));
                sumR2 = sumR2 + abs(dataR(uint32(x-1)*(Ndata_cycle)+n) - dataR(uint32(x-1)*(Ndata_cycle)+n-offset));%somme pour chaque partie de la fenetre
                sumL2 = sumL2 + abs(dataL(uint32(x-1)*(Ndata_cycle)+n) - dataL(uint32(x-1)*(Ndata_cycle)+n-offset));%
                if Buffercount == Ndata_cycle2 
                    BufferR(Buffercount2,(lag - Fmin)/frequencystep + 1)= sumR2;%contiendra les valeurs à soustraire
                    BufferL(Buffercount2,(lag - Fmin)/frequencystep + 1)= sumL2;%
                    SumR2 = 0;
                    SumL2 = 0;
                    Buffercount2 = Buffercount2 +1;
                    Buffercount =0;
                end    
                Buffercount = Buffercount+1;
            end
        end
        Dm(1,(lag - Fmin)/frequencystep + 1) = sumR;
        Dm(2,(lag - Fmin)/frequencystep + 1) = sumL;
    end
    
%     lag=Fmin:frequencystep:Fmax;
%     l = 1./lag;
%     if x == Ncycle/2 + 110 
%         figure(10)
%         subplot(2,1,1)
%         stem(l*1000,Dm(1,:),'Color',[0 0 0])
%         set(gca,'FontSize',12)
%         xlabel('[lag] = ms','Fontsize',18)
%         ylabel('[MDF(lag)]','Fontsize',18)
%         
%         subplot(2,1,2)
%         stem(lag,Dm(1,:),'Color',[0 0 0])
%         set(gca,'FontSize',12)
%         xlabel('[f] = Hz','Fontsize',18)
%         ylabel('[MDF(1/f)]','Fontsize',18)
%     end
%     
%     Amin(1) = Fmin;
%     Amin(2) = Fmin;
%     
%     for v=Fmin:frequencystep:Fmax
%         if Dm(1,(Amin(1) - Fmin)/frequencystep + 1) > Dm(1,(v - Fmin)/frequencystep + 1)
%             Amin(1) = v;
%         end
%         if Dm(2,(Amin(2) - Fmin)/frequencystep + 1) > Dm(2,(v - Fmin)/frequencystep + 1)
%             Amin(2) = v;
%         end
%     end
%     
%     if abs(Amin(1) - Amin(2)) <= 40 && Amin(1) <= 720 && Amin(1) >= 320
%         data_t(1,x) = Amin(1);
%         data_t(2,x) = Amin(2);
%     else
%         data_t(1,x) = 0;
%         data_t(2,x) = 0;
%     end
end
Buffercount3 = 0;
for x=1:Ncycle2
        if Buffercount3 == A
            Buffercount3 = 0;
        end
        
  Buffercount3 = Buffercount3 +1;
    for lag=Fmin:frequencystep:Fmax
        sumR = 0;
        sumL = 0;
        sumR2 = 0;
        sumL2 = 0;
        offset = uint32(Fs/lag);
        for n=1:Ndata_cycle2
            if offset < n && uint32(x-1)*(Ndata_cycle2)+n < length(dataR2)
                sumR = sumR + abs(dataR2(uint32(x-1)*(Ndata_cycle2)+n) - dataR2(uint32(x-1)*(Ndata_cycle2)+n-offset));
                sumL = sumL + abs(dataL2(uint32(x-1)*(Ndata_cycle2)+n) - dataL2(uint32(x-1)*(Ndata_cycle2)+n-offset));
            end
        end
        Dm(1,(lag - Fmin)/frequencystep + 1) =  (Dm(1,(lag - Fmin)/frequencystep + 1)+ sumR - (BufferR(Buffercount3,(lag - Fmin)/frequencystep + 1)));%soustrait la premiere partie et ajoute la nouvelle
        Dm(2,(lag - Fmin)/frequencystep + 1) =  (Dm(2,(lag - Fmin)/frequencystep + 1)+ sumL - (BufferL(Buffercount3,(lag - Fmin)/frequencystep + 1)));
        BufferR(Buffercount3,(lag - Fmin)/frequencystep + 1) = sumR;%Remplace la partie soustraite par la nouvel
        BufferL(Buffercount3,(lag - Fmin)/frequencystep + 1) = sumL;%idem

    end
    
    lag=Fmin:frequencystep:Fmax;
    l = 1./lag;
    if x == Ncycle2/2 + 110 
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


t = 0:timestep2:timeaudio2;
figure(2)
hold off
ax(1) = subplot(2,1,1);
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
%% MDF Moyenne glissante (v2 Finale)

clc; %clear all; %close all; 
 
rootdirectory = 'C:\Users\rolan\Desktop\Arafat\TB\Matlab_et_code_LOXO_Ears_3\loxo-ears-3\Test MATLAB\Sounds'

[dataRL,Fs] = audioread(fullfile(rootdirectory,'Police2.mp3'));%pour la fenetre
[dataRL2,Fs2] = audioread(fullfile(rootdirectory,'Police2.mp3'));%pour le reste du signal audio

%sound(dataRL, Fs)
dataL = dataRL(:,1);
dataR = dataRL(:,2);
timeaudio = length(dataL)/Fs; %sec
timestep = 0.05; %taille de la fenetre

% Calculer le nombre d'échantillons correspondant à 50 millisecondes
samples_to_remove = round(Fs * 0.05);
% Supprimer les échantillons des 50 premières millisecondes
dataRL2 = dataRL2((samples_to_remove + 1):end, :);
dataL2 = dataRL2(:,1);
dataR2 = dataRL2(:,2);

% Fs = 8000;
% dataL = record;
% dataR = record;


timeaudio2 = length(dataL2)/Fs;%audio sans la partie de la fenetre
timestep2 = 0.001;

%f = -Fs/2:Fs/length(data):Fs/2-Fs/length(data)

Ncycle = uint32(ceil(timeaudio/timestep));
Ndata_cycle = uint32(length(dataL)/(timeaudio/timestep));

Ncycle2 = uint32(ceil(timeaudio2/timestep2));%Pour 1ms
Ndata_cycle2 = uint32(length(dataL2)/(timeaudio2/timestep2));%Pour 1ms


 
data_t = zeros(2,Ncycle2);
%data_t = zeros(2,Ncycle);

frequencystep = 20;
Fmin = 200; %Hz
Fmax = 800; %Hz

freqTable = Fmin:frequencystep:Fmax;
% TableauR = zeros(Ndata_cycle,length(freqTable)); % Crée une matrice freqtablexNdatacycle remplie de zéros.
% TableauL = zeros(Ndata_cycle,length(freqTable)); % Crée une matrice freqtablexNdatacycle remplie de zéros.
% TableauR2 = zeros(Ndata_cycle2,length(freqTable)); % Crée une matrice freqtablexNdatacycle remplie de zéros.
% TableauL2 = zeros(Ndata_cycle2,length(freqTable)); % Crée une matrice freqtablexNdatacycle remplie de zéros.
Dm = zeros(2,length(freqTable));
TableauR = zeros(length(freqTable),Ndata_cycle);
TableauL = zeros(length(freqTable),Ndata_cycle);
Buffercount2 = 1;
for x=1:1
    for lag=Fmin:frequencystep:Fmax
        offset = uint32(Fs/lag);
        for n=1:Ndata_cycle
            if offset < n && uint32(x-1)*(Ndata_cycle)+n < length(dataR)
                TableauR((lag - Fmin)/frequencystep + 1,n) = abs(dataR(uint32(x-1)*(Ndata_cycle)+n) - dataR(uint32(x-1)*(Ndata_cycle)+n-offset));%rempli le tableau pour chaque Ndata_cycle de la fenetre
                TableauL((lag - Fmin)/frequencystep + 1,n) = abs(dataL(uint32(x-1)*(Ndata_cycle)+n) - dataL(uint32(x-1)*(Ndata_cycle)+n-offset));
            end    
        end
            Dm(1,(lag - Fmin)/frequencystep + 1) = sum(TableauR(((lag - Fmin)/frequencystep + 1),:));%fais la somme de la ligne et l'ajoute
            Dm(2,(lag - Fmin)/frequencystep + 1) = sum(TableauL(((lag - Fmin)/frequencystep + 1),:));
    end
end
    
%     lag=Fmin:frequencystep:Fmax;
%     l = 1./lag;
%     if x == Ncycle/2 + 110 
%         figure(10)
%         subplot(2,1,1)
%         stem(l*1000,Dm(1,:),'Color',[0 0 0])
%         set(gca,'FontSize',12)
%         xlabel('[lag] = ms','Fontsize',18)
%         ylabel('[MDF(lag)]','Fontsize',18)
%         
%         subplot(2,1,2)
%         stem(lag,Dm(1,:),'Color',[0 0 0])
%         set(gca,'FontSize',12)
%         xlabel('[f] = Hz','Fontsize',18)
%         ylabel('[MDF(1/f)]','Fontsize',18)
%     end
%     
%     Amin(1) = Fmin;
%     Amin(2) = Fmin;
%     
%     for v=Fmin:frequencystep:Fmax
%         if Dm(1,(Amin(1) - Fmin)/frequencystep + 1) > Dm(1,(v - Fmin)/frequencystep + 1)
%             Amin(1) = v;
%         end
%         if Dm(2,(Amin(2) - Fmin)/frequencystep + 1) > Dm(2,(v - Fmin)/frequencystep + 1)
%             Amin(2) = v;
%         end
%     end
%     
%     if abs(Amin(1) - Amin(2)) <= 40 && Amin(1) <= 720 && Amin(1) >= 320
%         data_t(1,x) = Amin(1);
%         data_t(2,x) = Amin(2);
%     else
%         data_t(1,x) = 0;
%         data_t(2,x) = 0;
%     end
Counter=1;
Counter2 = 0;
for x=1:Ncycle2
    for lag=Fmin:frequencystep:Fmax
        offset = uint32(Fs/lag);
        if lag == Fmin
           Counter2 = Counter;% si nouveau cycle
        else 
           Counter = Counter2;%Si meme cycle mais differente frequence
        end    
        for n=1:Ndata_cycle2
            if uint32(x-1)*(Ndata_cycle2)+n-offset > 0
               TableauR((lag - Fmin)/frequencystep + 1,Counter)= abs(dataR2(uint32(x-1)*(Ndata_cycle2)+n) - dataR2(uint32(x-1)*(Ndata_cycle2)+n-offset));%remplace les valeur dans le tableau pour chaque cycle de 1 ms
               TableauL((lag - Fmin)/frequencystep + 1,Counter)= abs(dataL2(uint32(x-1)*(Ndata_cycle2)+n) - dataL2(uint32(x-1)*(Ndata_cycle2)+n-offset));
               Counter = Counter +1;%pour parcourir toutes les valeurs
               if Counter == Ndata_cycle + 1
                  Counter = 1;
               end 
            end
        end
        Dm(1,(lag - Fmin)/frequencystep + 1) =  sum(TableauR(((lag - Fmin)/frequencystep + 1),:));
        Dm(2,(lag - Fmin)/frequencystep + 1) =  sum(TableauL(((lag - Fmin)/frequencystep + 1),:));
    end
    
    lag=Fmin:frequencystep:Fmax;
    l = 1./lag;
    if x == Ncycle2/2 + 110 
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


t = 0:timestep2:timeaudio2;
figure(2)
hold off
ax(1) = subplot(2,1,1);
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
xlim([00 10])
xlabel('[t] = s','Fontsize',18);
ylabel('[f] = Hz','Fontsize',18);
%% TDOA detection de la direction d'arrivée du son
% Paramètres
distance = 3; % Distance entre les micros en mètres
speedOfSound = 343; % Vitesse du son en m/s
numSamples = 10; % Nombre d'échantillons aléatoires

% Génération de différences de temps aléatoires
maxTimeDiff = distance / speedOfSound; % Différence de temps maximale
timeDiffs = (2 * rand(numSamples, 1) - 1) * maxTimeDiff;%genere des temps entre -timediff et + timediffs

% Calcul du TDOA
tdoa = timeDiffs * speedOfSound;

% Détection de devant ou derrière
direction(tdoa >= 0) = 1; % La détection vient de l'avant (1)
direction(tdoa < 0) = -1; % La détection vient de l'arrière (-1)

% Affichage des résultats
disp('Temps d''arrivée (en secondes):');
disp(timeDiffs);
disp('TDOA (en mètres):');
disp(tdoa);

% Plot
figure;
scatter(1:numSamples, direction, 'filled');
ylim([-1.5, 1.5]);
xlim([0.5, numSamples+0.5]);
xticks(1:numSamples);
xticklabels(1:numSamples);
xlabel('Échantillon');
ylabel('Détection');
title('Détection de devant (1) ou derrière (-1)');
%% Detection de l'angle d'arrivée du son 
% Paramètres
distance = 3; % Distance entre les micros en mètres
speedOfSound = 343; % Vitesse du son en m/s
numSamples = 10; % Nombre d'échantillons aléatoires

% Génération de différences de temps aléatoires
maxTimeDiff = distance / speedOfSound; % Différence de temps maximale
timeDiffs = (2 * rand(numSamples, 1) - 1) * maxTimeDiff;

% Calcul du TDOA
tdoa = timeDiffs * speedOfSound;

% Calcul de la direction de détection
direction = zeros(numSamples, 1);
direction(tdoa >= 0) = 1; % La détection vient de l'avant (1)
direction(tdoa < 0) = -1; % La détection vient de l'arrière (-1)

% Calcul de l'angle
angle = acos(abs(tdoa) / distance); % Angle en radians

% Conversion de l'angle en degrés
angleDeg = rad2deg(angle);

% Affichage des résultats
disp('Temps d''arrivée (en secondes):');
disp(timeDiffs);
disp('TDOA (en mètres):');
disp(tdoa);
disp('Direction de détection (avant: 1, arrière: -1):');
disp(direction);
disp('Angle (en degrés):');
disp(angleDeg);

% Plot de la direction
figure;
scatter(1:numSamples, direction, 'filled');
ylim([-1.5, 1.5]);
xlim([0.5, numSamples+0.5]);
xticks(1:numSamples);
xticklabels(1:numSamples);
xlabel('Échantillon');
ylabel('Direction');
title('Direction de détection (avant: 1, arrière: -1)');

% Plot de l'angle
figure;
scatter(1:numSamples, angleDeg, 'filled');
ylim([-90, 90]);
xlim([0.5, numSamples+0.5]);
xticks(1:numSamples);
xticklabels(1:numSamples);
xlabel('Échantillon');
ylabel('Angle (degrés)');
title('Angle de détection');
%% Test pour datasets 2 micros avec MDF LOXO Ears 2
clc; %clear all; %close all; 

rootdirectory = 'C:\Users\rolan\Desktop\Arafat\TB\Matlab et code LOXO Ears 3\loxo-ears-3\Test MATLAB\Sounds'
[dataRL,Fs] = audioread(fullfile(rootdirectory,'RecorderFrontDecSansBruit.wav'));%Premier canal devant par exemple
[dataRL2,Fs2] = audioread(fullfile(rootdirectory,'RecorderBackDecSansBruit.wav'));%2ème canal derrière par exemple

%Premier canal
dataL = dataRL(:,1);
dataR = dataRL(:,2);


% 2ème canal 
dataL2 = dataRL2(:,1);
dataR2 = dataRL2(:,2);



% Fs = 8000;
% dataL = record;
% dataR = record;
DetectDevant = 0;
DetectDerriere = 0;

timeaudio = length(dataL)/Fs; %sec
timestep = 0.003; %sec

timeaudio2 = length(dataL2)/Fs;
timestep2 = 0.003;




%f = -Fs/2:Fs/length(data):Fs/2-Fs/length(data)

Ncycle = uint32(ceil(timeaudio/timestep));%premier canal 
Ndata_cycle = uint32(length(dataL)/(timeaudio/timestep));

Ncycle2 = uint32(ceil(timeaudio2/timestep2));%2eme canal
Ndata_cycle2 = uint32(length(dataL2)/(timeaudio2/timestep2));
 
data_t = zeros(2,Ncycle);

frequencystep = 20;
Fmin = 350; %Hz
Fmax = 3000; %Hz

Counter = 1;
freqTable = Fmin:frequencystep:Fmax;
Dm = zeros(4,length(freqTable));  
for x=1:Ncycle
    for lag=Fmin:frequencystep:Fmax
        sumR = 0;
        sumL = 0;
        sumR2 = 0;
        sumL2 = 0;
        offset = uint32(Fs/lag);
        for n=1:Ndata_cycle
            if offset < n && uint32(x-1)*(Ndata_cycle)+n < length(dataR)
                sumR = sumR + abs(dataR(uint32(x-1)*(Ndata_cycle)+n) - dataR(uint32(x-1)*(Ndata_cycle)+n-offset));
                sumL = sumL + abs(dataL(uint32(x-1)*(Ndata_cycle)+n) - dataL(uint32(x-1)*(Ndata_cycle)+n-offset));
            end
            
        end
        for n=1:Ndata_cycle2
            if offset < n && uint32(x-1)*(Ndata_cycle2)+n < length(dataR2)
                sumR2 = sumR2 + abs(dataR2(uint32(x-1)*(Ndata_cycle2)+n) - dataR2(uint32(x-1)*(Ndata_cycle2)+n-offset));
                sumL2 = sumL2 + abs(dataL2(uint32(x-1)*(Ndata_cycle2)+n) - dataL2(uint32(x-1)*(Ndata_cycle2)+n-offset));
            end
            
        end
        Dm(1,(lag - Fmin)/frequencystep + 1) = sumR;
        Dm(2,(lag - Fmin)/frequencystep + 1) = sumL;
        Dm(3,(lag - Fmin)/frequencystep + 1) = sumR2;
        Dm(4,(lag - Fmin)/frequencystep + 1) = sumL2;
    end
    

    Amin(1) = Fmin;
    Amin(2) = Fmin;
    Amin(3) = Fmin;
    Amin(4) = Fmin;
    
    for v=Fmin:frequencystep:Fmax
        if Dm(1,(Amin(1) - Fmin)/frequencystep + 1) > Dm(1,(v - Fmin)/frequencystep + 1)
            Amin(1) = v;
        end
        if Dm(2,(Amin(2) - Fmin)/frequencystep + 1) > Dm(2,(v - Fmin)/frequencystep + 1)
            Amin(2) = v;
        end
        if Dm(3,(Amin(3) - Fmin)/frequencystep + 1) > Dm(3,(v - Fmin)/frequencystep + 1)
            Amin(3) = v;
        end
        if Dm(4,(Amin(4) - Fmin)/frequencystep + 1) > Dm(4,(v - Fmin)/frequencystep + 1)
            Amin(4) = v;
        end
    end
    if DetectDevant < 1
    if abs(Amin(1) - Amin(2)) <= 40 && Amin(1) <= 720 && Amin(1) >= 320
        time = Counter*timestep;
        fprintf('détecté devant à: %.3f\n', time);
        DetectDevant = 1;
    end
    end
    
    if DetectDerriere < 1
    if abs(Amin(3) - Amin(4)) <= 40 && Amin(3) <= 720 && Amin(3) >= 320
        time = Counter*timestep;
        fprintf('détecté dérrière à: %.3f\n', time);
        DetectDerriere = 1;
    end
    end
    Counter = Counter + 1;
end
% t = 0:timestep:timeaudio;
% figure(2)
% hold off
% ax(1) = subplot(2,1,1)
% stem(t,data_t(1,:));
% set(gca,'FontSize',12)
% ylim([0 800]);
% xlim([0 106])
% xlabel('[t] = s','Fontsize',18);
% ylabel('[f] = Hz','Fontsize',18);
% 
% figure(3)
% hold off
% %ax(2) = subplot(2,1,1)
% stem(t,data_t(1,:));
% set(gca,'FontSize',12)
% ylim([0 800]);
% xlim([33 44])
% xlabel('[t] = s','Fontsize',18);
% ylabel('[f] = Hz','Fontsize',18);


%% tests 
% Déclaration des variables
variableDecimale = 3.14;
variableEntiere = 2;

% Multiplication
resultat = variableDecimale * variableEntiere;

% Affichage du résultat
disp(resultat);
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
%%
% Charger le fichier audio
filename = 'C:\Users\rolan\Desktop\Arafat\TB\LOXO Ears 2\loxears2-main-Test MATLAB\Test MATLAB\Sounds'; % Remplacez par le chemin de votre fichier audio
[data, Fs] = audioread(fullfile(filename,'Police.mp3'));
% Obtenir la durée du signal audio en secondes
duration = length(data) / Fs;


% Effectuer la transformation de Fourier
NFFT = 2^nextpow2(length(data));
Y = fft(data, NFFT) / length(data);
f = Fs/2*linspace(0, 1, NFFT/2+1);

% Afficher le spectrogramme
figure;

% Axes pour le signal temporel
subplot(2,1,1);
t = linspace(0, duration, length(data));
plot(t, data, '.');
xlabel('Temps (s)');
ylabel('Amplitude');
title('Signal audio dans le domaine temporel');

% Axes pour le spectrogramme
subplot(2,1,2);
[f_grid, t_grid] = meshgrid(f, t);
scatter(t_grid(:), f_grid(:), 10, 20*log10(abs(Y(:))), 'filled');
set(gca, 'YDir', 'normal');
xlabel('Temps (s)');
ylabel('Fréquence (Hz)');
title('Analyse fréquentielle du signal audio');
colormap jet;
colorbar;

% Ajuster les espacements entre les sous-graphiques
subplot(2,1,1);
ax1 = gca;
ax1.Position(4) = ax1.Position(4) * 0.8;

% Ajuster les espacements entre les sous-graphiques
subplot(2,1,2);
ax2 = gca;
ax2.Position(2) = ax2.Position(2) * 1.2;

% Redimensionner la figure
set(gcf, 'Position', [100, 100, 800, 600]);



%% MDF Moyenne glissante test 2 micros

clc; %clear all; %close all; 
 
rootdirectory = 'C:\Users\rolan\Desktop\Arafat\TB\Matlab_et_code_LOXO_Ears_3\loxo-ears-3\Test MATLAB\Sounds'

[dataRL,Fs] = audioread(fullfile(rootdirectory,'RecorderFrontDecSansBruit.mp3'));%pour la fenetre
[dataRL2,Fs2] = audioread(fullfile(rootdirectory,'RecorderFrontDecSansBruit.mp3'));%pour le reste du signal audio

[dataRL3,Fs] = audioread(fullfile(rootdirectory,'RecorderBackDecSansBruit.mp3'));%pour la fenetre
[dataRL4,Fs2] = audioread(fullfile(rootdirectory,'RecorderBackDecSansBruit.mp3'));%pour le reste du signal audio



%sound(dataRL, Fs)
dataL = dataRL(:,1);
dataR = dataRL(:,2);
dataL3 = dataRL3(:,1);
dataR3 = dataRL3(:,2);
timeaudio = length(dataL)/Fs; %sec
timestep = 0.05; %taille de la fenetre
timeaudio3 = length(dataL3)/Fs; %sec
timestep3 = 0.05; %taille de la fenetre


% Calculer le nombre d'échantillons correspondant à 50 millisecondes
samples_to_remove = round(Fs * 0.05);
% Supprimer les échantillons des 50 premières millisecondes
dataRL2 = dataRL2((samples_to_remove + 1):end, :);
dataL2 = dataRL2(:,1);
dataR2 = dataRL2(:,2);

% Calculer le nombre d'échantillons correspondant à 50 millisecondes
samples_to_remove2 = round(Fs * 0.05);
% Supprimer les échantillons des 50 premières millisecondes
dataRL4 = dataRL4((samples_to_remove2 + 1):end, :);
dataL4 = dataRL4(:,1);
dataR4 = dataRL4(:,2);

% Fs = 8000;
% dataL = record;
% dataR = record;


timeaudio2 = length(dataL2)/Fs;%audio sans la partie de la fenetre
timestep2 = 0.001;
timeaudio4 = length(dataL4)/Fs;%audio sans la partie de la fenetre
timestep4 = 0.001;

%f = -Fs/2:Fs/length(data):Fs/2-Fs/length(data)

Ncycle = uint32(ceil(timeaudio/timestep));
Ndata_cycle = uint32(length(dataL)/(timeaudio/timestep));

Ncycle2 = uint32(ceil(timeaudio2/timestep2));%Pour 1ms
Ndata_cycle2 = uint32(length(dataL2)/(timeaudio2/timestep2));%Pour 1ms

Ncycle3 = uint32(ceil(timeaudio3/timestep3));
Ndata_cycle3 = uint32(length(dataL3)/(timeaudio3/timestep3));

Ncycle4 = uint32(ceil(timeaudio4/timestep4));%Pour 1ms
Ndata_cycle4 = uint32(length(dataL4)/(timeaudio4/timestep4));%Pour 1ms


 
data_t = zeros(2,Ncycle2);
data_t2 = zeros(2,Ncycle4);
%data_t = zeros(2,Ncycle);

frequencystep = 20;
Fmin = 200; %Hz
Fmax = 800; %Hz

freqTable = Fmin:frequencystep:Fmax;

Dm = zeros(4,length(freqTable));
TableauR = zeros(length(freqTable),Ndata_cycle);
TableauL = zeros(length(freqTable),Ndata_cycle);
TableauR2 = zeros(length(freqTable),Ndata_cycle3);
TableauL2 = zeros(length(freqTable),Ndata_cycle3);
DetectDevant = 0;
DetectDerriere = 0;
for x=1:1
    for lag=Fmin:frequencystep:Fmax
        offset = uint32(Fs/lag);
        for n=1:Ndata_cycle
            if offset < n && uint32(x-1)*(Ndata_cycle)+n < length(dataR)
                TableauR((lag - Fmin)/frequencystep + 1,n) = abs(dataR(uint32(x-1)*(Ndata_cycle)+n) - dataR(uint32(x-1)*(Ndata_cycle)+n-offset));%rempli le tableau pour chaque Ndata_cycle de la fenetre
                TableauL((lag - Fmin)/frequencystep + 1,n) = abs(dataL(uint32(x-1)*(Ndata_cycle)+n) - dataL(uint32(x-1)*(Ndata_cycle)+n-offset));
            end   
        end    
        for n2=1:Ndata_cycle3
            if offset < n2 && uint32(x-1)*(Ndata_cycle3)+n2 < length(dataR3)
                TableauR2((lag - Fmin)/frequencystep + 1,n2) = abs(dataR3(uint32(x-1)*(Ndata_cycle3)+n2) - dataR3(uint32(x-1)*(Ndata_cycle3)+n2-offset));%rempli le tableau pour chaque Ndata_cycle de la fenetre
                TableauL2((lag - Fmin)/frequencystep + 1,n2) = abs(dataL3(uint32(x-1)*(Ndata_cycle3)+n2) - dataL3(uint32(x-1)*(Ndata_cycle3)+n2-offset));
            end    
        end
            Dm(1,(lag - Fmin)/frequencystep + 1) = sum(TableauR(((lag - Fmin)/frequencystep + 1),:));%fais la somme de la ligne et l'ajoute
            Dm(2,(lag - Fmin)/frequencystep + 1) = sum(TableauL(((lag - Fmin)/frequencystep + 1),:));
            Dm(3,(lag - Fmin)/frequencystep + 1) = sum(TableauR2(((lag - Fmin)/frequencystep + 1),:));%fais la somme de la ligne et l'ajoute
            Dm(4,(lag - Fmin)/frequencystep + 1) = sum(TableauL2(((lag - Fmin)/frequencystep + 1),:));
    end
end

    
%     lag=Fmin:frequencystep:Fmax;
%     l = 1./lag;
%     if x == Ncycle/2 + 110 
%         figure(10)
%         subplot(2,1,1)
%         stem(l*1000,Dm(1,:),'Color',[0 0 0])
%         set(gca,'FontSize',12)
%         xlabel('[lag] = ms','Fontsize',18)
%         ylabel('[MDF(lag)]','Fontsize',18)
%         
%         subplot(2,1,2)
%         stem(lag,Dm(1,:),'Color',[0 0 0])
%         set(gca,'FontSize',12)
%         xlabel('[f] = Hz','Fontsize',18)
%         ylabel('[MDF(1/f)]','Fontsize',18)
%     end
%     
%     Amin(1) = Fmin;
%     Amin(2) = Fmin;
%     
%     for v=Fmin:frequencystep:Fmax
%         if Dm(1,(Amin(1) - Fmin)/frequencystep + 1) > Dm(1,(v - Fmin)/frequencystep + 1)
%             Amin(1) = v;
%         end
%         if Dm(2,(Amin(2) - Fmin)/frequencystep + 1) > Dm(2,(v - Fmin)/frequencystep + 1)
%             Amin(2) = v;
%         end
%     end
%     
%     if abs(Amin(1) - Amin(2)) <= 40 && Amin(1) <= 720 && Amin(1) >= 320
%         data_t(1,x) = Amin(1);
%         data_t(2,x) = Amin(2);
%     else
%         data_t(1,x) = 0;
%         data_t(2,x) = 0;
%     end
Counter=1;
Counter2 = 0;
Counter3 = 0;
for x=1:Ncycle2
    for lag=Fmin:frequencystep:Fmax
        offset = uint32(Fs/lag);
        if lag == Fmin
           Counter2 = Counter;% si nouveau cycle
        else 
           Counter = Counter2;%Si meme cycle mais differente frequence
        end    
        for n=1:Ndata_cycle2
            if uint32(x-1)*(Ndata_cycle2)+n-offset > 0
               TableauR((lag - Fmin)/frequencystep + 1,Counter)= abs(dataR2(uint32(x-1)*(Ndata_cycle2)+n) - dataR2(uint32(x-1)*(Ndata_cycle2)+n-offset));%remplace les valeur dans le tableau pour chaque cycle de 1 ms
               TableauL((lag - Fmin)/frequencystep + 1,Counter)= abs(dataL2(uint32(x-1)*(Ndata_cycle2)+n) - dataL2(uint32(x-1)*(Ndata_cycle2)+n-offset));
               Counter = Counter +1;%pour parcourir toutes les valeurs
               if Counter == Ndata_cycle + 1
                  Counter = 1;
               end 
            end
        end
        Dm(1,(lag - Fmin)/frequencystep + 1) =  sum(TableauR(((lag - Fmin)/frequencystep + 1),:));
        Dm(2,(lag - Fmin)/frequencystep + 1) =  sum(TableauL(((lag - Fmin)/frequencystep + 1),:));
    end
    
    lag=Fmin:frequencystep:Fmax;
    l = 1./lag;
    if x == Ncycle2/2 + 110 
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
    if DetectDevant < 1
    if abs(Amin(1) - Amin(2)) <= 40 && Amin(1) <= 720 && Amin(1) >= 320
        time = Counter3*timestep2;
        fprintf('détecté devant à: %.3f\n', time);
        DetectDevant = 1;
    end
    end
    Counter3 = Counter3+1;
    
end

Counter4 = 1;
Counter5 = 0;
Counter6 = 0;
for x=1:Ncycle4
    for lag=Fmin:frequencystep:Fmax
        offset = uint32(Fs/lag);
        if lag == Fmin
           Counter5 = Counter4;% si nouveau cycle
        else 
           Counter4 = Counter5;%Si meme cycle mais differente frequence
        end    
        for n=1:Ndata_cycle4
            if uint32(x-1)*(Ndata_cycle4)+n-offset > 0
               TableauR2((lag - Fmin)/frequencystep + 1,Counter4)= abs(dataR4(uint32(x-1)*(Ndata_cycle4)+n) - dataR4(uint32(x-1)*(Ndata_cycle4)+n-offset));%remplace les valeur dans le tableau pour chaque cycle de 1 ms
               TableauL2((lag - Fmin)/frequencystep + 1,Counter4)= abs(dataL4(uint32(x-1)*(Ndata_cycle4)+n) - dataL4(uint32(x-1)*(Ndata_cycle4)+n-offset));
               Counter4 = Counter4 +1;%pour parcourir toutes les valeurs
               if Counter4 == Ndata_cycle3 + 1
                  Counter4 = 1;
               end 
            end
        end
        Dm(3,(lag - Fmin)/frequencystep + 1) =  sum(TableauR2(((lag - Fmin)/frequencystep + 1),:));
        Dm(4,(lag - Fmin)/frequencystep + 1) =  sum(TableauL2(((lag - Fmin)/frequencystep + 1),:));
    end
    
%     lag=Fmin:frequencystep:Fmax;
%     l = 1./lag;
%     if x == Ncycle2/2 + 110 
%         figure(10)
%         subplot(2,1,1)
%         stem(l*1000,Dm(1,:),'Color',[0 0 0])
%         set(gca,'FontSize',12)
%         xlabel('[lag] = ms','Fontsize',18)
%         ylabel('[MDF(lag)]','Fontsize',18)
%         
%         subplot(2,1,2)
%         stem(lag,Dm(1,:),'Color',[0 0 0])
%         set(gca,'FontSize',12)
%         xlabel('[f] = Hz','Fontsize',18)
%         ylabel('[MDF(1/f)]','Fontsize',18)
%     end
    
    Amin(3) = Fmin;
    Amin(4) = Fmin;
    
    for v=Fmin:frequencystep:Fmax
        if Dm(3,(Amin(3) - Fmin)/frequencystep + 1) > Dm(3,(v - Fmin)/frequencystep + 1)
            Amin(3) = v;
        end
        if Dm(4,(Amin(4) - Fmin)/frequencystep + 1) > Dm(4,(v - Fmin)/frequencystep + 1)
            Amin(4) = v;
        end
    end
    
    if abs(Amin(3) - Amin(4)) <= 40 && Amin(3) <= 720 && Amin(3) >= 320
        data_t2(1,x) = Amin(3);
        data_t2(2,x) = Amin(4);
        
    else
        data_t2(1,x) = 0;
        data_t2(2,x) = 0;
    end
    if DetectDerriere < 1
    if abs(Amin(3) - Amin(4)) <= 40 && Amin(3) <= 720 && Amin(3) >= 320
        time = Counter6*timestep2;
        fprintf('détecté derriere à: %.3f\n', time);
        DetectDerriere = 1;
    end
    end
    Counter6 = Counter6+1;
end


t = 0.001:timestep2:timeaudio2;
figure(2)
hold off
ax(1) = subplot(2,1,1);
stem(t,data_t(1,:));
set(gca,'FontSize',12)
ylim([0 800]);
xlim([0 106])
xlabel('[t] = s','Fontsize',18);
ylabel('[f] = Hz','Fontsize',18);

figure(3)
hold off
title('Microphone avant');
%ax(2) = subplot(2,1,1)
stem(t,data_t(1,:));
set(gca,'FontSize',12)
ylim([0 800]);
xlim([00 10])
xlabel('[t] = s','Fontsize',18);
ylabel('[f] = Hz','Fontsize',18);
title('Microphone avant');

t2 = 0.001:timestep4:timeaudio4;
figure(4)
hold off
%ax(2) = subplot(2,1,1)
stem(t2,data_t2(1,:));
set(gca,'FontSize',12)
ylim([0 800]);
xlim([00 10])
xlabel('[t] = s','Fontsize',18);
ylabel('[f] = Hz','Fontsize',18);
title('Microphone arrière');
%% Algo pour calcul d'angle 4 microphones 

Times = zeros(1, 4); % Tableau contenant les temps de détection sur les 4 microphones
%Prenons le micro 1 devant gauche, micro 2 devant droite, micro 3 derrière
%gauche et micro 4 derrière droite

%Pour tester mettons des valeurs calculer pour un angle de 50° entre micro
%3 et 1 pour une déctection sur le micro 2
Times(1,2) = 0.010;
Times(1,1) = 0.012;
Times(1,3) = 0.0176;
Times(1,4) = 0.0154;

[smallestime, ClosestMic] =  min(Times(1,:));
%trouver le premier micro qui a detecte

if ClosestMic == 1
   TDOA1 = Times(1,4)-Times(1,2);%TDOA entre micro 4 et 2
   TDOA2 = Times(1,4)-Times(1,3);%TDOA entre micro 4 et 3
   Angle1 = acos((TDOA1 * 343)/3);% calcul de l'angle formé entre micro 4 et 2 
   Angle2 = acos((TDOA2 * 343)/1);% calcul de l'angle formé au micro 4 et 3
   Angle1Deg = rad2deg(Angle1);%conversion en degres
   Angle2Deg = rad2deg(Angle2);
   
   Angle2Deg = 90 - Angle2Deg;%Pour avoir la même droite de référence que l'angle1
   fprintf('détecté au micro 1\n');
   fprintf('Angle 1 entre micro 4 et 2: %.3f\n',Angle1Deg);
   fprintf('Angle 2 entre micro 4 et 2: %.3f\n',Angle2Deg);
end 

if ClosestMic == 2
   TDOA1 = Times(1,3)-Times(1,1);%TDOA entre micro 3 et 1
   TDOA2 = Times(1,3)-Times(1,4);%TDOA entre micro 3 et 4
   Angle1 = acos((TDOA1 * 343)/3);% calcul de l'angle formé entre micro 3 et 1 
   Angle2 = acos((TDOA2 * 343)/1);% calcul de l'angle formé au micro 3 et 4
   Angle1Deg = rad2deg(Angle1);%conversion en degres
   Angle2Deg = rad2deg(Angle2);
   
   Angle2Deg = 90 - Angle2Deg;%Pour avoir la même droite de référence que l'angle1
   fprintf('détecté au micro 2\n');
   fprintf('Angle 1 entre micro 3 et 1: %.3f\n',Angle1Deg);
   fprintf('Angle 2 entre micro 3 et 1: %.3f\n',Angle2Deg);
end 

if ClosestMic == 3
   TDOA1 = Times(1,2)-Times(1,4);%TDOA entre micro 2 et 4
   TDOA2 = Times(1,2)-Times(1,1);%TDOA entre micro 2 et 1
   Angle1 = acos((TDOA1 * 343)/3);% calcul de l'angle formé entre micro 2 et 4 
   Angle2 = acos((TDOA2 * 343)/1);% calcul de l'angle formé au micro 2 et 1
   Angle1Deg = rad2deg(Angle1);%conversion en degres
   Angle2Deg = rad2deg(Angle2);
   
   Angle2Deg = 90 - Angle2Deg;%Pour avoir la même droite de référence que l'angle1
   fprintf('détecté au micro 3\n');
   fprintf('Angle 1 entre micro 2 et 4: %.3f\n',Angle1Deg);
   fprintf('Angle 2 entre micro 2 et 4: %.3f\n',Angle2Deg);
    
end 

if ClosestMic == 4
   TDOA1 = Times(1,1)-Times(1,3);%TDOA entre micro 1 et 3
   TDOA2 = Times(1,1)-Times(1,2);%TDOA entre micro 1 et 2
   Angle1 = acos((TDOA1 * 343)/3);% calcul de l'angle formé entre micro 1 et 3 
   Angle2 = acos((TDOA2 * 343)/1);% calcul de l'angle formé au micro 1 et 2
   Angle1Deg = rad2deg(Angle1);%conversion en degres
   Angle2Deg = rad2deg(Angle2);
   
   Angle2Deg = 90 - Angle2Deg;%Pour avoir la même droite de référence que l'angle1
   fprintf('détecté au micro 4\n');
   fprintf('Angle 1 entre micro 1 et 3: %.3f\n',Angle1Deg);
   fprintf('Angle 2 entre micro 1 et 3: %.3f\n',Angle2Deg);
    
end 

%% MDF Moyenne glissante test 4 micros avec angle 

rootdirectory = 'C:\Users\rolan\Desktop\Arafat\TB\Matlab_et_code_LOXO_Ears_3\loxo-ears-3\Test MATLAB\Sounds'

[dataRL,Fs] = audioread(fullfile(rootdirectory,'Test_Croisement_FrontLeft.mp3'));%pour la fenetre
[dataRL2,Fs2] = audioread(fullfile(rootdirectory,'Test_Croisement_FrontLeft.mp3'));%pour le reste du signal audio

[dataRL3,Fs] = audioread(fullfile(rootdirectory,'Test_Croisement_FrontRight.mp3'));%pour la fenetre
[dataRL4,Fs2] = audioread(fullfile(rootdirectory,'Test_Croisement_FrontRight.mp3'));%pour le reste du signal audio


[dataRL5,Fs] = audioread(fullfile(rootdirectory,'Test_Croisement_BackLeft.mp3'));%pour la fenetre
[dataRL6,Fs2] = audioread(fullfile(rootdirectory,'Test_Croisement_BackLeft.mp3'));%pour le reste du signal audio

[dataRL7,Fs] = audioread(fullfile(rootdirectory,'Test_Croisement_BackRight.mp3'));%pour la fenetre
[dataRL8,Fs2] = audioread(fullfile(rootdirectory,'Test_Croisement_BackRight.mp3'));%pour le reste du signal audio

Times = zeros(1, 4); % Tableau contenant les temps de détection sur les 4 microphones
%Prenons le micro 1 devant gauche, micro 2 devant droite, micro 3 derrière
%gauche et micro 4 derrière droite
%sound(dataRL, Fs)
dataL = dataRL(:,1);
dataR = dataRL(:,2);
dataL3 = dataRL3(:,1);
dataR3 = dataRL3(:,2);
timeaudio = length(dataL)/Fs; %sec
timestep = 0.05; %taille de la fenetre
timeaudio3 = length(dataL3)/Fs; %sec
timestep3 = 0.05; %taille de la fenetre

dataL5 = dataRL5(:,1);
dataR5 = dataRL5(:,2);
dataL7 = dataRL7(:,1);
dataR7 = dataRL7(:,2);
timeaudio5 = length(dataL)/Fs; %sec
timestep5 = 0.05; %taille de la fenetre
timeaudio7 = length(dataL3)/Fs; %sec
timestep7 = 0.05; %taille de la fenetre

% Calculer le nombre d'échantillons correspondant à 50 millisecondes
samples_to_remove = round(Fs * 0.05);
% Supprimer les échantillons des 50 premières millisecondes
dataRL2 = dataRL2((samples_to_remove + 1):end, :);
dataL2 = dataRL2(:,1);
dataR2 = dataRL2(:,2);

% Calculer le nombre d'échantillons correspondant à 50 millisecondes
samples_to_remove2 = round(Fs * 0.05);
% Supprimer les échantillons des 50 premières millisecondes
dataRL4 = dataRL4((samples_to_remove2 + 1):end, :);
dataL4 = dataRL4(:,1);
dataR4 = dataRL4(:,2);

% Calculer le nombre d'échantillons correspondant à 50 millisecondes
samples_to_remove3 = round(Fs * 0.05);
% Supprimer les échantillons des 50 premières millisecondes
dataRL6 = dataRL6((samples_to_remove3 + 1):end, :);
dataL6 = dataRL6(:,1);
dataR6 = dataRL6(:,2);

% Calculer le nombre d'échantillons correspondant à 50 millisecondes
samples_to_remove4 = round(Fs * 0.05);
% Supprimer les échantillons des 50 premières millisecondes
dataRL8 = dataRL8((samples_to_remove4 + 1):end, :);
dataL8 = dataRL8(:,1);
dataR8 = dataRL8(:,2);

timeaudio2 = length(dataL2)/Fs;%audio sans la partie de la fenetre
timestep2 = 0.001;
timeaudio4 = length(dataL4)/Fs;%audio sans la partie de la fenetre
timestep4 = 0.001;

timeaudio6 = length(dataL6)/Fs;%audio sans la partie de la fenetre
timestep6 = 0.001;
timeaudio8 = length(dataL8)/Fs;%audio sans la partie de la fenetre
timestep8 = 0.001;


Ncycle = uint32(ceil(timeaudio/timestep));
Ndata_cycle = uint32(length(dataL)/(timeaudio/timestep));

Ncycle2 = uint32(ceil(timeaudio2/timestep2));%Pour 1ms
Ndata_cycle2 = uint32(length(dataL2)/(timeaudio2/timestep2));%Pour 1ms

Ncycle3 = uint32(ceil(timeaudio3/timestep3));
Ndata_cycle3 = uint32(length(dataL3)/(timeaudio3/timestep3));

Ncycle4 = uint32(ceil(timeaudio4/timestep4));%Pour 1ms
Ndata_cycle4 = uint32(length(dataL4)/(timeaudio4/timestep4));%Pour 1ms


Ncycle5 = uint32(ceil(timeaudio5/timestep5));
Ndata_cycle5 = uint32(length(dataL5)/(timeaudio5/timestep5));

Ncycle6 = uint32(ceil(timeaudio6/timestep6));%Pour 1ms
Ndata_cycle6 = uint32(length(dataL6)/(timeaudio6/timestep6));%Pour 1ms

Ncycle7 = uint32(ceil(timeaudio7/timestep7));
Ndata_cycle7 = uint32(length(dataL7)/(timeaudio7/timestep7));

Ncycle8 = uint32(ceil(timeaudio8/timestep8));%Pour 1ms
Ndata_cycle8 = uint32(length(dataL8)/(timeaudio8/timestep8));%Pour 1ms

data_t = zeros(2,Ncycle2);
data_t2 = zeros(2,Ncycle4);

data_t3 = zeros(2,Ncycle6);
data_t4 = zeros(2,Ncycle8);

frequencystep = 20;
Fmin = 200; %Hz
Fmax = 800; %Hz
freqTable = Fmin:frequencystep:Fmax;

Dm = zeros(8,length(freqTable));

TableauR = zeros(length(freqTable),Ndata_cycle);
TableauL = zeros(length(freqTable),Ndata_cycle);
TableauR2 = zeros(length(freqTable),Ndata_cycle3);
TableauL2 = zeros(length(freqTable),Ndata_cycle3);

TableauR3 = zeros(length(freqTable),Ndata_cycle5);
TableauL3 = zeros(length(freqTable),Ndata_cycle5);
TableauR4 = zeros(length(freqTable),Ndata_cycle7);
TableauL4 = zeros(length(freqTable),Ndata_cycle7);

DetectDevantG = 0;
DetectDerriereG = 0;
DetectDevantD = 0;
DetectDerriereD = 0;

for x=1:1
    for lag=Fmin:frequencystep:Fmax
        offset = uint32(Fs/lag);
        for n=1:Ndata_cycle
            if offset < n && uint32(x-1)*(Ndata_cycle)+n < length(dataR)
                TableauR((lag - Fmin)/frequencystep + 1,n) = abs(dataR(uint32(x-1)*(Ndata_cycle)+n) - dataR(uint32(x-1)*(Ndata_cycle)+n-offset));%rempli le tableau pour chaque Ndata_cycle de la fenetre
                TableauL((lag - Fmin)/frequencystep + 1,n) = abs(dataL(uint32(x-1)*(Ndata_cycle)+n) - dataL(uint32(x-1)*(Ndata_cycle)+n-offset));
            end  
        end    
        for n2=1:Ndata_cycle3
            if offset < n2 && uint32(x-1)*(Ndata_cycle3)+n2 < length(dataR3)
                TableauR2((lag - Fmin)/frequencystep + 1,n2) = abs(dataR3(uint32(x-1)*(Ndata_cycle3)+n2) - dataR3(uint32(x-1)*(Ndata_cycle3)+n2-offset));%rempli le tableau pour chaque Ndata_cycle de la fenetre
                TableauL2((lag - Fmin)/frequencystep + 1,n2) = abs(dataL3(uint32(x-1)*(Ndata_cycle3)+n2) - dataL3(uint32(x-1)*(Ndata_cycle3)+n2-offset));
            end 
        end
        for n3=1:Ndata_cycle5
            if offset < n3 && uint32(x-1)*(Ndata_cycle5)+n3 < length(dataR5)
                TableauR3((lag - Fmin)/frequencystep + 1,n3) = abs(dataR5(uint32(x-1)*(Ndata_cycle5)+n3) - dataR5(uint32(x-1)*(Ndata_cycle5)+n3-offset));%rempli le tableau pour chaque Ndata_cycle de la fenetre
                TableauL3((lag - Fmin)/frequencystep + 1,n3) = abs(dataL5(uint32(x-1)*(Ndata_cycle5)+n3) - dataL5(uint32(x-1)*(Ndata_cycle5)+n3-offset));
            end  
        end
        for n4=1:Ndata_cycle7
            if offset < n4 && uint32(x-1)*(Ndata_cycle7)+n4 < length(dataR7)
                TableauR4((lag - Fmin)/frequencystep + 1,n4) = abs(dataR7(uint32(x-1)*(Ndata_cycle7)+n4) - dataR7(uint32(x-1)*(Ndata_cycle7)+n4-offset));%rempli le tableau pour chaque Ndata_cycle de la fenetre
                TableauL4((lag - Fmin)/frequencystep + 1,n4) = abs(dataL7(uint32(x-1)*(Ndata_cycle7)+n4) - dataL7(uint32(x-1)*(Ndata_cycle7)+n4-offset));
            end     
        end
            Dm(1,(lag - Fmin)/frequencystep + 1) = sum(TableauR(((lag - Fmin)/frequencystep + 1),:));%fais la somme de la ligne et l'ajoute
            Dm(2,(lag - Fmin)/frequencystep + 1) = sum(TableauL(((lag - Fmin)/frequencystep + 1),:));
            Dm(3,(lag - Fmin)/frequencystep + 1) = sum(TableauR2(((lag - Fmin)/frequencystep + 1),:));%fais la somme de la ligne et l'ajoute
            Dm(4,(lag - Fmin)/frequencystep + 1) = sum(TableauL2(((lag - Fmin)/frequencystep + 1),:));
            Dm(5,(lag - Fmin)/frequencystep + 1) = sum(TableauR3(((lag - Fmin)/frequencystep + 1),:));%fais la somme de la ligne et l'ajoute
            Dm(6,(lag - Fmin)/frequencystep + 1) = sum(TableauL3(((lag - Fmin)/frequencystep + 1),:));
            Dm(7,(lag - Fmin)/frequencystep + 1) = sum(TableauR4(((lag - Fmin)/frequencystep + 1),:));%fais la somme de la ligne et l'ajoute
            Dm(8,(lag - Fmin)/frequencystep + 1) = sum(TableauL4(((lag - Fmin)/frequencystep + 1),:));
     end
end

Counter=1;
Counter2 = 0;
Counter3 = 0;
for x=1:Ncycle2
    for lag=Fmin:frequencystep:Fmax
        offset = uint32(Fs/lag);
        if lag == Fmin
           Counter2 = Counter;% si nouveau cycle
        else 
           Counter = Counter2;%Si meme cycle mais differente frequence
        end    
        for n=1:Ndata_cycle2
            if uint32(x-1)*(Ndata_cycle2)+n-offset > 0
               TableauR((lag - Fmin)/frequencystep + 1,Counter)= abs(dataR2(uint32(x-1)*(Ndata_cycle2)+n) - dataR2(uint32(x-1)*(Ndata_cycle2)+n-offset));%remplace les valeur dans le tableau pour chaque cycle de 1 ms
               TableauL((lag - Fmin)/frequencystep + 1,Counter)= abs(dataL2(uint32(x-1)*(Ndata_cycle2)+n) - dataL2(uint32(x-1)*(Ndata_cycle2)+n-offset));
               Counter = Counter +1;%pour parcourir toutes les valeurs
               if Counter == Ndata_cycle + 1
                  Counter = 1;
               end 
            end
        end
        Dm(1,(lag - Fmin)/frequencystep + 1) =  sum(TableauR(((lag - Fmin)/frequencystep + 1),:));
        Dm(2,(lag - Fmin)/frequencystep + 1) =  sum(TableauL(((lag - Fmin)/frequencystep + 1),:));
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
    if DetectDevantG < 1
    if abs(Amin(1) - Amin(2)) <= 40 && Amin(1) <= 720 && Amin(1) >= 320
        time = Counter3*timestep2;
        fprintf('détecté devant gauche à: %.3f\n', time);
        DetectDevantG = 1;
        Times(1, 1) = time;
    end
    end
    Counter3 = Counter3+1;
    
end

Counter4 = 1;
Counter5 = 0;
Counter6 = 0;
for x=1:Ncycle4
    for lag=Fmin:frequencystep:Fmax
        offset = uint32(Fs/lag);
        if lag == Fmin
           Counter5 = Counter4;% si nouveau cycle
        else 
           Counter4 = Counter5;%Si meme cycle mais differente frequence
        end    
        for n=1:Ndata_cycle4
            if uint32(x-1)*(Ndata_cycle4)+n-offset > 0
               TableauR2((lag - Fmin)/frequencystep + 1,Counter4)= abs(dataR4(uint32(x-1)*(Ndata_cycle4)+n) - dataR4(uint32(x-1)*(Ndata_cycle4)+n-offset));%remplace les valeur dans le tableau pour chaque cycle de 1 ms
               TableauL2((lag - Fmin)/frequencystep + 1,Counter4)= abs(dataL4(uint32(x-1)*(Ndata_cycle4)+n) - dataL4(uint32(x-1)*(Ndata_cycle4)+n-offset));
               Counter4 = Counter4 +1;%pour parcourir toutes les valeurs
               if Counter4 == Ndata_cycle3 + 1
                  Counter4 = 1;
               end 
            end
        end
        Dm(3,(lag - Fmin)/frequencystep + 1) =  sum(TableauR2(((lag - Fmin)/frequencystep + 1),:));
        Dm(4,(lag - Fmin)/frequencystep + 1) =  sum(TableauL2(((lag - Fmin)/frequencystep + 1),:));
    end
    
    Amin(3) = Fmin;
    Amin(4) = Fmin;
    
    for v=Fmin:frequencystep:Fmax
        if Dm(3,(Amin(3) - Fmin)/frequencystep + 1) > Dm(3,(v - Fmin)/frequencystep + 1)
            Amin(3) = v;
        end
        if Dm(4,(Amin(4) - Fmin)/frequencystep + 1) > Dm(4,(v - Fmin)/frequencystep + 1)
            Amin(4) = v;
        end
    end
    
    if abs(Amin(3) - Amin(4)) <= 40 && Amin(3) <= 720 && Amin(3) >= 320
        data_t2(1,x) = Amin(3);
        data_t2(2,x) = Amin(4);
        
    else
        data_t2(1,x) = 0;
        data_t2(2,x) = 0;
    end
    if DetectDevantD < 1
    if abs(Amin(3) - Amin(4)) <= 40 && Amin(3) <= 720 && Amin(3) >= 320
        time = Counter6*timestep4;
        fprintf('détecté devant droite à: %.3f\n', time);
        DetectDevantD = 1;
        Times(1, 2) = time;
    end
    end
    Counter6 = Counter6+1;
end

Counter7 = 1;
Counter8 = 0;
Counter9 = 0;
for x=1:Ncycle6
    for lag=Fmin:frequencystep:Fmax
        offset = uint32(Fs/lag);
        if lag == Fmin
           Counter8 = Counter7;% si nouveau cycle
        else 
           Counter7 = Counter8;%Si meme cycle mais differente frequence
        end    
        for n=1:Ndata_cycle6
            if uint32(x-1)*(Ndata_cycle6)+n-offset > 0
               TableauR3((lag - Fmin)/frequencystep + 1,Counter7)= abs(dataR6(uint32(x-1)*(Ndata_cycle6)+n) - dataR6(uint32(x-1)*(Ndata_cycle6)+n-offset));%remplace les valeur dans le tableau pour chaque cycle de 1 ms
               TableauL3((lag - Fmin)/frequencystep + 1,Counter7)= abs(dataL6(uint32(x-1)*(Ndata_cycle6)+n) - dataL6(uint32(x-1)*(Ndata_cycle6)+n-offset));
               Counter7 = Counter7 +1;%pour parcourir toutes les valeurs
               if Counter7 == Ndata_cycle5 + 1
                  Counter7 = 1;
               end 
            end
        end
        Dm(5,(lag - Fmin)/frequencystep + 1) =  sum(TableauR3(((lag - Fmin)/frequencystep + 1),:));
        Dm(6,(lag - Fmin)/frequencystep + 1) =  sum(TableauL3(((lag - Fmin)/frequencystep + 1),:));
    end
    
    Amin(5) = Fmin;
    Amin(6) = Fmin;
    
    for v=Fmin:frequencystep:Fmax
        if Dm(5,(Amin(5) - Fmin)/frequencystep + 1) > Dm(5,(v - Fmin)/frequencystep + 1)
            Amin(5) = v;
        end
        if Dm(6,(Amin(6) - Fmin)/frequencystep + 1) > Dm(6,(v - Fmin)/frequencystep + 1)
            Amin(6) = v;
        end
    end
    
    if abs(Amin(5) - Amin(6)) <= 40 && Amin(5) <= 720 && Amin(5) >= 320
        data_t3(1,x) = Amin(5);
        data_t3(2,x) = Amin(6);
        
    else
        data_t3(1,x) = 0;
        data_t3(2,x) = 0;
    end
    if DetectDerriereG < 1
    if abs(Amin(5) - Amin(6)) <= 40 && Amin(5) <= 720 && Amin(5) >= 320
        time = Counter9*timestep6;
        fprintf('détecté derriere gauche à: %.3f\n', time);
        DetectDerriereG = 1;
        Times(1,3) = time;
    end
    end
    Counter9 = Counter9+1;
end
Counter10 = 1;
Counter11 = 0;
Counter12 = 0;
for x=1:Ncycle8
    for lag=Fmin:frequencystep:Fmax
        offset = uint32(Fs/lag);
        if lag == Fmin
           Counter11 = Counter10;% si nouveau cycle
        else 
           Counter10 = Counter11;%Si meme cycle mais differente frequence
        end    
        for n=1:Ndata_cycle8
            if uint32(x-1)*(Ndata_cycle8)+n-offset > 0
               TableauR4((lag - Fmin)/frequencystep + 1,Counter10)= abs(dataR8(uint32(x-1)*(Ndata_cycle8)+n) - dataR8(uint32(x-1)*(Ndata_cycle8)+n-offset));%remplace les valeur dans le tableau pour chaque cycle de 1 ms
               TableauL4((lag - Fmin)/frequencystep + 1,Counter10)= abs(dataL8(uint32(x-1)*(Ndata_cycle8)+n) - dataL8(uint32(x-1)*(Ndata_cycle8)+n-offset));
               Counter10 = Counter10 +1;%pour parcourir toutes les valeurs
               if Counter10 == Ndata_cycle7 + 1
                  Counter10 = 1;
               end 
            end
        end
        Dm(7,(lag - Fmin)/frequencystep + 1) =  sum(TableauR4(((lag - Fmin)/frequencystep + 1),:));
        Dm(8,(lag - Fmin)/frequencystep + 1) =  sum(TableauL4(((lag - Fmin)/frequencystep + 1),:));
    end
    
    Amin(7) = Fmin;
    Amin(8) = Fmin;
    
    for v=Fmin:frequencystep:Fmax
        if Dm(7,(Amin(7) - Fmin)/frequencystep + 1) > Dm(7,(v - Fmin)/frequencystep + 1)
            Amin(7) = v;
        end
        if Dm(8,(Amin(8) - Fmin)/frequencystep + 1) > Dm(8,(v - Fmin)/frequencystep + 1)
            Amin(8) = v;
        end
    end
    
    if abs(Amin(7) - Amin(8)) <= 40 && Amin(7) <= 720 && Amin(7) >= 320
        data_t4(1,x) = Amin(7);
        data_t4(2,x) = Amin(8);
        
    else
        data_t4(1,x) = 0;
        data_t4(2,x) = 0;
    end
    if DetectDerriereD < 1
    if abs(Amin(7) - Amin(8)) <= 40 && Amin(8) <= 720 && Amin(8) >= 320
        time = Counter12*timestep8;
        fprintf('détecté derriere droite à: %.3f\n', time);
        DetectDerriereD = 1;
        Times(1, 4) = time;
    end
    end
    Counter12 = Counter12+1;
end

[smallestime, ClosestMic] =  min(Times(1,:));
%trouver le premier micro qui a detecte

if ClosestMic == 1
   TDOA1 = Times(1,4)-Times(1,2);%TDOA entre micro 4 et 2
   TDOA2 = Times(1,4)-Times(1,3);%TDOA entre micro 4 et 3
   Angle1 = acos((TDOA1 * 343)/3);% calcul de l'angle formé entre micro 4 et 2 
   Angle2 = acos((TDOA2 * 343)/1);% calcul de l'angle formé au micro 4 et 3
   Angle1Deg = rad2deg(Angle1);%conversion en degres
   Angle2Deg = rad2deg(Angle2);
   
   Angle2Deg = 90 - Angle2Deg;%Pour avoir la même droite de référence que l'angle1
   fprintf('détecté au micro 1\n');
   fprintf('Angle 1 entre micro 4 et 2: %.3f\n',Angle1Deg);
   fprintf('Angle 2 entre micro 4 et 2: %.3f\n',Angle2Deg);
end 

if ClosestMic == 2
   TDOA1 = Times(1,3)-Times(1,1);%TDOA entre micro 3 et 1
   TDOA2 = Times(1,3)-Times(1,4);%TDOA entre micro 3 et 4
   Angle1 = acos((TDOA1 * 343)/3);% calcul de l'angle formé entre micro 3 et 1 
   Angle2 = acos((TDOA2 * 343)/1);% calcul de l'angle formé au micro 3 et 4
   Angle1Deg = rad2deg(Angle1);%conversion en degres
   Angle2Deg = rad2deg(Angle2);
   
   Angle2Deg = 90 - Angle2Deg;%Pour avoir la même droite de référence que l'angle1
   fprintf('détecté au micro 2\n');
   fprintf('Angle 1 entre micro 3 et 1: %.3f\n',Angle1Deg);
   fprintf('Angle 2 entre micro 3 et 1: %.3f\n',Angle2Deg);
end 

if ClosestMic == 3
   TDOA1 = Times(1,2)-Times(1,4);%TDOA entre micro 2 et 4
   TDOA2 = Times(1,2)-Times(1,1);%TDOA entre micro 2 et 1
   Angle1 = acos((TDOA1 * 343)/3);% calcul de l'angle formé entre micro 2 et 4 
   Angle2 = acos((TDOA2 * 343)/1);% calcul de l'angle formé au micro 2 et 1
   Angle1Deg = rad2deg(Angle1);%conversion en degres
   Angle2Deg = rad2deg(Angle2);
   
   Angle2Deg = 90 - Angle2Deg;%Pour avoir la même droite de référence que l'angle1
   fprintf('détecté au micro 3\n');
   fprintf('Angle 1 entre micro 2 et 4: %.3f\n',Angle1Deg);
   fprintf('Angle 2 entre micro 2 et 4: %.3f\n',Angle2Deg);
    
end 

if ClosestMic == 4
   TDOA1 = Times(1,1)-Times(1,3);%TDOA entre micro 1 et 3
   TDOA2 = Times(1,1)-Times(1,2);%TDOA entre micro 1 et 2
   Angle1 = acos((TDOA1 * 343)/3);% calcul de l'angle formé entre micro 1 et 3 
   Angle2 = acos((TDOA2 * 343)/1);% calcul de l'angle formé au micro 1 et 2
   Angle1Deg = rad2deg(Angle1);%conversion en degres
   Angle2Deg = rad2deg(Angle2);
   
   Angle2Deg = 90 - Angle2Deg;%Pour avoir la même droite de référence que l'angle1
   fprintf('détecté au micro 4\n');
   fprintf('Angle 1 entre micro 1 et 3: %.3f\n',Angle1Deg);
   fprintf('Angle 2 entre micro 1 et 3: %.3f\n',Angle2Deg);
    
end 
