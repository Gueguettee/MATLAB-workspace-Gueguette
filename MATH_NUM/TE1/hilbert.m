function [H] = hilbert(n)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
H=[];
for i=0:1:n-1
    for j=0:1:n-1
        H(i+1,j+1)=1/(i+j+1);
    end
end
end