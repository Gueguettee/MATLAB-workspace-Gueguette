function f = dydx2(x, y)
%UNTITLED Summary of this function goes here
% y: [y1; y2]
% dydt: [y1'; y2']
y1 = y(1);
y2 = y(2);

f = [y2; (y1*cos(2*x))];   %fonction dans le 2 : d^2/dx = ...
end