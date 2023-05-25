%%

Te = 1e-3;
t=(-1:Te:1-Te);
%t = linspace(-1,0.999,2000);
f = 2;
N = 10;

x1 = zeros(size(t));
for n=0:1:N-1
    x1 = x1 + 1/(n*2+1)*sin(2*pi*(n*2+1)*f*t);
end

x2 = zeros(size(t));
for n=0:1:N-1
    x2 = x2 + 1/((n*2+1)^2)*cos(2*pi*(n*2+1)*f*t);
end

%plot(t,x1)
%hold on
%plot(t,x2)

X_k = serieF(x1);

k = (0:1:length(t)-1);
f = k*1/(Te*length(t));
tiledlayout(2,1);
nexttile
%plot(f, abs(X_k))
stem(f, abs(X_k))
title("|X1[k]| not shift")
xlabel("f (Hz)")
hold on
nexttile
%plot(f, angle(round(X_k,9)))
stem(f, angle(round(X_k,9)))
title("\phi not shift")
xlabel("f (Hz)")

%%
L = length(X_k);

k = (-(L/2):1:L/2-1);
f = k*1/(Te*L);

X_k_papillon = zeros(size(k));

X_k_papillon(1:L/2) = X_k(L/2+1:L);
X_k_papillon(L/2+1:L) = X_k(1:L/2);

tiledlayout(2,1);
nexttile
stem(f, abs(X_k_papillon))
title("|X1[k]| shift")
xlabel("f (Hz)")
hold on
nexttile
stem(f, angle(round(X_k_papillon,9)))
title("\phi shift")
xlabel("f (Hz)")

%%

L = length(t);

k = (-length(t)/2:1:length(t)/2-1);
f = k*1/(Te*length(t));

X_k_papillon = fftshift(1/L*fft(x1));

tiledlayout(2,1);
nexttile
stem(f, abs(X_k_papillon))
hold on
nexttile
stem(f, angle(round(X_k_papillon, 6)));
