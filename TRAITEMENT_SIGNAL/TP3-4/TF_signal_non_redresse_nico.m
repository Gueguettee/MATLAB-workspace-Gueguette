% Calcul des coefficients de la SF
clc; clear; close all;
N = 20;
f1 = 500;
Te = 1/(f1*N);

x = @(t) 1*sin(2*pi*f1*t)

data_x = [];
data_y = [];

for n=0:200
    temp = 0;

    for k = 0:N-1
        if n > 0
        temp = temp + x(k*Te) * (exp(-1j*2*pi*n*(k+1)/N) - exp(-1j*2*pi*n*k/N));
        else
        temp = temp + x(k*Te);
        end
    end

    if n > 0
    temp = temp / (-1j*2*pi*n);
    else
    temp = temp / N;
    end

    % Get module, and remove noise
    temp = abs(temp);
    if temp < 1e-10
        temp = 0;
    end

    % Get dBm
    temp_Vrms = temp / sqrt(2);
    temp_dBm = 10*log10((temp_Vrms^2)/(50*1e-3));


    if temp_dBm == -Inf
        temp_dBm = -90;
    end

    if temp_dBm > -90
    fprintf("X%d = %s dBm = %s Vrms @ f=%s\n", n, string(temp_dBm), string(temp/sqrt(2)), string(f1*n ...
        ));
    end

    data_x = [data_x f1*n];
    data_y = [data_y temp_dBm];
end

plot(data_x, data_y, 'o-');
xlabel("f, Hz");
ylabel("Amplitude, dBm");
