clear all;

%1
figure;
b1 = [1 5]; % Numerator coefficients
a1 = [1 2 3]; % Demoninator coefficients
H1 = tf(b1,a1);
bode(H1);

%2
figure;
b2 = [2 5 12]; % Numerator coefficients
a2 = [1 2 10]; % Demoninator coefficients
H2 = tf(b2,a2);
bode(H2);

%3
figure;
b3 = [2 5 12]; % Numerator coefficients
a3 = [1 4 14 20]; % Demoninator coefficients
H3 = tf(b3,a3);
bode(H3);