function [y] = sys3(x)
%sys3
%   systeme discret

y = zeros(size(x));

u = cumsum(delta(x));

for n=1:length(y)

    y(n) = square(x(n)/(2*pi))*u(n);

end
end