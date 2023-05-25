%%
close all; clear; clc;

data=readtable('data.csv');

%%

t = table2array(data(:,1));
in = table2array(data(:,2));
out = table2array(data(:,3));

plot(t, out);
hold on 
plot(t, in);
xlabel("t (s)")
ylabel("U (V)")

%%
close all;
dOut = zeros(length(out)-1,1);
nValueForMean = 1;
for l=1:1:length(out)-nValueForMean
    dOut(l) = out(l+nValueForMean)-out(l);  %/1
end
%dOut = diff(out);

plot(t(1:end-1), dOut)

%%
tf = fft(dOut)*2;
%tf = fft(dOut);

T = t(length(t))-t(1);
fm = 1/T;
Te = T/length(t);
fe = 1/Te;

deltaf = fe/length(dOut);

k = (0:1:length(dOut)-1)';
f = k*deltaf;

tf_db = 20*log10(abs(tf));

tiledlayout(2,1);
nexttile
semilogx(f, tf_db)
xlabel("f (Hz)")
ylabel("H(jw) (dB)")
hold on
nexttile
semilogx(f, angle(round(tf, 6).*exp(j*2*pi*f.*10.67e-3)));%Avec correction
%
%semilogx(f, angle(round(tf, 6)));

f_pic = 370;
H_pic = 12.96; % dB
H_0 = -6.05; %dB

