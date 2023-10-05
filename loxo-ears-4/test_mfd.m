% Paramètres du filtre MDF
N = 64; % Longueur de la FFT
L = 4;  % Nombre de retards
mu = 0.01; % Taux d'apprentissage

% Génération du signal d'entrée (exemple)
fs = 1000; % Fréquence d'échantillonnage
t = 0:1/fs:1-1/fs; % Temps
x = sin(2*pi*50*t) + 0.5*sin(2*pi*120*t) + randn(size(t)); % Signal d'entrée

% Initialisation du filtre MDF
w = zeros(N, 1);
d = zeros(N, 1);
y_estimated = zeros(size(x)); % Vecteur pour stocker les valeurs estimées

% Boucle principale
for i = N+1:length(x)
    % Sélectionner N échantillons du signal d'entrée
    x_n = x(i:-1:i-N+1);
    
    % Transformation de Fourier
    X_n = fft(x_n, N);
    
    % Calcul de la sortie estimée
    Y_n = X_n .* w;
    y_n = ifft(Y_n, N);
    y_estimated(i) = y_n(1);
    
    % Calcul de l'erreur
    e = x(i) - y_estimated(i);
    
    % Mise à jour du filtre
    W_n = X_n' / (X_n * X_n' + 1e-5); % Éviter la division par zéro
    w = w + mu * e * W_n;
    
    % Mise à jour du vecteur de données retardées
    d = circshift(d, 1);
    d(1) = x(i);
end

% Tracer le signal d'entrée, la sortie estimée et la vraie sortie
figure;
subplot(2,1,1);
plot(t(N+1:end), x(N+1:end));
title('Signal d''entrée');
xlabel('Temps');
subplot(2,1,2);
plot(t(N+1:end), y_estimated(N+1:end));
title('Sortie estimée');
xlabel('Temps');
