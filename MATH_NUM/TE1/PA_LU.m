function [P,L,U,x] = PA_LU(A,b)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
[L, U, P]=lu(A);
y = L\(P*b);
x=U\y;
end