clear all;

b = [2 2 17];
a = [1 4 104];

figure;
omega = linspace(-20,20,200);
H = freqs(b,a,omega);
plot(omega,H);

xlabel('Omega/(rad/s)');
ylabel('Frequency/(1/s)');
title('Magnitude and Phase of the frequency response');

figure;
H = tf(b,a);
bode(H);



