%%
close all; clear; clc;

f = 500;
T = 1/f;
nE = 20;
Te = T/nE;
Te1 = Te/1000;
period = T*10; %sec
A = 0.5;

nDataTe1 = round(period/Te1);

t = (0:Te1:period-Te1);
in = zeros(1, round(nDataTe1));
for tt=1:nDataTe1
    ttt = (tt-1)*Te1;
    in(tt) = A*sin(2*pi*f*ttt);
end

figure(1)
plot(t,in)
hold on

out = zeros(1, round(nDataTe1));
for tt=1:nDataTe1
    ttt = (tt-1)*Te1;
    if mod(ttt, Te) == 0
        out(tt) = A*sin(2*pi*f*ttt);
    else
        out(tt) = out(tt-1);
    end
end

figure(2)
plot(t,out)

%%

tf_noa = zeros(1, 1/Te1/2/f+1);
for ff=0:f:1/Te1/2
    sumI=0;
    tt = 0;
    for nn=1:nE
        if mod(nn,(nE-2)/2) == 0
            sumI = sumI + Te*A*sin(2*pi*nn/nE)*sinc(pi*ff*Te)*exp(-1i*2*pi*ff*(tt+Te/2));
            tt = tt + Te;
        else
            sumI = sumI + 2*Te*A*sin(2*pi*nn/nE)*sinc(pi*ff*2*Te)*exp(-1i*2*pi*ff*(tt+2*Te/2));
            tt = tt + 2*Te;
        end
    end
    sumN = 0;
    tf_noa(ff/f+1) = tf_noa(ff/f+1) + 2 * abs(sumI);
end

tf_noa = 20*log10(tf_noa);

figure(2)
plot(tf_noa)

%%
% Calcul de la transformée de Fourier
L = length(out); % Longueur du signal
Y = fft(out);    % Calcul de la DFT
P2 = abs(Y/L);   % Calcul des amplitudes
P1 = P2(1:L/2+1);% Troncature de la moitié positive du spectre
P1(2:end-1) = 2*P1(2:end-1); % Doublement pour compenser la moitié tronquée

% Fréquences correspondantes
frequencies = (0:(L/2))*(1/period);
P_dBm = 20*log10(P1/sqrt(2));

% Affichage du spectre
figure(3)
plot(frequencies, P1)
title('Spectre du signal out')
xlabel('Fréquence (Hz)')
ylabel('Amplitude (dBm)')
xlim([0 100e3])
figure(4)
plot(frequencies, P_dBm)
title('Spectre du signal out')
xlabel('Fréquence (Hz)')
ylabel('Amplitude (dBm)')
xlim([0 100e3])
