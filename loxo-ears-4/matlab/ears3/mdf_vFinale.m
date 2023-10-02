%% MDF Moyenne glissante (v2 Finale)

clc; %clear all; %close all; 
 
rootdirectory = 'Sounds'

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
