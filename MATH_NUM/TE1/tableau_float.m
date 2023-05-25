b = 3;
n = 2;
M1 = -1;
M2 = 1;

N = b^n*(b-1)*(M2-M1+1);

s = [];

e=b^-n;

for l1=M1:1:M2
    for l2=1:1:b-1
        for l3=0:1:b^n-1
            s=[s b^l1*(l2+l3*e)];
        end
    end
end
