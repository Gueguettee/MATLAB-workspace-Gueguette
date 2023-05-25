%% Boucle 5
% Regulateur P
numHcm = [0.5];
denHcm=[0.01 1];
numHs=[1];
denHs = [1 50 400];
[numHL,denHL]=series(numHcm,denHcm,numHs,denHs);
figure(1);
sgrid('new');
K=linspace(0,500,1000);
rlocus(numHL,denHL);
[kp,poles]=rlocfind(numHL,denHL);

%% Regulateur PID
s1=-20; s2=-50;
numHcm = [0.5];
denHcm=[0.01 1];
numHs=[1];
denHs = [1 50 400];
[numHL,denHL]=series(numHcm,denHcm,numHs,denHs);
figure(1);
sgrid('new');
K=linspace(0,500,1000);
rlocus(numHL,denHL);
[kp,poles]=rlocfind(numHL,denHL);

[numH0,denH0] = series(kp*numHcm, denHcm, numHs, denHs);
[numH0,denH0] = series(numH0, denH0, numHpr, denHpr);
[numHbc,denHbc]=feedback(numH0,denH0,numHm,denHm);
figure(2);
step(numHbc,denHbc)
