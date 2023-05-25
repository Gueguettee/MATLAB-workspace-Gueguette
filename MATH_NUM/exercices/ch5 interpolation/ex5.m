% Ex 5

dataX = [-2 -1 0 1 2];
dataY = [1 0 1 0 3];

 a = polyfit(dataX,dataY,2);

 e=[];
sommeE = 0;

for loop=1:5
    ee = dataY(loop) - (a(1)*dataX(loop)^2 + a(2)*dataX(loop) + a(3));
    e = [e ee^2];
    sommeE = sommeE + ee^2;
end

sommeE2 = norm(polyval(polyfit(dataX,dataY,2),dataX)-dataY);
