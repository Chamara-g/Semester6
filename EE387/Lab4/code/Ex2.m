clear all;

N = 4; %order

Fp = 1000;

Wp = 2*pi*Fp; %passband edge angular frequency

[num,den] = butter(N,Wp,'s');

G = tf(num,den);

bode(G, 'r');