function [bit_out, noisy_signal] = awgn_channel(signal, image_size, SNR)
    
    % Convert SNR from dB to linear
    SNRlin = 10^(SNR/10);
    
    % Add AWGN
    sigma2 = mean(abs(signal).^2)/SNRlin;
    sigmaReal = sqrt(sigma2/2);
    sigmaImag = sqrt(sigma2/2);
    noise = sigmaReal * randn(size(signal));
    complex_noise = sigmaImag * randn(size(signal)) * 1i;
    noisy_signal = signal + noise + complex_noise;
    % noisy_signal = awgn(signal, SNR, 'measured');
    
    % Demap
    bit_out = demapper(noisy_signal);
    
    % Decode and shown image
    image = image_decoder(bit_out, image_size);
    figure
    imshow(image, [])
end
