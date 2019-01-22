clear all;

sampR = 40000;

Fp = 1000;
Fs = 5000;

Wp = 2*pi*Fp/sampR; %passband edge angular frequency
Ws = 2*pi*Fs/sampR; %stopband edge angular frequency

Rp = 3; %maximum passband attenuation in dB
Rs = 40; %minimum passband attenuation in dB

[N,Wn] = buttord(Wp,Ws,Rp,Rs);

[num,den] = butter(N,Wn,'s');

G = tf(num,den);

bode(G , 'g');