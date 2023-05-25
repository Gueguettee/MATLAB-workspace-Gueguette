% EX3

%% 3.1

clear; close all; clc;

Fs = 44100;

b = [0.5 0.01 0.01 0.5];

load music.mat;

y = filter_no_recursive(music, b);

%sound(music,Fs);
%pause;
%sound(y, Fs);

plot(music);
hold on;
plot(y)

%% 3.2

clear; close all; clc;

Fs = 44100;

a = [1 -1.8 0.8];
b = [1 -2 1];

load music.mat;

music=[1 2 3 4 5 6];
y = filter_recursive(music, a, b);

%sound(music,Fs);
%pause;
%sound(y, Fs);

%plot(music);
%hold on;
%plot(y)

%% 3.3

clear; close all; clc;

a = [1 -1.8 0.8];
b = [1 -2 1];

Fs = 44100;

f=(1:1:1e6);

omega = 2*pi*f/Fs;

length_AB = length(a);

sumA = 0;
sumB = 0;
for l1=1:1:length_AB
    sumA = sumA + a(l1)*exp(-1j*omega*l1);
    sumB = sumB + b(l1)*exp(-1j*omega*l1);
end

axe(1)=subplot(2,1,1);
semilogx(f,20*log(abs(sumB./sumA)));
hold on;

axe(2)=subplot(2,1,2);
semilogx(omega,20*log(abs(sumB./sumA)));
