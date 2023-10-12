%% Affichage du signal audio source dans le temps 
% SOURCE : Signal Sinus 440Hz

clc; %clear all; close all; 

% Chemin vers le fichier WAV
cheminFichier = 'C:\Users\Ahmed\HESSO\TB-SimSound3D - General\4.SimSound3D\Son\Sinus_440Hz_1.wav';

% Lecture du fichier WAV
[signal, frequenceEchantillonnage] = audioread(cheminFichier);

% Calcul de la dur�e du signal
dureeSignal = length(signal) / frequenceEchantillonnage;

% Vecteur temps
temps = linspace(0, dureeSignal, length(signal));
 
% Trac� du signal audio
plot(temps, signal);

% �tiquettes des axes et titre du graphique
xlim([0,0.01]);
ylim([-0.3,0.3]); 
xlabel('Temps (s)');
ylabel('Amplitude');
titre = 'Signal audio Sinus 440Hz';
title(titre);

%% Affichage du signal du recepteur dans le temps 
% Enregistrement audio de la simulation

clc; %clear all; close all; 

% Chemin vers le fichier WAV
cheminFichier = 'C:\Users\Ahmed\HESSO\TB-SimSound3D - General\4.SimSound3D\Enregistrement\RecorderFront.wav';

% Lecture du fichier WAV
[signal, frequenceEchantillonnage] = audioread(cheminFichier);

% Calcul de la dur�e du signal
dureeSignal = length(signal) / frequenceEchantillonnage;

% Vecteur temps
temps = linspace(0, 20, length(signal));
 
% Trac� du signal audio
plot(temps, signal);

% �tiquettes des axes et titre du graphique
xlim([0,20]);
ylim([-0.4,0.4]); 
xlabel('Temps (s)');
ylabel('Amplitude');
titre = 'Signal audio';
title(titre);

%% Affichage spectre audio de la source dans les fr�quences

clc; %clear all; close all; 

% Chemin vers le fichier WAV
cheminFichier = 'C:\Users\Ahmed\HESSO\TB-SimSound3D - General\4.SimSound3D\Son\Sinus_440Hz_1.wav';

% Lecture du fichier WAV
[signal, frequenceEchantillonnage] = audioread(cheminFichier);

% Normalisation du signal
N = length(signal);
signalNormalise = signal / N;  % Normalisation 

% Calcul de la transform�e de Fourier du signal normalis�
spectre = fft(signalNormalise);
spectreDeplace = fftshift(spectre);

% Calcul des fr�quences correspondantes
deltaF = frequenceEchantillonnage / N;
frequences = (-N/2 : N/2-1) * deltaF;

% Trac� du spectre
plot(frequences, abs(spectreDeplace));

% �tiquettes des axes et titre du graphique
xlim([-500,500]);
xlabel('Fr�quence (Hz)');
ylabel('Amplitude');
title('Spectre du signal audio');

%% Affichage spectre audio du recepteur dans les fr�quences

clc; %clear all; close all; 

% Chemin vers le fichier WAV
cheminFichier = 'C:\Users\Ahmed\HESSO\TB-SimSound3D - General\4.SimSound3D\Enregistrement\RecorderFront.wav';
 
% Lecture du fichier WAV
[signal, frequenceEchantillonnage] = audioread(cheminFichier);

% Normalisation du signal
N = length(signal);
signalNormalise = signal / N;  % Normalisation 

% Calcul de la transform�e de Fourier du signal normalis�
spectre = fft(signalNormalise);
spectreDeplace = fftshift(spectre);

% Calcul des fr�quences correspondantes
deltaF = frequenceEchantillonnage / N;
frequences = (-N/2 : N/2-1) * deltaF;

% Trac� du spectre
plot(frequences, abs(spectreDeplace));

% �tiquettes des axes et titre du graphique
xlim([-500,500]);
xlabel('Fr�quence (Hz)');
ylabel('Amplitude');
title('Spectre du signal audio');

%% Test 1 Temps

clc; %clear all; close all; 

% Chemin vers le fichier WAV
cheminFichier = 'C:\Users\Ahmed\HESSO\TB-SimSound3D - General\4.SimSound3D\Son\Sinus_440Hz_1.wav';

% Lecture du fichier WAV
[signal, frequenceEchantillonnage] = audioread(cheminFichier);

% Calcul de la dur�e du signal
dureeSignal = length(signal) / frequenceEchantillonnage;

% Vecteur temps
temps = linspace(0, dureeSignal, length(signal));
 
% Trac� du signal audio
plot(temps, signal);

% �tiquettes des axes et titre du graphique
xlim([0,0.1]);
ylim([-1,1]); 
xlabel('Temps (s)');
ylabel('Amplitude');
titre = 'Signal audio';
title(titre);

%% Test 2 FFT

clc; %clear all; close all; 

% Chemin vers le fichier WAV
cheminFichier = 'C:\Users\Ahmed\HESSO\TB-SimSound3D - General\4.SimSound3D\Son\Sinus_440Hz_1.wav';

% Lecture du fichier WAV
[signal, frequenceEchantillonnage] = audioread(cheminFichier);

% Normalisation du signal
N = length(signal);
signalNormalise = signal / N;  % Normalisation 

% Calcul de la transform�e de Fourier du signal normalis�
spectre = fft(signalNormalise);
spectreDeplace = fftshift(spectre);

% Calcul des fr�quences correspondantes
deltaF = frequenceEchantillonnage / N;
frequences = (-N/2 : N/2-1) * deltaF;

% Trac� du spectre
plot(frequences, abs(spectreDeplace));

% �tiquettes des axes et titre du graphique
xlim([-500,500]);
xlabel('Fr�quence (Hz)');
ylabel('Amplitude');
title('Spectre du signal audio');