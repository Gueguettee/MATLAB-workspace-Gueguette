%% Diff ordre 1
clear;clc;

tspan = [-1e-12, 5];

y0 = 1;

[x, y] = euler1_te(@dydx, tspan , y0, 0.001);

ySol = y(length(y))

%% Diff ordre 2
clear;clc;

tspan = [-1e-12, 5];

y0 = [1, 0];

[x, y] = ode45(@dydx2,tspan,y0,0.1);
%[x, y] = euler2_te(@dydx2, tspan , y0, 0.001);

ySol = y(length(y))

%% Ex 1
clear;clc;

u(1)=0;
u(2)=1;

nieme = 1000;   %min 2

for loop=3:1:(nieme+1)
    u(loop)=u(loop-2)+u(loop-1);
end

sol = u(nieme+1)

%% Ex 2
clear;clc;

x = [-3, 2, -1, -2, 1];
y = [1, 5, -4, -4, 1];

% a) poly fit
p = polyfit(x, y, 4)

y = polyval(p,2.5)

%% Ex 3
clear;clc;

t = [0, 1, 3, 5, 7, 9];
n = [5.03, 4.70, 4.05, 3.45, 3.22, 2.92];

y = 1./n;
coeff = polyfit(t, y, 1)
beta = coeff(1)
alpha = 1/coeff(2)

%% Ex 4
clear;clc;

tspan = [0, 25];

y0 = [2, -1];

[x, y] = ode45(@dydx2,tspan,y0);

%[x, y] = euler2_te(@dydx2,tspan,y0,0.001);

ySol = y(length(y),1)

max = max(y)


