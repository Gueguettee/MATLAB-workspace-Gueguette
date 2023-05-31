L = 1e-3; C = 1e-5; R = 2;
num = [C 0]; den = [L*C R*C 1];

% step response
step(num, den);

% calcul poles
sys = tf(num, den); pole(sys) % complexes et conjugués

[r p k] = residue(num, den)

