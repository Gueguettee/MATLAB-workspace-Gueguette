function [X_k] = serieF(x_n)
N = length(x_n);
X_k = zeros(1, N);

for k=0:1:N-1
    for n=0:1:N-1
        X_k(k+1) = X_k(k+1) + x_n(n+1)*exp(-1i*k*2*pi/N*n);
    end
end
X_k = 1/N*X_k;
end






