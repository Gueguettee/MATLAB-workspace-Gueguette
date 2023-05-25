syms I0 I1 I2 U0 U1 U2 s R1 R2 C
equ1 = -U0+R2*I2+R1*I0==0;
equ2 = U1+R2*I2-I1/(s*C)==0;
equ3 = I2+I1==0;
[S]=solve([equ1,equ2,equ3],[I0,I1,I2])
S.I0
S.I1
S.I2