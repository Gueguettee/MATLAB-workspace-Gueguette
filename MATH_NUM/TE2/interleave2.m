function [c] = interleave2(a, b)
%UNTITLED5 Summary of this function goes here
%   Detailed explanation goes here
c = a;
l_b = size(b);
if l_b~=0
    for loop=1:1:l_b
        c = [c b(loop)];
    end
end
end
