numHN=[1*12.5];
denHN=[0.1 3 20 0];
sys1=tf(numHN,denHN);
nyquist(sys1);
