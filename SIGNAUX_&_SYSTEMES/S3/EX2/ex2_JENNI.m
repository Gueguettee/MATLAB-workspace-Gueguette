% Reponse impulsionnelle s1

clear; close all; clc;

n = (-10:1:10);

h1 = sys1(delta(n));

%stable, avec mémoire, causal

% Reponse impulsionnelle s2

n = (-10:1:10);

h2 = sys2(delta(n));

%instable, avec mémoire, causal

% Réponse de systèmes discrets et convolution

n = (-100:1:100);

x = sys3(n);

y1x = sys1(x);
y2x = sys2(x);

y1 = conv(x,h1,'same');
y2 = conv(x,h2,'same');

axe(1)=subplot(2,1,1);
stem(n,y1);
xlim([-5 100]);

axe(2)=subplot(2,1,2);
stem(n,y2);
xlim([-5 100]);

hold on

stem(n,y2x);


%% Convolution sonore

clear; close all; clc;

[flute,Fs1] = audioread ('flute.wav');
[balonEglise,Fs2] = audioread("balonEglise.wav");

convSound = conv(flute,balonEglise);

convSound = convSound / max(convSound);

sound(convSound,Fs1);
