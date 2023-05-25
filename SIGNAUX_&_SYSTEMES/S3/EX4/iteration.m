function [N1, result] = iteration(A, B, C, D, N, F0)
%SYSMASSERESSORT Summary of this function goes here
%   Detailed explanation goes here
N1 = A*N + B*F0;
result = C*N1 + D*F0;
end
