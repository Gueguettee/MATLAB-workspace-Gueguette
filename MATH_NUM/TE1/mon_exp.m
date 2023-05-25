function y = mon_exp(x,n)

terme = 1; y = 1;

for k = 1:n
    terme = terme * x / k;
    y = y + terme;
end

end
