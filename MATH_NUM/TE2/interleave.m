function [c] = interleave(a,b)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
n = length(a);
m = length(b);

k = min(n,m);
c = [];

for i = 1:k
    c = [c a(i) b(i)];
end

if(k == n)
    c = [c b(k+1:end)];
else
    c = [c a(k+1:end)];
end

end