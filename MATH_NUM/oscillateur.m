function dydt = oscillateur(t, y)
% t : variable inddépendnate
% y = [y1, y2]
% dydt = [dy1/dt; d2/dt]

y1 = y(1);
y2 = y(2);

dydt = [y2; -y1];

end
