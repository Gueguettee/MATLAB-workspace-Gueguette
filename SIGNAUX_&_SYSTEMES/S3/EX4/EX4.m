
Fs = 10e3;
Ts = 1/Fs;
m = 1;
k = 20;
R = 100e-3;

T = 60;

t = (0:Ts:T);

nt = length(t);

F0 = zeros(size(t));
F0(1:10)=100;

A = [1, Ts; -k*Ts/m, 1-R*Ts/m];
B = [0, Ts/m]';
C = [1, 0; 0, 3.6];
D = [0, 0]';

N = [0, 0]';

y = zeros(2, length(t));
for loop=1:1:nt
    [N, y(:,loop)] = iteration(A, B, C, D, N, F0(loop));
end

plot(t,y(1,:));
