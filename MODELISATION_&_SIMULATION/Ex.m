clc;clear;close all;

m=1;
c=[0.1 0.3 0.5 1.5];
k=0.4;
t=0:0.1:70;

B=[0;1/m];
C=[1 0];
D=[0];

x0=[0.9;0];
for i=1:length(c)
    A(:,:,i) = [0 1; -k/m -c(i)/m];
    sys=ss(A(:,:,i),B,C,D);
    y(:,i)=initial(sys,x0,t);
end

plot(t,y)
xlabel('t (s)')
ylabel('x (m)')
legend('c=0.1','c=0.3','c=0.5','c=1.5')
