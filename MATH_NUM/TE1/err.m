m = 50;
x = linspace(-1,1,m);
k=0;
y_exact = exp(x);
y = [];

for n = [4 8 16 20]
    for i = 1:m
        y(i) = mon_exp(x(i),n);
    end
    ErrRel = abs(y_exact-y)./abs(y_exact);
    k = k + 1;
    subplot(2,2,k);
    plot(x,ErrRel)
end
