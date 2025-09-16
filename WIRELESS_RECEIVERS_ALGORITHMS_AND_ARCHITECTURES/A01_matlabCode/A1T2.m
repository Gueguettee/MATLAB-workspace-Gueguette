const_blue = [-6-6i,-3i,3i,-3,3,6+6i];
const_red  = [-3-3i,-3+3i,3-3i,3+3i];
% Calculate here:


average_energy_blue = mean(abs(const_blue).^2);
 

average_energy_red = mean(abs(const_red).^2);

%normalized the constellation (we expect value with size(1, 6))
const_blue_norm = const_blue/sqrt(average_energy_blue);
    
const_red_norm = const_red/sqrt(average_energy_red);

%plot normalized constellations
figure
plot(const_blue_norm, 'b.')
hold on
plot(const_red_norm, 'r.')

% 3.2 observations
%
