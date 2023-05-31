%% LP
s1 = -50;
numHl = [0 0 4.6];
denHl = [1 0.2 0];
hold on;
figure(1); sgrid('new');rlocus(numHl,denHl);
hold off;
[kp poles] = rlocfind(numHl,denHl)
