% Start time measurement
tic();

nBits = 1e6;

% Source: Generate random bits
txbits = randi([0 1], nBits, 1);

% Mapping: Bits to symbols ('A' / 'B')
tx = char( 'A' + txbits );   % 0 -> 'A', 1 -> 'B'

% Channel: Apply BSC (flip with prob 0.2)
errors = rand(nBits,1) < 0.2;

% Flip 'A' <-> 'B' using XOR trick
rxbits = xor(txbits, errors);
rx = char( 'A' + rxbits );

% BER: Count errors
err_rate = mean(rxbits ~= txbits);

% Output result
disp(['BER: ' num2str(err_rate*100) '%'])

% Stop time measurement
runTime = toc
