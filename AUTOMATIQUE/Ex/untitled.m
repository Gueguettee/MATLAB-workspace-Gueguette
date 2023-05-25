num=[1];
den=[40 14 1];
figure(1);
step(num,den,40)
[r,p,k]=residue(num,den)