clc; clear all; close all; 

rootdirectory = 'Sounds';

[data1,Fs] = audioread(fullfile(rootdirectory,'1.mp3'));
[data2,Fs2] = audioread(fullfile(rootdirectory,'2.mp3'));

data1 = data1(1:10000,:);
figure(1)
plot(data1)
hold on
figure(2)
data2 = data2(1:10000,:);
plot(data2)
hold on

% Calculez la corrélation croisée temporelle
delay1 = finddelay(data1(:,1), data2(:,1), 5000); %delai maximale de 5000
cross_corr = xcorr(data1(:,1), data2(:,1));
figure(3)
plot(cross_corr)

% Trouvez le décalage temporel correspondant au pic maximal de la corrélation
[max_corr, max_index] = max(cross_corr);

% Le décalage temporel correspond au délai entre les signaux
delay = length(data1) - max_index; % Soustrayez 1 car l'index commence à zéro

% Affichez le résultat
fprintf('Le décalage temporel entre A et B est de %d échantillons.\n', delay);

% Exemple code C :
% #include <stdio.h>
% #include <math.h>
% 
% // Fonction pour calculer la corrélation croisée entre deux signaux
% double cross_correlation(const double* signal1, const double* signal2, int signal_length, int delay) {
%     double correlation = 0.0;
%     
%     for (int i = 0; i < signal_length - delay; i++) {
%         correlation += signal1[i] * signal2[i + delay];
%     }
%     
%     return correlation;
% }
% 
% // Fonction pour trouver le décalage temporel optimal entre deux signaux
% int find_delay(const double* signal1, const double* signal2, int signal_length) {
%     double max_correlation = -INFINITY;
%     int optimal_delay = 0;
%     
%     for (int delay = 0; delay < signal_length; delay++) {
%         double correlation = cross_correlation(signal1, signal2, signal_length, delay);
%         if (correlation > max_correlation) {
%             max_correlation = correlation;
%             optimal_delay = delay;
%         }
%     }
%     
%     return optimal_delay;
% }
% 
% int main() {
%     // Exemple d'utilisation
%     int signal_length = 100;
%     double signal1[100];
%     double signal2[100];
%     
%     // Remplissez les tableaux signal1 et signal2 avec vos données audio
%     
%     int delay = find_delay(signal1, signal2, signal_length);
%     printf("Le décalage temporel optimal est de %d échantillons.\n", delay);
%     
%     return 0;
% }
