function [ out ] = sys2( xin )
% system : y[n]-0.9*y[n-1]+0.6*y[n-2]=1.5*x[n]
    x=1.5*xin;
    a1=-0.9;a2=0.6;
    out=zeros(size(x));

    for m=1:length(x)
        if m==1
            out(m)=x(m);
        elseif m==2
            out(m)=x(m)-a1*out(m-1);
        else
            out(m)=x(m)-a1*out(m-1)-a2*out(m-2);
        end
    end

end

