clc; close all; clear;

Vref = 5;
R = 3.900E+05;
Rg = R;
nBits = 4;

I_in = Vref/R;
Iout_max = I_in - I_in/(2^nBits);

bitsIn = zeros(2^nBits);
for b=2:1:length(bitsIn)
    bitsIn(b) = bitsIn(b-1) + 1;
end

Iout = zeros(2^nBits);
for b=1:1:length(bitsIn)
    for l=0:1:nBits-1
        if mod(fix(bitsIn(b)/(2^l)), 2) > 0
            Iout(b) = Iout(b) + I_in/(2^(nBits-l));
        end
    end
end
Uout = -Iout * Rg;

tiledlayout(2,1);
nexttile
stem(bitsIn, Iout)
title("Iout")
hold on
nexttile
stem(bitsIn, Uout)
title("Uout")
