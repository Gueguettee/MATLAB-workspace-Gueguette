function y = filter_no_recursive(in, b)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
lS = length(in);
lB = length(b);

y=[];

for l1=1:lS%+lB-1
    if l1 < lB
        lB_STOP = l1;
    else
        lB_STOP = lB;
    end

    %if l1 > lS
    %    lB_START = 1 + (l1-lS);
    %else
    %    lB_START = 1;
    %end
    lB_START = 1;

    yN = 0;
    for l2=lB_START:lB_STOP
        yN = yN + b(l2)*in(l1-(l2-1));
    end
    y = [y yN];
end
end
