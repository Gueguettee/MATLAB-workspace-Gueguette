function [y] = sys1(x)
%sys1
%   systeme discret

y = zeros(size(x));

for n=1:length(y)

    y(n) = x(n);

    if n>1
        y(n) = y(n)-5*x(n-1);

        if n>2
            y(n) = y(n)+2*x(n-2);
        end
    end

end
end