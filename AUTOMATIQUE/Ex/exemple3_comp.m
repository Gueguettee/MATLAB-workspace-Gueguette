w0 = 10;
factor = 0.1;
s1 = -0.5;
numHL=[1];
denHL=[1/w0^2 2*factor/w0 1];
rlocus(numHL, denHL)

%% exmple 4
w0 = 10;
factor = 0.1;
s1 = -0.5;
numHL=[1 -s1];
denHL=[1/w0^2 2*factor/w0 1 0];
rlocus(numHL, denHL)