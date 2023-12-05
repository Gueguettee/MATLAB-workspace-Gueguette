%% TP5 point 1

close all; clc; clear;

nSignals = 4;

Fe = 30;
Pe = 1/Fe;
nSamples = 30;
T_tot = nSamples*Pe;
t = linspace(0,T_tot-Pe,T_tot*Fe);

f1 = 1/(30*Pe);
f2 = f1;
f3 = f1;
f4 = f1;
A1 = 1;
A2 = 2;
A3 = 0.5;
A4 = 2;
x1 = A1 * sin(2*pi*f1*t);
x2 = A2 * sawtooth (2*pi*f1*t);
x3 = A3 * randn(1, length(x1));
x4 = zeros(1,length(x1));
x4([nSamples/3, nSamples/2, round(nSamples*0.7), round(nSamples*0.9)]) = [A4, -A4, -A4, A4];

figure(1)
stem(t, x1)
hold on
stem(t, x2)
hold on
stem(t, x3)
hold on
stem(t, x4)
xlabel("t (s)")
ylabel("A")

%% B1: convolutions

y12 = conv(x1,x2);
t_conv = linspace(0, (length(y12)-1)*Pe, length(y12));

figure(2)
stem(t_conv, y12)
hold on
xlabel("t (s)")
ylabel("A")

%% B2: convolutions

y12 = zeros(1, length(t_conv));

for tt=1:length(t_conv)-1
    sum = 0;
    for tau=0:length(x1)-1
        if tt-tau >= 1
            if tt-tau <= length(x1)
                sum = sum + x1(tau+1) * x2(tt-tau);
            end
        end
    end
    y12(tt) = sum;
end

figure(3)
stem(t_conv, y12)
hold on
xlabel("t (s)")
ylabel("A")

%% B3 : filter()

y12 = filter(x1, 1, x2);

figure(4)
stem(t, y12)
hold on
xlabel("t (s)")
ylabel("A")

%% D : filter() 2

b = [ 1; -1.623151208784920; 0.990327854874358;
0.990327854874358; -1.623151208784920; 1]';
a = [ 1; -2.790929589252946; 3.113233992074267;
-1.592553142685512; 0.318049953266280]';

y12 = filter(b, a, x1);

figure(5)
stem(t, y12)
hold on
xlabel("t (s)")
ylabel("A")

%% E : zplane()

figure(6)
zplane(b, a)
