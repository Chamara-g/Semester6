clear all;

N = 4; %order

Rp = 2; %maximum passband attenuation
Fp = 1000;

Wp = 2*pi*Fp; %passband edge angular frequency

[num,den] = cheby1(N,Rp,Wp,'s');
G = tf(num,den);

bode(G);