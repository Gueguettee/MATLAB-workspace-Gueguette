function y = filter_recursive(in, a, b)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
lS = length(in);
lAB = length(a);

y=[];
Z=[];

for l1=1:lS%+lB-1
    if l1 < lAB
        lAB_STOP = l1;
    else
        lAB_STOP = lAB;
    end

    %if l1 > lS
    %    lAB_START = 1 + (l1-lS);
    %else
    %    lAB_START = 1;
    %end
    lAB_START = 1;

    ZN = 0;
    for l2=lAB_STOP:-1:lAB_START
        if l2==1
            ZN = (ZN + in(l1))*a(l2);
        else
            ZN = ZN + (-a(l2)*Z(lAB_STOP-(l2-1)));
        end
    end
    yN = 0;
    for l2=lAB_STOP:-1:lAB_START
        if l2==1
            yN = yN + ZN*b(l2);
        else
            yN = yN + (b(l2)*Z(lAB_STOP-(l2-1)));
        end
    end
    Z = [Z ZN];
    y = [y yN];
end
end
