clear all
close all

% Conditions initiales
y0 = [1; 0];

% Intervalle sur lequel on résout l'ED
tspan = [0, 20];
%tspan = linspace(0, 5, 1000);

% On résout l'ED
[t, y] = ode23(@oscillateur,tspan,y0);

plot(t, y)

% Faire passer un spline par ces points (possible dans TE)
