num = [0.5];
den = [1 4 8];
sys = tf(num,den);
rlocus(sys)
[kp, poles]=rlocfind(sys)
grid on
