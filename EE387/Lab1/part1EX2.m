t = -5:0.01:5;%take t values
y = x(t);%take y values

hs = hilbert(y);

hold on;
plot(t,y),grid; %plot
plot(t,-abs(hs),'r', t,abs(hs),'r');
hold off;
grid;
title ('x(t) = 3e-tcos(4?t)');