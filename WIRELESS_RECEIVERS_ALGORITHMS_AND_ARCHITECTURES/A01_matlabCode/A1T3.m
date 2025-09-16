close all; clear; clc;

SNR_range = -6:2:12;
L = 1e4;

rng(123)

% Initialize
BER_list_Gray = zeros(size(SNR_range));
BER_list_NonGray = zeros(size(SNR_range));
    


for ii = 1:numel(SNR_range) 
    % Convert SNR from dB to linear
    SNRlin = 10^(SNR_range(ii)/10);
    
    % Generate source bitstream
    source = randi([0 1],L,2);
       
    % Map input bitstream using Gray mapping
    b1 = source(:,1);
    b2 = source(:,2);
    mappedGray = -(1-2*b1)/sqrt(2) + -1i*(1-2*b2)/sqrt(2);

    if ii == 1
        mappedGray_record = mappedGray;
    end
      
    % Add AWGN
    mappedGrayNoisy = add_awgn_solution(mappedGray, SNRlin);
        
    % Demap
    demappedGray_b1 = real(mappedGrayNoisy) > 0;
    demappedGray_b2 = imag(mappedGrayNoisy) > 0;
    demappedGray = [demappedGray_b1*1, demappedGray_b2*1];

    if ii == 1
        demappedGray_record = demappedGray;
    end
        
    % BER calculation for Gray mapping
    BER_list_Gray(ii) = mean(source(:) ~= demappedGray(:));
        
    % Map input bitstream using non-Gray mapping
    mappedNonGray = zeros(L,1);
    for k = 1:L
        if b1(k)==0 && b2(k)==1
            mappedNonGray(k) = 1/sqrt(2) + 1i/sqrt(2);
        elseif b1(k)==1 && b2(k)==0
            mappedNonGray(k) = -1/sqrt(2) + 1i/sqrt(2);
        elseif b1(k)==1 && b2(k)==1
            mappedNonGray(k) = -1/sqrt(2) - 1i/sqrt(2);
        else % b1==0 && b2==0
            mappedNonGray(k) = 1/sqrt(2) - 1i/sqrt(2);
        end
    end

    if ii == 1
        mappedNonGray_record = mappedNonGray;
    end
          
          
    % Add AWGN
    mappedNonGrayNoisy = add_awgn_solution(mappedNonGray, SNRlin);
        
    % Demap
    demappedNonGray = zeros(L,2);
    for k = 1:L
        if real(mappedNonGrayNoisy(k)) > 0 && imag(mappedNonGrayNoisy(k)) > 0
            demappedNonGray(k,:) = [0, 1]; % 01
        elseif real(mappedNonGrayNoisy(k)) < 0 && imag(mappedNonGrayNoisy(k)) > 0
            demappedNonGray(k,:) = [1, 0]; % 10
        elseif real(mappedNonGrayNoisy(k)) < 0 && imag(mappedNonGrayNoisy(k)) < 0
            demappedNonGray(k,:) = [1, 1]; % 11
        else % real>0 & imag<0
            demappedNonGray(k,:) = [0, 0]; % 00
        end
    end

    if ii == 1
        demappedNonGray_record = demappedNonGray;
    end
        
    % BER calculation for Gray mapping
    BER_list_NonGray(ii) = mean(source(:) ~= demappedNonGray(:));
end


% uncomment this part for plot
% graphical ouput
figure;
semilogy(SNR_range, BER_list_Gray, 'bx-' ,'LineWidth',3)

hold on
semilogy(SNR_range, BER_list_NonGray, 'r*--','LineWidth',3);

xlabel('SNR (dB)')
ylabel('BER')
legend('Gray Mapping', 'Non-Gray Mapping')
grid on


%% optional: you can write your function for Map/Demap here
% function output = mapGrayfunc(input)
% end
% function output = demapGrayfunc(input)
% end