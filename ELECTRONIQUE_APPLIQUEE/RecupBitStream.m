%% Recup bitstream (.csv)

f = 1e6;
sample_rate = 50e6;

ratio = sample_rate/f;

ref = 1.5;

input = readtable('analog.csv');
bits = table2array(input(:,2));
t = linspace(0,1/50e6*(length(bits)-1),length(bits));

%%

plot(t, bits)

if bits(1) > ref
    temp_ref = 1;
else
    temp_ref = 0;
end
i1 = 0;
for l=1:1:100*ratio
    if temp_ref == 1
        if i1 == 0
            if bits(l) < ref
                i1 = l;
                break
            end
        end
    else
        if i1 == 0
            if bits(l) > ref
                i1 = l;
                break;
            end
        end
    end
end

iStart = i1 - ratio;

bitstream = zeros(size(bits));
len = length(bits);
for l=iStart:ratio:len
    if bits(l) > ref
        bitstream(l) = 1;
    else
        bitstream(l) = 0;
    end
end

plot(bitstream)
writematrix(bitstream', 'output.csv');
