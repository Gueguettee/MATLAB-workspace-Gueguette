R=10;
C=30e-12;
L=100e-9;

AT=[-R/L -1/L;1/C 0];
BT = [1/L;0];
CT = [1 0;0 1];
DT=0;

sys=ss(AT,BT,CT,DT,0);
[y,t]=step(sys,0.15e-6);

figure(1)
yyaxis left
plot(t*1e9, 1e3*y(:,1))
ylabel('i [mA]')
yyaxis right
plot(t*1e9, y(:,2))
ylabel('u_C[V]')

figure(2)
plot(1e3*y(:,1), y(:,2), 'r')
xlabel('x1')
ylabel('x2')
