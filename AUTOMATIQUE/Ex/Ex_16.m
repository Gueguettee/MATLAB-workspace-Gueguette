%%
numHl = [2];
denHl = [0.5 0];
figure(2);
rlocus(numHl, denHl);
[kp, poles] = rlocfind(numHl, denHl);

num1 = [0.1*kp];
den1 = [0.5 0];
num2 = [20];
den2 = [1];

%Y_Yc = feedback(num1, den1, num2, den2);
%%

s1 = -20;

numHpr = [1 -s1];
denHpr = [1 0];

[numHl, denHl] = series(numHl,denHl,numHpr,denHpr);
figure(2); rlocus(numHl, denHl)
