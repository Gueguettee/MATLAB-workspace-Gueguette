%Plot différents signaux

%% Signaux (plot)

clear;close all;clc;

f=6e3;
fe = 1/10e-6;
T=0.5e-3;
factEchelle = 1000;

t=(-1:1/fe:1);

x1 = 5*cos(2*pi*f*t);
x2 = 4*exp(-t/T).*cos(2*pi*f*t);

axe(1)=subplot(2,1,1);
plot(t*factEchelle,x1,'b','Linewidth',2);
title(['\fontsize{24}','Plot signal']);
xlim([-0.5 1.5]);
set(gca,'FontSize',16);
%xlabel('');
ylabel(['\fontsize{24}','x_1(t)']);
grid on;

axe(2)=subplot(2,1,2);
plot(t*factEchelle,x2,'r','Linewidth',2);
%title('');
xlim([-0.5 1.5]);
set(gca,'FontSize',16);
xlabel(['\fontsize{24}','t [ms]']);
ylabel(['\fontsize{24}','x_2(t)']);
grid on;

linkaxes(axe,'x');


%% Signaux discrets (stem)

clear;close all;clc;

n = (-5:1:5);

n_1 = delta(n+1);

u = cumsum(n_1);

r = cumsum(u);
r = [0 r(1:end-1)];

stem(n,n_1);
hold on;
stem(n-0.05,u);
hold on;
stem(n-0.1,r);


%% Signaux continus

clear;close all;clc;

syms t;
u=heaviside(t-0.5);

d=diff(u);

r=int(u,t);

t=(-5:1e-3:5);
plot(t,eval(u),'b');
hold on;

plot(t,eval(d),'r');
hold on;

plot(t,eval(r),'k');
% xlim=[-4 4];


%% Exponentielle complexe

clear;close all;clc;

f=200;
fe = 1/100e-6;
A = 4;
fi = -100;
omega = 2*pi*f;
factEchelle = 1000;

t=(-50e-3:1/fe:100e-3);

x1 = A*exp((fi+j*omega)*t);
x2 = A*(exp((fi+j*omega)*t)+exp((fi-j*omega)*t));

axe(1)=subplot(2,2,1);
plot(t*factEchelle,x1,'b','Linewidth',2);
title(['\fontsize{24}','Plot signal']);
xlim([-0.5 1.5]);
set(gca,'FontSize',16);
%xlabel('');
ylabel(['\fontsize{24}','x_1(t)']);
grid on;

axe(2)=subplot(2,2,2);
plot(t*factEchelle,x2,'r','Linewidth',2);
%title('');
xlim([-0.5 1.5]);
set(gca,'FontSize',16);
xlabel(['\fontsize{24}','t [ms]']);
ylabel(['\fontsize{24}','x_2(t)']);
grid on;

linkaxes(axe,'x');
